import { NextRequest, NextResponse } from 'next/server';
import { supabase } from '@/lib/supabase-server';

const API_KEY = process.env.AI_API_KEY;
const BASE_URL = process.env.AI_BASE_URL || 'https://api.groq.com/openai/v1';
const MODEL = process.env.AI_MODEL || 'groq/compound-mini';
const MAX_TOKENS = 700;

const SISTEMA = `Eres "Asistente FEI", el asistente integrado en la web de Concursos de Doma Clasica FEI.

SOLO puedes responder sobre DOS temas:
1) Los datos y funciones de esta web: concursos, jornadas, pruebas, horarios, categorias, reprises, jueces, clasificaciones, notas y estadisticas.
2) Doma clasica y reglamento FEI: niveles y reprises oficiales (Preliminar, Elemental, Medium, Prix St. Georges, Intermediaire I y II, Gran Premio), movimientos (piaffe, passage, piruetas, cambios de pie, apoyos, medias vueltas, circulos...), criterios de juzgamiento, escala de puntuacion 0-10, coeficientes, escala de adiestramiento (ritmo, soltura, contacto, impulsion, rectitud, reunido/coleccion) y normas de concurso.

Para cualquier otro tema NO respondas: di amablemente "Solo puedo ayudarte con la web de concursos de doma y con el reglamento de doma clasica FEI."

Cuando la pregunta sea sobre datos de la web, usa SIEMPRE el CONTEXTO DE LA WEB que recibes. Si el dato no aparece en el contexto, responde "No tengo ese dato en la web ahora mismo." y no lo inventes.

Responde en espanol, con naturalidad y brevedad (maximo unas 120 palabras). Usa listas sencillas con guiones si ayuda. De los jueces solo hables por su letra (C, B, M...), nunca por su nombre; es una web publica y los datos deben mantenerse anonimos.`;

function hoyISO(): string {
  return new Date().toISOString().slice(0, 10);
}

type PruebaConFecha = {
  id: string;
  nombre: string;
  categoria: string | null;
  fecha: string;
  hora_inicio: string;
  reprise_nombre: string | null;
  concurso_nombre: string | null;
  es_equipos: boolean;
};

async function construirContexto() {
  const { data: concursos } = await supabase
    .from('concursos')
    .select('id, nombre, ubicacion, fecha_inicio')
    .order('fecha_inicio', { ascending: false })
    .limit(8);

  let pruebas: PruebaConFecha[] = [];
  let podios: any[] = [];
  let stats = {
    total_concursos: concursos?.length || 0,
    total_pruebas: 0,
    total_binomios_puntuados: 0,
    mejor_media_temporada: null as null | { prueba: string; media: number; binomio: string },
  };

  if (!concursos || concursos.length === 0) {
    return { concursos: [], pruebas: [], resultados: podios, stats };
  }

  const concursoIds = concursos.map((c) => c.id);

  const { data: pruebasData } = await supabase
    .from('pruebas')
    .select(
      'id, nombre, categoria, fecha, hora_inicio, reprise:reprise_id(nombre), concurso:concurso_id(nombre), tipo_prueba:tipo_prueba_id(codigo)'
    )
    .in('concurso_id', concursoIds)
    .order('fecha', { ascending: true })
    .order('orden', { ascending: true });

  pruebas = ((pruebasData as any[]) || []).map((p: any) => ({
    id: p.id,
    nombre: p.nombre,
    categoria: p.categoria || null,
    fecha: p.fecha,
    hora_inicio: p.hora_inicio ? p.hora_inicio.substring(0, 5) : '',
    reprise_nombre: p.reprise?.nombre || null,
    concurso_nombre: p.concurso?.nombre || null,
    es_equipos: p.tipo_prueba?.codigo === 'EQU',
  }));

  stats.total_pruebas = pruebas.length;

  const hoy = hoyISO();
  const finalizadas = pruebas.filter((p) => p.fecha < hoy);

  if (finalizadas.length > 0) {
    const pruebaIds = finalizadas.map((p) => p.id);

    const { data: participaciones } = await supabase
      .from('participaciones')
      .select(
        'id, prueba_id, orden_salida, inscripcion:inscripcion_id(dorsal, binomio:binomio_id(nombre_jinete, nombre_caballo))'
      )
      .in('prueba_id', pruebaIds);

    const participacionIds = (participaciones || []).map((p: any) => p.id);

    // La API de Supabase limita cada consulta a 1000 filas: paginamos para no
    // perder puntuaciones al calcular podios y estadisticas.
    const puntos: any[] = [];
    if (participacionIds.length > 0) {
      const TAM = 1000;
      for (let desde = 0; ; desde += TAM) {
        const { data: puntuaciones, error: errP } = await supabase
          .from('puntuaciones')
          .select(
            'nota, participacion_id, prueba_juez:prueba_juez_id(id, letra), ejercicio_reprise:ejercicio_reprise_id(coeficiente)'
          )
          .in('participacion_id', participacionIds)
          .range(desde, desde + TAM - 1);
        if (errP) break;
        if (!puntuaciones || puntuaciones.length === 0) break;
        puntos.push(...(puntuaciones as any[]));
        if (puntuaciones.length < TAM) break;
      }
    }

    const partes = (participaciones || []) as any[];

    for (const prueba of finalizadas) {
      const parteIds = new Set(
        partes.filter((p) => p.prueba_id === prueba.id).map((p) => p.id)
      );
      const jul: Record<string, { suma: number; sumaCoef: number }> = {};

      for (const p of puntos) {
        if (!parteIds.has(p.participacion_id)) continue;
        const letra = p.prueba_juez?.letra || '?';
        const coef = p.ejercicio_reprise?.coeficiente || 1;
        const key = `${p.participacion_id}_${letra}`;
        if (!jul[key]) jul[key] = { suma: 0, sumaCoef: 0 };
        jul[key].suma += p.nota * coef;
        jul[key].sumaCoef += coef;
      }

      const medias: { part: any; media: number }[] = [];
      for (const part of partes) {
        if (!parteIds.has(part.id)) continue;
        let acc = 0;
        let n = 0;
        for (const key of Object.keys(jul)) {
          if (!key.startsWith(`${part.id}_`)) continue;
          const d = jul[key];
          if (d.sumaCoef <= 0) continue;
          acc += (d.suma * 100) / (d.sumaCoef * 10);
          n += 1;
        }
        if (n > 0) medias.push({ part, media: Math.round((acc / n) * 100) / 100 });
      }

      medias.sort((a, b) => b.media - a.media);
      const top = medias.slice(0, 3);

      if (top.length > 0) {
        const binomio = top[0].part.inscripcion?.binomio;
        const mediaMejor = top[0].media;
        if (!stats.mejor_media_temporada || mediaMejor > stats.mejor_media_temporada.media) {
          stats.mejor_media_temporada = {
            prueba: prueba.nombre,
            media: mediaMejor,
            binomio: binomio?.nombre_jinete || '-',
          };
        }
        stats.total_binomios_puntuados += medias.length;
        podios.push({
          prueba: prueba.nombre,
          fecha: prueba.fecha,
          concurso: prueba.concurso_nombre,
          podio: top.map((t, i) => {
            const insc = t.part.inscripcion;
            return {
              posicion: i + 1,
              dorsal: insc?.dorsal || 0,
              jinete: insc?.binomio?.nombre_jinete || '-',
              caballo: insc?.binomio?.nombre_caballo || '-',
              media: t.media,
            };
          }),
        });
      }
    }
  }

  return { concursos, pruebas, resultados: podios, stats };
}

function formatoContexto(tele: { concursos: any[]; pruebas: PruebaConFecha[]; resultados: any[]; stats: any }): string {
  const hoy = hoyISO();
  const partes: string[] = [];

  partes.push(
    '[CONCURSOS] ' +
      (tele.concursos.length > 0
        ? tele.concursos.map((c) => `${c.nombre} (${c.ubicacion || 'sin ubicacion'}, inicia ${c.fecha_inicio})`).join(' | ')
        : 'No hay concursos cargados.')
  );

  const programadas = tele.pruebas.filter((p) => p.fecha >= hoy).slice(0, 20);
  partes.push(
    '[PRUEBAS Y HORARIOS] ' +
      (programadas.length > 0
        ? programadas
            .map((p) => `${p.nombre}${p.concurso_nombre ? ' - ' + p.concurso_nombre : ''}, el ${p.fecha} a las ${p.hora_inicio}${p.categoria ? ', ' + p.categoria : ''}${p.reprise_nombre ? ', ' + p.reprise_nombre : ''}`)
            .join(' | ')
        : 'No hay pruebas programadas en la web.')
  );

  partes.push(
    '[RESULTADOS] ' +
      (tele.resultados.length > 0
        ? tele.resultados
            .map((r) => `${r.prueba} (${r.concurso || 'sin concurso'}, ${r.fecha}): 1º ${r.podio[0].dorsal} ${r.podio[0].jinete}/${r.podio[0].caballo} ${r.podio[0].media}%` + (r.podio[1] ? `; 2º ${r.podio[1].dorsal} ${r.podio[1].jinete} ${r.podio[1].media}%` : '') + (r.podio[2] ? `; 3º ${r.podio[2].dorsal} ${r.podio[2].jinete} ${r.podio[2].media}%` : ''))
            .join(' | ')
        : 'No hay resultados cargados todavia.')
  );

  partes.push(
    `[ESTADISTICAS GLOBALES] total_concursos=${tele.stats.total_concursos}, total_pruebas=${tele.stats.total_pruebas}, total_binomios_puntuados=${tele.stats.total_binomios_puntuados}` +
      (tele.stats.mejor_media_temporada
        ? `, mejor_media_temporada=${tele.stats.mejor_media_temporada.binomio} con ${tele.stats.mejor_media_temporada.media}% (${tele.stats.mejor_media_temporada.prueba})`
        : '')
  );

  return partes.join('\n\n');
}

export async function POST(req: NextRequest) {
  let cuerpo: { mensajes?: { role: 'user' | 'assistant'; content: string }[] } = {};
  try {
    cuerpo = await req.json();
  } catch {
    cuerpo = {};
  }

  const mensajes = (cuerpo.mensajes || []).slice(-12);
  const ultimoUsuario = mensajes.filter((m) => m.role === 'user').pop();

  if (!ultimoUsuario || !ultimoUsuario.content.trim()) {
    return NextResponse.json(
      { configurado: true, respuesta: 'Escribeme una pregunta sobre la web o sobre doma clasica FEI.' },
      { status: 400 }
    );
  }

  if (!API_KEY) {
    return NextResponse.json({
      configurado: false,
      respuesta:
        'El asistente no esta configurado. El administrador debe anadir la variable de entorno AI_API_KEY (servicio Groq gratis) y desplegar de nuevo.',
    });
  }

  let contexto = '';
  try {
    const datos = await construirContexto();
    contexto = formatoContexto(datos);
  } catch {
    contexto = 'No se pudo acceder a los datos de la web en este momento.';
  }

  const historial: { role: 'system' | 'user' | 'assistant'; content: string }[] = [
    { role: 'system', content: SISTEMA },
    { role: 'system', content: 'CONTEXTO DE LA WEB (puede estar vacio si no hay datos):\n' + contexto },
    ...mensajes.map((m) => ({ role: m.role, content: m.content })),
  ];

  try {
    const respuesta = await fetch(`${BASE_URL}/chat/completions`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${API_KEY}`,
      },
      body: JSON.stringify({
        model: MODEL,
        messages: historial,
        temperature: 0.3,
        max_tokens: MAX_TOKENS,
      }),
    });

    if (!respuesta.ok) {
      const detalle = await respuesta.text();
      console.error('Asistente FEI error:', respuesta.status, detalle.slice(0, 500));
      return NextResponse.json({
        configurado: true,
        respuesta: 'Ha fallado la conexion con el modelo de IA. Intentalo de nuevo en unos segundos.',
      });
    }

    const datos = await respuesta.json();
    const texto = datos.choices?.[0]?.message?.content?.trim();

    if (!texto) {
      return NextResponse.json({ configurado: true, respuesta: 'El modelo no devolvio respuesta.' });
    }

    return NextResponse.json({ configurado: true, respuesta: texto });
  } catch (err) {
    console.error('Asistente FEI fallo:', err);
    return NextResponse.json({
      configurado: true,
      respuesta: 'No he podido procesar la pregunta ahora mismo. Comprueba tu conexion e intenta de nuevo.',
    });
  }
}
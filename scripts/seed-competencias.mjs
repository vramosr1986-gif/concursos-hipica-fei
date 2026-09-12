// Script para completar el seed con jornadas, reprises, competencias y puntuaciones.
// Usa los concursos/binomios/jueces YA existentes en la base (no los duplica).
// Uso: node scripts/seed-competencias.mjs
import { createClient } from '@supabase/supabase-js';
import { readFileSync } from 'fs';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';

const __dirname = dirname(fileURLToPath(import.meta.url));

function loadEnvLocal() {
  const envPath = join(__dirname, '..', '.env.local');
  const content = readFileSync(envPath, 'utf-8');
  const env = {};
  for (const line of content.split('\n')) {
    const trimmed = line.trim();
    if (!trimmed || trimmed.startsWith('#')) continue;
    const idx = trimmed.indexOf('=');
    if (idx === -1) continue;
    env[trimmed.slice(0, idx).trim()] = trimmed.slice(idx + 1).trim();
  }
  return env;
}

const env = loadEnvLocal();
const supabase = createClient(env.NEXT_PUBLIC_SUPABASE_URL, env.SUPABASE_SERVICE_ROLE_KEY);

async function main() {
  console.log('Buscando concursos, binomios y jueces existentes...');
  const { data: concursos } = await supabase.from('concursos').select('*').order('fecha_inicio');
  const { data: binomios } = await supabase.from('binomios').select('*').order('dorsal');
  const { data: jueces } = await supabase.from('jueces').select('*');

  if (!concursos?.length || !binomios?.length || !jueces?.length) {
    console.error('Faltan concursos/binomios/jueces. Ejecuta primero node scripts/seed.mjs');
    process.exit(1);
  }

  const concurso1 = concursos[0];
  const concurso2 = concursos[1] || concursos[0];
  const binomiosC1 = binomios.filter((b) => b.concurso_id === concurso1.id);
  const binomiosC2 = binomios.filter((b) => b.concurso_id === concurso2.id);
  const juecesC1 = jueces.filter((j) => j.concurso_id === concurso1.id);

  console.log('Insertando reprises de muestra...');
  const { data: reprisesData, error: reprisesError } = await supabase
    .from('reprises')
    .upsert(
      [
        { numero: 'Prel-1', nombre: 'Preliminar 1', fei_numero: 'PREL1', desviacion: 1.2, multiplicador: 1.0, nivel: 'preliminar' },
        { numero: 'Elem-1', nombre: 'Elemental 1', fei_numero: 'ELEM1', desviacion: 1.3, multiplicador: 1.1, nivel: 'elemental' },
      ],
      { onConflict: 'fei_numero' }
    )
    .select();

  if (reprisesError) {
    console.error('Error insertando reprises:', reprisesError.message);
    process.exit(1);
  }
  const [repriseA, repriseB] = reprisesData;
  console.log(`✔ ${reprisesData.length} reprises listas`);

  console.log('Insertando jornadas de muestra...');
  const { data: jornadasData, error: jornadasError } = await supabase
    .from('jornadas')
    .upsert(
      [
        { concurso_id: concurso1.id, fecha: concurso1.fecha_inicio, numero: 1, pista: 'Pista A', hora_inicio: '09:00' },
        { concurso_id: concurso2.id, fecha: concurso2.fecha_inicio, numero: 1, pista: 'Pista Única', hora_inicio: '10:00' },
      ],
      { onConflict: 'concurso_id,numero' }
    )
    .select();

  if (jornadasError) {
    console.error('Error insertando jornadas:', jornadasError.message);
    process.exit(1);
  }
  const [jornada1, jornada2] = jornadasData;
  console.log(`✔ ${jornadasData.length} jornadas listas`);

  console.log('Asignando reprises a jornadas...');
  const { data: jrData, error: jrError } = await supabase
    .from('jornada_reprises')
    .upsert(
      [
        { jornada_id: jornada1.id, reprise_id: repriseA.id, orden: 1, hora_salida: '09:00', pista: 'Pista A' },
        { jornada_id: jornada2.id, reprise_id: repriseB.id, orden: 1, hora_salida: '10:00', pista: 'Pista Única' },
      ],
      { onConflict: 'jornada_id,reprise_id' }
    )
    .select();

  if (jrError) {
    console.error('Error insertando jornada_reprises:', jrError.message);
    process.exit(1);
  }
  const [jr1, jr2] = jrData;
  console.log(`✔ ${jrData.length} asignaciones jornada-reprise listas`);

  console.log('Insertando competencias de muestra...');
  const competenciasAInsertar = [];
  if (binomiosC1[0]) {
    competenciasAInsertar.push({ jornada_reprise_id: jr1.id, binomio_id: binomiosC1[0].id, orden_salida: 1, hora_salida: '09:00', estado: 'completado' });
  }
  if (binomiosC1[1]) {
    competenciasAInsertar.push({ jornada_reprise_id: jr1.id, binomio_id: binomiosC1[1].id, orden_salida: 2, hora_salida: '09:10', estado: 'pendiente' });
  }
  if (binomiosC2[0]) {
    competenciasAInsertar.push({ jornada_reprise_id: jr2.id, binomio_id: binomiosC2[0].id, orden_salida: 1, hora_salida: '10:00', estado: 'pendiente' });
  }

  const { data: competenciasData, error: competenciasError } = await supabase
    .from('competencias')
    .upsert(competenciasAInsertar, { onConflict: 'jornada_reprise_id,binomio_id' })
    .select();

  if (competenciasError) {
    console.error('Error insertando competencias:', competenciasError.message);
    process.exit(1);
  }
  console.log(`✔ ${competenciasData.length} competencias listas`);

  const competenciaCompletada = competenciasData.find((c) => c.estado === 'completado');

  if (competenciaCompletada && juecesC1.length) {
    console.log('Insertando puntuaciones de muestra...');
    const puntuacionesAInsertar = juecesC1.slice(0, 3).map((juez, i) => ({
      competencia_id: competenciaCompletada.id,
      juez_id: juez.id,
      letra_juez: juez.letra_oficial,
      notas: [],
      puntuacion_final: [68.5, 70.2, 66.8][i] ?? 67,
    }));

    const { data: puntuacionesData, error: puntuacionesError } = await supabase
      .from('puntuaciones')
      .upsert(puntuacionesAInsertar, { onConflict: 'competencia_id,juez_id' })
      .select();

    if (puntuacionesError) {
      console.error('Error insertando puntuaciones:', puntuacionesError.message);
      process.exit(1);
    }
    console.log(`✔ ${puntuacionesData.length} puntuaciones listas`);
  }

  console.log('Listo. Ya puedes ver notas en /resultados.');
}

main();

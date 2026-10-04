'use client';

import { useEffect, useState } from 'react';
import { useRouter } from 'next/navigation';
import Link from 'next/link';
import { SelectorFederacion } from '@/components/BanderaFH';
import { fetchConSesion } from '@/lib/juez-actual';
import { ComprobarRfhe } from '@/components/ComprobarRfhe';
import { supabase } from '@/lib/supabase';
import { inscribirEnConcurso } from '@/lib/inscribir';
import { FechasConPermiso, FechasNacimiento, fechasParaGuardar } from '@/components/FechasConPermiso';

export default function NuevoBinomioPage() {
  const router = useRouter();

  const [fechas, setFechas] = useState<FechasNacimiento>({ consentimiento: false, fecha_nacimiento_jinete: '', anio_nacimiento_caballo: '' });
  const [formData, setFormData] = useState({
    nombre_jinete: '',
    nombre_caballo: '',
    ldn_jinete: '',
    lac_caballo: '',
    fh_jinete: '',
    fh_caballo: '',
  });

  const [error, setError] = useState('');
  const [guardando, setGuardando] = useState(false);
  // Inscripción opcional en un concurso al dar de alta el binomio.
  type ConcursoOpcion = { id: string; nombre: string; fecha_inicio: string };
  type PruebaOpcion = { id: string; nombre: string; fecha: string; categoria: string | null; categoria_edad_id: string | null };
  const [concursos, setConcursos] = useState<ConcursoOpcion[]>([]);
  const [concursoId, setConcursoId] = useState('');
  const [pruebasConcurso, setPruebasConcurso] = useState<PruebaOpcion[]>([]);
  const [pruebasElegidas, setPruebasElegidas] = useState<Set<string>>(new Set());
  const [resultado, setResultado] = useState<{ binomioId: string; texto: string } | null>(null);

  useEffect(() => {
    supabase.from('concursos').select('id, nombre, fecha_inicio').order('fecha_inicio', { ascending: false })
      .then(({ data }) => setConcursos(data || []));
  }, []);

  useEffect(() => {
    setPruebasElegidas(new Set());
    if (!concursoId) {
      setPruebasConcurso([]);
      return;
    }
    supabase.from('pruebas').select('id, nombre, fecha, categoria, categoria_edad_id')
      .eq('concurso_id', concursoId).order('fecha').order('hora_inicio')
      .then(({ data }) => setPruebasConcurso(data || []));
  }, [concursoId]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError('');

    if (!formData.nombre_jinete.trim() || !formData.nombre_caballo.trim()) {
      setError('Jinete y caballo son obligatorios');
      return;
    }

    setGuardando(true);
    try {
      const res = await fetchConSesion('/api/binomios', {
        method: 'POST',
        body: JSON.stringify({
          nombre_jinete: formData.nombre_jinete.trim(),
          nombre_caballo: formData.nombre_caballo.trim(),
          ldn_jinete: formData.ldn_jinete.trim() || null,
          lac_caballo: formData.lac_caballo.trim() || null,
          fh_jinete: formData.fh_jinete || null,
          fh_caballo: formData.fh_caballo || null,
          ...fechasParaGuardar(fechas, null),
        }),
      });

      if (!res.ok) {
        const body = await res.json().catch(() => ({}));
        setError(body.error || 'No se pudo guardar el binomio');
        return;
      }

      const guardado = await res.json().catch(() => ({}));
      const mensajes: string[] = [];
      if (guardado.ya_existia) {
        // No se duplica: se avisa de que ya estaba y de qué datos se han completado.
        const nombres: Record<string, string> = {
          ldn_jinete: 'LDN', lac_caballo: 'LAC', fh_jinete: 'federación del jinete', fh_caballo: 'federación del caballo',
          fecha_nacimiento_jinete: 'fecha de nacimiento del jinete', anio_nacimiento_caballo: 'año del caballo',
          consentimiento_datos_at: 'permiso de datos',
        };
        const completados = (guardado.completados || []).map((c: string) => nombres[c]).filter(Boolean);
        mensajes.push(completados.length > 0
          ? `Este jinete con este caballo ya estaba registrado. Se han completado: ${completados.join(', ')}.`
          : 'Este jinete con este caballo ya estaba registrado con todos sus datos.');
      } else {
        mensajes.push('Jinete y caballo dados de alta.');
      }

      if (concursoId && guardado.id) {
        const concurso = concursos.find((c) => c.id === concursoId);
        const pruebas = pruebasConcurso.filter((p) => pruebasElegidas.has(p.id));
        try {
          const insc = await inscribirEnConcurso(concursoId, guardado.id, pruebas);
          mensajes.push(insc.yaEstaba
            ? `Ya estaba inscrito en «${concurso?.nombre}» (dorsal ${insc.dorsal}).${pruebas.length ? ' Se ha añadido a las pruebas marcadas.' : ''}`
            : `Inscrito en «${concurso?.nombre}» con el dorsal ${insc.dorsal}${pruebas.length ? ` y en ${pruebas.length} prueba${pruebas.length > 1 ? 's' : ''}` : ''}.`);
        } catch (err) {
          setError(`Se ha guardado el binomio, pero no se pudo inscribir en el concurso: ${err instanceof Error ? err.message : ''}`);
        }
      }

      if (guardado.ya_existia || concursoId) {
        setResultado({ binomioId: guardado.id, texto: mensajes.join(' ') });
        return;
      }

      router.push('/admin/binomios');
      router.refresh();
    } catch (err: unknown) {
      setError(err instanceof Error ? err.message : 'Error al guardar el binomio');
    } finally {
      setGuardando(false);
    }
  };

  return (
    <div className="container max-w-2xl py-8">
      <Link href="/admin/binomios" className="text-primary mb-4 inline-block">
        Volver al listado
      </Link>

      <h1 className="text-3xl font-bold mb-6">Nuevo Binomio</h1>

      <div className="card p-6">
        {error && (
          <div className="mb-4 p-3 bg-danger text-white rounded text-sm">{error}</div>
        )}
        {resultado && (
          <div role="status" className="mb-4 rounded border border-green-200 bg-green-50 p-3 text-sm text-green-900">
            <p>{resultado.texto}</p>
            <div className="mt-2 flex flex-wrap gap-2">
              {concursoId && <Link href={`/admin/concursos/${concursoId}`} className="btn btn-primary btn-sm">Ir al concurso</Link>}
              <Link href="/admin/binomios" className="btn btn-outline btn-sm">Volver al listado</Link>
            </div>
          </div>
        )}

        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <label className="block text-sm font-bold mb-2">
              Nombre del jinete *
            </label>
            <input
              type="text"
              required
              placeholder="Ej. Juan Perez"
              value={formData.nombre_jinete}
              onChange={(e) =>
                setFormData({ ...formData, nombre_jinete: e.target.value })
              }
              className="input w-full"
            />
          </div>

          <div>
            <label className="block text-sm font-bold mb-2">
              Nombre del caballo *
            </label>
            <input
              type="text"
              required
              placeholder="Ej. Babieca"
              value={formData.nombre_caballo}
              onChange={(e) =>
                setFormData({ ...formData, nombre_caballo: e.target.value })
              }
              className="input w-full"
            />
          </div>

          <div className="grid grid-cols-1 gap-4 sm:grid-cols-2">
            <div>
              <div className="mb-2 flex items-center justify-between gap-2">
                <label className="text-sm font-bold" htmlFor="ldn_jinete">
                  LDN del jinete
                </label>
              </div>
              <input id="ldn_jinete" type="text" placeholder="Ej. 283953" value={formData.ldn_jinete}
                onChange={(e) => setFormData({ ...formData, ldn_jinete: e.target.value })}
                className="input w-full" />
              <ComprobarRfhe tipo="jinete" nombre={formData.nombre_jinete} codigo={formData.ldn_jinete}
                onUsar={(ldn_jinete, nombre_jinete) => setFormData((f) => ({ ...f, ldn_jinete, nombre_jinete }))} />
            </div>

            <div>
              <div className="mb-2 flex items-center justify-between gap-2">
                <label className="text-sm font-bold" htmlFor="lac_caballo">
                  LAC del caballo
                </label>
              </div>
              <input id="lac_caballo" type="text" placeholder="Ej. 080640" value={formData.lac_caballo}
                onChange={(e) => setFormData({ ...formData, lac_caballo: e.target.value })}
                className="input w-full" />
              <ComprobarRfhe tipo="caballo" nombre={formData.nombre_caballo} codigo={formData.lac_caballo}
                onUsar={(lac_caballo, nombre_caballo) => setFormData((f) => ({ ...f, lac_caballo, nombre_caballo }))} />
            </div>
          </div>

          <div className="grid grid-cols-1 gap-4 sm:grid-cols-2">
            <SelectorFederacion id="fh_jinete" etiqueta="Federación (comunidad) del jinete" valor={formData.fh_jinete}
              onChange={(fh_jinete) => setFormData({ ...formData, fh_jinete })} />
            <SelectorFederacion id="fh_caballo" etiqueta="Federación (comunidad) del caballo" valor={formData.fh_caballo}
              onChange={(fh_caballo) => setFormData({ ...formData, fh_caballo })} />
          </div>

          <fieldset className="rounded border border-[#e4dfd4] p-4">
            <legend className="px-1 text-sm font-bold">Inscribir en un concurso (opcional)</legend>
            <label htmlFor="inscribir-concurso" className="mb-1 block text-sm">Concurso</label>
            <select id="inscribir-concurso" value={concursoId} onChange={(e) => setConcursoId(e.target.value)} className="input w-full">
              <option value="">-- No inscribir ahora --</option>
              {concursos.map((c) => (
                <option key={c.id} value={c.id}>{c.nombre} ({c.fecha_inicio.split('-').reverse().join('/')})</option>
              ))}
            </select>
            {concursoId && (
              pruebasConcurso.length === 0 ? (
                <p className="mt-2 text-xs text-amber-700">Este concurso todavía no tiene pruebas: se inscribirá en el concurso y luego podrás meterlo en sus pruebas.</p>
              ) : (
                <div className="mt-3">
                  <p className="mb-1 text-sm">¿En qué pruebas participa?</p>
                  <div className="flex flex-wrap gap-x-5 gap-y-2">
                    {pruebasConcurso.map((p) => (
                      <label key={p.id} className="flex items-center gap-2 text-sm">
                        <input
                          type="checkbox"
                          checked={pruebasElegidas.has(p.id)}
                          onChange={() => setPruebasElegidas((actual) => {
                            const n = new Set(actual);
                            if (n.has(p.id)) n.delete(p.id); else n.add(p.id);
                            return n;
                          })}
                        />
                        {p.nombre}
                      </label>
                    ))}
                  </div>
                </div>
              )
            )}
          </fieldset>

          <FechasConPermiso valor={fechas} onChange={setFechas} />

          <div className="rounded border border-gray-200 bg-gray-50 p-3 text-sm text-gray-700">
            Los datos se utilizarán para gestionar el binomio y sus inscripciones.
            Consulta la{' '}
            <Link href="/privacidad" className="text-primary underline">
              política de privacidad
            </Link>
            .
          </div>

          <div className="flex justify-end gap-3 pt-6">
            <Link href="/admin/binomios" className="btn btn-outline">
              Cancelar
            </Link>

            <button
              type="submit"
              disabled={guardando}
              className="btn btn-primary disabled:opacity-50"
            >
              {guardando ? 'Guardando...' : 'Guardar Binomio'}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}
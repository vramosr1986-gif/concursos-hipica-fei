'use client';

import { ESPECIALIDADES } from '@/lib/constants';

/** Datos de un concurso, los mismos que publica RFHE en su calendario y ficha. */
export type DatosConcurso = {
  nombre: string;
  tipo: string;
  disciplina: string;
  fecha_inicio: string;
  fecha_fin: string;
  provincia: string;
  ubicacion: string;
  organizador: string;
  federacion: string;
};

export const CAMPOS_CONCURSO = [
  'nombre', 'tipo', 'disciplina', 'fecha_inicio', 'fecha_fin', 'provincia', 'ubicacion', 'organizador', 'federacion',
] as const;

export function concursoVacio(): DatosConcurso {
  return {
    nombre: '', tipo: '', disciplina: '', fecha_inicio: '', fecha_fin: '',
    provincia: '', ubicacion: '', organizador: '', federacion: '',
  };
}

/** Normaliza para guardar: recorta textos y convierte vacíos en null. */
export function datosParaGuardar(datos: DatosConcurso) {
  const limpio = (valor: string) => valor.trim() || null;
  return {
    nombre: datos.nombre.trim(),
    fecha_inicio: datos.fecha_inicio,
    fecha_fin: datos.fecha_fin,
    tipo: limpio(datos.tipo),
    disciplina: limpio(datos.disciplina),
    provincia: limpio(datos.provincia),
    ubicacion: limpio(datos.ubicacion),
    organizador: limpio(datos.organizador),
    federacion: limpio(datos.federacion),
  };
}

export function validarConcurso(datos: DatosConcurso): string | null {
  if (!datos.nombre.trim()) return 'El nombre es obligatorio';
  if (!datos.fecha_inicio || !datos.fecha_fin) return 'Las fechas de inicio y fin son obligatorias';
  if (datos.fecha_fin < datos.fecha_inicio) return 'La fecha de fin no puede ser anterior a la de inicio';
  return null;
}

export function ConcursoCampos({ datos, onChange }: {
  datos: DatosConcurso;
  onChange: (datos: DatosConcurso) => void;
}) {
  const campo = (nombre: keyof DatosConcurso) => ({
    id: `concurso-${nombre}`,
    name: nombre,
    value: datos[nombre],
    onChange: (e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>) => onChange({ ...datos, [nombre]: e.target.value }),
    className: 'input w-full',
  });
  const etiqueta = (nombre: keyof DatosConcurso, texto: string) => (
    <label htmlFor={`concurso-${nombre}`} className="mb-1.5 block text-sm font-bold">{texto}</label>
  );
  const disciplinas = datos.disciplina && !ESPECIALIDADES.includes(datos.disciplina)
    ? [datos.disciplina, ...ESPECIALIDADES]
    : ESPECIALIDADES;

  return (
    <div className="grid gap-4 md:grid-cols-2">
      <div className="md:col-span-2">
        {etiqueta('nombre', 'Nombre del concurso *')}
        <input type="text" required {...campo('nombre')} />
      </div>
      <div>
        {etiqueta('tipo', 'Tipo')}
        <input type="text" placeholder="Ej. CDN***, CDI*" {...campo('tipo')} />
      </div>
      <div>
        {etiqueta('disciplina', 'Disciplina')}
        <select {...campo('disciplina')}>
          <option value="">-- Seleccionar disciplina --</option>
          {disciplinas.map((d) => <option key={d} value={d}>{d}</option>)}
        </select>
      </div>
      <div>
        {etiqueta('fecha_inicio', 'Fecha de inicio *')}
        <input type="date" required {...campo('fecha_inicio')} />
      </div>
      <div>
        {etiqueta('fecha_fin', 'Fecha de fin *')}
        <input type="date" required min={datos.fecha_inicio || undefined} {...campo('fecha_fin')} />
      </div>
      <div>
        {etiqueta('provincia', 'Provincia')}
        <input type="text" {...campo('provincia')} />
      </div>
      <div>
        {etiqueta('ubicacion', 'Sede / localidad')}
        <input type="text" placeholder="Ej. Las Cadenas" {...campo('ubicacion')} />
      </div>
      <div>
        {etiqueta('organizador', 'Organizador')}
        <input type="text" {...campo('organizador')} />
      </div>
      <div>
        {etiqueta('federacion', 'Federación')}
        <input type="text" placeholder="Ej. Federación Hípica de Madrid" {...campo('federacion')} />
      </div>
    </div>
  );
}

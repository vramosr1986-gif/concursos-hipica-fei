'use client';

import Link from 'next/link';

export type FechasNacimiento = {
  consentimiento: boolean;
  fecha_nacimiento_jinete: string;
  anio_nacimiento_caballo: string;
};

/**
 * Datos que se envían al guardar: sin permiso no se guarda ninguna fecha.
 * `consentimientoPrevio` conserva la fecha del permiso si ya existía.
 */
export function fechasParaGuardar(f: FechasNacimiento, consentimientoPrevio: string | null) {
  if (!f.consentimiento) {
    return { consentimiento_datos_at: null, fecha_nacimiento_jinete: null, anio_nacimiento_caballo: null };
  }
  return {
    consentimiento_datos_at: consentimientoPrevio || new Date().toISOString(),
    fecha_nacimiento_jinete: f.fecha_nacimiento_jinete || null,
    anio_nacimiento_caballo: f.anio_nacimiento_caballo.trim() ? parseInt(f.anio_nacimiento_caballo, 10) : null,
  };
}

/** Fechas de nacimiento de jinete y caballo, solo si han dado permiso. */
export function FechasConPermiso({ valor, onChange }: { valor: FechasNacimiento; onChange: (v: FechasNacimiento) => void }) {
  return (
    <fieldset className="rounded border border-[#e4dfd4] p-4">
      <legend className="px-1 text-sm font-bold">Fechas de nacimiento (opcional)</legend>
      <p className="text-xs text-gray-600">
        Solo para binomios añadidos a mano. Los de concursos de la RFHE no las necesitan.
      </p>
      <label className="mt-3 flex items-start gap-2 text-sm">
        <input
          type="checkbox"
          className="mt-1"
          checked={valor.consentimiento}
          onChange={(e) => onChange(e.target.checked
            ? { ...valor, consentimiento: true }
            : { consentimiento: false, fecha_nacimiento_jinete: '', anio_nacimiento_caballo: '' })}
        />
        <span>
          El jinete (o su madre, padre o tutor si es menor de edad) ha leído la{' '}
          <Link href="/privacidad" target="_blank" className="text-primary underline">política de privacidad</Link>{' '}
          y acepta que guardemos su fecha de nacimiento y el año de nacimiento del caballo.
        </span>
      </label>
      {valor.consentimiento ? (
        <div className="mt-3 grid gap-4 sm:grid-cols-2">
          <div>
            <label htmlFor="fecha_nacimiento_jinete" className="mb-1 block text-sm font-bold">Fecha de nacimiento del jinete</label>
            <input
              id="fecha_nacimiento_jinete"
              type="date"
              value={valor.fecha_nacimiento_jinete}
              onChange={(e) => onChange({ ...valor, fecha_nacimiento_jinete: e.target.value })}
              className="input w-full"
            />
          </div>
          <div>
            <label htmlFor="anio_nacimiento_caballo" className="mb-1 block text-sm font-bold">Año de nacimiento del caballo</label>
            <input
              id="anio_nacimiento_caballo"
              type="number"
              min="1990"
              max="2035"
              placeholder="Ej. 2018"
              value={valor.anio_nacimiento_caballo}
              onChange={(e) => onChange({ ...valor, anio_nacimiento_caballo: e.target.value })}
              className="input w-full"
            />
          </div>
        </div>
      ) : (
        <p className="mt-2 text-xs text-gray-500">Sin este permiso no se guarda ninguna fecha.</p>
      )}
    </fieldset>
  );
}

'use client';

/** Datos de un concurso, los mismos que publica RFHE en su calendario y ficha. */
export type DatosConcurso = {
  nombre: string;
  tipo: string;
  fecha_inicio: string;
  fecha_fin: string;
  provincia: string;
  ubicacion: string;
  organizador: string;
  federacion: string;
  /** Enlace del concurso en la web de la RFHE (vacío = concurso manual). */
  rfhe_url: string;
};

export const CAMPOS_CONCURSO = [
  'nombre', 'tipo', 'fecha_inicio', 'fecha_fin', 'provincia', 'ubicacion', 'organizador', 'federacion', 'rfhe_url',
] as const;

export function concursoVacio(): DatosConcurso {
  return {
    nombre: '', tipo: '', fecha_inicio: '', fecha_fin: '',
    provincia: '', ubicacion: '', organizador: '', federacion: '', rfhe_url: '',
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
    provincia: limpio(datos.provincia),
    ubicacion: limpio(datos.ubicacion),
    organizador: limpio(datos.organizador),
    federacion: limpio(datos.federacion),
    rfhe_url: limpio(datos.rfhe_url),
  };
}

export function validarConcurso(datos: DatosConcurso): string | null {
  if (!datos.nombre.trim()) return 'El nombre es obligatorio';
  if (!datos.fecha_inicio || !datos.fecha_fin) return 'Las fechas de inicio y fin son obligatorias';
  if (datos.fecha_fin < datos.fecha_inicio) return 'La fecha de fin no puede ser anterior a la de inicio';
  if (datos.rfhe_url.trim() && !/^https:\/\/(www\.|gestion\.)?cbservicios\.net\//i.test(datos.rfhe_url.trim())) {
    return 'El enlace de la RFHE debe ser una dirección de la web de la Federación (cbservicios.net)';
  }
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

  return (
    <div className="grid gap-4 md:grid-cols-2">
      <div className="md:col-span-2">
        {etiqueta('nombre', 'Nombre del concurso *')}
        <input type="text" required {...campo('nombre')} />
      </div>
      <div className="md:col-span-2">
        {etiqueta('tipo', 'Tipo')}
        <input type="text" placeholder="Ej. CDN***, CDI*" {...campo('tipo')} />
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
      <div className="md:col-span-2">
        {etiqueta('rfhe_url', 'Enlace del concurso en la web de la RFHE')}
        <input type="url" placeholder="Solo si es un concurso de la Federación: https://www.cbservicios.net/..." {...campo('rfhe_url')} />
        <p className="mt-1 text-xs text-gray-500">
          Queda guardado para traer o actualizar los inscritos y las pruebas sin tener que buscarlo otra vez. Déjalo vacío si el concurso es manual.
        </p>
      </div>
    </div>
  );
}

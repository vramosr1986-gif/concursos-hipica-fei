// Genera db/esquema_actual.sql con la estructura REAL de la base de datos de
// Supabase (tablas, columnas, tipos, valores por defecto, claves primarias y
// foráneas), leída de la API de PostgREST con la clave de servidor.
//
//   node scripts/exportar-esquema.mjs
//
// No incluye políticas RLS, funciones ni el código de las vistas: esos están en
// los ficheros de migración. Lee las variables de .env.local.
import { readFileSync, writeFileSync } from 'node:fs';

const env = Object.fromEntries(
  readFileSync('.env.local', 'utf8').split(/\r?\n/)
    .map((l) => l.match(/^\s*([A-Z0-9_]+)\s*=\s*"?([^"]*)"?\s*$/))
    .filter(Boolean)
    .map((m) => [m[1], m[2]])
);
const url = env.NEXT_PUBLIC_SUPABASE_URL;
const clave = env.SUPABASE_SERVICE_ROLE_KEY;
if (!url || !clave) throw new Error('Faltan NEXT_PUBLIC_SUPABASE_URL o SUPABASE_SERVICE_ROLE_KEY en .env.local');

const res = await fetch(`${url}/rest/v1/`, { headers: { apikey: clave, Authorization: `Bearer ${clave}` } });
if (!res.ok) throw new Error(`Supabase respondió ${res.status}`);
const { definitions = {} } = await res.json();

const tipoSql = (p) => {
  if (p.format === 'ARRAY' || p.type === 'array') return `${p.items?.format || p.items?.type || 'text'}[]`;
  return p.format || p.type || 'text';
};
const fkDe = (descripcion = '') => {
  const m = descripcion.match(/<fk table='([^']+)' column='([^']+)'\/>/);
  return m ? { tabla: m[1], columna: m[2] } : null;
};

// Tablas antes que las que las referencian (y las vistas al final).
const nombres = Object.keys(definitions).sort();
const esVista = (n) => n.startsWith('v_');
const dependencias = (n) => Object.values(definitions[n].properties || {})
  .map((p) => fkDe(p.description)?.tabla).filter((t) => t && t !== n && definitions[t]);
const orden = [];
const visitar = (n, pila = new Set()) => {
  if (orden.includes(n) || pila.has(n)) return;
  pila.add(n);
  dependencias(n).forEach((d) => visitar(d, pila));
  orden.push(n);
};
nombres.filter((n) => !esVista(n)).forEach((n) => visitar(n));

const lineas = [
  '-- ============================================================',
  '-- ESQUEMA ACTUAL DE LA BASE DE DATOS (generado, no editar a mano)',
  `-- Proyecto: ${new URL(url).hostname.split('.')[0]}`,
  `-- Generado: ${new Date().toISOString().slice(0, 10)} con: node scripts/exportar-esquema.mjs`,
  '--',
  '-- Refleja tablas, columnas, tipos, valores por defecto y claves tal como',
  '-- están ahora en Supabase. No incluye políticas RLS, funciones ni el código',
  '-- de las vistas (ver las migraciones numeradas).',
  '-- ============================================================',
  '',
];

for (const nombre of orden) {
  const def = definitions[nombre];
  const requeridas = new Set(def.required || []);
  const pk = [];
  const columnas = Object.entries(def.properties || {}).map(([col, p]) => {
    const partes = [`  ${col}`, tipoSql(p)];
    if ((p.description || '').includes('<pk/>')) pk.push(col);
    if (requeridas.has(col)) partes.push('NOT NULL');
    if (p.default !== undefined) partes.push(`DEFAULT ${typeof p.default === 'string' && !/\(|::|^now|^gen_|^uuid|^public\./.test(p.default) ? `'${p.default}'` : p.default}`);
    const fk = fkDe(p.description);
    if (fk) partes.push(`REFERENCES ${fk.tabla}(${fk.columna})`);
    return partes.join(' ');
  });
  if (pk.length) columnas.push(`  PRIMARY KEY (${pk.join(', ')})`);
  lineas.push(`CREATE TABLE ${nombre} (`, columnas.join(',\n'), ');', '');
}

const vistas = nombres.filter(esVista);
if (vistas.length) {
  lineas.push('-- ------------------------------------------------------------', '-- VISTAS (solo columnas; su definición está en las migraciones)', '-- ------------------------------------------------------------');
  for (const nombre of vistas) {
    const cols = Object.entries(definitions[nombre].properties || {}).map(([c, p]) => `--   ${c} ${tipoSql(p)}`);
    lineas.push(`-- VIEW ${nombre}`, ...cols, '');
  }
}

writeFileSync('db/esquema_actual.sql', lineas.join('\n'));
console.log(`db/esquema_actual.sql: ${orden.length} tablas y ${vistas.length} vistas`);

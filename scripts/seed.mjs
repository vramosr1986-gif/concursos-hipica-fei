// Script de seed: inserta concursos y binomios de muestra en Supabase.
// Uso: node scripts/seed.mjs
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
const supabaseUrl = env.NEXT_PUBLIC_SUPABASE_URL;
const serviceRoleKey = env.SUPABASE_SERVICE_ROLE_KEY;

if (!supabaseUrl || !serviceRoleKey) {
  console.error('Faltan NEXT_PUBLIC_SUPABASE_URL o SUPABASE_SERVICE_ROLE_KEY en .env.local');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, serviceRoleKey);

async function seed() {
  console.log('Insertando concursos de muestra...');
  const { data: concursos, error: concursosError } = await supabase
    .from('concursos')
    .insert([
      {
        nombre: 'Concurso Nacional de Doma Clásica - Madrid',
        fecha_inicio: '2026-10-10',
        fecha_fin: '2026-10-12',
        ubicacion: 'Club de Campo Villa de Madrid',
        organizador: 'RFHE',
      },
      {
        nombre: 'Copa Primavera de Doma Clásica - Sevilla',
        fecha_inicio: '2026-11-05',
        fecha_fin: '2026-11-06',
        ubicacion: 'Hípica Andaluza',
        organizador: 'Federación Andaluza de Hípica',
      },
    ])
    .select();

  if (concursosError) {
    console.error('Error insertando concursos:', concursosError.message);
    console.error(JSON.stringify(concursosError, Object.getOwnPropertyNames(concursosError)));
    process.exit(1);
  }
  console.log(`✔ ${concursos.length} concursos insertados`);

  const [concurso1, concurso2] = concursos;

  console.log('Insertando binomios de muestra...');
  const binomios = [
    { concurso_id: concurso1.id, dorsal: 1, nombre_jinete: 'Laura Gómez', nombre_caballo: 'Bandolero', equipo: 'Club Hípico Madrid', orden_salida: 1 },
    { concurso_id: concurso1.id, dorsal: 2, nombre_jinete: 'Carlos Ruiz', nombre_caballo: 'Estrella', equipo: 'Club Hípico Madrid', orden_salida: 2 },
    { concurso_id: concurso1.id, dorsal: 3, nombre_jinete: 'Marta Sánchez', nombre_caballo: 'Vendaval', equipo: 'Escuela Ecuestre Norte', orden_salida: 3 },
    { concurso_id: concurso2.id, dorsal: 1, nombre_jinete: 'Javier López', nombre_caballo: 'Alcazar', equipo: 'Hípica Andaluza', orden_salida: 1 },
    { concurso_id: concurso2.id, dorsal: 2, nombre_jinete: 'Ana Torres', nombre_caballo: 'Duquesa', equipo: 'Hípica Andaluza', orden_salida: 2 },
  ];

  const { data: binomiosData, error: binomiosError } = await supabase
    .from('binomios')
    .insert(binomios)
    .select();

  if (binomiosError) {
    console.error('Error insertando binomios:', binomiosError.message);
    process.exit(1);
  }
  console.log(`✔ ${binomiosData.length} binomios insertados`);

  console.log('Insertando jueces de muestra...');
  const jueces = [
    { concurso_id: concurso1.id, nombre: 'Isabel Fernández', letra_oficial: 'C', experiencia: 'Juez Internacional FEI 4*' },
    { concurso_id: concurso1.id, nombre: 'Pedro Álvarez', letra_oficial: 'H', experiencia: 'Juez Nacional' },
    { concurso_id: concurso1.id, nombre: 'Sofía Martín', letra_oficial: 'M', experiencia: 'Juez Nacional' },
    { concurso_id: concurso2.id, nombre: 'Ricardo Navarro', letra_oficial: 'C', experiencia: 'Juez Internacional FEI 3*' },
    { concurso_id: concurso2.id, nombre: 'Elena Castro', letra_oficial: 'E', experiencia: 'Juez Nacional' },
  ];

  const { data: juecesData, error: juecesError } = await supabase
    .from('jueces')
    .insert(jueces)
    .select();

  if (juecesError) {
    console.error('Error insertando jueces:', juecesError.message);
    process.exit(1);
  }
  console.log(`✔ ${juecesData.length} jueces insertados`);
  console.log('Seed completado.');
}

seed();

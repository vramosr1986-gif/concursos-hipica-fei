// Script para crear el primer usuario admin y un usuario juez.
// Uso: node scripts/create-users.mjs
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

const usuarios = [
  {
    email: 'admin@concursosfei.com',
    password: 'Admin123!',
    nombre: 'Administrador FEI',
    role: 'admin',
  },
  {
    email: 'juez@concursosfei.com',
    password: 'Juez123!',
    nombre: 'Juez de Prueba',
    role: 'judge',
  },
];

async function crearUsuario({ email, password, nombre, role }) {
  const { data: created, error: createError } = await supabase.auth.admin.createUser({
    email,
    password,
    email_confirm: true,
    user_metadata: { nombre },
  });

  if (createError) {
    console.error(`Error creando ${email}:`, createError.message);
    return;
  }

  const { error: insertError } = await supabase.from('users').insert([
    {
      id: created.user.id,
      email,
      nombre,
      role,
    },
  ]);

  if (insertError) {
    console.error(`Error insertando perfil de ${email}:`, insertError.message);
    await supabase.auth.admin.deleteUser(created.user.id);
    return;
  }

  console.log(`✔ Usuario creado: ${email} (${role})`);
}

async function main() {
  for (const usuario of usuarios) {
    await crearUsuario(usuario);
  }
  console.log('Listo.');
}

main();

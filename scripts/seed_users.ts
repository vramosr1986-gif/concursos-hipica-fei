/**
 * Script de seed: crear usuarios con Service Role Key
 * Ejecutar con: npx tsx scripts/seed_users.ts
 */

import { createClient } from '@supabase/supabase-js';
import * as fs from 'fs';
import * as path from 'path';

const envPath = path.join(process.cwd(), '.env.local');
const envContent = fs.readFileSync(envPath, 'utf-8');

const env: Record<string, string> = {};
envContent.split('\n').forEach((line) => {
  const match = line.match(/^([^=]+)=(.*)$/);
  if (match) {
    env[match[1].trim()] = match[2].trim();
  }
});

const SUPABASE_URL = env.NEXT_PUBLIC_SUPABASE_URL;
const SERVICE_ROLE_KEY = env.SUPABASE_SERVICE_ROLE_KEY;

if (!SUPABASE_URL || !SERVICE_ROLE_KEY) {
  console.error('Faltan variables: NEXT_PUBLIC_SUPABASE_URL o SUPABASE_SERVICE_ROLE_KEY');
  process.exit(1);
}

const supabaseAdmin = createClient(SUPABASE_URL, SERVICE_ROLE_KEY, {
  auth: { autoRefreshToken: false, persistSession: false },
});

type SeedUser = {
  email: string;
  password: string;
  nombre: string;
  rol: 'admin' | 'juez';
};

// Las contraseñas NO se guardan en el código: se pasan por variables de entorno.
//   SEED_ADMIN_PASSWORD=... SEED_JUEZ_PASSWORD=... npx tsx scripts/seed_users.ts
const ADMIN_PASSWORD = process.env.SEED_ADMIN_PASSWORD || '';
const JUEZ_PASSWORD = process.env.SEED_JUEZ_PASSWORD || '';
if (!ADMIN_PASSWORD || !JUEZ_PASSWORD) {
  console.error('Define SEED_ADMIN_PASSWORD y SEED_JUEZ_PASSWORD antes de ejecutar este script.');
  process.exit(1);
}

const USERS: SeedUser[] = [
  { email: 'vramosr1986@gmail.com', password: ADMIN_PASSWORD, nombre: 'Victor Ramos', rol: 'admin' },
  { email: 'juez1@test.com', password: JUEZ_PASSWORD, nombre: 'Ana Garcia', rol: 'juez' },
  { email: 'juez2@test.com', password: JUEZ_PASSWORD, nombre: 'Luis Perez', rol: 'juez' },
  { email: 'juez3@test.com', password: JUEZ_PASSWORD, nombre: 'Carlos Ruiz', rol: 'juez' },
  { email: 'juez4@test.com', password: JUEZ_PASSWORD, nombre: 'Marta Lopez', rol: 'juez' },
  { email: 'juez5@test.com', password: JUEZ_PASSWORD, nombre: 'Pedro Sanchez', rol: 'juez' },
];

async function crearUsuario(u: SeedUser) {
  const { data: existing } = await supabaseAdmin
    .from('profiles')
    .select('id')
    .eq('email', u.email)
    .maybeSingle();

  if (existing) {
    console.log('  Ya existe:', u.email);
    return existing.id;
  }

  const { data: authData, error: authError } = await supabaseAdmin.auth.admin.createUser({
    email: u.email,
    password: u.password,
    email_confirm: true,
    user_metadata: { nombre: u.nombre },
  });

  if (authError) {
    console.error('  ERROR auth:', u.email, authError.message);
    return null;
  }

  const { error: profileError } = await supabaseAdmin
    .from('profiles')
    .insert({
      id: authData.user.id,
      email: u.email,
      nombre: u.nombre,
      rol: u.rol,
    });

  if (profileError) {
    console.error('  ERROR profile:', u.email, profileError.message);
    await supabaseAdmin.auth.admin.deleteUser(authData.user.id);
    return null;
  }

  console.log('  Creado:', u.email, '->', u.rol);
  return authData.user.id;
}

async function main() {
  console.log('=== SEED USUARIOS ===\n');

  for (const u of USERS) {
    await crearUsuario(u);
  }

  console.log('\n=== COMPLETADO ===');
  console.log('\nUsuarios creados:');
  console.log('  admin: vramosr1986@gmail.com');
  console.log('  juez1: juez1@test.com');
  console.log('  juez2: juez2@test.com');
  console.log('  juez3: juez3@test.com');
  console.log('  juez4: juez4@test.com');
  console.log('  juez5: juez5@test.com');
}

main().catch(console.error);

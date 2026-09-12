# Concursos Hípicos FEI

Plataforma serverless para la gestión de **concursos de doma clásica (FEI/RFHE)** con tres paneles diferenciados: público, jueces y administración.

## Características

### Panel Público
- Consulta de notas y resultados finales por concurso y binomio.
- Clasificaciones con columnas por letra de juez, puntuación final y resultados "en vivo" (realtime).

### Panel de Jueces
- Listado de pruebas asignadas al juez (denominado con letra oficial A–E).
- Evaluación de binomios participante a participante, ejercicio a ejercicio de la reprise.
- Nota 0–10 por ejercicio según la escala FEI, con comentario opcional.

### Panel de Administración
- Gestión completa de concursos, jornadas, pruebas y reprises.
- Catálogo de reprises FEI (incluye catálogo online de reprises RFHE 2023 con ejercicios).
- Registro de binomios (jinete + caballo) con licencia federativa y control de duplicados.
- Inscripciones por concurso con dorsal único y orden de salida.
- Asignación de jueces a cada prueba con letras oficiales.
- Gestión de usuarios y roles (admin / juez).

## Tecnologías

| Capa | Tecnología |
|---|---|
| Framework | Next.js 14 (App Router) + React 18 |
| Lenguaje | TypeScript 5.3 |
| Base de datos | Supabase (PostgreSQL + RLS) |
| Autenticación | Supabase Auth |
| Estilos | Tailwind CSS 3.3 |
| Estado | Zustand |
| Despliegue | Vercel |

## Estructura del proyecto

```
src/
├── app/
│   ├── page.tsx               # Landing: paneles y listado de concursos
│   ├── login/                 # Inicio de sesión
│   ├── signup/                # Registro público (deshabilitado)
│   ├── resultados/            # Panel público
│   │   └── [id]/              # Notas detalladas por concurso
│   ├── juez/                  # Panel de jueces
│   │   └── prueba/[pruebaId]/ # Participaciones y puntuación por ejercicio
│   ├── admin/                 # Panel de administración
│   │   ├── concursos/         # CRUD de concursos, jornadas, pruebas, jueces y binomios
│   │   ├── binomios/          # Catálogo de binomios
│   │   ├── jueces/            # Catálogo de jueces
│   │   ├── reprises/          # Catálogo de reprises y sus ejercicios
│   │   ├── usuarios/          # Gestión de usuarios
│   │   └── nuevo/             # Hub de creación
│   └── api/                   # API Routes (REST)
├── components/                # Componentes React (Navbar, ConcursoCard, ...)
├── lib/
│   ├── supabase.ts            # Cliente Supabase (navegador)
│   ├── supabase-server.ts     # Cliente Supabase (servidor)
│   ├── supabase-admin.ts      # Cliente con service role (bypasa RLS)
│   ├── auth.ts                # Servicios de autenticación
│   ├── services.ts            # Servicios CRUD
│   └── constants.ts           # Criterios FEI, letras de jueces, escala de puntuación
├── types/                     # Tipos TypeScript
└── supabase/migrations/       # Migraciones SQL
```

## Modelo de datos

```
concursos ──► jornadas
    │                reprises ──► ejercicios_reprise
    │                prueba_jueces (prueba + juez + letra oficial)
    └─► pruebas ──► participaciones ──► puntuaciones (por juez y ejercicio)
inscripciones (binomio × concurso)
profiles (usuario con rol admin|juez)
binomios (catálogo global de binomios)
```

- `profiles`: vinculada a `auth.users` con rol `admin` o `juez` (RLS con funciones `is_admin()`/`is_staff()`).
- `reprises`: reprise con código, categoría, nivel, años, coeficientes y puntos máximos.
- `pruebas`: cada prueba está ligada a un concurso y una reprise, con categoría, fecha, hora, pista y estado.
- `puntuaciones`: notas de cada juez por ejercicio de la reprise, ligadas a cada participación.

## API Endpoints

```
GET/POST   /api/concursos
GET/POST   /api/jornadas
GET/POST   /api/reprises
GET/POST   /api/reprises/[id]/ejercicios
PUT/DELETE /api/ejercicios
GET/POST/DELETE /api/binomios          # 409 si la licencia ya existe
GET/POST/DELETE /api/jueces
GET/POST/PUT    /api/puntuaciones
GET/POST/DELETE /api/inscripciones     # 409 si el dorsal está duplicado
GET/DELETE/PATCH /api/admin/usuarios   # create/update/delete con service role
```

## Puesta en marcha

Requisitos: Node.js 18+ y un proyecto en Supabase.

```bash
npm install
cp .env.local.example .env.local   # o crea el archivo manualmente
npm run dev
```

### Variables de entorno

```env
NEXT_PUBLIC_SUPABASE_URL=tu_url_supabase
NEXT_PUBLIC_SUPABASE_ANON_KEY=tu_anon_key
SUPABASE_SERVICE_ROLE_KEY=tu_service_role_key
```

Se obtienen en [app.supabase.com](https://app.supabase.com) → Settings → API → Keys.

### Base de datos

Aplica los scripts SQL en el orden deseado (ver `supabase/migrations/` y los scripts del directorio raíz: `crear_profiles.sql`, `crear_funciones_roles.sql`, `fix_recursion_profiles.sql`, `crear_tablas_pruebas.sql`, etc.) en Supabase → SQL Editor. Los scripts `*_pending*.sql` / `insertar_*.sql` cargan las reprises FEI y sus ejercicios.

### Scripts disponibles

| Script | Descripción |
|---|---|
| `npm run dev` | Servidor de desarrollo |
| `npm run build` | Build de producción |
| `npm run start` | Servidor de producción |
| `npm run lint` | ESLint |
| `npm run type-check` | Comprobación de tipos (tsc --noEmit) |
| `npm run db:push` / `db:pull` | Sincronizar schema con Supabase |

## Despliegue en Vercel

1. Sube el repositorio a GitHub.
2. Importa el proyecto en [vercel.com](https://vercel.com).
3. Configura las variables de entorno del `.env.local`.
4. Deploy. `vercel.json` ya define el build y la configuración de función por-hogar para `/api/**` (memoria 1024, maxDuration 60).

## Autenticación y roles

| Rol | Acceso |
|---|---|
| Público | Resultados y notas (lectura) |
| Juez | Panel de jueces: puntuar las pruebas que tiene asignadas |
| Admin | Panel completo de administración y gestión de usuarios |

El registro público está deshabilitado; los usuarios se crean desde `/admin/usuarios` (el API usa `SUPABASE_SERVICE_ROLE_KEY`).

## Puntuación FEI

- Evaluación de cada ejercicio de la reprise con nota 0–10 según la escala FEI (`ESCALA_PUNTUACION` en `src/lib/constants.ts`).
- Cada ejercicio puede tener coeficiente y puntuación máxima.
- Los resultados se muestran por juez (letra) con columna de `puntuacion_final`.
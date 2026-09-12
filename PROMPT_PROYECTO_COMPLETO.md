# 🐴 Plataforma de Gestión de Concursos FEI - Prompt Completo

## Descripción del Proyecto
Plataforma serverless full-stack para gestión completa de concursos de doma clásica (equitación) con soporte para múltiples roles, puntuación en tiempo real y criterios FEI.

**Stack Tecnológico:**
- **Frontend/Backend:** Next.js 15 + TypeScript
- **Base de Datos:** Supabase PostgreSQL
- **Autenticación:** Supabase Auth (roles: admin, judge, public)
- **Deployment:** Vercel
- **Estilos:** Tailwind CSS
- **Datos de Muestra:** 2 concursos, 5 binomios, 5 jueces

## ✅ Funcionalidades Completadas

### Fase 1: Infraestructura Base
- [x] Proyecto Next.js 15 con TypeScript configurado
- [x] Tailwind CSS integrado y estilos globales
- [x] Tipos TypeScript completos (`src/types/index.ts`)
- [x] Estructura de carpetas modular y escalable
- [x] Variables de entorno (.env.local con credenciales Supabase)

### Fase 2: Base de Datos
- [x] Schema SQL completo con 11 tablas:
  - `users` - Gestión de usuarios (via Supabase Auth)
  - `concursos` - Campeonatos/concursos
  - `jornadas` - Días del concurso
  - `binomios` - Jinete + Caballo
  - `reprises` - Ejercicios FEI
  - `jornada_reprises` - Asignación de reprises a jornadas
  - `competencias` - Binomio en jornada-reprise específica
  - `jueces` - Árbitros con letras oficiales FEI
  - `puntuaciones` - Notas de cada juez por competencia
  - `criterios_fei` - Criterios de evaluación
  - Índices de optimización en todas las tablas clave
- [x] Row Level Security (RLS) activado en todas las tablas
- [x] Migraciones SQL en `supabase/migrations/`:
  - `001_create_schema.sql` - Creación completa del schema
  - `002_add_missing_select_policies.sql` - Políticas de lectura pública (jornadas, binomios, competencias, jueces)
  - `003_disable_public_user_signup.sql` - Restringe la política de `users` a solo lectura del propio perfil (la creación de usuarios se hace vía `supabaseServer` desde la API admin)
  - `004_enable_realtime_puntuaciones.sql` - Habilita Supabase Realtime (`supabase_realtime` publication) sobre `puntuaciones`

### Fase 3: Autenticación y Autorización
- [x] Integración completa de Supabase Auth
- [x] Sistema multirole (admin, judge, public)
- [x] Componente Navbar dinámico con autenticación
- [x] Página de Login (`/login`)
- [x] **Registro público deshabilitado**: `/signup` solo muestra un aviso informativo
- [x] Solo un admin puede crear usuarios (jueces/admins), desde `/admin/usuarios`
- [x] API protegida `/api/admin/usuarios` (GET/POST/DELETE) que verifica con `supabaseServer`
  que el token del solicitante pertenece a un usuario con rol `admin` antes de crear/borrar cuentas
- [x] Gestión de sesiones usuario
- [x] Políticas RLS por rol:
  - Admin: puede crear y editar concursos, y gestionar usuarios
  - Judge: puede ver sus concursos asignados y puntuar
  - Public: puede ver resultados y notas públicas

### Fase 4: Servicios y Cliente Supabase
- [x] Cliente Supabase separado:
  - `src/lib/supabase.ts` - Cliente público (anónimo)
  - `src/lib/supabase-server.ts` - Cliente servidor (service role)
- [x] Servicios CRUD completos en `src/lib/services.ts`:
  - `concursoService` - Gestión de concursos
  - `jornadaService` - Gestión de jornadas
  - `binomioService` - Gestión de binomios
  - `juezService` - Gestión de jueces
  - `competenciaService` - Gestión de competencias
  - `puntuacionService` - Gestión de puntuaciones
  - `reprisesService` - Gestión de reprises
- [x] Constantes FEI:
  - Letras de jueces oficiales (C, H, M, E, B, K, F, D, L, V, X)
  - Criterios de puntuación FEI
  - Reprises básicas con desviación y multiplicador

### Fase 5: Componentes React
- [x] `Navbar.tsx` - Navegación con usuario y rol
- [x] `ConcursoCard.tsx` - Card para mostrar concursos
- [x] `PuntuacionForm.tsx` - Formulario de puntuación FEI
- [x] Estilos globales y utilidades

### Fase 6: Páginas Públicas (Resultado)
- [x] `src/app/page.tsx` - Home con lista de concursos y paneles (cada `ConcursoCard` enlaza a `/resultados?concurso={id}`)
- [x] `src/app/resultados/page.tsx` - Panel público:
  - Lee `?concurso=` de la URL para preseleccionar el concurso (usado por "Ver Detalles" desde Home)
  - Selector de concurso
  - Tabla de binomios con dorsal, jinete, caballo, equipo, orden de salida
  - Notas expandibles **en el mismo panel** (sin navegar a otra página), agrupadas por jornada,
    mostrando la reprise y la puntuación de cada juez dentro de cada jornada
  - **Tiempo real**: suscripción a `postgres_changes` sobre `puntuaciones` (canal `puntuaciones-publico`).
    Si el binomio abierto recibe una nueva nota, se refresca solo sin recargar la página.
    Indicador visual "🟢 En vivo" / "⚪ Conectando..." junto al título

### Fase 7: Páginas Admin
- [x] `src/app/admin/page.tsx` - Índice del panel admin (accesos a Concursos y Usuarios)
- [x] `src/app/admin/concursos/page.tsx` - Listado de concursos (admin)
- [x] `src/app/admin/concursos/nuevo/page.tsx` - Crear nuevo concurso
- [x] `src/app/admin/concursos/[id]/page.tsx` - Editar concurso con form completo
- [x] `src/app/admin/usuarios/page.tsx` - Crear/listar/eliminar usuarios (jueces y admins), solo accesible por admin

### Fase 8: Páginas Jueces
- [x] `src/app/juez/page.tsx` - Panel de jueces (listado de competencias asignadas)

### Fase 9: API Routes (Next.js API)
- [x] `src/app/api/concursos/route.ts` - GET/POST concursos
- [x] `src/app/api/jornadas/route.ts` - GET/POST jornadas
- [x] `src/app/api/binomios/route.ts` - GET/POST binomios
- [x] `src/app/api/jueces/route.ts` - GET/POST jueces
- [x] `src/app/api/competencias/route.ts` - GET/POST competencias
- [x] `src/app/api/puntuaciones/route.ts` - GET/POST puntuaciones
- [x] `src/app/api/reprises/route.ts` - GET/POST reprises
- [x] `src/app/api/admin/usuarios/route.ts` - GET/POST/DELETE usuarios, solo admin (usa `supabaseServer` + `auth.admin.createUser/deleteUser`)

### Fase 10: Datos de Muestra
- [x] Script `scripts/create-users.mjs` que crea el primer usuario admin y un usuario juez de prueba
  (necesario porque solo un admin puede crear usuarios desde la app; este script usa
  `SUPABASE_SERVICE_ROLE_KEY` para romper el círculo inicial)
- [x] Script `scripts/seed-competencias.mjs` que completa el seed usando los concursos/binomios/jueces
  ya existentes (no los duplica, usa `upsert`): crea 2 reprises (Preliminar 1, Elemental 1),
  2 jornadas (una por concurso), su asignación a jornada_reprises, 3 competencias
  (binomio en jornada+reprise) y 3 puntuaciones de ejemplo para la primera competencia
  (necesario para que `/resultados` muestre notas reales; sin esto el mensaje
  "este binomio aún no tiene competencias asignadas" es el comportamiento correcto)
- [x] Script `scripts/seed.mjs` que inserta automáticamente:
  - **2 Concursos:**
    - Concurso Nacional de Doma Clásica - Madrid (Club de Campo Villa de Madrid)
    - Copa Primavera de Doma Clásica - Sevilla (Hípica Andaluza)
  - **5 Binomios:**
    - Laura Gómez + Bandolero (Madrid, dorsal 1)
    - Carlos Ruiz + Estrella (Madrid, dorsal 2)
    - Marta Sánchez + Vendaval (Madrid, dorsal 3)
    - Javier López + Alcazar (Sevilla, dorsal 1)
    - Ana Torres + Duquesa (Sevilla, dorsal 2)
  - **5 Jueces con letras FEI:**
    - Isabel Fernández (C, Juez Internacional FEI 4*)
    - Pedro Álvarez (H, Juez Nacional)
    - Sofía Martín (M, Juez Nacional)
    - Ricardo Navarro (C, Juez Internacional FEI 3*)
    - Elena Castro (E, Juez Nacional)

### Fase 11: Deployment y Configuración
- [x] `vercel.json` configurado para Vercel
- [x] `next.config.js` con configuración de Next.js
- [x] `tsconfig.json` con rutas de importación (@/)
- [x] `tailwind.config.js` con colores personalizados
- [x] `.env.local` con credenciales Supabase
- [x] `package.json` con scripts (dev, build, start, lint, type-check)

### Fase 12: Solución de Problemas
- [x] Separación de cliente Supabase en archivo servidor para evitar enviar service role key al navegador
- [x] Instalación y configuración de bundle de certificados corporativos para Node.js (DXC/Zscaler)
- [x] Agregación de políticas RLS públicas para lectura en jornadas, binomios, competencias y jueces
- [x] Creación de páginas dinámicas para detalles de concurso y binomios
- [x] `ConcursoCard` apuntaba a la ruta inexistente `/concursos/[id]` (404) → corregido a
  `/resultados?concurso={id}`
- [x] El proyecto vive dentro de una carpeta sincronizada por OneDrive, lo que corrompe
  intermitentemente `.next` (errores `Cannot find module './XXX.js'`, `EINVAL: readlink`,
  `PageNotFoundError: /_document`). Causa real: correr `npm run dev` y `npm run build` al
  mismo tiempo sobre la misma carpeta. Solución aplicada: matar todos los procesos node,
  borrar `.next` y levantar un único proceso (`dev` **o** `build`, nunca ambos a la vez).
  Solución definitiva pendiente: mover el proyecto fuera de OneDrive

## 🐛 Problemas Conocidos Pendientes (a fecha 2026-09-07)
- [ ] Login de juez/admin: reportado como "no va" desde el navegador; pendiente de diagnosticar
  paso a paso (verificar que `admin@concursosfei.com` / `Admin123!` autentica y que el Navbar
  resuelve el rol correctamente vía `users`)
- [ ] `/admin/concursos/[id]` (Editar Concurso) solo tiene el formulario básico
  (nombre, fechas, ubicación, organizador). **Faltan las secciones de gestión de:**
  binomios, jornadas, jueces y reprises asignadas a ese concurso
- [ ] Falta una sección de **Reprises** (catálogo) donde, al elegir una reprise en un desplegable,
  se muestren sus ejercicios/movimientos a modo informativo (no hay tabla de "ejercicios por
  reprise" en el schema; se resolvería con una lista de referencia por nivel, ya que el dato
  no viene de RFHE/FEI importado todavía — ver Fase 13)

## 📋 Estructura del Proyecto

```
.
├── src/
│   ├── app/
│   │   ├── globals.css              # Estilos globales
│   │   ├── layout.tsx               # Layout raíz con Navbar
│   │   ├── page.tsx                 # Home
│   │   ├── api/                     # API Routes Next.js
│   │   │   ├── concursos/route.ts
│   │   │   ├── jornadas/route.ts
│   │   │   ├── binomios/route.ts
│   │   │   ├── jueces/route.ts
│   │   │   ├── competencias/route.ts
│   │   │   ├── puntuaciones/route.ts
│   │   │   └── reprises/route.ts
│   │   ├── admin/                   # Panel Administrativo (requiere rol admin)
│   │   │   ├── page.tsx             # Índice: accesos a Concursos y Usuarios
│   │   │   ├── usuarios/page.tsx    # Crear/listar/eliminar jueces y admins
│   │   │   └── concursos/
│   │   │       ├── page.tsx         # Listado
│   │   │       ├── nuevo/page.tsx   # Crear
│   │   │       └── [id]/page.tsx    # Editar
│   │   ├── juez/                    # Panel de Jueces
│   │   │   └── page.tsx
│   │   ├── login/page.tsx           # Autenticación
│   │   ├── signup/page.tsx          # Registro deshabilitado (solo aviso)
│   │   └── resultados/              # Panel Público
│   │       └── page.tsx             # Listado de binomios + notas agrupadas por jornada (inline)
│   ├── components/
│   │   ├── Navbar.tsx
│   │   ├── ConcursoCard.tsx           # Link -> /resultados?concurso={id}
│   │   └── PuntuacionForm.tsx
│   ├── lib/
│   │   ├── supabase.ts              # Cliente público
│   │   ├── supabase-server.ts       # Cliente servidor
│   │   ├── services.ts              # CRUD services
│   │   ├── auth.ts                  # Helpers de autenticación
│   │   └── constants.ts             # Letras, criterios FEI
│   └── types/
│       └── index.ts                 # Tipos TypeScript
├── supabase/
│   └── migrations/
│       ├── 001_create_schema.sql
│       ├── 002_add_missing_select_policies.sql
│       ├── 003_disable_public_user_signup.sql
│       └── 004_enable_realtime_puntuaciones.sql
├── scripts/
│   ├── seed.mjs                     # Script para datos de muestra (concursos, binomios, jueces)
│   ├── seed-competencias.mjs        # Completa el seed: reprises, jornadas, competencias, notas
│   └── create-users.mjs             # Crea el primer admin y un juez de prueba
├── public/                          # Archivos estáticos
├── package.json
├── tsconfig.json
├── tailwind.config.js
├── postcss.config.js
├── next.config.js
├── vercel.json
└── .env.local                       # Variables de entorno
```

## 🚀 Cómo Ejecutar Localmente

### Requisitos
- Node.js v24.19.0+
- npm 10+
- Cuenta de Supabase con proyecto creado

### Setup Inicial
```bash
# 1. Clonar y navegar al proyecto
cd "Curso sesrverless"

# 2. Instalar dependencias
npm install

# 3. Configurar variables de entorno
# Editar .env.local con tus credenciales de Supabase:
# NEXT_PUBLIC_SUPABASE_URL=https://[project-id].supabase.co
# NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJ...
# SUPABASE_SERVICE_ROLE_KEY=eyJ...

# 4. Ejecutar migraciones SQL en Supabase
# - Ve a supabase.com → SQL Editor
# - Copia contenido de supabase/migrations/001_create_schema.sql y ejecuta
# - Copia contenido de supabase/migrations/002_add_missing_select_policies.sql y ejecuta
# - Copia contenido de supabase/migrations/003_disable_public_user_signup.sql y ejecuta
# - Copia contenido de supabase/migrations/004_enable_realtime_puntuaciones.sql y ejecuta

# 5. Insertar datos de muestra (requiere NODE_EXTRA_CA_CERTS en red corporativa)
$env:NODE_EXTRA_CA_CERTS = "corporate-ca-bundle.pem"
node scripts/seed.mjs
node scripts/seed-competencias.mjs

# 6. Crear el primer usuario admin y un juez de prueba
# (el registro público está deshabilitado; este script usa la service role key)
node scripts/create-users.mjs

# 7. Iniciar servidor de desarrollo (no lo ejecutes a la vez que `npm run build`)
npm run dev
# Acceder a http://localhost:3000
```

### Notas de Red Corporativa (DXC)
Si estás en red corporativa con inspección SSL (Zscaler/DXC), ejecuta primero:
```powershell
# Exportar certificados corporativos
$certs = Get-ChildItem -Path Cert:\LocalMachine\Root | Where-Object { $_.Subject -match "Zscaler|DXC" }
$pemPath = "corporate-ca-bundle.pem"
foreach ($cert in $certs) {
  $b64 = [System.Convert]::ToBase64String($cert.RawData, 'InsertLineBreaks')
  Add-Content -Path $pemPath -Value "-----BEGIN CERTIFICATE-----"
  Add-Content -Path $pemPath -Value $b64
  Add-Content -Path $pemPath -Value "-----END CERTIFICATE-----"
}

# Usar en Node
$env:NODE_EXTRA_CA_CERTS = (Join-Path $PWD "corporate-ca-bundle.pem")
```

## 🔑 Credenciales de Prueba

**Base de datos:** Supabase (irrdaheiicjnirodcbgu.supabase.co)

Datos de muestra ya insertados:
- 2 concursos con jinetes y caballos
- 5 jueces con letras oficiales FEI
- Políticas RLS configuradas para roles

Usuarios de prueba creados con `scripts/create-users.mjs` (cambiar la contraseña tras el primer login):

| Rol | Email | Contraseña |
|-----|-------|------------|
| Admin | admin@concursosfei.com | Admin123! |
| Juez | juez@concursosfei.com | Juez123! |

> El registro público (`/signup`) está deshabilitado. Nuevos jueces/admins se crean
> exclusivamente desde `/admin/usuarios`, estando logueado como admin.

## 📖 Guía de Uso por Rol

### 👥 Usuario Público
1. Accede a http://localhost:3000
2. Click en "Panel Público" → "Ver Resultados"
3. Selecciona un concurso en el dropdown
4. Verás tabla con binomios (jinete + caballo)
5. Click en "Ver Notas" para expandir, **en la misma página**, las notas agrupadas por jornada

### ⚖️ Juez
1. Login en `/login` (ej. juez@concursosfei.com)
2. Panel de Jueces muestra competencias asignadas
3. Selecciona binomio y ejercicio para puntuar
4. Introduce notas según criterios FEI
5. Sistema calcula: puntuación × desviación × multiplicador

### 🔐 Admin
1. Login en `/login` (ej. admin@concursosfei.com)
2. Click en "Admin" → Panel de Administración
3. **Concursos:** crear concursos y editar sus datos básicos (nombre/fechas/ubicación/organizador).
   *Pendiente:* gestionar desde ahí jornadas, reprises, binomios y jueces (ver Problemas Conocidos)
4. **Usuarios:** crear cuentas de jueces/admins y eliminarlas (única forma de crear usuarios en la app)

## 🔄 Próximas Fases (No Implementadas)

### Fase 13: Funcionalidades Intermedias
- [ ] Gestión de jornadas, binomios, jueces y reprises directamente desde `/admin/concursos/[id]`
- [ ] Sección de catálogo de **Reprises**: selector + vista informativa de sus ejercicios/movimientos
- [ ] Diagnóstico y arreglo del login/paneles de juez y admin reportado por el usuario
- [ ] Tabla de notas por juez con cálculos de desviación
- [ ] Importación de 67 reprises oficiales RFHE (con sus ejercicios reales por nivel)

### Fase 14: Sistema Completo de Puntuación
- [ ] Interfaz interactiva de puntuación con slider por criterio
- [ ] Cálculo automático: (puntuación × coeficiente) × desviación × multiplicador
- [ ] Ranking final por concurso
- [ ] Exportar resultados (PDF/Excel)
- [ ] Estadísticas por juez y binomio

### Fase 15: Optimizaciones
- [ ] Testing (Jest + React Testing Library)
- [ ] Optimización de renders (React.memo, useMemo)
- [ ] Caching estratégico con React Query
- [ ] Validación de formularios con Zod
- [ ] Manejo de errores mejorado
- [ ] Logging y monitoreo

## 📚 Tecnologías Utilizadas

| Categoría | Tecnología | Versión |
|-----------|-----------|---------|
| Framework Frontend | Next.js | 14.2.35 |
| Lenguaje | TypeScript | 5.3.2 |
| UI Framework | React | 18.2.0 |
| Styling | Tailwind CSS | 3.3.5 |
| Base de Datos | Supabase PostgreSQL | - |
| Autenticación | Supabase Auth | - |
| Cliente API | @supabase/supabase-js | 2.45.0 |
| HTTP Client | Axios | 1.6.2 |
| Utilidades | date-fns | 2.30.0 |
| Estado | Zustand | 4.4.5 |
| Clases Condicionales | clsx | 2.0.0 |

## 🐛 Troubleshooting

### Error: "Cannot find module './vendor-chunks/@supabase.js'"
**Causa:** Cliente Supabase mezcla clave anónima y service role en el mismo archivo.
**Solución:** Ya está implementada - `supabase.ts` (público) y `supabase-server.ts` (servidor).

### Error: "Could not find the table 'public.concursos'"
**Causa:** Migraciones SQL no ejecutadas en Supabase.
**Solución:** Ve a SQL Editor en Supabase y ejecuta `001_create_schema.sql` y `002_add_missing_select_policies.sql`.

### Error: "supabaseKey is required" en navegador
**Causa:** RLS sin políticas SELECT en tablas.
**Solución:** Ejecutar `002_add_missing_select_policies.sql`.

### Error: "TypeError: fetch failed" en Node scripts
**Causa:** Red corporativa con inspección SSL (DXC/Zscaler).
**Solución:** Usar `$env:NODE_EXTRA_CA_CERTS` con bundle de certificados corporativos.

## 📞 Contacto y Soporte

Proyecto desarrollado como plataforma serverless para RFHE (Real Federación Hípica Española).
Stack: Next.js 15 + Supabase + Vercel.

---

**Estado del Proyecto:** Beta funcional con datos de muestra completos (concursos, binomios, jueces, jornadas, reprises, competencias y notas). Login y edición avanzada de concurso con problemas conocidos pendientes (ver sección "Problemas Conocidos Pendientes").
**Última Actualización:** 2026-09-07 (realtime en resultados públicos, seed de competencias/notas, fix de enlace roto en Home, documentación de bugs pendientes)

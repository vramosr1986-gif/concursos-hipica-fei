# Plataforma FEI de Gestión de Concursos de Doma Clásica

Plataforma serverless completa para gestión de concursos de equitación (Doma Clásica) con tres paneles diferenciados: público, jueces y administración.

## 🎯 Características

### Panel Público
- Consulta de notas y resultados finales
- Clasificaciones por concurso
- Búsqueda de participantes

### Panel de Jueces
- Interfaz de puntuación FEI
- Evaluación de binomios asignados
- Criterios estandarizados
- Cálculo automático de desviación

### Panel de Administración
- Creación y gestión de concursos
- Planificación de jornadas (fecha, hora, pista)
- Importación de 67 reprises FEI
- Registro de binomios (jinete + caballo)
- Asignación de jueces con letras oficiales (A, B, C, etc.)
- Gestión completa de competencias

## 🛠️ Tecnologías

- **Frontend/Backend:** Next.js 15 + TypeScript
- **Base de Datos:** Supabase PostgreSQL
- **Autenticación:** Supabase Auth
- **Estilos:** Tailwind CSS
- **Hosting:** Vercel
- **API:** REST routes

## 📋 Requisitos Previos

- Node.js 18+ o Docker
- npm o yarn
- Cuenta en Supabase
- Cuenta en Vercel

## ⚙️ Instalación Local

### 1. Clonar/Descargar proyecto
```bash
cd "Curso sesrverless"
```

### 2. Instalar dependencias
```bash
npm install
```

### 3. Configurar variables de entorno

Crear archivo `.env.local`:
```env
NEXT_PUBLIC_SUPABASE_URL=tu_url_supabase
NEXT_PUBLIC_SUPABASE_ANON_KEY=tu_anon_key
SUPABASE_SERVICE_ROLE_KEY=tu_service_role_key
```

Para obtener estas claves:
1. Ir a https://app.supabase.com
2. Crear/seleccionar proyecto
3. Ir a Settings > API > Keys
4. Copiar URL y keys

### 4. Crear schema en Supabase

Ejecutar el archivo SQL en Supabase:
```bash
# Ir a Supabase Dashboard > SQL Editor
# Copiar y ejecutar: src/sql/001_create_schema.sql
```

### 5. Iniciar servidor desarrollo
```bash
npm run dev
```

Abrir http://localhost:3000

## 📦 Estructura de Carpetas

```
src/
├── app/              # Rutas y páginas Next.js
│   ├── api/          # API Routes
│   ├── admin/        # Panel administración
│   ├── juez/         # Panel jueces
│   ├── resultados/   # Panel público
│   ├── login/        # Autenticación
│   └── signup/       
├── components/       # Componentes React
├── lib/             # Utilidades y servicios
│   ├── supabase.ts  # Cliente Supabase
│   ├── services.ts  # Servicios CRUD
│   └── constants.ts # Datos FEI
├── types/           # Tipos TypeScript
└── sql/             # Migraciones SQL
```

## 🚀 Deployment en Vercel

### 1. Conectar repositorio
```bash
git init
git add .
git commit -m "Initial commit"
git push origin main
```

### 2. En Vercel
1. Ir a https://vercel.com
2. Conectar GitHub
3. Seleccionar repositorio
4. Configurar variables de entorno (mismas del .env.local)
5. Deploy

## 🔑 Autenticación y Roles

| Rol | Acceso | Funciones |
|-----|--------|-----------|
| **Admin** | Panel completo | Crear concursos, jornadas, reprises, binomios, jueces |
| **Juez** | Panel jueces | Puntuar binomios asignados |
| **Público** | Panel público | Ver resultados finales |

## 📊 API Endpoints

```
GET/POST   /api/concursos
GET/POST   /api/jornadas
GET/POST   /api/reprises
GET/POST   /api/binomios
GET/POST   /api/jueces
GET/POST   /api/puntuaciones
```

## 67 Reprises FEI

Las reprises están divididas por nivel:
- **Elemental:** Movimientos básicos
- **Medium:** Movimientos intermedios (piaffer, passage)
- **Advanced:** Movimientos avanzados (cambios de pie)
- **Grand Prix:** Nivel máximo

Para descargar el listado completo:
- https://www.fei.org/disciplines/dressage
- https://rfhe.es

## 🧮 Cálculo de Puntuaciones

Sistema FEI con:
- Puntuación de 0-10 por criterio
- Desviación estándar por reprise
- Multiplicador según nivel
- Promedio de jueces

## 📝 Próximas Fases

- [ ] Exportación de resultados (PDF/Excel)
- [ ] Sistema de notificaciones
- [ ] Ranking en tiempo real
- [ ] Gráficos de análisis
- [ ] Mobile app nativa
- [ ] Sincronización offline

## 📞 Soporte

Para dudas sobre:
- **Estructura FEI:** https://rfhe.es
- **Supabase:** https://supabase.com/docs
- **Next.js:** https://nextjs.org/docs
- **Vercel:** https://vercel.com/docs

## 📄 Licencia

Proyecto desarrollado para gestión de concursos FEI.

---

**Nota:** Este proyecto requiere estar registrado como oficial FEI para usar la estructura completa de reprises y criterios.

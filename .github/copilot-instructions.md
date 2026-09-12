# Instrucciones Copilot - Plataforma de Gestión de Concursos FEI

## Descripción del Proyecto
Plataforma serverless para gestión de concursos de doma clásica (equitación) con:
- **Frontend/Backend:** Next.js 15 + TypeScript
- **Base de datos:** Supabase PostgreSQL
- **Autenticación:** Supabase Auth (roles: admin, judge, public)
- **Deployment:** Vercel
- **Estilos:** Tailwind CSS

## ✅ Funcionalidades Completadas

### Estructura Base
- [x] Proyecto Next.js 15 con TypeScript
- [x] Configuración de Tailwind CSS
- [x] Tipos TypeScript completos
- [x] Estructura de carpetas modular

### Base de Datos
- [x] Schema SQL Supabase con todas las tablas
- [x] Row Level Security (RLS) configurado
- [x] Índices de optimización
- [x] Relaciones entre tablas

### Autenticación
- [x] Integración de Supabase Auth
- [x] Sistema multirole (admin, judge, public)
- [x] Páginas de login y signup
- [x] Navbar con gestión de sesiones

### Servicios
- [x] Cliente Supabase configurado
- [x] Servicios CRUD para todas las entidades
- [x] Constantes FEI (criterios, reprises básicas)
- [x] Letras de jueces oficiales

### Componentes
- [x] Navbar con autenticación
- [x] Card de concursos
- [x] Formulario de puntuación FEI
- [x] Estilos globales y utilitarios

### Páginas Implementadas
- [x] Página de inicio / Home
- [x] Login y Signup
- [x] Panel Público (Resultados)
- [x] Panel de Admin (Gestión de concursos)
- [x] Panel de Jueces (Listado de competencias)
- [x] Formulario para crear concursos

### Deployment
- [x] Configuración vercel.json
- [x] Variables de entorno documentadas
- [x] Preparado para Vercel

## 🚀 Próximas Tareas

### Fase 2: Funcionalidades Intermedias
- [ ] API Routes para endpoints REST
- [ ] Página de detalles de concurso
- [ ] Gestión de jornadas (CRUD)
- [ ] Asignación de reprises a jornadas
- [ ] Gestión de binomios
- [ ] Asignación de jueces

### Fase 3: Sistema de Puntuación
- [ ] Interfaz completa de puntuación
- [ ] Cálculo de desviación y multiplicador
- [ ] Visualización de resultados
- [ ] Ranking final de concurso
- [ ] Exportar resultados (PDF/Excel)

### Fase 4: Reprises FEI
- [ ] Descargar 67 reprises de RFHE
- [ ] Importar a base de datos
- [ ] Interfaz de selección de reprises
- [ ] Gestor de reprises personalizado

### Fase 5: Optimización
- [ ] Testing (Jest + React Testing Library)
- [ ] Optimización de renders
- [ ] Caching estratégico
- [ ] Validación de formularios
- [ ] Manejo de errores

## Equipo de Desarrollo
- Panel Público: Consulta notas de participantes
- Panel de Jueces: Puntuación de binomios con criterios FEI
- Panel Admin: Gestión completa de concursos, jornadas, reprises, binomios y jueces

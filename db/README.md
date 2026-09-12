# Reconstruccion de la Base de Datos

Este directorio contiene todos los scripts necesarios para **recrear la base de datos desde cero** en caso de desastre.

## Antes de empezar

**Los usuarios de Auth (vramosr1986@gmail.com, juez1@test.com, etc.) NO se pueden crear con SQL.** Deben existir previamente en Supabase Auth.

### Como crear los usuarios en Auth

1. Ve al panel de Supabase -> Authentication -> Users
2. Pulsa "Add user" -> "Create new user"
3. Crea uno a uno estos usuarios (marca "Auto Confirm User"):

| Email | Password | Rol |
|---|---|---|
| vramosr1986@gmail.com | 2ndLevel.1986! | admin |
| juez1@test.com | test1234 | juez |
| juez2@test.com | test1234 | juez |
| juez3@test.com | test1234 | juez |
| juez4@test.com | test1234 | juez |
| juez5@test.com | test1234 | juez |

## Recrear la base de datos

Una vez creados los usuarios en Auth, ejecuta:

    cd C:\Users\vramo\Documents\concursos-hipica-fei
    .\db\recrear_bd.ps1

El script pedira confirmacion escribiendo SI.

## Que hace el script?

Ejecuta estos archivos en orden:

| # | Archivo | Que hace |
|---|---|---|
| 00 | 00_limpiar_todo.sql | Borra TODAS las tablas y funciones |
| 01 | 01_estructura.sql | Crea las tablas |
| 02 | 02_funciones.sql | Crea is_admin(), is_staff(), etc. |
| 03 | 03_politicas_rls.sql | Crea las politicas RLS |
| 04 | 04_permisos.sql | Otorga permisos a anon/auth/service_role |
| 05 | 05_seed_usuarios.sql | Rellena profiles (lee de auth.users) |
| 06 | 06_seed_reprises.sql | 66 reprises + 1551 ejercicios |
| 07 | 07_seed_datos.sql | 12 binomios + 3 concursos + 18 inscripciones + 8 pruebas |
| 08 | 08_seed_participaciones.sql | 30 jueces asignados + 22 participaciones + 15 puntuaciones |

## Verificar que todo esta bien

Despues de ejecutar el script, verifica:

    supabase db query --linked "SELECT email, nombre, rol FROM profiles ORDER BY rol, email;"
    supabase db query --linked "SELECT COUNT(*) FROM reprises;"
    supabase db query --linked "SELECT COUNT(*) FROM ejercicios_reprise;"
    supabase db query --linked "SELECT COUNT(*) FROM puntuaciones;"

## Estructura esperada despues del seed

| Tabla | Total |
|---|---|
| profiles | 6 (1 admin + 5 jueces) |
| reprises | 66 |
| ejercicios_reprise | 1551 |
| binomios | 12 |
| concursos | 3 |
| inscripciones | 30 |
| pruebas | 8 |
| prueba_jueces | 30 |
| participaciones | 22 |
| puntuaciones | 15 |

## Advertencias

- Los usuarios de Auth NO se recrean con el script. Hay que crearlos a mano en el panel de Supabase.
- Los archivos db/ deben estar en Git para que no se pierdan.
- Las contrasenas de los usuarios estan en este README por comodidad, pero en produccion deben ir en un .env o gestor de secretos.

## Estructura de archivos

    db/
    |-- README.md                       <- Este archivo
    |-- recrear_bd.ps1                  <- Script maestro
    |-- 00_limpiar_todo.sql             <- Borra todo
    |-- 01_estructura.sql               <- Crea tablas
    |-- 02_funciones.sql                <- Crea funciones auxiliares
    |-- 03_politicas_rls.sql            <- Crea politicas RLS
    |-- 04_permisos.sql                 <- Otorga permisos
    |-- 05_seed_usuarios.sql            <- Rellena profiles
    |-- 06_seed_reprises.sql            <- 66 reprises + 1551 ejercicios
    |-- 07_seed_datos.sql               <- Binomios, concursos, pruebas
    |-- 08_seed_participaciones.sql     <- Jueces, participaciones, puntuaciones
    
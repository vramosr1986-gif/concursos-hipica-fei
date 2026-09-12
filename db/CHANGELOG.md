# Changelog - Base de Datos

Registro de cambios importantes en la estructura de la BD.

## 2026-09-12 - Cambios del dia

### Anadido
- Politicas RLS publicas para lectura de:
  - reprises, ejercicios_reprise
  - binomios, concursos, inscripciones
  - pruebas, prueba_jueces, participaciones, puntuaciones
- Funcion get_jueces_con_email() para joins con auth.users
- Tabla puntuaciones con FK a profiles (antes apuntaba a jueces vieja)
- Columna participacion_id en puntuaciones (antes competencia_id)

### Cambiado
- Modelo de datos completo:
  - OLD: jornadas -> jornada_reprises -> competencias
  - NEW: pruebas -> participaciones
- Los jueces ahora se asignan a PRUEBAS (prueba_jueces), no a concursos
- La categoria va en pruebas.categoria y inscripciones.categoria

### Eliminado
- Tablas obsoletas: jornadas, jornada_reprises, jornada_reprise_jueces, competencias, jueces
- Columnas duplicadas en binomios (concurso_id, dorsal, equipo, orden_salida)

### Datos actuales (2026-09-12)
- 6 usuarios (1 admin + 5 jueces)
- 66 reprises + 1551 ejercicios
- 12 binomios
- 3 concursos
- 30 inscripciones
- 8 pruebas
- 30 asignaciones de jueces a pruebas
- 22 participaciones
- 15 puntuaciones de ejemplo

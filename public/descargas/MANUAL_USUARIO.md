# Manual de Usuario — Concursos FEI

Guía completa para gestionar concursos de Doma Clásica según el reglamento de la RFHE.

## 📑 Índice

1. Acceso al sistema
2. Roles de usuario
3. Crear un concurso paso a paso
4. Sistema de categorías
5. Sistema de equipos
6. Puntuar como juez
7. Ver resultados
8. Preguntas frecuentes

## 🔐 Acceso al sistema

### Admin
1. Ve a `/login`
2. Email: el asignado (ej. `admin@concursosfei.com`)
3. Contraseña: la asignada

### Juez
1. Ve a `/login`
2. Email: el asignado (ej. `juez1@test.com`)
3. Contraseña: la asignada

El registro público está deshabilitado. Los usuarios nuevos se crean desde `/admin/usuarios` por un admin.

## 👥 Roles

| Rol | Puede hacer |
|---|---|
| Admin | Crear/editar concursos, jornadas, pruebas, binomios, equipos, jueces, usuarios |
| Juez | Ver sus pruebas asignadas y puntuar los binomios |
| Público | Ver resultados y clasificaciones (sin login) |

## 🏆 Crear un concurso paso a paso

### Paso 1 — Crear el concurso
1. Login como admin
2. Ve a `/admin/concursos`
3. Pulsa "+ Nuevo Concurso"
4. Rellena nombre, fechas, ubicación y organizador
5. Pulsa "Guardar Concurso"

### Paso 2 — Añadir jornadas
1. Entra en el concurso ("Editar")
2. Baja a "Jornadas"
3. Pulsa "+ Añadir Jornada"
4. Rellena fecha, pista, hora inicio y hora fin

Ejemplo:
- Sábado 15/03/2026 → Pista A → 09:00-18:00
- Domingo 16/03/2026 → Pista A → 09:00-14:00

### Paso 3 — Crear pruebas
1. Baja a "Pruebas del Concurso"
2. Pulsa "+ Añadir Prueba"
3. Rellena:
   - Nombre (ej. "Clásica 1 - Alevines")
   - Jornada
   - Nivel (N0, N1, ..., GP, KUR)
   - Categoría edad (se filtra según nivel)
   - Tipo de prueba (se filtra según nivel)
   - Reprise (se filtra según nivel)
   - Hora, pista, orden
4. Pulsa "Guardar Prueba"

IMPORTANTE: Al elegir el Nivel, el sistema filtra automáticamente las categorías y tipos compatibles.

### Paso 4 — Crear binomios
1. Ve a `/admin/binomios`
2. Pulsa "+ Nuevo Binomio"
3. Rellena datos del jinete y del caballo
4. Las categorías se calculan automáticamente

Ejemplo:
- Jinete: Laura Gómez · Fecha nac: 15/03/2010
- Caballo: Bandolero · Año nac: 2016
- → Categoría calculada: JUVENIL

### Paso 5 — Inscribir binomios
1. Vuelve al concurso ("Editar")
2. Baja a "Inscripciones"
3. Pulsa "+ Añadir Inscripción"
4. Elige binomio, dorsal y categoría

Aviso de coherencia: Si eliges una categoría distinta a la sugerida, el sistema te avisa.

### Paso 6 — Asignar jueces
1. Entra en una prueba
2. En "Jueces asignados", pulsa "+ Añadir Juez"
3. Elige juez y letra oficial (A, B, C, D, E)

### Paso 7 — Inscribir binomios a pruebas
1. En la página de la prueba, baja a "Binomios participantes"
2. Pulsa "+ Añadir Binomio"
3. Elige binomio y orden de salida

## 📊 Sistema de categorías

Las categorías se calculan automáticamente.

### Categorías de jinete

| Categoría | Edad |
|---|---|
| Benjamines | ≤ 12 años |
| Alevines | ≤ 12 años (oficial) |
| Infantiles | 13-14 años |
| Juveniles 0* | 14-15 años |
| Juveniles | 16-17 años |
| Jóvenes Jinetes | 18-21 años |
| Adultos | 22+ años |

### Categorías de caballo joven

| Categoría | Edad |
|---|---|
| CJ4 | 4 años |
| CJ5 | 5 años |
| CJ6 | 6 años |
| CJ7 | 7 años |
| CJ8_10 | 8-10 años |
| CABALLO_ADULTO | 11+ años |

Categoría principal: siempre la del jinete (excepto en Caballos Jóvenes).

## 🏆 Sistema de equipos

### Crear un equipo
1. En el concurso, baja a "Equipos del Concurso"
2. Pulsa "+ Nuevo Equipo"
3. Rellena nombre, club y categoría (opcional)

### Añadir miembros
1. En el equipo, pulsa "+ Añadir miembro"
2. Elige una inscripción del concurso
3. Pulsa "Añadir"

Regla: cada binomio puede estar en un solo equipo del mismo concurso.

### Clasificación de equipos
Se calcula con la media de los 3 mejores porcentajes de cada equipo.

Ejemplo:
- Andalucía: Laura 75.89% · Juan 74.10% · María 68.90% · Pedro 67.00%
- Media de los 3 mejores: (75.89 + 74.10 + 68.90) / 3 = 72.96%

## ⚖️ Puntuar como juez

### Ver pruebas asignadas
1. Login como juez
2. Ve a `/juez`

### Puntuar
1. Pulsa "Puntuar" en una prueba
2. Si es prueba de equipos, verás pestañas por equipo
3. Dentro de cada equipo, pestañas por miembro
4. Selecciona un miembro
5. Puntúa cada ejercicio con nota 0-10
6. Las notas se guardan automáticamente

### Estados de guardado
- Gris: sin puntuar
- Amarillo: guardando
- Verde: guardado
- Rojo: error

## 📈 Ver resultados

1. Ve a `/resultados`
2. Selecciona un concurso
3. Filtra por categoría
4. Ordena por media, dorsal o jinete

### Pestañas
- Individual: clasificación por binomio con columnas por juez
- Equipos: clasificación por equipo (media de los 3 mejores)

### Auto-update
El panel se actualiza automáticamente cuando un juez guarda una nota (Supabase Realtime).

### Ver detalle
Pulsa "Ver detalle" en cualquier binomio para ver los ejercicios y las notas por juez.

## ❓ FAQ

### ¿Cómo cambio la contraseña?
Habla con el administrador.

### ¿Puedo crear varias pruebas el mismo día?
Sí. El sistema permite múltiples pruebas en la misma jornada.

### ¿Qué pasa si me equivoco al puntuar?
Puedes editar cualquier nota. Los cambios se guardan automáticamente.

### ¿Cómo hago un backup de la BBDD?
Ejecuta: `.\scripts\backup_bbdd.ps1`

### ¿Cómo restauro un backup?
Ejecuta: `.\scripts\restore_bbdd.ps1 -BackupZip ".\backups\backup_XXXX.zip"`

### ¿Los resultados se actualizan en tiempo real?
Sí. El panel usa Supabase Realtime.

## 🔗 Enlaces útiles

- RFHE: https://rfhe.com
- Reglamento: https://rfhe.com/informacion-rfhe/estatutos-reglamentos-normativa-general/
- FEI: https://www.fei.org

---

Última actualización: Septiembre 2026
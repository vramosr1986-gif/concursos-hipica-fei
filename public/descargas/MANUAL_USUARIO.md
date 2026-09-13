# Manual de Usuario - Concursos FEI

Guia completa para gestionar concursos de Doma Clasica segun el reglamento de la RFHE.

## Indice

1. Introduccion
2. Roles de usuario
3. Crear un concurso paso a paso
4. Sistema de categorias
5. Combinaciones posibles
6. Sistema de binomios
7. Sistema de equipos
8. Puntuar como juez
9. Ver resultados
10. FAQ

---

## 1. Introduccion

Esta plataforma gestiona concursos de Doma Clasica segun el reglamento oficial de la RFHE.

Hay tres paneles:

- Panel publico (/resultados): ver clasificaciones
- Panel del juez (/juez): puntuar pruebas asignadas
- Panel admin (/admin): gestionar todo

## 2. Roles

| Rol | Puede hacer |
|---|---|
| Admin | Crear/editar concursos, jornadas, pruebas, binomios, equipos, jueces, usuarios |
| Juez | Ver sus pruebas asignadas y puntuar los binomios |
| Publico | Ver resultados y clasificaciones |

## 3. Crear un concurso paso a paso

### Paso 1 - Crear el concurso
1. Login como admin
2. Ve a /admin/concursos
3. Pulsa "+ Nuevo Concurso"
4. Rellena nombre, fechas, ubicacion, organizador

### Paso 2 - Anadir jornadas
Las jornadas son los dias del concurso (sabado, domingo).

1. Entra en el concurso
2. Baja a "Jornadas"
3. Pulsa "+ Anadir Jornada"
4. Rellena fecha, pista, hora inicio y fin

Ejemplo:
- Sabado 15/03/2026 - Pista A - 09:00-18:00
- Domingo 16/03/2026 - Pista A - 09:00-14:00

### Paso 3 - Crear pruebas
1. Baja a "Pruebas del Concurso"
2. Pulsa "+ Anadir Prueba"
3. Rellena los campos (ver seccion de combinaciones)

### Paso 4 - Crear binomios
1. Ve a /admin/binomios
2. Pulsa "+ Nuevo Binomio"
3. Rellena los datos (ver seccion de binomios)

### Paso 5 - Inscribir binomios
1. Vuelve al concurso
2. Baja a "Inscripciones"
3. Pulsa "+ Anadir Inscripcion"
4. Elige binomio, dorsal y categoria

### Paso 6 - Crear equipos
1. Baja a "Equipos"
2. Pulsa "+ Nuevo Equipo"
3. Anade miembros

### Paso 7 - Asignar jueces
1. Entra en una prueba
2. Pulsa "+ Anadir Juez"
3. Elige juez y letra (A-E)

### Paso 8 - Inscribir binomios a pruebas
1. En la prueba, baja a "Binomios participantes"
2. Pulsa "+ Anadir Binomio"

## 4. Sistema de categorias

Cada binomio (jinete + caballo) tiene 3 categorias calculadas automaticamente.

### 4.1 Categoria del jinete (por edad)

| Categoria | Edad |
|---|---|
| Benjamines | Hasta 11 anos |
| Alevines | Hasta 12 anos |
| Infantiles | 13 a 14 anos |
| Juveniles 0* | 14 a 15 anos |
| Juveniles | 16 a 17 anos |
| Jovenes Jinetes | 18 a 21 anos |
| Adultos | 22 anos o mas |

Nota: se usa el ano en que cumple la edad, no la fecha exacta.

### 4.2 Categoria del caballo (por edad)

| Categoria | Edad |
|---|---|
| CJ4 | 4 anos |
| CJ5 | 5 anos |
| CJ6 | 6 anos |
| CJ7 | 7 anos |
| CJ8_10 | 8 a 10 anos |
| CABALLO_ADULTO | 11 anos o mas |

Los caballos de 4 a 10 anos son "Caballos Jovenes".

### 4.3 Categoria principal (la que manda en las pruebas)

| Caso | Categoria principal |
|---|---|
| Caballo joven (4-10 anos) | La del caballo (CJ4, CJ5, ..., CJ8_10) |
| Caballo adulto (11+ anos) | La del jinete (Alevin, Infantil, Juvenil, etc.) |

Regla de oro: si el caballo es joven, manda la edad del caballo. Si el caballo es adulto, manda la edad del jinete.

### 4.4 Ejemplos practicos

Ejemplo 1: Jinete joven + caballo joven
- Jinete: Laura (14 anos) -> INFANTIL
- Caballo: Bandolero (6 anos) -> CJ6
- Categoria principal: CJ6 (manda el caballo joven)

Ejemplo 2: Jinete adulto + caballo joven
- Jinete: Carlos (30 anos) -> ADULTO
- Caballo: Relampago (8 anos) -> CJ8_10
- Categoria principal: CJ8_10 (manda el caballo joven)

Ejemplo 3: Jinete joven + caballo adulto
- Jinete: Maria (16 anos) -> JUVENIL
- Caballo: Luna (12 anos) -> CABALLO_ADULTO
- Categoria principal: JUVENIL (manda el jinete)

Ejemplo 4: Jinete adulto + caballo adulto
- Jinete: Pedro (40 anos) -> ADULTO
- Caballo: Trueno (15 anos) -> CABALLO_ADULTO
- Categoria principal: ADULTO (manda el jinete)

## 5. Combinaciones posibles

Cada prueba combina 3 elementos:

- Nivel (dificultad de la reprise)
- Categoria de edad (jinete o caballo joven)
- Tipo de prueba (Individual, Equipos, Kur, etc.)

No se pueden combinar libremente: el sistema filtra automaticamente las categorias y tipos compatibles con cada nivel.

### 5.1 Tabla oficial de combinaciones

| Nivel | Nombre | Categorias permitidas | Tipos permitidos |
|---|---|---|---|
| N0 | Acceso | Benjamines, Alevines | Preliminar, Individual, AP |
| N1 | Iniciacion | Alevines | Preliminar, Equipos, Individual, Final |
| N2 | Elemental | Infantiles, CJ5 | Preliminar, Equipos, Individual, Final |
| N3 | Basico | Juveniles 0*, Ponis | Preliminar, Equipos, Individual |
| N4 | Medio | Juveniles, Juniors, CJ6 | Preliminar, Equipos, Individual, Final |
| SJ | San Jorge | Jovenes Jinetes, CJ7, Veteranos | Preliminar, Equipos, Individual, Final |
| INT_I | Intermedia I | Adultos, Jovenes Jinetes, Veteranos | Individual |
| INT_II | Intermedia II | Adultos | Individual |
| GP | Gran Premio | Adultos, CJ8_10 | Individual |
| KUR | Estilo libre | Todas | Kur |

### 5.2 Como funciona el filtrado en la practica

Al crear una prueba, solo eliges el Nivel y el sistema te muestra solo las opciones compatibles.

Ejemplo - Creas una prueba de Nivel N1:
- Categorias disponibles: Alevines (unica)
- Tipos disponibles: Preliminar, Equipos, Individual, Final
- No puedes elegir "Kur" (Kur solo esta en KUR)
- No puedes elegir "CJ6" (CJ6 no esta en N1)

Ejemplo - Creas una prueba de Nivel GP:
- Categorias disponibles: Adultos y CJ8_10
- Tipos disponibles: solo Individual
- No puedes elegir "Equipos"

### 5.3 Casos especiales

Kur (KUR): permite cualquier categoria porque puede haber Kur de Ponis, Juveniles, Jovenes Jinetes, Intermedia I, Gran Premio, etc. Pero solo permite el tipo Kur.

Veteranos: algunos niveles (SJ, INT_I) admiten esta categoria especial para jinetes de +45 anos.

Rider: prueba de formacion, se usa con N0 y N1.

## 6. Sistema de binomios

Un binomio es una pareja jinete + caballo.

### 6.1 Registro de un binomio

Ruta: /admin/binomios -> "+ Nuevo Binomio"

| Campo | Obligatorio | Para que sirve |
|---|---|---|
| Nombre del jinete | Si | Identificacion |
| Fecha de nacimiento del jinete | Si | Calcular categoria del jinete |
| Nombre del caballo | Si | Identificacion |
| Ano de nacimiento del caballo | Si | Calcular categoria del caballo |
| Licencia federativa | No | Identificacion oficial |

### 6.2 Categorias automaticas

Al guardar el binomio, el sistema calcula 3 categorias:

- Categoria del jinete: ALEVIN, INFANTIL, JUVENIL, etc.
- Categoria del caballo: CJ4, CJ5, ..., CABALLO_ADULTO
- Categoria principal: la que manda

### 6.3 Ejemplo completo

Jinete: Laura Gomez
- Fecha nac.: 15/03/2012
- Edad en 2026: 14 anos -> INFANTIL

Caballo: Bandolero
- Ano nac.: 2018
- Edad en 2026: 8 anos -> CJ8_10

Categoria principal: CJ8_10 (manda el caballo joven)

### 6.4 Listado de binomios

En /admin/binomios se muestra una tabla con:

| Columna | Significado |
|---|---|
| Jinete | Nombre del jinete |
| Caballo | Nombre del caballo |
| Edad jinete | Anos cumplidos |
| Cat. jinete | Categoria calculada |
| Edad caballo | Anos cumplidos |
| Cat. caballo | Categoria calculada |
| Categoria principal | La que manda |
| Licencia | Numero de licencia |

### 6.5 Inscripcion al concurso

Un binomio del catalogo se inscribe a un concurso con:

- Dorsal: numero unico en el concurso
- Categoria: se preselecciona la sugerida (la principal)
- Equipo (opcional)

Aviso de coherencia: si eliges una categoria distinta a la sugerida, el sistema te avisa.

Ejemplo:
- Binomio: Laura (INFANTIL) + Bandolero (CJ8_10)
- Categoria sugerida: CJ8_10
- Puedes cambiarla a INFANTIL si es una prueba especifica

## 7. Sistema de equipos

Un equipo agrupa varios binomios (tipicamente 3-4) que compiten juntos.

### 7.1 Crear un equipo

Ruta: /admin/concursos/[id] -> "Equipos del Concurso"

| Campo | Descripcion |
|---|---|
| Nombre | Ej. "Andalucia" |
| Club | Opcional |
| Categoria edad | Opcional |

### 7.2 Anadir miembros

1. Pulsa "+ Anadir miembro"
2. Elige una inscripcion del concurso (no del catalogo de binomios)
3. Pulsa "Anadir"

Importante: los miembros son inscripciones (binomio + dorsal en este concurso), no binomios sueltos.

### 7.3 Reglas de equipos

| Regla | Detalle |
|---|---|
| Un binomio -> un equipo | Un binomio no puede estar en 2 equipos del mismo concurso |
| Minimo 3 miembros | Un equipo necesita al menos 3 |
| Maximo 4 miembros | Lo habitual es 4 |
| Cuentan 3 mejores | En clasificacion solo suman los 3 mejores |

### 7.4 Clasificacion por equipos

La clasificacion por equipos se calcula con la media de los 3 mejores porcentajes de cada equipo.

Formula:

    puntuacion_equipo = (mejor1 + mejor2 + mejor3) / 3

Ejemplo:

Equipo Andalucia (4 miembros):
- Laura / Bandolero -> 75.89%
- Juan / Rayo -> 74.10%
- Maria / Luna -> 68.90%
- Pedro / Trueno -> 67.00% (no cuenta)

Clasificacion Andalucia:

    (75.89 + 74.10 + 68.90) / 3 = 72.96%

Si el equipo tiene solo 3 miembros: se suman los 3 y se divide entre 3.

Si el equipo tiene 2 miembros: se suman los 2 y se divide entre 2.

### 7.5 Pruebas de equipos

Una prueba es "de equipos" si tiene al menos una participacion con equipo asignado.

Deteccion automatica: no hay un checkbox manual. Si hay participaciones con equipo, el sistema lo detecta.

En el panel de resultados aparece la pestana "Equipos" automaticamente.

### 7.6 Como puntuar equipos

Importante: los jueces NO puntuan al equipo. Puntuan a cada binomio individualmente.

- Cada miembro del equipo se puntua como cualquier otro binomio
- El sistema suma las notas de los 3 mejores
- El equipo tiene su propia clasificacion

En el panel del juez:
1. Al entrar a una prueba de equipos, veras pestanas por equipo (Andalucia, Madrid)
2. Dentro de cada equipo, veras pestanas por miembro
3. Puntua a cada miembro individualmente

### 7.7 Crear equipos: caso practico

Escenario: Concurso con prueba de equipos de Alevines.

Paso 1 - Inscribe los binomios al concurso:
- Laura / Bandolero (dorsal 1) -> categoria ALEVIN
- Juan / Rayo (dorsal 2) -> categoria ALEVIN
- Maria / Luna (dorsal 3) -> categoria ALEVIN
- Pedro / Trueno (dorsal 4) -> categoria ALEVIN

Paso 2 - Crea el equipo "Andalucia":
- Pulsa "+ Nuevo Equipo"
- Nombre: Andalucia
- Anade miembros: Laura, Juan, Maria, Pedro

Paso 3 - Crea la prueba "Alevines Equipos" (Nivel N1):
- Nombre: Alevines Equipos
- Nivel: N1
- Categoria: ALEVIN
- Tipo: Equipos
- Reprise: Alevines Equipos

Paso 4 - Inscribe binomios a la prueba:
- Al anadir a Laura, el sistema detecta que esta en Andalucia y guarda equipo_id

Paso 5 - Asigna jueces y puntuan.

Paso 6 - Ver resultados:
- Pestana Individual: clasificacion por binomio
- Pestana Equipos: clasificacion por equipo (media de los 3 mejores)

## 8. Puntuar como juez

### 8.1 Ver pruebas asignadas

1. Login como juez
2. Ve a /juez

### 8.2 Puntuar

1. Pulsa "Puntuar" en una prueba
2. Si es prueba de equipos, veras pestanas por equipo
3. Dentro, pestanas por miembro
4. Puntua cada ejercicio (0-10)
5. Las notas se guardan automaticamente

### 8.3 Escala FEI

| Nota | Significado |
|---|---|
| 10 | Excelente |
| 9 | Muy bien |
| 8 | Bien |
| 7 | Bastante bien |
| 6 | Satisfactorio |
| 5 | Marginal |
| 4 | Insuficiente |
| 3 | Bastante mal |
| 2 | Mal |
| 1 | Muy mal |
| 0 | No ejecutado |

## 9. Ver resultados

Ruta: /resultados

### 9.1 Filtros

- Concurso
- Categoria
- Ordenacion (Media / Dorsal / Jinete)

### 9.2 Pestanas

- Individual: clasificacion por binomio con columnas por juez
- Equipos: clasificacion por equipo (media de los 3 mejores)

### 9.3 Auto-update

El panel se actualiza en tiempo real cuando un juez guarda una nota.

### 9.4 Ver detalle

Pulsa "Ver detalle" para ver los ejercicios con las notas de cada juez.

## 10. FAQ

### Como cambio la contrasena?
Habla con el administrador.

### Puedo crear varias pruebas el mismo dia?
Si. El sistema permite multiples pruebas en la misma jornada con diferentes categorias, niveles y tipos.

### Que pasa si me equivoco al puntuar?
Puedes editar cualquier nota. Se guarda automaticamente.

### Como se que categoria tiene un binomio?
Ve a /admin/binomios y veras las 3 categorias calculadas.

### Como hago un backup?
Ejecuta en PowerShell: .\scripts\backup_bbdd.ps1

### Los resultados son en tiempo real?
Si, con Supabase Realtime.

### Un binomio puede estar en 2 equipos?
No. Un binomio pertenece a un solo equipo por concurso.

### Que pasa si un equipo tiene 4 miembros?
Solo cuentan los 3 mejores. El peor no se suma.

### Puedo cambiar la categoria de una inscripcion?
Si. Al inscribir, el sistema te avisa si la cambias de la sugerida.

---

Ultima actualizacion: Septiembre 2026
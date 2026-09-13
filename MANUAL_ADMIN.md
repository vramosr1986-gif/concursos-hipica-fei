# Manual para Administradores - Concursos FEI

## Indice

1. Acceso
2. Crear un concurso
3. Anadir jornadas
4. Crear pruebas (con combinaciones validas)
5. Registrar binomios
6. Inscribir binomios al concurso
7. Crear equipos
8. Asignar jueces
9. Inscribir binomios a pruebas
10. Gestionar usuarios
11. Ver resultados
12. Backup y restore
13. Reglas de negocio
14. FAQ

## 1. Acceso

1. Ve a /login
2. Introduce tu email y contrasena
3. Solo los usuarios con rol admin pueden acceder al panel /admin

## 2. Crear un concurso

Ruta: /admin/concursos/nuevo

Campos obligatorios:
- Nombre (ej. "Primavera 2026")
- Fecha inicio
- Fecha fin

Campos opcionales:
- Ubicacion
- Organizador

## 3. Anadir jornadas

Ruta: /admin/concursos/[id] seccion Jornadas

Cada jornada es un dia del concurso.

1. Pulsa "+ Anadir Jornada"
2. Rellena:
   - Fecha (dentro del rango)
   - Pista (ej. "Pista A")
   - Hora inicio
   - Hora fin

Ejemplo:
- Sabado 15/03/2026 - Pista A - 09:00-18:00
- Domingo 16/03/2026 - Pista A - 09:00-14:00

## 4. Crear pruebas

Ruta: /admin/concursos/[id] seccion Pruebas del Concurso

Campos:
- Nombre
- Jornada
- Nivel (N0, N1, ..., GP, KUR)
- Categoria edad (se filtra segun nivel)
- Tipo de prueba (se filtra segun nivel)
- Reprise (se filtra segun nivel)

### Validacion automatica

| Nivel | Categorias | Tipos |
|---|---|---|
| N0 | Benjamines, Alevines | Preliminar, Individual, AP |
| N1 | Alevines | Preliminar, Equipos, Individual, Final |
| N2 | Infantiles, CJ5 | Preliminar, Equipos, Individual, Final |
| N3 | Juveniles 0*, Ponis | Preliminar, Equipos, Individual |
| N4 | Juveniles, Juniors, CJ6 | Preliminar, Equipos, Individual, Final |
| SJ | Jovenes Jinetes, CJ7, Veteranos | Preliminar, Equipos, Individual, Final |
| INT_I | Adultos, Jovenes Jinetes, Veteranos | Individual |
| INT_II | Adultos | Individual |
| GP | Adultos, CJ8_10 | Individual |
| KUR | Todas | Kur |

## 5. Registrar binomios

Ruta: /admin/binomios

1. Pulsa "+ Nuevo Binomio"
2. Rellena:
   - Nombre del jinete
   - Fecha nac. jinete
   - Nombre del caballo
   - Ano nac. caballo
   - Licencia (opcional)

### Categorias automaticas

Jinete (por edad):
- Hasta 11: Benjamines
- Hasta 12: Alevines
- 13-14: Infantiles
- 14-15: Juveniles 0*
- 16-17: Juveniles
- 18-21: Jovenes Jinetes
- 22+: Adultos

Caballo (por edad):
- 4 anos: CJ4
- 5 anos: CJ5
- 6 anos: CJ6
- 7 anos: CJ7
- 8-10 anos: CJ8_10
- 11+ anos: CABALLO_ADULTO

Categoria principal:
- Caballo joven: manda la del caballo
- Caballo adulto: manda la del jinete

## 6. Inscribir binomios

Ruta: /admin/concursos/[id] seccion Inscripciones

1. Pulsa "+ Anadir Inscripcion"
2. Elige binomio, dorsal y categoria
3. Guardar

Aviso de coherencia si cambias la categoria.

## 7. Crear equipos

Ruta: /admin/concursos/[id] seccion Equipos

1. Pulsa "+ Nuevo Equipo"
2. Rellena nombre, club, categoria
3. Anade miembros con "+ Anadir miembro"

Reglas:
- Un binomio -> un equipo por concurso
- 3-4 miembros
- Cuentan los 3 mejores

Clasificacion: (mejor1 + mejor2 + mejor3) / 3

## 8. Asignar jueces

Ruta: /admin/concursos/[id]/pruebas/[pruebaId]

1. Pulsa "+ Anadir Juez"
2. Elige juez y letra (A-E)

Reglas:
- Minimo 3 jueces por prueba
- Letra unica por juez

## 9. Inscribir binomios a pruebas

Ruta: /admin/concursos/[id]/pruebas/[pruebaId]

1. Pulsa "+ Anadir Binomio"
2. Elige binomio y orden

Filtros automaticos por categoria.

Si el binomio esta en un equipo, se guarda equipo_id.

## 10. Gestionar usuarios

Ruta: /admin/usuarios

1. Pulsa "+ Nuevo Usuario"
2. Rellena email, contrasena, nombre, rol
3. Crear

Roles:
- Admin: acceso completo
- Juez: solo sus pruebas

## 11. Ver resultados

Ruta: /resultados

Filtros: Concurso, Categoria, Ordenacion

Pestanas:
- Individual: clasificacion por binomio
- Equipos: clasificacion por equipo

Auto-update: tiempo real.

Indicador EN VIVO si hay prueba en curso.

## 12. Backup y restore

Hacer backup:
.\scripts\backup_bbdd.ps1

Listar:
.\scripts\listar_backups.ps1

Restaurar:
.\scripts\restore_bbdd.ps1 -BackupZip ".\backups\backup_XXXX.zip"

## 13. Reglas de negocio

### Categorias jinete
- Hasta 11: BENJAMIN
- Hasta 12: ALEVIN
- 13-14: INFANTIL
- 14-15: JUVENIL_0
- 16-17: JUVENIL
- 18-21: JOVEN_JINETE
- 22+: ADULTO

### Categorias caballo
- 4: CJ4, 5: CJ5, 6: CJ6, 7: CJ7
- 8-10: CJ8_10
- 11+: CABALLO_ADULTO

### Tipos de prueba
- PRE: Preliminar
- EQU: Equipos (coef 1.5)
- IND: Individual
- FIN: Final
- EXP: Experimental
- KUR: Kur
- AP: Asiento y Posicion

## 14. FAQ

### Como anado un concurso?
/admin/concursos/nuevo

### Como cambio la contrasena de un juez?
Eliminalo y crea uno nuevo en /admin/usuarios

### Por que no puedo crear una prueba?
Verifica: fecha dentro del rango, nivel elegido, categoria y tipo compatibles

### Los jueces pueden ver otros concursos?
No. Solo ven sus pruebas

### Que pasa si un equipo tiene 4 miembros?
Solo cuentan los 3 mejores

### Como se si una prueba es de equipos?
Si tiene al menos un binomio con equipo. Deteccion automatica.

### Que es el coeficiente?
Multiplicador. Equipos: 1.5. Resto: 1.0

---

Ultima actualizacion: Septiembre 2026
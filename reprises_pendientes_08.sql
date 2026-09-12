-- ============================================
-- KÜR INTERMEDIA I 2022
-- ============================================
INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('72', 'Kür Intermedia I', 'RFHE-2022-KUR-INT-I', 'Kür', 'Intermedia I', 'kur', 2022, '4''30" a 5''00"', 7, 400, 'KÜR INTERMEDIA I 2022', 'Reprise libre con musica Intermedia I', 1, 0, 'RFHE-2022-KUR-INT-I');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-INT-I'), 1, 'T1', 'Paso reunido (minimo 20 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-INT-I'), 2, 'T2', 'Paso largo (minimo 20 m)', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-INT-I'), 3, 'T3', 'Espalda adentro a la derecha (trote reunido) (minimo 12 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-INT-I'), 4, 'T4', 'Espalda adentro a la izquierda (trote reunido) (minimo 12 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-INT-I'), 5, 'T5', 'Apoyo a la derecha (trote reunido)', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-INT-I'), 6, 'T6', 'Apoyo a la izquierda (trote reunido)', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-INT-I'), 7, 'T7', 'Trote largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-INT-I'), 8, 'T8', 'Apoyo a la derecha (galope reunido)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-INT-I'), 9, 'T9', 'Apoyo a la izquierda (galope reunido)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-INT-I'), 10, 'T10', 'Galope largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-INT-I'), 11, 'T11', 'Cambios de pie en el aire cada 3 trancos (minimo 5 cambios consecutivos)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-INT-I'), 12, 'T12', 'Cambios de pie en el aire cada 2 trancos (minimo 5 cambios consecutivos)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-INT-I'), 13, 'T13', 'Pirueta a galope a la derecha', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-INT-I'), 14, 'T14', 'Pirueta a galope a la izquierda', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-INT-I'), 15, 'T15', 'La entrada y las paradas al principio y al final de la reprise', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-INT-I'), 101, 'A1', 'Ritmo, energia y elasticidad', 4, 'nota_artistica'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-INT-I'), 102, 'A2', 'Armonia entre jinete y caballo', 4, 'nota_artistica'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-INT-I'), 103, 'A3', 'Coreografia. Utilizacion de la pista. Creatividad', 4, 'nota_artistica'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-INT-I'), 104, 'A4', 'Grado de dificultad. Riesgo calculado', 4, 'nota_artistica'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-INT-I'), 105, 'A5', 'Interpretacion de la musica', 4, 'nota_artistica');

-- ============================================
-- KÜR JOVENES JINETES 2022
-- ============================================
INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('73', 'Kür Jovenes Jinetes', 'RFHE-2022-KUR-JJ', 'Kür', 'Jovenes Jinetes', 'kur', 2022, '4''30" a 5''00"', 7, 400, 'KÜR JOVENES JINETES 2022', 'Reprise libre con musica Jovenes Jinetes', 1, 0, 'RFHE-2022-KUR-JJ');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JJ'), 1, 'T1', 'Paso reunido (minimo 20 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JJ'), 2, 'T2', 'Paso largo (minimo 20 m)', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JJ'), 3, 'T3', 'Espalda adentro a la derecha (trote reunido) (minimo 12 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JJ'), 4, 'T4', 'Espalda adentro a la izquierda (trote reunido) (minimo 12 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JJ'), 5, 'T5', 'Apoyo a la derecha (trote reunido)', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JJ'), 6, 'T6', 'Apoyo a la izquierda (trote reunido)', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JJ'), 7, 'T7', 'Trote largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JJ'), 8, 'T8', 'Apoyo a la derecha (galope reunido)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JJ'), 9, 'T9', 'Apoyo a la izquierda (galope reunido)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JJ'), 10, 'T10', 'Galope largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JJ'), 11, 'T11', 'Cambios de pie en el aire cada 4 trancos (minimo 5 cambios consecutivos)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JJ'), 12, 'T12', 'Cambios de pie en el aire cada 3 trancos (minimo 5 cambios consecutivos)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JJ'), 13, 'T13', 'Media pirueta a galope a la derecha', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JJ'), 14, 'T14', 'Media pirueta a galope a la izquierda', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JJ'), 15, 'T15', 'La entrada y las paradas al principio y al final de la reprise', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JJ'), 101, 'A1', 'Ritmo, energia y elasticidad', 4, 'nota_artistica'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JJ'), 102, 'A2', 'Armonia entre jinete y caballo', 4, 'nota_artistica'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JJ'), 103, 'A3', 'Coreografia. Utilizacion de la pista. Creatividad', 4, 'nota_artistica'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JJ'), 104, 'A4', 'Grado de dificultad. Riesgo calculado', 4, 'nota_artistica'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JJ'), 105, 'A5', 'Interpretacion de la musica', 4, 'nota_artistica');

-- ============================================
-- KÜR JUVENILES 0* 2022
-- ============================================
INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('74', 'Kür Juveniles 0*', 'RFHE-2022-KUR-JUV0', 'Kür', 'Juveniles 0*', 'kur', 2022, '4''30" a 5''00"', 6, 420, 'KÜR JUVENILES 0* 2022', 'Reprise libre con musica Juveniles 0*', 1, 0, 'RFHE-2022-KUR-JUV0');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JUV0'), 1, 'T1', 'Paso reunido (minimo 20 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JUV0'), 2, 'T2', 'Paso largo (minimo 20 m)', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JUV0'), 3, 'T3', 'Media pirueta a la derecha y/o a la izquierda al paso reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JUV0'), 4, 'T4', 'Espalda adentro a la derecha (trote reunido) (minimo 12 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JUV0'), 5, 'T5', 'Espalda adentro a la izquierda (trote reunido) (minimo 12 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JUV0'), 6, 'T6', 'Grupa adentro a la derecha (trote reunido) (minimo 12 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JUV0'), 7, 'T7', 'Grupa adentro a la izquierda (trote reunido) (minimo 12 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JUV0'), 8, 'T8', 'Apoyo a la derecha (trote reunido)', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JUV0'), 9, 'T9', 'Apoyo a la izquierda (trote reunido)', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JUV0'), 10, 'T10', 'Trote largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JUV0'), 11, 'T11', 'Galope en trocado a mano derecha (minimo 20 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JUV0'), 12, 'T12', 'Galope en trocado a mano izquierda (minimo 20 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JUV0'), 13, 'T13', 'Cambio de pie simple -con pasos intermedios- de izquierda a derecha', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JUV0'), 14, 'T14', 'Cambio de pie simple -con pasos intermedios- de derecha a izquierda', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JUV0'), 15, 'T15', 'Galope reunido incluyendo vuelta de 8 m de diametro a la izquierda y/o derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JUV0'), 16, 'T16', 'Galope largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JUV0'), 17, 'T17', 'La entrada y las paradas al principio y al final de la reprise', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JUV0'), 101, 'A1', 'Ritmo, energia y elasticidad', 4, 'nota_artistica'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JUV0'), 102, 'A2', 'Armonia entre jinete y caballo', 4, 'nota_artistica'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JUV0'), 103, 'A3', 'Coreografia. Utilizacion de la pista. Creatividad', 4, 'nota_artistica'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JUV0'), 104, 'A4', 'Grado de dificultad. Riesgo calculado', 4, 'nota_artistica'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JUV0'), 105, 'A5', 'Interpretacion de la musica', 4, 'nota_artistica');

-- ============================================
-- KÜR JUVENILES 2022
-- ============================================
INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('75', 'Kür Juveniles', 'RFHE-2022-KUR-JUV', 'Kür', 'Juveniles', 'kur', 2022, '4''30" a 5''00"', 6, 400, 'KÜR JUVENILES 2022', 'Reprise libre con musica Juveniles', 1, 0, 'RFHE-2022-KUR-JUV');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JUV'), 1, 'T1', 'Paso reunido (minimo 20 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JUV'), 2, 'T2', 'Media pirueta a la derecha y/o a la izquierda al paso reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JUV'), 3, 'T3', 'Paso largo (minimo 20 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JUV'), 4, 'T4', 'Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JUV'), 5, 'T5', 'Espalda adentro a la derecha (trote reunido) (minimo 12 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JUV'), 6, 'T6', 'Espalda adentro a la izquierda (trote reunido) (minimo 12 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JUV'), 7, 'T7', 'Apoyo a la derecha (trote reunido)', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JUV'), 8, 'T8', 'Apoyo a la izquierda (trote reunido)', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JUV'), 9, 'T9', 'Trote largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JUV'), 10, 'T10', 'Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JUV'), 11, 'T11', 'Apoyo a la derecha (galope reunido)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JUV'), 12, 'T12', 'Apoyo a la izquierda (galope reunido)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JUV'), 13, 'T13', 'Cambio de pie en el aire a la derecha', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JUV'), 14, 'T14', 'Cambio de pie en el aire a la izquierda', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JUV'), 15, 'T15', 'Galope largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JUV'), 16, 'T16', 'La entrada y las paradas al principio y al final de la reprise', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JUV'), 101, 'A1', 'Ritmo, energia y elasticidad', 4, 'nota_artistica'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JUV'), 102, 'A2', 'Armonia entre jinete y caballo', 4, 'nota_artistica'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JUV'), 103, 'A3', 'Coreografia. Utilizacion de la pista. Creatividad', 4, 'nota_artistica'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JUV'), 104, 'A4', 'Grado de dificultad. Riesgo calculado', 4, 'nota_artistica'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-JUV'), 105, 'A5', 'Interpretacion de la musica', 4, 'nota_artistica');

-- ============================================
-- KÜR PONIS 2022
-- ============================================
INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('76', 'Kür Ponis', 'RFHE-2022-KUR-PON', 'Kür', 'Ponis', 'kur', 2022, '4''30" a 5''00"', 6, 400, 'KÜR PONIS 2022', 'Reprise libre con musica Ponis', 1, 0, 'RFHE-2022-KUR-PON');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-PON'), 1, 'T1', 'Paso reunido (minimo 20 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-PON'), 2, 'T2', 'Paso largo (minimo 20 m)', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-PON'), 3, 'T3', 'Media pirueta a la derecha y/o a la izquierda al paso reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-PON'), 4, 'T4', 'Espalda adentro a la derecha (trote reunido) (minimo 12 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-PON'), 5, 'T5', 'Espalda adentro a la izquierda (trote reunido) (minimo 12 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-PON'), 6, 'T6', 'Apoyo a la derecha (trote reunido)', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-PON'), 7, 'T7', 'Apoyo a la izquierda (trote reunido)', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-PON'), 8, 'T8', 'Trote largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-PON'), 9, 'T9', 'Galope en trocado a mano derecha (minimo 20 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-PON'), 10, 'T10', 'Galope en trocado a mano izquierda (minimo 20 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-PON'), 11, 'T11', 'Cambio de pie simple -con pasos intermedios- de izquierda a derecha', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-PON'), 12, 'T12', 'Cambio de pie simple -con pasos intermedios- de derecha a izquierda', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-PON'), 13, 'T13', 'Galope reunido incluyendo vuelta de 8 m de diametro a la izquierda y/o derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-PON'), 14, 'T14', 'Galope largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-PON'), 15, 'T15', 'La entrada y las paradas al principio y al final de la reprise', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-PON'), 101, 'A1', 'Ritmo, energia y elasticidad', 4, 'nota_artistica'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-PON'), 102, 'A2', 'Armonia entre jinete y caballo', 4, 'nota_artistica'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-PON'), 103, 'A3', 'Coreografia. Utilizacion de la pista. Creatividad', 4, 'nota_artistica'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-PON'), 104, 'A4', 'Grado de dificultad. Riesgo calculado', 4, 'nota_artistica'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-PON'), 105, 'A5', 'Interpretacion de la musica', 4, 'nota_artistica');
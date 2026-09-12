-- ============================================
-- KÜR GRAN PREMIO 2022
-- ============================================
INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('59', 'Kür Gran Premio', 'RFHE-2022-KUR-GP', 'Kür', 'Gran Premio', 'kur', 2022, '5''30" a 6''00"', 8, 400, 'KÜR GRAN PREMIO 2022', 'Reprise libre con musica Gran Premio', 1, 0, 'RFHE-2022-KUR-GP');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-GP'), 1, 'T1', 'Paso reunido (minimo 20 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-GP'), 2, 'T2', 'Paso largo (minimo 20 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-GP'), 3, 'T3', 'Apoyo a la derecha (trote reunido)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-GP'), 4, 'T4', 'Apoyo a la izquierda (trote reunido)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-GP'), 5, 'T5', 'Trote largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-GP'), 6, 'T6', 'Apoyo a la derecha (galope reunido)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-GP'), 7, 'T7', 'Apoyo a la izquierda (galope reunido)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-GP'), 8, 'T8', 'Galope largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-GP'), 9, 'T9', 'Cambios de pie en el aire cada dos trancos (minimo 5 consecutivos)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-GP'), 10, 'T10', 'Cambios de pie en el aire al trance (minimo 9 consecutivos)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-GP'), 11, 'T11', 'Pirueta a galope a la derecha', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-GP'), 12, 'T12', 'Pirueta a galope a la izquierda', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-GP'), 13, 'T13', 'Passage (minimo 15 m hacia adelante)', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-GP'), 14, 'T14', 'Piaffer (minimo 10 batidas recto)', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-GP'), 15, 'T15', 'Transiciones de passage a piaffer y de piaffer a passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-GP'), 16, 'T16', 'La entrada y las paradas al principio y al final de la reprise', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-GP'), 101, 'A1', 'Ritmo, energia y elasticidad', 4, 'nota_artistica'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-GP'), 102, 'A2', 'Armonia entre jinete y caballo', 4, 'nota_artistica'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-GP'), 103, 'A3', 'Coreografia. Utilizacion de la pista. Creatividad', 4, 'nota_artistica'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-GP'), 104, 'A4', 'Grado de dificultad. Riesgo calculado', 4, 'nota_artistica'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-GP'), 105, 'A5', 'Interpretacion de la musica', 4, 'nota_artistica');

-- ============================================
-- KÜR INTERMEDIA A/B 2022
-- ============================================
INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('60', 'Kür Intermedia A/B', 'RFHE-2022-KUR-INT-AB', 'Kür', 'Intermedia A/B', 'kur', 2022, '5''00" a 5''30"', 8, 400, 'KÜR INTERMEDIA A/B 2022', 'Reprise libre con musica Intermedia A/B', 1, 0, 'RFHE-2022-KUR-INT-AB');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-INT-AB'), 1, 'T1', 'Paso reunido (minimo 20 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-INT-AB'), 2, 'T2', 'Paso largo (minimo 20 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-INT-AB'), 3, 'T3', 'Apoyo a la derecha (trote reunido)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-INT-AB'), 4, 'T4', 'Apoyo a la izquierda (trote reunido)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-INT-AB'), 5, 'T5', 'Trote largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-INT-AB'), 6, 'T6', 'Apoyo a la derecha (galope reunido)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-INT-AB'), 7, 'T7', 'Apoyo a la izquierda (galope reunido)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-INT-AB'), 8, 'T8', 'Galope largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-INT-AB'), 9, 'T9', 'Cambios de pie en el aire cada dos trancos (minimo 5 consecutivos)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-INT-AB'), 10, 'T10', 'Cambios de pie en el aire al trance (minimo 5 consecutivos)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-INT-AB'), 11, 'T11', 'Pirueta a galope a la derecha (solo pirueta simple)', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-INT-AB'), 12, 'T12', 'Pirueta a galope a la izquierda (solo pirueta simple)', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-INT-AB'), 13, 'T13', 'Passage (minimo 12 m en una pista, apoyos no permitidos)', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-INT-AB'), 14, 'T14', 'Piaffer (minimo 8 batidas recto; permitido avanzar 2 m, piruetas no permitidas)', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-INT-AB'), 15, 'T15', 'Transiciones de y a piaffer (desde paso, trote o passage)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-INT-AB'), 16, 'T16', 'La entrada y las paradas al principio y al final de la reprise', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-INT-AB'), 101, 'A1', 'Ritmo, energia y elasticidad', 4, 'nota_artistica'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-INT-AB'), 102, 'A2', 'Armonia entre jinete y caballo', 4, 'nota_artistica'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-INT-AB'), 103, 'A3', 'Coreografia. Utilizacion de la pista. Creatividad', 4, 'nota_artistica'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-INT-AB'), 104, 'A4', 'Grado de dificultad. Riesgo calculado', 4, 'nota_artistica'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-KUR-INT-AB'), 105, 'A5', 'Interpretacion de la musica', 4, 'nota_artistica');

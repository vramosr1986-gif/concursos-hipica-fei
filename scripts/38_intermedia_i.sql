INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('38', 'Intermedia I', 'RFHE-2022-INT-I', 'Intermedia', 'Intermedia I', 'individual', 2022, '5''30"', 7, 320, 'INTERMEDIA I 2022', 'Reprise intermedia I', 1, 0, 'RFHE-2022-INT-I');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 1, 'A X XC', 'Entrada a galope reunido. Parada - inmovilidad - saludo. Partir al trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 2, 'C HXF F FA', 'Pista a mano izquierda. Trote largo. Trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 3, 'A DX', 'Doblar a lo largo. Espalda adentro a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 4, 'X', 'Vuelta a la derecha (8 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 5, 'XM MC', 'Apoyar a la derecha. Trote reunido', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 6, 'C', 'Parada - inmovilidad. 5 pasos atrás y partir inmediatamente al trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 7, 'HX', 'Apoyar a la izquierda', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 8, 'X', 'Vuelta a la izquierda (8 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 9, 'XD D A', 'Espalda adentro a la izquierda. Línea central. Pista a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 10, 'KR', 'Trote medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 11, 'R RMGH', 'Paso reunido. Paso reunido', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 12, 'HB(P)', 'Paso largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 13, 'Antes de P P PFA', 'Paso reunido. Partir a galope reunido a mano derecha. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 14, 'A Entre D y G', 'Doblar a lo largo. 3 apoyos de 5 m a cada lado de la línea central con cambio de pie en cada cambio de dirección empezando y terminando a la derecha. Cambio de pie en el aire. Pista a mano izquierda', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 15, 'HXF', 'Galope largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 16, 'F', 'Galope reunido y cambio de pie en el aire', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 17, 'KXM', 'En la diagonal 5 cambios de pie en el aire cada 3 trancos', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 18, 'H(B)', 'En la diagonal', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 19, 'B', 'Cambio de pie en el aire', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 20, 'B(K)', 'En la diagonal', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 21, 'K', 'Cambio de pie en el aire', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 22, 'FXH', 'En la diagonal, 7 cambios de pie en el aire cada 2 trancos', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 23, 'C', 'Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 24, 'MXK', 'Trote largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 25, 'A X', 'Doblar a lo largo. Parada - inmovilidad - saludo', 1, 'movimiento');

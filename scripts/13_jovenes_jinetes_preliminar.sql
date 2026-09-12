INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('13', 'Jovenes Jinetes Preliminar', 'RFHE-2022-JJ-PRE', 'Jovenes Jinetes', 'Preliminar', 'preliminar', 2022, '4''45"', 7, 300, 'JOVENES JINETES PRELIMINAR 2022', 'Reprise preliminar jovenes jinetes', 1, 0, 'RFHE-2022-JJ-PRE');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-PRE'), 1, 'A X XC', 'Entrada al galope reunido. Parada - inmovilidad - saludo. Partir al trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-PRE'), 2, 'C MXK K', 'Pista a mano derecha. Trote largo. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-PRE'), 3, 'KA', 'Transiciones en M y K. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-PRE'), 4, 'A DE', 'Doblar a lo largo. Apoyar a la izquierda', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-PRE'), 5, 'E', 'Vuelta a la derecha (8 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-PRE'), 6, 'EH HC', 'Espalda adentro a la derecha. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-PRE'), 7, 'C CM M H', 'Paso reunido. Paso reunido. Doblar a la derecha. Doblar a la izquierda', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-PRE'), 8, 'HB(P)', 'Paso largo', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-PRE'), 9, 'Antes de P P PA', 'Paso reunido. Partir a trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-PRE'), 10, 'A DB', 'Doblar a lo largo. Apoyar a la derecha', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-PRE'), 11, 'B', 'Vuelta a la izquierda (8 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-PRE'), 12, 'BM MC', 'Espalda adentro a la izquierda. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-PRE'), 13, 'C', 'Partir a galope reunido a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-PRE'), 14, 'HK', 'Galope medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-PRE'), 15, 'F Hacia X', 'A galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-PRE'), 16, 'F', 'Cambio de pie en el aire', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-PRE'), 17, 'KX', 'Apoyo a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-PRE'), 18, 'HXF', 'Sobre la diagonal 5 cambios de pie cada 4 trancos', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-PRE'), 19, 'FAK', 'Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-PRE'), 20, 'K', 'Cambio de pie en el aire', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-PRE'), 21, 'FX', 'Apoyo a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-PRE'), 22, 'MXK', 'Galope largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-PRE'), 23, 'K', 'Galope reunido y cambio de pie en el aire', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-PRE'), 24, 'A X', 'Doblar a lo largo. Parada - inmovilidad - saludo', 1, 'movimiento');

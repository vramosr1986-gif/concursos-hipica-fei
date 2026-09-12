INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('50', '7 años Preliminar', 'RFHE-2022-CJ7-PRE', 'Caballos Jovenes', '7 años Preliminar', 'preliminar', 2022, '4''45"', 7, 100, 'PRELIMINAR CABALLOS DE 7 AÑOS 2022', 'Reprise preliminar caballos 7 años', 1, 0, 'RFHE-2022-CJ7-PRE');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-PRE'), 1, 'A X XC', 'Entrada al galope reunido. Parada - inmovilidad - saludo. Partir al trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-PRE'), 2, 'C MXK K', 'Pista a mano derecha. Trote largo. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-PRE'), 3, 'KA', 'Transiciones en M y K. El trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-PRE'), 4, 'A DE', 'Doblar a lo largo. Apoyar a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-PRE'), 5, 'E', 'Vuelta a la derecha (8 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-PRE'), 6, 'EH HC', 'Espalda adentro a la derecha. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-PRE'), 7, 'CM M H', 'Paso reunido. Doblar a la derecha. Doblar a la izquierda', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-PRE'), 8, 'HS P', 'Paso largo', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-PRE'), 9, 'Entre P y F FA', 'Paso reunido y partir al trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-PRE'), 10, 'A DB', 'Doblar a lo largo. Apoyar a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-PRE'), 11, 'B', 'Vuelta a la izquierda (8 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-PRE'), 12, 'BM MC', 'Espalda adentro a la izquierda. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-PRE'), 13, 'C CH', 'Partir a galope reunido a la izquierda. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-PRE'), 14, 'HK KAF', 'Galope medio. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-PRE'), 15, 'F (X)', 'Proceder hacia X a galope reunido. Media pirueta a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-PRE'), 16, 'F FAK', 'Cambio de pie en el aire. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-PRE'), 17, 'KX X I C', 'Apoyo a la derecha. Linea central. Cambio de pie en el aire. Pista a mano izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-PRE'), 18, 'HP PFAK', 'Sobre la diagonal corta 3 cambios de pie cada 4 trancos. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-PRE'), 19, 'K (X)', 'Avanzar hacia X a galope reunido. Media pirueta a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-PRE'), 20, 'K KAF', 'Cambio de pie en el aire. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-PRE'), 21, 'FX X I C', 'Apoyo a la izquierda. Linea central. Cambio de pie en el aire. Pista a mano derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-PRE'), 22, 'MXK', 'Galope largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-PRE'), 23, 'K', 'Galope reunido y cambio de pie en el aire', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-PRE'), 24, 'A X', 'Doblar a lo largo. Parada - inmovilidad - saludo', 1, 'movimiento');

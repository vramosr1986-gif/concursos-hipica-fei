INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('15', 'Jovenes Jinetes Individual', 'RFHE-2022-JJ-IND', 'Jovenes Jinetes', 'Individual', 'individual', 2022, '5''50"', 7, 340, 'JOVENES JINETES INDIVIDUAL 2022', 'Reprise individual jovenes jinetes', 1, 0, 'RFHE-2022-JJ-IND');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 1, 'A X XC', 'Entrada al galope reunido. Parada - inmovilidad - saludo. Partir al trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 2, 'C HE E', 'Pista a mano izquierda. Espalda adentro a la izquierda. Doblar a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 3, 'B BF', 'Doblar a la derecha. Espalda adentro a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 4, 'A DB', 'Doblar a lo largo. Apoyar a la derecha', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 5, 'B', 'Vuelta a la izquierda (8 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 6, 'BH H HC', 'Trote medio. Trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 7, 'C', 'Parada - inmovilidad. 5 pasos atrás y partir inmediatamente al trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 8, 'MXK K', 'Trote largo. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 9, 'KA', 'Transiciones en M y K. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 10, 'A DE', 'Doblar a lo largo. Apoyar a la izquierda', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 11, 'E', 'Vuelta a la derecha (8 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 12, 'EM M MC', 'Trote medio. Trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 13, 'C CH', 'Paso medio. Paso Medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 14, 'HB', 'Paso largo', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 15, 'B BPL', 'Paso reunido. Paso reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 16, 'L LVKA', 'Partir a galope reunido a mano izquierda. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 17, 'A DE E', 'Línea central. Apoyo a la izquierda. Cambio de pie en el aire', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 18, 'EG G C', 'Apoyo a la derecha. Línea central. Pista a mano derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 19, 'MXK KAF', 'Sobre la diagonal 5 cambios de pie cada 4 trancos. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 20, 'FX X XF', 'Galope reunido. Media pirueta a la izquierda. Galope reunido', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 21, 'FA A', 'Galope en trocado. Cambio de pie en el aire', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 22, 'KX X XK', 'Galope reunido. Media pirueta a la derecha. Galope reunido', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 23, 'KA A', 'Galope en trocado. Cambio de pie en el aire', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 24, 'FXH', 'Sobre la diagonal 5 cambios de pie cada 3 trancos', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 25, 'MXK', 'Galope largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 26, 'K', 'Transición a galope reunido y cambio de pie en el aire', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 27, 'A X', 'Doblar a lo largo. Parada - inmovilidad - saludo', 1, 'movimiento');

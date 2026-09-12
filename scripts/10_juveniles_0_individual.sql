INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('10', 'Juveniles 0* Individual', 'RFHE-2022-JUV0-IND', 'Juveniles', '0* Individual', 'individual', 2022, '6''00"', 6, 320, 'JUNIORS 0* INDIVIDUAL 2022', 'Reprise individual 0* juveniles', 1, 0, 'RFHE-2022-JUV0-IND');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-IND'), 1, 'A X', 'Entrada a galope reunido. Parada- Inmovilidad - Saludo. Partir al trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-IND'), 2, 'C HF F', 'Pista a mano izquierda. Cambio de mano al trote medio. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-IND'), 3, 'Transiciones', 'Transiciones de reunido al trote medio y del medio al reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-IND'), 4, 'KE', 'Espalda adentro a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-IND'), 5, 'E', 'Círculo de 10 m a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-IND'), 6, 'EG C', 'Apoyar a la derecha. Pista a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-IND'), 7, 'MK', 'Cambio de mano al trote largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-IND'), 8, 'Transiciones', 'Transiciones de reunido al trote largo y del largo al reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-IND'), 9, 'FB', 'Espalda adentro a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-IND'), 10, 'B', 'Círculo a la izquierda de 10 m', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-IND'), 11, 'BG', 'Apoyo a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-IND'), 12, 'C CH', 'Pista a la izquierda. Paso medio', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-IND'), 13, 'HB', 'Cambio de mano al paso largo', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-IND'), 14, 'BP P', 'Paso reunido. Doblar a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-IND'), 15, 'L', 'Parada, por lo menos 4 segundos de inmovilidad, cuatro pasos para atrás y partir al galope reunido a la derecha. Pista a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-IND'), 16, 'VHCMR RI IS', 'Galope reunido. Semicírculo a la derecha de 10 m. Semicírculo a la izquierda de 10 m en trocado', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-IND'), 17, 'SF F', 'Cambio de mano al galope medio. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-IND'), 18, 'KM M C', 'Cambio de mano al galope largo. Galope reunido. Cambio de pie simple (3 a 5 pasos)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-IND'), 19, 'SI IR', 'Semicírculo de 10 m a la izquierda. Semicírculo de 10 m a la derecha en trocado', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-IND'), 20, 'RK K', 'Cambio de mano en galope medio. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-IND'), 21, 'A D', 'Doblar por la línea del centro. Trote', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-IND'), 22, 'LG G', 'Trote medio. Parada, Inmovilidad, Saludo', 1, 'movimiento');

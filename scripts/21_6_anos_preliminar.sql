INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('21', '6 años Preliminar', 'RFHE-2022-CJ6-PRE', 'Caballos Jovenes', '6 años Preliminar', 'preliminar', 2022, '5''00"', 6, 100, 'PRELIMINAR CABALLOS DE 6 AÑOS 2022', 'Reprise preliminar caballos 6 años', 1, 0, 'RFHE-2022-CJ6-PRE');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-PRE'), 1, 'A X', 'Entrada al trote de trabajo. Parada y saludo, partir al trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-PRE'), 2, 'C', 'Pista a mano izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-PRE'), 3, 'EX XB', 'Semicírculo de 10 m a mano izquierda. Semicírculo de 10 m a mano derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-PRE'), 4, 'BFAK', 'Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-PRE'), 5, 'KXM MCH', 'Trote medio. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-PRE'), 6, 'SV', 'Espalda adentro a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-PRE'), 7, 'VL LS', 'Semicírculo de 10 m. Apoyar a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-PRE'), 8, 'SHCM', 'Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-PRE'), 9, 'RP', 'Espalda adentro a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-PRE'), 10, 'PL LR', 'Semicírculo de 10 m. Apoyar a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-PRE'), 11, 'RMCH', 'Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-PRE'), 12, 'HXF FA', 'Trote largo. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-PRE'), 13, 'A', 'Parada - 4 ó 5 pasos atrás y partir al paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-PRE'), 14, 'KLB BI', 'Paso medio. Paso largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-PRE'), 15, 'HC', 'Paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-PRE'), 16, 'C', 'Partir a galope reunido a mano derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-PRE'), 17, 'PV V', 'Semicírculo de 20 m y ceder y volver a tomar las riendas algunos trancos. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-PRE'), 18, 'EI M Cerca de I', 'Cambio de mano. Cambio de pie en el aire', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-PRE'), 19, 'MCH H EK KAF', 'Galope reunido. Galope largo. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-PRE'), 20, 'FLE Cerca de L', 'Cambio de mano. Cambio de pie en el aire', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-PRE'), 21, 'ESRB BFA', 'Galope medio, entre S y R semicírculo de 20 m. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-PRE'), 22, 'Antes de A A', 'Trote reunido. Doblar a lo largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-PRE'), 23, 'X', 'Parada - inmovilidad - saludo', 1, 'movimiento');

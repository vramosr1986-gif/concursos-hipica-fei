INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('9', 'Juveniles 0* Preliminar', 'RFHE-2022-JUV0-PRE', 'Juveniles', '0* Preliminar', 'preliminar', 2022, '5''30"', 6, 260, 'JUNIORS 0* PRELIMINAR 2022', 'Reprise preliminar 0* juveniles', 1, 0, 'RFHE-2022-JUV0-PRE');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-PRE'), 1, 'A X', 'Entrada al trote de trabajo. Parada - inmovilidad - saludo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-PRE'), 2, 'C CMBFA A', 'Pista a mano derecha. Trote de trabajo. Transición a trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-PRE'), 3, 'Esquina entre A y K', 'Vuelta de 8 m', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-PRE'), 4, 'KE E B', 'Espalda adentro a la derecha. Doblar a la derecha. Doblar a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-PRE'), 5, 'BM', 'Espalda adentro a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-PRE'), 6, 'Esquina MH', 'Vuelta de 8 m. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-PRE'), 7, 'HF F', 'Cambio de mano al trote medio. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-PRE'), 8, 'Transiciones', 'Transiciones del trote reunido al largo y del largo al reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-PRE'), 9, 'A', 'Parada, inmovilidad 5 segundos y partir al paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-PRE'), 10, 'KR R', 'Cambio de mano al paso largo. Paso medio', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-PRE'), 11, 'M', 'Doblar a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-PRE'), 12, 'Entre G y H', 'Reunir el paso y media pirueta a la izquierda, paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-PRE'), 13, 'Entre G y M', 'Reunir el paso y media pirueta a la derecha. Paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-PRE'), 14, 'Paso medio', 'Paso medio entre piruetas y hasta salida al galope', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-PRE'), 15, 'G H', 'Partir a galope reunido a la izquierda. Pista a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-PRE'), 16, 'SK K', 'Galope medio. Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-PRE'), 17, 'P', 'Círculo de 10 m y en el círculo reunir el galope unos trancos y seguir a galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-PRE'), 18, 'B Antes de E', 'Doblar a la izquierda y transición a paso medio (por lo menos 10 metros). Galope a la derecha', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-PRE'), 19, 'S', 'Círculo de 10 m. y reunir el galope unos trancos y seguir a galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-PRE'), 20, 'MV V', 'Galope largo. Transición a galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-PRE'), 21, 'V VP', 'Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-PRE'), 22, 'P BE', 'Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-PRE'), 23, 'E Entre EK', 'Continuar por la pista a trote sentado acortando las riendas', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-PRE'), 24, 'A X', 'Doblar a lo largo. Parada - Inmovilidad - Saludo', 1, 'movimiento');

INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('37', 'Rider 3D', 'RFHE-2024-RID-3D', 'Rider', 'Rider 3D', 'individual', 2024, '6''00"', 6, 340, 'RIDER 3D 2024', 'Reprise rider 3D', 1, 0, 'RFHE-2024-RID-3D');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 1, 'A X C', 'Entrada al Galope reunido. Parada-Inmovilidad-saludo, y partir al trote reunido. Pista a mano derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 2, 'MB', 'Espalda dentro a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 3, 'B', 'Circulo a la derecha de 10m. de diámetro', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 4, 'BF', 'Cabeza al muro', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 5, 'A DB', 'Doblar por la línea del centro. Apoyo a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 6, 'BM MH', 'Trote Medio. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 7, 'HE', 'Espalda dentro a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 8, 'E', 'Circulo a la izquierda de 10m. de diámetro', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 9, 'EK', 'Cabeza al muro', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 10, 'A DE', 'Doblar por la línea del centro. Apoyo a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 11, 'EH HC', 'Trote medio. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 12, 'C', 'Parada, 5 pasos atrás, y partir al paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 13, 'MRXVP', 'Paso largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 14, 'V K Entre D & F', 'Paso reunido. Doblar a la izquierda. Media pirueta a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 15, 'Entre D & K', 'Media pirueta a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 16, 'El Paso reunido', 'El Paso reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 17, 'D F', 'Partir al galope reunido a la izquierda. Doblar a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 18, 'PM M', 'Galope Medio. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 19, 'C GB', 'Doblar por la línea del centro. Apoyo a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 20, 'PV', 'Medio circulo a la derecha de 20m de diámetro al galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 21, 'E EC', 'Cambio de pie simple. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 22, 'C GE', 'Doblar por la línea del centro. Apoyo a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 23, 'VP', 'Medio circulo a la izquierda de 20m de diámetro al galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 24, 'B BCH', 'Cambio de pie simple. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 25, 'HP P PF', 'Cambio de mano al galope largo. Galope reunido. Galope trocado', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 26, 'F KXM M', 'Trote reunido. Cambio de mano al trote largo. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 27, 'MCE E X', 'Trote reunido. Doblar a la izquierda. Doblar a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 28, 'G', 'Parada-Inmovilidad-saludo', 1, 'movimiento');

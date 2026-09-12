INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('36', 'Rider 3C', 'RFHE-2024-RID-3C', 'Rider', 'Rider 3C', 'individual', 2024, '5''00"', 6, 230, 'RIDER 3C 2024', 'Reprise rider 3C', 1, 0, 'RFHE-2024-RID-3C');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3C'), 1, 'A X C', 'Entrada al trote reunido. Parada - inmovilidad - saludo. Partir al Trote reunido. Pista a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3C'), 2, 'E X', '½ Circulo a la izquierda de 10m. Diámetro, hasta X. ½ Circulo a la derecha de 10m. de diámetro hasta la B', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3C'), 3, 'BF', 'Cabeza al muro', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3C'), 4, 'KXM M', 'Cambio de mano al trote medio. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3C'), 5, 'HD A', 'Apoyo a la izquierda. Pista derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3C'), 6, 'E X', '½ Circulo a la derecha de 10m. Diámetro, hasta X. ½ Circulo a la izquierda de 10m. de diámetro hasta la B', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3C'), 7, 'BM', 'Cabeza al muro', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3C'), 8, 'HXF F', 'Cambio de mano al trote medio. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3C'), 9, 'KG C', 'Apoyo a la derecha. Pista a mano derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3C'), 10, 'MXK K A', 'Paso largo. Paso reunido. Doblar por la línea del centro', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3C'), 11, 'X', 'Partir al Galope reunido a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3C'), 12, 'C HEKA', 'Pista a mano izquierda. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3C'), 13, 'FG C', 'Apoyo a la izquierda. Pista a mano izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3C'), 14, 'HK K', 'Galope Medio. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3C'), 15, 'FXH', 'Cambio de mano con cambio de pie simple en X', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3C'), 16, 'MBFAK', 'Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3C'), 17, 'KG C', 'Apoyo a la derecha. Pista a mano derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3C'), 18, 'MF F', 'Galope Medio. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3C'), 19, 'KXM', 'Cambio de mano con cambio de pie simple en X', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3C'), 20, 'MCH E E', 'Galope reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3C'), 21, 'A X', 'Doblar por la línea del centro. Parada, 4 pasos atrás, y partir al trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3C'), 22, 'G', 'Parada inmovilidad y saludo', 1, 'movimiento');

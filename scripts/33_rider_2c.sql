INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('33', 'Rider 2C', 'RFHE-2024-RID-2C', 'Rider', 'Rider 2C', 'individual', 2024, '5''30"', 6, 200, 'RIDER 2C 2024', 'Reprise rider 2C', 1, 0, 'RFHE-2024-RID-2C');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2C'), 1, 'A X C', 'Entrada al trote de trabajo. Parada - inmovilidad - saludo. Partir al Trote de Trabajo. Pista a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2C'), 2, 'S E X B', 'Circulo a la izquierda de 10m. de diámetro. Doblar a lo ancho. Parada, 3 - 4 pasos atrás. Y partir al trote trabajo. Doblar a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2C'), 4, 'P A Entre D & L BMC', 'Circulo a la derecha de 10m. de diámetro. Doblar por la línea del centro. Cesión a la pierna a mano derecha, hasta B. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2C'), 6, 'C Entre G & I BFAV', 'Doblar por la línea del centro. Cesión a la pierna a mano izquierda, hasta B. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2C'), 7, 'VXR', 'Cambio de mano a trote medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2C'), 8, 'R RMC', 'Trote de trabajo. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2C'), 9, 'C CHS', 'Paso medio. Paso Medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2C'), 10, 'SXP', 'Cambio de mano en paso libre, con riendas largas', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2C'), 11, 'PA A', 'Paso Medio. Galope reunido a mano derecha directamente desde el paso', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2C'), 12, 'AKV V V', 'Galope reunido. Circulo a la derecha de 20m de diámetro, mostrando algún tronco de galope medio. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2C'), 13, 'E X B BR', 'Doblar a la derecha. Cambio de pie con 2 - 3 trancos de trote. Doblar a la izquierda. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2C'), 14, 'R RC', 'Circulo a la izquierda de 20m de diámetro, mostrando algún tranco de galope medio. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2C'), 15, 'CA', 'Serpentina de 3 bucles al galope reunido, con cambios simples cada vez que se cruza la línea del centro. Acabando a mano izquierda en A Primer cambio simple', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2C'), 16, 'Segundo Cambio simple', 'Segundo Cambio simple', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2C'), 17, 'Serpentina', 'Serpentina: calidad del galope, y trazado de los bucles', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2C'), 18, 'A FX X', 'Trote reunido. Diagonal en trote reunido. Tomar la línea del centro', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2C'), 19, 'G', 'Parada-Inmovilidad - Saludo', 1, 'movimiento');

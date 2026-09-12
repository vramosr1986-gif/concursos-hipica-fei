INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('30', 'Rider 1C', 'RFHE-2024-RID-1C', 'Rider', 'Rider 1C', 'individual', 2024, '5''30"', 6, 200, 'RIDER 1C 2024', 'Reprise rider 1C', 1, 0, 'RFHE-2024-RID-1C');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1C'), 1, 'A X XC C', 'Entrada al trote de trabajo. Parada - inmovilidad - saludo. Trote de Trabajo. Pista a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1C'), 2, 'C', 'Serpentina de 4 bucles, acabando en A a mano izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1C'), 3, 'FXH H', 'Cambio de mano, mostrando algún tronco de trote medio. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1C'), 4, 'M', 'Circulo a la derecha de 10m', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1C'), 5, 'RXV V', 'Cambio de mano, mostrando algún tronco de trote medio. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1C'), 6, 'K', 'Circulo a la izquierda de 10m', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1C'), 7, 'AF', 'Paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1C'), 8, 'FS', 'Cambio de mano al paso libre en riendas largas', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1C'), 9, 'SM', 'Cambio de mano en Paso Medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1C'), 10, 'C', 'Galope de trabajo a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1C'), 11, 'E E', 'Circulo a la izquierda de 20m., mostrando en el primer ½ círculo algún tronco de galope Medio. Galope de Trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1C'), 12, 'VP', 'Medio círculo a la izquierda de 20m. Ceder y recoger las riendas al cruzar la línea del centro', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1C'), 13, 'Entre B&M', 'Transición galope, trote, galope', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1C'), 14, 'SX(P) X', 'Cambio de mano al galope de trabajo. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1C'), 15, 'F', 'Galope de trabajo a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1C'), 16, 'V', 'Circulo a la derecha de 20m, mostrando en el primer ½ circulo algún trance de galope Medio. Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1C'), 17, 'Entre E&H', 'Transición galope, trote, galope', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1C'), 18, 'R B', 'Transición al trote de Trabajo. Circulo a la derecha de 20m. dejando al caballo estirarse en riendas largas', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1C'), 19, 'Justo antes de B A D', 'Recoger las riendas. Doblar por la línea central. Paso Medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1C'), 20, 'X', 'Parada-Inmovilidad - Saludo', 1, 'movimiento');

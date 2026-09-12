INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('47', 'Benjamines 1', 'RFHE-BEN-1', 'Benjamines', 'Benjamines 1', 'individual', 2024, '4''00"', 6, 200, 'BENJAMINES 1', 'Reprise benjamines 1', 1, 0, 'RFHE-BEN-1');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-BEN-1'), 1, 'A X', 'Entrada al paso. Parada inmovilidad y saludo. Salida progresivamente al trote', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-BEN-1'), 2, 'C C-M-B', 'Pista a la derecha. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-BEN-1'), 3, 'B-E-B', 'Circulo de 20 m', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-BEN-1'), 4, 'B-F-K', 'Trote de trabajo sentado', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-BEN-1'), 5, 'K-M M-C-H-E', 'Cambio de mano en trote levantado alargando los trancos. Continuar al trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-BEN-1'), 6, 'E', 'Circulo de 20 m', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-BEN-1'), 7, 'K', 'Transición al paso', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-BEN-1'), 8, 'K-A-F', 'Paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-BEN-1'), 9, 'F-E', 'Diagonal al paso libre', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-BEN-1'), 10, 'Entre E-H', 'Transición al trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-BEN-1'), 11, 'Entre H-C', 'Galope de trabajo a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-BEN-1'), 12, 'C-M-B-F', 'Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-BEN-1'), 13, 'Antes de A', 'Transición al trote', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-BEN-1'), 14, 'A-C', 'Serpentina de dos bucles', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-BEN-1'), 15, 'Entre C-H', 'Galope a izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-BEN-1'), 16, 'H-E-K', 'Galope de trabajo a izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-BEN-1'), 17, 'Antes de A', 'Transición al trote', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-BEN-1'), 18, 'F-K', 'Semicírculo de 20 m en trote levantado', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-BEN-1'), 19, 'A X G', 'Doblar línea central. Paso Parada, inmovilidad 4" y saludo', 1, 'movimiento');

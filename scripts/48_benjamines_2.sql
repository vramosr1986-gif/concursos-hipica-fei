INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('48', 'Benjamines 2', 'RFHE-BEN-2', 'Benjamines', 'Benjamines 2', 'individual', 2024, '4''00"', 6, 200, 'BENJAMINES 2', 'Reprise benjamines 2', 1, 0, 'RFHE-BEN-2');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-BEN-2'), 1, 'A X', 'Entrada al paso. Parada inmovilidad y saludo. Salida progresivamente al trote', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-BEN-2'), 2, 'C', 'Pista a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-BEN-2'), 3, 'C-M-B', 'Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-BEN-2'), 4, 'B-E-B', 'Circulo de 20 m', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-BEN-2'), 5, 'B-F-K', 'Trote de trabajo sentado', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-BEN-2'), 6, 'K-M M-C-H-E', 'Cambio de mano en trote levantado alargando los trancos', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-BEN-2'), 7, 'E', 'Circulo de 20 m', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-BEN-2'), 8, 'K', 'Transición al paso', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-BEN-2'), 9, 'K-A-F', 'Paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-BEN-2'), 10, 'F-E', 'Diagonal al paso libre', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-BEN-2'), 11, 'Entre E-H', 'Transición al trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-BEN-2'), 12, 'Entre H-C', 'Galope de trabajo a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-BEN-2'), 13, 'C-M-B-F', 'Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-BEN-2'), 14, 'Antes de A', 'Transición al trote', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-BEN-2'), 15, 'A-C', 'Serpentina de dos bucles', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-BEN-2'), 16, 'Entre C-H', 'Galope a izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-BEN-2'), 17, 'H-E-K', 'Galope de trabajo a izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-BEN-2'), 18, 'Antes de A', 'Transición al trote', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-BEN-2'), 19, 'F-K', 'Semicírculo de 20 m en trote levantado', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-BEN-2'), 20, 'A X G', 'Doblar línea central. Paso Parada, inmovilidad 4" y saludo', 1, 'movimiento');

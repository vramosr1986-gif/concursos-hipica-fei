INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('28', 'Rider 1A', 'RFHE-2024-RID-1A', 'Rider', 'Rider 1A', 'individual', 2024, '3''30"', 6, 170, 'RIDER 1A 2024', 'Reprise rider 1A', 1, 0, 'RFHE-2024-RID-1A');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1A'), 1, 'A X', 'Entrada al trote de trabajo. Parada - inmovilidad - saludo. Partir al trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1A'), 2, 'C E EKAF', 'Pista a mano izquierda. Círculo a la izquierda de 12m de diámetro. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1A'), 3, 'FXH HCMB', 'Cambio de mano. Antes de X paso medio entre 7 y 10 pasos, después de X partir al Trote de trabajo. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1A'), 4, 'B BFA', 'Círculo a la derecha de 12m. de diámetro. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1A'), 5, 'A', 'Parada - inmovilidad 4 segundos, Partir al paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1A'), 6, 'KB BR', 'Cambio de mano al paso medio, alargar las riendas y dejar al caballo estirarse en riendas largas. Acortar las riendas', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1A'), 7, 'RMC', 'Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1A'), 8, 'C', 'Partir a Galope de trabajo a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1A'), 9, 'E', 'Círculo a la izquierda de 15m. de diámetro', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1A'), 10, 'EKAFB', 'Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1A'), 11, 'B', 'Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1A'), 12, 'CA', 'Serpentina de 4 bucles', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1A'), 13, 'A', 'Partir al galope de trabajo a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1A'), 14, 'E', 'Círculo a la derecha de 15m. de diámetro', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1A'), 15, 'EHCMB', 'Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1A'), 16, 'B', 'Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1A'), 17, 'A', 'Doblar por la línea del centro', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1A'), 18, 'I', 'Parada-Inmovilidad- Saludo', 1, 'movimiento');

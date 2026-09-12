INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('35', 'Rider 3B', 'RFHE-2024-RID-3B', 'Rider', 'Rider 3B', 'individual', 2024, '5''00"', 6, 250, 'RIDER 3B 2024', 'Reprise rider 3B', 1, 0, 'RFHE-2024-RID-3B');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3B'), 1, 'A X', 'Entrada al trote de trabajo. Parada - inmovilidad - saludo. Partir al Trote de Trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3B'), 2, 'C MXK', 'Pista a mano derecha. Cambio de mano al trote medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3B'), 3, 'K KF', 'Trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3B'), 4, 'FX', 'Apoyo a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3B'), 5, 'X X C', 'Circulo a la derecha de 10m. de diámetro. Seguir por la línea del centro. Pista a mano derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3B'), 6, 'Entre M & R Antes de R', 'Paso reunido. Media pirueta grande a la derecha, partir al paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3B'), 7, 'MCH HXF', 'Trote reunido. Cambio de mano al trote medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3B'), 8, 'F FK', 'Trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3B'), 9, 'KX', 'Apoyo a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3B'), 10, 'X X C', 'Circulo a la izquierda de 10m de diámetro. Seguir por la línea del centro. Pista a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3B'), 11, 'Entre H & S Antes de S', 'Paso reunido. Media pirueta a la izquierda, seguir al paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3B'), 12, 'HCM', 'Paso Medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3B'), 13, 'MIE', 'Cambio de mano al paso largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3B'), 14, 'EK', 'Paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3B'), 15, 'K KA', 'Galope a mano izquierda. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3B'), 16, 'A DE', 'Doblar por la línea del centro. Apoyo a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3B'), 17, 'ES SM', 'Galope trocado. Cambio de mano en galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3B'), 18, 'MCH HP', 'Galope reunido. Cambio de mano en galope medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3B'), 19, 'Justo antes de P P', 'Transición a galope reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3B'), 20, 'F', 'Partir a galope reunido a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3B'), 21, 'A DB', 'Doblar por la línea del centro. Apoyo a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3B'), 22, 'BR RH', 'Galope trocado. Cambio de mano en galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3B'), 23, 'HCM MV', 'Galope reunido. Galope medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3B'), 24, 'Justo antes de V VA', 'Transición a galope reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3B'), 25, 'A X', 'Doblar por la línea del centro. Parada-Inmovilidad - Saludo', 1, 'movimiento');

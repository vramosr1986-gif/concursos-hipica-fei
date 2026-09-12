INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('8', 'Juveniles Individual', 'RFHE-2018-JUV-IND', 'Juveniles', 'Individual', 'individual', 2018, '5''15"', 6, 320, 'JUVENILES INDIVIDUAL 2018', 'Reprise individual juveniles', 1, 0, 'RFHE-2018-JUV-IND');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2018-JUV-IND'), 1, 'A X XC', 'Entrada al galope reunido. Parada - inmovilidad - saludo. Partir al trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2018-JUV-IND'), 2, 'C HXF F FAK', 'Pista a mano izquierda. Trote medio. Trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2018-JUV-IND'), 3, 'KE', 'Espalda adentro a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2018-JUV-IND'), 4, 'EX XB', 'Media vuelta a la derecha (10 m). Media vuelta a la izquierda (10 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2018-JUV-IND'), 5, 'BG G C', 'Apoyo a la izquierda. Línea central. Pista a mano derecha', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2018-JUV-IND'), 6, 'RS SHCM', 'Entre S y H. Semicírculo a la derecha (20 m). Permitir al caballo estirarse en riendas largas. Trote reunido. Volver a tomar las riendas', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2018-JUV-IND'), 7, 'MXK K', 'Trote largo. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2018-JUV-IND'), 8, 'KAF', 'Transiciones en M y K. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2018-JUV-IND'), 9, 'FB', 'Espalda adentro a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2018-JUV-IND'), 10, 'BX XE', 'Media vuelta a la izquierda (10 m). Media vuelta a la derecha (10 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2018-JUV-IND'), 11, 'EG G', 'Apoyo a la derecha. Línea central', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2018-JUV-IND'), 12, 'Antes de C C H G GH', '[Paso reunido]. [Pista a mano izquierda]. [Doblar a la izquierda]. Media pirueta a la izquierda. [Paso reunido]', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2018-JUV-IND'), 13, 'C-H-G-H', 'El paso reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2018-JUV-IND'), 14, 'HB', 'Paso largo', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2018-JUV-IND'), 15, 'B BPL', 'Paso reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2018-JUV-IND'), 16, 'L L(P)', 'Media pirueta a la derecha. Paso reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2018-JUV-IND'), 17, 'Antes de P PFAK', 'Partir a galope reunido a mano derecha. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2018-JUV-IND'), 18, 'KX X', 'Apoyo a la derecha. Línea central', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2018-JUV-IND'), 19, 'I C', 'Cambio de pie en el aire. Pista a mano izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2018-JUV-IND'), 20, 'HP P', 'Galope medio. Galope Reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2018-JUV-IND'), 21, 'PF', 'Galope en trocado', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2018-JUV-IND'), 22, 'F', 'Cambio de pie en el aire', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2018-JUV-IND'), 23, 'FD D Entre D y L LV VKAF', 'Media vuelta a la derecha (10 m). Línea central. Cambio de pie simple. Media vuelta a la izquierda (10 m). Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2018-JUV-IND'), 24, 'FX X', 'Apoyo a la izquierda. Línea central', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2018-JUV-IND'), 25, 'I C', 'Cambio de pie en el aire. Pista a mano derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2018-JUV-IND'), 26, 'MV V', 'Galope largo. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2018-JUV-IND'), 27, 'VK', 'Galope en trocado', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2018-JUV-IND'), 28, 'K KA', 'Cambio de pie en el aire. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2018-JUV-IND'), 29, 'A X', 'Doblar a lo largo. Parada - inmovilidad - saludo', 1, 'movimiento');

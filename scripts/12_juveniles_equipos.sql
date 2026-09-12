INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('12', 'Juveniles Equipos', 'RFHE-2022-JUV-EQU', 'Juveniles', 'Equipos', 'equipos', 2022, '5''40"', 6, 310, 'JUVENILES EQUIPOS 2022', 'Reprise por equipos juveniles', 1, 0, 'RFHE-2022-JUV-EQU');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-EQU'), 1, 'A X XC', 'Entrada al galope reunido. Parada - inmovilidad - saludo. Partir al trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-EQU'), 2, 'C R', 'Pista a mano derecha. Vuelta a la derecha (10 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-EQU'), 3, 'RP', 'Espalda adentro a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-EQU'), 4, 'PL LR', 'Media vuelta a la derecha (10 m). Apoyo a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-EQU'), 5, 'M G H', 'Doblar a la izquierda. Parada - inmovilidad. 4 pasos atrás y partir inmediatamente al trote reunido. Doblar a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-EQU'), 6, 'SF F FA', 'Trote medio. Trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-EQU'), 7, 'A AKV', 'Paso medio. Paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-EQU'), 8, 'VR', 'Paso largo', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-EQU'), 9, 'RMG Entre G y H', '[Paso reunido]. Media pirueta a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-EQU'), 10, 'Entre G y M', 'Media pirueta a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-EQU'), 11, 'R-M-G-(H)-G-(M)-G', 'El paso reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-EQU'), 12, 'G H S', 'Partir a trote reunido. Doblar a la izquierda. Vuelta a la izquierda (10 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-EQU'), 13, 'SV', 'Espalda adentro a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-EQU'), 14, 'VL LS SHCM', 'Media vuelta a la izquierda (10 m). Apoyo a la izquierda. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-EQU'), 15, 'MXK K', 'Trote largo. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-EQU'), 16, 'KA', 'Transiciones en M y K. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-EQU'), 17, 'A', 'Partir a galope reunido a mano izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-EQU'), 18, 'AFP P L V', '[Galope reunido] [Doblar a la izquierda] Cambio de pie en el aire [Doblar a la derecha]', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-EQU'), 19, 'A-F-P-V-E', 'El galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-EQU'), 20, 'EG C', 'Apoyo a la derecha. Pista a mano derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-EQU'), 21, 'ME', 'Galope reunido con cambio de pie en el aire en I', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-EQU'), 22, 'EF', 'Galope reunido con cambio de pie en el aire en L', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-EQU'), 23, 'AKV V L P', '[Galope reunido] [Doblar a la derecha] Cambio de pie en el aire [Doblar a la izquierda]', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-EQU'), 24, 'A-K-V-P-B', 'El galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-EQU'), 25, 'BG C', 'Apoyo a la izquierda. Pista a mano izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-EQU'), 26, 'HK K', 'Galope largo. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-EQU'), 27, 'KA', 'Transiciones en H y K. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-EQU'), 28, 'A X', 'Doblar a lo largo. Parada - inmovilidad - saludo', 1, 'movimiento');

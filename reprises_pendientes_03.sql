INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('54', 'San Jorge', 'RFHE-2022-SJ', 'Clasica', 'San Jorge', 'individual', 2022, '5''50"', 7, 340, 'SAN JORGE 2022', 'Reprise San Jorge', 1, 0, 'RFHE-2022-SJ');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-SJ'), 1, 'A X XC', 'Entrada al galope reunido. Parada - inmovilidad - saludo. Partir al trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-SJ'), 2, 'C MXK K KAF', 'Pista a mano derecha. Trote medio. Trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-SJ'), 3, 'FB', 'Espalda adentro a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-SJ'), 4, 'B', 'Vuelta a la izquierda (8 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-SJ'), 5, 'BG G C', 'Apoyar a la izquierda. Continuar recto. Pista a la izquierda', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-SJ'), 6, 'HXF F', 'Trote largo. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-SJ'), 7, 'FAK', 'Transiciones en H y F. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-SJ'), 8, 'KE', 'Espalda adentro a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-SJ'), 9, 'E', 'Vuelta a la derecha (8 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-SJ'), 10, 'EG G', 'Apoyar a la derecha. Continuar recto', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-SJ'), 11, 'Antes de C C H Entre G y M', '[Paso reunido]. [Pista a mano izquierda]. [Doblar a la izquierda]. Media pirueta a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-SJ'), 12, 'Entre G y H GM', 'Media pirueta a la derecha [Paso reunido]', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-SJ'), 13, 'El paso reunido C-H-G-(M)-G-(H)-G-M', 'El paso reunido', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-SJ'), 14, 'MRXV(K)', 'Paso largo', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-SJ'), 15, 'Antes de K K KAF', 'Paso reunido Partir a galope reunido a la izquierda Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-SJ'), 16, 'FX X', 'Apoyo a la izquierda Cambio de pie en el aire', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-SJ'), 17, 'XM M MCH', 'Apoyo a la derecha Cambio de pie en el aire Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-SJ'), 18, 'H Entre H y X', 'Hacia X a galope reunido Media pirueta a la izquierda', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-SJ'), 19, 'HC C', 'Galope en trocado Cambio de pie en el aire', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-SJ'), 20, 'M Entre M y X', 'Avanzar hacia X a galope reunido Media pirueta a la derecha', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-SJ'), 21, 'MC C', 'Galope en trocado Cambio de pie en el aire', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-SJ'), 22, 'HXF FAK', 'Sobre la diagonal 5 cambios de pie cada 4 trancos Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-SJ'), 23, 'KXM MCH', 'Sobre la diagonal 5 cambios de pie en el aire cada 3 trancos Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-SJ'), 24, 'HXF', 'Galope largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-SJ'), 25, 'F', 'Galope reunido y cambio de pie en el aire', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-SJ'), 26, 'A X', 'Doblar a lo largo. Parada - inmovilidad - saludo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-SJ'), 101, 'NC1', 'Impresion General (Armonia y presentacion, posicion y asiento del jinete/amazona, correccion y efecto de las ayudas)', 1, 'nota_conjunto');

INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('55', 'Juveniles Preliminar', 'RFHE-2022-JUV-PRE', 'Juveniles', 'Preliminar', 'preliminar', 2022, '4''45"', 6, 300, 'JUVENILES PRELIMINAR 2022', 'Reprise preliminar juveniles', 1, 0, 'RFHE-2022-JUV-PRE');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-PRE'), 1, 'A X XC', 'Entrada a galope reunido. Parada - inmovilidad - saludo. Partir al trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-PRE'), 2, 'C S', 'Pista a mano izquierda. Vuelta a la izquierda (10 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-PRE'), 3, 'SV', 'Espalda adentro a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-PRE'), 4, 'VL LS H', 'Media vuelta a la izquierda (10 m). Apoyo a la izquierda. Doblar a la derecha', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-PRE'), 5, 'M R', 'Doblar a la derecha. Vuelta a la derecha (10 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-PRE'), 6, 'RP', 'Espalda adentro a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-PRE'), 7, 'PL LR', 'Media vuelta a la derecha (10 m). Apoyo a la derecha', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-PRE'), 8, 'RMCH H P P', 'Trote reunido. Trote medio. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-PRE'), 9, 'PF', 'Transiciones en H y P. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-PRE'), 10, 'F FAK', 'Paso medio. Paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-PRE'), 11, 'KR', 'Paso largo', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-PRE'), 12, 'R RMC', 'Paso reunido. Paso reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-PRE'), 13, 'C CS', 'Partir a galope reunido a mano izquierda. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-PRE'), 14, 'SK K KA', 'Galope medio. Galope reunido. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-PRE'), 15, 'A DE', 'Doblar a lo largo. Apoyo a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-PRE'), 16, 'ESH C', 'Galope en trocado. Cambio de pie simple', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-PRE'), 18, 'MF F', 'Galope largo. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-PRE'), 19, 'FA', 'Transiciones en M y F. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-PRE'), 20, 'A DB', 'Doblar a lo largo. Apoyo a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-PRE'), 21, 'BRMC', 'Galope en trocado', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-PRE'), 22, 'C', 'Cambio de pie simple', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-PRE'), 23, 'HB', 'Galope reunido con cambio de pie en el aire en I', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-PRE'), 24, 'BK', 'Galope reunido con cambio de pie en el aire en L', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-PRE'), 25, 'A X', 'Doblar a lo largo. Parada - inmovilidad - saludo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-PRE'), 101, 'NC1', 'Impresion General (Armonia y presentacion, posicion y asiento del jinete/amazona, correccion y efecto de las ayudas)', 1, 'nota_conjunto');

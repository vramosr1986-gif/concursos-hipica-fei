INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('51', 'Promocion 1', 'RFHE-2022-PRO-1', 'Promocion', 'Promocion 1', 'individual', 2022, '4''00"', 6, 160, 'PROMOCION 1', 'Reprise promocion 1', 1, 0, 'RFHE-2022-PRO-1');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-1'), 1, 'A X', 'Entrada al trote de trabajo. Parada - inmovilidad - saludo. Partir al trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-1'), 2, 'C E EKF', 'Pista a mano izquierda. Circulo a la izquierda de 15 m. de diametro. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-1'), 3, 'FXH HCMB', 'Cambio de mano al trote de trabajo (levantado). Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-1'), 4, 'B BFA', 'Circulo a la derecha de 15 m. de diametro. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-1'), 5, 'A', 'Transicion al paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-1'), 6, 'KB BR', 'Paso medio alargando la linea superior. Paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-1'), 7, 'RMC', 'Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-1'), 8, 'C', 'Partir a galope de trabajo a mano izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-1'), 9, 'E', 'Circulo a la izquierda de 20 m. de diametro', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-1'), 10, 'EKAF', 'Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-1'), 11, 'FB', 'Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-1'), 12, 'BE EB BE EHC', 'Semicirculo a la izquierda de 20 m. de diametro. Cambio de mano dentro del circulo de 20 m. haciendo una S. Semicirculo a la derecha de 20 m. de diametro. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-1'), 13, 'C CMB', 'Partir a galope de trabajo a mano derecha. Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-1'), 14, 'B BF', 'Circulo a la derecha de 20 m. de diametro. Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-1'), 15, 'F', 'Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-1'), 16, 'A I', 'Doblar a lo largo. Parada - Inmovilidad - Saludo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-1'), 101, 'NC1', 'Posicion y asiento del jinete, correccion y efecto de las ayudas', 1, 'nota_conjunto');

INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('52', 'Promocion 3', 'RFHE-2022-PRO-3', 'Promocion', 'Promocion 3', 'individual', 2022, '5''30"', 6, 320, 'PROMOCION 3 2022', 'Reprise promocion 3', 1, 0, 'RFHE-2022-PRO-3');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-3'), 1, 'A X', 'Entrada a galope reunido. Parada - inmovilidad - saludo. Partir al trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-3'), 2, 'C MXK K', 'Pista a mano derecha. Cambio de mano al trote medio. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-3'), 3, 'FB', 'Espalda adentro a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-3'), 4, 'B', 'Vuelta de 8 m', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-3'), 5, 'BG C', 'Apoyar a la izquierda. Pista a mano izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-3'), 6, 'HXF F', 'Cambio de mano al trote largo. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-3'), 7, 'Transiciones', 'Transiciones en H y F', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-3'), 8, 'A', 'Parada - 4 pasos atras y partir inmediatamente al trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-3'), 9, 'KE', 'Espalda adentro a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-3'), 10, 'E', 'Vuelta de 8 m', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-3'), 11, 'EG C', 'Apoyar a la derecha. Pista a mano derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-3'), 12, 'Entre C y M M Entre G y H', 'Paso medio. Doblar a lo ancho. Paso reunido y media pirueta a la derecha, partir al paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-3'), 13, 'Entre G y M', 'Paso reunido y media pirueta a la izquierda, partir al paso medio hasta H', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-3'), 14, 'El paso medio desde la transicion entre C y M hasta H', 'El paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-3'), 15, 'HSXP', 'Cambio de mano al paso largo', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-3'), 16, 'PFA', 'Paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-3'), 17, 'A', 'Partir a galope reunido a mano derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-3'), 18, 'V', 'Vuelta de 8 m', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-3'), 19, 'E X B', 'Doblar a lo ancho. Cambio de pie simple. Pista a mano izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-3'), 20, 'R', 'Vuelta de 8 m', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-3'), 21, 'HP P', 'Cambio de mano a galope medio. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-3'), 22, 'PFA', 'Galope en trocado', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-3'), 23, 'A', 'Cambio de pie simple', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-3'), 24, 'VR R', 'Cambio de mano a galope medio. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-3'), 25, 'RMC', 'Galope en trocado', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-3'), 26, 'C', 'Cambio de pie simple', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-3'), 27, 'HK K', 'Galope largo. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-3'), 28, 'Transiciones', 'Transiciones en H y K', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-3'), 29, 'A X', 'Doblar a lo largo. Parada - inmovilidad - saludo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-3'), 101, 'NC1', 'Impresion General (Armonia y presentacion, posicion y asiento del jinete/amazona, correccion y efecto de las ayudas)', 1, 'nota_conjunto');

INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('53', 'Promocion 4 (Juveniles Preliminar)', 'RFHE-2022-PRO-4', 'Promocion', 'Promocion 4', 'preliminar', 2022, '4''45"', 6, 300, 'PROMOCION 4 (JUVENILES PRELIMINAR)', 'Reprise promocion 4 juveniles preliminar', 1, 0, 'RFHE-2022-PRO-4');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-4'), 1, 'A X XC', 'Entrada al galope reunido. Parada - inmovilidad - saludo. Partir al trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-4'), 2, 'C S', 'Pista a mano izquierda. Vuelta a la izquierda (10 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-4'), 3, 'SV', 'Espalda adentro a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-4'), 4, 'VL LS H', 'Media vuelta a la izquierda (10 m). Apoyo a la izquierda. Doblar a la derecha', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-4'), 5, 'M R', 'Doblar a la derecha. Vuelta a la derecha (10 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-4'), 6, 'RP', 'Espalda adentro a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-4'), 7, 'PL LR', 'Media vuelta a la derecha (10 m). Apoyo a la derecha', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-4'), 8, 'RMCH H P PF', 'Trote reunido. Trote medio. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-4'), 9, 'Transiciones', 'Transiciones en H y P', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-4'), 10, 'FAK', 'Paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-4'), 11, 'KR', 'Paso largo', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-4'), 12, 'RMC', 'Paso reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-4'), 13, 'C CS', 'Partir a galope reunido a mano izquierda. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-4'), 14, 'SK KA', 'Galope medio. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-4'), 15, 'A DE', 'Doblar a lo largo. Apoyo a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-4'), 16, 'ESH C', 'Galope en trocado. Cambio de pie simple', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-4'), 18, 'MF FA', 'Galope largo. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-4'), 19, 'Transiciones', 'Transiciones en M y F', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-4'), 20, 'A DB', 'Doblar a lo largo. Apoyo a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-4'), 21, 'BRMC', 'Galope en trocado', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-4'), 22, 'C', 'Cambio de pie simple', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-4'), 23, 'HB', 'Galope reunido con cambio de pie en el aire en I', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-4'), 24, 'BK', 'Galope reunido con cambio de pie en el aire en L', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-4'), 25, 'A X', 'Doblar a lo largo. Parada - inmovilidad - saludo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-4'), 101, 'NC1', 'Impresion General (Armonia y presentacion, posicion y asiento del jinete/amazona, correccion y efecto de las ayudas)', 1, 'nota_conjunto');

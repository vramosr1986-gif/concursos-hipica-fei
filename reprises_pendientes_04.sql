-- ============================================
-- PONIS EQUIPOS 2022
-- ============================================
INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('56', 'Ponis Equipos', 'RFHE-2022-PON-EQU', 'Ponis', 'Equipos', 'equipos', 2022, '6''30"', 6, 330, 'PONIS EQUIPOS 2022', 'Reprise por equipos ponis', 1, 0, 'RFHE-2022-PON-EQU');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-EQU'), 1, 'A X XC', 'Entrada a galope reunido. Parada - inmovilidad - saludo. Partir al trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-EQU'), 2, 'C RK KAF', 'Pista a mano derecha. Trote medio. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-EQU'), 3, 'FB', 'Espalda adentro', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-EQU'), 4, 'BX XE', 'Media vuelta a la izquierda de 10 m. Media vuelta a la derecha de 10 m', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-EQU'), 5, 'EG G C', 'Apoyar a la derecha. Linea del centro. Pista a la derecha', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-EQU'), 6, 'Entre C y M M', 'Paso medio. Doblar a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-EQU'), 7, 'Entre G y H GH', 'Paso reunido. Media pirueta a la derecha, continuar al paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-EQU'), 8, 'Entre G y M GH', 'Paso reunido. Media pirueta a la izquierda, continuar al paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-EQU'), 9, 'El paso medio desde G hasta la transicion a paso largo en S', 'El paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-EQU'), 10, 'SP', 'Paso largo', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-EQU'), 11, 'PF F FAK', 'Paso medio. Partir al trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-EQU'), 12, 'KE', 'Espalda adentro', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-EQU'), 13, 'EX XB', 'Media vuelta a la derecha (10 m). Media vuelta a la izquierda (10 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-EQU'), 14, 'BG G C', 'Apoyo a la izquierda. En la linea del centro. Pista a la izquierda', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-EQU'), 15, 'HXF F', 'Trote largo. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-EQU'), 16, 'FA', 'Transiciones en H y F. El trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-EQU'), 17, 'A AK', 'Parada - inmovilidad. Cinco pasos atras y partir inmediatamente al galope reunido. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-EQU'), 18, 'KH H', 'Galope largo. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-EQU'), 19, 'Transiciones', 'Transiciones en K y H', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-EQU'), 20, 'SEVKA', 'Media vuelta (10 m). Volver a la pista en S. Galope en trocado', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-EQU'), 21, 'AF', 'Cambio de pie simple. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-EQU'), 22, 'FLE', 'Galope reunido. Entre F y E soltar y volver a tomar las riendas durante 3 trancos', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-EQU'), 23, 'ESHC', 'Galope en trocado', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-EQU'), 24, 'CMR', 'Cambio de pie simple. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-EQU'), 25, 'RI I IS', 'Media vuelta a la derecha (10m). Cambio de pie simple. Media vuelta a la izquierda (10m)', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-EQU'), 26, 'SV V', 'Galope medio. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-EQU'), 27, 'VL L LP PFA', 'Media vuelta a la izquierda (10m). Cambio de pie simple. Media vuelta a la derecha (10 m). Galope reunido', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-EQU'), 28, 'A X', 'Doblar por la linea de centro. Parada-inmovilidad-saludo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-EQU'), 101, 'NC1', 'Impresion General (Armonia y presentacion, posicion y asiento del jinete/amazona, correccion y efecto de las ayudas)', 1, 'nota_conjunto');

-- ============================================
-- PONIS INDIVIDUAL 2022
-- ============================================
INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('57', 'Ponis Individual', 'RFHE-2022-PON-IND', 'Ponis', 'Individual', 'individual', 2022, '6''00"', 6, 340, 'PONIS INDIVIDUAL 2022', 'Reprise individual ponis', 1, 0, 'RFHE-2022-PON-IND');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-IND'), 1, 'A X XC', 'Entrada a galope reunido. Parada - inmovilidad - saludo. Partir al trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-IND'), 2, 'C HB BP', 'Pista a mano izquierda. Trote medio. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-IND'), 3, 'B', 'Vuelta de 8 m', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-IND'), 4, 'BF FA', 'Espalda adentro a la derecha. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-IND'), 5, 'A DB', 'Doblar por la linea del centro. Apoyar a la derecha', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-IND'), 6, 'BG G C', 'Apoyar a la izquierda. Doblar por la linea del centro. Pista a mano derecha', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-IND'), 7, 'ME E', 'Trote medio. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-IND'), 8, 'E', 'Vuelta de 8 m', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-IND'), 9, 'EK KA', 'Espalda adentro a la izquierda. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-IND'), 10, 'A AF', 'Parada - inmovilidad. 5 pasos atras y partir inmediatamente a trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-IND'), 11, 'FXH H', 'Trote largo. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-IND'), 12, 'HC', 'Transiciones en F y H. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-IND'), 13, 'CM (G) Antes de G', 'Paso medio. Paso reunido. Media pirueta a la derecha. Continuar al paso medio hasta M', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-IND'), 14, 'El paso medio desde la transicion en C hasta la transicion a paso largo en M', 'El paso medio', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-IND'), 15, 'MRXV', 'Paso largo', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-IND'), 16, 'V Entre V y K KA', 'Paso medio. Galope reunido. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-IND'), 17, 'AX', 'Serpentina con dos bucles. El primero en firme. El segundo en trocado', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-IND'), 18, 'X', 'Cambio de pie simple del trocado al trocado', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-IND'), 19, 'XC', 'Serpentina con dos bucles. El primero en trocado. El segundo en firme', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-IND'), 20, 'CM MV VK', 'Galope reunido. Galope medio. Galope reunido (en trocado)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-IND'), 21, 'K KA', 'Cambio de pie simple. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-IND'), 22, 'A L', 'Doblar por la linea del centro. Vuelta a la izquierda de 8 m', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-IND'), 23, 'LX X XI', 'Galope reunido. Cambio de pie simple. Galope reunido', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-IND'), 24, 'I', 'Vuelta a la derecha de 8 m', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-IND'), 25, 'IG G C', 'Galope reunido. Cambio de pie simple. Pista a la izquierda', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-IND'), 26, 'HP P', 'Galope largo. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-IND'), 27, 'PF', 'Transiciones en H y P. Galope en trocado', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-IND'), 28, 'F A DI IG', 'Trote reunido. Doblar por la linea del centro. Trote medio. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-IND'), 29, 'G', 'Parada - inmovilidad - saludo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-IND'), 101, 'NC1', 'Impresion General (Armonia y presentacion, posicion y asiento del jinete/amazona, correccion y efecto de las ayudas)', 1, 'nota_conjunto');

-- ============================================
-- PONIS PRELIMINAR 2022
-- ============================================
INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('58', 'Ponis Preliminar', 'RFHE-2022-PON-PRE', 'Ponis', 'Preliminar', 'preliminar', 2022, '6''30"', 6, 340, 'PONIS PRELIMINAR 2022', 'Reprise preliminar ponis', 1, 0, 'RFHE-2022-PON-PRE');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-PRE'), 1, 'A X XC', 'Entrada a galope reunido. Parada - inmovilidad - saludo. Partir al trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-PRE'), 2, 'C MXK KAF', 'Pista a mano derecha. Trote medio. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-PRE'), 3, 'FB', 'Espalda adentro a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-PRE'), 4, 'B', 'Vuelta a la izquierda de 8 m', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-PRE'), 5, 'BG G C', 'Apoyar a la izquierda. Linea del centro. Pista a la izquierda', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-PRE'), 6, 'HXF FA', 'Trote largo. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-PRE'), 7, 'Transiciones', 'Las transiciones en H y F', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-PRE'), 8, 'A', 'Parada - inmovilidad. Cuatro pasos atras, partir inmediatamente al trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-PRE'), 9, 'KE', 'Espalda adentro a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-PRE'), 10, 'E', 'Vuelta a la derecha 8 m', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-PRE'), 11, 'EG G C', 'Apoyar a la derecha. Linea del centro. Pista a la derecha', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-PRE'), 12, 'Entre C y M M Entre G y H', 'Paso medio. Doblar a la derecha. Paso reunido y media pirueta a la derecha, continuar al paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-PRE'), 13, 'Entre G y M', 'Paso reunido y media pirueta a la izquierda, continuar al paso medio hasta H', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-PRE'), 14, 'El paso medio desde la transicion entre C y M hasta H', 'El paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-PRE'), 15, 'HSXP', 'Paso largo', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-PRE'), 16, 'PFA', 'Paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-PRE'), 17, 'A AV', 'Galope reunido a la derecha. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-PRE'), 18, 'V VE', 'Vuelta a la derecha 8 m. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-PRE'), 19, 'E X B', 'Doblar a la derecha. Cambio de pie simple. Pista a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-PRE'), 20, 'R RMCH', 'Vuelta a la izquierda 8 m. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-PRE'), 21, 'HP P', 'Galope medio. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-PRE'), 22, 'PFA', 'Galope en trocado', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-PRE'), 23, 'A', 'Cambio de pie simple', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-PRE'), 24, 'AKV VR R', 'Galope reunido. Galope medio. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-PRE'), 25, 'RMC', 'Galope en trocado', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-PRE'), 26, 'C', 'Cambio de pie simple', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-PRE'), 27, 'HK KA', 'Galope largo. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-PRE'), 28, 'Transiciones', 'Transiciones en H y K', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-PRE'), 29, 'A X', 'Doblar por la linea del centro. Parada - inmovilidad - saludo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PON-PRE'), 101, 'NC1', 'Impresion General (Armonia y presentacion, posicion y asiento del jinete/amazona, correccion y efecto de las ayudas)', 1, 'nota_conjunto');
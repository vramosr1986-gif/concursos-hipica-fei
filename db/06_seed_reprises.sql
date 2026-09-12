-- ============================================
-- SEED: TODAS LAS REPRISES Y EJERCICIOS
-- ============================================
-- Este archivo contiene las 66 reprises oficiales RFHE
-- con sus 1551 ejercicios.
--
-- Orden de ejecucion: se ejecuta despues de crear la estructura.
-- ============================================

INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('7', 'Infantiles Individual', 'RFHE-2024-INF-IND', 'Infantiles', 'Individual', 'individual', 2024, '3''50"', 6, 270, 'INFANTILES INDIVIDUAL 2024', 'Reprise individual infantiles', 1, 0, 'RFHE-2024-INF-IND');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-IND'), 1, 'A X', 'Entrada al trote reunido. Parada - inmovilidad - saludo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-IND'), 2, 'X XC', 'Partir al trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-IND'), 3, 'C HSE', 'Pista a la izquierda. Espalda adentro a la izquierda', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-IND'), 4, 'EX XB', 'Medio círculo a izquierda (10m). Medio círculo a derecha (10m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-IND'), 5, 'BPF FAK', 'Espalda adentro a la derecha. Trote reunido', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-IND'), 6, 'KXM M', 'Trote Medio. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-IND'), 7, 'MC', 'Transiciones en K y M. Trote Reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-IND'), 8, 'CHG', 'Paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-IND'), 9, 'Entre G&M', 'Giro sobre los posteriores a la izquierda. Continuar al paso medio', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-IND'), 10, 'Entre G&H', 'Giro sobre los posteriores a la derecha. Continuar al paso medio', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-IND'), 11, 'GMC', 'Paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-IND'), 12, 'C CH', 'Partir al Galope Reunido. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-IND'), 13, 'HEK K', 'Galope Medio. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-IND'), 14, 'KA', 'Transiciones en H y K. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-IND'), 15, 'AX', 'Serpentina de 2 bucles. El 1er bucle en galope en firme. El Segundo bucle en galope trocado', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-IND'), 16, 'X', 'Cambio de pie simple de galope trocado a galope trocado', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-IND'), 17, 'XC', 'Serpentina de 2 bucles. El 1er bucle en galope trocado. El 2º bucle en galope en firme', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-IND'), 18, 'RIMedia', 'Media vuelta a la derecha (10m.). Cambio de pie simple. Media vuelta a la izquierda (10m). Galope reunido', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-IND'), 19, 'E', 'Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-IND'), 20, 'A', 'Doblar línea central. Parada. Inmovilidad. Saludo', 1, 'movimiento');



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



INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('9', 'Juveniles 0* Preliminar', 'RFHE-2022-JUV0-PRE', 'Juveniles', '0* Preliminar', 'preliminar', 2022, '5''30"', 6, 260, 'JUNIORS 0* PRELIMINAR 2022', 'Reprise preliminar 0* juveniles', 1, 0, 'RFHE-2022-JUV0-PRE');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-PRE'), 1, 'A X', 'Entrada al trote de trabajo. Parada - inmovilidad - saludo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-PRE'), 2, 'C CMBFA A', 'Pista a mano derecha. Trote de trabajo. Transición a trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-PRE'), 3, 'Esquina entre A y K', 'Vuelta de 8 m', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-PRE'), 4, 'KE E B', 'Espalda adentro a la derecha. Doblar a la derecha. Doblar a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-PRE'), 5, 'BM', 'Espalda adentro a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-PRE'), 6, 'Esquina MH', 'Vuelta de 8 m. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-PRE'), 7, 'HF F', 'Cambio de mano al trote medio. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-PRE'), 8, 'Transiciones', 'Transiciones del trote reunido al largo y del largo al reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-PRE'), 9, 'A', 'Parada, inmovilidad 5 segundos y partir al paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-PRE'), 10, 'KR R', 'Cambio de mano al paso largo. Paso medio', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-PRE'), 11, 'M', 'Doblar a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-PRE'), 12, 'Entre G y H', 'Reunir el paso y media pirueta a la izquierda, paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-PRE'), 13, 'Entre G y M', 'Reunir el paso y media pirueta a la derecha. Paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-PRE'), 14, 'Paso medio', 'Paso medio entre piruetas y hasta salida al galope', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-PRE'), 15, 'G H', 'Partir a galope reunido a la izquierda. Pista a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-PRE'), 16, 'SK K', 'Galope medio. Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-PRE'), 17, 'P', 'Círculo de 10 m y en el círculo reunir el galope unos trancos y seguir a galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-PRE'), 18, 'B Antes de E', 'Doblar a la izquierda y transición a paso medio (por lo menos 10 metros). Galope a la derecha', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-PRE'), 19, 'S', 'Círculo de 10 m. y reunir el galope unos trancos y seguir a galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-PRE'), 20, 'MV V', 'Galope largo. Transición a galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-PRE'), 21, 'V VP', 'Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-PRE'), 22, 'P BE', 'Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-PRE'), 23, 'E Entre EK', 'Continuar por la pista a trote sentado acortando las riendas', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-PRE'), 24, 'A X', 'Doblar a lo largo. Parada - Inmovilidad - Saludo', 1, 'movimiento');



INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('10', 'Juveniles 0* Individual', 'RFHE-2022-JUV0-IND', 'Juveniles', '0* Individual', 'individual', 2022, '6''00"', 6, 320, 'JUNIORS 0* INDIVIDUAL 2022', 'Reprise individual 0* juveniles', 1, 0, 'RFHE-2022-JUV0-IND');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-IND'), 1, 'A X', 'Entrada a galope reunido. Parada- Inmovilidad - Saludo. Partir al trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-IND'), 2, 'C HF F', 'Pista a mano izquierda. Cambio de mano al trote medio. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-IND'), 3, 'Transiciones', 'Transiciones de reunido al trote medio y del medio al reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-IND'), 4, 'KE', 'Espalda adentro a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-IND'), 5, 'E', 'Círculo de 10 m a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-IND'), 6, 'EG C', 'Apoyar a la derecha. Pista a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-IND'), 7, 'MK', 'Cambio de mano al trote largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-IND'), 8, 'Transiciones', 'Transiciones de reunido al trote largo y del largo al reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-IND'), 9, 'FB', 'Espalda adentro a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-IND'), 10, 'B', 'Círculo a la izquierda de 10 m', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-IND'), 11, 'BG', 'Apoyo a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-IND'), 12, 'C CH', 'Pista a la izquierda. Paso medio', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-IND'), 13, 'HB', 'Cambio de mano al paso largo', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-IND'), 14, 'BP P', 'Paso reunido. Doblar a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-IND'), 15, 'L', 'Parada, por lo menos 4 segundos de inmovilidad, cuatro pasos para atrás y partir al galope reunido a la derecha. Pista a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-IND'), 16, 'VHCMR RI IS', 'Galope reunido. Semicírculo a la derecha de 10 m. Semicírculo a la izquierda de 10 m en trocado', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-IND'), 17, 'SF F', 'Cambio de mano al galope medio. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-IND'), 18, 'KM M C', 'Cambio de mano al galope largo. Galope reunido. Cambio de pie simple (3 a 5 pasos)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-IND'), 19, 'SI IR', 'Semicírculo de 10 m a la izquierda. Semicírculo de 10 m a la derecha en trocado', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-IND'), 20, 'RK K', 'Cambio de mano en galope medio. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-IND'), 21, 'A D', 'Doblar por la línea del centro. Trote', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-IND'), 22, 'LG G', 'Trote medio. Parada, Inmovilidad, Saludo', 1, 'movimiento');



INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('11', 'Juveniles 0* Equipos', 'RFHE-2022-JUV0-EQU', 'Juveniles', '0* Equipos', 'equipos', 2022, '6''00"', 6, 320, 'JUNIORS 0* EQUIPOS 2022', 'Reprise por equipos 0* juveniles', 1, 0, 'RFHE-2022-JUV0-EQU');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-EQU'), 1, 'A X', 'Entrada a galope reunido. Parada - Inmovilidad - Saludo. Partir al trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-EQU'), 2, 'C HE', 'Pista a la izquierda. Espalda adentro a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-EQU'), 3, 'E', 'Círculo de 10 m a la izquierda en la mitad del mismo ceder las 2 riendas por lo menos 3 a 4 trancos', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-EQU'), 4, 'EK', 'Cabeza al muro a la izquierda (Travers)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-EQU'), 5, 'A DE EHC', 'Doblar por la línea del centro. Apoyar a la izquierda. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-EQU'), 6, 'C Antes de M Entre M & R', 'Paso medio. Reunir el paso. Media pirueta a la derecha, continuar al paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-EQU'), 7, 'Antes de H Entre H & S', 'Reunir el paso. Media pirueta a la izquierda, continuar al paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-EQU'), 8, 'Paso medio entre piruetas', 'Paso medio entre piruetas', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-EQU'), 9, 'C MB', 'Trote reunido. Espalda adentro a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-EQU'), 10, 'B', 'Círculo de 10 m a la derecha a la mitad del mismo ceder las 2 riendas por lo menos 3 a 4 trancos', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-EQU'), 11, 'BF', 'Cabeza al muro a la derecha (Travers)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-EQU'), 12, 'A DB BH', 'Doblar por la línea del centro. Apoyo a la derecha. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-EQU'), 13, 'HF F', 'Cambio de mano al trote largo. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-EQU'), 14, 'Transiciones', 'Las transiciones en F y H', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-EQU'), 15, 'AKR', 'Paso largo', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-EQU'), 16, 'Entre RM', 'Acortar las riendas reunir el paso y partir al galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-EQU'), 17, 'HK KF', 'Galope largo. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-EQU'), 18, 'Transiciones', 'Las transiciones en H/K', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-EQU'), 19, 'FE', 'Cambio de mano al galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-EQU'), 20, 'EB BP', 'Semicírculo de 20 m en galope en trocado. Galope en trocado', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-EQU'), 21, 'P PFK', 'Cambio de pie simple (3 a 5 pasos). Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-EQU'), 22, 'KB', 'Cambio de mano al galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-EQU'), 23, 'BE EV', 'Semicírculo de 20 m en trocado. Galope en trocado', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-EQU'), 24, 'V VKA', 'Cambio de pie simple (3 a 5 pasos). Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-EQU'), 25, 'A L', 'Doblar por la línea del centro. Círculo de 10 m. a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-EQU'), 26, 'X I', 'Cambio de pie simple (3 a 5 pasos). Círculo de 10 m a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV0-EQU'), 27, 'C B X G', 'Doblar a la derecha. Doblar a la derecha. Doblar a la derecha. Parada', 1, 'movimiento');



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



INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('13', 'Jovenes Jinetes Preliminar', 'RFHE-2022-JJ-PRE', 'Jovenes Jinetes', 'Preliminar', 'preliminar', 2022, '4''45"', 7, 300, 'JOVENES JINETES PRELIMINAR 2022', 'Reprise preliminar jovenes jinetes', 1, 0, 'RFHE-2022-JJ-PRE');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-PRE'), 1, 'A X XC', 'Entrada al galope reunido. Parada - inmovilidad - saludo. Partir al trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-PRE'), 2, 'C MXK K', 'Pista a mano derecha. Trote largo. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-PRE'), 3, 'KA', 'Transiciones en M y K. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-PRE'), 4, 'A DE', 'Doblar a lo largo. Apoyar a la izquierda', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-PRE'), 5, 'E', 'Vuelta a la derecha (8 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-PRE'), 6, 'EH HC', 'Espalda adentro a la derecha. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-PRE'), 7, 'C CM M H', 'Paso reunido. Paso reunido. Doblar a la derecha. Doblar a la izquierda', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-PRE'), 8, 'HB(P)', 'Paso largo', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-PRE'), 9, 'Antes de P P PA', 'Paso reunido. Partir a trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-PRE'), 10, 'A DB', 'Doblar a lo largo. Apoyar a la derecha', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-PRE'), 11, 'B', 'Vuelta a la izquierda (8 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-PRE'), 12, 'BM MC', 'Espalda adentro a la izquierda. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-PRE'), 13, 'C', 'Partir a galope reunido a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-PRE'), 14, 'HK', 'Galope medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-PRE'), 15, 'F Hacia X', 'A galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-PRE'), 16, 'F', 'Cambio de pie en el aire', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-PRE'), 17, 'KX', 'Apoyo a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-PRE'), 18, 'HXF', 'Sobre la diagonal 5 cambios de pie cada 4 trancos', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-PRE'), 19, 'FAK', 'Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-PRE'), 20, 'K', 'Cambio de pie en el aire', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-PRE'), 21, 'FX', 'Apoyo a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-PRE'), 22, 'MXK', 'Galope largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-PRE'), 23, 'K', 'Galope reunido y cambio de pie en el aire', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-PRE'), 24, 'A X', 'Doblar a lo largo. Parada - inmovilidad - saludo', 1, 'movimiento');



INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('14', 'Jovenes Jinetes Equipos', 'RFHE-2022-JJ-EQU', 'Jovenes Jinetes', 'Equipos', 'equipos', 2022, '5''50"', 7, 350, 'JOVENES JINETES EQUIPOS 2022', 'Reprise por equipos jovenes jinetes', 1, 0, 'RFHE-2022-JJ-EQU');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 1, 'A X XC', 'Entrada al galope reunido. Parada - inmovilidad - saludo. Partir al trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 2, 'C MXK K KAF', 'Pista a mano derecha. Cambio de mano al trote medio. Trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 3, 'FB', 'Espalda adentro a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 4, 'B', 'Vuelta a la izquierda (8 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 5, 'BG G C', 'Apoyar a la izquierda. Continuar por derecho. Pista a la izquierda', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 6, 'HXF F', 'Trote largo. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 7, 'FAK', 'Transiciones en H y F. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 8, 'KE', 'Espalda adentro a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 9, 'E', 'Vuelta a la derecha (8 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 10, 'EG G C', 'Apoyar a la derecha. Continuar por derecho. Pista a mano izquierda', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 11, 'Antes de C C H Entre G y M', '[Paso reunido]. [Pista a mano izquierda]. [Doblar a la izquierda]. Media pirueta a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 12, 'Entre G y H G M', 'Media pirueta a la derecha. [Paso reunido]', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 13, 'El paso reunido', 'El paso reunido C-H-G-(M)-G-(H)-G-M', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 14, 'MRXV(K)', 'Paso largo', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 15, 'Antes de K K KAF', 'Paso reunido. Partir a galope reunido a la izquierda. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 16, 'FX X', 'Apoyo a la izquierda. Cambio de pie en el aire', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 17, 'XM M MCH', 'Apoyo a la derecha. Cambio de pie en el aire. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 18, 'H Entre H y X', 'Hacia X a galope reunido. Media pirueta a la izquierda', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 19, 'HC C', 'Galope en trocado. Cambio de pie en el aire', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 20, 'M Entre M y X', 'Avanzar hacia X a galope reunido. Media pirueta a la derecha', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 21, 'MC C', 'Galope en trocado. Cambio de pie en el aire', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 22, 'HXF FAK', 'Sobre la diagonal 5 cambios de pie cada 4 trancos. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 23, 'KXM MCH', 'Sobre la diagonal 5 cambios de pie en el aire cada 3 trancos. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 24, 'HXF', 'Galope largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 25, 'F', 'Galope reunido y cambio de pie en el aire', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 26, 'A X', 'Doblar a lo largo. Parada - inmovilidad - saludo', 1, 'movimiento');



INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('15', 'Jovenes Jinetes Individual', 'RFHE-2022-JJ-IND', 'Jovenes Jinetes', 'Individual', 'individual', 2022, '5''50"', 7, 340, 'JOVENES JINETES INDIVIDUAL 2022', 'Reprise individual jovenes jinetes', 1, 0, 'RFHE-2022-JJ-IND');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 1, 'A X XC', 'Entrada al galope reunido. Parada - inmovilidad - saludo. Partir al trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 2, 'C HE E', 'Pista a mano izquierda. Espalda adentro a la izquierda. Doblar a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 3, 'B BF', 'Doblar a la derecha. Espalda adentro a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 4, 'A DB', 'Doblar a lo largo. Apoyar a la derecha', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 5, 'B', 'Vuelta a la izquierda (8 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 6, 'BH H HC', 'Trote medio. Trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 7, 'C', 'Parada - inmovilidad. 5 pasos atrás y partir inmediatamente al trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 8, 'MXK K', 'Trote largo. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 9, 'KA', 'Transiciones en M y K. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 10, 'A DE', 'Doblar a lo largo. Apoyar a la izquierda', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 11, 'E', 'Vuelta a la derecha (8 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 12, 'EM M MC', 'Trote medio. Trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 13, 'C CH', 'Paso medio. Paso Medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 14, 'HB', 'Paso largo', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 15, 'B BPL', 'Paso reunido. Paso reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 16, 'L LVKA', 'Partir a galope reunido a mano izquierda. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 17, 'A DE E', 'Línea central. Apoyo a la izquierda. Cambio de pie en el aire', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 18, 'EG G C', 'Apoyo a la derecha. Línea central. Pista a mano derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 19, 'MXK KAF', 'Sobre la diagonal 5 cambios de pie cada 4 trancos. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 20, 'FX X XF', 'Galope reunido. Media pirueta a la izquierda. Galope reunido', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 21, 'FA A', 'Galope en trocado. Cambio de pie en el aire', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 22, 'KX X XK', 'Galope reunido. Media pirueta a la derecha. Galope reunido', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 23, 'KA A', 'Galope en trocado. Cambio de pie en el aire', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 24, 'FXH', 'Sobre la diagonal 5 cambios de pie cada 3 trancos', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 25, 'MXK', 'Galope largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 26, 'K', 'Transición a galope reunido y cambio de pie en el aire', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-IND'), 27, 'A X', 'Doblar a lo largo. Parada - inmovilidad - saludo', 1, 'movimiento');



INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('16', '4 años Preliminar', 'RFHE-2022-CJ4-PRE', 'Caballos Jovenes', '4 años Preliminar', 'preliminar', 2022, '5''00"', 4, 100, 'PRELIMINAR CABALLOS DE 4 AÑOS', 'Reprise preliminar caballos 4 años', 1, 0, 'RFHE-2022-CJ4-PRE');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-PRE'), 1, 'A X C', 'Entrada al trote de trabajo por la línea central sin saludo. Pista a mano derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-PRE'), 2, 'CMBFAKE', 'Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-PRE'), 3, 'EXB B', 'Doblar a lo ancho. Doblar a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-PRE'), 4, 'BMCH', 'Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-PRE'), 5, 'HK KA', 'Alargar los trancos. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-PRE'), 6, 'Entre A y F', 'Paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-PRE'), 7, 'FXH', 'Paso medio. Dejar al caballo estirarse en riendas largas', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-PRE'), 8, 'H Entre H y C', 'Volver a tomar las riendas. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-PRE'), 9, 'CB BE', 'Trote de trabajo. Semicírculo de 20 m al trote sentado', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-PRE'), 10, 'Antes de E EHCM', 'Galope de trabajo. Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-PRE'), 11, 'MF FA', 'Alargar los trancos. Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-PRE'), 12, 'Entre A y K KXM', 'Trote de trabajo. Cambio de mano alargando los trancos', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-PRE'), 13, 'M Entre M y C', 'Trote de trabajo sentado. Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-PRE'), 14, 'HM MCH', 'Semicírculo de 20 m a galope de trabajo. Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-PRE'), 15, 'HK K', 'Alargar los trancos. Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-PRE'), 16, 'Entre K y A AF FK', 'Trote de trabajo. Trote de trabajo. Semicírculo de 20 m', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-PRE'), 17, 'K A X', 'Volver a tomar las riendas. Doblar a lo largo. Parada - Inmovilidad - Saludo', 1, 'movimiento');



INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('17', '4 años Final', 'RFHE-2022-CJ4-FIN', 'Caballos Jovenes', '4 años Final', 'final', 2022, '5''00"', 4, 50, 'FINAL CABALLOS DE 4 AÑOS', 'Reprise final caballos 4 años', 1, 0, 'RFHE-2022-CJ4-FIN');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 1, 'A C', 'Entrada al trote de trabajo por la línea central sin saludo. Pista a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 2, 'R', 'Círculo de 15 m. de diámetro', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 3, 'RK K', 'Cambio de mano por diagonal alargando el trote. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 4, 'P', 'Círculo de 15 m. de diámetro', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 5, 'PH H', 'Cambio de mano por diagonal alargando el trote. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 6, 'CX X', 'Serpentina de 2 bucles llegando a la pista en cada bucle. Parada. Inmovilidad 5 seg. Partir al trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 7, 'B BM', 'Pista a la izquierda. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 8, 'M MCH', 'Paso medio. Paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 9, 'SR', 'Medio círculo de 20 m. de diámetro con riendas largas', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 10, 'M C', 'Paso medio. Trote de trabajo sentado y círculo de 15 m. de diámetro', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 11, 'CE E', 'Al llegar a C partir al galope de trabajo a la izquierda. Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 12, 'E', 'Círculo a la izquierda de 20 m. de diámetro', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 13, 'EAF', 'Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 14, 'FS', 'Cambio de mano por diagonal alargando el galope', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 15, 'S H', 'Galope de trabajo. Trote de trabajo sentado', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 16, 'C', 'Partir al galope a la derecha y círculo de 20 m. de diámetro', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 17, 'MV', 'Cambio de mano por diagonal alargando el galope', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 18, 'VK K', 'Galope de trabajo. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 19, 'A', 'Doblar a lo largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 20, 'X', 'Parada. Inmovilidad y saludo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 101, 'NC1', 'Trote: Ritmo, soltura, elasticidad, impulsión, dorso flexible, aptitud para flexionar las articulaciones del tercio posterior', 1, 'nota_conjunto'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 102, 'NC2', 'Paso: Ritmo, relajación, actividad, amplitud', 1, 'nota_conjunto'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 103, 'NC3', 'Galope: Ritmo, soltura, elasticidad, equilibrio natural, tendencia cuesta arriba (elevación de la cruz) y aptitud para flexionar las articulaciones del tercio posterior', 1, 'nota_conjunto'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 104, 'NC4', 'Sumisión, contacto, rectitud, obediencia, respuesta a las ayudas del jinete', 1, 'nota_conjunto'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 105, 'NC5', 'Expectativas de futuro: Potencial como caballo joven de doma, standard de entrenamiento según la escala de entrenamiento', 1, 'nota_conjunto');



INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('18', '4 años Experimental', 'RFHE-2022-CJ4-EXP', 'Caballos Jovenes', '4 años Experimental', 'experimental', 2022, '5''00"', 4, 100, '4 AÑOS EXPERIMENTAL', 'Reprise experimental 4 años', 1, 0, 'RFHE-2022-CJ4-EXP');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-EXP'), 1, 'Ejercicio 1', 'Círculo 20 mts al trote de trabajo a cada mano', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-EXP'), 2, 'Ejercicio 2', 'Alargamiento de algunos trancos al trote en línea recta', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-EXP'), 3, 'Ejercicio 3', 'Círculo de 20 mts a galope de trabajo a cada mano', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-EXP'), 4, 'Ejercicio 4', 'Alargamiento de algunos trancos al galope en línea recta a cada mano', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-EXP'), 5, 'Ejercicio 5', 'Transiciones Galope - Trote - Galope a cada mano', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-EXP'), 6, 'Ejercicio 6', 'Transiciones Trote - Paso - Trote', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-EXP'), 7, 'Ejercicio 7', 'Alargamiento del paso (mínimo 40 mts) Similar a requerimientos de paso largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-EXP'), 8, 'A', 'Salir de la pista por A al paso en riendas largas', 1, 'movimiento');



INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('19', '5 años Preliminar', 'RFHE-2022-CJ5-PRE', 'Caballos Jovenes', '5 años Preliminar', 'preliminar', 2022, '5''00"', 5, 100, 'PRELIMINAR CABALLOS DE 5 AÑOS 2022', 'Reprise preliminar caballos 5 años', 1, 0, 'RFHE-2022-CJ5-PRE');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-PRE'), 1, 'A X', 'Entrada al trote de trabajo. Parada y saludo, partir al trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-PRE'), 2, 'C', 'Pista a mano derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-PRE'), 3, 'CB', 'Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-PRE'), 4, 'BX XE', 'Semicírculo de 10 m a mano derecha. Semicírculo de 10 m a mano izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-PRE'), 5, 'VKAF', 'Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-PRE'), 6, 'FXH H', 'Trote medio. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-PRE'), 7, 'CA', 'Serpentina de 3 bucles (tocando el lado mayor)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-PRE'), 8, 'KXM MC', 'Trote medio. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-PRE'), 9, 'C', 'Parada - paso atrás (un largo del caballo) e inmediatamente partir al paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-PRE'), 10, 'HB BK', 'Paso medio. Paso medio, dejando al caballo estirarse en riendas largas', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-PRE'), 11, 'K KA', 'Volver a tomar las riendas. Paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-PRE'), 12, 'A AFB', 'Galope de trabajo a mano izquierda. Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-PRE'), 13, 'BRSE', 'Galope medio. Entre R y S semicírculo (20 m). Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-PRE'), 14, 'KDE E', 'Semicírculo de 10 m, volviendo a la pista en E. Galope en trocado', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-PRE'), 15, 'Antes de H ME', 'Cambio de pie simple. Cambio de mano', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-PRE'), 16, 'EK KAFP', 'Galope en trocado. Trote de trabajo. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-PRE'), 17, 'PV', 'Semicírculo de 20 m, permitiendo al caballo estirarse en riendas largas, al trote levantado', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-PRE'), 18, 'Entre V y K', 'Volver a tomar las riendas', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-PRE'), 19, 'A', 'Doblar a lo largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-PRE'), 20, 'X', 'Parada - inmovilidad - saludo', 1, 'movimiento');



INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('20', '5 años Final', 'RFHE-2022-CJ5-FIN', 'Caballos Jovenes', '5 años Final', 'final', 2022, '5''00"', 5, 50, 'FINAL CABALLOS DE 5 AÑOS 2022', 'Reprise final caballos 5 años', 1, 0, 'RFHE-2022-CJ5-FIN');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-FIN'), 1, 'Trote', 'Ritmo, soltura, elasticidad, impulsión, dorso flexible, aptitud para avanzar y voluntad para la reunión', 1, 'nota_conjunto'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-FIN'), 2, 'Paso', 'Ritmo, relajación, actividad, aptitud para avanzar', 1, 'nota_conjunto'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-FIN'), 3, 'Galope', 'Ritmo, soltura, elasticidad, equilibrio natural, impulsión, voluntad para la reunión, aptitud para avanzar y tendencia cuesta arriba', 1, 'nota_conjunto'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-FIN'), 4, 'Sumisión', 'Elasticidad, flexibilidad, contacto, rectitud, obediencia, aptitud para sostenerse por sí mismo', 1, 'nota_conjunto'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-FIN'), 5, 'Expectativas de futuro', 'Potencial como caballo de doma. Standard de entrenamiento (según la escala de entrenamiento)', 1, 'nota_conjunto');



INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('21', '6 años Preliminar', 'RFHE-2022-CJ6-PRE', 'Caballos Jovenes', '6 años Preliminar', 'preliminar', 2022, '5''00"', 6, 100, 'PRELIMINAR CABALLOS DE 6 AÑOS 2022', 'Reprise preliminar caballos 6 años', 1, 0, 'RFHE-2022-CJ6-PRE');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-PRE'), 1, 'A X', 'Entrada al trote de trabajo. Parada y saludo, partir al trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-PRE'), 2, 'C', 'Pista a mano izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-PRE'), 3, 'EX XB', 'Semicírculo de 10 m a mano izquierda. Semicírculo de 10 m a mano derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-PRE'), 4, 'BFAK', 'Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-PRE'), 5, 'KXM MCH', 'Trote medio. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-PRE'), 6, 'SV', 'Espalda adentro a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-PRE'), 7, 'VL LS', 'Semicírculo de 10 m. Apoyar a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-PRE'), 8, 'SHCM', 'Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-PRE'), 9, 'RP', 'Espalda adentro a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-PRE'), 10, 'PL LR', 'Semicírculo de 10 m. Apoyar a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-PRE'), 11, 'RMCH', 'Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-PRE'), 12, 'HXF FA', 'Trote largo. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-PRE'), 13, 'A', 'Parada - 4 ó 5 pasos atrás y partir al paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-PRE'), 14, 'KLB BI', 'Paso medio. Paso largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-PRE'), 15, 'HC', 'Paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-PRE'), 16, 'C', 'Partir a galope reunido a mano derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-PRE'), 17, 'PV V', 'Semicírculo de 20 m y ceder y volver a tomar las riendas algunos trancos. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-PRE'), 18, 'EI M Cerca de I', 'Cambio de mano. Cambio de pie en el aire', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-PRE'), 19, 'MCH H EK KAF', 'Galope reunido. Galope largo. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-PRE'), 20, 'FLE Cerca de L', 'Cambio de mano. Cambio de pie en el aire', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-PRE'), 21, 'ESRB BFA', 'Galope medio, entre S y R semicírculo de 20 m. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-PRE'), 22, 'Antes de A A', 'Trote reunido. Doblar a lo largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-PRE'), 23, 'X', 'Parada - inmovilidad - saludo', 1, 'movimiento');



INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('22', '6 años Final', 'RFHE-2022-CJ6-FIN', 'Caballos Jovenes', '6 años Final', 'final', 2022, '5''15"', 6, 50, 'FINAL CABALLOS DE 6 AÑOS 2022', 'Reprise final caballos 6 años', 1, 0, 'RFHE-2022-CJ6-FIN');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-FIN'), 1, 'A X', 'Entrada al trote de trabajo. Parada y saludo, partir al trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-FIN'), 2, 'C', 'Pista a mano derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-FIN'), 3, 'RK', 'Trote medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-FIN'), 4, 'KAF', 'Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-FIN'), 5, 'FB', 'Espalda adentro a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-FIN'), 6, 'B', 'Círculo de 10 m', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-FIN'), 7, 'BG', 'Apoyar a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-FIN'), 8, 'C', 'Pista a mano izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-FIN'), 9, 'HXF', 'Trote medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-FIN'), 10, 'FAK', 'Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-FIN'), 11, 'KE', 'Espalda adentro a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-FIN'), 12, 'E', 'Círculo de 10 m', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-FIN'), 13, 'EG', 'Apoyar a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-FIN'), 14, 'Antes de C', 'Paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-FIN'), 15, 'CM', 'Paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-FIN'), 16, 'MEV', 'Paso largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-FIN'), 17, 'Antes de V', 'Paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-FIN'), 18, 'V', 'Doblar a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-FIN'), 19, 'Entre L y P', 'Reunir para la media pirueta - media pirueta a la izquierda - paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-FIN'), 20, 'Entre L y V', 'Reunir para la media pirueta - media pirueta a la derecha - paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-FIN'), 21, 'L', 'Galope reunido a mano derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-FIN'), 22, 'P(FAK)', 'Doblar a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-FIN'), 23, 'KVPF', 'Galope medio, entre V y P semicírculo de 20 m', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-FIN'), 24, 'FAK', 'Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-FIN'), 25, 'KLB', 'Cambio de mano', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-FIN'), 26, 'L', 'Cambio de pie en el aire', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-FIN'), 27, 'BMCH', 'Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-FIN'), 28, 'HI', 'Cambio de mano', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-FIN'), 29, 'I', 'Cambio de pie en el aire', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-FIN'), 30, 'BF', 'Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-FIN'), 31, 'FDB', 'Semicírculo de 10 m volviendo a la pista en B', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-FIN'), 32, 'Entre R y M', 'Cambio de pie en el aire', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-FIN'), 33, 'MCH', 'Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-FIN'), 34, 'HEV', 'Galope largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-FIN'), 35, 'V', 'Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-FIN'), 36, 'KDE', 'Semicírculo de 10 m volviendo a la pista en E', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-FIN'), 37, 'Entre S y H', 'Cambio de pie en el aire', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-FIN'), 38, 'CM', 'Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-FIN'), 39, 'MXK', 'Trote largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-FIN'), 40, 'K', 'Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-FIN'), 41, 'A', 'Doblar a lo largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ6-FIN'), 42, 'X', 'Parada - inmovilidad - saludo', 1, 'movimiento');



INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('23', '7 años Final', 'RFHE-2022-CJ7-FIN', 'Caballos Jovenes', '7 años Final', 'final', 2022, '5''15"', 7, 330, 'FINAL CABALLOS DE 7 AÑOS 2022', 'Reprise final caballos 7 años', 1, 0, 'RFHE-2022-CJ7-FIN');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN'), 1, 'A X XC', 'Entrada al galope reunido. Parada - inmovilidad y saludo. Partir al trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN'), 2, 'C HXF F', 'Pista a mano izquierda. Cambio de mano al trote medio. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN'), 3, 'FAK', 'Transiciones en H y F. El trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN'), 4, 'KE', 'Espalda adentro a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN'), 5, 'EX XB', 'Media vuelta a la derecha (10 m). Media vuelta a la izquierda (10 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN'), 6, 'BG G C', 'Apoyo a la izquierda. Seguir la línea central. Pista a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN'), 7, 'RS SHCM Entre S y H', 'Medio círculo a la derecha (20 m). Dejando al caballo estirarse con riendas largas. Trote reunido. Recoger las riendas', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN'), 8, 'MXK K', 'Trote largo. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN'), 9, 'KAF', 'Transiciones en M y K. El trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN'), 10, 'FB', 'Espalda adentro a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN'), 11, 'BX XE', 'Media vuelta a la izquierda (10 m). Media vuelta a la derecha (10 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN'), 12, 'EG G', 'Apoyo a la derecha. Seguir la línea central', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN'), 13, 'Antes de C C CH', 'Paso medio. Pista a la izquierda. Paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN'), 14, 'HIB', 'Paso Largo', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN'), 15, 'BPL(V)', 'Paso reunido', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN'), 16, 'Entre L y V L(P)', 'Media pirueta a la derecha. Seguir al paso reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN'), 17, 'Entre L y P L(P)', 'Media pirueta a la izquierda. Seguir al paso reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN'), 18, 'Entre L y V VKA', 'Partir al galope a la izquierda. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN'), 19, 'A DE E', 'Doblar a lo largo. Apoyo a la izquierda. Cambio de pie en el aire', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN'), 20, 'EG C', 'Apoyo a la derecha. Pista a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN'), 21, 'MXK', 'Galope largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN'), 22, 'K KAF', 'Galope reunido y cambio de pie en el aire. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN'), 23, 'F(X) Entre F y X', 'Proceder hacia X a galope reunido. Media pirueta a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN'), 24, 'FA A AK', 'Galope en trocado. Cambio de pie en el aire. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN'), 25, 'K(X) Entre K y X', 'Avanzar hacia X a galope reunido. Media pirueta a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN'), 26, 'KA A AF', 'Galope en trocado. Cambio de pie en el aire. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN'), 27, 'FS', 'Sobre la diagonal corta 3 cambios de pie cada 4 trancos', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN'), 28, 'SR', 'Medio círculo a la derecha (20 m). Ceder las riendas y retomarlas durante 3 trancos', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN'), 29, 'RK', 'Diagonal corta con 3 cambios de pie cada 3 trancos. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN'), 30, 'A X', 'Doblar en la línea central. Parada - inmovilidad - saludo', 1, 'movimiento');



INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('24', 'Clasica 1', 'RFHE-2023-CLA-1', 'Clasica', 'Clasica 1', 'individual', 2023, '5''40"', 6, 330, 'CLASICA 1 2023', 'Reprise clasica 1', 1, 0, 'RFHE-2023-CLA-1');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-1'), 1, 'A X', 'Entrada galope reunido. Parada, saludo. Partir al trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-1'), 2, 'C MB', 'Pista mano derecha. Espalda adentro a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-1'), 3, 'B', 'Círculo de 8 m. de diámetro', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-1'), 4, 'BF', 'Grupa dentro (Travers)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-1'), 5, 'A DB', 'Doblar por la línea central. Apoyar a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-1'), 6, 'BM M (MCH)', 'Trote medio. Trote reunido. El trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-1'), 7, 'HE', 'Espalda adentro', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-1'), 8, 'E', 'Círculo de 8 m. de diámetro', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-1'), 9, 'EK', 'Grupa adentro (travers)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-1'), 10, 'A DE', 'Doblar por la línea central. Apoyar a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-1'), 11, 'EH H', 'Trote medio. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-1'), 12, 'C (CMR)', 'Paso medio. El paso medio', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-1'), 13, 'RXVK', 'Cambio de mano al paso largo', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-1'), 14, 'K entre D y F', 'Doblar a paso medio. Media pirueta a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-1'), 15, 'entre D y K', 'Media Pirueta a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-1'), 16, 'D F', 'Partir a galope reunido a la izquierda. Pista a mano izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-1'), 17, 'PM M', 'Galope medio. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-1'), 18, 'Hasta 21 CA', 'Serpentina de cuatro bucles, con cambios de mano al pasar por la línea central terminando a mano derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-1'), 19, 'Primer cambio de pie', 'Primer cambio de pie', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-1'), 20, 'Segundo cambio de pie', 'Segundo cambio de pie', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-1'), 21, 'Tercer cambio de pie', 'Tercer cambio de pie', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-1'), 22, '(C-A)', 'El galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-1'), 23, 'KXM M', 'Galope largo. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-1'), 24, 'Transiciones', 'Las transiciones de galope largo a reunido y de reunido a largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-1'), 25, 'MC', 'El trocado', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-1'), 26, 'C HXF F', 'Trote reunido. Trote largo. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-1'), 27, 'Transiciones', 'Las transiciones del largo a reunido y de reunido a largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-1'), 28, 'A X', 'Doblar a lo largo. Parada - inmovilidad - saludo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-1'), 101, 'NC1', 'Impresion General (Armonia y presentacion, posicion y asiento del jinete/amazona, correccion y efecto de las ayudas)', 1, 'nota_conjunto');



INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('25', 'Clasica 2', 'RFHE-2023-CLA-2', 'Clasica', 'Clasica 2', 'individual', 2023, '5''40"', 6, 280, 'CLASICA 2 2023', 'Reprise clasica 2', 1, 0, 'RFHE-2023-CLA-2');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-2'), 1, 'A X', 'Entrada a galope reunido. Parada, saludo. Partir a trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-2'), 2, 'C MB', 'Pista a mano derecha. Espalda adentro', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-2'), 3, 'BLK K', 'Cambio de mano a trote medio. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-2'), 4, 'A DG C', 'Doblar por la línea central. Tres contraccambios a la izquierda y a la derecha, a 5, 10, 5 m. de la línea del centro, terminando a la izquierda. Pista a mano izquierda', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-2'), 5, 'HE', 'Espalda adentro', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-2'), 6, 'ELF F (FAK)', 'Cambio de mano al trote medio. Trote reunido. El trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-2'), 7, 'KXM M', 'Cambio de mano al trote largo. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-2'), 8, 'Transiciones', 'Transiciones del largo a reunido y del reunido al largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-2'), 9, 'C (CHS)', 'Paso medio. El paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-2'), 10, 'SXP', 'Cambio de mano al paso largo', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-2'), 11, 'P F (PFD)', 'Paso reunido. Doblar a la derecha. El paso reunido', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-2'), 12, 'D', 'Parada, 6 pasos atrás, partir a galope reunido a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-2'), 13, 'K VM', 'Doblar a la derecha. Galope medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-2'), 14, 'M (MCH)', 'Galope reunido y cambio de pie. El galope reunido', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-2'), 15, 'HXF F', 'Galope largo. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-2'), 16, 'Transiciones', 'Las transiciones del galope reunido a largo y de largo a reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-2'), 17, 'F', 'Cambio de pie', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-2'), 18, 'A L', 'Doblar por la línea central. Círculo a la derecha de 8 m', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-2'), 19, 'X', 'Cambio de pie', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-2'), 20, 'I', 'Círculo a la izquierda de 8 m', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-2'), 21, 'G', 'Cambio de pie', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-2'), 22, 'C B X G', 'Pista a mano derecha. Doblar a la derecha. Doblar a la derecha. Parada, inmovilidad y saludo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-2'), 101, 'NC1', 'Impresion General (Armonia y presentacion, posicion y asiento del jinete/amazona, correccion y efecto de las ayudas)', 1, 'nota_conjunto');



INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('26', 'Clasica 3', 'RFHE-2023-CLA-3', 'Clasica', 'Clasica 3', 'individual', 2023, '5''40"', 6, 340, 'CLASICA 3 2023', 'Reprise clasica 3', 1, 0, 'RFHE-2023-CLA-3');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-3'), 1, 'A X', 'Entrada a galope reunido. Parada saludo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-3'), 2, 'C HP P', 'Pista a mano izquierda. Trote medio. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-3'), 3, 'A DG C', 'Doblar por la línea central. 3 contraccambios a la derecha e izquierda a 5, 10 y 5 m de la línea del centro, terminando a la derecha. Pista a la derecha', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-3'), 4, 'MXK K', 'Cambio de mano al trote largo. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-3'), 5, 'Transiciones', 'Las transiciones del trote reunido al largo y del largo al reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-3'), 6, 'A FV (AFV)', 'Paso medio. Paso medio. El paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-3'), 7, 'VXR', 'Paso largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-3'), 8, 'R M Entre G y H', 'Paso reunido. Doblar a la izquierda. Media pirueta a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-3'), 9, 'Entre G y M', 'Media pirueta a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-3'), 10, '(RMC(H)G(H)G)', 'El paso reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-3'), 11, 'G H', 'Salida a galope reunido a la izquierda. Pista a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-3'), 12, 'SK K', 'Galope medio. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-3'), 13, 'A L', 'Doblar por la línea central. Círculo a la izquierda de 8 m', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-3'), 14, 'LS', 'Apoyar a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-3'), 15, 'H (HCM)', 'Cambio de pie. El galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-3'), 16, 'MF F', 'Galope medio. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-3'), 17, 'A L', 'Doblar por la línea central. Círculo a la derecha de 8 m', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-3'), 18, 'LR', 'Apoyar a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-3'), 19, 'M', 'Cambio de pie', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-3'), 20, 'HXF', 'Cambio de mano por diagonal con tres cambios de pie', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-3'), 21, 'Primer cambio de pie', 'El primer cambio de pie (después de H)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-3'), 22, 'Segundo cambio de pie', 'Segundo cambio de pie (en X)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-3'), 23, 'Tercer cambio de pie', 'Tercer cambio de pie (antes de F)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-3'), 24, '(HXF)', 'El galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-3'), 25, 'A X', 'Doblar por la línea del centro. Parada - inmovilidad - saludo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-3'), 101, 'NC1', 'Impresion General (Armonia y presentacion, posicion y asiento del jinete/amazona, correccion y efecto de las ayudas)', 1, 'nota_conjunto');



INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('27', 'Promocion 2', 'RFHE-2024-PRO-2', 'Promocion', 'Promocion 2', 'individual', 2024, '4''00"', 6, 170, 'PROMOCION 2 2024', 'Reprise promocion 2', 1, 0, 'RFHE-2024-PRO-2');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-PRO-2'), 1, 'A X', 'Entrada al trote de trabajo. Parada - inmovilidad - saludo. Partir al trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-PRO-2'), 2, 'C E', 'Pista a mano izquierda. Doblar a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-PRO-2'), 3, 'X X', 'Círculo a la izquierda de 10 metros. Círculo a la derecha de 10 metros', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-PRO-2'), 4, 'XBFA', 'Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-PRO-2'), 5, 'AC', 'Serpentina de cuatro bucles iguales llegando a cada lado de la pista', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-PRO-2'), 6, 'Entre C y H HE', 'Galope de trabajo a mano izquierda. Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-PRO-2'), 7, 'E EKAF', 'Círculo a la izquierda de 15 metros de diámetro. Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-PRO-2'), 8, 'FXH', 'En la diagonal, en X trote de trabajo, entre H y C galope de trabajo a mano derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-PRO-2'), 9, 'HCB', 'Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-PRO-2'), 10, 'B', 'Círculo a la derecha de 15 metros de diámetro', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-PRO-2'), 11, 'BFA', 'Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-PRO-2'), 12, 'A K', 'Trote de trabajo. Paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-PRO-2'), 13, 'KE', 'Paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-PRO-2'), 14, 'EB', 'Semicírculo de 20 m de diámetro al paso libre en riendas largas', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-PRO-2'), 15, 'BF F', 'Paso medio. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-PRO-2'), 16, 'A G', 'Doblar a lo largo. Parada - Inmovilidad - Saludo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-PRO-2'), 101, 'NC1', 'Impresion General (Armonia y presentacion, posicion y asiento del jinete/amazona, correccion y efecto de las ayudas)', 1, 'nota_conjunto');



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



INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('29', 'Rider 1B', 'RFHE-2024-RID-1B', 'Rider', 'Rider 1B', 'individual', 2024, '4''45"', 6, 150, 'RIDER 1B 2024', 'Reprise rider 1B', 1, 0, 'RFHE-2024-RID-1B');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1B'), 1, 'A', 'Entrada al trote de trabajo. Seguir por la línea del centro sin parada. Pista a mano izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1B'), 2, 'E', 'Circulo a la izquierda de 20m. diametro. Medio circulo izquierda de 10m. hasta D dirigirse hacia H', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1B'), 3, 'B', 'Circulo a la derecha de 20m. diametro. Medio circulo a la derecha de 10m. hasta D dirigirse hacia M', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1B'), 4, 'C', 'Paso Medio. Cambio de mano al paso Medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1B'), 5, 'XFK', 'Paso libre con riendas largas. Paso Medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1B'), 6, 'E', 'Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1B'), 7, 'Entre H&C Entre C&F', 'Galope de trabajo a la derecha. Enseñar algún tranco de galope medio. Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1B'), 8, 'AX Cerca X', 'Medio circulo a la derecha de 20m. Caer al trote unos trancos (3-5) y nuevamente partir a Galope a mano izquierda. Medio Circulo a la izquierda de 20m. Hacia C', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1B'), 9, 'Entre C&K', 'Enseñar algún tranco de galope medio. Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1B'), 10, 'AX Cerca X', 'Medio circulo a la izquierda de 20m. Caer al trote unos trancos (3-5) y nuevamente partir a Galope a mano derecha. Medio Circulo a la derecha de 20m. Hacia C', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1B'), 11, 'C', 'Trote de trabajo. Cambio de mano mostrando algún tranco de trote medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1B'), 12, 'KAF', 'Trote de trabajo. Cambio de mano mostrando algún tranco de trote medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1B'), 13, 'HB B', 'Trote de Trabajo. Circulo a la derecha de 20m. dejando al caballo estirarse, recogiendo las riendas al entrar nuevamente en pista en B', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1B'), 14, 'BA A D', 'Trote de Trabajo. Doblar por la línea del centro. Paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1B'), 15, 'X', 'Parada-Inmovilidad-Saludo', 1, 'movimiento');



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



INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('31', 'Rider 2A', 'RFHE-2024-RID-2A', 'Rider', 'Rider 2A', 'individual', 2024, '3''30"', 6, 270, 'RIDER 2A 2024', 'Reprise rider 2A', 1, 0, 'RFHE-2024-RID-2A');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2A'), 1, 'A X XC', 'Entrada al trote de trabajo. Parada - inmovilidad - saludo. Trote de Trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2A'), 2, 'C MXK KA', 'Pista a mano derecha. Trote Medio. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2A'), 3, 'Transiciones', 'Transiciones en M & K', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2A'), 4, 'A L', 'Doblar a lo largo. Ceder a la pierna a la derecha, entrando nuevamente en la pista entre R y M', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2A'), 5, 'C', 'Circulo a la izquierda de 20m de diámetro, al pasar por la línea del centro, ceder las riendas algunos trancos, y después retomarlas', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2A'), 6, 'HXF FA', 'Trote medio. Trote de Trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2A'), 7, 'Transiciones', 'Transiciones en H & F', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2A'), 8, 'A L', 'Doblar a lo largo. Ceder a la pierna a la izquierda, entrando nuevamente en la pista entre S y H', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2A'), 9, 'C', 'Trote levantado y circulo de 20m de diámetro a mano derecha. En la primera mitad del circulo, al cruzar la línea del centro, alargar lentamente las riendas y dejar que el caballo se estire en riendas largas, hacia delante y hacia abajo. Poco antes de C, retomar las riendas', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2A'), 10, 'CM', 'Paso Medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2A'), 11, 'MV', 'Paso Medio. Ceder las riendas y dejar al caballo estirarse en riendas largas', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2A'), 12, 'K KF', 'Partir al galope de trabajo a mano izquierda. Galope de Trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2A'), 13, 'FM MH', 'Galope Medio. Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2A'), 14, 'Transiciones', 'Las Transiciones en F & M', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2A'), 15, 'HB PV VS', 'Cambio de mano. Medio circulo en galope Trocado. Galope Trocado', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2A'), 16, 'S', 'Paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2A'), 17, 'H', 'Galope de Trabajo a mano derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2A'), 18, 'MF FK', 'Galope Medio. Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2A'), 19, 'Transiciones', 'Transiciones en M & F', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2A'), 20, 'KB RS SV', 'Cambio de mano en galope de trabajo. Medio Circulo en galope trocado. Galope Trocado', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2A'), 21, 'V', 'Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2A'), 22, 'A I', 'Doblar por la línea del centro. Parada-Inmovilidad- Saludo', 1, 'movimiento');



INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('32', 'Rider 2B', 'RFHE-2024-RID-2B', 'Rider', 'Rider 2B', 'individual', 2024, '5''30"', 6, 220, 'RIDER 2B 2024', 'Reprise rider 2B', 1, 0, 'RFHE-2024-RID-2B');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2B'), 1, 'A X C', 'Entrada al trote de trabajo. Parada - inmovilidad - saludo. Partir al Trote de Trabajo. Pista a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2B'), 2, 'CE E', 'Trote de trabajo. Doblar a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2B'), 3, 'X B', 'Circulo izquierda de 15m de diámetro, seguido de un círculo a la derecha de 15 m. de diámetro. Pista a mano derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2B'), 4, 'BAK KXM M', 'Trote de trabajo. Cambio de mano al trote medio. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2B'), 5, 'C G', 'Doblar por la línea del centro. Cesión a la pierna a mano derecha, entrando en la pista entre E & K', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2B'), 6, 'KF FXH H', 'Trote de trabajo. Cambio de mano al trote medio. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2B'), 7, 'C G', 'Doblar por la línea del centro. Cesión a la pierna a mano izquierda, entrando en la pista entre B & F', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2B'), 8, 'FA A', 'Trote de trabajo. Paso libre con riendas largas', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2B'), 9, 'KB', 'Cambio de mano en Paso libre con riendas largas', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2B'), 10, 'BH', 'Cambio de mano en paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2B'), 11, 'C', 'Parada-Inmovilidad. Paso atrás Aproximadamente la longitud de un caballo, e inmediatamente partir al trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2B'), 12, 'M', 'Galope de trabajo a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2B'), 13, 'A', 'Circulo a la derecha de 15m. de diámetro. Al volver a entrar en la pista en A, ceder y recoger la rienda interior', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2B'), 14, 'KH', 'Bucle de 6 a 8 metros', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2B'), 15, 'B', 'Medio círculo a la derecha de 10m, de diámetro, seguido de medio círculo a la izquierda de 10m. de diámetro hasta E, cambiando de pie al pasar por X con trancos de trote', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2B'), 16, 'EA A', 'Galope de trabajo. Circulo a la izquierda de 15m. de diámetro. Al volver a entrar en la pista en A, ceder y recoger la rienda interior', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2B'), 17, 'FM', 'Bucle de 6 a 8 metros', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2B'), 18, 'C CE', 'Circulo izquierda de 20m de diámetro, mostrando algún trance de Galope medio. Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2B'), 19, 'E', 'Medio círculo a la izquierda de 10m, de diámetro, seguido de medio círculo a la derecha de 10m. de diámetro hasta B, cambiando de pie al pasar por X con trancos de trote', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2B'), 20, 'B', 'Circulo a la derecha de 20m. de diámetro, dejando al caballo estirarse unos trancos. Al entrar en la pista en B, recoger las riendas', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2B'), 21, 'F', 'Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2B'), 22, 'A X', 'Doblar por la línea del centro. Parada-Inmovilidad - Saludo', 1, 'movimiento');



INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('33', 'Rider 2C', 'RFHE-2024-RID-2C', 'Rider', 'Rider 2C', 'individual', 2024, '5''30"', 6, 200, 'RIDER 2C 2024', 'Reprise rider 2C', 1, 0, 'RFHE-2024-RID-2C');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2C'), 1, 'A X C', 'Entrada al trote de trabajo. Parada - inmovilidad - saludo. Partir al Trote de Trabajo. Pista a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2C'), 2, 'S E X B', 'Circulo a la izquierda de 10m. de diámetro. Doblar a lo ancho. Parada, 3 - 4 pasos atrás. Y partir al trote trabajo. Doblar a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2C'), 4, 'P A Entre D & L BMC', 'Circulo a la derecha de 10m. de diámetro. Doblar por la línea del centro. Cesión a la pierna a mano derecha, hasta B. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2C'), 6, 'C Entre G & I BFAV', 'Doblar por la línea del centro. Cesión a la pierna a mano izquierda, hasta B. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2C'), 7, 'VXR', 'Cambio de mano a trote medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2C'), 8, 'R RMC', 'Trote de trabajo. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2C'), 9, 'C CHS', 'Paso medio. Paso Medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2C'), 10, 'SXP', 'Cambio de mano en paso libre, con riendas largas', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2C'), 11, 'PA A', 'Paso Medio. Galope reunido a mano derecha directamente desde el paso', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2C'), 12, 'AKV V V', 'Galope reunido. Circulo a la derecha de 20m de diámetro, mostrando algún tronco de galope medio. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2C'), 13, 'E X B BR', 'Doblar a la derecha. Cambio de pie con 2 - 3 trancos de trote. Doblar a la izquierda. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2C'), 14, 'R RC', 'Circulo a la izquierda de 20m de diámetro, mostrando algún tranco de galope medio. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2C'), 15, 'CA', 'Serpentina de 3 bucles al galope reunido, con cambios simples cada vez que se cruza la línea del centro. Acabando a mano izquierda en A Primer cambio simple', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2C'), 16, 'Segundo Cambio simple', 'Segundo Cambio simple', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2C'), 17, 'Serpentina', 'Serpentina: calidad del galope, y trazado de los bucles', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2C'), 18, 'A FX X', 'Trote reunido. Diagonal en trote reunido. Tomar la línea del centro', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2C'), 19, 'G', 'Parada-Inmovilidad - Saludo', 1, 'movimiento');



INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('34', 'Rider 3A', 'RFHE-2024-RID-3A', 'Rider', 'Rider 3A', 'individual', 2024, '5''30"', 6, 340, 'RIDER 3A 2024', 'Reprise rider 3A', 1, 0, 'RFHE-2024-RID-3A');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3A'), 1, 'A X XC', 'Entrada al trote de trabajo. Parada - inmovilidad - saludo. Trote de Trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3A'), 2, 'C MB', 'Pista a mano derecha. Espalda dentro a la derecha', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3A'), 3, 'BX XE', 'Medio circulo a la derecha 10m. Medio circulo a la izquierda 10m', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3A'), 4, 'EK', 'Cabeza al muro', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3A'), 5, 'FM MH', 'Trote Medio. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3A'), 6, 'Transiciones', 'Transiciones en F & M', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3A'), 7, 'HE', 'Espalda dentro a la izquierda', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3A'), 8, 'EX XB', 'Medio circulo a la izquierda 10m. Medio circulo a la derecha 10m', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3A'), 9, 'BF', 'Cabeza al muro', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3A'), 10, 'KH HR', 'Trote Medio. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3A'), 11, 'Transiciones', 'Transiciones en K & H', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3A'), 12, 'R Entre R&B', 'Paso medio. Reunir el paso y media pirueta a la derecha(1-3m), y seguir al paso medio', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3A'), 13, 'RS', 'Medio circulo a la izquierda de 20m', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3A'), 14, 'S Entre S&E', 'Paso medio. Reunir el paso y media pirueta a la izquierda(1-3m), y seguir al paso medio', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3A'), 15, 'H HC', 'Partir al galope de trabajo a la derecha. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3A'), 16, 'CA', 'Serpentina de tres bucles, el primero y el último en firme, el segundo en trocado', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3A'), 17, 'KB', 'Cambio de mano con cambio de pie simple cerca de L', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3A'), 18, 'RS', 'Medio circulo de 20m. Al cruzar la línea del centro ceder un momento las riendas y retomarlas antes de entrar en pista', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3A'), 19, 'SK K', 'Galope medio. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3A'), 20, 'Transiciones', 'Transiciones en S&K', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3A'), 21, 'AC', 'Serpentina de tres bucles, el primero y el último en firme, el segundo en trocado', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3A'), 22, 'HB', 'Cambio de mano con cambio de pie simple cerca de L', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3A'), 23, 'P', 'Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3A'), 24, 'A X', 'Doblar por la línea del centro. Parada-Inmovilidad- Saludo', 1, 'movimiento');



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



INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('36', 'Rider 3C', 'RFHE-2024-RID-3C', 'Rider', 'Rider 3C', 'individual', 2024, '5''00"', 6, 230, 'RIDER 3C 2024', 'Reprise rider 3C', 1, 0, 'RFHE-2024-RID-3C');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3C'), 1, 'A X C', 'Entrada al trote reunido. Parada - inmovilidad - saludo. Partir al Trote reunido. Pista a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3C'), 2, 'E X', '½ Circulo a la izquierda de 10m. Diámetro, hasta X. ½ Circulo a la derecha de 10m. de diámetro hasta la B', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3C'), 3, 'BF', 'Cabeza al muro', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3C'), 4, 'KXM M', 'Cambio de mano al trote medio. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3C'), 5, 'HD A', 'Apoyo a la izquierda. Pista derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3C'), 6, 'E X', '½ Circulo a la derecha de 10m. Diámetro, hasta X. ½ Circulo a la izquierda de 10m. de diámetro hasta la B', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3C'), 7, 'BM', 'Cabeza al muro', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3C'), 8, 'HXF F', 'Cambio de mano al trote medio. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3C'), 9, 'KG C', 'Apoyo a la derecha. Pista a mano derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3C'), 10, 'MXK K A', 'Paso largo. Paso reunido. Doblar por la línea del centro', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3C'), 11, 'X', 'Partir al Galope reunido a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3C'), 12, 'C HEKA', 'Pista a mano izquierda. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3C'), 13, 'FG C', 'Apoyo a la izquierda. Pista a mano izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3C'), 14, 'HK K', 'Galope Medio. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3C'), 15, 'FXH', 'Cambio de mano con cambio de pie simple en X', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3C'), 16, 'MBFAK', 'Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3C'), 17, 'KG C', 'Apoyo a la derecha. Pista a mano derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3C'), 18, 'MF F', 'Galope Medio. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3C'), 19, 'KXM', 'Cambio de mano con cambio de pie simple en X', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3C'), 20, 'MCH E E', 'Galope reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3C'), 21, 'A X', 'Doblar por la línea del centro. Parada, 4 pasos atrás, y partir al trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3C'), 22, 'G', 'Parada inmovilidad y saludo', 1, 'movimiento');



INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('37', 'Rider 3D', 'RFHE-2024-RID-3D', 'Rider', 'Rider 3D', 'individual', 2024, '6''00"', 6, 340, 'RIDER 3D 2024', 'Reprise rider 3D', 1, 0, 'RFHE-2024-RID-3D');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 1, 'A X C', 'Entrada al Galope reunido. Parada-Inmovilidad-saludo, y partir al trote reunido. Pista a mano derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 2, 'MB', 'Espalda dentro a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 3, 'B', 'Circulo a la derecha de 10m. de diámetro', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 4, 'BF', 'Cabeza al muro', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 5, 'A DB', 'Doblar por la línea del centro. Apoyo a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 6, 'BM MH', 'Trote Medio. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 7, 'HE', 'Espalda dentro a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 8, 'E', 'Circulo a la izquierda de 10m. de diámetro', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 9, 'EK', 'Cabeza al muro', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 10, 'A DE', 'Doblar por la línea del centro. Apoyo a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 11, 'EH HC', 'Trote medio. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 12, 'C', 'Parada, 5 pasos atrás, y partir al paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 13, 'MRXVP', 'Paso largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 14, 'V K Entre D & F', 'Paso reunido. Doblar a la izquierda. Media pirueta a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 15, 'Entre D & K', 'Media pirueta a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 16, 'El Paso reunido', 'El Paso reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 17, 'D F', 'Partir al galope reunido a la izquierda. Doblar a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 18, 'PM M', 'Galope Medio. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 19, 'C GB', 'Doblar por la línea del centro. Apoyo a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 20, 'PV', 'Medio circulo a la derecha de 20m de diámetro al galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 21, 'E EC', 'Cambio de pie simple. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 22, 'C GE', 'Doblar por la línea del centro. Apoyo a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 23, 'VP', 'Medio circulo a la izquierda de 20m de diámetro al galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 24, 'B BCH', 'Cambio de pie simple. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 25, 'HP P PF', 'Cambio de mano al galope largo. Galope reunido. Galope trocado', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 26, 'F KXM M', 'Trote reunido. Cambio de mano al trote largo. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 27, 'MCE E X', 'Trote reunido. Doblar a la izquierda. Doblar a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3D'), 28, 'G', 'Parada-Inmovilidad-saludo', 1, 'movimiento');



INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('38', 'Intermedia I', 'RFHE-2022-INT-I', 'Intermedia', 'Intermedia I', 'individual', 2022, '5''30"', 7, 320, 'INTERMEDIA I 2022', 'Reprise intermedia I', 1, 0, 'RFHE-2022-INT-I');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 1, 'A X XC', 'Entrada a galope reunido. Parada - inmovilidad - saludo. Partir al trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 2, 'C HXF F FA', 'Pista a mano izquierda. Trote largo. Trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 3, 'A DX', 'Doblar a lo largo. Espalda adentro a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 4, 'X', 'Vuelta a la derecha (8 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 5, 'XM MC', 'Apoyar a la derecha. Trote reunido', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 6, 'C', 'Parada - inmovilidad. 5 pasos atrás y partir inmediatamente al trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 7, 'HX', 'Apoyar a la izquierda', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 8, 'X', 'Vuelta a la izquierda (8 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 9, 'XD D A', 'Espalda adentro a la izquierda. Línea central. Pista a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 10, 'KR', 'Trote medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 11, 'R RMGH', 'Paso reunido. Paso reunido', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 12, 'HB(P)', 'Paso largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 13, 'Antes de P P PFA', 'Paso reunido. Partir a galope reunido a mano derecha. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 14, 'A Entre D y G', 'Doblar a lo largo. 3 apoyos de 5 m a cada lado de la línea central con cambio de pie en cada cambio de dirección empezando y terminando a la derecha. Cambio de pie en el aire. Pista a mano izquierda', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 15, 'HXF', 'Galope largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 16, 'F', 'Galope reunido y cambio de pie en el aire', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 17, 'KXM', 'En la diagonal 5 cambios de pie en el aire cada 3 trancos', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 18, 'H(B)', 'En la diagonal', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 19, 'B', 'Cambio de pie en el aire', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 20, 'B(K)', 'En la diagonal', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 21, 'K', 'Cambio de pie en el aire', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 22, 'FXH', 'En la diagonal, 7 cambios de pie en el aire cada 2 trancos', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 23, 'C', 'Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 24, 'MXK', 'Trote largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 25, 'A X', 'Doblar a lo largo. Parada - inmovilidad - saludo', 1, 'movimiento');



INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('39', 'Intermedia II', 'RFHE-2022-INT-II', 'Intermedia', 'Intermedia II', 'individual', 2022, '5''25"', 7, 350, 'INTERMEDIA II 2022', 'Reprise intermedia II', 1, 0, 'RFHE-2022-INT-II');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-II'), 1, 'A X XC', 'Entrada al galope reunido. Parada - inmovilidad - saludo. Partir al trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-II'), 2, 'C HXF F FA', 'Pista a mano izquierda. Trote largo. Trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-II'), 3, 'A DG C', 'Doblar a lo largo. 3 apoyos de 5 m a cada lado de la línea central empezando y terminando a la derecha. Pista a mano derecha', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-II'), 4, 'Entre R y B', 'Transición a Passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-II'), 5, 'B (V)', 'En la Diagonal. Passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-II'), 6, 'Al cruzar la línea central', 'Piaffe 8 a 10 batidas (permitido avanzar 1 m.)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-II'), 7, 'Entrar/salir de piaffe', 'Transiciones passage - piaffe - passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-II'), 8, 'Desde Piaffe VKA', 'Passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-II'), 9, 'A', 'Piaffe 8 a 10 batidas (permitido avanzar 1 m.)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-II'), 10, 'A', 'Transiciones passage - piaffe - passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-II'), 11, 'AFP', 'Passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-II'), 12, 'PS', 'Paso largo', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-II'), 13, 'S SHC', 'Paso reunido. Paso reunido', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-II'), 14, 'C CM', 'Partir al galope reunido a mano derecha. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-II'), 15, 'MXK X KAFP', 'Galope medio. Cambio de pie en el aire. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-II'), 16, 'PX X', 'Apoyo a la izquierda. Por la línea central', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-II'), 17, 'I C', 'Pirueta a la izquierda. Pista a mano izquierda', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-II'), 18, 'HXF', 'Galope largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-II'), 19, 'F FAKV', 'Galope reunido y cambio de pie en el aire. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-II'), 20, 'VX X', 'Apoyo a la derecha. Por la línea central', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-II'), 21, 'I C', 'Pirueta a la derecha. Pista a mano derecha', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-II'), 22, 'MXK KAF', 'Galope reunido. En la diagonal 7 cambios de pie en el aire cada 2 trancos. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-II'), 23, 'FXH HC', 'En la diagonal 11 cambios de pie en el aire al trance. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-II'), 24, 'C CM', 'Trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-II'), 25, 'MXK K KA', 'Trote largo. Trote reunido. El Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-II'), 26, 'A Entre D y L LI', 'Doblar a lo largo. Transición a passage. Passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-II'), 27, 'I', 'Parada - inmovilidad - saludo', 1, 'movimiento');



INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('40', 'Intermedia A', 'RFHE-2022-INT-A', 'Intermedia', 'Intermedia A', 'individual', 2022, '5''10"', 8, 320, 'INTERMEDIA A 2022', 'Reprise intermedia A', 1, 0, 'RFHE-2022-INT-A');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-A'), 1, 'A X XC', 'Entrada al galope reunido. Parada - inmovilidad - saludo. Partir al trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-A'), 2, 'C HXF F', 'Pista a mano izquierda. Trote largo. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-A'), 3, 'FA', 'Transiciones en H y en F. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-A'), 4, 'A DG C CHS', 'Doblar a lo largo. 3 apoyos de 5 m a cada lado de la línea central empezando y terminando a la derecha. Pista a mano izquierda. Trote reunido', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-A'), 5, 'SR Entre la línea central y R', 'Semicírculo de 20m. Transición a passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-A'), 6, 'RMC', 'Passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-A'), 7, 'C PF[A]', 'Piaffe, 7-10 batidas (permitido avanzar hasta 2m). Continuar al trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-A'), 8, '[C]HS', 'Transiciones passage – piaffe – trote. El trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-A'), 9, 'SXP', 'Paso Largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-A'), 10, 'P PF[A]', 'Paso reunido. Paso reunido', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-A'), 11, 'cerca de A', 'Piaffe, 7-10 batidas (permitido avanzar hasta 2m). Partir al trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-A'), 12, '(A)K', 'Transiciones paso – piaffe – trote. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-A'), 13, 'KXM M', 'Trote largo. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-A'), 14, 'MC', 'Transiciones en K y en M. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-A'), 15, 'C CH', 'Partir al galope reunido a mano izquierda. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-A'), 16, 'HXF F FA', 'Galope largo. Galope reunido y cambio de pie en el aire. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-A'), 17, 'A DP Entre P&B', 'Doblar a lo largo. Apoyo a la derecha. Cambio de pie en el aire', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-A'), 18, 'BIH I', 'En la diagonal corta. Pirueta a la izquierda', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-A'), 19, 'H HCM', 'Cambio de pie en el aire. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-A'), 20, 'MXK KA', '7 cambios de pie cada 2 trancos. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-A'), 21, 'A DV Entre V&E', 'Doblar a lo largo. Apoyo a la izquierda. Cambio de pie en el aire', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-A'), 22, 'EIM I', 'En la diagonal corta. Pirueta a la derecha', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-A'), 23, 'M MCH', 'Cambio de pie en el aire. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-A'), 24, 'HXF FA', '7 cambios de pie al tranco. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-A'), 25, 'A DL', 'Doblar a lo largo. Trote reunido. Transición a Passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-A'), 26, 'LI', 'Passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-A'), 27, 'IG G', 'Trote reunido. Parada - inmovilidad - saludo', 1, 'movimiento');



INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('41', 'Intermedia B', 'RFHE-2022-INT-B', 'Intermedia', 'Intermedia B', 'individual', 2022, '5''45"', 8, 350, 'INTERMEDIA B 2022', 'Reprise intermedia B', 1, 0, 'RFHE-2022-INT-B');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-B'), 1, 'A X XC', 'Entrada a galope reunido. Parada-inmovilidad-saludo. Partir a trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-B'), 2, 'C MXK K', 'Pista a mano derecha. Trote largo. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-B'), 3, 'KAF', 'Transiciones en M y K. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-B'), 4, 'Comenzando entre F y P a S S', 'Apoyo a la izquierda. Trote reunido', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-B'), 5, 'Entre S y H', 'Transición a Passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-B'), 6, 'Entre S y H a C', 'Passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-B'), 7, 'C', 'Piaffe 7-10 batidas (permitido avanzar hasta 2m)', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-B'), 8, 'C', 'Transiciones Passage – Piaffe - Passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-B'), 9, '(C)M', 'Passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-B'), 10, 'M Comenzando entre M y R a V VKA', 'Trote reunido. Apoyo a la derecha. Trote reunido', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-B'), 11, 'AFL', 'Passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-B'), 12, 'L', 'Piaffe 7-10 batidas (permitido avanzar hasta 2m)', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-B'), 13, 'L', 'Transiciones Passage – Piaffe - Passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-B'), 14, 'LE', 'Passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-B'), 15, 'EIM', 'Paso largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-B'), 16, 'MCHG', 'Paso reunido', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-B'), 17, 'G GMR', 'Parada – inmovilidad. Paso atrás 4 trancos e inmediatamente salida a galope reunido. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-B'), 18, 'RK KA', 'En la diagonal 7 cambios de pie cada 2 trancos. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-B'), 19, 'A Entre 0 y 6', 'Doblar a lo largo. 4 apoyos de un lado a otro de la línea central con cambios de pie en cada cambio de dirección, el primer apoyo a la izquierda y el ultimo a la derecha de 4 trancos, los otros 8 trancos. Pista a la derecha', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-B'), 20, 'MXK KAFP', 'Galope largo. Galope reunido y cambio de pie. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-B'), 21, 'PH HCM', 'En la diagonal 9 cambios del pie al tronco. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-B'), 22, 'MIE I', 'En la diagonal corta. Pirueta a la derecha', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-B'), 23, 'E Antes y después de E', 'Cambio de pie. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-B'), 24, 'ELF L', 'En la diagonal corta. Pirueta a la izquierda', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-B'), 25, 'F Antes y después de F', 'Cambio de pie. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-B'), 26, 'A X', 'Doblar a lo largo. Parada – inmovilidad - saludo', 1, 'movimiento');



INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('42', 'Gran Premio', 'RFHE-2022-GP', 'Gran Premio', 'Gran Premio', 'individual', 2022, '6''30"', 8, 440, 'GRAN PREMIO 2022', 'Reprise Gran Premio', 1, 0, 'RFHE-2022-GP');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GP'), 1, 'A X XC', 'Entrada al galope reunido. Parada - inmovilidad - saludo. Partir al trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GP'), 2, 'C HXF FAK', 'Pista a mano izquierda. Trote largo. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GP'), 3, 'KB', 'Apoyar a la derecha', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GP'), 4, 'BH HC', 'Apoyar a la izquierda. Trote reunido', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GP'), 5, 'C', 'Parada - inmovilidad. 5 pasos atrás y partir inmediatamente al trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GP'), 6, 'MV', 'Trote largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GP'), 7, 'VK D', 'Passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GP'), 8, 'D', 'Piaffe 12 a 15 batidas', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GP'), 9, 'D', 'Transiciones passage - piaffe - passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GP'), 10, 'DFP', 'Passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GP'), 11, 'PH', 'Paso largo', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GP'), 12, 'HCM', 'Paso reunido', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GP'), 13, 'M', 'Partir en Passage. Transición paso reunido - passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GP'), 14, 'MRI', 'Passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GP'), 15, 'I', 'Piaffe 12 a 15 batidas', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GP'), 16, 'I', 'Transiciones passage - piaffe - passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GP'), 17, 'ISE', 'Passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GP'), 18, 'E', 'Partir a galope reunido a mano izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GP'), 19, 'FXH', 'En la diagonal, 9 cambios de pie en el aire cada 2 trancos', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GP'), 20, 'MXK', 'Galope largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GP'), 21, 'K', 'Galope reunido y cambio de pie en el aire', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GP'), 22, 'A Entre D y G', 'Doblar a lo largo. 5 apoyos a un lado y otro de la línea central cambiando de pie en cada cambio de dirección, el primer apoyo a la izquierda y el último a la izquierda de 3 trancos, los otros de 6 trancos', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GP'), 23, 'G C', 'Cambio de pie. Pista a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GP'), 24, 'MXK KAF', 'En la diagonal 15 cambios de pie en el aire al trance. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GP'), 25, 'A L', 'Doblar a lo largo. Pirueta a la izquierda', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GP'), 26, 'X', 'Cambio de pie en el aire', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GP'), 27, 'I C', 'Pirueta a la derecha. Pista a la derecha', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GP'), 28, 'M MR', 'Trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GP'), 29, 'RK K KA', 'Trote largo. Trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GP'), 30, 'A DX', 'Doblar a lo largo. Passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GP'), 31, 'X', 'Piaffe 12 a 15 batidas', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GP'), 32, 'X', 'Transiciones passage - piaffe - passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GP'), 33, 'XG', 'Passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GP'), 34, 'G', 'Parada - inmovilidad - saludo', 1, 'movimiento');



INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('43', 'Gran Premio Especial', 'RFHE-2022-GPE', 'Gran Premio', 'Gran Premio Especial', 'individual', 2022, '6''40"', 8, 450, 'GRAN PREMIO ESPECIAL 2022', 'Reprise Gran Premio Especial', 1, 0, 'RFHE-2022-GPE');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPE'), 1, 'A X XC', 'Entrada al galope reunido. Parada - inmovilidad - saludo. Partir al trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPE'), 2, 'C MXK KAFP', 'Pista a mano derecha. Trote largo. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPE'), 3, 'PS SHC', 'Apoyo a la izquierda. Trote reunido', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPE'), 4, 'CMR', 'Passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPE'), 5, 'RF', 'Trote largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPE'), 6, 'Transiciones', 'Transiciones passage - trote largo - passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPE'), 7, 'FAK', 'Passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPE'), 8, 'KV VR RMC', 'Trote reunido. Apoyo. Trote reunido', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPE'), 9, 'CHS', 'Passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPE'), 10, 'SK', 'Trote largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPE'), 11, 'Transiciones', 'Transiciones passage - trote largo - passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPE'), 12, 'KAF', 'Passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPE'), 13, 'FS', 'Paso largo', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPE'), 14, 'SHG', 'Paso reunido', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPE'), 15, 'G', 'Piaffe 12 a 15 batidas', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPE'), 16, 'G', 'Transiciones paso reunido - piaffe - passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPE'), 17, 'GMRI', 'Passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPE'), 18, 'I', 'Piaffe de 12 a 15 batidas', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPE'), 19, 'I', 'Transiciones de passage - piaffe - passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPE'), 20, 'ISEX', 'Passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPE'), 21, 'X XBFAK', 'Partir a galope reunido a la derecha. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPE'), 22, 'KB B', 'Apoyo a galope a la derecha. Cambio de pie en el aire', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPE'), 23, 'BH H HCM', 'Apoyo a galope. Cambio de pie en el aire. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPE'), 24, 'MXK KAF', 'En la diagonal 9 cambios de pie en el aire cada 2 trancos. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPE'), 25, 'FXH HCM', 'En la diagonal 15 cambios de pie en el aire al trance. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPE'), 26, 'MXK K KA', 'Galope largo. Galope reunido y cambio de pie en el aire. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPE'), 27, 'A D', 'Doblar a lo largo. Pirueta a la izquierda', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPE'), 28, 'Entre D y G', 'En la línea central 9 cambios de pie en el aire al trance', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPE'), 29, 'G C CM', 'Pirueta a la derecha. Pista a mano derecha. Galope reunido', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPE'), 30, 'M MR', 'Trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPE'), 31, 'RF F FA', 'Trote largo. Trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPE'), 32, 'A DX', 'Doblar a lo largo. Passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPE'), 33, 'X', 'Piaffe 12 a 15 batidas', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPE'), 34, 'X', 'Transiciones passage - piaffe - passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPE'), 35, 'XG', 'Passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPE'), 36, 'G', 'Parada - inmovilidad - saludo', 1, 'movimiento');



INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('44', 'Gran Premio U25', 'RFHE-2022-GPU25', 'Gran Premio', 'Gran Premio U25', 'individual', 2022, '6''00"', 8, 320, 'GRAN PREMIO U25 16-25 2022', 'Reprise Gran Premio U25', 1, 0, 'RFHE-2022-GPU25');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPU25'), 1, 'A X XC', 'Entrada al galope reunido. Parada - inmovilidad - saludo. Partir al trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPU25'), 2, 'C MXK KA', 'Pista a mano derecha. Trote largo. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPU25'), 3, 'Transiciones', 'Transiciones en M y K', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPU25'), 4, 'A Entre D & G C', 'Doblar a lo largo. 4 apoyos de 5 m a cada lado de la línea central empezando a la izquierda y acabando a la derecha. Pista a la derecha', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPU25'), 5, 'CMR R', 'Trote reunido. Transición a Passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPU25'), 6, 'RI', 'Semicírculo a la derecha de 10m diámetro, en passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPU25'), 7, 'I', 'Piaffe 8 a 10 batidas', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPU25'), 8, 'I', 'Transiciones Passage-Piaffe-Passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPU25'), 9, 'IS', 'Semicírculo a la izquierda de 10m diámetro, en passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPU25'), 10, 'SP', 'Trote Medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPU25'), 11, 'PFD', 'Passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPU25'), 12, 'D', 'Piaffe 8 a 10 batidas', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPU25'), 13, 'D', 'Transiciones Passage-Piaffe-Passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPU25'), 14, 'DKV', 'Passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPU25'), 15, 'VXR', 'Paso Largo', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPU25'), 16, 'RHC', 'Paso Reunido', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPU25'), 17, 'C', 'Partir al galope reunido a la derecha. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPU25'), 18, 'MXK', 'Galope Largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPU25'), 19, 'K', 'Galope reunido y cambio de pie en el aire. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPU25'), 20, 'PX', 'Apoyar a la izquierda. Continuar por la línea del centro', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPU25'), 21, 'I', 'Pirueta a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPU25'), 22, 'HXF', 'En la diagonal, 9 cambios de pie en el aire cada dos trancos. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPU25'), 23, 'VX', 'Apoyar a la derecha. Continuar por la línea del centro', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPU25'), 24, 'I', 'Pirueta a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPU25'), 25, 'MXK', 'En la diagonal 15 cambios de pie en el aire al trancó. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPU25'), 26, 'A DL', 'Doblar a lo largo. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPU25'), 27, 'LX', 'Passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPU25'), 28, 'X', 'Piaffe 8 a 10 batidas', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPU25'), 29, 'X', 'Transiciones passage -piaffe - passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPU25'), 30, 'XG', 'Passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GPU25'), 31, 'G', 'Parada - inmovilidad - saludo', 1, 'movimiento');



INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('45', 'AP Preliminar', 'RFHE-AP-PRE', 'AP', 'AP Preliminar', 'preliminar', 2024, '5''00"', 6, 100, 'AP PRELIMINAR', 'Reprise AP preliminar', 1, 0, 'RFHE-AP-PRE');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-AP-PRE'), 1, 'A X C', 'Entrada al trote de trabajo. Parada - Inmovilidad de 4 seg mínimo - saludo. Partir progresivamente al trote de trabajo. Pista a mano izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-AP-PRE'), 2, 'HXF F A', 'Cambio de mano por diagonal al trote levantado. Cambiar diagonal del trote. Trote sentado', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-AP-PRE'), 3, 'E B', 'Doblar a lo ancho. Pista a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-AP-PRE'), 4, 'C', 'Circulo de 20 m. de diámetro', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-AP-PRE'), 5, 'H E X B', 'Caer al paso. Doblar a lo ancho. Parada. Descalzar los estribos. Partir progresivamente al trote sentado. Pista a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-AP-PRE'), 6, 'Entre K & H', 'Calzar los estribos', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-AP-PRE'), 7, 'Entre C & M', 'Partir a galope de trabajo a mano derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-AP-PRE'), 8, 'BEB', 'Circulo de 20m. de diámetro', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-AP-PRE'), 9, 'Entre B&F', 'Caer al trote', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-AP-PRE'), 10, 'A X G', 'Doblar por la línea del centro. Transición a paso medio. Parada. Inmovilidad de 4 seg mínimo y saludo', 1, 'movimiento');



INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('46', 'AP Final', 'RFHE-AP-FIN', 'AP', 'AP Final', 'final', 2024, '5''00"', 6, 120, 'AP FINAL', 'Reprise AP final', 1, 0, 'RFHE-AP-FIN');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-AP-FIN'), 1, 'A X', 'Entrada al trote de trabajo. Parada -Inmovilidad de 4 seg mínimo -saludo. Partir progresivamente al trote de trabajo. Pista a mano derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-AP-FIN'), 2, 'MXK', 'Cambio de mano por diagonal al trote levantado. Cambiar diagonal del trote. Trote sentado', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-AP-FIN'), 3, 'B E', 'Doblar a lo ancho. Pista a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-AP-FIN'), 4, 'C', 'Circulo de 20 m. de diámetro a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-AP-FIN'), 5, 'M B X', 'Caer al paso medio. Doblar a lo ancho. Parada. Descalzar los estribos. Partir progresivamente al trote sentado. Pista a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-AP-FIN'), 6, 'Entre F & M', 'Calzar los estribos', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-AP-FIN'), 7, 'En C', 'Partir a galope de trabajo a mano izquierda', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-AP-FIN'), 8, 'EBE', 'Circulo de 20m. de diámetro a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-AP-FIN'), 9, 'En KC', 'Caer al trote', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-AP-FIN'), 10, 'A X G', 'Doblar por la línea del centro. Transición a paso medio. Parada. Inmovilidad de 4 seg mínimo y saludo', 1, 'movimiento');



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



INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('49', 'Final Caballos Jovenes 7 años', 'RFHE-2022-CJ7-FIN2', 'Caballos Jovenes', '7 años Final', 'final', 2022, '5''15"', 7, 330, 'FINAL CABALLOS JOVENES 7 AÑOS 2022', 'Reprise final caballos jovenes 7 años (variante)', 1, 0, 'RFHE-2022-CJ7-FIN2');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN2'), 1, 'A X XC', 'Entrada al galope reunido. Parada-inmovilidad y saludo. Partir al trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN2'), 2, 'C HXF F', 'Pista a mano izquierda. Cambio de mano al trote medio. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN2'), 3, 'FAK', 'Transiciones en H y F. El trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN2'), 4, 'KE', 'Espalda adentro a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN2'), 5, 'EX XB', 'Media vuelta a la derecha (10 m). Media vuelta a la izquierda (10 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN2'), 6, 'BG G C', 'Apoyo a la izquierda. Seguir la línea central. Pista a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN2'), 7, 'RS SHCM', 'Medio círculo a la derecha (20 m). Dejando al caballo estirarse con riendas largas. Trote reunido. Recoger las riendas', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN2'), 8, 'MXK K', 'Trote largo. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN2'), 9, 'KAF', 'Transiciones en M y K. El trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN2'), 10, 'FB', 'Espalda adentro a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN2'), 11, 'BX XE', 'Media vuelta a la izquierda (10 m). Media vuelta a la derecha (10 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN2'), 12, 'EG G', 'Apoyo a la derecha. Seguir la línea central', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN2'), 13, 'Antes de C C CH', 'Paso medio. Pista a la izquierda. Paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN2'), 14, 'HIB', 'Paso Largo', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN2'), 15, 'BPL(V)', 'Paso reunido', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN2'), 16, 'Entre L y V L(P)', 'Media pirueta a la derecha. Seguir al paso reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN2'), 17, 'Entre L y P L(P)', 'Media pirueta a la izquierda. Seguir al paso reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN2'), 18, 'Entre L y V VKA', 'Partir al galope a la izquierda. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN2'), 19, 'A DE E', 'Doblar a lo largo. Apoyo a la izquierda. Cambio de pie en el aire', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN2'), 20, 'EG C', 'Apoyo a la derecha. Pista a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN2'), 21, 'MXK', 'Galope largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN2'), 22, 'K KAF', 'Galope reunido y cambio de pie en el aire. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN2'), 23, 'F(X) Entre F y X', 'Proceder hacia X a galope reunido. Media pirueta a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN2'), 24, 'FA A AK', 'Galope en trocado. Cambio de pie en el aire. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN2'), 25, 'K(X) Entre K y X', 'Avanzar hacia X a galope reunido. Media pirueta a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN2'), 26, 'KA A AF', 'Galope en trocado. Cambio de pie en el aire. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN2'), 27, 'FS', 'Sobre la diagonal corta 3 cambios de pie cada 4 trancos', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN2'), 28, 'SR', 'Medio círculo a la derecha (20 m). Ceder las riendas y retomarlas durante 3 trancos', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN2'), 29, 'RK', 'Diagonal corta con 3 cambios de pie cada 3 trancos. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ7-FIN2'), 30, 'A X', 'Doblar en la línea central. Parada - inmovilidad - saludo', 1, 'movimiento');




-- ============================================
-- VERIFICACION
-- ============================================
SELECT 
  'reprises' AS tabla,
  COUNT(*)::text AS total
FROM reprises
UNION ALL
SELECT 
  'ejercicios_reprise',
  COUNT(*)::text
FROM ejercicios_reprise;

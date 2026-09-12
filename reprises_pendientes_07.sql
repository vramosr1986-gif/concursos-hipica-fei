-- ============================================
-- INFANTILES PRELIMINAR B 2024
-- ============================================
INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('69', 'Infantiles Preliminar B', 'RFHE-2024-INF-PRE-B', 'Infantiles', 'Preliminar B', 'preliminar', 2024, '3''50"', 6, 280, 'INFANTILES PRELIMINAR B 2024', 'Reprise preliminar B infantiles', 1, 0, 'RFHE-2024-INF-PRE-B');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-PRE-B'), 1, 'A X', 'Entrada al trote de trabajo. Parada - inmovilidad - saludo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-PRE-B'), 2, 'XC', 'Salida al trote de trabajo. Trote de Trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-PRE-B'), 3, 'C HS SI IR RBP', 'Pista a mano izquierda. Trote de Trabajo. Semicirculo de 10m a la izquierda. Semicirculo de 10m a la derecha. Trote de trabajo', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-PRE-B'), 4, 'PL LV VKAF', 'Semicirculo de 10m a la derecha. Semicirculo de 10m a la izquierda. Trote de trabajo', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-PRE-B'), 5, 'FH H', 'Alargar los trancos. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-PRE-B'), 6, 'HC', 'Transiciones en F y en H. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-PRE-B'), 7, 'C CMSE', 'Paso medio. Paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-PRE-B'), 8, 'E EVK', 'Salir a trote de trabajo. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-PRE-B'), 9, 'K KAF', 'Salir a galope de trabajo. Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-PRE-B'), 10, 'FP PV VK', 'Galope reunido. Medio circulo (20 metros diametro). Entre P y V ceder y recoger riendas en 3 trancos. Galope reunido', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-PRE-B'), 11, 'KD', 'Media Vuelta de 10 metros de diametro volviendo a la pista en E', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-PRE-B'), 12, 'EHC', 'Galope en trocado', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-PRE-B'), 13, 'CM', 'Paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-PRE-B'), 14, 'M MR', 'Partir a galope reunido. Galope Reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-PRE-B'), 15, 'RB F F', 'Alargamiento de los trancos. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-PRE-B'), 16, 'FAK', 'Transiciones en R y F. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-PRE-B'), 17, 'KLB', 'Galope Reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-PRE-B'), 18, 'BRMC', 'Galope en trocado', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-PRE-B'), 19, 'C', 'Transicion a paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-PRE-B'), 20, 'CHRB', 'Paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-PRE-B'), 21, 'B PV VP PF FA', 'Partir al trote de trabajo. Circulo de 20 metros de diametro a trote levantado. Dejar estirar al caballo en riendas largas. Trote sentado y retomar las riendas. Trote de trabajo', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-PRE-B'), 22, 'A X', 'Doblar por la linea del centro. Parada-Inmovilidad- Saludo', 1, 'movimiento');

-- ============================================
-- INFANTILES EQUIPOS 2024
-- ============================================
INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('70', 'Infantiles Equipos', 'RFHE-2024-INF-EQU', 'Infantiles', 'Equipos', 'equipos', 2024, '3''55"', 6, 250, 'INFANTILES EQUIPOS 2024', 'Reprise por equipos infantiles', 1, 0, 'RFHE-2024-INF-EQU');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-EQU'), 1, 'A X', 'Entrada al trote de trabajo. Parada- Inmovilidad-Saludo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-EQU'), 2, 'X XC', 'Partir al trote de trabajo. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-EQU'), 3, 'C MV V', 'Pista a la derecha. Trote medio. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-EQU'), 4, 'VK', 'Transiciones en M y V. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-EQU'), 5, 'KD DE ES', 'Media vuelta (10m). Cesion a la pierna. Trote de trabajo', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-EQU'), 6, 'SR RB PF', 'Medio circulo (20 m), ceder y retomar las riendas en 3-4 trancos. Trote de trabajo', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-EQU'), 7, 'FD DB BR', 'Media vuelta (10m). Cesion a la pierna. Trote de trabajo', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-EQU'), 8, 'R RS', 'Paso medio. Medio circulo (20 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-EQU'), 9, 'S(E) Entre S y E', '[Paso medio]. Giro sobre los posteriores. Continuar en paso medio', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-EQU'), 10, 'SH', 'Paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-EQU'), 11, 'H HCM', 'Partir al galope de trabajo. Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-EQU'), 12, 'MRB PF F', 'Galope medio. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-EQU'), 13, 'FAK', 'Transiciones en M y F. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-EQU'), 14, 'KXH HCMR', 'Bucle de 10 m. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-EQU'), 15, 'RX[V] X XVKAF', 'En la diagonal corte. Cambio de pie simple. Galope reunido', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-EQU'), 16, 'FXM MCH', 'Bucle de 10 m. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-EQU'), 17, 'HSEX X RBP', 'Galope reunido. Cambio de pie simple. Galope reunido', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-EQU'), 18, 'P PFA', 'Trote de trabajo. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-EQU'), 19, 'A X', 'Doblar en la linea central. Parada - Inmovilidad y Saludo', 1, 'movimiento');

-- ============================================
-- GRAN PREMIO CJ 8-10 AÑOS 2022
-- ============================================
INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('71', 'Gran Premio CJ 8-10 años', 'RFHE-2022-CJ8-10', 'Gran Premio', 'CJ 8-10 años', 'individual', 2022, '6''00"', 8, 360, 'GRAN PREMIO CJ 8-10 AÑOS 2022', 'Reprise Gran Premio Caballos Jovenes 8-10 años', 1, 0, 'RFHE-2022-CJ8-10');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ8-10'), 1, 'A X XC', 'Entrada al galope reunido. Parada - inmovilidad - saludo. Partir al trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ8-10'), 2, 'C MXK K', 'Pista a mano derecha. Trote largo. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ8-10'), 3, 'KAF', 'Transiciones en M y K. El trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ8-10'), 4, 'Entre F y P', 'Transicion a passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ8-10'), 5, 'P(V)', 'Medio circulo a passage (20m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ8-10'), 6, 'Al cruzar la linea central', 'Piaffe 8 a 10 batidas', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ8-10'), 7, 'Al cruzar la linea central', 'Transiciones passage - piaffe - passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ8-10'), 8, 'De la linea central a V, en linea circular VA', 'Passage. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ8-10'), 9, 'A DG', 'Sobre la linea central 3 apoyos, 5 metros a ambos lados de la linea central, empezando y acabando a la izquierda. Pista a mano izquierda', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ8-10'), 10, 'HP', 'Trote medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ8-10'), 11, 'PFD', 'Passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ8-10'), 12, 'D', 'Piaffe 8 a 10 batidas', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ8-10'), 13, 'D', 'Transiciones passage - piaffe - passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ8-10'), 14, 'DKV', 'Passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ8-10'), 15, 'VXR', 'Paso largo', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ8-10'), 16, 'RHC', 'Paso reunido', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ8-10'), 17, 'C', 'Salida a galope a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ8-10'), 18, 'MXK', 'Galope largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ8-10'), 19, 'K', 'Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ8-10'), 20, 'PX', 'Apoyo a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ8-10'), 21, 'I', 'Pirueta a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ8-10'), 22, 'HXF', 'En la diagonal 9 cambios de pie en el aire cada 2 trancos. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ8-10'), 23, 'VX', 'Apoyo a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ8-10'), 24, 'I', 'Pirueta a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ8-10'), 25, 'MXK', 'En la diagonal, 15 cambios de pie en el aire a un tronco', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ8-10'), 26, 'A', 'Linea central', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ8-10'), 27, 'LX', 'Passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ8-10'), 28, 'X', 'Piaffe 8 a 10 batidas', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ8-10'), 29, 'X', 'Transiciones passage - piaffe - passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ8-10'), 30, 'XG', 'Passage', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ8-10'), 31, 'G', 'Parada - inmovilidad - saludo', 1, 'movimiento');
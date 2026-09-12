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

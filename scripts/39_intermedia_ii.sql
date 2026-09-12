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

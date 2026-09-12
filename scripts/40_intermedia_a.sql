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

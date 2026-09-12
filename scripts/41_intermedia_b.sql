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

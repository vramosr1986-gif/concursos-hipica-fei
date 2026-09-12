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

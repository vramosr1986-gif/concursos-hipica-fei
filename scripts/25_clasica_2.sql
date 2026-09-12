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

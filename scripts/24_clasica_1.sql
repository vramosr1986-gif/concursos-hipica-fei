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

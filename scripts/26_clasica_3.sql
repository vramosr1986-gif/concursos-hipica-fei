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

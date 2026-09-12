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

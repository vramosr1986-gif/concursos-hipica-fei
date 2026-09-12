INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('46', 'AP Final', 'RFHE-AP-FIN', 'AP', 'AP Final', 'final', 2024, '5''00"', 6, 120, 'AP FINAL', 'Reprise AP final', 1, 0, 'RFHE-AP-FIN');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-AP-FIN'), 1, 'A X', 'Entrada al trote de trabajo. Parada -Inmovilidad de 4 seg mínimo -saludo. Partir progresivamente al trote de trabajo. Pista a mano derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-AP-FIN'), 2, 'MXK', 'Cambio de mano por diagonal al trote levantado. Cambiar diagonal del trote. Trote sentado', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-AP-FIN'), 3, 'B E', 'Doblar a lo ancho. Pista a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-AP-FIN'), 4, 'C', 'Circulo de 20 m. de diámetro a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-AP-FIN'), 5, 'M B X', 'Caer al paso medio. Doblar a lo ancho. Parada. Descalzar los estribos. Partir progresivamente al trote sentado. Pista a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-AP-FIN'), 6, 'Entre F & M', 'Calzar los estribos', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-AP-FIN'), 7, 'En C', 'Partir a galope de trabajo a mano izquierda', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-AP-FIN'), 8, 'EBE', 'Circulo de 20m. de diámetro a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-AP-FIN'), 9, 'En KC', 'Caer al trote', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-AP-FIN'), 10, 'A X G', 'Doblar por la línea del centro. Transición a paso medio. Parada. Inmovilidad de 4 seg mínimo y saludo', 1, 'movimiento');

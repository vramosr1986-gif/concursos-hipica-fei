INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('16', '4 años Preliminar', 'RFHE-2022-CJ4-PRE', 'Caballos Jovenes', '4 años Preliminar', 'preliminar', 2022, '5''00"', 4, 100, 'PRELIMINAR CABALLOS DE 4 AÑOS', 'Reprise preliminar caballos 4 años', 1, 0, 'RFHE-2022-CJ4-PRE');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-PRE'), 1, 'A X C', 'Entrada al trote de trabajo por la línea central sin saludo. Pista a mano derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-PRE'), 2, 'CMBFAKE', 'Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-PRE'), 3, 'EXB B', 'Doblar a lo ancho. Doblar a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-PRE'), 4, 'BMCH', 'Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-PRE'), 5, 'HK KA', 'Alargar los trancos. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-PRE'), 6, 'Entre A y F', 'Paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-PRE'), 7, 'FXH', 'Paso medio. Dejar al caballo estirarse en riendas largas', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-PRE'), 8, 'H Entre H y C', 'Volver a tomar las riendas. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-PRE'), 9, 'CB BE', 'Trote de trabajo. Semicírculo de 20 m al trote sentado', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-PRE'), 10, 'Antes de E EHCM', 'Galope de trabajo. Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-PRE'), 11, 'MF FA', 'Alargar los trancos. Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-PRE'), 12, 'Entre A y K KXM', 'Trote de trabajo. Cambio de mano alargando los trancos', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-PRE'), 13, 'M Entre M y C', 'Trote de trabajo sentado. Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-PRE'), 14, 'HM MCH', 'Semicírculo de 20 m a galope de trabajo. Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-PRE'), 15, 'HK K', 'Alargar los trancos. Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-PRE'), 16, 'Entre K y A AF FK', 'Trote de trabajo. Trote de trabajo. Semicírculo de 20 m', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-PRE'), 17, 'K A X', 'Volver a tomar las riendas. Doblar a lo largo. Parada - Inmovilidad - Saludo', 1, 'movimiento');

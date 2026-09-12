INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('19', '5 años Preliminar', 'RFHE-2022-CJ5-PRE', 'Caballos Jovenes', '5 años Preliminar', 'preliminar', 2022, '5''00"', 5, 100, 'PRELIMINAR CABALLOS DE 5 AÑOS 2022', 'Reprise preliminar caballos 5 años', 1, 0, 'RFHE-2022-CJ5-PRE');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-PRE'), 1, 'A X', 'Entrada al trote de trabajo. Parada y saludo, partir al trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-PRE'), 2, 'C', 'Pista a mano derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-PRE'), 3, 'CB', 'Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-PRE'), 4, 'BX XE', 'Semicírculo de 10 m a mano derecha. Semicírculo de 10 m a mano izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-PRE'), 5, 'VKAF', 'Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-PRE'), 6, 'FXH H', 'Trote medio. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-PRE'), 7, 'CA', 'Serpentina de 3 bucles (tocando el lado mayor)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-PRE'), 8, 'KXM MC', 'Trote medio. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-PRE'), 9, 'C', 'Parada - paso atrás (un largo del caballo) e inmediatamente partir al paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-PRE'), 10, 'HB BK', 'Paso medio. Paso medio, dejando al caballo estirarse en riendas largas', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-PRE'), 11, 'K KA', 'Volver a tomar las riendas. Paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-PRE'), 12, 'A AFB', 'Galope de trabajo a mano izquierda. Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-PRE'), 13, 'BRSE', 'Galope medio. Entre R y S semicírculo (20 m). Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-PRE'), 14, 'KDE E', 'Semicírculo de 10 m, volviendo a la pista en E. Galope en trocado', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-PRE'), 15, 'Antes de H ME', 'Cambio de pie simple. Cambio de mano', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-PRE'), 16, 'EK KAFP', 'Galope en trocado. Trote de trabajo. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-PRE'), 17, 'PV', 'Semicírculo de 20 m, permitiendo al caballo estirarse en riendas largas, al trote levantado', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-PRE'), 18, 'Entre V y K', 'Volver a tomar las riendas', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-PRE'), 19, 'A', 'Doblar a lo largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-PRE'), 20, 'X', 'Parada - inmovilidad - saludo', 1, 'movimiento');

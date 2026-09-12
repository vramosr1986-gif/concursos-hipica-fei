INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('27', 'Promocion 2', 'RFHE-2024-PRO-2', 'Promocion', 'Promocion 2', 'individual', 2024, '4''00"', 6, 170, 'PROMOCION 2 2024', 'Reprise promocion 2', 1, 0, 'RFHE-2024-PRO-2');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-PRO-2'), 1, 'A X', 'Entrada al trote de trabajo. Parada - inmovilidad - saludo. Partir al trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-PRO-2'), 2, 'C E', 'Pista a mano izquierda. Doblar a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-PRO-2'), 3, 'X X', 'Círculo a la izquierda de 10 metros. Círculo a la derecha de 10 metros', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-PRO-2'), 4, 'XBFA', 'Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-PRO-2'), 5, 'AC', 'Serpentina de cuatro bucles iguales llegando a cada lado de la pista', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-PRO-2'), 6, 'Entre C y H HE', 'Galope de trabajo a mano izquierda. Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-PRO-2'), 7, 'E EKAF', 'Círculo a la izquierda de 15 metros de diámetro. Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-PRO-2'), 8, 'FXH', 'En la diagonal, en X trote de trabajo, entre H y C galope de trabajo a mano derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-PRO-2'), 9, 'HCB', 'Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-PRO-2'), 10, 'B', 'Círculo a la derecha de 15 metros de diámetro', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-PRO-2'), 11, 'BFA', 'Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-PRO-2'), 12, 'A K', 'Trote de trabajo. Paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-PRO-2'), 13, 'KE', 'Paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-PRO-2'), 14, 'EB', 'Semicírculo de 20 m de diámetro al paso libre en riendas largas', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-PRO-2'), 15, 'BF F', 'Paso medio. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-PRO-2'), 16, 'A G', 'Doblar a lo largo. Parada - Inmovilidad - Saludo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-PRO-2'), 101, 'NC1', 'Impresion General (Armonia y presentacion, posicion y asiento del jinete/amazona, correccion y efecto de las ayudas)', 1, 'nota_conjunto');

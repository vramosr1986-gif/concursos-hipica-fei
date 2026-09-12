-- ============================================
-- ALEVINES EQUIPOS 2024
-- ============================================
INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('66', 'Alevines Equipos', 'RFHE-2024-ALE-EQU', 'Alevines', 'Equipos', 'equipos', 2024, '5''00"', 6, 200, 'ALEVINES EQUIPOS 2024', 'Reprise por equipos alevines', 1, 0, 'RFHE-2024-ALE-EQU');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-EQU'), 1, 'A X X I', 'Entrada al trote de trabajo. Caer al paso. Paso', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-EQU'), 2, 'I IC', 'Parada. Inmovilidad. Saludo. Partir al paso. Paso', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-EQU'), 3, 'C M', 'Pista a la derecha. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-EQU'), 4, 'Transiciones', 'Las transiciones trote-parada, parada-paso, paso-trote', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-EQU'), 5, 'BE B', 'Circulo de 20 m. de diametro', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-EQU'), 6, 'A', 'Por el lado menor - (A) - caer al paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-EQU'), 7, 'VXR', 'Cambio de mano ampliando el tranco', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-EQU'), 8, 'R hacia C', 'Transicion al paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-EQU'), 9, 'C hacia H', 'Parada de 6 seg. y partir al paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-EQU'), 10, 'H HE', 'Transicion a trote de trabajo. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-EQU'), 11, 'EBE', 'Circulo de 20 m. de diametro', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-EQU'), 12, 'Entre K y F F B', 'Galope de trabajo a la izquierda. Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-EQU'), 13, 'BEB', 'Circulo de 20 m. de diametro', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-EQU'), 14, 'C', 'Por el lado menor (C) caer al trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-EQU'), 15, 'HP P hacia F', 'Cambio de mano al trote levantado ampliando el tranco. Transicion a trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-EQU'), 16, 'Entre F y K hacia E', 'Partir al galope de trabajo a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-EQU'), 17, 'EBE', 'Circulo de 20 m. de diametro', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-EQU'), 18, 'C', 'Por el lado menor (C) caer al trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-EQU'), 19, 'MV', 'Cambio de mano al trote levantado ampliando el tranco. Transicion a trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-EQU'), 20, 'A X G', 'Doblar a lo largo. Caer al paso medio. Parada - Inmovilidad 6 seg. - Saludo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-EQU'), 101, 'NC1', 'Aires (soltura y mantenimiento del ritmo correcto)', 1, 'nota_conjunto'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-EQU'), 102, 'NC2', 'Energia y Remetimiento', 1, 'nota_conjunto'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-EQU'), 103, 'NC3', 'Posicion del cuello y nuca', 1, 'nota_conjunto'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-EQU'), 104, 'NC4', 'Atencion y confianza', 1, 'nota_conjunto'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-EQU'), 105, 'NC5', 'Posicion y asiento del jinete', 1, 'nota_conjunto'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-EQU'), 106, 'NC6', 'Correccion y efecto de las ayudas', 1, 'nota_conjunto'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-EQU'), 107, 'NC7', 'Correccion en esquinas y transiciones', 1, 'nota_conjunto');

-- ============================================
-- ALEVINES INDIVIDUAL 2024
-- ============================================
INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('67', 'Alevines Individual', 'RFHE-2024-ALE-IND', 'Alevines', 'Individual', 'individual', 2024, '4''30"', 6, 230, 'ALEVINES INDIVIDUAL 2024', 'Reprise individual alevines', 1, 0, 'RFHE-2024-ALE-IND');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-IND'), 1, 'A X C', 'Entrada al trote de trabajo. Parada - Saludo. Partir al trote de trabajo. Pista a mano derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-IND'), 2, 'R', 'Circulo de 15 m. de diametro', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-IND'), 3, 'RK K KAFP', 'Cambio de mano por diagonal alargando el trote. Transicion a trote de trabajo. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-IND'), 4, 'P', 'Circulo de 15 m. de diametro', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-IND'), 5, 'PH H HC', 'Cambio de mano por diagonal alargando el trote. Transicion a trote de trabajo. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-IND'), 6, 'C', 'Serpentina de 2 bucles llegando a la pista en cada bucle', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-IND'), 7, 'X', 'Parada. Inmovilidad 5 seg. Partir al trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-IND'), 8, 'B BM', 'Pista a la izquierda. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-IND'), 9, 'M MCH', 'Transicion a paso medio. Paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-IND'), 10, 'Entre H y S SR', 'Transicion a paso libre. Paso libre. Medio circulo de 20 m. de diametro con riendas largas', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-IND'), 11, 'Entre R y M MC', 'Transicion a paso medio. Paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-IND'), 12, 'C C', 'Transicion a trote de trabajo. Circulo de 15 m. de diametro al trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-IND'), 13, 'C CE', 'Al llegar de nuevo a C, partir al galope de trabajo a la izquierda. Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-IND'), 14, 'E', 'Circulo a la izquierda de 20 m. de diametro. Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-IND'), 15, 'FS', 'Cambio de mano por diagonal alargando el galope', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-IND'), 16, 'S SH', 'Transicion a galope de trabajo. Galope en trocado', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-IND'), 17, 'H HC', 'Transicion a trote de trabajo. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-IND'), 18, 'C', 'Partir al galope a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-IND'), 19, 'C', 'Circulo de 20 m. de diametro', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-IND'), 20, 'MV', 'Cambio de mano por diagonal alargando el galope', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-IND'), 21, 'V VK', 'Transicion a galope de trabajo. Galope en trocado', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-IND'), 22, 'K KA', 'Transicion a trote de trabajo. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-IND'), 23, 'A X', 'Doblar a lo largo. Parada. Inmovilidad y saludo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-IND'), 101, 'NC1', 'Aires (soltura y mantenimiento del ritmo correcto)', 1, 'nota_conjunto'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-IND'), 102, 'NC2', 'Energia y Remetimiento', 1, 'nota_conjunto'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-IND'), 103, 'NC3', 'Posicion del cuello y nuca', 1, 'nota_conjunto'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-IND'), 104, 'NC4', 'Atencion y confianza', 1, 'nota_conjunto'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-IND'), 105, 'NC5', 'Posicion y asiento del jinete', 1, 'nota_conjunto'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-IND'), 106, 'NC6', 'Correccion y efecto de las ayudas', 1, 'nota_conjunto'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-ALE-IND'), 107, 'NC7', 'Correccion en esquinas y transiciones', 1, 'nota_conjunto');

-- ============================================
-- INFANTILES PRELIMINAR A 2024
-- ============================================
INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('68', 'Infantiles Preliminar A', 'RFHE-2024-INF-PRE-A', 'Infantiles', 'Preliminar A', 'preliminar', 2024, '3''30"', 6, 200, 'INFANTILES PRELIMINAR A 2024', 'Reprise preliminar A infantiles', 1, 0, 'RFHE-2024-INF-PRE-A');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-PRE-A'), 1, 'A X', 'Entrada al trote de trabajo. Parada - inmovilidad - saludo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-PRE-A'), 2, 'X XC', 'Salida al trote de trabajo. Trote de Trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-PRE-A'), 3, 'C CMR', 'Pista a la derecha. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-PRE-A'), 4, 'RXV', 'Cambio de mano en diagonal corta', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-PRE-A'), 5, 'VKA', 'Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-PRE-A'), 6, 'AC', 'Serpentina de cuatro bucles', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-PRE-A'), 7, 'Entre C y M MRB', 'Galope de trabajo a mano derecha. Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-PRE-A'), 8, 'B BPFAK', 'Circulo a la derecha de 15 metros de diametro. Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-PRE-A'), 9, 'KXM', 'En la diagonal, en X trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-PRE-A'), 10, 'MC', 'Entre M y C galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-PRE-A'), 11, 'CHSE', 'Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-PRE-A'), 12, 'E EVKA', 'Circulo a la izquierda de 15 metros de diametro. Galope de trabajo', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-PRE-A'), 13, 'A AF', 'Trote de trabajo. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-PRE-A'), 14, 'F FV', 'Paso Medio. Paso Medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-PRE-A'), 15, 'VP', 'Semicirculo de 20 m de diametro en paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-PRE-A'), 16, 'P PFA', 'Partir al trote de trabajo. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-INF-PRE-A'), 17, 'A X', 'Doblar por la linea del centro. Parada-Inmovilidad- Saludo', 1, 'movimiento');
INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('17', '4 años Final', 'RFHE-2022-CJ4-FIN', 'Caballos Jovenes', '4 años Final', 'final', 2022, '5''00"', 4, 50, 'FINAL CABALLOS DE 4 AÑOS', 'Reprise final caballos 4 años', 1, 0, 'RFHE-2022-CJ4-FIN');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 1, 'A C', 'Entrada al trote de trabajo por la línea central sin saludo. Pista a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 2, 'R', 'Círculo de 15 m. de diámetro', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 3, 'RK K', 'Cambio de mano por diagonal alargando el trote. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 4, 'P', 'Círculo de 15 m. de diámetro', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 5, 'PH H', 'Cambio de mano por diagonal alargando el trote. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 6, 'CX X', 'Serpentina de 2 bucles llegando a la pista en cada bucle. Parada. Inmovilidad 5 seg. Partir al trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 7, 'B BM', 'Pista a la izquierda. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 8, 'M MCH', 'Paso medio. Paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 9, 'SR', 'Medio círculo de 20 m. de diámetro con riendas largas', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 10, 'M C', 'Paso medio. Trote de trabajo sentado y círculo de 15 m. de diámetro', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 11, 'CE E', 'Al llegar a C partir al galope de trabajo a la izquierda. Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 12, 'E', 'Círculo a la izquierda de 20 m. de diámetro', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 13, 'EAF', 'Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 14, 'FS', 'Cambio de mano por diagonal alargando el galope', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 15, 'S H', 'Galope de trabajo. Trote de trabajo sentado', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 16, 'C', 'Partir al galope a la derecha y círculo de 20 m. de diámetro', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 17, 'MV', 'Cambio de mano por diagonal alargando el galope', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 18, 'VK K', 'Galope de trabajo. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 19, 'A', 'Doblar a lo largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 20, 'X', 'Parada. Inmovilidad y saludo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 101, 'NC1', 'Trote: Ritmo, soltura, elasticidad, impulsión, dorso flexible, aptitud para flexionar las articulaciones del tercio posterior', 1, 'nota_conjunto'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 102, 'NC2', 'Paso: Ritmo, relajación, actividad, amplitud', 1, 'nota_conjunto'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 103, 'NC3', 'Galope: Ritmo, soltura, elasticidad, equilibrio natural, tendencia cuesta arriba (elevación de la cruz) y aptitud para flexionar las articulaciones del tercio posterior', 1, 'nota_conjunto'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 104, 'NC4', 'Sumisión, contacto, rectitud, obediencia, respuesta a las ayudas del jinete', 1, 'nota_conjunto'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-FIN'), 105, 'NC5', 'Expectativas de futuro: Potencial como caballo joven de doma, standard de entrenamiento según la escala de entrenamiento', 1, 'nota_conjunto');

INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('20', '5 años Final', 'RFHE-2022-CJ5-FIN', 'Caballos Jovenes', '5 años Final', 'final', 2022, '5''00"', 5, 50, 'FINAL CABALLOS DE 5 AÑOS 2022', 'Reprise final caballos 5 años', 1, 0, 'RFHE-2022-CJ5-FIN');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-FIN'), 1, 'Trote', 'Ritmo, soltura, elasticidad, impulsión, dorso flexible, aptitud para avanzar y voluntad para la reunión', 1, 'nota_conjunto'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-FIN'), 2, 'Paso', 'Ritmo, relajación, actividad, aptitud para avanzar', 1, 'nota_conjunto'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-FIN'), 3, 'Galope', 'Ritmo, soltura, elasticidad, equilibrio natural, impulsión, voluntad para la reunión, aptitud para avanzar y tendencia cuesta arriba', 1, 'nota_conjunto'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-FIN'), 4, 'Sumisión', 'Elasticidad, flexibilidad, contacto, rectitud, obediencia, aptitud para sostenerse por sí mismo', 1, 'nota_conjunto'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ5-FIN'), 5, 'Expectativas de futuro', 'Potencial como caballo de doma. Standard de entrenamiento (según la escala de entrenamiento)', 1, 'nota_conjunto');

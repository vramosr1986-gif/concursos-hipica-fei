INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('18', '4 años Experimental', 'RFHE-2022-CJ4-EXP', 'Caballos Jovenes', '4 años Experimental', 'experimental', 2022, '5''00"', 4, 100, '4 AÑOS EXPERIMENTAL', 'Reprise experimental 4 años', 1, 0, 'RFHE-2022-CJ4-EXP');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-EXP'), 1, 'Ejercicio 1', 'Círculo 20 mts al trote de trabajo a cada mano', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-EXP'), 2, 'Ejercicio 2', 'Alargamiento de algunos trancos al trote en línea recta', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-EXP'), 3, 'Ejercicio 3', 'Círculo de 20 mts a galope de trabajo a cada mano', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-EXP'), 4, 'Ejercicio 4', 'Alargamiento de algunos trancos al galope en línea recta a cada mano', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-EXP'), 5, 'Ejercicio 5', 'Transiciones Galope - Trote - Galope a cada mano', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-EXP'), 6, 'Ejercicio 6', 'Transiciones Trote - Paso - Trote', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-EXP'), 7, 'Ejercicio 7', 'Alargamiento del paso (mínimo 40 mts) Similar a requerimientos de paso largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-CJ4-EXP'), 8, 'A', 'Salir de la pista por A al paso en riendas largas', 1, 'movimiento');

INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('29', 'Rider 1B', 'RFHE-2024-RID-1B', 'Rider', 'Rider 1B', 'individual', 2024, '4''45"', 6, 150, 'RIDER 1B 2024', 'Reprise rider 1B', 1, 0, 'RFHE-2024-RID-1B');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1B'), 1, 'A', 'Entrada al trote de trabajo. Seguir por la línea del centro sin parada. Pista a mano izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1B'), 2, 'E', 'Circulo a la izquierda de 20m. diametro. Medio circulo izquierda de 10m. hasta D dirigirse hacia H', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1B'), 3, 'B', 'Circulo a la derecha de 20m. diametro. Medio circulo a la derecha de 10m. hasta D dirigirse hacia M', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1B'), 4, 'C', 'Paso Medio. Cambio de mano al paso Medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1B'), 5, 'XFK', 'Paso libre con riendas largas. Paso Medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1B'), 6, 'E', 'Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1B'), 7, 'Entre H&C Entre C&F', 'Galope de trabajo a la derecha. Enseñar algún tranco de galope medio. Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1B'), 8, 'AX Cerca X', 'Medio circulo a la derecha de 20m. Caer al trote unos trancos (3-5) y nuevamente partir a Galope a mano izquierda. Medio Circulo a la izquierda de 20m. Hacia C', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1B'), 9, 'Entre C&K', 'Enseñar algún tranco de galope medio. Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1B'), 10, 'AX Cerca X', 'Medio circulo a la izquierda de 20m. Caer al trote unos trancos (3-5) y nuevamente partir a Galope a mano derecha. Medio Circulo a la derecha de 20m. Hacia C', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1B'), 11, 'C', 'Trote de trabajo. Cambio de mano mostrando algún tranco de trote medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1B'), 12, 'KAF', 'Trote de trabajo. Cambio de mano mostrando algún tranco de trote medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1B'), 13, 'HB B', 'Trote de Trabajo. Circulo a la derecha de 20m. dejando al caballo estirarse, recogiendo las riendas al entrar nuevamente en pista en B', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1B'), 14, 'BA A D', 'Trote de Trabajo. Doblar por la línea del centro. Paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-1B'), 15, 'X', 'Parada-Inmovilidad-Saludo', 1, 'movimiento');

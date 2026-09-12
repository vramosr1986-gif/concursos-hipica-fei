INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('34', 'Rider 3A', 'RFHE-2024-RID-3A', 'Rider', 'Rider 3A', 'individual', 2024, '5''30"', 6, 340, 'RIDER 3A 2024', 'Reprise rider 3A', 1, 0, 'RFHE-2024-RID-3A');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3A'), 1, 'A X XC', 'Entrada al trote de trabajo. Parada - inmovilidad - saludo. Trote de Trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3A'), 2, 'C MB', 'Pista a mano derecha. Espalda dentro a la derecha', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3A'), 3, 'BX XE', 'Medio circulo a la derecha 10m. Medio circulo a la izquierda 10m', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3A'), 4, 'EK', 'Cabeza al muro', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3A'), 5, 'FM MH', 'Trote Medio. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3A'), 6, 'Transiciones', 'Transiciones en F & M', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3A'), 7, 'HE', 'Espalda dentro a la izquierda', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3A'), 8, 'EX XB', 'Medio circulo a la izquierda 10m. Medio circulo a la derecha 10m', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3A'), 9, 'BF', 'Cabeza al muro', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3A'), 10, 'KH HR', 'Trote Medio. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3A'), 11, 'Transiciones', 'Transiciones en K & H', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3A'), 12, 'R Entre R&B', 'Paso medio. Reunir el paso y media pirueta a la derecha(1-3m), y seguir al paso medio', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3A'), 13, 'RS', 'Medio circulo a la izquierda de 20m', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3A'), 14, 'S Entre S&E', 'Paso medio. Reunir el paso y media pirueta a la izquierda(1-3m), y seguir al paso medio', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3A'), 15, 'H HC', 'Partir al galope de trabajo a la derecha. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3A'), 16, 'CA', 'Serpentina de tres bucles, el primero y el último en firme, el segundo en trocado', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3A'), 17, 'KB', 'Cambio de mano con cambio de pie simple cerca de L', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3A'), 18, 'RS', 'Medio circulo de 20m. Al cruzar la línea del centro ceder un momento las riendas y retomarlas antes de entrar en pista', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3A'), 19, 'SK K', 'Galope medio. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3A'), 20, 'Transiciones', 'Transiciones en S&K', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3A'), 21, 'AC', 'Serpentina de tres bucles, el primero y el último en firme, el segundo en trocado', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3A'), 22, 'HB', 'Cambio de mano con cambio de pie simple cerca de L', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3A'), 23, 'P', 'Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-3A'), 24, 'A X', 'Doblar por la línea del centro. Parada-Inmovilidad- Saludo', 1, 'movimiento');

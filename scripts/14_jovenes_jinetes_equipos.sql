INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('14', 'Jovenes Jinetes Equipos', 'RFHE-2022-JJ-EQU', 'Jovenes Jinetes', 'Equipos', 'equipos', 2022, '5''50"', 7, 350, 'JOVENES JINETES EQUIPOS 2022', 'Reprise por equipos jovenes jinetes', 1, 0, 'RFHE-2022-JJ-EQU');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 1, 'A X XC', 'Entrada al galope reunido. Parada - inmovilidad - saludo. Partir al trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 2, 'C MXK K KAF', 'Pista a mano derecha. Cambio de mano al trote medio. Trote reunido. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 3, 'FB', 'Espalda adentro a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 4, 'B', 'Vuelta a la izquierda (8 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 5, 'BG G C', 'Apoyar a la izquierda. Continuar por derecho. Pista a la izquierda', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 6, 'HXF F', 'Trote largo. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 7, 'FAK', 'Transiciones en H y F. Trote reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 8, 'KE', 'Espalda adentro a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 9, 'E', 'Vuelta a la derecha (8 m)', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 10, 'EG G C', 'Apoyar a la derecha. Continuar por derecho. Pista a mano izquierda', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 11, 'Antes de C C H Entre G y M', '[Paso reunido]. [Pista a mano izquierda]. [Doblar a la izquierda]. Media pirueta a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 12, 'Entre G y H G M', 'Media pirueta a la derecha. [Paso reunido]', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 13, 'El paso reunido', 'El paso reunido C-H-G-(M)-G-(H)-G-M', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 14, 'MRXV(K)', 'Paso largo', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 15, 'Antes de K K KAF', 'Paso reunido. Partir a galope reunido a la izquierda. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 16, 'FX X', 'Apoyo a la izquierda. Cambio de pie en el aire', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 17, 'XM M MCH', 'Apoyo a la derecha. Cambio de pie en el aire. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 18, 'H Entre H y X', 'Hacia X a galope reunido. Media pirueta a la izquierda', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 19, 'HC C', 'Galope en trocado. Cambio de pie en el aire', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 20, 'M Entre M y X', 'Avanzar hacia X a galope reunido. Media pirueta a la derecha', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 21, 'MC C', 'Galope en trocado. Cambio de pie en el aire', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 22, 'HXF FAK', 'Sobre la diagonal 5 cambios de pie cada 4 trancos. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 23, 'KXM MCH', 'Sobre la diagonal 5 cambios de pie en el aire cada 3 trancos. Galope reunido', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 24, 'HXF', 'Galope largo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 25, 'F', 'Galope reunido y cambio de pie en el aire', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JJ-EQU'), 26, 'A X', 'Doblar a lo largo. Parada - inmovilidad - saludo', 1, 'movimiento');

INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('31', 'Rider 2A', 'RFHE-2024-RID-2A', 'Rider', 'Rider 2A', 'individual', 2024, '3''30"', 6, 270, 'RIDER 2A 2024', 'Reprise rider 2A', 1, 0, 'RFHE-2024-RID-2A');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2A'), 1, 'A X XC', 'Entrada al trote de trabajo. Parada - inmovilidad - saludo. Trote de Trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2A'), 2, 'C MXK KA', 'Pista a mano derecha. Trote Medio. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2A'), 3, 'Transiciones', 'Transiciones en M & K', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2A'), 4, 'A L', 'Doblar a lo largo. Ceder a la pierna a la derecha, entrando nuevamente en la pista entre R y M', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2A'), 5, 'C', 'Circulo a la izquierda de 20m de diámetro, al pasar por la línea del centro, ceder las riendas algunos trancos, y después retomarlas', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2A'), 6, 'HXF FA', 'Trote medio. Trote de Trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2A'), 7, 'Transiciones', 'Transiciones en H & F', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2A'), 8, 'A L', 'Doblar a lo largo. Ceder a la pierna a la izquierda, entrando nuevamente en la pista entre S y H', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2A'), 9, 'C', 'Trote levantado y circulo de 20m de diámetro a mano derecha. En la primera mitad del circulo, al cruzar la línea del centro, alargar lentamente las riendas y dejar que el caballo se estire en riendas largas, hacia delante y hacia abajo. Poco antes de C, retomar las riendas', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2A'), 10, 'CM', 'Paso Medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2A'), 11, 'MV', 'Paso Medio. Ceder las riendas y dejar al caballo estirarse en riendas largas', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2A'), 12, 'K KF', 'Partir al galope de trabajo a mano izquierda. Galope de Trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2A'), 13, 'FM MH', 'Galope Medio. Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2A'), 14, 'Transiciones', 'Las Transiciones en F & M', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2A'), 15, 'HB PV VS', 'Cambio de mano. Medio circulo en galope Trocado. Galope Trocado', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2A'), 16, 'S', 'Paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2A'), 17, 'H', 'Galope de Trabajo a mano derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2A'), 18, 'MF FK', 'Galope Medio. Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2A'), 19, 'Transiciones', 'Transiciones en M & F', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2A'), 20, 'KB RS SV', 'Cambio de mano en galope de trabajo. Medio Circulo en galope trocado. Galope Trocado', 2, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2A'), 21, 'V', 'Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2A'), 22, 'A I', 'Doblar por la línea del centro. Parada-Inmovilidad- Saludo', 1, 'movimiento');

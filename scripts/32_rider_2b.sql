INSERT INTO reprises (numero, nombre, codigo, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo, reprise_oficial, descripcion, multiplicador, desviacion, fei_numero)
VALUES ('32', 'Rider 2B', 'RFHE-2024-RID-2B', 'Rider', 'Rider 2B', 'individual', 2024, '5''30"', 6, 220, 'RIDER 2B 2024', 'Reprise rider 2B', 1, 0, 'RFHE-2024-RID-2B');

INSERT INTO ejercicios_reprise (reprise_id, numero_orden, letra, descripcion, coeficiente, tipo)
VALUES
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2B'), 1, 'A X C', 'Entrada al trote de trabajo. Parada - inmovilidad - saludo. Partir al Trote de Trabajo. Pista a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2B'), 2, 'CE E', 'Trote de trabajo. Doblar a la izquierda', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2B'), 3, 'X B', 'Circulo izquierda de 15m de diámetro, seguido de un círculo a la derecha de 15 m. de diámetro. Pista a mano derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2B'), 4, 'BAK KXM M', 'Trote de trabajo. Cambio de mano al trote medio. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2B'), 5, 'C G', 'Doblar por la línea del centro. Cesión a la pierna a mano derecha, entrando en la pista entre E & K', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2B'), 6, 'KF FXH H', 'Trote de trabajo. Cambio de mano al trote medio. Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2B'), 7, 'C G', 'Doblar por la línea del centro. Cesión a la pierna a mano izquierda, entrando en la pista entre B & F', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2B'), 8, 'FA A', 'Trote de trabajo. Paso libre con riendas largas', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2B'), 9, 'KB', 'Cambio de mano en Paso libre con riendas largas', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2B'), 10, 'BH', 'Cambio de mano en paso medio', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2B'), 11, 'C', 'Parada-Inmovilidad. Paso atrás Aproximadamente la longitud de un caballo, e inmediatamente partir al trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2B'), 12, 'M', 'Galope de trabajo a la derecha', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2B'), 13, 'A', 'Circulo a la derecha de 15m. de diámetro. Al volver a entrar en la pista en A, ceder y recoger la rienda interior', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2B'), 14, 'KH', 'Bucle de 6 a 8 metros', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2B'), 15, 'B', 'Medio círculo a la derecha de 10m, de diámetro, seguido de medio círculo a la izquierda de 10m. de diámetro hasta E, cambiando de pie al pasar por X con trancos de trote', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2B'), 16, 'EA A', 'Galope de trabajo. Circulo a la izquierda de 15m. de diámetro. Al volver a entrar en la pista en A, ceder y recoger la rienda interior', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2B'), 17, 'FM', 'Bucle de 6 a 8 metros', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2B'), 18, 'C CE', 'Circulo izquierda de 20m de diámetro, mostrando algún trance de Galope medio. Galope de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2B'), 19, 'E', 'Medio círculo a la izquierda de 10m, de diámetro, seguido de medio círculo a la derecha de 10m. de diámetro hasta B, cambiando de pie al pasar por X con trancos de trote', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2B'), 20, 'B', 'Circulo a la derecha de 20m. de diámetro, dejando al caballo estirarse unos trancos. Al entrar en la pista en B, recoger las riendas', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2B'), 21, 'F', 'Trote de trabajo', 1, 'movimiento'),
((SELECT id FROM reprises WHERE codigo = 'RFHE-2024-RID-2B'), 22, 'A X', 'Doblar por la línea del centro. Parada-Inmovilidad - Saludo', 1, 'movimiento');

-- ============================================
-- EJERCICIOS: ALEVINES PRELIMINAR 2024
-- ============================================

INSERT INTO ejercicios_reprise 
(reprise_id, numero_orden, letra, descripcion, coeficiente, puntuacion_max, tipo)
VALUES
('57625b7e-3c7f-4013-952b-920c6852ec94', 1, 'A X C', 'Entrada al trote de trabajo. Parada - inmovilidad - saludo. Partir al trote de trabajo. Pista a mano izquierda', 1, 10, 'movimiento'),
('57625b7e-3c7f-4013-952b-920c6852ec94', 2, 'E EK', 'Circulo a la izquierda de 15 m. de diametro. Trote de trabajo', 1, 10, 'movimiento'),
('57625b7e-3c7f-4013-952b-920c6852ec94', 3, 'FXH H HCMB', 'Cambio de mano al trote levantado, ampliando el tranco. Transicion a trote de trabajo. Trote de trabajo', 1, 10, 'movimiento'),
('57625b7e-3c7f-4013-952b-920c6852ec94', 4, 'B BFA', 'Circulo a la derecha de 15 m. de diametro. Trote de trabajo', 1, 10, 'movimiento'),
('57625b7e-3c7f-4013-952b-920c6852ec94', 5, 'Cerca de A', 'Transicion al paso medio', 1, 10, 'movimiento'),
('57625b7e-3c7f-4013-952b-920c6852ec94', 6, 'KB', 'Paso libre alargando la linea superior', 1, 10, 'movimiento'),
('57625b7e-3c7f-4013-952b-920c6852ec94', 7, 'Entre B y R', 'Paso medio', 1, 10, 'movimiento'),
('57625b7e-3c7f-4013-952b-920c6852ec94', 8, 'RMC', 'Trote de trabajo', 1, 10, 'movimiento'),
('57625b7e-3c7f-4013-952b-920c6852ec94', 9, 'Cerca de C CH E', 'Partir a galope de trabajo a mano izquierda. Galope de trabajo', 1, 10, 'movimiento'),
('57625b7e-3c7f-4013-952b-920c6852ec94', 10, 'E', 'Circulo a la izquierda de 20 m. de diametro', 1, 10, 'movimiento'),
('57625b7e-3c7f-4013-952b-920c6852ec94', 11, 'EKAF', 'Galope de trabajo', 1, 10, 'movimiento'),
('57625b7e-3c7f-4013-952b-920c6852ec94', 12, 'FB BE BE', 'Trote de trabajo. Semicirculo a la izquierda de 20 m. de diametro. Cambio de mano dentro del circulo de 20 m. haciendo una S. Semicirculo a la derecha de 20 m. de diametro', 1, 10, 'movimiento'),
('57625b7e-3c7f-4013-952b-920c6852ec94', 13, 'Cerca de C', 'Trote de trabajo', 1, 10, 'movimiento'),
('57625b7e-3c7f-4013-952b-920c6852ec94', 14, 'B', 'Circulo a la derecha de 20 m. de diametro', 1, 10, 'movimiento'),
('57625b7e-3c7f-4013-952b-920c6852ec94', 15, 'Cerca de F', 'Trote de trabajo', 1, 10, 'movimiento'),
('57625b7e-3c7f-4013-952b-920c6852ec94', 16, 'A I', 'Doblar a lo largo. Parada - Inmovilidad - Saludo', 1, 10, 'movimiento');

-- Notas de conjunto (7 criterios)
INSERT INTO ejercicios_reprise
(reprise_id, numero_orden, letra, descripcion, coeficiente, puntuacion_max, tipo)
VALUES
('57625b7e-3c7f-4013-952b-920c6852ec94', 101, 'NC1', 'Aires (soltura y regularidad)', 1, 10, 'nota_conjunto'),
('57625b7e-3c7f-4013-952b-920c6852ec94', 102, 'NC2', 'Energia y Remetimiento (deseo de ir hacia delante, descontraccion del dorso, elasticidad, remetimiento de los posteriores y tempo mantenido)', 1, 10, 'nota_conjunto'),
('57625b7e-3c7f-4013-952b-920c6852ec94', 103, 'NC3', 'Posicion del cuello y nuca (contacto suave y mantenido, nuca en el punto mas alto, angulo de nuca ligeramente delante de la vertical)', 1, 10, 'nota_conjunto'),
('57625b7e-3c7f-4013-952b-920c6852ec94', 104, 'NC4', 'Atencion y confianza (sumision y facilidad de los movimientos)', 1, 10, 'nota_conjunto'),
('57625b7e-3c7f-4013-952b-920c6852ec94', 105, 'NC5', 'Posicion y asiento del jinete', 1, 10, 'nota_conjunto'),
('57625b7e-3c7f-4013-952b-920c6852ec94', 106, 'NC6', 'Correccion y efecto de las ayudas', 1, 10, 'nota_conjunto'),
('57625b7e-3c7f-4013-952b-920c6852ec94', 107, 'NC7', 'Correccion en esquinas y transiciones', 1, 10, 'nota_conjunto');

-- Borrar TODOS los binomios y reinscribirlos limpios
DELETE FROM inscripciones;
DELETE FROM binomios;

INSERT INTO binomios (nombre_jinete, nombre_caballo, anio, licencia_federativa) VALUES
('Magui', 'Brujo', 2015, 'MAG-001'),
('Juan', 'Rayo', 2016, 'JUA-002'),
('Maria', 'Luna', 2014, 'MAR-003'),
('Pedro', 'Estrella', 2017, 'PED-004'),
('Sofia', 'Trueno', 2013, 'SOF-005'),
('Diego', 'Relampago', 2018, 'DIE-006'),
('Lucia', 'Fantasma', 2015, 'LUC-007'),
('Andres', 'Cometa', 2016, 'AND-008'),
('Elena', 'Trufa', 2014, 'ELE-009'),
('Pablo', 'Vendaval', 2017, 'PAB-010'),
('Carmen', 'Nube', 2015, 'CAR-011'),
('Raul', 'Tornado', 2013, 'RAU-012');

SELECT COUNT(*) AS total_binomios FROM binomios;

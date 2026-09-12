-- ============================================
-- SEED 02: BINOMIOS
-- ============================================
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

-- ============================================
-- SEED 02: CONCURSOS
-- ============================================
INSERT INTO concursos (nombre, fecha_inicio, fecha_fin, ubicacion, organizador, created_by)
VALUES 
('Primavera 2026', '2026-03-15', '2026-03-17', 'Madrid', 'RFHE', (SELECT id FROM profiles WHERE email = 'vramosr1986@gmail.com')),
('Verano 2026', '2026-06-20', '2026-06-22', 'Sevilla', 'RFHE', (SELECT id FROM profiles WHERE email = 'vramosr1986@gmail.com')),
('Otono 2026', '2026-10-10', '2026-10-11', 'Barcelona', 'RFHE', (SELECT id FROM profiles WHERE email = 'vramosr1986@gmail.com'));

-- Verificar
SELECT 'binomios' AS tabla, COUNT(*) AS total FROM binomios
UNION ALL
SELECT 'concursos', COUNT(*) FROM concursos;

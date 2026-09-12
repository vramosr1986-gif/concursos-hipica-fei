-- ============================================
-- SEED: DATOS BASE (BINOMIOS, CONCURSOS, INSCRIPCIONES, PRUEBAS)
-- ============================================

-- ============================================
-- BINOMIOS
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
('Raul', 'Tornado', 2013, 'RAU-012')
ON CONFLICT (licencia_federativa) DO NOTHING;

-- ============================================
-- CONCURSOS
-- ============================================
INSERT INTO concursos (nombre, fecha_inicio, fecha_fin, ubicacion, organizador, created_by)
VALUES 
('Primavera 2026', '2026-03-15', '2026-03-17', 'Madrid', 'RFHE', (SELECT id FROM profiles WHERE email = 'vramosr1986@gmail.com')),
('Verano 2026', '2026-06-20', '2026-06-22', 'Sevilla', 'RFHE', (SELECT id FROM profiles WHERE email = 'vramosr1986@gmail.com')),
('Otono 2026', '2026-10-10', '2026-10-11', 'Barcelona', 'RFHE', (SELECT id FROM profiles WHERE email = 'vramosr1986@gmail.com'))
ON CONFLICT DO NOTHING;

-- ============================================
-- INSCRIPCIONES (usando subconsultas por nombre)
-- ============================================
DO $$
DECLARE
  v_primavera uuid;
  v_verano uuid;
  v_otono uuid;
  v_magui uuid;
  v_juan uuid;
  v_maria uuid;
  v_pedro uuid;
  v_sofia uuid;
  v_diego uuid;
  v_lucia uuid;
  v_andres uuid;
  v_elena uuid;
  v_pablo uuid;
  v_carmen uuid;
  v_raul uuid;
BEGIN
  -- Obtener IDs de concursos
  SELECT id INTO v_primavera FROM concursos WHERE nombre = 'Primavera 2026';
  SELECT id INTO v_verano FROM concursos WHERE nombre = 'Verano 2026';
  SELECT id INTO v_otono FROM concursos WHERE nombre = 'Otono 2026';

  -- Obtener IDs de binomios
  SELECT id INTO v_magui FROM binomios WHERE licencia_federativa = 'MAG-001';
  SELECT id INTO v_juan FROM binomios WHERE licencia_federativa = 'JUA-002';
  SELECT id INTO v_maria FROM binomios WHERE licencia_federativa = 'MAR-003';
  SELECT id INTO v_pedro FROM binomios WHERE licencia_federativa = 'PED-004';
  SELECT id INTO v_sofia FROM binomios WHERE licencia_federativa = 'SOF-005';
  SELECT id INTO v_diego FROM binomios WHERE licencia_federativa = 'DIE-006';
  SELECT id INTO v_lucia FROM binomios WHERE licencia_federativa = 'LUC-007';
  SELECT id INTO v_andres FROM binomios WHERE licencia_federativa = 'AND-008';
  SELECT id INTO v_elena FROM binomios WHERE licencia_federativa = 'ELE-009';
  SELECT id INTO v_pablo FROM binomios WHERE licencia_federativa = 'PAB-010';
  SELECT id INTO v_carmen FROM binomios WHERE licencia_federativa = 'CAR-011';
  SELECT id INTO v_raul FROM binomios WHERE licencia_federativa = 'RAU-012';

  -- ============================================
  -- INSCRIPCIONES PRIMAVERA 2026
  -- ============================================
  INSERT INTO inscripciones (binomio_id, concurso_id, dorsal, categoria, orden_salida) VALUES
    (v_magui, v_primavera, 1, 'Alevines', 1),
    (v_juan, v_primavera, 2, 'Alevines', 2),
    (v_maria, v_primavera, 3, 'Infantiles', 3),
    (v_pedro, v_primavera, 4, 'Infantiles', 4),
    (v_sofia, v_primavera, 5, 'Juveniles', 5),
    (v_diego, v_primavera, 6, 'Juveniles', 6),
    (v_lucia, v_primavera, 7, 'Alevines', 7),
    (v_andres, v_primavera, 8, 'Infantiles', 8)
  ON CONFLICT (concurso_id, dorsal) DO NOTHING;

  -- ============================================
  -- INSCRIPCIONES VERANO 2026
  -- ============================================
  INSERT INTO inscripciones (binomio_id, concurso_id, dorsal, categoria, orden_salida) VALUES
    (v_sofia, v_verano, 1, 'Juveniles', 1),
    (v_diego, v_verano, 2, 'Juveniles', 2),
    (v_elena, v_verano, 3, 'Clasica', 3),
    (v_pablo, v_verano, 4, 'Clasica', 4),
    (v_carmen, v_verano, 5, 'Clasica', 5),
    (v_raul, v_verano, 6, 'Clasica', 6),
    (v_magui, v_verano, 7, 'Alevines', 7),
    (v_juan, v_verano, 8, 'Alevines', 8),
    (v_maria, v_verano, 9, 'Infantiles', 9),
    (v_pedro, v_verano, 10, 'Infantiles', 10),
    (v_lucia, v_verano, 11, 'Juveniles', 11),
    (v_andres, v_verano, 12, 'Juveniles', 12)
  ON CONFLICT (concurso_id, dorsal) DO NOTHING;

  -- ============================================
  -- INSCRIPCIONES OTONO 2026
  -- ============================================
  INSERT INTO inscripciones (binomio_id, concurso_id, dorsal, categoria, orden_salida) VALUES
    (v_maria, v_otono, 1, 'Jovenes Jinetes', 1),
    (v_pedro, v_otono, 2, 'Jovenes Jinetes', 2),
    (v_lucia, v_otono, 3, 'Clasica', 3),
    (v_andres, v_otono, 4, 'Clasica', 4),
    (v_magui, v_otono, 5, 'Alevines', 5),
    (v_sofia, v_otono, 6, 'Juveniles', 6),
    (v_diego, v_otono, 7, 'Juveniles', 7),
    (v_elena, v_otono, 8, 'Clasica', 8),
    (v_pablo, v_otono, 9, 'Clasica', 9),
    (v_carmen, v_otono, 10, 'Clasica', 10)
  ON CONFLICT (concurso_id, dorsal) DO NOTHING;

  -- ============================================
  -- PRUEBAS PRIMAVERA 2026
  -- ============================================
  INSERT INTO pruebas (concurso_id, reprise_id, nombre, categoria, fecha, hora_inicio, pista, orden, estado) VALUES
    (v_primavera, (SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-1'), 'Clasica 1 - Alevines', 'Alevines', '2026-03-15', '09:00', 'Pista A', 1, 'programada'),
    (v_primavera, (SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-2'), 'Clasica 2 - Infantiles', 'Infantiles', '2026-03-15', '11:00', 'Pista A', 2, 'programada'),
    (v_primavera, (SELECT id FROM reprises WHERE codigo = 'RFHE-2024-PRO-2'), 'Promocion 2 - Juveniles', 'Juveniles', '2026-03-16', '10:00', 'Pista B', 3, 'programada');

  -- ============================================
  -- PRUEBAS VERANO 2026
  -- ============================================
  INSERT INTO pruebas (concurso_id, reprise_id, nombre, categoria, fecha, hora_inicio, pista, orden, estado) VALUES
    (v_verano, (SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-PRE'), 'Juveniles Preliminar', 'Juveniles', '2026-06-20', '10:00', 'Pista A', 1, 'programada'),
    (v_verano, (SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'), 'Intermedia I - Adultos', 'Clasica', '2026-06-21', '12:00', 'Pista A', 2, 'programada'),
    (v_verano, (SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GP'), 'Gran Premio - Adultos', 'Clasica', '2026-06-22', '16:00', 'Pista A', 3, 'programada');

  -- ============================================
  -- PRUEBAS OTONO 2026
  -- ============================================
  INSERT INTO pruebas (concurso_id, reprise_id, nombre, categoria, fecha, hora_inicio, pista, orden, estado) VALUES
    (v_otono, (SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-3'), 'Promocion 3 - Jovenes Jinetes', 'Jovenes Jinetes', '2026-10-10', '09:00', 'Pista A', 1, 'programada'),
    (v_otono, (SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-3'), 'Clasica 3 - Adultos', 'Clasica', '2026-10-10', '11:00', 'Pista A', 2, 'programada');
END $$;

-- ============================================
-- VERIFICACION
-- ============================================
SELECT 'binomios' AS tabla, COUNT(*)::text AS total FROM binomios
UNION ALL SELECT 'concursos', COUNT(*)::text FROM concursos
UNION ALL SELECT 'inscripciones', COUNT(*)::text FROM inscripciones
UNION ALL SELECT 'pruebas', COUNT(*)::text FROM pruebas;

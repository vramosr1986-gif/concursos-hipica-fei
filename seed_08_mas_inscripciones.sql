-- ============================================
-- VERANO 2026: AÑADIR 6 INSCRIPCIONES
-- ============================================
INSERT INTO inscripciones (binomio_id, concurso_id, dorsal, categoria, equipo, orden_salida) VALUES
((SELECT id FROM binomios WHERE licencia_federativa = 'MAG-001'), 'fc9d2856-33bd-453f-9227-b27601a884c3', 7, 'Alevines', NULL, 7),
((SELECT id FROM binomios WHERE licencia_federativa = 'JUA-002'), 'fc9d2856-33bd-453f-9227-b27601a884c3', 8, 'Alevines', NULL, 8),
((SELECT id FROM binomios WHERE licencia_federativa = 'MAR-003'), 'fc9d2856-33bd-453f-9227-b27601a884c3', 9, 'Infantiles', NULL, 9),
((SELECT id FROM binomios WHERE licencia_federativa = 'PED-004'), 'fc9d2856-33bd-453f-9227-b27601a884c3', 10, 'Infantiles', NULL, 10),
((SELECT id FROM binomios WHERE licencia_federativa = 'LUC-007'), 'fc9d2856-33bd-453f-9227-b27601a884c3', 11, 'Juveniles', NULL, 11),
((SELECT id FROM binomios WHERE licencia_federativa = 'AND-008'), 'fc9d2856-33bd-453f-9227-b27601a884c3', 12, 'Juveniles', NULL, 12);

-- ============================================
-- OTONO 2026: AÑADIR 6 INSCRIPCIONES
-- ============================================
INSERT INTO inscripciones (binomio_id, concurso_id, dorsal, categoria, equipo, orden_salida) VALUES
((SELECT id FROM binomios WHERE licencia_federativa = 'MAG-001'), 'a31f95d5-6f42-4f43-af61-da4705ca3d44', 5, 'Alevines', NULL, 5),
((SELECT id FROM binomios WHERE licencia_federativa = 'SOF-005'), 'a31f95d5-6f42-4f43-af61-da4705ca3d44', 6, 'Juveniles', NULL, 6),
((SELECT id FROM binomios WHERE licencia_federativa = 'DIE-006'), 'a31f95d5-6f42-4f43-af61-da4705ca3d44', 7, 'Juveniles', NULL, 7),
((SELECT id FROM binomios WHERE licencia_federativa = 'ELE-009'), 'a31f95d5-6f42-4f43-af61-da4705ca3d44', 8, 'Clasica', NULL, 8),
((SELECT id FROM binomios WHERE licencia_federativa = 'PAB-010'), 'a31f95d5-6f42-4f43-af61-da4705ca3d44', 9, 'Clasica', NULL, 9),
((SELECT id FROM binomios WHERE licencia_federativa = 'CAR-011'), 'a31f95d5-6f42-4f43-af61-da4705ca3d44', 10, 'Clasica', NULL, 10);

-- ============================================
-- VERIFICAR
-- ============================================
SELECT 
  c.nombre AS concurso,
  COUNT(i.id) AS total_inscripciones
FROM concursos c
LEFT JOIN inscripciones i ON i.concurso_id = c.id
GROUP BY c.nombre
ORDER BY c.nombre;

-- ============================================
-- INSCRIPCIONES: PRIMAVERA 2026
-- ============================================
INSERT INTO inscripciones (binomio_id, concurso_id, dorsal, categoria, equipo, orden_salida) VALUES
((SELECT id FROM binomios WHERE licencia_federativa = 'MAG-001'), '7994f61f-525e-41db-a920-106b5ee99f38', 1, 'Alevines', NULL, 1),
((SELECT id FROM binomios WHERE licencia_federativa = 'JUA-002'), '7994f61f-525e-41db-a920-106b5ee99f38', 2, 'Alevines', NULL, 2),
((SELECT id FROM binomios WHERE licencia_federativa = 'MAR-003'), '7994f61f-525e-41db-a920-106b5ee99f38', 3, 'Infantiles', NULL, 3),
((SELECT id FROM binomios WHERE licencia_federativa = 'PED-004'), '7994f61f-525e-41db-a920-106b5ee99f38', 4, 'Infantiles', NULL, 4),
((SELECT id FROM binomios WHERE licencia_federativa = 'SOF-005'), '7994f61f-525e-41db-a920-106b5ee99f38', 5, 'Juveniles', NULL, 5),
((SELECT id FROM binomios WHERE licencia_federativa = 'DIE-006'), '7994f61f-525e-41db-a920-106b5ee99f38', 6, 'Juveniles', NULL, 6),
((SELECT id FROM binomios WHERE licencia_federativa = 'LUC-007'), '7994f61f-525e-41db-a920-106b5ee99f38', 7, 'Alevines', NULL, 7),
((SELECT id FROM binomios WHERE licencia_federativa = 'AND-008'), '7994f61f-525e-41db-a920-106b5ee99f38', 8, 'Infantiles', NULL, 8);

-- ============================================
-- INSCRIPCIONES: VERANO 2026
-- ============================================
INSERT INTO inscripciones (binomio_id, concurso_id, dorsal, categoria, equipo, orden_salida) VALUES
((SELECT id FROM binomios WHERE licencia_federativa = 'SOF-005'), 'fc9d2856-33bd-453f-9227-b27601a884c3', 1, 'Juveniles', NULL, 1),
((SELECT id FROM binomios WHERE licencia_federativa = 'DIE-006'), 'fc9d2856-33bd-453f-9227-b27601a884c3', 2, 'Juveniles', NULL, 2),
((SELECT id FROM binomios WHERE licencia_federativa = 'ELE-009'), 'fc9d2856-33bd-453f-9227-b27601a884c3', 3, 'Clasica', NULL, 3),
((SELECT id FROM binomios WHERE licencia_federativa = 'PAB-010'), 'fc9d2856-33bd-453f-9227-b27601a884c3', 4, 'Clasica', NULL, 4),
((SELECT id FROM binomios WHERE licencia_federativa = 'CAR-011'), 'fc9d2856-33bd-453f-9227-b27601a884c3', 5, 'Clasica', NULL, 5),
((SELECT id FROM binomios WHERE licencia_federativa = 'RAU-012'), 'fc9d2856-33bd-453f-9227-b27601a884c3', 6, 'Clasica', NULL, 6);

-- ============================================
-- INSCRIPCIONES: OTONO 2026
-- ============================================
INSERT INTO inscripciones (binomio_id, concurso_id, dorsal, categoria, equipo, orden_salida) VALUES
((SELECT id FROM binomios WHERE licencia_federativa = 'MAR-003'), 'a31f95d5-6f42-4f43-af61-da4705ca3d44', 1, 'Jovenes Jinetes', NULL, 1),
((SELECT id FROM binomios WHERE licencia_federativa = 'PED-004'), 'a31f95d5-6f42-4f43-af61-da4705ca3d44', 2, 'Jovenes Jinetes', NULL, 2),
((SELECT id FROM binomios WHERE licencia_federativa = 'LUC-007'), 'a31f95d5-6f42-4f43-af61-da4705ca3d44', 3, 'Clasica', NULL, 3),
((SELECT id FROM binomios WHERE licencia_federativa = 'AND-008'), 'a31f95d5-6f42-4f43-af61-da4705ca3d44', 4, 'Clasica', NULL, 4);

-- ============================================
-- VERIFICAR
-- ============================================
SELECT c.nombre AS concurso, i.categoria, COUNT(*) AS inscritos
FROM inscripciones i
LEFT JOIN concursos c ON c.id = i.concurso_id
GROUP BY c.nombre, i.categoria
ORDER BY c.nombre, i.categoria;

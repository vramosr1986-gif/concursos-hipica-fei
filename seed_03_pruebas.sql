-- ============================================
-- PRIMAVERA 2026
-- ============================================
INSERT INTO pruebas (concurso_id, reprise_id, nombre, categoria, fecha, hora_inicio, pista, orden, estado) VALUES
(
  '7994f61f-525e-41db-a920-106b5ee99f38',
  (SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-1'),
  'Clasica 1 - Alevines',
  'Alevines',
  '2026-03-15',
  '09:00',
  'Pista A',
  1,
  'programada'
),
(
  '7994f61f-525e-41db-a920-106b5ee99f38',
  (SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-2'),
  'Clasica 2 - Infantiles',
  'Infantiles',
  '2026-03-15',
  '11:00',
  'Pista A',
  2,
  'programada'
),
(
  '7994f61f-525e-41db-a920-106b5ee99f38',
  (SELECT id FROM reprises WHERE codigo = 'RFHE-2024-PRO-2'),
  'Promocion 2 - Juveniles',
  'Juveniles',
  '2026-03-16',
  '10:00',
  'Pista B',
  3,
  'programada'
);

-- ============================================
-- VERANO 2026
-- ============================================
INSERT INTO pruebas (concurso_id, reprise_id, nombre, categoria, fecha, hora_inicio, pista, orden, estado) VALUES
(
  'fc9d2856-33bd-453f-9227-b27601a884c3',
  (SELECT id FROM reprises WHERE codigo = 'RFHE-2022-JUV-PRE'),
  'Juveniles Preliminar',
  'Juveniles',
  '2026-06-20',
  '10:00',
  'Pista A',
  1,
  'programada'
),
(
  'fc9d2856-33bd-453f-9227-b27601a884c3',
  (SELECT id FROM reprises WHERE codigo = 'RFHE-2022-INT-I'),
  'Intermedia I - Adultos',
  'Clasica',
  '2026-06-21',
  '12:00',
  'Pista A',
  2,
  'programada'
),
(
  'fc9d2856-33bd-453f-9227-b27601a884c3',
  (SELECT id FROM reprises WHERE codigo = 'RFHE-2022-GP'),
  'Gran Premio - Adultos',
  'Clasica',
  '2026-06-22',
  '16:00',
  'Pista A',
  3,
  'programada'
);

-- ============================================
-- OTONO 2026
-- ============================================
INSERT INTO pruebas (concurso_id, reprise_id, nombre, categoria, fecha, hora_inicio, pista, orden, estado) VALUES
(
  'a31f95d5-6f42-4f43-af61-da4705ca3d44',
  (SELECT id FROM reprises WHERE codigo = 'RFHE-2022-PRO-3'),
  'Promocion 3 - Jovenes Jinetes',
  'Jovenes Jinetes',
  '2026-10-10',
  '09:00',
  'Pista A',
  1,
  'programada'
),
(
  'a31f95d5-6f42-4f43-af61-da4705ca3d44',
  (SELECT id FROM reprises WHERE codigo = 'RFHE-2023-CLA-3'),
  'Clasica 3 - Adultos',
  'Clasica',
  '2026-10-10',
  '11:00',
  'Pista A',
  2,
  'programada'
);

-- Verificar
SELECT c.nombre AS concurso, p.nombre AS prueba, p.categoria, p.fecha, p.hora_inicio 
FROM pruebas p 
LEFT JOIN concursos c ON c.id = p.concurso_id 
ORDER BY c.nombre, p.orden;

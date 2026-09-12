-- 007_niveles_reprises.sql
CREATE TABLE IF NOT EXISTS niveles_reprises (
  nivel_id uuid REFERENCES niveles(id) ON DELETE CASCADE,
  reprise_id uuid REFERENCES reprises(id) ON DELETE CASCADE,
  PRIMARY KEY (nivel_id, reprise_id)
);

INSERT INTO niveles_reprises (nivel_id, reprise_id)
SELECT (SELECT id FROM niveles WHERE codigo = 'N0'), id
FROM reprises
WHERE codigo IN ('RFHE-BEN-1','RFHE-BEN-2','RFHE-AP-PRE','RFHE-AP-FIN')
ON CONFLICT DO NOTHING;

INSERT INTO niveles_reprises (nivel_id, reprise_id)
SELECT (SELECT id FROM niveles WHERE codigo = 'N1'), id
FROM reprises
WHERE codigo IN (
  'RFHE-2024-ALE-PRE','RFHE-2024-ALE-EQU','RFHE-2024-ALE-IND',
  'RFHE-2022-CJ4-PRE','RFHE-2022-CJ4-FIN','RFHE-2022-CJ4-EXP',
  'RFHE-2022-PRO-1',
  'RFHE-2024-RID-1A','RFHE-2024-RID-1B','RFHE-2024-RID-1C'
)
ON CONFLICT DO NOTHING;

INSERT INTO niveles_reprises (nivel_id, reprise_id)
SELECT (SELECT id FROM niveles WHERE codigo = 'N2'), id
FROM reprises
WHERE codigo IN (
  'RFHE-2024-INF-PRE-A','RFHE-2024-INF-PRE-B','RFHE-2024-INF-EQU','RFHE-2024-INF-IND',
  'RFHE-2022-CJ5-PRE','RFHE-2022-CJ5-FIN',
  'RFHE-2024-PRO-2',
  'RFHE-2024-RID-2A','RFHE-2024-RID-2B','RFHE-2024-RID-2C'
)
ON CONFLICT DO NOTHING;

INSERT INTO niveles_reprises (nivel_id, reprise_id)
SELECT (SELECT id FROM niveles WHERE codigo = 'N3'), id
FROM reprises
WHERE codigo IN (
  'RFHE-2022-PON-PRE','RFHE-2022-PON-EQU','RFHE-2022-PON-IND',
  'RFHE-2022-JUV0-PRE','RFHE-2022-JUV0-EQU','RFHE-2022-JUV0-IND',
  'RFHE-2022-PRO-3',
  'RFHE-2024-RID-3A','RFHE-2024-RID-3B','RFHE-2024-RID-3C'
)
ON CONFLICT DO NOTHING;

INSERT INTO niveles_reprises (nivel_id, reprise_id)
SELECT (SELECT id FROM niveles WHERE codigo = 'N4'), id
FROM reprises
WHERE codigo IN (
  'RFHE-2022-CJ6-PRE','RFHE-2022-CJ6-FIN',
  'RFHE-2023-CLA-1','RFHE-2023-CLA-2','RFHE-2023-CLA-3',
  'RFHE-2022-JUV-PRE','RFHE-2022-JUV-EQU','RFHE-2018-JUV-IND',
  'RFHE-2022-PRO-4'
)
ON CONFLICT DO NOTHING;

INSERT INTO niveles_reprises (nivel_id, reprise_id)
SELECT (SELECT id FROM niveles WHERE codigo = 'SJ'), id
FROM reprises
WHERE codigo IN (
  'RFHE-2022-CJ7-PRE','RFHE-2022-CJ7-FIN','RFHE-2022-CJ7-FIN2',
  'RFHE-2022-JJ-PRE','RFHE-2022-JJ-EQU','RFHE-2022-JJ-IND',
  'RFHE-2022-SJ'
)
ON CONFLICT DO NOTHING;

INSERT INTO niveles_reprises (nivel_id, reprise_id)
SELECT (SELECT id FROM niveles WHERE codigo = 'INT_I'), id
FROM reprises
WHERE codigo IN ('RFHE-2022-INT-I')
ON CONFLICT DO NOTHING;

INSERT INTO niveles_reprises (nivel_id, reprise_id)
SELECT (SELECT id FROM niveles WHERE codigo = 'INT_II'), id
FROM reprises
WHERE codigo IN ('RFHE-2022-INT-A','RFHE-2022-INT-B','RFHE-2022-INT-II')
ON CONFLICT DO NOTHING;

INSERT INTO niveles_reprises (nivel_id, reprise_id)
SELECT (SELECT id FROM niveles WHERE codigo = 'GP'), id
FROM reprises
WHERE codigo IN ('RFHE-2022-GP','RFHE-2022-GPE','RFHE-2022-GPU25','RFHE-2022-CJ8-10')
ON CONFLICT DO NOTHING;

INSERT INTO niveles_reprises (nivel_id, reprise_id)
SELECT (SELECT id FROM niveles WHERE codigo = 'KUR'), id
FROM reprises
WHERE codigo LIKE 'RFHE-2022-KUR-%'
ON CONFLICT DO NOTHING;

SELECT 
  n.codigo AS nivel,
  n.nombre AS nombre_nivel,
  COUNT(nr.reprise_id) AS reprises_asignadas
FROM niveles n
LEFT JOIN niveles_reprises nr ON nr.nivel_id = n.id
GROUP BY n.codigo, n.nombre, n.orden
ORDER BY n.orden;
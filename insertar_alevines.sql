-- REPRISE: ALEVINES PRELIMINAR 2024
INSERT INTO reprises (
  numero, nombre, codigo, categoria, nivel, tipo, anio,
  tiempo_orientativo, edad_minima_caballo, total_maximo,
  reprise_oficial, descripcion, multiplicador, desviacion,
  fei_numero
) VALUES (
  '1',
  'Alevines Preliminar',
  'RFHE-2024-ALE-PRE',
  'Alevines',
  'Preliminar',
  'preliminar',
  2024,
  '4''00"',
  6,
  160,
  'ALEVINES PRELIMINAR 2024',
  'Reprise de iniciacion para jinetes alevines',
  1,
  0,
  'RFHE-2024-ALE-PRE'
) RETURNING id;

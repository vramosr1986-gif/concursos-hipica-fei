-- Comprobacion UTF-8 en Supabase (solo lectura; no modifica datos).

-- 1) Codificacion de la base de datos: debe devolver UTF8 en las tres.
SELECT current_setting('server_encoding') AS server_encoding,
       current_setting('client_encoding') AS client_encoding,
       (SELECT pg_encoding_to_char(encoding) FROM pg_database WHERE datname = current_database()) AS db_encoding;

-- 2) Texto con "mojibake" (UTF-8 leido como Windows-1252), por tabla y columna.
--    Patrones tipicos: Ã© Ã± Ã³ Â° â€" ðŸ
SELECT 'reprises.nombre' AS campo, count(*) AS filas FROM reprises WHERE nombre ~ '(Ã.|Â.|â€|ðŸ)'
UNION ALL SELECT 'reprises.descripcion', count(*) FROM reprises WHERE descripcion ~ '(Ã.|Â.|â€|ðŸ)'
UNION ALL SELECT 'ejercicios_reprise.descripcion', count(*) FROM ejercicios_reprise WHERE descripcion ~ '(Ã.|Â.|â€|ðŸ)'
UNION ALL SELECT 'binomios.nombre_jinete', count(*) FROM binomios WHERE nombre_jinete ~ '(Ã.|Â.|â€|ðŸ)'
UNION ALL SELECT 'binomios.nombre_caballo', count(*) FROM binomios WHERE nombre_caballo ~ '(Ã.|Â.|â€|ðŸ)'
UNION ALL SELECT 'concursos.nombre', count(*) FROM concursos WHERE nombre ~ '(Ã.|Â.|â€|ðŸ)'
UNION ALL SELECT 'concursos.ubicacion', count(*) FROM concursos WHERE ubicacion ~ '(Ã.|Â.|â€|ðŸ)'
UNION ALL SELECT 'pruebas.nombre', count(*) FROM pruebas WHERE nombre ~ '(Ã.|Â.|â€|ðŸ)'
UNION ALL SELECT 'pruebas.categoria', count(*) FROM pruebas WHERE categoria ~ '(Ã.|Â.|â€|ðŸ)'
UNION ALL SELECT 'profiles.nombre', count(*) FROM profiles WHERE nombre ~ '(Ã.|Â.|â€|ðŸ)'
ORDER BY filas DESC;

-- 3) Caracteres de sustitucion U+FFFD (texto ya perdido, hay que reescribirlo a mano).
SELECT 'reprises.nombre' AS campo, count(*) AS filas FROM reprises WHERE nombre LIKE '%' || chr(65533) || '%'
UNION ALL SELECT 'ejercicios_reprise.descripcion', count(*) FROM ejercicios_reprise WHERE descripcion LIKE '%' || chr(65533) || '%'
UNION ALL SELECT 'binomios.nombre_jinete', count(*) FROM binomios WHERE nombre_jinete LIKE '%' || chr(65533) || '%';

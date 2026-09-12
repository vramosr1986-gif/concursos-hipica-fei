-- Borrar TODOS los concursos (primero pruebas y dependencias)
DELETE FROM concursos;

-- Insertar SOLO 3 concursos
INSERT INTO concursos (nombre, fecha_inicio, fecha_fin, ubicacion, organizador, created_by)
VALUES 
('Primavera 2026', '2026-03-15', '2026-03-17', 'Madrid', 'RFHE', (SELECT id FROM profiles WHERE email = 'vramosr1986@gmail.com')),
('Verano 2026', '2026-06-20', '2026-06-22', 'Sevilla', 'RFHE', (SELECT id FROM profiles WHERE email = 'vramosr1986@gmail.com')),
('Otono 2026', '2026-10-10', '2026-10-11', 'Barcelona', 'RFHE', (SELECT id FROM profiles WHERE email = 'vramosr1986@gmail.com'));

-- Verificar
SELECT id, nombre, fecha_inicio FROM concursos ORDER BY fecha_inicio;

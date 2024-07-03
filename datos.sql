INSERT INTO actor (nombre, apellido) VALUES
('Robert', 'Downey Jr.'),
('Chris', 'Evans'),
('Scarlett', 'Johansson'),
('Mark', 'Ruffalo'),
('Chris', 'Hemsworth'),
('Jeremy', 'Renner'),
('Tom', 'Holland'),
('Benedict', 'Cumberbatch'),
('Chadwick', 'Boseman'),
('Paul', 'Rudd');

INSERT INTO clasificacion (clasificacion) VALUES
('Acción'),
('Comedia'),
('Drama'),
('Terror'),
('Ciencia Ficción'),
('Fantasía'),
('Aventura'),
('Animación'),
('Documental'),
('Musical');

INSERT INTO idioma (idioma) VALUES
('English'),
('Spanish'),
('French'),
('German'),
('Italian'),
('Chinese'),
('Japanese'),
('Korean'),
('Russian'),
('Portuguese');

INSERT INTO actor_pelicula (id_actor, id_pelicula) VALUES
(1, 2),
(2, 2),
(3, 2),
(4, 5),
(5, 5),
(6, 8),
(7, 9),
(8, 10),
(9, 12),
(10, 13),
(1, 14),
(2, 15),
(3, 16),
(4, 9),
(5, 10),
(6, 12),
(7, 13),
(8, 14),
(9, 15),
(10, 16);

INSERT INTO clasificacion_pelicula (id_clasificacion, id_pelicula) VALUES
(19, 2),
(22, 5),
(18, 8),
(18, 9),
(18, 10),
(19, 12),
(24, 13),
(22, 14),
(18, 15),
(22, 16);

INSERT INTO idioma_pelicula (id_idioma, id_pelicula) VALUES
(5, 2),
(5, 5),
(5, 8),
(5, 9),
(5, 10),
(5, 12),
(5, 13),
(5, 14),
(5, 15),
(5, 16);
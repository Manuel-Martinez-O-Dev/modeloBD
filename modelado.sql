
-- creamos la base de datos para la plataforma de peliculas

CREATE DATABASE app_data;

-- TABLAS SIN CLAVES FORANEAS

-- primero crearemos las tablas que no tienen una clave foranea
-- para evitar problemas al crear la base de datos

-- una tabla para almacenar los datos de los usuarios

CREATE TABLE cliente (
  id_cliente SERIAL PRIMARY KEY,
  nombre VARCHAR(30) NOT NULL,
  apellido VARCHAR(30),
  nombre_usuario VARCHAR(250) UNIQUE NOT NULL,
  correo_electronico VARCHAR(250) UNIQUE NOT NULL,
  activo BOOLEAN NOT NULL,
  fecha_registro TIMESTAMP NOT NULL
);

-- una tabla para almacenar los datos de las peliculas

CREATE TABLE pelicula (
  id_pelicula SERIAL PRIMARY KEY,
  titulo VARCHAR(100) NOT NULL,
  descripcion TEXT,
  direccion_url TEXT UNIQUE NOT NULL,
  portada_url TEXT UNIQUE NOT NULL,
  duracion INT NOT NULL,
  ano_estreno INT NOT NULL,
  fecha_registro TIMESTAMP NOT NULL
);

-- una tabla para almacenar los datos de los actores que participaron 
-- en las peliculas

CREATE TABLE actor (
  id_actor SERIAL PRIMARY KEY,
  nombre VARCHAR(30) NOT NULL,
  apellido VARCHAR(30) NOT NULL
);

-- una tabla para almacenar las clasificacion que puede tener cada pelicula

CREATE TABLE clasificacion (
  id_clasificacion SERIAL PRIMARY KEY,
  clasificacion VARCHAR(30) UNIQUE NOT NULL
);

-- una tabla para almacenar los idiomas de las diferentes peliculas

CREATE TABLE idioma (
  id_idioma SERIAL PRIMARY KEY,
  idioma VARCHAR(30) UNIQUE NOT NULL
);

-- TABLAS QUE CUENTAN CON CLAVES FORANEAS

-- una tabla para almacenar las peliculas que vieron los clientes

CREATE TABLE cliente_pelicula (
  id_cliente INT,
  id_pelicula INT,
  FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
  ON UPDATE CASCADE
  ON DELETE CASCADE,
  FOREIGN KEY (id_pelicula) REFERENCES pelicula(id_pelicula)
  ON UPDATE CASCADE
  ON DELETE CASCADE
);

-- una tabla para almacenar las peliculas donde participo los actores

CREATE TABLE actor_pelicula (
  id_actor INT,
  id_pelicula INT,
  FOREIGN KEY (id_actor) REFERENCES actor(id_actor)
  ON UPDATE CASCADE
  ON DELETE CASCADE,
  FOREIGN KEY (id_pelicula) REFERENCES pelicula(id_pelicula)
  ON UPDATE CASCADE
  ON DELETE CASCADE
);

-- una tabla para almacenar las peliculas con sus clasificaciones

CREATE TABLE clasificacion_pelicula (
  id_clasificacion INT,
  id_pelicula INT,
  FOREIGN KEY (id_clasificacion) REFERENCES clasificacion(id_clasificacion)
  ON UPDATE CASCADE
  ON DELETE CASCADE,
  FOREIGN KEY (id_pelicula) REFERENCES pelicula(id_pelicula)
  ON UPDATE CASCADE
  ON DELETE CASCADE
);

-- una tabla para almacenar las peliculas que estan en diferentes idiomas

CREATE TABLE idioma_pelicula (
  id_idioma INT,
  id_pelicula INT,
  FOREIGN KEY (id_idioma) REFERENCES idioma(id_idioma)
  ON UPDATE CASCADE
  ON DELETE CASCADE,
  FOREIGN KEY (id_pelicula) REFERENCES pelicula(id_pelicula)
  ON UPDATE CASCADE
  ON DELETE CASCADE
);




















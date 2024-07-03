
CREATE OR REPLACE FUNCTION insertNewClient(
    p_nombre VARCHAR,
    p_apellido VARCHAR,
    p_nombre_usuario VARCHAR,
    p_correo_electronico VARCHAR,
    p_activo BOOLEAN,
    p_fecha_registro TIMESTAMP
) 
RETURNS VOID AS $$
BEGIN
    INSERT INTO cliente (nombre, apellido, nombre_usuario, correo_electronico, activo, fecha_registro) 
    VALUES (p_nombre, p_apellido, p_nombre_usuario, p_correo_electronico, p_activo, p_fecha_registro);

    EXECUTE format('CREATE USER %I WITH PASSWORD %L', p_nombre_usuario, p_correo_electronico);

    EXECUTE format('GRANT SELECT ON TABLE pelicula TO %I', p_nombre_usuario);
    EXECUTE format('GRANT SELECT ON TABLE idioma TO %I', p_nombre_usuario);
    EXECUTE format('GRANT SELECT ON TABLE actor TO %I', p_nombre_usuario);
    EXECUTE format('GRANT SELECT ON TABLE clasificacion TO %I', p_nombre_usuario);
    EXECUTE format('GRANT INSERT ON TABLE cliente_pelicula TO %I', p_nombre_usuario);
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION deleteClient(
    p_id_cliente INT,
    p_nombre_usuario VARCHAR
)
RETURNS VOID AS $$
BEGIN
    DELETE FROM cliente WHERE nombre_usuario = p_nombre_usuario;

    REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM p_nombre_usuario;

    -- Construir y ejecutar la instrucción para eliminar el usuario
    EXECUTE format('DROP USER %I', p_nombre_usuario);
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION deleteClientById(p_cliente_id INT)
RETURNS VOID AS $$
DECLARE
    v_nombre_usuario VARCHAR;
BEGIN
    SELECT nombre_usuario INTO v_nombre_usuario FROM cliente WHERE id_cliente = p_cliente_id;

    DELETE FROM cliente WHERE id_cliente = p_cliente_id;

    EXECUTE format('REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM %I', v_nombre_usuario);

    EXECUTE format('DROP USER %I', v_nombre_usuario);
END;
$$ LANGUAGE plpgsql;


CREATE ROLE admin 

CREATE ROLE admin WITH LOGIN PASSWORD 'admin@admin.che';
ALTER ROLE admin CREATEDB CREATEROLE;
ALTER ROLE admin WITH SUPERUSER;

REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM admin;




SELECT * FROM peliculaPorActor('Robert', 'Downey Jr.');

CREATE OR REPLACE FUNCTION peliculaPorActor(actor_nombre VARCHAR, actor_apellido VARCHAR)
RETURNS TABLE (
    id_pelicula INT,
    titulo VARCHAR(100),
    descripcion TEXT,
    direccion_url TEXT,
    portada_url TEXT,
    duracion INT,
    ano_estreno INT,
    fecha_registro TIMESTAMP
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        p.id_pelicula,
        p.titulo,
        p.descripcion,
        p.direccion_url,
        p.portada_url,
        p.duracion,
        p.ano_estreno,
        p.fecha_registro
    FROM 
        actor a
    JOIN 
        actor_pelicula ap ON a.id_actor = ap.id_actor
    JOIN 
        pelicula p ON ap.id_pelicula = p.id_pelicula
    WHERE 
        a.nombre = actor_nombre AND a.apellido = actor_apellido;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION peliculaPorIdioma(idioma_nombre VARCHAR)
RETURNS TABLE (
    id_pelicula INT,
    titulo VARCHAR(100),
    descripcion TEXT,
    direccion_url TEXT,
    portada_url TEXT,
    duracion INT,
    ano_estreno INT,
    fecha_registro TIMESTAMP
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        p.id_pelicula,
        p.titulo,
        p.descripcion,
        p.direccion_url,
        p.portada_url,
        p.duracion,
        p.ano_estreno,
        p.fecha_registro
    FROM 
        idioma i
    JOIN 
        idioma_pelicula ip ON i.id_idioma = ip.id_idioma
    JOIN 
        pelicula p ON ip.id_pelicula = p.id_pelicula
    WHERE 
        i.idioma = idioma_nombre;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION peliculaPorClasificacion(clasificacion_nombre VARCHAR)
RETURNS TABLE (
    id_pelicula INT,
    titulo VARCHAR(100),
    descripcion TEXT,
    direccion_url TEXT,
    portada_url TEXT,
    duracion INT,
    ano_estreno INT,
    fecha_registro TIMESTAMP
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        p.id_pelicula,
        p.titulo,
        p.descripcion,
        p.direccion_url,
        p.portada_url,
        p.duracion,
        p.ano_estreno,
        p.fecha_registro
    FROM 
        clasificacion c
    JOIN 
        clasificacion_pelicula cp ON c.id_clasificacion = cp.id_clasificacion
    JOIN 
        pelicula p ON cp.id_pelicula = p.id_pelicula
    WHERE 
        c.clasificacion = clasificacion_nombre;
END;
$$ LANGUAGE plpgsql;


SELECT * FROM peliculaPorActor('Robert', 'Downey Jr.');
SELECT * FROM peliculaPorIdioma('Spanish');
SELECT * FROM peliculaPorClasificacion('Terror');

CREATE OR REPLACE FUNCTION add_cliente_pelicula(
    p_id_cliente INT,
    p_id_pelicula INT
)
RETURNS VOID AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM cliente_pelicula
        WHERE id_cliente = p_id_cliente
        AND id_pelicula = p_id_pelicula
    ) THEN
        INSERT INTO cliente_pelicula (id_cliente, id_pelicula)
        VALUES (p_id_cliente, p_id_pelicula);
    END IF;
END;
$$ LANGUAGE plpgsql;

SELECT add_cliente_pelicula(1, 2);

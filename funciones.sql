

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
    INSERT INTO cliente (nombre, apellido, nombre_usuario, correo_electronico, activo, fecha_registro) VALUES (p_nombre, p_apellido, p_nombre_usuario, p_correo_electronico, p_activo, p_fecha_registro);

    CREATE USER p_nombre_usuario WITH PASSWORD 'p_correo_electronico';
    GRANT SELECT ON TABLE pelicula TO p_nombre_usuario;
END;
$$ LANGUAGE plpgsql;



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
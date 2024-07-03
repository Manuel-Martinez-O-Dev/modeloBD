CREATE TABLE seguimiento (
    s_id_pelicula INT,
    s_titulo VARCHAR(100),
    s_fecha_cambio TIMESTAMP
);

CREATE OR REPLACE FUNCTION f_seguimiento()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO seguimiento (s_id_pelicula, s_titulo, s_fecha_cambio) VALUES (OLD.id_pelicula, OLD.titulo, NOW());
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER t_seguimiento
BEFORE UPDATE ON pelicula
FOR EACH ROW
EXECUTE FUNCTION f_seguimiento();


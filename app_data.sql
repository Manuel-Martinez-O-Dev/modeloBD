--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: deleteclientbyid(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.deleteclientbyid(p_cliente_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_nombre_usuario VARCHAR;
BEGIN
    SELECT nombre_usuario INTO v_nombre_usuario FROM cliente WHERE id_cliente = p_cliente_id;


    DELETE FROM cliente WHERE id_cliente = p_cliente_id;

    EXECUTE format('REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM %I', v_nombre_usuario);

    EXECUTE format('DROP USER %I', v_nombre_usuario);
END;
$$;


ALTER FUNCTION public.deleteclientbyid(p_cliente_id integer) OWNER TO postgres;

--
-- Name: insertnewclient(character varying, character varying, character varying, character varying, boolean, timestamp without time zone); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.insertnewclient(p_nombre character varying, p_apellido character varying, p_nombre_usuario character varying, p_correo_electronico character varying, p_activo boolean, p_fecha_registro timestamp without time zone) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO cliente (nombre, apellido, nombre_usuario, correo_electronico, activo, fecha_registro) 
    VALUES (p_nombre, p_apellido, p_nombre_usuario, p_correo_electronico, p_activo, p_fecha_registro);

    EXECUTE format('CREATE USER %I WITH PASSWORD %L', p_nombre_usuario, p_correo_electronico);

    EXECUTE format('GRANT SELECT ON TABLE pelicula TO %I', p_nombre_usuario);
END;
$$;


ALTER FUNCTION public.insertnewclient(p_nombre character varying, p_apellido character varying, p_nombre_usuario character varying, p_correo_electronico character varying, p_activo boolean, p_fecha_registro timestamp without time zone) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: actor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.actor (
    id_actor integer NOT NULL,
    nombre character varying(30) NOT NULL,
    apellido character varying(30) NOT NULL
);


ALTER TABLE public.actor OWNER TO postgres;

--
-- Name: actor_id_actor_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.actor_id_actor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.actor_id_actor_seq OWNER TO postgres;

--
-- Name: actor_id_actor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.actor_id_actor_seq OWNED BY public.actor.id_actor;


--
-- Name: actor_pelicula; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.actor_pelicula (
    id_actor integer,
    id_pelicula integer
);


ALTER TABLE public.actor_pelicula OWNER TO postgres;

--
-- Name: clasificacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clasificacion (
    id_clasificacion integer NOT NULL,
    clasificacion character varying(30) NOT NULL
);


ALTER TABLE public.clasificacion OWNER TO postgres;

--
-- Name: clasificacion_id_clasificacion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.clasificacion_id_clasificacion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.clasificacion_id_clasificacion_seq OWNER TO postgres;

--
-- Name: clasificacion_id_clasificacion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.clasificacion_id_clasificacion_seq OWNED BY public.clasificacion.id_clasificacion;


--
-- Name: clasificacion_pelicula; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clasificacion_pelicula (
    id_clasificacion integer,
    id_pelicula integer
);


ALTER TABLE public.clasificacion_pelicula OWNER TO postgres;

--
-- Name: cliente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cliente (
    id_cliente integer NOT NULL,
    nombre character varying(30) NOT NULL,
    apellido character varying(30),
    nombre_usuario character varying(250) NOT NULL,
    correo_electronico character varying(250) NOT NULL,
    activo boolean NOT NULL,
    fecha_registro timestamp without time zone NOT NULL
);


ALTER TABLE public.cliente OWNER TO postgres;

--
-- Name: cliente_id_cliente_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cliente_id_cliente_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cliente_id_cliente_seq OWNER TO postgres;

--
-- Name: cliente_id_cliente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cliente_id_cliente_seq OWNED BY public.cliente.id_cliente;


--
-- Name: cliente_pelicula; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cliente_pelicula (
    id_cliente integer,
    id_pelicula integer
);


ALTER TABLE public.cliente_pelicula OWNER TO postgres;

--
-- Name: idioma; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.idioma (
    id_idioma integer NOT NULL,
    idioma character varying(30) NOT NULL
);


ALTER TABLE public.idioma OWNER TO postgres;

--
-- Name: idioma_id_idioma_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.idioma_id_idioma_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.idioma_id_idioma_seq OWNER TO postgres;

--
-- Name: idioma_id_idioma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.idioma_id_idioma_seq OWNED BY public.idioma.id_idioma;


--
-- Name: idioma_pelicula; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.idioma_pelicula (
    id_idioma integer,
    id_pelicula integer
);


ALTER TABLE public.idioma_pelicula OWNER TO postgres;

--
-- Name: pelicula; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pelicula (
    id_pelicula integer NOT NULL,
    titulo character varying(100) NOT NULL,
    descripcion text,
    direccion_url text NOT NULL,
    portada_url text NOT NULL,
    duracion integer NOT NULL,
    ano_estreno integer NOT NULL,
    fecha_registro timestamp without time zone NOT NULL
);


ALTER TABLE public.pelicula OWNER TO postgres;

--
-- Name: pelicula_id_pelicula_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pelicula_id_pelicula_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pelicula_id_pelicula_seq OWNER TO postgres;

--
-- Name: pelicula_id_pelicula_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pelicula_id_pelicula_seq OWNED BY public.pelicula.id_pelicula;


--
-- Name: actor id_actor; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actor ALTER COLUMN id_actor SET DEFAULT nextval('public.actor_id_actor_seq'::regclass);


--
-- Name: clasificacion id_clasificacion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clasificacion ALTER COLUMN id_clasificacion SET DEFAULT nextval('public.clasificacion_id_clasificacion_seq'::regclass);


--
-- Name: cliente id_cliente; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente ALTER COLUMN id_cliente SET DEFAULT nextval('public.cliente_id_cliente_seq'::regclass);


--
-- Name: idioma id_idioma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idioma ALTER COLUMN id_idioma SET DEFAULT nextval('public.idioma_id_idioma_seq'::regclass);


--
-- Name: pelicula id_pelicula; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pelicula ALTER COLUMN id_pelicula SET DEFAULT nextval('public.pelicula_id_pelicula_seq'::regclass);


--
-- Data for Name: actor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.actor (id_actor, nombre, apellido) FROM stdin;
\.


--
-- Data for Name: actor_pelicula; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.actor_pelicula (id_actor, id_pelicula) FROM stdin;
\.


--
-- Data for Name: clasificacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clasificacion (id_clasificacion, clasificacion) FROM stdin;
\.


--
-- Data for Name: clasificacion_pelicula; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clasificacion_pelicula (id_clasificacion, id_pelicula) FROM stdin;
\.


--
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cliente (id_cliente, nombre, apellido, nombre_usuario, correo_electronico, activo, fecha_registro) FROM stdin;
32	Admin del	Sistemas	admin	admin@admin.che	t	2024-07-02 18:58:52.55
34	Manuel	Martinez	manuel	manuel@gmail.com	t	2024-07-02 19:42:03.205
\.


--
-- Data for Name: cliente_pelicula; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cliente_pelicula (id_cliente, id_pelicula) FROM stdin;
\.


--
-- Data for Name: idioma; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.idioma (id_idioma, idioma) FROM stdin;
1	portuges
2	chino
3	japones
\.


--
-- Data for Name: idioma_pelicula; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.idioma_pelicula (id_idioma, id_pelicula) FROM stdin;
\.


--
-- Data for Name: pelicula; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pelicula (id_pelicula, titulo, descripcion, direccion_url, portada_url, duracion, ano_estreno, fecha_registro) FROM stdin;
5	moana 2	una pelicula mas de disne	https://www.youtube.com/watch?v=oG_lt31kFfc	https://lumiere-a.akamaihd.net/v1/images/garland_teaser1_poster_las_168c6658.jpeg	120	2022	2024-06-30 02:15:18.056
8	Tarot de la Muerte	Película de terror y suspenso.	https://www.youtube.com/watch?v=tLttLNQLq6o	https://www.sonypictures.com.mx/sites/mexico/files/2024-02/TAR_1400x2100.jpg	160	2021	2024-07-01 18:35:40.406
9	Nosferatus	Pelicula de terror	https://www.youtube.com/watch?v=jGcPEBRd2fE	https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfrVRY8sL-AqJFqHBIFU3kvCoZW2j0gKPHPw&s	130	2024	2024-07-01 18:37:25.541
10	Abigail	Pelicula de terror	https://www.youtube.com/watch?v=E8KysONydqc	https://es.web.img3.acsta.net/pictures/24/02/07/17/44/0885934.jpg	140	2024	2024-07-01 18:39:55.038
12	Respira	Pelicula de ciencia ficcion.	https://www.youtube.com/watch?v=YaVCb1YFwEg	https://es.web.img3.acsta.net/img/4c/54/4c5409569d34b91c122abff5845d1eea.jpg	120	2024	2024-07-01 19:34:01.855
13	Guason 2	El payaso	https://www.youtube.com/watch?v=rLbfdpdYh-U	https://hips.hearstapps.com/hmg-prod/images/joker-2-poster-660d1344c56e8.jpeg	180	2024	2024-07-01 20:22:49.089
14	Intensamente 2	Peli para toda la familia	https://www.youtube.com/watch?v=S087KG9XdgM	https://www.eldiario.net/portal/wp-content/uploads/2024/03/IntensaMente-2-de-Disney-y-Pixar-estrena-el-13-de-junio-solo-en-cines-2-scaled.jpg	160	2024	2024-07-01 20:32:28.112
2	venom 3	brutal pelicula de superheroes	https://www.youtube.com/watch?v=ncOH8-d4BYQ	https://m.media-amazon.com/images/M/MV5BYmIxMGNmOGYtMDQ4ZS00N2M0LWFiNWMtMWVlYjVkNzkzODc4XkEyXkFqcGc@._V1_.jpg	111	2020	2024-06-29 21:36:38.423
15	Demonios 1	Pelicula de terror	https://www.youtube.com/watch?v=V4JCJBAWdRM	https://i.pinimg.com/originals/39/fd/1a/39fd1a6fcb7ef90084891c5a86e1a8d4.jpg	128	1985	2024-07-02 19:46:13.55
16	Zootopia	Peli de disney	https://www.youtube.com/watch?v=8KNg1i4OG1o&list=PLz3WizklEOJepPbS4nLAla_15VYRU0Xk-&index=2	https://i.pinimg.com/originals/b7/b1/48/b7b1481a124a07babe533388d0521caa.jpg	120	2009	2024-07-02 19:50:10.942
\.


--
-- Name: actor_id_actor_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.actor_id_actor_seq', 1, false);


--
-- Name: clasificacion_id_clasificacion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clasificacion_id_clasificacion_seq', 14, true);


--
-- Name: cliente_id_cliente_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cliente_id_cliente_seq', 34, true);


--
-- Name: idioma_id_idioma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.idioma_id_idioma_seq', 3, true);


--
-- Name: pelicula_id_pelicula_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pelicula_id_pelicula_seq', 16, true);


--
-- Name: actor actor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actor
    ADD CONSTRAINT actor_pkey PRIMARY KEY (id_actor);


--
-- Name: clasificacion clasificacion_clasificacion_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clasificacion
    ADD CONSTRAINT clasificacion_clasificacion_key UNIQUE (clasificacion);


--
-- Name: clasificacion clasificacion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clasificacion
    ADD CONSTRAINT clasificacion_pkey PRIMARY KEY (id_clasificacion);


--
-- Name: cliente cliente_correo_electronico_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_correo_electronico_key UNIQUE (correo_electronico);


--
-- Name: cliente cliente_nombre_usuario_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_nombre_usuario_key UNIQUE (nombre_usuario);


--
-- Name: cliente cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (id_cliente);


--
-- Name: idioma idioma_idioma_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idioma
    ADD CONSTRAINT idioma_idioma_key UNIQUE (idioma);


--
-- Name: idioma idioma_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idioma
    ADD CONSTRAINT idioma_pkey PRIMARY KEY (id_idioma);


--
-- Name: pelicula pelicula_direccion_url_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pelicula
    ADD CONSTRAINT pelicula_direccion_url_key UNIQUE (direccion_url);


--
-- Name: pelicula pelicula_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pelicula
    ADD CONSTRAINT pelicula_pkey PRIMARY KEY (id_pelicula);


--
-- Name: pelicula pelicula_portada_url_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pelicula
    ADD CONSTRAINT pelicula_portada_url_key UNIQUE (portada_url);


--
-- Name: actor_pelicula actor_pelicula_id_actor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actor_pelicula
    ADD CONSTRAINT actor_pelicula_id_actor_fkey FOREIGN KEY (id_actor) REFERENCES public.actor(id_actor) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: actor_pelicula actor_pelicula_id_pelicula_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actor_pelicula
    ADD CONSTRAINT actor_pelicula_id_pelicula_fkey FOREIGN KEY (id_pelicula) REFERENCES public.pelicula(id_pelicula) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: clasificacion_pelicula clasificacion_pelicula_id_clasificacion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clasificacion_pelicula
    ADD CONSTRAINT clasificacion_pelicula_id_clasificacion_fkey FOREIGN KEY (id_clasificacion) REFERENCES public.clasificacion(id_clasificacion) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: clasificacion_pelicula clasificacion_pelicula_id_pelicula_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clasificacion_pelicula
    ADD CONSTRAINT clasificacion_pelicula_id_pelicula_fkey FOREIGN KEY (id_pelicula) REFERENCES public.pelicula(id_pelicula) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cliente_pelicula cliente_pelicula_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente_pelicula
    ADD CONSTRAINT cliente_pelicula_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES public.cliente(id_cliente) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cliente_pelicula cliente_pelicula_id_pelicula_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente_pelicula
    ADD CONSTRAINT cliente_pelicula_id_pelicula_fkey FOREIGN KEY (id_pelicula) REFERENCES public.pelicula(id_pelicula) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: idioma_pelicula idioma_pelicula_id_idioma_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idioma_pelicula
    ADD CONSTRAINT idioma_pelicula_id_idioma_fkey FOREIGN KEY (id_idioma) REFERENCES public.idioma(id_idioma) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: idioma_pelicula idioma_pelicula_id_pelicula_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idioma_pelicula
    ADD CONSTRAINT idioma_pelicula_id_pelicula_fkey FOREIGN KEY (id_pelicula) REFERENCES public.pelicula(id_pelicula) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: TABLE pelicula; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.pelicula TO manuel;


--
-- PostgreSQL database dump complete
--


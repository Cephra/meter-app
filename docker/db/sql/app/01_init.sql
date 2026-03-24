--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

-- Started on 2024-06-24 19:41:25 UTC

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
-- TOC entry 215 (class 1259 OID 16384)
-- Name: t_meter; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.t_meter (
    id integer NOT NULL,
    name text NOT NULL,
    meter_type_id integer
);


--
-- TOC entry 216 (class 1259 OID 16389)
-- Name: t_meter_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.t_meter_id_seq
AS integer
START WITH 1
INCREMENT BY 1
NO MINVALUE
NO MAXVALUE
CACHE 1;


--
-- TOC entry 3445 (class 0 OID 0)
-- Dependencies: 216
-- Name: t_meter_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.t_meter_id_seq OWNED BY public.t_meter.id;


--
-- TOC entry 217 (class 1259 OID 16390)
-- Name: t_meter_type; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.t_meter_type (
    id integer NOT NULL,
    name text NOT NULL,
    unit_id integer
);


--
-- TOC entry 218 (class 1259 OID 16395)
-- Name: t_meter_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.t_meter_type_id_seq
AS integer
START WITH 1
INCREMENT BY 1
NO MINVALUE
NO MAXVALUE
CACHE 1;


--
-- TOC entry 3446 (class 0 OID 0)
-- Dependencies: 218
-- Name: t_meter_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.t_meter_type_id_seq OWNED BY public.t_meter_type.id;


--
-- TOC entry 225 (class 1259 OID 16443)
-- Name: t_note; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.t_note (
    id integer NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    text text NOT NULL
);


--
-- TOC entry 226 (class 1259 OID 16448)
-- Name: t_note_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.t_note_id_seq
AS integer
START WITH 1
INCREMENT BY 1
NO MINVALUE
NO MAXVALUE
CACHE 1;


--
-- TOC entry 3447 (class 0 OID 0)
-- Dependencies: 226
-- Name: t_note_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.t_note_id_seq OWNED BY public.t_note.id;


--
-- TOC entry 219 (class 1259 OID 16396)
-- Name: t_unit; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.t_unit (
    suffix text NOT NULL,
    id integer NOT NULL,
    name text NOT NULL
);


--
-- TOC entry 220 (class 1259 OID 16401)
-- Name: t_unit_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.t_unit_id_seq
AS integer
START WITH 1
INCREMENT BY 1
NO MINVALUE
NO MAXVALUE
CACHE 1;


--
-- TOC entry 3448 (class 0 OID 0)
-- Dependencies: 220
-- Name: t_unit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.t_unit_id_seq OWNED BY public.t_unit.id;


--
-- TOC entry 221 (class 1259 OID 16402)
-- Name: t_value; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.t_value (
    id integer NOT NULL,
    value double precision NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    meter_id integer
);


--
-- TOC entry 222 (class 1259 OID 16405)
-- Name: t_value_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.t_value_id_seq
AS integer
START WITH 1
INCREMENT BY 1
NO MINVALUE
NO MAXVALUE
CACHE 1;


--
-- TOC entry 3449 (class 0 OID 0)
-- Dependencies: 222
-- Name: t_value_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.t_value_id_seq OWNED BY public.t_value.id;


--
-- TOC entry 3267 (class 2604 OID 16406)
-- Name: t_meter id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.t_meter ALTER COLUMN id SET DEFAULT nextval(
    'public.t_meter_id_seq'::regclass
);


--
-- TOC entry 3268 (class 2604 OID 16407)
-- Name: t_meter_type id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.t_meter_type ALTER COLUMN id SET DEFAULT nextval(
    'public.t_meter_type_id_seq'::regclass
);


--
-- TOC entry 3271 (class 2604 OID 16449)
-- Name: t_note id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.t_note ALTER COLUMN id SET DEFAULT nextval(
    'public.t_note_id_seq'::regclass
);


--
-- TOC entry 3269 (class 2604 OID 16408)
-- Name: t_unit id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.t_unit ALTER COLUMN id SET DEFAULT nextval(
    'public.t_unit_id_seq'::regclass
);


--
-- TOC entry 3270 (class 2604 OID 16409)
-- Name: t_value id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.t_value ALTER COLUMN id SET DEFAULT nextval(
    'public.t_value_id_seq'::regclass
);


--
-- TOC entry 3430 (class 0 OID 16384)
-- Dependencies: 215
-- Data for Name: t_meter; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.t_meter (id, name, meter_type_id) VALUES (1, 'gas', 1);
INSERT INTO public.t_meter (id, name, meter_type_id) VALUES (2, 'water', 4);
INSERT INTO public.t_meter (id, name, meter_type_id) VALUES (3, 'rainwater', 3);
INSERT INTO public.t_meter (id, name, meter_type_id) VALUES (
    4, 'electricity', 2
);
INSERT INTO public.t_meter (id, name, meter_type_id) VALUES (5, 'gas2', 1);
INSERT INTO public.t_meter (id, name, meter_type_id) VALUES (
    6, 'electricity2', 2
);
INSERT INTO public.t_meter (id, name, meter_type_id) VALUES (
    7, 'electricity3', 2
);
INSERT INTO public.t_meter (id, name, meter_type_id) VALUES (
    8, 'rainwater2', 3
);


--
-- TOC entry 3432 (class 0 OID 16390)
-- Dependencies: 217
-- Data for Name: t_meter_type; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.t_meter_type (id, name, unit_id) VALUES (1, 'gas', 1);
INSERT INTO public.t_meter_type (id, name, unit_id) VALUES (
    2, 'electricity', 2
);
INSERT INTO public.t_meter_type (id, name, unit_id) VALUES (3, 'rainwater', 1);
INSERT INTO public.t_meter_type (id, name, unit_id) VALUES (4, 'water', 1);


--
-- TOC entry 3434 (class 0 OID 16396)
-- Dependencies: 219
-- Data for Name: t_unit; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.t_unit (suffix, id, name) VALUES ('m³', 1, 'Kubikmeter');
INSERT INTO public.t_unit (suffix, id, name) VALUES (
    'kWh', 2, 'Kilowattstunden'
);


--
-- TOC entry 3450 (class 0 OID 0)
-- Dependencies: 216
-- Name: t_meter_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.t_meter_id_seq', 8, true);


--
-- TOC entry 3451 (class 0 OID 0)
-- Dependencies: 218
-- Name: t_meter_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.t_meter_type_id_seq', 4, true);


--
-- TOC entry 3452 (class 0 OID 0)
-- Dependencies: 226
-- Name: t_note_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.t_note_id_seq', 137, true);


--
-- TOC entry 3453 (class 0 OID 0)
-- Dependencies: 220
-- Name: t_unit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.t_unit_id_seq', 2, true);


--
-- TOC entry 3454 (class 0 OID 0)
-- Dependencies: 222
-- Name: t_value_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.t_value_id_seq', 3969, true);


--
-- TOC entry 3273 (class 2606 OID 16411)
-- Name: t_meter t_meter_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.t_meter
ADD CONSTRAINT t_meter_pkey PRIMARY KEY (id);


--
-- TOC entry 3275 (class 2606 OID 16413)
-- Name: t_meter_type t_meter_type_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.t_meter_type
ADD CONSTRAINT t_meter_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3281 (class 2606 OID 16451)
-- Name: t_note t_note_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.t_note
ADD CONSTRAINT t_note_pkey PRIMARY KEY (id);


--
-- TOC entry 3277 (class 2606 OID 16415)
-- Name: t_unit t_unit_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.t_unit
ADD CONSTRAINT t_unit_pkey PRIMARY KEY (id);


--
-- TOC entry 3279 (class 2606 OID 16417)
-- Name: t_value t_value_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.t_value
ADD CONSTRAINT t_value_pkey PRIMARY KEY (id);


--
-- TOC entry 3282 (class 2606 OID 16418)
-- Name: t_meter fk_t_meter_meter_type_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.t_meter
ADD CONSTRAINT fk_t_meter_meter_type_id FOREIGN KEY (
    meter_type_id
) REFERENCES public.t_meter_type (id) ON UPDATE SET NULL ON DELETE CASCADE;


--
-- TOC entry 3283 (class 2606 OID 16423)
-- Name: t_meter_type fk_t_meter_type_unit_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.t_meter_type
ADD CONSTRAINT fk_t_meter_type_unit_id FOREIGN KEY (
    unit_id
) REFERENCES public.t_unit (id) ON UPDATE SET NULL ON DELETE CASCADE;


--
-- TOC entry 3284 (class 2606 OID 16428)
-- Name: t_value fk_t_value_meter_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.t_value
ADD CONSTRAINT fk_t_value_meter_id FOREIGN KEY (
    meter_id
) REFERENCES public.t_meter (id) ON UPDATE SET NULL ON DELETE CASCADE;


-- Completed on 2024-06-24 19:41:25 UTC

--
-- PostgreSQL database dump complete
--

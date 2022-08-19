--
-- PostgreSQL database dump
--

-- Dumped from database version 14.5
-- Dumped by pg_dump version 14.5

-- Started on 2022-09-11 00:46:17 UTC

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

SET default_table_access_method = heap;

--
-- TOC entry 209 (class 1259 OID 16385)
-- Name: t_meter; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.t_meter (
    id integer NOT NULL,
    name text NOT NULL,
    meter_type_id integer
);


--
-- TOC entry 210 (class 1259 OID 16390)
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
-- TOC entry 3361 (class 0 OID 0)
-- Dependencies: 210
-- Name: t_meter_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.t_meter_id_seq OWNED BY public.t_meter.id;


--
-- TOC entry 216 (class 1259 OID 16433)
-- Name: t_meter_type; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.t_meter_type (
    id integer NOT NULL,
    name text NOT NULL,
    unit_id integer
);


--
-- TOC entry 215 (class 1259 OID 16432)
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
-- TOC entry 3362 (class 0 OID 0)
-- Dependencies: 215
-- Name: t_meter_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.t_meter_type_id_seq OWNED BY public.t_meter_type.id;


--
-- TOC entry 211 (class 1259 OID 16391)
-- Name: t_unit; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.t_unit (
    suffix text NOT NULL,
    id integer NOT NULL,
    name text NOT NULL
);


--
-- TOC entry 212 (class 1259 OID 16396)
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
-- TOC entry 3363 (class 0 OID 0)
-- Dependencies: 212
-- Name: t_unit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.t_unit_id_seq OWNED BY public.t_unit.id;


--
-- TOC entry 213 (class 1259 OID 16397)
-- Name: t_value; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.t_value (
    id integer NOT NULL,
    value double precision NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    meter_id integer
);


--
-- TOC entry 214 (class 1259 OID 16400)
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
-- TOC entry 3364 (class 0 OID 0)
-- Dependencies: 214
-- Name: t_value_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.t_value_id_seq OWNED BY public.t_value.id;


--
-- TOC entry 3194 (class 2604 OID 16401)
-- Name: t_meter id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.t_meter ALTER COLUMN id SET DEFAULT nextval('public.t_meter_id_seq'::regclass);


--
-- TOC entry 3197 (class 2604 OID 16436)
-- Name: t_meter_type id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.t_meter_type ALTER COLUMN id SET DEFAULT nextval('public.t_meter_type_id_seq'::regclass);


--
-- TOC entry 3195 (class 2604 OID 16402)
-- Name: t_unit id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.t_unit ALTER COLUMN id SET DEFAULT nextval('public.t_unit_id_seq'::regclass);


--
-- TOC entry 3196 (class 2604 OID 16403)
-- Name: t_value id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.t_value ALTER COLUMN id SET DEFAULT nextval('public.t_value_id_seq'::regclass);

--
-- TOC entry 3352 (class 0 OID 16397)
-- Dependencies: 213
-- Data for Name: t_value; Type: TABLE DATA; Schema: public; Owner: -
--

--
-- TOC entry 3199 (class 2606 OID 16405)
-- Name: t_meter t_meter_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.t_meter
    ADD CONSTRAINT t_meter_pkey PRIMARY KEY (id);


--
-- TOC entry 3205 (class 2606 OID 16440)
-- Name: t_meter_type t_meter_type_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.t_meter_type
    ADD CONSTRAINT t_meter_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3201 (class 2606 OID 16407)
-- Name: t_unit t_unit_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.t_unit
    ADD CONSTRAINT t_unit_pkey PRIMARY KEY (id);


--
-- TOC entry 3203 (class 2606 OID 16409)
-- Name: t_value t_value_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.t_value
    ADD CONSTRAINT t_value_pkey PRIMARY KEY (id);


--
-- TOC entry 3206 (class 2606 OID 16461)
-- Name: t_meter fk_t_meter_meter_type_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.t_meter
    ADD CONSTRAINT fk_t_meter_meter_type_id FOREIGN KEY (meter_type_id) REFERENCES public.t_meter_type(id) ON UPDATE SET NULL ON DELETE CASCADE;


--
-- TOC entry 3208 (class 2606 OID 16456)
-- Name: t_meter_type fk_t_meter_type_unit_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.t_meter_type
    ADD CONSTRAINT fk_t_meter_type_unit_id FOREIGN KEY (unit_id) REFERENCES public.t_unit(id) ON UPDATE SET NULL ON DELETE CASCADE;


--
-- TOC entry 3207 (class 2606 OID 16466)
-- Name: t_value fk_t_value_meter_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.t_value
    ADD CONSTRAINT fk_t_value_meter_id FOREIGN KEY (meter_id) REFERENCES public.t_meter(id) ON UPDATE SET NULL ON DELETE CASCADE;


-- Completed on 2022-09-11 00:46:17 UTC

--
-- PostgreSQL database dump complete
--


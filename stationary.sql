--
-- PostgreSQL database dump
--

-- Dumped from database version 12.4 (Ubuntu 12.4-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.4 (Ubuntu 12.4-0ubuntu0.20.04.1)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: busses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.busses (
    id bigint NOT NULL,
    bus_name character varying(50),
    bus_photo character varying(255),
    station_id bigint
);


ALTER TABLE public.busses OWNER TO postgres;

--
-- Name: busses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.busses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.busses_id_seq OWNER TO postgres;

--
-- Name: busses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.busses_id_seq OWNED BY public.busses.id;


--
-- Name: schedules; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schedules (
    id bigint NOT NULL,
    departure_time date,
    arrival_time date,
    destination character varying(50),
    estimated character varying(255)
);


ALTER TABLE public.schedules OWNER TO postgres;

--
-- Name: schedules_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.schedules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.schedules_id_seq OWNER TO postgres;

--
-- Name: schedules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.schedules_id_seq OWNED BY public.schedules.id;


--
-- Name: stations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stations (
    id bigint NOT NULL,
    station_name character varying(50),
    schedule_id bigint
);


ALTER TABLE public.stations OWNER TO postgres;

--
-- Name: stations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.stations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stations_id_seq OWNER TO postgres;

--
-- Name: stations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.stations_id_seq OWNED BY public.stations.id;


--
-- Name: busses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.busses ALTER COLUMN id SET DEFAULT nextval('public.busses_id_seq'::regclass);


--
-- Name: schedules id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedules ALTER COLUMN id SET DEFAULT nextval('public.schedules_id_seq'::regclass);


--
-- Name: stations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stations ALTER COLUMN id SET DEFAULT nextval('public.stations_id_seq'::regclass);


--
-- Data for Name: busses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.busses (id, bus_name, bus_photo, station_id) FROM stdin;
5	Lorena	uploads/bus_photo-1601936461185.jpeg	9
6	Scania	uploads/bus_photo-1601936605897.jpg	10
7	Big Bird	uploads/bus_photo-1601936809691.jpg	11
4	Damri 2	uploads/bus_photo-1601936254839.jpeg	8
\.


--
-- Data for Name: schedules; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schedules (id, departure_time, arrival_time, destination, estimated) FROM stdin;
3	2020-10-07	2020-10-15	Terminal Langsa	\N
4	2020-10-10	2020-10-17	Terminal Batoh	\N
5	2020-10-08	2020-10-13	Terminal Tanjung Pinggir	\N
6	2020-10-09	2020-10-15	Terminal Tanjung Dumai	\N
7	2020-10-21	2020-11-01	Terminal Gerbangsari	\N
17	2020-10-21	2020-11-01	Terminal Batu Kuning	11 days
18	2020-11-02	2020-11-06	Terminal Puuwatu	4 days
19	2020-11-06	2020-11-12	Terminal Kayuagung	6 days
20	2020-11-08	2020-11-12	Terminal Kayuagung	4 days
\.


--
-- Data for Name: stations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stations (id, station_name, schedule_id) FROM stdin;
3	Terminal Alam Barajo	3
4	Terminal Muaro Bungo	4
5	Terminal Alang-Alang Lebar	5
6	Terminal Karya Jaya	6
7	Terminal Simpang Priuk	7
8	Terminal Entrop	17
9	Terminal Takalar	18
10	Terminal Karya Jaya	19
11	Terminal Alang-Alang Lebar	20
\.


--
-- Name: busses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.busses_id_seq', 7, true);


--
-- Name: schedules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.schedules_id_seq', 20, true);


--
-- Name: stations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stations_id_seq', 11, true);


--
-- Name: busses busses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.busses
    ADD CONSTRAINT busses_pkey PRIMARY KEY (id);


--
-- Name: schedules schedules_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedules
    ADD CONSTRAINT schedules_pkey PRIMARY KEY (id);


--
-- Name: stations stations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stations
    ADD CONSTRAINT stations_pkey PRIMARY KEY (id);


--
-- Name: stations stations_schedule_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stations
    ADD CONSTRAINT stations_schedule_id_key UNIQUE (schedule_id);


--
-- Name: busses busses_station_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.busses
    ADD CONSTRAINT busses_station_id_fkey FOREIGN KEY (station_id) REFERENCES public.stations(id);


--
-- Name: stations stations_schedule_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stations
    ADD CONSTRAINT stations_schedule_id_fkey FOREIGN KEY (schedule_id) REFERENCES public.schedules(id);


--
-- PostgreSQL database dump complete
--


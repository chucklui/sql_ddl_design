--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1
-- Dumped by pg_dump version 14.1

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

ALTER TABLE ONLY public.planets DROP CONSTRAINT planets_orbits_around_star_fkey;
ALTER TABLE ONLY public.moons DROP CONSTRAINT moons_orbiting_planet_id_fkey;
ALTER TABLE ONLY public.stars DROP CONSTRAINT stars_pkey;
ALTER TABLE ONLY public.planets DROP CONSTRAINT planets_planet_name_orbits_around_star_key;
ALTER TABLE ONLY public.planets DROP CONSTRAINT planets_pkey;
ALTER TABLE ONLY public.moons DROP CONSTRAINT moons_pkey;
ALTER TABLE ONLY public.moons DROP CONSTRAINT moons_moon_name_orbiting_planet_id_key;
ALTER TABLE public.stars ALTER COLUMN star_id DROP DEFAULT;
ALTER TABLE public.planets ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.moons ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE public.stars_star_id_seq;
DROP TABLE public.stars;
DROP SEQUENCE public.planets_id_seq;
DROP TABLE public.planets;
DROP SEQUENCE public.moons_id_seq;
DROP TABLE public.moons;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: moons; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.moons (
    id integer NOT NULL,
    moon_name character varying(20) NOT NULL,
    orbiting_planet_id integer NOT NULL
);


--
-- Name: moons_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.moons_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: moons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.moons_id_seq OWNED BY public.moons.id;


--
-- Name: planets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.planets (
    id integer NOT NULL,
    planet_name character varying(20) NOT NULL,
    orbital_period_yrs double precision NOT NULL,
    orbits_around_star integer NOT NULL
);


--
-- Name: planets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.planets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: planets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.planets_id_seq OWNED BY public.planets.id;


--
-- Name: stars; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stars (
    star_id integer NOT NULL,
    star_name character varying(20),
    star_temp_kelvin integer
);


--
-- Name: stars_star_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.stars_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stars_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.stars_star_id_seq OWNED BY public.stars.star_id;


--
-- Name: moons id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.moons ALTER COLUMN id SET DEFAULT nextval('public.moons_id_seq'::regclass);


--
-- Name: planets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.planets ALTER COLUMN id SET DEFAULT nextval('public.planets_id_seq'::regclass);


--
-- Name: stars star_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stars ALTER COLUMN star_id SET DEFAULT nextval('public.stars_star_id_seq'::regclass);


--
-- Data for Name: moons; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.moons (id, moon_name, orbiting_planet_id) FROM stdin;
1	The Moon	1
2	Phobos	2
3	Deimos	2
\.


--
-- Data for Name: planets; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.planets (id, planet_name, orbital_period_yrs, orbits_around_star) FROM stdin;
1	Earth	1	1
2	Mars	1.882	1
3	Venus	0.62	1
4	Proxima Centauri b	0.03	2
5	Gliese 876 b	0.236	3
\.


--
-- Data for Name: stars; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.stars (star_id, star_name, star_temp_kelvin) FROM stdin;
1	The Sun	5800
2	Proxima Centauri	3042
3	Gliese 876	3192
\.


--
-- Name: moons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.moons_id_seq', 3, true);


--
-- Name: planets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.planets_id_seq', 5, true);


--
-- Name: stars_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.stars_star_id_seq', 3, true);


--
-- Name: moons moons_moon_name_orbiting_planet_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.moons
    ADD CONSTRAINT moons_moon_name_orbiting_planet_id_key UNIQUE (moon_name, orbiting_planet_id);


--
-- Name: moons moons_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.moons
    ADD CONSTRAINT moons_pkey PRIMARY KEY (id);


--
-- Name: planets planets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.planets
    ADD CONSTRAINT planets_pkey PRIMARY KEY (id);


--
-- Name: planets planets_planet_name_orbits_around_star_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.planets
    ADD CONSTRAINT planets_planet_name_orbits_around_star_key UNIQUE (planet_name, orbits_around_star);


--
-- Name: stars stars_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stars
    ADD CONSTRAINT stars_pkey PRIMARY KEY (star_id);


--
-- Name: moons moons_orbiting_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.moons
    ADD CONSTRAINT moons_orbiting_planet_id_fkey FOREIGN KEY (orbiting_planet_id) REFERENCES public.planets(id);


--
-- Name: planets planets_orbits_around_star_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.planets
    ADD CONSTRAINT planets_orbits_around_star_fkey FOREIGN KEY (orbits_around_star) REFERENCES public.stars(star_id);


--
-- PostgreSQL database dump complete
--


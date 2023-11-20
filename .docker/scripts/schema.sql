--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE haalcentraal;
ALTER ROLE haalcentraal WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION NOBYPASSRLS;
-- CREATE ROLE root;
ALTER ROLE root WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'md5b4b8daf4b8ea9d39568719e1e320076f';






\connect template1

--
-- PostgreSQL database dump
--

-- Dumped from database version 11.21
-- Dumped by pg_dump version 11.21

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
-- PostgreSQL database dump complete
--

\connect postgres

--
-- PostgreSQL database dump
--

-- Dumped from database version 11.21
-- Dumped by pg_dump version 11.21

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
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 11.21
-- Dumped by pg_dump version 11.21

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
-- Name: root; Type: DATABASE; Schema: -; Owner: root
--

-- CREATE DATABASE root WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE root OWNER TO root;

\connect root

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
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 11.21
-- Dumped by pg_dump version 11.21

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
-- Name: rvig_haalcentraal_testdata; Type: DATABASE; Schema: -; Owner: haalcentraal
--

CREATE DATABASE rvig_haalcentraal_testdata WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE rvig_haalcentraal_testdata OWNER TO haalcentraal;

\connect rvig_haalcentraal_testdata

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
-- Name: vospg; Type: SCHEMA; Schema: -; Owner: haalcentraal
--

CREATE SCHEMA vospg;


ALTER SCHEMA vospg OWNER TO haalcentraal;

--
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


--
-- Name: contains_special_characters(character varying); Type: FUNCTION; Schema: public; Owner: haalcentraal
--

CREATE FUNCTION public.contains_special_characters(character varying) RETURNS boolean
    LANGUAGE sql
    AS $_$
-- Implementation: replace special characters by an inverted exclamation mark and
--   return true if the translation result contains any of those marks.
select position(E'\xc2\xa1' in translate(
$1,-- search original string

E'\xc2\xa1' ||-- inverted exclamation mark
E'\xc2\xa2' ||-- cent sign
E'\xc2\xa3' ||-- pound sign
E'\xc2\xa5' ||-- yen sign
E'\xc2\xa4' ||-- currency sign
E'\xc2\xab' ||-- angle quotation mark left
E'\xc2\xb0' ||-- degree sign
E'\xc2\xb1' ||-- plus minus sign
E'\xc2\xb2' ||-- superscript 2
E'\xc2\xb3' ||-- superscript 3
E'\xc3\x97' ||-- multiply sign
E'\xc2\xb7' ||-- middle dot
E'\xc3\xb7' ||-- divide sign
E'\xc2\xbb' ||-- angle quotation mark right
E'\xc2\xbc' ||-- fraction one quarter
E'\xc2\xbd' ||-- fraction one half
E'\xc2\xbe' ||-- fraction three quarter
E'\xc2\xbf' ||-- inverted question mark
E'\xe2\x84\xa6' ||-- Ohm sign
E'\xc3\x86' ||-- capital AE diphtong
E'\xc4\x90' ||-- capital D with stroke
E'\xc2\xaa' ||-- ordinal indicator feminine
E'\xc4\xa6' ||-- capital H with stroke
E'\xc4\xbf' ||-- capital L with middle dot
E'\xc5\x81' ||-- capital L with stroke
E'\xc3\x98' ||-- capital O with slash
E'\xc5\x92' ||-- capital OE ligature
E'\xc2\xba' ||-- ordinal indicator masculine
E'\xc3\x9e' ||-- capital thorn, icelandic
E'\xc5\xa6' ||-- capital T with stroke
E'\xc5\x8a' ||-- capital eng, lapp
E'\xc5\x89' ||-- small n with apostrophe
E'\xc4\xb8' ||-- small k, greenlandic
E'\xc3\xa6' ||-- small ae diphtong
E'\xc4\x91' ||-- small d with stroke
E'\xc3\xb0' ||-- small eth, icelandic
E'\xc4\xa7' ||-- small h with stroke
E'\xc4\xb1' ||-- small i without dot
E'\xc5\x80' ||-- small l with middle dot
E'\xc5\x82' ||-- small l with stroke
E'\xc3\xb8' ||-- small o with slash
E'\xc5\x93' ||-- small oe ligature
E'\xc3\x9f' ||-- small sharp s, german
E'\xc3\xbe' ||-- small thorn, icelandic
E'\xc5\xa7' ||-- small t with stroke
E'\xc5\x8b',-- small eng, lapp
E'\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1\xc2\xa1')) > 0
$_$;


ALTER FUNCTION public.contains_special_characters(character varying) OWNER TO haalcentraal;

--
-- Name: convert_special_characters_to_slim(character varying); Type: FUNCTION; Schema: public; Owner: haalcentraal
--

CREATE FUNCTION public.convert_special_characters_to_slim(character varying) RETURNS character varying
    LANGUAGE sql
    AS $_$
select replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(translate(

-- convert the contents of the input string
$1,

-- from these special characters
E'\xc2\xa1' ||-- inverted exclamation mark
E'\xc2\xa2' ||-- cent sign
E'\xc2\xa3' ||-- pound sign
E'\xc2\xa5' ||-- yen sign
E'\xc2\xa4' ||-- currency sign
E'\xc2\xb0' ||-- degree sign
E'\xc2\xb2' ||-- superscript 2
E'\xc2\xb3' ||-- superscript 3
E'\xc3\x97' ||-- multiply sign
E'\xc2\xb7' ||-- middle dot
E'\xc3\xb7' ||-- divide sign
E'\xc2\xbf' ||-- inverted question mark
E'\xc4\x90' ||-- capital D with stroke
E'\xc2\xaa' ||-- ordinal indicator feminine
E'\xc4\xa6' ||-- capital H with stroke
E'\xc5\x81' ||-- capital L with stroke
E'\xc3\x98' ||-- capital O with slash
E'\xc2\xba' ||-- ordinal indicator masculine
E'\xc5\xa6' ||-- capital T with stroke
E'\xc4\xb8' ||-- small k, greenlandic
E'\xc4\x91' ||-- small d with stroke
E'\xc3\xb0' ||-- small eth, icelandic
E'\xc4\xa7' ||-- small h with stroke
E'\xc4\xb1' ||-- small i without dot
E'\xc5\x82' ||-- small l with stroke
E'\xc3\xb8' ||-- small o with slash
E'\xc5\xa7',-- small t with stroke

-- to a single ASCII-compatible character
'!' ||-- inverted exclamation mark
'c' ||-- cent sign
'L' ||-- pound sign
'Y' ||-- yen sign
'*' ||-- currency sign
'o' ||-- degree sign
'2' ||-- superscript 2
'3' ||-- superscript 3
'x' ||-- multiply sign
'.' ||-- middle dot
':' ||-- divide sign
'?' ||-- inverted question mark
'D' ||-- capital D with stroke
'a' ||-- ordinal indicator feminine
'H' ||-- capital H with stroke
'L' ||-- capital L with stroke
'O' ||-- capital O with slash
'o' ||-- ordinal indicator masculine
'T' ||-- capital T with stroke
'q' ||-- small k, greenlandic
'd' ||-- small d with stroke
'd' ||-- small eth, icelandic
'h' ||-- small h with stroke
'i' ||-- small i without dot
'l' ||-- small l with stroke
'o' ||-- small o with slash
't'),-- small t with stroke

-- and from the other special characters to more than one ASCII-compatible character
E'\xc2\xab', '<<'),-- angle quotation mark left
E'\xc2\xb1', '+/-'),-- plus minus sign
E'\xc2\xbb', '>>'),-- angle quotation mark right
E'\xc2\xbc', '1/4'),-- fraction one quarter
E'\xc2\xbd', '1/2'),-- fraction one half
E'\xc2\xbe', '3/4'),-- fraction three quarter
E'\xe2\x84\xa6', 'Ohm'),-- Ohm sign
E'\xc3\x86', 'AE'),-- capital AE diphtong
E'\xc4\xbf', 'L.'),-- capital L with middle dot
E'\xc5\x92', 'OE'),-- capital OE ligature
E'\xc3\x9e', 'TH'),-- capital thorn, icelandic
E'\xc5\x8a', 'NG'),-- capital eng, lapp
E'\xc5\x89', '''n'),-- small n with apostrophe
E'\xc3\xa6', 'ae'),-- small ae diphtong
E'\xc5\x80', 'l.'),-- small l with middle dot
E'\xc5\x93', 'oe'),-- small oe ligature
E'\xc3\x9f', 'ss'),-- small sharp s, german
E'\xc3\xbe', 'th'),-- small thorn, icelandic
E'\xc5\x8b', 'ng')-- small eng, lapp
$_$;


ALTER FUNCTION public.convert_special_characters_to_slim(character varying) OWNER TO haalcentraal;

--
-- Name: plpgsql_call_handler(); Type: FUNCTION; Schema: public; Owner: haalcentraal
--

CREATE FUNCTION public.plpgsql_call_handler() RETURNS language_handler
    LANGUAGE c
    AS '$libdir/plpgsql', 'plpgsql_call_handler';


ALTER FUNCTION public.plpgsql_call_handler() OWNER TO haalcentraal;

--
-- Name: plpgsql_validator(oid); Type: FUNCTION; Schema: public; Owner: haalcentraal
--

CREATE FUNCTION public.plpgsql_validator(oid) RETURNS void
    LANGUAGE c
    AS '$libdir/plpgsql', 'plpgsql_validator';


ALTER FUNCTION public.plpgsql_validator(oid) OWNER TO haalcentraal;

--
-- Name: activiteit_id_sequence; Type: SEQUENCE; Schema: public; Owner: haalcentraal
--

CREATE SEQUENCE public.activiteit_id_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.activiteit_id_sequence OWNER TO haalcentraal;

SET default_tablespace = '';

SET default_with_oids = true;

--
-- Name: activiteit_small; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.activiteit_small (
    activiteit_id bigint NOT NULL,
    activiteit_type integer NOT NULL,
    activiteit_subtype integer NOT NULL,
    moeder_id bigint,
    toestand integer NOT NULL,
    start_dt timestamp without time zone DEFAULT now() NOT NULL,
    laatste_actie_dt timestamp without time zone,
    uiterlijke_actie_dt timestamp without time zone NOT NULL,
    pl_id bigint,
    communicatie_partner character varying(40),
    nr_1 bigint,
    nr_2 bigint,
    nr_3 bigint,
    nr_4 bigint,
    nr_5 bigint,
    tekst_1 character varying(40),
    tekst_2 character varying(40),
    tekst_3 character varying(40),
    tekst_4 character varying(40),
    tekst_5 character varying(40),
    trace_level character(1),
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.activiteit_small OWNER TO haalcentraal;

--
-- Name: adres_id_sequence; Type: SEQUENCE; Schema: public; Owner: haalcentraal
--

CREATE SEQUENCE public.adres_id_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.adres_id_sequence OWNER TO haalcentraal;

SET default_with_oids = false;

--
-- Name: afnemer; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.afnemer (
    afnemer_id bigint NOT NULL,
    afnemer_code integer NOT NULL,
    geschatte_omvang integer DEFAULT 0 NOT NULL,
    leverwijze integer DEFAULT 0 NOT NULL,
    max_berichten integer DEFAULT 0 NOT NULL,
    berichtsoort integer,
    selectiesoort integer DEFAULT 0 NOT NULL,
    bestands_formaat integer,
    oin character varying(20)
);


ALTER TABLE public.afnemer OWNER TO haalcentraal;

--
-- Name: afnemer_id_sequence; Type: SEQUENCE; Schema: public; Owner: haalcentraal
--

CREATE SEQUENCE public.afnemer_id_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.afnemer_id_sequence OWNER TO haalcentraal;

SET default_with_oids = true;

--
-- Name: gebeurtenis_data; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.gebeurtenis_data (
    gebeurtenis_data_id bigint NOT NULL,
    gebeurtenis_data_type integer NOT NULL,
    gebeurtenis_data text,
    gebeurtenis_nr_1 bigint,
    gebeurtenis_nr_2 bigint,
    gebeurtenis_id bigint NOT NULL,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.gebeurtenis_data OWNER TO haalcentraal;

--
-- Name: gebeurtenis_data_id_sequence; Type: SEQUENCE; Schema: public; Owner: haalcentraal
--

CREATE SEQUENCE public.gebeurtenis_data_id_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gebeurtenis_data_id_sequence OWNER TO haalcentraal;

--
-- Name: gebeurtenis_id_sequence; Type: SEQUENCE; Schema: public; Owner: haalcentraal
--

CREATE SEQUENCE public.gebeurtenis_id_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gebeurtenis_id_sequence OWNER TO haalcentraal;

--
-- Name: gebeurtenis_small; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.gebeurtenis_small (
    gebeurtenis_id bigint NOT NULL,
    gebeurtenis_type integer NOT NULL,
    gebeurtenis_dt timestamp without time zone DEFAULT now() NOT NULL,
    gebeurtenis_oms text,
    activiteit_id bigint NOT NULL,
    activiteit_nieuwe_toestand integer,
    creatie_door character varying(40),
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL,
    gebeurtenis_hash bigint
);


ALTER TABLE public.gebeurtenis_small OWNER TO haalcentraal;

SET default_with_oids = false;

--
-- Name: haalcentraal_vraag; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.haalcentraal_vraag (
    request_id character varying(36) NOT NULL,
    request_datum timestamp without time zone DEFAULT now() NOT NULL,
    afnemer_code integer NOT NULL,
    pl_id bigint NOT NULL,
    request_zoek_rubrieken text,
    request_gevraagde_rubrieken text,
    verwerkt boolean DEFAULT false
);


ALTER TABLE public.haalcentraal_vraag OWNER TO root;

--
-- Name: herindeling; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.herindeling (
    herindeling_id bigint NOT NULL,
    nieuwe_gemeente_code character varying(4) NOT NULL,
    oude_gemeente_codes character varying(400),
    herindeling_datum integer NOT NULL,
    volg_nr integer NOT NULL,
    verstrekking_start_datum integer NOT NULL,
    verstrekking_eind_datum integer NOT NULL,
    afnemers_am_verstrekkingen text,
    afnemers_niet_verstrekkingen text,
    toelichting text,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT herindeling_check CHECK (((herindeling_datum >= verstrekking_start_datum) AND (herindeling_datum <= verstrekking_eind_datum))),
    CONSTRAINT herindeling_check1 CHECK ((verstrekking_eind_datum >= verstrekking_start_datum)),
    CONSTRAINT herindeling_nieuwe_gemeente_code_check CHECK ((length((nieuwe_gemeente_code)::text) = 4)),
    CONSTRAINT herindeling_verstrekking_start_datum_check CHECK ((verstrekking_start_datum >= 20121101)),
    CONSTRAINT herindeling_volg_nr_check CHECK (((volg_nr >= 1) AND (volg_nr <= 25)))
);


ALTER TABLE public.herindeling OWNER TO haalcentraal;

SET default_with_oids = true;

--
-- Name: lo3_adres; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_adres (
    adres_id bigint NOT NULL,
    gemeente_code smallint NOT NULL,
    gemeente_deel character varying(24),
    straat_naam character varying(24),
    diak_straat_naam character varying(24),
    huis_nr integer,
    huis_letter character(1),
    huis_nr_toevoeging character varying(4),
    huis_nr_aand character varying(2),
    postcode character varying(6),
    locatie_beschrijving character varying(35),
    diak_locatie_beschrijving character varying(35),
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL,
    open_ruimte_naam character varying(80),
    diak_open_ruimte_naam character varying(80),
    woon_plaats_naam character varying(80),
    diak_woon_plaats_naam character varying(80),
    verblijf_plaats_ident_code character varying(16),
    nummer_aand_ident_code character varying(16)
);


ALTER TABLE public.lo3_adres OWNER TO haalcentraal;

--
-- Name: lo3_adres_afnemer_ind; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_adres_afnemer_ind (
    adres_id bigint NOT NULL,
    afnemer_code integer NOT NULL,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_adres_afnemer_ind OWNER TO haalcentraal;

--
-- Name: lo3_afnemers_verstrekking_aut; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_afnemers_verstrekking_aut (
    autorisatie_id bigint NOT NULL,
    afnemer_code integer NOT NULL,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_afnemers_verstrekking_aut OWNER TO haalcentraal;

--
-- Name: lo3_akte_aand; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_akte_aand (
    akte_aand character varying(3) NOT NULL,
    akte_soort_oms character varying(80) NOT NULL,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_akte_aand OWNER TO haalcentraal;

--
-- Name: lo3_autorisatie; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_autorisatie (
    autorisatie_id bigint NOT NULL,
    afnemer_code integer NOT NULL,
    geheimhouding_ind smallint NOT NULL,
    verstrekkings_beperking smallint NOT NULL,
    afnemer_naam character varying(80),
    straat_naam character varying(24),
    huis_nr integer,
    huis_letter character(1),
    huis_nr_toevoeging character varying(4),
    postcode character varying(6),
    gemeente_code smallint,
    conditionele_verstrekking smallint,
    spontaan_medium character(1),
    selectie_soort smallint,
    bericht_aand smallint,
    eerste_selectie_datum integer,
    selectie_periode smallint,
    selectie_medium character(1),
    pl_plaatsings_bevoegdheid smallint,
    adres_vraag_bevoegdheid smallint,
    ad_hoc_medium character(1),
    adres_medium character(1),
    tabel_regel_start_datum integer,
    tabel_regel_eind_datum integer,
    sleutel_rubrieken text,
    spontaan_rubrieken text,
    selectie_rubrieken text,
    ad_hoc_rubrieken text,
    adres_rubrieken text,
    afnemers_verstrekkingen text,
    bijzondere_betrekking_kind_verstrekken smallint DEFAULT 0,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_autorisatie OWNER TO haalcentraal;

--
-- Name: lo3_autorisatie_id_sequence; Type: SEQUENCE; Schema: public; Owner: haalcentraal
--

CREATE SEQUENCE public.lo3_autorisatie_id_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lo3_autorisatie_id_sequence OWNER TO haalcentraal;

--
-- Name: lo3_bericht; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_bericht (
    lo3_bericht_id bigint NOT NULL,
    aanduiding_in_uit character(1) NOT NULL,
    bericht_activiteit_id bigint,
    medium character(1) NOT NULL,
    originator_or_recipient character varying(7),
    spg_mailbox_instantie integer,
    eref character varying(12),
    bref character varying(12),
    eref2 character varying(12),
    berichtcyclus_id bigint,
    tijdstip_verzending_ontvangst timestamp without time zone,
    dispatch_sequence_number integer,
    report_delivery_time timestamp without time zone,
    non_delivery_reason character varying(4),
    non_receipt_reason character varying(4),
    bericht_data text,
    kop_random_key integer,
    kop_berichtsoort_nummer character varying(4),
    kop_a_nummer bigint,
    kop_oud_a_nummer bigint,
    kop_herhaling character(1),
    kop_foutreden character(1),
    kop_datum_tijd bigint,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_bericht OWNER TO haalcentraal;

--
-- Name: lo3_bericht_id_sequence; Type: SEQUENCE; Schema: public; Owner: haalcentraal
--

CREATE SEQUENCE public.lo3_bericht_id_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lo3_bericht_id_sequence OWNER TO haalcentraal;

--
-- Name: lo3_bericht_view_inkomend; Type: VIEW; Schema: public; Owner: haalcentraal
--

CREATE VIEW public.lo3_bericht_view_inkomend AS
 SELECT lo3_bericht.lo3_bericht_id,
    lo3_bericht.originator_or_recipient,
    lo3_bericht.bref,
    lo3_bericht.dispatch_sequence_number,
    lo3_bericht.kop_berichtsoort_nummer
   FROM public.lo3_bericht;


ALTER TABLE public.lo3_bericht_view_inkomend OWNER TO haalcentraal;

--
-- Name: lo3_bericht_view_insert_update; Type: VIEW; Schema: public; Owner: haalcentraal
--

CREATE VIEW public.lo3_bericht_view_insert_update AS
 SELECT lo3_bericht.lo3_bericht_id,
    NULL::character(1) AS aanduiding_in_uit,
    NULL::bigint AS bericht_activiteit_id,
    NULL::character(1) AS medium,
    NULL::character varying(7) AS originator_or_recipient,
    NULL::integer AS spg_mailbox_instantie,
    NULL::character varying(12) AS eref,
    NULL::character varying(12) AS bref,
    NULL::character varying(12) AS eref2,
    NULL::timestamp without time zone AS tijdstip_verzending_ontvangst,
    NULL::integer AS dispatch_sequence_number,
    NULL::timestamp without time zone AS report_delivery_time,
    NULL::character varying(4) AS non_delivery_reason,
    NULL::character varying(4) AS non_receipt_reason,
    NULL::text AS bericht_data,
    NULL::integer AS kop_random_key,
    NULL::character varying(4) AS kop_berichtsoort_nummer,
    NULL::bigint AS kop_a_nummer,
    NULL::bigint AS kop_oud_a_nummer,
    NULL::character(1) AS kop_herhaling,
    NULL::character(1) AS kop_foutreden,
    NULL::bigint AS kop_datum_tijd
   FROM public.lo3_bericht;


ALTER TABLE public.lo3_bericht_view_insert_update OWNER TO haalcentraal;

--
-- Name: lo3_bericht_view_uitgaand; Type: VIEW; Schema: public; Owner: haalcentraal
--

CREATE VIEW public.lo3_bericht_view_uitgaand AS
 SELECT lo3_bericht.lo3_bericht_id,
    lo3_bericht.aanduiding_in_uit,
    lo3_bericht.bericht_activiteit_id,
    lo3_bericht.medium,
    lo3_bericht.originator_or_recipient,
    lo3_bericht.spg_mailbox_instantie,
    lo3_bericht.eref,
    lo3_bericht.bref,
    lo3_bericht.eref2,
    lo3_bericht.berichtcyclus_id,
    lo3_bericht.tijdstip_verzending_ontvangst,
    lo3_bericht.dispatch_sequence_number,
    lo3_bericht.report_delivery_time,
    lo3_bericht.non_delivery_reason,
    lo3_bericht.non_receipt_reason,
    lo3_bericht.bericht_data,
    lo3_bericht.kop_random_key,
    lo3_bericht.kop_berichtsoort_nummer,
    lo3_bericht.kop_a_nummer,
    lo3_bericht.kop_oud_a_nummer,
    lo3_bericht.kop_herhaling,
    lo3_bericht.kop_foutreden,
    lo3_bericht.kop_datum_tijd,
    lo3_bericht.creatie_dt
   FROM public.lo3_bericht
  WHERE (lo3_bericht.aanduiding_in_uit = 'U'::bpchar);


ALTER TABLE public.lo3_bericht_view_uitgaand OWNER TO haalcentraal;

SET default_with_oids = false;

--
-- Name: lo3_gba_deelnemer; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_gba_deelnemer (
    deelnemer_code integer NOT NULL,
    deelnemer_oms character varying(80) NOT NULL,
    gba_netwerk_aand smallint,
    tabel_regel_start_datum integer,
    tabel_regel_eind_datum integer,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_gba_deelnemer OWNER TO haalcentraal;

SET default_with_oids = true;

--
-- Name: lo3_gemeente; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_gemeente (
    gemeente_code smallint NOT NULL,
    gemeente_naam character varying(40) NOT NULL,
    nieuwe_gemeente_code smallint,
    tabel_regel_start_datum integer,
    tabel_regel_eind_datum integer,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_gemeente OWNER TO haalcentraal;

SET default_with_oids = false;

--
-- Name: lo3_gezagsverhouding; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_gezagsverhouding (
    gezagsverhouding_code character varying(2) NOT NULL,
    gezagsverhouding_oms character varying(80) NOT NULL,
    tabel_regel_start_datum integer,
    tabel_regel_eind_datum integer,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_gezagsverhouding OWNER TO haalcentraal;

SET default_with_oids = true;

--
-- Name: lo3_land; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_land (
    land_code smallint NOT NULL,
    land_naam character varying(42) NOT NULL,
    tabel_regel_start_datum integer,
    tabel_regel_eind_datum integer,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_land OWNER TO haalcentraal;

--
-- Name: lo3_mailbox; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_mailbox (
    lo3_mailbox_nummer character varying(7) NOT NULL,
    spg_mailbox_instantie integer,
    soort_instantie character(1) NOT NULL,
    code_instantie integer,
    indicatie_mailbox_actief character(1),
    brp_overgangs_datum integer,
    blokkade_start_dt timestamp without time zone,
    blokkade_eind_dt timestamp without time zone,
    mutatie_dt timestamp without time zone,
    blokkade_bericht_nrs character varying(400),
    deblokkade_toestand integer,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_mailbox OWNER TO haalcentraal;

--
-- Name: lo3_nationaliteit; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_nationaliteit (
    nationaliteit_code smallint NOT NULL,
    nationaliteit_oms character varying(42) NOT NULL,
    tabel_regel_start_datum integer,
    tabel_regel_eind_datum integer,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_nationaliteit OWNER TO haalcentraal;

--
-- Name: lo3_nl_nat_verkrijg_verlies_reden; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_nl_nat_verkrijg_verlies_reden (
    nl_nat_verkrijg_verlies_reden smallint NOT NULL,
    nl_nat_reden_oms character varying(80) NOT NULL,
    nl_nat_reden_soort character varying(2) NOT NULL,
    tabel_regel_start_datum integer,
    tabel_regel_eind_datum integer,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_nl_nat_verkrijg_verlies_reden OWNER TO haalcentraal;

--
-- Name: lo3_nl_reis_doc_autoriteit; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_nl_reis_doc_autoriteit (
    nl_reis_doc_autoriteit_code character varying(6) NOT NULL,
    nl_reis_doc_autoriteit_oms character varying(80) NOT NULL,
    tabel_regel_start_datum integer,
    tabel_regel_eind_datum integer,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_nl_reis_doc_autoriteit OWNER TO haalcentraal;

--
-- Name: lo3_nl_reis_doc_soort; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_nl_reis_doc_soort (
    nl_reis_doc_soort character varying(2) NOT NULL,
    nl_reis_doc_soort_oms character varying(80) NOT NULL,
    tabel_regel_start_datum integer,
    tabel_regel_eind_datum integer,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_nl_reis_doc_soort OWNER TO haalcentraal;

--
-- Name: lo3_pl; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_pl (
    pl_id bigint NOT NULL,
    pl_blokkering_start_datum integer,
    bijhouding_opschort_datum integer,
    bijhouding_opschort_reden character(1),
    gba_eerste_inschrijving_datum integer,
    pk_gemeente_code smallint,
    geheim_ind smallint,
    volledig_geconverteerd_pk character(1),
    europees_kiesrecht_aand smallint,
    europees_kiesrecht_datum integer,
    europees_uitsluit_eind_datum integer,
    kiesrecht_uitgesl_aand character(1),
    kiesrecht_uitgesl_eind_datum integer,
    kiesrecht_doc_gemeente_code smallint,
    kiesrecht_doc_datum integer,
    kiesrecht_doc_beschrijving character varying(40),
    mutatie_activiteit_id bigint,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL,
    mutatie_dt timestamp without time zone NOT NULL,
    versie_nr smallint,
    stempel_dt bigint,
    verificatie_datum integer,
    verificatie_oms character varying(50),
    rni_deelnemer smallint,
    verdrag_oms character varying(50)
);


ALTER TABLE public.lo3_pl OWNER TO haalcentraal;

SET default_with_oids = false;

--
-- Name: lo3_pl_afnemer_ind; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_pl_afnemer_ind (
    pl_id bigint NOT NULL,
    stapel_nr smallint NOT NULL,
    volg_nr smallint NOT NULL,
    afnemer_code integer,
    geldigheid_start_datum integer
);


ALTER TABLE public.lo3_pl_afnemer_ind OWNER TO haalcentraal;

SET default_with_oids = true;

--
-- Name: lo3_pl_gezagsverhouding; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_pl_gezagsverhouding (
    pl_id bigint NOT NULL,
    volg_nr smallint NOT NULL,
    minderjarig_gezag_ind character varying(2),
    curatele_register_ind smallint,
    doc_gemeente_code smallint,
    doc_datum integer,
    doc_beschrijving character varying(40),
    onderzoek_gegevens_aand integer,
    onderzoek_start_datum integer,
    onderzoek_eind_datum integer,
    onjuist_ind character(1),
    geldigheid_start_datum integer,
    opneming_datum integer
);


ALTER TABLE public.lo3_pl_gezagsverhouding OWNER TO haalcentraal;

--
-- Name: lo3_pl_id_sequence; Type: SEQUENCE; Schema: public; Owner: haalcentraal
--

CREATE SEQUENCE public.lo3_pl_id_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lo3_pl_id_sequence OWNER TO haalcentraal;

--
-- Name: lo3_pl_nationaliteit; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_pl_nationaliteit (
    pl_id bigint NOT NULL,
    stapel_nr smallint NOT NULL,
    volg_nr smallint NOT NULL,
    nationaliteit_code smallint,
    nl_nat_verkrijg_reden smallint,
    nl_nat_verlies_reden smallint,
    bijzonder_nl_aand character(1),
    doc_gemeente_code smallint,
    doc_datum integer,
    doc_beschrijving character varying(40),
    onderzoek_gegevens_aand integer,
    onderzoek_start_datum integer,
    onderzoek_eind_datum integer,
    onjuist_ind character(1),
    geldigheid_start_datum integer,
    opneming_datum integer,
    rni_deelnemer smallint,
    verdrag_oms character varying(50),
    eu_persoon_nr character varying(40)
);


ALTER TABLE public.lo3_pl_nationaliteit OWNER TO haalcentraal;

SET default_with_oids = false;

--
-- Name: lo3_pl_overlijden; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_pl_overlijden (
    pl_id bigint NOT NULL,
    volg_nr smallint NOT NULL,
    overlijden_datum integer,
    overlijden_plaats character varying(40),
    overlijden_land_code smallint,
    akte_register_gemeente_code smallint,
    akte_nr character varying(7),
    doc_gemeente_code smallint,
    doc_datum integer,
    doc_beschrijving character varying(40),
    onderzoek_gegevens_aand integer,
    onderzoek_start_datum integer,
    onderzoek_eind_datum integer,
    onjuist_ind character(1),
    geldigheid_start_datum integer,
    opneming_datum integer,
    rni_deelnemer smallint,
    verdrag_oms character varying(50)
);


ALTER TABLE public.lo3_pl_overlijden OWNER TO haalcentraal;

--
-- Name: lo3_pl_paw_index_2; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_pl_paw_index_2 (
    pl_id bigint NOT NULL,
    voor_naam character varying(200),
    diak_voor_naam character varying(200),
    geslachts_naam character varying(200) NOT NULL,
    diak_geslachts_naam character varying(200),
    titel_predikaat character varying(2),
    geslachts_naam_voorvoegsel character varying(10),
    geboorte_datum integer,
    geboorte_plaats character varying(40),
    geboorte_land_code smallint,
    geslachts_aand character(1),
    naam_gebruik_aand character(1),
    inschrijving_gemeente_code smallint NOT NULL,
    gemeente_deel character varying(24),
    straat_naam character varying(24),
    diak_straat_naam character varying(24),
    huis_nr integer,
    huis_letter character(1),
    huis_nr_toevoeging character varying(4),
    huis_nr_aand character varying(2),
    postcode character varying(6),
    locatie_beschrijving character varying(35),
    diak_locatie_beschrijving character varying(35),
    open_ruimte_naam character varying(80),
    diak_open_ruimte_naam character varying(80),
    woon_plaats_naam character varying(80),
    diak_woon_plaats_naam character varying(80),
    verblijf_plaats_ident_code character varying(16),
    nummer_aand_ident_code character varying(16)
);


ALTER TABLE public.lo3_pl_paw_index_2 OWNER TO haalcentraal;

--
-- Name: lo3_pl_persoon; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_pl_persoon (
    pl_id bigint NOT NULL,
    persoon_type character(1) NOT NULL,
    stapel_nr smallint NOT NULL,
    volg_nr smallint NOT NULL,
    a_nr bigint,
    burger_service_nr bigint,
    voor_naam character varying(200),
    diak_voor_naam character varying(200),
    titel_predicaat character varying(2),
    geslachts_naam_voorvoegsel character varying(10),
    geslachts_naam character varying(200),
    diak_geslachts_naam character varying(200),
    geboorte_datum integer,
    geboorte_plaats character varying(40),
    geboorte_land_code smallint,
    geslachts_aand character(1),
    naam_gebruik_aand character(1),
    akte_register_gemeente_code smallint,
    akte_nr character varying(7),
    doc_gemeente_code smallint,
    doc_datum integer,
    doc_beschrijving character varying(40),
    onderzoek_gegevens_aand integer,
    onderzoek_start_datum integer,
    onderzoek_eind_datum integer,
    onjuist_ind character(1),
    geldigheid_start_datum integer,
    opneming_datum integer,
    relatie_start_datum integer,
    relatie_start_plaats character varying(40),
    relatie_start_land_code smallint,
    relatie_eind_datum integer,
    relatie_eind_plaats character varying(40),
    relatie_eind_land_code smallint,
    relatie_eind_reden character(1),
    verbintenis_soort character(1),
    familie_betrek_start_datum integer,
    vorig_a_nr bigint,
    volgend_a_nr bigint,
    rni_deelnemer smallint,
    verdrag_oms character varying(50),
    registratie_betrekking character(1)
);


ALTER TABLE public.lo3_pl_persoon OWNER TO haalcentraal;

--
-- Name: lo3_pl_reis_doc; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_pl_reis_doc (
    pl_id bigint NOT NULL,
    stapel_nr smallint NOT NULL,
    nl_reis_doc_soort character varying(2),
    nl_reis_doc_nr character varying(9),
    nl_reis_doc_uitgifte_datum integer,
    nl_reis_doc_autoriteit_code character varying(6),
    nl_reis_doc_geldig_eind_datum integer,
    nl_reis_doc_weg_datum integer,
    nl_reis_doc_weg_ind character(1),
    nl_reis_doc_houder_lengte smallint,
    nl_reis_doc_signalering smallint,
    buitenland_reis_doc_aand smallint,
    doc_gemeente_code smallint,
    doc_datum integer,
    doc_beschrijving character varying(40),
    onderzoek_gegevens_aand integer,
    onderzoek_start_datum integer,
    onderzoek_eind_datum integer,
    geldigheid_start_datum integer,
    opneming_datum integer
);


ALTER TABLE public.lo3_pl_reis_doc OWNER TO haalcentraal;

--
-- Name: lo3_pl_serialized; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_pl_serialized (
    pl_id bigint NOT NULL,
    mutatie_dt timestamp without time zone DEFAULT now() NOT NULL,
    data text NOT NULL
);


ALTER TABLE public.lo3_pl_serialized OWNER TO haalcentraal;

--
-- Name: lo3_pl_verblijfplaats; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_pl_verblijfplaats (
    pl_id bigint NOT NULL,
    volg_nr smallint NOT NULL,
    inschrijving_gemeente_code smallint,
    adres_id bigint,
    inschrijving_datum integer,
    adres_functie character(1),
    gemeente_deel character varying(24),
    adreshouding_start_datum integer,
    vertrek_land_code smallint,
    vertrek_datum integer,
    vertrek_land_adres_1 character varying(35),
    vertrek_land_adres_2 character varying(35),
    vertrek_land_adres_3 character varying(35),
    vestiging_land_code smallint,
    vestiging_datum integer,
    aangifte_adreshouding_oms character(1),
    doc_ind smallint,
    onderzoek_gegevens_aand integer,
    onderzoek_start_datum integer,
    onderzoek_eind_datum integer,
    onjuist_ind character(1),
    geldigheid_start_datum integer,
    opneming_datum integer,
    rni_deelnemer smallint,
    verdrag_oms character varying(50)
);


ALTER TABLE public.lo3_pl_verblijfplaats OWNER TO haalcentraal;

SET default_with_oids = true;

--
-- Name: lo3_pl_verblijfstitel; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_pl_verblijfstitel (
    pl_id bigint NOT NULL,
    volg_nr smallint NOT NULL,
    verblijfstitel_aand smallint,
    verblijfstitel_eind_datum integer,
    verblijfstitel_start_datum integer,
    onderzoek_gegevens_aand integer,
    onderzoek_start_datum integer,
    onderzoek_eind_datum integer,
    onjuist_ind character(1),
    geldigheid_start_datum integer,
    opneming_datum integer
);


ALTER TABLE public.lo3_pl_verblijfstitel OWNER TO haalcentraal;

--
-- Name: lo3_relatie_eind_reden; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_relatie_eind_reden (
    relatie_eind_reden character(1) NOT NULL,
    relatie_eind_reden_oms character varying(80),
    tabel_regel_start_datum integer,
    tabel_regel_eind_datum integer,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_relatie_eind_reden OWNER TO haalcentraal;

SET default_with_oids = false;

--
-- Name: lo3_rni_deelnemer; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_rni_deelnemer (
    deelnemer_code smallint NOT NULL,
    deelnemer_oms character varying(80) NOT NULL,
    tabel_regel_start_datum integer,
    tabel_regel_eind_datum integer,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_rni_deelnemer OWNER TO haalcentraal;

SET default_with_oids = true;

--
-- Name: lo3_titel_predicaat; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_titel_predicaat (
    titel_predicaat character varying(2) NOT NULL,
    titel_predicaat_oms character varying(10) NOT NULL,
    titel_predicaat_soort character varying(10) NOT NULL,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_titel_predicaat OWNER TO haalcentraal;

--
-- Name: lo3_verblijfstitel_aand; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_verblijfstitel_aand (
    verblijfstitel_aand smallint NOT NULL,
    verblijfstitel_aand_oms character varying(80) NOT NULL,
    tabel_regel_start_datum integer,
    tabel_regel_eind_datum integer,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_verblijfstitel_aand OWNER TO haalcentraal;

--
-- Name: lo3_voorvoegsel; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_voorvoegsel (
    voorvoegsel character varying(10) NOT NULL,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_voorvoegsel OWNER TO haalcentraal;

--
-- Name: lo3_voorwaarde_regel_aut; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_voorwaarde_regel_aut (
    voorwaarde_type character(1) NOT NULL,
    voorwaarde_regel character varying(4096) NOT NULL,
    autorisatie_id bigint NOT NULL,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_voorwaarde_regel_aut OWNER TO haalcentraal;

--
-- Name: lo3_vospg_instructie; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lo3_vospg_instructie (
    spg_mailbox_instantie integer NOT NULL,
    soort_instructie character varying(40),
    dag_van_de_week smallint,
    tijd time without time zone,
    datum_tijd timestamp without time zone,
    tijdstip_laatste_actie timestamp without time zone,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lo3_vospg_instructie OWNER TO haalcentraal;

--
-- Name: lo3_vospg_instructie_id_sequence; Type: SEQUENCE; Schema: public; Owner: haalcentraal
--

CREATE SEQUENCE public.lo3_vospg_instructie_id_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lo3_vospg_instructie_id_sequence OWNER TO haalcentraal;

--
-- Name: lookup_codering; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lookup_codering (
    lookup_codering_id integer NOT NULL,
    codering_naam character varying(40) NOT NULL,
    code_type character(1) NOT NULL,
    idc_vaste_codering character(1) NOT NULL,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lookup_codering OWNER TO haalcentraal;

--
-- Name: lookup_codewaarde; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.lookup_codewaarde (
    lookup_codering_id integer NOT NULL,
    referentie_waarde_num integer,
    referentie_waarde_alfa character varying(40),
    lookup_afkorting character varying(20),
    lookup_omschrijving character varying(40) NOT NULL,
    omschrijving_volledig character varying(200),
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL,
    mutatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.lookup_codewaarde OWNER TO haalcentraal;

SET default_with_oids = false;

--
-- Name: miteller; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.miteller (
    groep_id character varying(8) NOT NULL,
    soort_teller integer NOT NULL,
    aantal integer NOT NULL,
    datum_telling date NOT NULL,
    periode smallint NOT NULL,
    periode_aanduiding character varying(5) NOT NULL
);


ALTER TABLE public.miteller OWNER TO haalcentraal;

--
-- Name: miteller_marker; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.miteller_marker (
    marker_id character varying(30) NOT NULL,
    marker bigint NOT NULL
);


ALTER TABLE public.miteller_marker OWNER TO haalcentraal;

--
-- Name: monitor; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.monitor (
    monitor_id bigint NOT NULL,
    node character varying(50) NOT NULL,
    component character varying(50) NOT NULL,
    ernst integer NOT NULL,
    melding text,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.monitor OWNER TO haalcentraal;

--
-- Name: monitor_id_sequence; Type: SEQUENCE; Schema: public; Owner: haalcentraal
--

CREATE SEQUENCE public.monitor_id_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.monitor_id_sequence OWNER TO haalcentraal;

--
-- Name: selectie_enumeratie; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.selectie_enumeratie (
    selectie_instelling_id bigint NOT NULL,
    enumeratie text
);


ALTER TABLE public.selectie_enumeratie OWNER TO haalcentraal;

--
-- Name: selectie_instelling; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.selectie_instelling (
    selectie_instelling_id bigint NOT NULL,
    autorisatie_id bigint NOT NULL,
    geschatte_omvang integer NOT NULL,
    leverwijze integer NOT NULL,
    max_berichten integer NOT NULL,
    berichtsoort integer,
    selectiesoort integer NOT NULL,
    bestands_formaat integer,
    selectie_datum date NOT NULL,
    berekende_selectie_datum date NOT NULL,
    selectie_activiteit_id bigint NOT NULL,
    voorwaarde_regel character varying(4096) NOT NULL,
    rubrieken character varying(4096) NOT NULL,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL,
    teller_definities character varying(4096)
);


ALTER TABLE public.selectie_instelling OWNER TO haalcentraal;

--
-- Name: selectie_instelling_id_sequence; Type: SEQUENCE; Schema: public; Owner: haalcentraal
--

CREATE SEQUENCE public.selectie_instelling_id_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.selectie_instelling_id_sequence OWNER TO haalcentraal;

SET default_with_oids = true;

--
-- Name: spg_mailbox; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.spg_mailbox (
    spg_mailbox_instantie integer NOT NULL,
    spg_mailbox_nummer character varying(7) NOT NULL
);


ALTER TABLE public.spg_mailbox OWNER TO haalcentraal;

--
-- Name: spg_schema; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.spg_schema (
    version character varying(40) NOT NULL
);


ALTER TABLE public.spg_schema OWNER TO haalcentraal;

SET default_with_oids = false;

--
-- Name: tmp_convert_special_characters_adres; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.tmp_convert_special_characters_adres (
    adres_id bigint,
    old_straat_naam character varying(24),
    old_diak_straat_naam character varying(24),
    old_locatie_beschrijving character varying(35),
    old_diak_locatie_beschrijving character varying(35),
    new_straat_naam character varying,
    new_diak_straat_naam character varying(24),
    new_locatie_beschrijving character varying,
    new_diak_locatie_beschrijving character varying(35)
);


ALTER TABLE public.tmp_convert_special_characters_adres OWNER TO haalcentraal;

--
-- Name: tmp_convert_special_characters_persoon; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.tmp_convert_special_characters_persoon (
    pl_id bigint,
    persoon_type character(1),
    stapel_nr smallint,
    volg_nr smallint,
    old_voor_naam character varying(200),
    old_diak_voor_naam character varying(200),
    old_geslachts_naam character varying(200),
    old_diak_geslachts_naam character varying(200),
    new_voor_naam character varying,
    new_diak_voor_naam character varying(200),
    new_geslachts_naam character varying,
    new_diak_geslachts_naam character varying(200)
);


ALTER TABLE public.tmp_convert_special_characters_persoon OWNER TO haalcentraal;

SET default_with_oids = true;

--
-- Name: toestand_overgang; Type: TABLE; Schema: public; Owner: haalcentraal
--

CREATE TABLE public.toestand_overgang (
    toestand_overgang_id integer NOT NULL,
    activiteit_type integer NOT NULL,
    activiteit_subtype integer,
    toestand_huidig integer,
    gebeurtenis_type integer NOT NULL,
    toestand_nieuw integer NOT NULL,
    creatie_dt timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.toestand_overgang OWNER TO haalcentraal;

--
-- Name: toestand_overgang_id_sequence; Type: SEQUENCE; Schema: public; Owner: haalcentraal
--

CREATE SEQUENCE public.toestand_overgang_id_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.toestand_overgang_id_sequence OWNER TO haalcentraal;

SET default_with_oids = false;

--
-- Name: pl_bericht; Type: TABLE; Schema: vospg; Owner: haalcentraal
--

CREATE TABLE vospg.pl_bericht (
    pl_bericht_id bigint NOT NULL,
    a_nr bigint,
    bericht_data text,
    hash_bericht_data text,
    verzender character varying(7),
    tijdstip_ontvangst timestamp without time zone,
    berichtsoort_nummer character varying(4)
);


ALTER TABLE vospg.pl_bericht OWNER TO haalcentraal;

--
-- Name: pl_bericht_id_sequence; Type: SEQUENCE; Schema: vospg; Owner: haalcentraal
--

CREATE SEQUENCE vospg.pl_bericht_id_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE vospg.pl_bericht_id_sequence OWNER TO haalcentraal;

--
-- Data for Name: activiteit_small; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--



--
-- Data for Name: afnemer; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--



--
-- Data for Name: gebeurtenis_data; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--



--
-- Data for Name: gebeurtenis_small; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--



--
-- Data for Name: haalcentraal_vraag; Type: TABLE DATA; Schema: public; Owner: root
--



--
-- Data for Name: herindeling; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--



--
-- Data for Name: lo3_adres; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--



--
-- Data for Name: lo3_adres_afnemer_ind; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--



--
-- Data for Name: lo3_afnemers_verstrekking_aut; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--



--
-- Data for Name: lo3_akte_aand; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--



--
-- Data for Name: lo3_autorisatie; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--



--
-- Data for Name: lo3_bericht; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--



--
-- Data for Name: lo3_gba_deelnemer; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--



--
-- Data for Name: lo3_gemeente; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--

INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (0, 'Onbekend', NULL, NULL, NULL, '2023-05-10 09:16:54.129023');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1, 'Adorp', 53, NULL, 19900101, '2023-05-10 09:16:54.132734');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (2, 'Aduard', 56, NULL, 19900101, '2023-05-10 09:16:54.135023');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (3, 'Appingedam', 1979, NULL, 20210101, '2023-05-10 09:16:54.137163');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (4, 'Baflo', 53, NULL, 19900101, '2023-05-10 09:16:54.139292');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5, 'Bedum', 1966, NULL, 20190101, '2023-05-10 09:16:54.140864');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6, 'Beerta', 1661, NULL, 19910701, '2023-05-10 09:16:54.191285');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7, 'Bellingwedde', 1950, 19680101, 20180101, '2023-05-10 09:16:54.194281');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (8, 'Bierum', 10, NULL, 19900101, '2023-05-10 09:16:54.196912');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9, 'Ten Boer', 14, NULL, 20190101, '2023-05-10 09:16:54.199212');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (10, 'Delfzijl', 1979, NULL, 20210101, '2023-05-10 09:16:54.201818');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (11, 'Eenrum', 45, NULL, 19900101, '2023-05-10 09:16:54.203825');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (12, 'Ezinge', 53, NULL, 19900101, '2023-05-10 09:16:54.205645');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (13, 'Finsterwolde', 6, NULL, 19900101, '2023-05-10 09:16:54.20782');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (14, 'Groningen', NULL, NULL, NULL, '2023-05-10 09:16:54.210274');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (15, 'Grootegast', 1969, NULL, 20190101, '2023-05-10 09:16:54.212205');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (16, 'Grijpskerk', 56, NULL, 19900101, '2023-05-10 09:16:54.214103');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (17, 'Haren', 14, NULL, 20190101, '2023-05-10 09:16:54.215454');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (18, 'Hoogezand-Sappemeer', 1952, 19490401, 20180101, '2023-05-10 09:16:54.216931');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (19, 'Hefshuizen', 1651, 19790101, 19920101, '2023-05-10 09:16:54.21895');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (20, 'Kantens', 19, NULL, 19900101, '2023-05-10 09:16:54.220976');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (21, 'Kloosterburen', 45, NULL, 19900101, '2023-05-10 09:16:54.223166');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (22, 'Leek', 1969, NULL, 20190101, '2023-05-10 09:16:54.224605');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (23, 'Leens', 45, NULL, 19900101, '2023-05-10 09:16:54.226859');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (24, 'Loppersum', 1979, NULL, 20210101, '2023-05-10 09:16:54.228587');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (25, 'Marum', 1969, NULL, 20190101, '2023-05-10 09:16:54.232397');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (26, 'Meeden', 33, NULL, 19900101, '2023-05-10 09:16:54.236315');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (27, 'Middelstum', 24, NULL, 19900101, '2023-05-10 09:16:54.238065');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (28, 'Midwolda', 39, NULL, 19900101, '2023-05-10 09:16:54.239482');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (29, 'Muntendam', 33, NULL, 19900101, '2023-05-10 09:16:54.241142');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (30, 'Nieuwe Pekela', 765, NULL, 19900101, '2023-05-10 09:16:54.242367');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (31, 'Nieuweschans', 6, NULL, 19900101, '2023-05-10 09:16:54.244362');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (32, 'Nieuwolda', 39, NULL, 19900101, '2023-05-10 09:16:54.247174');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (33, 'Oosterbroek', 1987, 19650701, 19910201, '2023-05-10 09:16:54.250405');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (34, 'Almere', NULL, 19840101, NULL, '2023-05-10 09:16:54.252456');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (35, 'Oldehove', 56, NULL, 19900101, '2023-05-10 09:16:54.254489');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (36, 'Oldekerk', 15, NULL, 19900101, '2023-05-10 09:16:54.256208');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (37, 'Stadskanaal', NULL, 19690101, NULL, '2023-05-10 09:16:54.258025');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (38, 'Oude Pekela', 765, NULL, 19900101, '2023-05-10 09:16:54.259724');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (39, 'Scheemda', 1895, NULL, 20100101, '2023-05-10 09:16:54.266309');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (40, 'Slochteren', 1952, NULL, 20180101, '2023-05-10 09:16:54.269167');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (41, 'Stedum', 24, NULL, 19900101, '2023-05-10 09:16:54.270925');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (42, 'Termunten', 10, NULL, 19900101, '2023-05-10 09:16:54.322335');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (43, 'Uithuizen', 19, NULL, 19790101, '2023-05-10 09:16:54.324837');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (44, 'Uithuizermeeden', 19, NULL, 19790101, '2023-05-10 09:16:54.332552');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (45, 'Ulrum', 1663, NULL, 19920101, '2023-05-10 09:16:54.334675');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (46, 'Usquert', 19, NULL, 19900101, '2023-05-10 09:16:54.337226');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (47, 'Veendam', NULL, NULL, NULL, '2023-05-10 09:16:54.338915');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (48, 'Vlagtwedde', 1950, NULL, 20180101, '2023-05-10 09:16:54.340377');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (49, 'Warffum', 19, NULL, 19900101, '2023-05-10 09:16:54.342139');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (50, 'Zeewolde', NULL, 19840101, NULL, '2023-05-10 09:16:54.343717');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (51, 'Skarsterlân', 1921, 19850301, 20140101, '2023-05-10 09:16:54.345002');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (52, 'Winschoten', 1895, NULL, 20100101, '2023-05-10 09:16:54.346295');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (53, 'Winsum', 1966, NULL, 20190101, '2023-05-10 09:16:54.347524');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (54, '''t Zandt', 24, NULL, 19900101, '2023-05-10 09:16:54.349032');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (55, 'Boarnsterhim', 80, 19850103, 20140101, '2023-05-10 09:16:54.350448');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (56, 'Zuidhorn', 1969, NULL, 20190101, '2023-05-10 09:16:54.351845');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (57, 'Boornsterhem', 55, 19840101, 19850103, '2023-05-10 09:16:54.353331');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (58, 'Dongeradeel', 1970, 19840101, 20190101, '2023-05-10 09:16:54.355576');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (59, 'Achtkarspelen', NULL, NULL, NULL, '2023-05-10 09:16:54.357826');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (60, 'Ameland', NULL, NULL, NULL, '2023-05-10 09:16:54.359421');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (61, 'Baarderadeel', 103, NULL, 19840101, '2023-05-10 09:16:54.361426');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (62, 'Barradeel', 70, NULL, 19840101, '2023-05-10 09:16:54.363355');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (63, 'het Bildt', 1949, NULL, 20180101, '2023-05-10 09:16:54.365025');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (64, 'Bolsward', 1900, NULL, 20110101, '2023-05-10 09:16:54.367159');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (65, 'Dantumadeel', 1891, NULL, 20090101, '2023-05-10 09:16:54.369525');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (66, 'Dokkum', 58, NULL, 19840101, '2023-05-10 09:16:54.371213');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (67, 'Doniawerstal', 139, NULL, 19840101, '2023-05-10 09:16:54.372548');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (68, 'Ferwerderadeel', 1722, NULL, 19990101, '2023-05-10 09:16:54.374434');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (69, 'Franeker', 70, NULL, 19840101, '2023-05-10 09:16:54.377086');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (70, 'Franekeradeel', 1949, NULL, 20180101, '2023-05-10 09:16:54.378902');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (71, 'Gaasterland', 653, NULL, 19850605, '2023-05-10 09:16:54.380632');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (72, 'Harlingen', NULL, NULL, NULL, '2023-05-10 09:16:54.382495');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (73, 'Haskerland', 139, NULL, 19840101, '2023-05-10 09:16:54.384491');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (74, 'Heerenveen', NULL, 19340701, NULL, '2023-05-10 09:16:54.386648');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (75, 'Hemelumer Oldeferd', 104, 19560101, 19840101, '2023-05-10 09:16:54.391201');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (76, 'Hennaarderadeel', 103, NULL, 19840101, '2023-05-10 09:16:54.394271');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (77, 'Hindeloopen', 104, NULL, 19840101, '2023-05-10 09:16:54.397258');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (78, 'Idaarderadeel', 57, NULL, 19840101, '2023-05-10 09:16:54.402319');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (79, 'Kollumerland en Nieuwkruisland', 1970, NULL, 20190101, '2023-05-10 09:16:54.40531');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (80, 'Leeuwarden', NULL, NULL, NULL, '2023-05-10 09:16:54.406846');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (81, 'Leeuwarderadeel', 80, NULL, 20180101, '2023-05-10 09:16:54.408709');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (82, 'Lemsterland', 1921, NULL, 20140101, '2023-05-10 09:16:54.41135');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (83, 'Menaldumadeel', 1908, NULL, 20110101, '2023-05-10 09:16:54.41328');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (84, 'Oostdongeradeel', 58, NULL, 19840101, '2023-05-10 09:16:54.415179');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (85, 'Ooststellingwerf', NULL, NULL, NULL, '2023-05-10 09:16:54.416976');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (86, 'Opsterland', NULL, NULL, NULL, '2023-05-10 09:16:54.419018');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (87, 'Rauwerderhem', 57, NULL, 19840101, '2023-05-10 09:16:54.423243');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (88, 'Schiermonnikoog', NULL, NULL, NULL, '2023-05-10 09:16:54.426241');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (89, 'Sloten (F)', 71, NULL, 19840101, '2023-05-10 09:16:54.428916');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (90, 'Smallingerland', NULL, NULL, NULL, '2023-05-10 09:16:54.431418');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (91, 'Sneek', 1900, NULL, 20110101, '2023-05-10 09:16:54.480469');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (92, 'Stavoren', 104, NULL, 19840101, '2023-05-10 09:16:54.481726');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (93, 'Terschelling', NULL, NULL, NULL, '2023-05-10 09:16:54.482952');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (94, 'Tietjerksteradeel', 737, NULL, 19890101, '2023-05-10 09:16:54.484228');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (95, 'Utingeradeel', 57, NULL, 19840101, '2023-05-10 09:16:54.485834');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (96, 'Vlieland', NULL, NULL, NULL, '2023-05-10 09:16:54.487119');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (97, 'Westdongeradeel', 58, NULL, 19840101, '2023-05-10 09:16:54.488371');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (98, 'Weststellingwerf', NULL, NULL, NULL, '2023-05-10 09:16:54.489728');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (99, 'Wonseradeel', 710, NULL, 19870101, '2023-05-10 09:16:54.491039');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (100, 'Workum', 104, NULL, 19840101, '2023-05-10 09:16:54.493057');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (101, 'Wymbritseradeel', 683, NULL, 19860101, '2023-05-10 09:16:54.495115');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (102, 'IJlst', 101, NULL, 19840101, '2023-05-10 09:16:54.496791');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (103, 'Littenseradeel', 140, 19840101, 19850126, '2023-05-10 09:16:54.498501');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (104, 'Nijefurd', 1900, 19840101, 20110101, '2023-05-10 09:16:54.500356');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (105, 'Anloo', 1680, NULL, 19980101, '2023-05-10 09:16:54.502064');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (106, 'Assen', NULL, NULL, NULL, '2023-05-10 09:16:54.503965');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (107, 'Beilen', 1697, NULL, 19980101, '2023-05-10 09:16:54.506102');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (108, 'Borger', 1681, NULL, 19980101, '2023-05-10 09:16:54.507407');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (109, 'Coevorden', NULL, NULL, NULL, '2023-05-10 09:16:54.508695');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (110, 'Dalen', 109, NULL, 19980101, '2023-05-10 09:16:54.510368');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (111, 'Diever', 1701, NULL, 19980101, '2023-05-10 09:16:54.512081');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (112, 'Dwingeloo', 1701, NULL, 19980101, '2023-05-10 09:16:54.513873');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (113, 'Eelde', 136, NULL, 19980101, '2023-05-10 09:16:54.515682');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (114, 'Emmen', NULL, NULL, NULL, '2023-05-10 09:16:54.516912');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (115, 'Gasselte', 1680, NULL, 19980101, '2023-05-10 09:16:54.518074');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (116, 'Gieten', 1680, NULL, 19980101, '2023-05-10 09:16:54.519855');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (117, 'Havelte', 1701, NULL, 19980101, '2023-05-10 09:16:54.521679');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (118, 'Hoogeveen', NULL, NULL, NULL, '2023-05-10 09:16:54.52299');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (119, 'Meppel', NULL, NULL, NULL, '2023-05-10 09:16:54.525157');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (120, 'Norg', 1699, NULL, 19980101, '2023-05-10 09:16:54.527175');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (121, 'Nijeveen', 119, NULL, 19980101, '2023-05-10 09:16:54.5285');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (122, 'Odoorn', 1681, NULL, 19980101, '2023-05-10 09:16:54.529684');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (123, 'Oosterhesselen', 109, NULL, 19980101, '2023-05-10 09:16:54.530907');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (124, 'Peize', 1699, NULL, 19980101, '2023-05-10 09:16:54.53208');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (125, 'Roden', 1699, NULL, 19980101, '2023-05-10 09:16:54.534022');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (126, 'Rolde', 1680, NULL, 19980101, '2023-05-10 09:16:54.5354');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (127, 'Ruinen', 1690, NULL, 19980101, '2023-05-10 09:16:54.537158');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (128, 'Ruinerwold', 1690, NULL, 19980101, '2023-05-10 09:16:54.538921');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (129, 'Schoonebeek', 114, 18840501, 19980101, '2023-05-10 09:16:54.540197');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (130, 'Sleen', 109, NULL, 19980101, '2023-05-10 09:16:54.542221');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (131, 'Smilde', 1697, NULL, 19980101, '2023-05-10 09:16:54.544345');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (132, 'Vledder', 1701, NULL, 19980101, '2023-05-10 09:16:54.546249');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (133, 'Vries', 136, NULL, 19980101, '2023-05-10 09:16:54.548011');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (134, 'Westerbork', 1697, NULL, 19980101, '2023-05-10 09:16:54.549754');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (135, 'de Wijk', 1690, NULL, 19980101, '2023-05-10 09:16:54.551615');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (136, 'Zuidlaren', 1730, NULL, 19991201, '2023-05-10 09:16:54.553413');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (137, 'Zuidwolde', 1690, NULL, 19980101, '2023-05-10 09:16:54.554711');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (138, 'Zweeloo', 109, NULL, 19980101, '2023-05-10 09:16:54.556616');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (139, 'Scharsterland', 51, 19840101, 19850301, '2023-05-10 09:16:54.55875');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (140, 'Littenseradiel', 1900, 19850126, 20180101, '2023-05-10 09:16:54.560631');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (141, 'Almelo', NULL, 19130101, NULL, '2023-05-10 09:16:54.562904');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (142, 'Ambt Delden', 1735, NULL, 20010101, '2023-05-10 09:16:54.564497');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (143, 'Avereest', 160, NULL, 20010101, '2023-05-10 09:16:54.56627');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (144, 'Bathmen', 150, NULL, 20050101, '2023-05-10 09:16:54.568063');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (145, 'Blankenham', 195, NULL, 19730101, '2023-05-10 09:16:54.569856');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (146, 'Blokzijl', 194, NULL, 19730101, '2023-05-10 09:16:54.571655');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (147, 'Borne', NULL, NULL, NULL, '2023-05-10 09:16:54.573807');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (148, 'Dalfsen', NULL, NULL, NULL, '2023-05-10 09:16:54.576005');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (149, 'Denekamp', 1774, NULL, 20020601, '2023-05-10 09:16:54.577795');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (150, 'Deventer', NULL, NULL, NULL, '2023-05-10 09:16:54.581477');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (151, 'Diepenheim', 1735, NULL, 20010101, '2023-05-10 09:16:54.583874');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (152, 'Diepenveen', 150, NULL, 19990101, '2023-05-10 09:16:54.585721');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (153, 'Enschede', NULL, NULL, NULL, '2023-05-10 09:16:54.587699');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (154, 'Genemuiden', 1896, NULL, 20010101, '2023-05-10 09:16:54.589274');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (155, 'Giethoorn', 194, NULL, 19730101, '2023-05-10 09:16:54.59057');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (156, 'Goor', 1735, NULL, 20010101, '2023-05-10 09:16:54.591764');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (157, 'Gramsbergen', 160, NULL, 20010101, '2023-05-10 09:16:54.593259');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (158, 'Haaksbergen', NULL, NULL, NULL, '2023-05-10 09:16:54.594706');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (159, 'Den Ham', 186, NULL, 20010101, '2023-05-10 09:16:54.595963');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (160, 'Hardenberg', NULL, 19410501, NULL, '2023-05-10 09:16:54.597243');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (161, 'Hasselt', 1896, NULL, 20010101, '2023-05-10 09:16:54.598501');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (162, 'Heino', 177, NULL, 20010101, '2023-05-10 09:16:54.600202');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (163, 'Hellendoorn', NULL, NULL, NULL, '2023-05-10 09:16:54.601449');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (164, 'Hengelo (O)', NULL, NULL, NULL, '2023-05-10 09:16:54.602675');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (165, 'Holten', 178, NULL, 20010101, '2023-05-10 09:16:54.604048');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (166, 'Kampen', NULL, NULL, NULL, '2023-05-10 09:16:54.605559');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (167, 'Kuinre', 195, NULL, 19730101, '2023-05-10 09:16:54.60758');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (168, 'Losser', NULL, NULL, NULL, '2023-05-10 09:16:54.615317');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (169, 'Markelo', 1735, NULL, 20010101, '2023-05-10 09:16:54.617411');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (170, 'Nieuwleusen', 148, NULL, 20010101, '2023-05-10 09:16:54.618777');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (171, 'Noordoostpolder', NULL, 19620701, NULL, '2023-05-10 09:16:54.620024');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (172, 'Oldemarkt', 195, NULL, 19730101, '2023-05-10 09:16:54.621783');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (173, 'Oldenzaal', NULL, NULL, NULL, '2023-05-10 09:16:54.622981');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (174, 'Olst', 1773, NULL, 20020326, '2023-05-10 09:16:54.624308');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (175, 'Ommen', NULL, 19230501, NULL, '2023-05-10 09:16:54.626551');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (176, 'Ootmarsum', 149, NULL, 20010101, '2023-05-10 09:16:54.628099');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (177, 'Raalte', NULL, NULL, NULL, '2023-05-10 09:16:54.6295');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (178, 'Rijssen', 1742, NULL, 20030315, '2023-05-10 09:16:54.630846');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (179, 'Stad Delden', 1735, NULL, 20010101, '2023-05-10 09:16:54.63298');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (180, 'Staphorst', NULL, NULL, NULL, '2023-05-10 09:16:54.634621');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (181, 'Steenwijk', 1708, NULL, 20030101, '2023-05-10 09:16:54.635766');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (182, 'Steenwijkerwold', 181, NULL, 19730101, '2023-05-10 09:16:54.63746');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (183, 'Tubbergen', NULL, NULL, NULL, '2023-05-10 09:16:54.639267');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (184, 'Urk', NULL, NULL, NULL, '2023-05-10 09:16:54.641079');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (185, 'Vollenhove', 194, 19420201, 19730101, '2023-05-10 09:16:54.642872');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (186, 'Vriezenveen', 1700, NULL, 20020601, '2023-05-10 09:16:54.644643');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (187, 'Wanneperveen', 194, NULL, 19730101, '2023-05-10 09:16:54.646358');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (188, 'Weerselo', 149, NULL, 20010101, '2023-05-10 09:16:54.648425');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (189, 'Wierden', NULL, NULL, NULL, '2023-05-10 09:16:54.65026');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (190, 'Wijhe', 174, NULL, 20010101, '2023-05-10 09:16:54.652095');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (191, 'IJsselmuiden', 166, NULL, 20010101, '2023-05-10 09:16:54.654141');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (192, 'Zwartsluis', 1896, NULL, 20010101, '2023-05-10 09:16:54.656288');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (193, 'Zwolle', NULL, NULL, NULL, '2023-05-10 09:16:54.657962');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (194, 'Brederwiede', 181, 19730101, 20010101, '2023-05-10 09:16:54.65997');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (195, 'IJsselham', 181, 19730101, 20010101, '2023-05-10 09:16:54.661682');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (196, 'Rijnwaarden', 299, 19850101, 20180101, '2023-05-10 09:16:54.663682');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (197, 'Aalten', NULL, NULL, NULL, '2023-05-10 09:16:54.665604');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (198, 'Ammerzoden', 263, NULL, 19990101, '2023-05-10 09:16:54.666822');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (199, 'Angerlo', 299, NULL, 20050101, '2023-05-10 09:16:54.668553');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (200, 'Apeldoorn', NULL, NULL, NULL, '2023-05-10 09:16:54.670288');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (201, 'Appeltern', 290, NULL, 19840101, '2023-05-10 09:16:54.672371');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (202, 'Arnhem', NULL, NULL, NULL, '2023-05-10 09:16:54.673706');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (203, 'Barneveld', NULL, NULL, NULL, '2023-05-10 09:16:54.674868');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (204, 'Batenburg', 296, NULL, 19840101, '2023-05-10 09:16:54.676288');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (205, 'Beesd', 236, NULL, 19780101, '2023-05-10 09:16:54.678009');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (206, 'Bemmel', 1705, NULL, 20030101, '2023-05-10 09:16:54.679757');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (207, 'Bergh', 1955, NULL, 20050101, '2023-05-10 09:16:54.681834');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (208, 'Bergharen', 296, NULL, 19840101, '2023-05-10 09:16:54.68342');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (209, 'Beuningen', NULL, NULL, NULL, '2023-05-10 09:16:54.684699');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (210, 'Beusichem', 214, NULL, 19780101, '2023-05-10 09:16:54.686063');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (211, 'Borculo', 1859, NULL, 20050101, '2023-05-10 09:16:54.687328');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (212, 'Brakel', 297, NULL, 19990101, '2023-05-10 09:16:54.688604');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (213, 'Brummen', NULL, NULL, NULL, '2023-05-10 09:16:54.689863');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (214, 'Buren', NULL, NULL, NULL, '2023-05-10 09:16:54.691018');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (215, 'Buurmalsen', 236, NULL, 19780101, '2023-05-10 09:16:54.692176');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (216, 'Culemborg', NULL, NULL, NULL, '2023-05-10 09:16:54.693377');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (217, 'Deil', 236, NULL, 19780101, '2023-05-10 09:16:54.694563');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (218, 'Didam', 1955, NULL, 20050101, '2023-05-10 09:16:54.695747');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (219, 'Dinxperlo', 197, NULL, 20050101, '2023-05-10 09:16:54.697178');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (220, 'Dodewaard', 258, NULL, 20020101, '2023-05-10 09:16:54.698298');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (221, 'Doesburg', NULL, NULL, NULL, '2023-05-10 09:16:54.699474');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (222, 'Doetinchem', NULL, 19200101, NULL, '2023-05-10 09:16:54.700605');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (223, 'Doornspijk', 230, NULL, 19740801, '2023-05-10 09:16:54.701774');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (224, 'Dreumel', 290, NULL, 19840101, '2023-05-10 09:16:54.703066');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (225, 'Druten', NULL, NULL, NULL, '2023-05-10 09:16:54.704441');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (226, 'Duiven', NULL, NULL, NULL, '2023-05-10 09:16:54.705702');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (227, 'Echteld', 258, NULL, 20020101, '2023-05-10 09:16:54.70686');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (228, 'Ede', NULL, NULL, NULL, '2023-05-10 09:16:54.707945');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (229, 'Eibergen', 1859, NULL, 20050101, '2023-05-10 09:16:54.709289');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (230, 'Elburg', NULL, NULL, NULL, '2023-05-10 09:16:54.710848');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (231, 'Elst', 1734, NULL, 20010101, '2023-05-10 09:16:54.76121');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (232, 'Epe', NULL, NULL, NULL, '2023-05-10 09:16:54.763038');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (233, 'Ermelo', NULL, NULL, NULL, '2023-05-10 09:16:54.764712');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (234, 'Est en Opijnen', 304, NULL, 19780101, '2023-05-10 09:16:54.765887');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (235, 'Ewijk', 209, NULL, 19800701, '2023-05-10 09:16:54.767424');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (236, 'Geldermalsen', 1960, NULL, 20190101, '2023-05-10 09:16:54.769269');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (237, 'Gendringen', 1509, NULL, 20050101, '2023-05-10 09:16:54.771102');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (238, 'Gendt', 206, NULL, 20010101, '2023-05-10 09:16:54.772791');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (239, 'Gorssel', 262, NULL, 20050101, '2023-05-10 09:16:54.774164');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (240, 'Groenlo', 1586, NULL, 20060519, '2023-05-10 09:16:54.775955');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (241, 'Groesbeek', 1945, NULL, 20160101, '2023-05-10 09:16:54.779949');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (242, 'Haaften', 304, NULL, 19780101, '2023-05-10 09:16:54.78325');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (243, 'Harderwijk', NULL, NULL, NULL, '2023-05-10 09:16:54.832816');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (244, 'Hattem', NULL, NULL, NULL, '2023-05-10 09:16:54.834931');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (245, 'Hedel', 263, NULL, 19990101, '2023-05-10 09:16:54.836685');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (246, 'Heerde', NULL, NULL, NULL, '2023-05-10 09:16:54.838059');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (247, 'Heerewaarden', 263, NULL, 19990101, '2023-05-10 09:16:54.839358');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (248, 'Hengelo (Gld)', 1876, NULL, 20050101, '2023-05-10 09:16:54.841342');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (249, 'Herwen en Aerdt', 196, NULL, 19850101, '2023-05-10 09:16:54.842981');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (250, 'Herwijnen', 287, NULL, 19860101, '2023-05-10 09:16:54.846091');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (251, 'Heteren', 1734, NULL, 20010101, '2023-05-10 09:16:54.848181');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (252, 'Heumen', NULL, NULL, NULL, '2023-05-10 09:16:54.850235');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (253, 'Hoevelaken', 267, NULL, 20000101, '2023-05-10 09:16:54.851972');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (254, 'Horssen', 225, NULL, 19840101, '2023-05-10 09:16:54.853674');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (255, 'Huissen', 206, NULL, 20010101, '2023-05-10 09:16:54.855061');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (256, 'Hummelo en Keppel', 1876, NULL, 20050101, '2023-05-10 09:16:54.857044');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (257, 'Kerkwijk', 297, NULL, 19990101, '2023-05-10 09:16:54.858589');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (258, 'Kesteren', 1740, NULL, 20030401, '2023-05-10 09:16:54.861286');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (259, 'Laren (Gld)', 262, NULL, 19710801, '2023-05-10 09:16:54.863431');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (260, 'Lichtenvoorde', 240, NULL, 20050101, '2023-05-10 09:16:54.865316');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (261, 'Lienden', 214, NULL, 19990101, '2023-05-10 09:16:54.867144');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (262, 'Lochem', NULL, NULL, NULL, '2023-05-10 09:16:54.868769');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (263, 'Maasdriel', NULL, 19440801, NULL, '2023-05-10 09:16:54.870034');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (264, 'Maurik', 214, NULL, 19990101, '2023-05-10 09:16:54.871314');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (265, 'Millingen aan de Rijn', 241, 19550101, 20150101, '2023-05-10 09:16:54.872637');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (266, 'Neede', 1859, NULL, 20050101, '2023-05-10 09:16:54.874088');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (267, 'Nijkerk', NULL, NULL, NULL, '2023-05-10 09:16:54.875419');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (268, 'Nijmegen', NULL, NULL, NULL, '2023-05-10 09:16:54.876916');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (269, 'Oldebroek', NULL, NULL, NULL, '2023-05-10 09:16:54.87818');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (270, 'Ophemert', 304, NULL, 19780101, '2023-05-10 09:16:54.879477');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (271, 'Overasselt', 252, NULL, 19800701, '2023-05-10 09:16:54.880594');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (272, 'Pannerden', 196, NULL, 19850101, '2023-05-10 09:16:54.881776');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (273, 'Putten', NULL, NULL, NULL, '2023-05-10 09:16:54.883073');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (274, 'Renkum', NULL, NULL, NULL, '2023-05-10 09:16:54.884346');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (275, 'Rheden', NULL, NULL, NULL, '2023-05-10 09:16:54.885503');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (276, 'Rossum', 263, NULL, 19990101, '2023-05-10 09:16:54.886707');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (277, 'Rozendaal', NULL, NULL, NULL, '2023-05-10 09:16:54.888037');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (278, 'Ruurlo', 1859, NULL, 20050101, '2023-05-10 09:16:54.889321');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (279, 'Scherpenzeel', NULL, NULL, NULL, '2023-05-10 09:16:54.89063');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (280, 'Steenderen', 1876, NULL, 20050101, '2023-05-10 09:16:54.89208');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (281, 'Tiel', NULL, NULL, NULL, '2023-05-10 09:16:54.893614');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (282, 'Ubbergen', 241, NULL, 20150101, '2023-05-10 09:16:54.895055');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (283, 'Valburg', 1734, NULL, 20010101, '2023-05-10 09:16:54.896581');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (284, 'Varik', 304, NULL, 19780101, '2023-05-10 09:16:54.898037');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (285, 'Voorst', NULL, NULL, NULL, '2023-05-10 09:16:54.899306');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (286, 'Vorden', 1876, NULL, 20050101, '2023-05-10 09:16:54.900623');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (287, 'Vuren', 733, NULL, 19870103, '2023-05-10 09:16:54.90252');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (288, 'Waardenburg', 304, NULL, 19780101, '2023-05-10 09:16:54.90538');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (289, 'Wageningen', NULL, NULL, NULL, '2023-05-10 09:16:54.907748');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (290, 'Wamel', 668, NULL, 19850701, '2023-05-10 09:16:54.910152');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (291, 'Warnsveld', 301, NULL, 20050101, '2023-05-10 09:16:54.912393');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (292, 'Wehl', 222, NULL, 20050101, '2023-05-10 09:16:54.914059');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (293, 'Westervoort', NULL, NULL, NULL, '2023-05-10 09:16:54.915539');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (294, 'Winterswijk', NULL, NULL, NULL, '2023-05-10 09:16:54.916861');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (295, 'Wisch', 1509, NULL, 20050101, '2023-05-10 09:16:54.918624');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (296, 'Wijchen', NULL, NULL, NULL, '2023-05-10 09:16:54.922479');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (297, 'Zaltbommel', NULL, NULL, NULL, '2023-05-10 09:16:54.926346');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (298, 'Zelhem', 1876, NULL, 20050101, '2023-05-10 09:16:54.928249');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (299, 'Zevenaar', NULL, NULL, NULL, '2023-05-10 09:16:54.93049');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (300, 'Zoelen', 214, NULL, 19780101, '2023-05-10 09:16:54.934549');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (301, 'Zutphen', NULL, NULL, NULL, '2023-05-10 09:16:54.936746');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (302, 'Nunspeet', NULL, 19720101, NULL, '2023-05-10 09:16:54.938128');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (303, 'Dronten', NULL, 19720101, NULL, '2023-05-10 09:16:54.939373');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (304, 'Neerijnen', 1960, 19780101, 20190101, '2023-05-10 09:16:54.940625');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (305, 'Abcoude', 736, 19410501, 20110101, '2023-05-10 09:16:54.942038');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (306, 'Amerongen', 1581, NULL, 20060101, '2023-05-10 09:16:54.943424');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (307, 'Amersfoort', NULL, NULL, NULL, '2023-05-10 09:16:54.946032');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (308, 'Baarn', NULL, NULL, NULL, '2023-05-10 09:16:54.950339');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (309, 'Benschop', 331, NULL, 19890101, '2023-05-10 09:16:54.952793');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (310, 'De Bilt', NULL, NULL, NULL, '2023-05-10 09:16:54.954239');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (311, 'Breukelen', 1904, 19490101, 20110101, '2023-05-10 09:16:54.955566');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (312, 'Bunnik', NULL, NULL, NULL, '2023-05-10 09:16:54.956747');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (313, 'Bunschoten', NULL, NULL, NULL, '2023-05-10 09:16:54.958033');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (314, 'Cothen', 352, NULL, 19960101, '2023-05-10 09:16:54.959299');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (315, 'Doorn', 1581, NULL, 20060101, '2023-05-10 09:16:54.961242');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (316, 'Driebergen-Rijsenburg', 1581, 19310501, 20060101, '2023-05-10 09:16:54.962707');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (317, 'Eemnes', NULL, NULL, NULL, '2023-05-10 09:16:54.96413');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (318, 'Harmelen', 632, NULL, 20010101, '2023-05-10 09:16:54.96529');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (319, 'Hoenkoop', 589, NULL, 19700901, '2023-05-10 09:16:54.966411');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (320, 'Hoogland', 307, NULL, 19740101, '2023-05-10 09:16:54.96762');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (321, 'Houten', NULL, NULL, NULL, '2023-05-10 09:16:54.968975');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (322, 'Jutphaas', 356, NULL, 19710701, '2023-05-10 09:16:54.970834');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (323, 'Kamerik', 632, NULL, 19890101, '2023-05-10 09:16:54.972234');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (324, 'Kockengen', 311, NULL, 19890101, '2023-05-10 09:16:54.973388');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (325, 'Langbroek', 352, NULL, 19960101, '2023-05-10 09:16:54.974593');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (326, 'Leersum', 1581, NULL, 20060101, '2023-05-10 09:16:54.975869');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (327, 'Leusden', NULL, NULL, NULL, '2023-05-10 09:16:54.977202');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (328, 'Linschoten', 335, NULL, 19890101, '2023-05-10 09:16:54.978355');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (329, 'Loenen', 1904, NULL, 20110101, '2023-05-10 09:16:54.979857');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (330, 'Loosdrecht', 1696, NULL, 20020101, '2023-05-10 09:16:54.981115');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (331, 'Lopik', NULL, NULL, NULL, '2023-05-10 09:16:54.98233');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (332, 'Maarn', 1581, NULL, 20060101, '2023-05-10 09:16:54.983535');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (333, 'Maarssen', 1904, NULL, 20110101, '2023-05-10 09:16:54.984938');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (334, 'Maartensdijk', 310, NULL, 20010101, '2023-05-10 09:16:54.986204');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (335, 'Montfoort', NULL, NULL, NULL, '2023-05-10 09:16:54.987387');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (336, 'Mijdrecht', 736, NULL, 19890101, '2023-05-10 09:16:54.988459');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (337, 'Nigtevecht', 329, NULL, 19890101, '2023-05-10 09:16:54.989635');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (338, 'Polsbroek', 331, 18570613, 19890101, '2023-05-10 09:16:54.99073');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (339, 'Renswoude', NULL, NULL, NULL, '2023-05-10 09:16:54.991937');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (340, 'Rhenen', NULL, NULL, NULL, '2023-05-10 09:16:54.993335');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (341, 'Snelrewaard', 589, NULL, 19890101, '2023-05-10 09:16:54.994795');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (342, 'Soest', NULL, NULL, NULL, '2023-05-10 09:16:54.996143');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (343, 'Stoutenburg', 327, NULL, 19690601, '2023-05-10 09:16:54.997327');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (344, 'Utrecht', NULL, NULL, NULL, '2023-05-10 09:16:54.99848');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (345, 'Veenendaal', NULL, NULL, NULL, '2023-05-10 09:16:54.999659');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (346, 'Vinkeveen en Waverveen', 736, 18410101, 19890101, '2023-05-10 09:16:55.00104');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (347, 'Vleuten-De Meern', 344, 19540101, 20010101, '2023-05-10 09:16:55.002217');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (348, 'Vreeswijk', 356, NULL, 19710701, '2023-05-10 09:16:55.003337');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (349, 'Willeskop', 335, NULL, 19890101, '2023-05-10 09:16:55.004488');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (350, 'Wilnis', 736, NULL, 19890101, '2023-05-10 09:16:55.005683');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (351, 'Woudenberg', NULL, NULL, NULL, '2023-05-10 09:16:55.007161');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (352, 'Wijk bij Duurstede', NULL, NULL, NULL, '2023-05-10 09:16:55.008459');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (353, 'IJsselstein', NULL, NULL, NULL, '2023-05-10 09:16:55.010315');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (354, 'Zegveld', 632, NULL, 19890101, '2023-05-10 09:16:55.011699');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (355, 'Zeist', NULL, NULL, NULL, '2023-05-10 09:16:55.012917');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (356, 'Nieuwegein', NULL, 19710701, NULL, '2023-05-10 09:16:55.01416');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (357, 'Egmond', 373, 19780701, 20010101, '2023-05-10 09:16:55.015336');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (358, 'Aalsmeer', NULL, NULL, NULL, '2023-05-10 09:16:55.01662');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (359, 'Abbekerk', 529, NULL, 19790101, '2023-05-10 09:16:55.017747');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (360, 'Akersloot', 383, NULL, 20020101, '2023-05-10 09:16:55.019109');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (361, 'Alkmaar', NULL, NULL, NULL, '2023-05-10 09:16:55.020241');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (362, 'Amstelveen', NULL, 19640101, NULL, '2023-05-10 09:16:55.070387');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (363, 'Amsterdam', NULL, NULL, NULL, '2023-05-10 09:16:55.0716');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (364, 'Andijk', 420, NULL, 20110101, '2023-05-10 09:16:55.072841');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (365, 'Graft-De Rijp', 361, 19700801, 20150101, '2023-05-10 09:16:55.074346');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (366, 'Anna Paulowna', 1911, 18700718, 20120101, '2023-05-10 09:16:55.075546');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (367, 'Assendelft', 479, NULL, 19740101, '2023-05-10 09:16:55.07698');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (368, 'Avenhorn', 558, NULL, 19790101, '2023-05-10 09:16:55.078403');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (369, 'Barsingerhorn', 412, NULL, 19900101, '2023-05-10 09:16:55.080039');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (370, 'Beemster', 439, NULL, 20220101, '2023-05-10 09:16:55.081313');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (371, 'Beets', 478, NULL, 19700801, '2023-05-10 09:16:55.082448');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (372, 'Bennebroek', 377, NULL, 20090101, '2023-05-10 09:16:55.083746');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (373, 'Bergen (NH)', NULL, NULL, NULL, '2023-05-10 09:16:55.085');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (374, 'Berkhout', 558, NULL, 19790101, '2023-05-10 09:16:55.086369');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (375, 'Beverwijk', NULL, NULL, NULL, '2023-05-10 09:16:55.087647');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (376, 'Blaricum', NULL, NULL, NULL, '2023-05-10 09:16:55.088849');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (377, 'Bloemendaal', NULL, NULL, NULL, '2023-05-10 09:16:55.090394');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (378, 'Blokker', 405, NULL, 19790101, '2023-05-10 09:16:55.091852');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (379, 'Bovenkarspel', 532, NULL, 19790101, '2023-05-10 09:16:55.093727');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (380, 'Broek in Waterland', 852, NULL, 19910101, '2023-05-10 09:16:55.095304');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (381, 'Bussum', 1942, NULL, 20160101, '2023-05-10 09:16:55.096924');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (382, 'Callantsoog', 476, NULL, 19900101, '2023-05-10 09:16:55.098597');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (383, 'Castricum', NULL, NULL, NULL, '2023-05-10 09:16:55.100479');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (384, 'Diemen', NULL, NULL, NULL, '2023-05-10 09:16:55.102122');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (385, 'Edam-Volendam', NULL, 19750101, NULL, '2023-05-10 09:16:55.103583');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (386, 'Egmond aan Zee', 357, NULL, 19780701, '2023-05-10 09:16:55.104946');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (387, 'Egmond-Binnen', 357, NULL, 19780701, '2023-05-10 09:16:55.106477');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (388, 'Enkhuizen', NULL, NULL, NULL, '2023-05-10 09:16:55.107854');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (389, 'Graft', 365, NULL, 19700801, '2023-05-10 09:16:55.109041');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (390, '''s-Graveland', 1696, NULL, 20020101, '2023-05-10 09:16:55.110528');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (391, 'Grootebroek', 532, NULL, 19790101, '2023-05-10 09:16:55.111904');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (392, 'Haarlem', NULL, NULL, NULL, '2023-05-10 09:16:55.113167');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (393, 'Haarlemmerliede en Spaarnwoude', 394, 18570101, 20190101, '2023-05-10 09:16:55.114362');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (394, 'Haarlemmermeer', NULL, 18550101, NULL, '2023-05-10 09:16:55.115528');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (395, 'Harenkarspel', 441, NULL, 20130101, '2023-05-10 09:16:55.116629');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (396, 'Heemskerk', NULL, NULL, NULL, '2023-05-10 09:16:55.117842');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (397, 'Heemstede', NULL, NULL, NULL, '2023-05-10 09:16:55.119223');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (398, 'Heerhugowaard', 1980, NULL, 20220101, '2023-05-10 09:16:55.120501');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (399, 'Heiloo', NULL, NULL, NULL, '2023-05-10 09:16:55.171527');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (400, 'Den Helder', NULL, NULL, NULL, '2023-05-10 09:16:55.173227');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (401, 'Hensbroek', 429, NULL, 19790101, '2023-05-10 09:16:55.174691');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (402, 'Hilversum', NULL, NULL, NULL, '2023-05-10 09:16:55.175976');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (403, 'Hoogkarspel', 1246, NULL, 19790101, '2023-05-10 09:16:55.17794');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (404, 'Hoogwoud', 432, NULL, 19790101, '2023-05-10 09:16:55.18181');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (405, 'Hoorn', NULL, NULL, NULL, '2023-05-10 09:16:55.183498');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (406, 'Huizen', NULL, NULL, NULL, '2023-05-10 09:16:55.185711');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (407, 'Ilpendam', 415, NULL, 19910101, '2023-05-10 09:16:55.187608');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (408, 'Jisp', 880, NULL, 19910101, '2023-05-10 09:16:55.189665');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (409, 'Katwoude', 852, NULL, 19910101, '2023-05-10 09:16:55.191085');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (410, 'Koedijk', 446, NULL, 19721001, '2023-05-10 09:16:55.192296');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (411, 'Koog aan de Zaan', 479, NULL, 19740101, '2023-05-10 09:16:55.194136');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (412, 'Niedorp', 1911, 19700801, 20120101, '2023-05-10 09:16:55.197689');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (413, 'Krommenie', 479, NULL, 19740101, '2023-05-10 09:16:55.201448');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (414, 'Kwadijk', 478, NULL, 19700801, '2023-05-10 09:16:55.203034');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (415, 'Landsmeer', NULL, NULL, NULL, '2023-05-10 09:16:55.204299');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (416, 'Langedijk', 1980, 19410801, 20220101, '2023-05-10 09:16:55.205499');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (417, 'Laren', NULL, NULL, NULL, '2023-05-10 09:16:55.206688');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (418, 'Limmen', 383, NULL, 20020101, '2023-05-10 09:16:55.207828');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (419, 'Marken', 852, NULL, 19910101, '2023-05-10 09:16:55.209093');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (420, 'Medemblik', NULL, NULL, NULL, '2023-05-10 09:16:55.211134');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (421, 'Middelie', 478, NULL, 19700801, '2023-05-10 09:16:55.214663');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (422, 'Midwoud', 529, NULL, 19790101, '2023-05-10 09:16:55.218463');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (423, 'Monnickendam', 852, NULL, 19910101, '2023-05-10 09:16:55.220102');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (424, 'Muiden', 1942, NULL, 20160101, '2023-05-10 09:16:55.221485');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (425, 'Naarden', 1942, NULL, 20160101, '2023-05-10 09:16:55.222999');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (426, 'Nederhorst den Berg', 1696, NULL, 20020101, '2023-05-10 09:16:55.224352');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (427, 'Nibbixwoud', 466, NULL, 19790101, '2023-05-10 09:16:55.225555');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (428, 'Nieuwe Niedorp', 412, NULL, 19700801, '2023-05-10 09:16:55.227559');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (429, 'Obdam', 1598, NULL, 20070101, '2023-05-10 09:16:55.231104');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (430, 'Oosthuizen', 478, NULL, 19700801, '2023-05-10 09:16:55.234378');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (431, 'Oostzaan', NULL, NULL, NULL, '2023-05-10 09:16:55.235747');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (432, 'Opmeer', NULL, NULL, NULL, '2023-05-10 09:16:55.236969');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (433, 'Opperdoes', 529, NULL, 19790101, '2023-05-10 09:16:55.238147');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (434, 'Oterleek', 458, NULL, 19700801, '2023-05-10 09:16:55.239283');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (435, 'Oudendijk', 558, NULL, 19790101, '2023-05-10 09:16:55.240464');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (436, 'Oude Niedorp', 412, NULL, 19700801, '2023-05-10 09:16:55.241648');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (437, 'Ouder-Amstel', NULL, NULL, NULL, '2023-05-10 09:16:55.243048');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (438, 'Oudorp', 361, NULL, 19721001, '2023-05-10 09:16:55.245253');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (439, 'Purmerend', NULL, NULL, NULL, '2023-05-10 09:16:55.247042');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (440, 'De Rijp', 365, NULL, 19700801, '2023-05-10 09:16:55.248636');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (441, 'Schagen', NULL, NULL, NULL, '2023-05-10 09:16:55.250246');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (442, 'Schellinkhout', 454, NULL, 19700801, '2023-05-10 09:16:55.251423');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (443, 'Schermerhorn', 458, NULL, 19700801, '2023-05-10 09:16:55.25257');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (444, 'Schoorl', 373, NULL, 20010101, '2023-05-10 09:16:55.253734');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (445, 'Sint Maarten', 395, NULL, 19900101, '2023-05-10 09:16:55.254897');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (446, 'Sint Pancras', 416, NULL, 19900101, '2023-05-10 09:16:55.256074');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (447, 'Sijbekarspel', 529, NULL, 19790101, '2023-05-10 09:16:55.25724');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (448, 'Texel', NULL, NULL, NULL, '2023-05-10 09:16:55.258397');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (449, 'Twisk', 529, NULL, 19790101, '2023-05-10 09:16:55.259909');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (450, 'Uitgeest', NULL, NULL, NULL, '2023-05-10 09:16:55.261797');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (451, 'Uithoorn', NULL, NULL, NULL, '2023-05-10 09:16:55.263757');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (452, 'Ursem', 558, NULL, 19790101, '2023-05-10 09:16:55.265473');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (453, 'Velsen', NULL, NULL, NULL, '2023-05-10 09:16:55.267052');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (454, 'Venhuizen', 498, NULL, 20060101, '2023-05-10 09:16:55.268312');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (455, 'Warder', 478, NULL, 19700801, '2023-05-10 09:16:55.269494');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (456, 'Warmenhuizen', 395, NULL, 19900101, '2023-05-10 09:16:55.270794');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (457, 'Weesp', 363, NULL, 20220324, '2023-05-10 09:16:55.272018');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (458, 'Schermer', 361, 19700801, 20150101, '2023-05-10 09:16:55.273202');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (459, 'Wervershoof', 420, NULL, 20110101, '2023-05-10 09:16:55.274362');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (460, 'Westwoud', 1246, NULL, 19790101, '2023-05-10 09:16:55.275578');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (461, 'Westzaan', 479, NULL, 19740101, '2023-05-10 09:16:55.27682');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (462, 'Wieringen', 1911, NULL, 20120101, '2023-05-10 09:16:55.278059');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (463, 'Wieringermeer', 1911, 19380101, 20120101, '2023-05-10 09:16:55.279334');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (464, 'Wieringerwaard', 369, NULL, 19700801, '2023-05-10 09:16:55.280656');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (465, 'Winkel', 412, NULL, 19700801, '2023-05-10 09:16:55.281848');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (466, 'Wognum', 420, NULL, 20070101, '2023-05-10 09:16:55.283251');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (467, 'Wormer', 880, NULL, 19910101, '2023-05-10 09:16:55.284504');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (468, 'Wormerveer', 479, NULL, 19740101, '2023-05-10 09:16:55.285713');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (469, 'Wijdenes', 454, NULL, 19700801, '2023-05-10 09:16:55.287036');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (470, 'Wijdewormer', 880, NULL, 19910101, '2023-05-10 09:16:55.288361');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (471, 'Zaandam', 479, NULL, 19740101, '2023-05-10 09:16:55.289515');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (472, 'Zaandijk', 479, NULL, 19740101, '2023-05-10 09:16:55.290785');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (473, 'Zandvoort', NULL, NULL, NULL, '2023-05-10 09:16:55.292057');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (474, 'Zuid- en Noord-Schermer', 458, NULL, 19700801, '2023-05-10 09:16:55.293211');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (475, 'Zwaag', 405, NULL, 19790101, '2023-05-10 09:16:55.294436');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (476, 'Zijpe', 441, NULL, 20130101, '2023-05-10 09:16:55.295542');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (477, 'Albrandswaard (oud)', 592, NULL, 18410901, '2023-05-10 09:16:55.296764');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (478, 'Zeevang', 385, 19700801, 20160101, '2023-05-10 09:16:55.297929');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (479, 'Zaanstad', NULL, 19740101, NULL, '2023-05-10 09:16:55.299107');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (480, 'Ter Aar', 569, NULL, 20070101, '2023-05-10 09:16:55.300294');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (481, 'Abbenbroek', 568, NULL, 19800101, '2023-05-10 09:16:55.352057');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (482, 'Alblasserdam', NULL, NULL, NULL, '2023-05-10 09:16:55.353879');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (483, 'Alkemade', 1884, NULL, 20090101, '2023-05-10 09:16:55.355161');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (484, 'Alphen aan den Rijn', NULL, 19180101, NULL, '2023-05-10 09:16:55.356452');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (485, 'Ameide', 707, NULL, 19860101, '2023-05-10 09:16:55.357914');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (486, 'Ammerstol', 491, NULL, 19850101, '2023-05-10 09:16:55.359304');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (487, 'Arkel', 689, NULL, 19860101, '2023-05-10 09:16:55.36058');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (488, 'Asperen', 287, NULL, 19860101, '2023-05-10 09:16:55.361829');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (489, 'Barendrecht', NULL, 18860101, NULL, '2023-05-10 09:16:55.362984');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (490, 'Benthuizen', 646, NULL, 19910101, '2023-05-10 09:16:55.364214');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (491, 'Bergambacht', 1931, NULL, 20150101, '2023-05-10 09:16:55.365384');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (492, 'Bergschenhoek', 1621, NULL, 20070101, '2023-05-10 09:16:55.366537');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (493, 'Berkel en Rodenrijs', 1621, NULL, 20070101, '2023-05-10 09:16:55.367667');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (494, 'Berkenwoude', 491, NULL, 19850101, '2023-05-10 09:16:55.368725');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (495, 'Bleiswijk', 1621, NULL, 20070101, '2023-05-10 09:16:55.3699');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (496, 'Bleskensgraaf en Hofwegen', 693, NULL, 19860101, '2023-05-10 09:16:55.371077');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (497, 'Bodegraven', 1901, NULL, 20110101, '2023-05-10 09:16:55.372227');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (498, 'Drechterland', NULL, 19800101, NULL, '2023-05-10 09:16:55.373454');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (499, 'Boskoop', 484, NULL, 20140101, '2023-05-10 09:16:55.374623');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (500, 'Brandwijk', 693, NULL, 19860101, '2023-05-10 09:16:55.3758');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (501, 'Brielle', NULL, NULL, NULL, '2023-05-10 09:16:55.37704');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (502, 'Capelle aan den IJssel', NULL, NULL, NULL, '2023-05-10 09:16:55.378276');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (503, 'Delft', NULL, NULL, NULL, '2023-05-10 09:16:55.379489');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (504, 'Dirksland', 1924, NULL, 20130101, '2023-05-10 09:16:55.380637');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (505, 'Dordrecht', NULL, NULL, NULL, '2023-05-10 09:16:55.381862');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (506, 'Driebruggen', 595, 19640201, 19890101, '2023-05-10 09:16:55.382977');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (507, 'Dubbeldam', 505, NULL, 19700701, '2023-05-10 09:16:55.384143');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (508, 'Everdingen', 620, NULL, 19860101, '2023-05-10 09:16:55.38537');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (509, 'Geervliet', 568, NULL, 19800101, '2023-05-10 09:16:55.386453');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (510, 'Giessenburg', 689, 19570101, 19860101, '2023-05-10 09:16:55.38762');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (511, 'Goedereede', 1924, NULL, 20130101, '2023-05-10 09:16:55.388809');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (512, 'Gorinchem', NULL, NULL, NULL, '2023-05-10 09:16:55.390011');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (513, 'Gouda', NULL, NULL, NULL, '2023-05-10 09:16:55.391141');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (514, 'Gouderak', 644, NULL, 19850101, '2023-05-10 09:16:55.392213');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (515, 'Goudriaan', 693, NULL, 19860101, '2023-05-10 09:16:55.393395');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (516, 'Goudswaard', 588, NULL, 19840101, '2023-05-10 09:16:55.394535');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (517, '''s-Gravendeel', 585, NULL, 20070101, '2023-05-10 09:16:55.39569');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (518, '''s-Gravenhage', NULL, NULL, NULL, '2023-05-10 09:16:55.396805');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (519, '''s-Gravenzande', 1783, NULL, 20040101, '2023-05-10 09:16:55.397965');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (520, 'Groot-Ammers', 694, NULL, 19860101, '2023-05-10 09:16:55.399109');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (521, 'Haastrecht', 623, NULL, 19850101, '2023-05-10 09:16:55.400193');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (522, 'Hagestein', 620, NULL, 19860101, '2023-05-10 09:16:55.452007');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (523, 'Hardinxveld-Giessendam', NULL, 19570101, NULL, '2023-05-10 09:16:55.453681');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (524, 'Hazerswoude', 646, NULL, 19910101, '2023-05-10 09:16:55.455157');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (525, 'Heenvliet', 568, NULL, 19800101, '2023-05-10 09:16:55.456621');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (526, 'Heerjansdam', 642, NULL, 20030101, '2023-05-10 09:16:55.458184');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (527, 'Hei- en Boeicop', 707, NULL, 19860101, '2023-05-10 09:16:55.459396');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (528, 'Heinenoord', 585, NULL, 19840101, '2023-05-10 09:16:55.460774');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (529, 'Noorder-Koggenland', 420, 19790101, 20070101, '2023-05-10 09:16:55.461978');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (530, 'Hellevoetsluis', NULL, NULL, NULL, '2023-05-10 09:16:55.463202');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (531, 'Hendrik-Ido-Ambacht', NULL, NULL, NULL, '2023-05-10 09:16:55.464367');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (532, 'Stede Broec', NULL, 19790101, NULL, '2023-05-10 09:16:55.465575');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (533, 'Heukelum', 287, NULL, 19860101, '2023-05-10 09:16:55.466727');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (534, 'Hillegom', NULL, NULL, NULL, '2023-05-10 09:16:55.468139');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (535, 'Hoogblokland', 689, NULL, 19860101, '2023-05-10 09:16:55.46934');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (536, 'Hoornaar', 689, NULL, 19860101, '2023-05-10 09:16:55.470721');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (537, 'Katwijk', NULL, NULL, NULL, '2023-05-10 09:16:55.471958');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (538, 'Kedichem', 545, NULL, 19860101, '2023-05-10 09:16:55.473399');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (539, 'Klaaswaal', 611, NULL, 19840101, '2023-05-10 09:16:55.474604');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (540, 'Koudekerk aan den Rijn', 646, NULL, 19910101, '2023-05-10 09:16:55.475792');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (541, 'Krimpen aan de Lek', 643, NULL, 19850101, '2023-05-10 09:16:55.477048');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (542, 'Krimpen aan den IJssel', NULL, NULL, NULL, '2023-05-10 09:16:55.478317');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (543, 'Langerak', 694, NULL, 19860101, '2023-05-10 09:16:55.479488');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (544, 'Leerbroek', 707, NULL, 19860101, '2023-05-10 09:16:55.480771');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (545, 'Leerdam', 1961, NULL, 20190101, '2023-05-10 09:16:55.481982');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (546, 'Leiden', NULL, NULL, NULL, '2023-05-10 09:16:55.483358');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (547, 'Leiderdorp', NULL, NULL, NULL, '2023-05-10 09:16:55.484977');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (548, 'Leidschendam', 1916, 19380101, 20020101, '2023-05-10 09:16:55.486586');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (549, 'Leimuiden', 645, NULL, 19910101, '2023-05-10 09:16:55.488108');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (550, 'Lekkerkerk', 643, NULL, 19850101, '2023-05-10 09:16:55.489712');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (551, 'Lexmond', 707, NULL, 19860101, '2023-05-10 09:16:55.491044');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (552, 'De Lier', 1783, NULL, 20040101, '2023-05-10 09:16:55.492358');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (553, 'Lisse', NULL, NULL, NULL, '2023-05-10 09:16:55.493619');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (554, 'Maasdam', 585, NULL, 19840101, '2023-05-10 09:16:55.495069');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (555, 'Maasland', 1842, NULL, 20040101, '2023-05-10 09:16:55.496253');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (556, 'Maassluis', NULL, NULL, NULL, '2023-05-10 09:16:55.497466');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (557, 'Meerkerk', 707, NULL, 19860101, '2023-05-10 09:16:55.498792');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (558, 'Wester-Koggenland', 1598, 19790101, 20070101, '2023-05-10 09:16:55.50053');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (559, 'Middelharnis', 1924, NULL, 20130101, '2023-05-10 09:16:55.502094');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (560, 'Moerkapelle', 647, NULL, 19910101, '2023-05-10 09:16:55.503478');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (561, 'Molenaarsgraaf', 693, NULL, 19860101, '2023-05-10 09:16:55.504753');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (562, 'Monster', 1783, NULL, 20040101, '2023-05-10 09:16:55.505989');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (563, 'Moordrecht', 1892, NULL, 20100101, '2023-05-10 09:16:55.507408');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (564, 'Mijnsheerenland', 585, NULL, 19840101, '2023-05-10 09:16:55.508724');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (565, 'Naaldwijk', 1783, NULL, 20040101, '2023-05-10 09:16:55.509977');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (566, 'Nieuw-Beijerland', 588, NULL, 19840101, '2023-05-10 09:16:55.511315');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (567, 'Nieuwerkerk aan den IJssel', 1892, NULL, 20100101, '2023-05-10 09:16:55.512541');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (568, 'Bernisse', 1930, 19800101, 20150101, '2023-05-10 09:16:55.513769');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (569, 'Nieuwkoop', NULL, NULL, NULL, '2023-05-10 09:16:55.515088');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (570, 'Nieuwland', 707, NULL, 19860101, '2023-05-10 09:16:55.516377');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (571, 'Nieuw-Lekkerland', 1927, NULL, 20130101, '2023-05-10 09:16:55.51769');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (572, 'Nieuwpoort', 694, NULL, 19860101, '2023-05-10 09:16:55.519054');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (573, 'Nieuwveen', 1673, NULL, 19940101, '2023-05-10 09:16:55.520197');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (574, 'Noordeloos', 689, NULL, 19860101, '2023-05-10 09:16:55.521338');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (575, 'Noordwijk', NULL, NULL, NULL, '2023-05-10 09:16:55.522513');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (576, 'Noordwijkerhout', 575, NULL, 20190101, '2023-05-10 09:16:55.523761');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (577, 'Nootdorp', 1926, NULL, 20020101, '2023-05-10 09:16:55.525023');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (578, 'Numansdorp', 611, NULL, 19840101, '2023-05-10 09:16:55.526325');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (579, 'Oegstgeest', NULL, NULL, NULL, '2023-05-10 09:16:55.527512');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (580, 'Oostflakkee', 1924, 19660101, 20130101, '2023-05-10 09:16:55.528693');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (581, 'Oostvoorne', 614, NULL, 19800101, '2023-05-10 09:16:55.529819');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (582, 'Ottoland', 693, NULL, 19860101, '2023-05-10 09:16:55.531347');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (583, 'Oud-Alblas', 693, NULL, 19860101, '2023-05-10 09:16:55.532631');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (584, 'Oud-Beijerland', 1963, NULL, 20190101, '2023-05-10 09:16:55.533859');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (585, 'Binnenmaas', 1963, 19840101, 20190101, '2023-05-10 09:16:55.535035');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (586, 'Oudenhoorn', 568, NULL, 19800101, '2023-05-10 09:16:55.536233');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (587, 'Ouderkerk aan den IJssel', 644, NULL, 19850101, '2023-05-10 09:16:55.537384');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (588, 'Korendijk', 1963, 19840101, 20190101, '2023-05-10 09:16:55.538798');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (589, 'Oudewater', NULL, NULL, NULL, '2023-05-10 09:16:55.539998');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (590, 'Papendrecht', NULL, NULL, NULL, '2023-05-10 09:16:55.541209');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (591, 'Piershil', 588, NULL, 19840101, '2023-05-10 09:16:55.542377');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (592, 'Poortugaal', 613, NULL, 19850101, '2023-05-10 09:16:55.543598');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (593, 'Puttershoek', 585, NULL, 19840101, '2023-05-10 09:16:55.544806');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (594, 'Pijnacker', 1926, NULL, 20020101, '2023-05-10 09:16:55.545937');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (595, 'Reeuwijk', 1901, NULL, 20110101, '2023-05-10 09:16:55.547417');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (596, 'Rhoon', 613, NULL, 19850101, '2023-05-10 09:16:55.548624');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (597, 'Ridderkerk', NULL, NULL, NULL, '2023-05-10 09:16:55.549832');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (598, 'Rockanje', 614, NULL, 19800101, '2023-05-10 09:16:55.550977');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (599, 'Rotterdam', NULL, NULL, NULL, '2023-05-10 09:16:55.552074');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (600, 'Rozenburg', 599, NULL, 20100318, '2023-05-10 09:16:55.553284');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (601, 'Rijnsaterwoude', 645, NULL, 19910101, '2023-05-10 09:16:55.55443');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (602, 'Rijnsburg', 537, NULL, 20060101, '2023-05-10 09:16:55.55564');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (603, 'Rijswijk', NULL, NULL, NULL, '2023-05-10 09:16:55.556837');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (604, 'Sassenheim', 1525, NULL, 20060101, '2023-05-10 09:16:55.558143');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (605, 'Schelluinen', 689, NULL, 19860101, '2023-05-10 09:16:55.559337');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (606, 'Schiedam', NULL, NULL, NULL, '2023-05-10 09:16:55.560696');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (607, 'Schipluiden', 1842, NULL, 20040101, '2023-05-10 09:16:55.561869');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (608, 'Schoonhoven', 1931, NULL, 20150101, '2023-05-10 09:16:55.563212');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (609, 'Schoonrewoerd', 545, NULL, 19860101, '2023-05-10 09:16:55.56472');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (610, 'Sliedrecht', NULL, NULL, NULL, '2023-05-10 09:16:55.566138');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (611, 'Cromstrijen', 1963, 19840101, 20190101, '2023-05-10 09:16:55.567663');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (612, 'Spijkenisse', 1930, NULL, 20150101, '2023-05-10 09:16:55.569075');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (613, 'Albrandswaard', NULL, 19850101, NULL, '2023-05-10 09:16:55.570259');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (614, 'Westvoorne', NULL, 19800101, NULL, '2023-05-10 09:16:55.620884');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (615, 'Stolwijk', 623, NULL, 19850101, '2023-05-10 09:16:55.622233');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (616, 'Streefkerk', 694, NULL, 19860101, '2023-05-10 09:16:55.623433');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (617, 'Strijen', 1963, NULL, 20190101, '2023-05-10 09:16:55.624633');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (618, 'Tienhoven (ZH)', 707, NULL, 19860101, '2023-05-10 09:16:55.626002');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (619, 'Valkenburg (ZH)', 537, NULL, 20060101, '2023-05-10 09:16:55.627634');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (620, 'Vianen', 1961, NULL, 20190101, '2023-05-10 09:16:55.629041');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (621, 'Vierpolders', 501, NULL, 19800101, '2023-05-10 09:16:55.63033');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (622, 'Vlaardingen', NULL, NULL, NULL, '2023-05-10 09:16:55.63154');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (623, 'Vlist', 1931, NULL, 20150101, '2023-05-10 09:16:55.632782');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (624, 'Voorburg', 1916, NULL, 20020101, '2023-05-10 09:16:55.634021');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (625, 'Voorhout', 1525, NULL, 20060101, '2023-05-10 09:16:55.635157');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (626, 'Voorschoten', NULL, NULL, NULL, '2023-05-10 09:16:55.636352');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (627, 'Waddinxveen', NULL, 18700701, NULL, '2023-05-10 09:16:55.63747');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (628, 'Warmond', 1525, NULL, 20060101, '2023-05-10 09:16:55.638757');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (629, 'Wassenaar', NULL, NULL, NULL, '2023-05-10 09:16:55.639951');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (630, 'Wateringen', 1783, NULL, 20040101, '2023-05-10 09:16:55.6411');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (631, 'Westmaas', 585, NULL, 19840101, '2023-05-10 09:16:55.642485');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (632, 'Woerden', NULL, NULL, NULL, '2023-05-10 09:16:55.644213');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (633, 'Woubrugge', 645, NULL, 19910101, '2023-05-10 09:16:55.645702');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (634, 'Wijngaarden', 693, NULL, 19860101, '2023-05-10 09:16:55.64718');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (635, 'Zevenhoven', 573, NULL, 19910101, '2023-05-10 09:16:55.648599');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (636, 'Zevenhuizen', 647, NULL, 19910101, '2023-05-10 09:16:55.649868');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (637, 'Zoetermeer', NULL, NULL, NULL, '2023-05-10 09:16:55.651122');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (638, 'Zoeterwoude', NULL, NULL, NULL, '2023-05-10 09:16:55.652216');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (639, 'Zuid-Beijerland', 588, NULL, 19840101, '2023-05-10 09:16:55.653326');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (640, 'Zuidland', 568, NULL, 19800101, '2023-05-10 09:16:55.654503');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (641, 'Zwartewaal', 501, NULL, 19800101, '2023-05-10 09:16:55.655767');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (642, 'Zwijndrecht', NULL, NULL, NULL, '2023-05-10 09:16:55.656934');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (643, 'Nederlek', 1931, 19850101, 20150101, '2023-05-10 09:16:55.658119');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (644, 'Ouderkerk', 1931, 19850101, 20150101, '2023-05-10 09:16:55.659362');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (645, 'Jacobswoude', 1884, 19910101, 20090101, '2023-05-10 09:16:55.660649');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (646, 'Rijneveld', 1672, 19910101, 19930101, '2023-05-10 09:16:55.661855');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (647, 'Moerhuizen', 1666, 19910101, 19920201, '2023-05-10 09:16:55.663074');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (648, 'Aardenburg', 1698, NULL, 19950101, '2023-05-10 09:16:55.664389');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (649, 'Arnemuiden', 687, NULL, 19970101, '2023-05-10 09:16:55.665527');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (650, 'Axel', 715, NULL, 20030101, '2023-05-10 09:16:55.666785');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (651, 'Baarland', 654, NULL, 19700101, '2023-05-10 09:16:55.667967');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (652, 'Biervliet', 715, NULL, 19700401, '2023-05-10 09:16:55.669318');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (653, 'Gaasterlân-Sleat', 1921, 19850605, 20140101, '2023-05-10 09:16:55.670543');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (654, 'Borsele', NULL, 19700101, NULL, '2023-05-10 09:16:55.671767');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (655, 'Breskens', 692, NULL, 19700401, '2023-05-10 09:16:55.673026');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (656, 'Brouwershaven', 1676, NULL, 19970101, '2023-05-10 09:16:55.674254');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (657, 'Bruinisse', 1676, NULL, 19970101, '2023-05-10 09:16:55.676393');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (658, 'Cadzand', 692, NULL, 19700401, '2023-05-10 09:16:55.677775');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (659, 'Clinge', 677, NULL, 19700401, '2023-05-10 09:16:55.679161');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (660, 'Domburg', 717, NULL, 19970101, '2023-05-10 09:16:55.680338');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (661, 'Driewegen', 654, NULL, 19700101, '2023-05-10 09:16:55.731537');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (662, 'Duiveland', 1676, 19610101, 19970101, '2023-05-10 09:16:55.733174');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (663, 'Ellewoutsdijk', 654, NULL, 19700101, '2023-05-10 09:16:55.735371');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (664, 'Goes', NULL, NULL, NULL, '2023-05-10 09:16:55.736821');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (665, 'Graauw en Langendam', 677, NULL, 19700401, '2023-05-10 09:16:55.738311');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (666, '''s-Gravenpolder', 654, NULL, 19700101, '2023-05-10 09:16:55.739997');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (667, 'Groede', 692, NULL, 19700401, '2023-05-10 09:16:55.741487');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (668, 'West Maas en Waal', NULL, 19850701, NULL, '2023-05-10 09:16:55.742846');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (669, '''s Heer Abtskerke', 654, NULL, 19700101, '2023-05-10 09:16:55.744066');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (670, '''s-Heer Arendskerke', 664, NULL, 19700101, '2023-05-10 09:16:55.74551');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (671, '''s-Heerenhoek', 654, NULL, 19700101, '2023-05-10 09:16:55.747078');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (672, 'Heinkenszand', 654, NULL, 19700101, '2023-05-10 09:16:55.748609');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (673, 'Hoedekenskerke', 654, NULL, 19700101, '2023-05-10 09:16:55.750051');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (674, 'Hoek', 715, NULL, 19700401, '2023-05-10 09:16:55.75134');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (675, 'Hontenisse', 677, NULL, 20030101, '2023-05-10 09:16:55.752581');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (676, 'Hoofdplaat', 692, NULL, 19700401, '2023-05-10 09:16:55.754068');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (677, 'Hulst', NULL, NULL, NULL, '2023-05-10 09:16:55.75579');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (678, 'Kapelle', NULL, NULL, NULL, '2023-05-10 09:16:55.757632');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (679, 'Kattendijke', 664, NULL, 19700101, '2023-05-10 09:16:55.759042');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (680, 'Kloetinge', 664, NULL, 19700401, '2023-05-10 09:16:55.760384');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (681, 'Koewacht', 650, NULL, 19700401, '2023-05-10 09:16:55.761581');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (682, 'Kortgene', 1695, NULL, 19950101, '2023-05-10 09:16:55.762749');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (683, 'Wymbritseradiel', 1900, 19860101, 20110101, '2023-05-10 09:16:55.763953');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (684, 'Krabbendijke', 703, NULL, 19700101, '2023-05-10 09:16:55.765112');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (685, 'Kruiningen', 703, NULL, 19700101, '2023-05-10 09:16:55.766321');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (686, 'Mariekerke', 717, 19660701, 19970101, '2023-05-10 09:16:55.767448');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (687, 'Middelburg', NULL, NULL, NULL, '2023-05-10 09:16:55.768595');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (688, 'Middenschouwen', 1676, 19610101, 19970101, '2023-05-10 09:16:55.769693');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (689, 'Giessenlanden', 1978, 19860101, 20190101, '2023-05-10 09:16:55.771178');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (690, 'Nieuwvliet', 692, NULL, 19700401, '2023-05-10 09:16:55.772511');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (691, 'Nisse', 654, NULL, 19700101, '2023-05-10 09:16:55.773847');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (692, 'Oostburg', 1714, NULL, 20030101, '2023-05-10 09:16:55.775105');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (693, 'Graafstroom', 1927, 19860101, 20130101, '2023-05-10 09:16:55.776341');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (694, 'Liesveld', 1927, 19860101, 20130101, '2023-05-10 09:16:55.777542');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (695, 'Oudelande', 654, NULL, 19700101, '2023-05-10 09:16:55.778726');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (696, 'Oud-Vossemeer', 716, NULL, 19710701, '2023-05-10 09:16:55.779936');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (697, 'Overslag', 650, NULL, 19700401, '2023-05-10 09:16:55.781114');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (698, 'Ovezande', 654, NULL, 19700101, '2023-05-10 09:16:55.782303');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (699, 'Philippine', 704, NULL, 19700401, '2023-05-10 09:16:55.783466');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (700, 'Poortvliet', 716, NULL, 19710701, '2023-05-10 09:16:55.784659');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (701, 'Retranchement', 713, NULL, 19700401, '2023-05-10 09:16:55.785936');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (702, 'Rilland-Bath', 703, 18771210, 19700101, '2023-05-10 09:16:55.78744');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (703, 'Reimerswaal', NULL, 19700101, NULL, '2023-05-10 09:16:55.78926');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (704, 'Sas van Gent', 715, NULL, 20030101, '2023-05-10 09:16:55.790993');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (705, 'Scherpenisse', 716, NULL, 19710701, '2023-05-10 09:16:55.841961');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (706, 'Schoondijke', 692, NULL, 19700401, '2023-05-10 09:16:55.844556');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (707, 'Zederik', 1961, 19860101, 20190101, '2023-05-10 09:16:55.846509');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (708, 'Sint-Annaland', 716, NULL, 19710701, '2023-05-10 09:16:55.847795');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (709, 'St. Jansteen', 677, NULL, 19700401, '2023-05-10 09:16:55.84935');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (710, 'Wûnseradiel', 1900, 19870101, 20110101, '2023-05-10 09:16:55.851026');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (711, 'Sint-Maartensdijk', 716, NULL, 19710701, '2023-05-10 09:16:55.85237');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (712, 'Sint Philipsland', 716, NULL, 19950101, '2023-05-10 09:16:55.853989');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (713, 'Sluis (oud)', 1698, NULL, 19950101, '2023-05-10 09:16:55.855379');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (714, 'Stavenisse', 716, NULL, 19710701, '2023-05-10 09:16:55.85657');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (715, 'Terneuzen', NULL, NULL, NULL, '2023-05-10 09:16:55.858053');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (716, 'Tholen', NULL, NULL, NULL, '2023-05-10 09:16:55.859474');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (717, 'Veere', NULL, NULL, NULL, '2023-05-10 09:16:55.86072');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (718, 'Vlissingen', NULL, NULL, NULL, '2023-05-10 09:16:55.861929');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (719, 'Vogelwaarde', 675, 19360701, 19700401, '2023-05-10 09:16:55.863165');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (720, 'Valkenisse', 717, 19660701, 19970101, '2023-05-10 09:16:55.864429');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (721, 'Waarde', 703, NULL, 19700101, '2023-05-10 09:16:55.865676');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (722, 'Waterlandkerkje', 692, NULL, 19700401, '2023-05-10 09:16:55.866995');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (723, 'Wemeldinge', 678, NULL, 19700101, '2023-05-10 09:16:55.868133');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (724, 'Westdorpe', 704, NULL, 19700401, '2023-05-10 09:16:55.869338');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (725, 'Westerschouwen', 1676, 19610101, 19970101, '2023-05-10 09:16:55.870486');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (726, 'Westkapelle', 717, NULL, 19970101, '2023-05-10 09:16:55.871685');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (727, 'Wissenkerke', 1695, NULL, 19950101, '2023-05-10 09:16:55.872829');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (728, 'Wolphaartsdijk', 664, NULL, 19700101, '2023-05-10 09:16:55.874002');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (729, 'Yerseke', 703, NULL, 19700101, '2023-05-10 09:16:55.875244');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (730, 'IJzendijke', 692, NULL, 19700401, '2023-05-10 09:16:55.876791');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (731, 'Zaamslag', 715, NULL, 19700401, '2023-05-10 09:16:55.878148');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (732, 'Zierikzee', 1676, NULL, 19970101, '2023-05-10 09:16:55.879407');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (733, 'Lingewaal', 1960, 19870103, 20190101, '2023-05-10 09:16:55.880613');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (734, 'Zuiddorpe', 650, NULL, 19700401, '2023-05-10 09:16:55.882234');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (735, 'Zuidzande', 692, NULL, 19700401, '2023-05-10 09:16:55.883493');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (736, 'De Ronde Venen', NULL, 19890101, NULL, '2023-05-10 09:16:55.884664');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (737, 'Tytsjerksteradiel', NULL, 19890101, NULL, '2023-05-10 09:16:55.885981');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (738, 'Aalburg', 1959, NULL, 20190101, '2023-05-10 09:16:55.887203');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (739, 'Aarle-Rixtel', 1659, NULL, 19970101, '2023-05-10 09:16:55.888539');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (740, 'Almkerk', 874, NULL, 19730101, '2023-05-10 09:16:55.889738');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (741, 'Alphen en Riel', 1723, NULL, 19970101, '2023-05-10 09:16:55.891231');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (742, 'Andel', 874, NULL, 19730101, '2023-05-10 09:16:55.892394');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (743, 'Asten', NULL, NULL, NULL, '2023-05-10 09:16:55.893697');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (744, 'Baarle-Nassau', NULL, NULL, NULL, '2023-05-10 09:16:55.895011');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (745, 'Bakel en Milheeze', 1652, NULL, 19970101, '2023-05-10 09:16:55.896709');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (746, 'Beek en Donk', 1659, NULL, 19970101, '2023-05-10 09:16:55.898294');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (747, 'Beers', 1684, NULL, 19940101, '2023-05-10 09:16:55.899542');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (748, 'Bergen op Zoom', NULL, NULL, NULL, '2023-05-10 09:16:55.900737');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (749, 'Bergeyk', 1724, NULL, 19990101, '2023-05-10 09:16:55.902351');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (750, 'Berghem', 828, NULL, 19940101, '2023-05-10 09:16:55.903524');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (751, 'Berkel-Enschot', 855, NULL, 19970101, '2023-05-10 09:16:55.904826');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (752, 'Berlicum', 845, NULL, 19960101, '2023-05-10 09:16:55.906012');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (753, 'Best', NULL, NULL, NULL, '2023-05-10 09:16:55.907295');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (754, 'Bladel en Netersel', 1728, NULL, 19970101, '2023-05-10 09:16:55.908475');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (755, 'Boekel', NULL, NULL, NULL, '2023-05-10 09:16:55.909728');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (756, 'Boxmeer', 1982, NULL, 20220101, '2023-05-10 09:16:55.911104');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (757, 'Boxtel', NULL, NULL, NULL, '2023-05-10 09:16:55.912315');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (758, 'Breda', NULL, NULL, NULL, '2023-05-10 09:16:55.914336');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (759, 'Budel', 1706, NULL, 19980128, '2023-05-10 09:16:55.91608');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (760, 'Chaam', 1723, NULL, 19970101, '2023-05-10 09:16:55.917776');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (761, 'Cuijk en Sint Agatha', 1684, NULL, 19940101, '2023-05-10 09:16:55.919139');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (762, 'Deurne', NULL, 19260101, NULL, '2023-05-10 09:16:55.920726');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (763, 'Diessen', 798, NULL, 19970101, '2023-05-10 09:16:55.972202');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (764, 'Dinteloord en Prinsenland', 851, NULL, 19970101, '2023-05-10 09:16:55.974829');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (765, 'Pekela', NULL, 19900101, NULL, '2023-05-10 09:16:55.976862');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (766, 'Dongen', NULL, NULL, NULL, '2023-05-10 09:16:55.979556');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (767, 'Drunen', 797, NULL, 19970101, '2023-05-10 09:16:55.981938');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (768, 'Den Dungen', 845, NULL, 19960101, '2023-05-10 09:16:55.98421');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (769, 'Dussen', 870, NULL, 19970101, '2023-05-10 09:16:55.985702');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (770, 'Eersel', NULL, NULL, NULL, '2023-05-10 09:16:55.987285');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (771, 'Eethen', 738, 19230501, 19730101, '2023-05-10 09:16:55.988907');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (772, 'Eindhoven', NULL, NULL, NULL, '2023-05-10 09:16:55.990488');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (773, 'Empel en Meerwijk', 796, NULL, 19710401, '2023-05-10 09:16:55.992021');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (774, 'Engelen', 796, NULL, 19710401, '2023-05-10 09:16:55.993799');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (775, 'Erp', 860, NULL, 19940101, '2023-05-10 09:16:55.995598');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (776, 'Esch', 788, NULL, 19960101, '2023-05-10 09:16:55.997005');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (777, 'Etten-Leur', NULL, 19680101, NULL, '2023-05-10 09:16:55.99846');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (778, 'Fijnaart en Heijningen', 878, NULL, 19970101, '2023-05-10 09:16:55.999811');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (779, 'Geertruidenberg', NULL, NULL, NULL, '2023-05-10 09:16:56.001098');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (780, 'Geffen', 1671, NULL, 19930101, '2023-05-10 09:16:56.002288');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (781, 'Geldrop', 1771, NULL, 20040101, '2023-05-10 09:16:56.00356');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (782, 'Gemert', 1652, NULL, 19970101, '2023-05-10 09:16:56.00478');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (783, 'Giessen', 874, NULL, 19730101, '2023-05-10 09:16:56.005937');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (784, 'Gilze en Rijen', NULL, NULL, NULL, '2023-05-10 09:16:56.007148');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (785, 'Goirle', NULL, NULL, NULL, '2023-05-10 09:16:56.008887');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (786, 'Grave', 1982, NULL, 20220101, '2023-05-10 09:16:56.010665');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (787, '''s Gravenmoer', 766, NULL, 19970101, '2023-05-10 09:16:56.012786');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (788, 'Haaren', 824, NULL, 20210101, '2023-05-10 09:16:56.014401');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (789, 'Halsteren', 748, NULL, 19970101, '2023-05-10 09:16:56.016084');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (790, 'Haps', 1684, NULL, 19940101, '2023-05-10 09:16:56.01769');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (791, 'Heesch', 1721, NULL, 19950128, '2023-05-10 09:16:56.018903');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (792, 'Heeswijk-Dinther', 791, 19690101, 19940101, '2023-05-10 09:16:56.020178');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (793, 'Heeze', 1658, NULL, 19970101, '2023-05-10 09:16:56.021372');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (794, 'Helmond', NULL, NULL, NULL, '2023-05-10 09:16:56.022597');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (795, 'Helvoirt', 788, NULL, 19960101, '2023-05-10 09:16:56.023839');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (796, '''s-Hertogenbosch', NULL, NULL, NULL, '2023-05-10 09:16:56.025343');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (797, 'Heusden', NULL, NULL, NULL, '2023-05-10 09:16:56.026673');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (798, 'Hilvarenbeek', NULL, NULL, NULL, '2023-05-10 09:16:56.02797');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (799, 'Hoeven', 1655, NULL, 19970101, '2023-05-10 09:16:56.029223');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (800, 'Hoogeloon, Hapert en Casteren', 1728, NULL, 19970101, '2023-05-10 09:16:56.030448');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (801, 'Hooge en Lage Mierde', 1667, NULL, 19970101, '2023-05-10 09:16:56.081998');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (802, 'Hooge en Lage Zwaluwe', 1665, NULL, 19970101, '2023-05-10 09:16:56.084278');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (803, 'Huijbergen', 873, NULL, 19970101, '2023-05-10 09:16:56.086435');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (804, 'Klundert', 878, NULL, 19970101, '2023-05-10 09:16:56.087998');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (805, 'Leende', 1658, NULL, 19970101, '2023-05-10 09:16:56.089317');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (806, 'Liempde', 757, NULL, 19960101, '2023-05-10 09:16:56.090577');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (807, 'Lieshout', 1659, NULL, 19970101, '2023-05-10 09:16:56.091757');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (808, 'Lith', 828, NULL, 20110101, '2023-05-10 09:16:56.093019');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (809, 'Loon op Zand', NULL, NULL, NULL, '2023-05-10 09:16:56.094283');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (810, 'Luyksgestel', 749, NULL, 19970101, '2023-05-10 09:16:56.095473');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (811, 'Maarheeze', 759, NULL, 19970101, '2023-05-10 09:16:56.096653');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (812, 'Made en Drimmelen', 1665, NULL, 19970101, '2023-05-10 09:16:56.097921');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (813, 'Megen, Haren en Macharen', 828, NULL, 19940101, '2023-05-10 09:16:56.099131');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (814, 'Mierlo', 1771, NULL, 20040101, '2023-05-10 09:16:56.100286');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (815, 'Mill en Sint Hubert', 1982, NULL, 20220101, '2023-05-10 09:16:56.101451');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (816, 'Moergestel', 824, NULL, 19970101, '2023-05-10 09:16:56.10261');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (817, 'Nieuw-Ginneken', 758, 19420101, 19970101, '2023-05-10 09:16:56.103881');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (818, 'Nieuw-Vossemeer', 851, NULL, 19970101, '2023-05-10 09:16:56.105071');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (819, 'Nistelrode', 791, NULL, 19940101, '2023-05-10 09:16:56.106389');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (820, 'Nuenen, Gerwen en Nederwetten', NULL, NULL, NULL, '2023-05-10 09:16:56.107645');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (821, 'Nuland', 1671, NULL, 19930101, '2023-05-10 09:16:56.108854');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (822, 'Oeffelt', 756, NULL, 19940101, '2023-05-10 09:16:56.110115');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (823, 'Oirschot', NULL, NULL, NULL, '2023-05-10 09:16:56.11133');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (824, 'Oisterwijk', NULL, NULL, NULL, '2023-05-10 09:16:56.112465');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (825, 'Oost-, West- en Middelbeers', 823, NULL, 19970101, '2023-05-10 09:16:56.113638');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (826, 'Oosterhout', NULL, NULL, NULL, '2023-05-10 09:16:56.115262');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (827, 'Oploo, St. Anthonis en Ledeacker', 1691, NULL, 19940101, '2023-05-10 09:16:56.116637');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (828, 'Oss', NULL, NULL, NULL, '2023-05-10 09:16:56.117996');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (829, 'Ossendrecht', 873, NULL, 19970101, '2023-05-10 09:16:56.119658');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (830, 'Oudenbosch', 1655, NULL, 19970101, '2023-05-10 09:16:56.12112');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (831, 'Oud en Nieuw Gastel', 1655, NULL, 19970101, '2023-05-10 09:16:56.122656');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (832, 'Prinsenbeek', 758, 19510101, 19970101, '2023-05-10 09:16:56.123962');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (833, 'Putte', 873, NULL, 19970101, '2023-05-10 09:16:56.125387');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (834, 'Raamsdonk', 779, NULL, 19970101, '2023-05-10 09:16:56.126665');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (835, 'Ravenstein', 828, NULL, 20030101, '2023-05-10 09:16:56.127915');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (836, 'Reusel', 1667, NULL, 19970101, '2023-05-10 09:16:56.129109');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (837, 'Riethoven', 749, NULL, 19970101, '2023-05-10 09:16:56.130297');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (838, 'Roosendaal en Nispen', 1674, NULL, 19970101, '2023-05-10 09:16:56.192388');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (839, 'Rosmalen', 796, NULL, 19960101, '2023-05-10 09:16:56.195218');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (840, 'Rucphen', NULL, NULL, NULL, '2023-05-10 09:16:56.197667');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (841, 'Rijsbergen', 879, NULL, 19970101, '2023-05-10 09:16:56.199184');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (842, 'Rijswijk (NB)', 874, NULL, 19730101, '2023-05-10 09:16:56.20057');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (843, 'Schaijk', 1685, NULL, 19940101, '2023-05-10 09:16:56.201787');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (844, 'Schijndel', 1948, NULL, 20170101, '2023-05-10 09:16:56.202967');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (845, 'Sint-Michielsgestel', NULL, NULL, NULL, '2023-05-10 09:16:56.204128');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (846, 'Sint-Oedenrode', 1948, NULL, 20170101, '2023-05-10 09:16:56.205372');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (847, 'Someren', NULL, NULL, NULL, '2023-05-10 09:16:56.206974');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (848, 'Son en Breugel', NULL, NULL, NULL, '2023-05-10 09:16:56.208583');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (849, 'Sprang-Capelle', 867, 19230101, 19970101, '2023-05-10 09:16:56.210418');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (850, 'Standdaarbuiten', 878, NULL, 19970101, '2023-05-10 09:16:56.211975');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (851, 'Steenbergen', NULL, NULL, NULL, '2023-05-10 09:16:56.213236');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (852, 'Waterland', NULL, 19910101, NULL, '2023-05-10 09:16:56.214394');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (853, 'Terheijden', 1665, NULL, 19970101, '2023-05-10 09:16:56.215571');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (854, 'Teteringen', 758, NULL, 19970101, '2023-05-10 09:16:56.216748');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (855, 'Tilburg', NULL, NULL, NULL, '2023-05-10 09:16:56.217939');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (856, 'Uden', 1991, NULL, 20220101, '2023-05-10 09:16:56.219146');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (857, 'Udenhout', 855, NULL, 19970101, '2023-05-10 09:16:56.22049');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (858, 'Valkenswaard', NULL, NULL, NULL, '2023-05-10 09:16:56.272067');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (859, 'Veen', 738, NULL, 19730101, '2023-05-10 09:16:56.274292');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (860, 'Veghel', 1948, NULL, 20170101, '2023-05-10 09:16:56.277221');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (861, 'Veldhoven', NULL, 19210101, NULL, '2023-05-10 09:16:56.278957');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (862, 'Vessem, Wintelre en Knegsel', 770, NULL, 19970101, '2023-05-10 09:16:56.280389');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (863, 'Vierlingsbeek', 756, NULL, 19980101, '2023-05-10 09:16:56.281777');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (864, 'Vlijmen', 797, NULL, 19970101, '2023-05-10 09:16:56.283048');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (865, 'Vught', NULL, NULL, NULL, '2023-05-10 09:16:56.284327');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (866, 'Waalre', NULL, NULL, NULL, '2023-05-10 09:16:56.285696');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (867, 'Waalwijk', NULL, NULL, NULL, '2023-05-10 09:16:56.287783');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (868, 'Wanroij', 1691, NULL, 19940101, '2023-05-10 09:16:56.289652');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (869, 'Waspik', 867, NULL, 19970101, '2023-05-10 09:16:56.291365');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (870, 'Werkendam', 1959, NULL, 20190101, '2023-05-10 09:16:56.293063');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (871, 'Westerhoven', 749, NULL, 19970101, '2023-05-10 09:16:56.294814');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (872, 'Willemstad', 878, NULL, 19970101, '2023-05-10 09:16:56.296317');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (873, 'Woensdrecht', NULL, NULL, NULL, '2023-05-10 09:16:56.297466');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (874, 'Woudrichem', 1959, NULL, 20190101, '2023-05-10 09:16:56.29872');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (875, 'Wouw', 1674, NULL, 19970101, '2023-05-10 09:16:56.299895');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (876, 'Wijk en Aalburg', 738, NULL, 19730101, '2023-05-10 09:16:56.301259');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (877, 'Zeeland', 1685, NULL, 19940101, '2023-05-10 09:16:56.302826');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (878, 'Zevenbergen', 1709, NULL, 19980401, '2023-05-10 09:16:56.304458');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (879, 'Zundert', NULL, NULL, NULL, '2023-05-10 09:16:56.305984');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (880, 'Wormerland', NULL, 19910101, NULL, '2023-05-10 09:16:56.307273');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (881, 'Onderbanken', 1954, 19820101, 20190101, '2023-05-10 09:16:56.308368');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (882, 'Landgraaf', NULL, 19820101, NULL, '2023-05-10 09:16:56.309683');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (883, 'Amby', 935, NULL, 19700701, '2023-05-10 09:16:56.311667');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (884, 'Amstenrade', 962, NULL, 19820101, '2023-05-10 09:16:56.313023');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (885, 'Arcen en Velden', 983, NULL, 20100101, '2023-05-10 09:16:56.314292');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (886, 'Baexem', 920, NULL, 19910101, '2023-05-10 09:16:56.315568');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (887, 'Beegden', 1937, NULL, 19910101, '2023-05-10 09:16:56.316937');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (888, 'Beek', NULL, NULL, NULL, '2023-05-10 09:16:56.318515');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (889, 'Beesel', NULL, NULL, NULL, '2023-05-10 09:16:56.320087');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (890, 'Belfeld', 983, NULL, 20010101, '2023-05-10 09:16:56.32142');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (891, 'Bemelen', 936, NULL, 19820101, '2023-05-10 09:16:56.322528');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (892, 'Berg en Terblijt', 994, NULL, 19820101, '2023-05-10 09:16:56.323696');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (893, 'Bergen (L)', NULL, NULL, NULL, '2023-05-10 09:16:56.324883');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (894, 'Bingelrade', 963, NULL, 19820101, '2023-05-10 09:16:56.326167');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (895, 'Bocholtz', 965, NULL, 19820101, '2023-05-10 09:16:56.327508');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (896, 'Borgharen', 935, NULL, 19700701, '2023-05-10 09:16:56.328772');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (897, 'Born', 1883, NULL, 20010101, '2023-05-10 09:16:56.330126');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (898, 'Broekhuizen', 1507, NULL, 20010101, '2023-05-10 09:16:56.331346');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (899, 'Brunssum', NULL, NULL, NULL, '2023-05-10 09:16:56.332498');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (900, 'Bunde', 938, NULL, 19820101, '2023-05-10 09:16:56.33378');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (901, 'Cadier en Keer', 936, NULL, 19820101, '2023-05-10 09:16:56.334975');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (902, 'Echt', 1711, NULL, 20030101, '2023-05-10 09:16:56.336195');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (903, 'Elsloo', 971, NULL, 19820101, '2023-05-10 09:16:56.337543');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (904, 'Eygelshoven', 928, NULL, 19820101, '2023-05-10 09:16:56.33872');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (905, 'Eijsden', 1903, NULL, 20110101, '2023-05-10 09:16:56.339882');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (906, 'Geleen', 1883, NULL, 20010101, '2023-05-10 09:16:56.341032');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (907, 'Gennep', NULL, NULL, NULL, '2023-05-10 09:16:56.342166');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (908, 'Geulle', 938, NULL, 19820101, '2023-05-10 09:16:56.343289');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (909, 'Grathem', 920, NULL, 19910101, '2023-05-10 09:16:56.345427');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (910, 'Grevenbicht', 897, NULL, 19820101, '2023-05-10 09:16:56.346576');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (911, 'Gronsveld', 905, NULL, 19820101, '2023-05-10 09:16:56.347731');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (912, 'Grubbenvorst', 1507, NULL, 20010101, '2023-05-10 09:16:56.348966');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (913, 'Gulpen', 1729, NULL, 19990101, '2023-05-10 09:16:56.350575');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (914, 'Haelen', 1640, NULL, 20070101, '2023-05-10 09:16:56.351873');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (915, 'Heel en Panheel', 1937, NULL, 19910101, '2023-05-10 09:16:56.353116');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (916, 'Heer', 935, NULL, 19700701, '2023-05-10 09:16:56.354311');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (917, 'Heerlen', NULL, NULL, NULL, '2023-05-10 09:16:56.35548');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (918, 'Helden', 1894, NULL, 20100101, '2023-05-10 09:16:56.356678');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (919, 'Herten', 957, NULL, 19910101, '2023-05-10 09:16:56.358142');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (920, 'Heythuysen', 1640, NULL, 20070101, '2023-05-10 09:16:56.359347');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (921, 'Hoensbroek', 917, NULL, 19820101, '2023-05-10 09:16:56.360591');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (922, 'Horn', 914, NULL, 19910101, '2023-05-10 09:16:56.361844');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (923, 'Horst', 1507, NULL, 20010101, '2023-05-10 09:16:56.363089');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (924, 'Hulsberg', 951, NULL, 19820101, '2023-05-10 09:16:56.364221');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (925, 'Hunsel', 1640, NULL, 20070101, '2023-05-10 09:16:56.365367');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (926, 'Itteren', 935, NULL, 19700701, '2023-05-10 09:16:56.366584');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (927, 'Jabeek', 963, NULL, 19820101, '2023-05-10 09:16:56.367983');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (928, 'Kerkrade', NULL, NULL, NULL, '2023-05-10 09:16:56.369298');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (929, 'Kessel', 1894, NULL, 20100101, '2023-05-10 09:16:56.370561');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (930, 'Klimmen', 986, NULL, 19820101, '2023-05-10 09:16:56.372009');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (931, 'Limbricht', 968, NULL, 19820101, '2023-05-10 09:16:56.373427');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (932, 'Linne', 933, NULL, 19910101, '2023-05-10 09:16:56.374863');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (933, 'Maasbracht', 1641, NULL, 20070101, '2023-05-10 09:16:56.376379');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (934, 'Maasbree', 1894, NULL, 20100101, '2023-05-10 09:16:56.378211');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (935, 'Maastricht', NULL, NULL, NULL, '2023-05-10 09:16:56.379881');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (936, 'Margraten', 1903, NULL, 20110101, '2023-05-10 09:16:56.381467');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (937, 'Meerlo', 993, NULL, 19690701, '2023-05-10 09:16:56.383092');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (938, 'Meerssen', NULL, NULL, NULL, '2023-05-10 09:16:56.384534');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (939, 'Melick en Herkenbosch', 1669, NULL, 19930101, '2023-05-10 09:16:56.386133');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (940, 'Merkelbeek', 963, NULL, 19820101, '2023-05-10 09:16:56.38746');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (941, 'Meijel', 1894, NULL, 20100101, '2023-05-10 09:16:56.388688');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (942, 'Mheer', 936, NULL, 19820101, '2023-05-10 09:16:56.389838');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (943, 'Montfort', 956, NULL, 19910101, '2023-05-10 09:16:56.391013');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (944, 'Mook en Middelaar', NULL, NULL, NULL, '2023-05-10 09:16:56.392179');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (945, 'Munstergeleen', 968, NULL, 19820101, '2023-05-10 09:16:56.393352');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (946, 'Nederweert', NULL, NULL, NULL, '2023-05-10 09:16:56.394569');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (947, 'Neer', 958, NULL, 19910101, '2023-05-10 09:16:56.395893');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (948, 'Nieuwenhagen', 882, NULL, 19820101, '2023-05-10 09:16:56.397102');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (949, 'Nieuwstadt', 974, NULL, 19820101, '2023-05-10 09:16:56.398516');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (950, 'Noorbeek', 936, NULL, 19820101, '2023-05-10 09:16:56.399995');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (951, 'Nuth', 1954, NULL, 20190101, '2023-05-10 09:16:56.401649');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (952, 'Obbicht en Papenhoven', 897, NULL, 19820101, '2023-05-10 09:16:56.403004');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (953, 'Ohé en Laak', 933, NULL, 19910101, '2023-05-10 09:16:56.404284');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (954, 'Oirsbeek', 962, NULL, 19820101, '2023-05-10 09:16:56.405547');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (955, 'Ottersum', 907, NULL, 19730101, '2023-05-10 09:16:56.40687');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (956, 'Posterholt', 1679, NULL, 19940201, '2023-05-10 09:16:56.408163');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (957, 'Roermond', NULL, NULL, NULL, '2023-05-10 09:16:56.409566');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (958, 'Roggel', 1670, NULL, 19930101, '2023-05-10 09:16:56.411085');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (959, 'Roosteren', 974, NULL, 19820101, '2023-05-10 09:16:56.412496');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (960, 'Schaesberg', 882, NULL, 19820101, '2023-05-10 09:16:56.414231');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (961, 'Schimmert', 951, NULL, 19820101, '2023-05-10 09:16:56.415879');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (962, 'Schinnen', 1954, NULL, 20190101, '2023-05-10 09:16:56.417584');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (963, 'Schinveld', 881, NULL, 19820101, '2023-05-10 09:16:56.418899');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (964, 'Sevenum', 1507, NULL, 20100101, '2023-05-10 09:16:56.420308');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (965, 'Simpelveld', NULL, NULL, NULL, '2023-05-10 09:16:56.422172');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (966, 'Sint Geertruid', 936, NULL, 19820101, '2023-05-10 09:16:56.42366');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (967, 'Sint Odiliënberg', 956, NULL, 19910101, '2023-05-10 09:16:56.425168');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (968, 'Sittard', 1883, NULL, 20010101, '2023-05-10 09:16:56.42648');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (969, 'Slenaken', 990, NULL, 19820101, '2023-05-10 09:16:56.427864');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (970, 'Spaubeek', 888, NULL, 19820101, '2023-05-10 09:16:56.429238');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (971, 'Stein', NULL, NULL, NULL, '2023-05-10 09:16:56.431037');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (972, 'Stevensweert', 933, NULL, 19910101, '2023-05-10 09:16:56.434554');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (973, 'Stramproy', 988, NULL, 19980101, '2023-05-10 09:16:56.437411');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (974, 'Susteren', 1711, NULL, 20030101, '2023-05-10 09:16:56.448031');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (975, 'Swalmen', 957, NULL, 20070101, '2023-05-10 09:16:56.469997');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (976, 'Tegelen', 983, NULL, 20010101, '2023-05-10 09:16:56.47223');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (977, 'Thorn', 1641, NULL, 20070101, '2023-05-10 09:16:56.474192');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (978, 'Ubach over Worms', 882, NULL, 19820101, '2023-05-10 09:16:56.476176');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (979, 'Ulestraten', 938, NULL, 19820101, '2023-05-10 09:16:56.482427');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (980, 'Urmond', 971, NULL, 19820101, '2023-05-10 09:16:56.485197');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (981, 'Vaals', NULL, NULL, NULL, '2023-05-10 09:16:56.488155');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (982, 'Valkenburg-Houthem', 994, 19401001, 19820101, '2023-05-10 09:16:56.490086');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (983, 'Venlo', NULL, NULL, NULL, '2023-05-10 09:16:56.491871');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (984, 'Venray', NULL, NULL, NULL, '2023-05-10 09:16:56.493592');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (985, 'Vlodrop', 939, NULL, 19910101, '2023-05-10 09:16:56.495897');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (986, 'Voerendaal', NULL, NULL, NULL, '2023-05-10 09:16:56.49763');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (987, 'Wanssum', 993, NULL, 19690701, '2023-05-10 09:16:56.499464');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (988, 'Weert', NULL, NULL, NULL, '2023-05-10 09:16:56.501082');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (989, 'Wessem', 1937, NULL, 19910101, '2023-05-10 09:16:56.502626');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (990, 'Wittem', 1729, NULL, 19990101, '2023-05-10 09:16:56.504295');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (991, 'Wijlre', 913, NULL, 19820101, '2023-05-10 09:16:56.505998');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (992, 'Wijnandsrade', 951, NULL, 19820101, '2023-05-10 09:16:56.507608');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (993, 'Meerlo-Wanssum', 984, 19690701, 20100101, '2023-05-10 09:16:56.509344');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (994, 'Valkenburg aan de Geul', NULL, 19820101, NULL, '2023-05-10 09:16:56.511452');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (995, 'Lelystad', NULL, 19800101, NULL, '2023-05-10 09:16:56.560963');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (996, 'Zuidelijke IJsselmeerpolders', 34, 19551130, 19960101, '2023-05-10 09:16:56.562546');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (997, 'Centraal Persoonsregister (Niet GBA)', NULL, NULL, 19901001, '2023-05-10 09:16:56.563799');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (998, 'Buitenland (Niet GBA)', NULL, NULL, 19901001, '2023-05-10 09:16:56.565063');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (999, 'Onbekend (Niet GBA)', NULL, NULL, 19901001, '2023-05-10 09:16:56.566453');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1000, 'Aagtekerke', 686, NULL, 19660701, '2023-05-10 09:16:56.567564');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1001, 'Aalst', 866, NULL, 19230101, '2023-05-10 09:16:56.568764');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1002, 'Aarlanderveen', 484, NULL, 19180101, '2023-05-10 09:16:56.569986');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1003, 'Abcoude-Baambrugge', 305, NULL, 19410501, '2023-05-10 09:16:56.571286');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1004, 'Abcoude-Proostdij', 305, NULL, 19410501, '2023-05-10 09:16:56.572664');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1005, 'Achttienhoven', 1224, NULL, 19540101, '2023-05-10 09:16:56.574093');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1006, 'Aengwirden', 74, NULL, 19340701, '2023-05-10 09:16:56.575297');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1007, 'Alem, Maren en Kessel', 808, NULL, 19580101, '2023-05-10 09:16:56.576488');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1008, 'Alphen', 484, NULL, 19180101, '2023-05-10 09:16:56.577779');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1009, 'Ambt-Almelo', 141, NULL, 19140101, '2023-05-10 09:16:56.579051');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1010, 'Ambt-Doetinchem', 222, NULL, 19200101, '2023-05-10 09:16:56.580233');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1011, 'Ambt-Hardenberg', 160, NULL, 19410501, '2023-05-10 09:16:56.581637');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1012, 'Ambt-Ommen', 175, NULL, 19230501, '2023-05-10 09:16:56.582951');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1013, 'Ambt-Vollenhove', 185, NULL, 19420201, '2023-05-10 09:16:56.584447');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1014, 'Ankeveen', 390, NULL, 19660801, '2023-05-10 09:16:56.585637');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1015, 'Baardwijk', 867, NULL, 19220101, '2023-05-10 09:16:56.586868');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1016, 'Balgoij', 271, NULL, 19230501, '2023-05-10 09:16:56.588284');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1017, 'Barwoutswaarder', 632, NULL, 19640201, '2023-05-10 09:16:56.589534');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1018, 'Bath', 702, NULL, 18780101, '2023-05-10 09:16:56.590941');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1019, 'Bellingwolde', 7, NULL, 19680901, '2023-05-10 09:16:56.592207');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1020, 'Besoijen', 867, NULL, 19290101, '2023-05-10 09:16:56.593521');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1021, 'Beugen en Rijkevoort', 756, NULL, 19420501, '2023-05-10 09:16:56.594736');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1022, 'Biggekerke', 720, NULL, 19660701, '2023-05-10 09:16:56.595967');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1023, 'Bokhoven', 774, NULL, 19220101, '2023-05-10 09:16:56.597217');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1024, 'Den Bommel', 580, NULL, 19660101, '2023-05-10 09:16:56.598461');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1025, 'Bommenede', 1236, NULL, 18650101, '2023-05-10 09:16:56.599807');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1026, 'Borkel en Schaft', 858, NULL, 19340501, '2023-05-10 09:16:56.601011');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1027, 'Boschkapelle', 719, NULL, 19360701, '2023-05-10 09:16:56.602438');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1028, 'Breukelen-Nijenrode', 311, NULL, 19490101, '2023-05-10 09:16:56.603765');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1029, 'Breukelen-Sint Pieters', 311, NULL, 19490101, '2023-05-10 09:16:56.605046');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1030, 'Broek', 627, NULL, 18700701, '2023-05-10 09:16:56.606246');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1031, 'Broek op Langendijk', 416, NULL, 19410801, '2023-05-10 09:16:56.607432');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1032, 'Broeksittard', 968, NULL, 19421001, '2023-05-10 09:16:56.608603');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1033, 'Buggenum', 914, NULL, 19421001, '2023-05-10 09:16:56.609954');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1034, 'Buiksloot', 363, NULL, 19210101, '2023-05-10 09:16:56.611395');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1035, 'Burgh', 725, NULL, 19610101, '2023-05-10 09:16:56.612766');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1036, 'Capelle', 849, NULL, 19230101, '2023-05-10 09:16:56.614346');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1037, 'Charlois', 599, NULL, 18950228, '2023-05-10 09:16:56.61558');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1038, 'Colijnsplaat', 682, NULL, 19410401, '2023-05-10 09:16:56.616896');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1039, 'Cromvoirt', 865, NULL, 19330101, '2023-05-10 09:16:56.618332');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1040, 'Delfshaven', 599, NULL, 18860114, '2023-05-10 09:16:56.619571');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1041, 'Deurne en Liessel', 762, NULL, 19260101, '2023-05-10 09:16:56.620759');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1042, 'Deursen en Dennenburg', 835, NULL, 19230501, '2023-05-10 09:16:56.621983');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1043, 'Dieden, Demen en Langel', 835, NULL, 19230501, '2023-05-10 09:16:56.623167');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1044, 'Dinther', 792, NULL, 19690101, '2023-05-10 09:16:56.624309');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1045, 'Dommelen', 858, NULL, 19340501, '2023-05-10 09:16:56.625644');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1046, 'Doorwerth', 274, NULL, 19230501, '2023-05-10 09:16:56.627069');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1047, 'Dreischor', 656, NULL, 19610101, '2023-05-10 09:16:56.628364');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1048, 'Driebergen', 316, NULL, 19310501, '2023-05-10 09:16:56.629577');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1049, 'Drongelen', 771, NULL, 19230501, '2023-05-10 09:16:56.630815');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1050, 'Duivendijke', 688, NULL, 19610101, '2023-05-10 09:16:56.632031');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1051, 'Duizel en Steensel', 770, NULL, 19230101, '2023-05-10 09:16:56.633254');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1052, 'Eede', 648, NULL, 19410401, '2023-05-10 09:16:56.634464');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1053, 'Elkerzee', 688, NULL, 19610101, '2023-05-10 09:16:56.635721');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1054, 'Ellemeet', 688, NULL, 19610101, '2023-05-10 09:16:56.636926');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1055, 'Elten', NULL, 19490423, 19630801, '2023-05-10 09:16:56.638072');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1056, 'Emmikhoven en Waardhuizen', 740, NULL, 18790715, '2023-05-10 09:16:56.639274');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1057, 'Escharen', 786, NULL, 19420701, '2023-05-10 09:16:56.640724');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1058, 'Gameren', 257, NULL, 19550701, '2023-05-10 09:16:56.641964');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1059, 'Gassel', 747, NULL, 19420801, '2023-05-10 09:16:56.643157');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1060, 'Genderen', 771, 19080801, 19230501, '2023-05-10 09:16:56.644329');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1061, 'Gestel en Blaarthem', 772, NULL, 19200101, '2023-05-10 09:16:56.645601');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1062, 'Giessen-Nieuwkerk', 510, NULL, 19570101, '2023-05-10 09:16:56.646878');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1063, 'Giessendam', 523, NULL, 19570101, '2023-05-10 09:16:56.648067');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1064, 'Ginneken en Bavel', 817, NULL, 19420101, '2023-05-10 09:16:56.64931');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1065, 'Grafhorst', 191, NULL, 19370101, '2023-05-10 09:16:56.650603');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1066, 'Groote Lindt', 642, NULL, 18810906, '2023-05-10 09:16:56.65209');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1067, 'Grijpskerke', 686, NULL, 19660701, '2023-05-10 09:16:56.65354');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1068, 'Haamstede', 725, NULL, 19610101, '2023-05-10 09:16:56.654761');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1069, 'Haarzuilens', 347, NULL, 19540101, '2023-05-10 09:16:56.656182');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1070, 'Hardinxveld', 523, NULL, 19570101, '2023-05-10 09:16:56.657405');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1071, 'Hedikhuizen', 797, NULL, 19350501, '2023-05-10 09:16:56.658738');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1072, 'Heeswijk', 792, NULL, 19690101, '2023-05-10 09:16:56.660164');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1073, 'Heille', 713, NULL, 18800423, '2023-05-10 09:16:56.661809');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1074, 'Hekelingen', 612, NULL, 19660501, '2023-05-10 09:16:56.663201');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1075, 'Hekendorp', 506, NULL, 19640201, '2023-05-10 09:16:56.664441');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1076, 'Hemmen', 283, NULL, 19550701, '2023-05-10 09:16:56.665714');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1077, 'Hengstdijk', 719, NULL, 19360701, '2023-05-10 09:16:56.667012');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1078, 'Herkingen', 504, NULL, 19660101, '2023-05-10 09:16:56.668264');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1079, 'Herpen', 835, NULL, 19410401, '2023-05-10 09:16:56.669463');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1080, 'Herpt', 797, NULL, 19350501, '2023-05-10 09:16:56.670656');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1081, 'Hillegersberg', 599, NULL, 19410801, '2023-05-10 09:16:56.672006');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1082, 'Hof van Delft', 503, NULL, 19210101, '2023-05-10 09:16:56.673211');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1083, 'Hoogezand', 18, NULL, 19490401, '2023-05-10 09:16:56.674296');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1084, 'Hoogkerk', 14, NULL, 19690101, '2023-05-10 09:16:56.675508');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1085, 'Hoogvliet', 599, NULL, 19340501, '2023-05-10 09:16:56.677002');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1086, 'Houthem', 982, NULL, 19401001, '2023-05-10 09:16:56.67851');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1087, 'Houtrijk en Polanen', 393, NULL, 18630922, '2023-05-10 09:16:56.679672');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1088, 'Huisseling en Neerloon', 835, NULL, 19230501, '2023-05-10 09:16:56.680861');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1089, 'Hurwenen', 276, NULL, 19550701, '2023-05-10 09:16:56.682066');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1090, 'Ittervoort', 925, NULL, 19420701, '2023-05-10 09:16:56.683315');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1091, 'Jaarsveld', 331, NULL, 19430101, '2023-05-10 09:16:56.684859');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1092, 'Kamperveen', 191, NULL, 19370101, '2023-05-10 09:16:56.686005');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1093, 'Katendrecht', 1037, NULL, 18740101, '2023-05-10 09:16:56.687352');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1094, 'Kats', 682, NULL, 19410401, '2023-05-10 09:16:56.68858');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1095, 'Kerkwerve', 688, NULL, 19610101, '2023-05-10 09:16:56.689962');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1096, 'Kethel en Spaland', 606, NULL, 19410801, '2023-05-10 09:16:56.691264');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1097, 'Kortenhoef', 390, NULL, 19660801, '2023-05-10 09:16:56.692675');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1098, 'Koudekerke', 720, NULL, 19660701, '2023-05-10 09:16:56.694215');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1099, 'Kralingen', 599, NULL, 18950228, '2023-05-10 09:16:56.695498');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1100, 'Laag-Nieuwkoop', 324, NULL, 19420501, '2023-05-10 09:16:56.696833');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1101, 'Lange Ruige Weide', 506, NULL, 19640201, '2023-05-10 09:16:56.697909');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1102, 'Lierop', 847, NULL, 19350501, '2023-05-10 09:16:56.699135');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1103, 'Linden', 747, NULL, 19420801, '2023-05-10 09:16:56.700294');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1104, 'Lithoijen', 808, NULL, 19390101, '2023-05-10 09:16:56.750808');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1105, 'Loenersloot', 311, NULL, 19640401, '2023-05-10 09:16:56.752342');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1106, 'Lonneker', 153, NULL, 19340501, '2023-05-10 09:16:56.753567');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1107, 'Loosduinen', 518, NULL, 19230701, '2023-05-10 09:16:56.754752');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1108, 'Maarsseveen', 333, NULL, 19490701, '2023-05-10 09:16:56.756208');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1109, 'Maashees en Overloon', 863, NULL, 19420501, '2023-05-10 09:16:56.75766');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1110, 'Maasniel', 957, NULL, 19590801, '2023-05-10 09:16:56.758923');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1111, 'Meeuwen', 771, NULL, 19230501, '2023-05-10 09:16:56.760223');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1112, 'Meliskerke', 686, NULL, 19660701, '2023-05-10 09:16:56.761432');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1113, 'Melissant', 504, NULL, 19660101, '2023-05-10 09:16:56.762622');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1114, 'Mesch', 905, NULL, 19430101, '2023-05-10 09:16:56.763855');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1115, 'Nederhemert', 257, NULL, 19550701, '2023-05-10 09:16:56.765277');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1116, 'Neeritter', 925, NULL, 19420701, '2023-05-10 09:16:56.766758');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1117, 'Nieuw- en Sint Joosland', 687, NULL, 19660701, '2023-05-10 09:16:56.768019');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1118, 'Nieuw-Helvoet', 530, NULL, 19600101, '2023-05-10 09:16:56.769219');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1119, 'Nieuwe Tonge', 559, NULL, 19660101, '2023-05-10 09:16:56.770541');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1120, 'Nieuwendam', 363, NULL, 19210101, '2023-05-10 09:16:56.771976');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1121, 'Nieuwenhoorn', 530, NULL, 19600101, '2023-05-10 09:16:56.773464');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1122, 'Nieuwerkerk', 662, NULL, 19610101, '2023-05-10 09:16:56.775051');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1123, 'Nieuwkuijk', 864, NULL, 19350501, '2023-05-10 09:16:56.776531');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1124, 'Noord-Scharwoude', 416, NULL, 19410801, '2023-05-10 09:16:56.777906');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1125, 'Noord-Waddinxveen', 627, NULL, 18700701, '2023-05-10 09:16:56.779076');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1126, 'Noordbroek', 33, NULL, 19650701, '2023-05-10 09:16:56.780334');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1127, 'Noorddijk', 14, NULL, 19690101, '2023-05-10 09:16:56.781526');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1128, 'Noordgouwe', 656, NULL, 19610101, '2023-05-10 09:16:56.782675');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1129, 'Noordwelle', 725, NULL, 19610101, '2023-05-10 09:16:56.783829');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1130, 'Nunhem', 914, NULL, 19421001, '2023-05-10 09:16:56.78494');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1131, 'Odijk', 312, NULL, 19640901, '2023-05-10 09:16:56.786158');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1132, 'Oerle', 861, NULL, 19210501, '2023-05-10 09:16:56.788281');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1133, 'Ooltgensplaat', 580, NULL, 19660101, '2023-05-10 09:16:56.789788');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1134, 'Oost- en West-Barendrecht', 489, 18360101, 18860101, '2023-05-10 09:16:56.791071');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1135, 'Oost- en West-Souburg', 718, NULL, 19660701, '2023-05-10 09:16:56.792254');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1136, 'Oosterland', 662, NULL, 19610101, '2023-05-10 09:16:56.7936');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1137, 'Oostkapelle', 660, NULL, 19660701, '2023-05-10 09:16:56.794882');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1138, 'Ossenisse', 719, NULL, 19360701, '2023-05-10 09:16:56.796156');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1139, 'Oud- en Nieuw-Mathenesse', 606, NULL, 18680101, '2023-05-10 09:16:56.797499');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1140, 'Oud-Valkenburg', 982, NULL, 19401001, '2023-05-10 09:16:56.798713');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1141, 'Oud-Vroenhoven', 935, NULL, 19200101, '2023-05-10 09:16:56.800176');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1142, 'Ouddorp', 511, NULL, 19660101, '2023-05-10 09:16:56.801529');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1143, 'Oude-Tonge', 580, NULL, 19660101, '2023-05-10 09:16:56.803054');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1144, 'Oudenrijn', 347, NULL, 19540101, '2023-05-10 09:16:56.80437');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1145, 'Oudheusden', 797, NULL, 19350501, '2023-05-10 09:16:56.805574');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1146, 'Oudkarspel', 416, NULL, 19410801, '2023-05-10 09:16:56.806768');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1147, 'Oudshoorn', 484, NULL, 19180101, '2023-05-10 09:16:56.808249');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1148, 'Ouwerkerk', 662, NULL, 19610101, '2023-05-10 09:16:56.809394');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1149, 'Overschie', 599, NULL, 19410801, '2023-05-10 09:16:56.810805');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1150, 'Oijen en Teeffelen', 808, NULL, 19390101, '2023-05-10 09:16:56.812028');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1151, 'Papekop', 506, NULL, 19640201, '2023-05-10 09:16:56.813411');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1152, 'Pernis', 599, NULL, 19340501, '2023-05-10 09:16:56.814622');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1153, 'Petten', 476, NULL, 19290501, '2023-05-10 09:16:56.815783');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1154, 'Peursum', 510, NULL, 19570101, '2023-05-10 09:16:56.816964');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1155, 'Poederoijen', 212, NULL, 19550701, '2023-05-10 09:16:56.818413');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1156, 'Princenhage', 1247, NULL, 19420101, '2023-05-10 09:16:56.819619');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1157, 'Ransdorp', 363, NULL, 19210101, '2023-05-10 09:16:56.821077');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1158, 'Reek', 843, NULL, 19420701, '2023-05-10 09:16:56.822203');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1159, 'Renesse', 725, NULL, 19610101, '2023-05-10 09:16:56.823486');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1160, 'Rietveld', 632, NULL, 19640201, '2023-05-10 09:16:56.824789');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1161, 'Rilland', 702, NULL, 18780101, '2023-05-10 09:16:56.82608');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1162, 'Rimburg', 978, NULL, 18870315, '2023-05-10 09:16:56.827319');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1163, 'Ritthem', 718, NULL, 19660701, '2023-05-10 09:16:56.82851');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1164, 'Ruwiel', 311, NULL, 19640401, '2023-05-10 09:16:56.829825');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1165, 'Rijckholt', 911, NULL, 19430101, '2023-05-10 09:16:56.830995');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1166, 'Rijsenburg', 316, NULL, 19310501, '2023-05-10 09:16:56.832185');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1167, 'Sambeek', 756, NULL, 19420501, '2023-05-10 09:16:56.833382');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1168, 'Sappemeer', 18, NULL, 19490401, '2023-05-10 09:16:56.834678');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1169, 'Schalkwijk', 321, NULL, 19620101, '2023-05-10 09:16:56.835883');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1170, 'Schiebroek', 599, NULL, 19410801, '2023-05-10 09:16:56.837041');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1171, 'Schin op Geul', 982, NULL, 19401001, '2023-05-10 09:16:56.838195');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1172, 'Schore', 678, NULL, 19410101, '2023-05-10 09:16:56.839418');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1173, 'Schoten', 392, NULL, 19270501, '2023-05-10 09:16:56.840614');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1174, 'Schoterland', 74, NULL, 19340701, '2023-05-10 09:16:56.841828');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1175, 'Serooskerke (Schouwen)', 725, NULL, 19610101, '2023-05-10 09:16:56.843316');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1176, 'Serooskerke (Walcheren)', 717, NULL, 19660701, '2023-05-10 09:16:56.845149');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1177, 'St. Anna ter Muiden', 713, NULL, 18800423, '2023-05-10 09:16:56.846557');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1178, 'Sint Kruis', 648, NULL, 19410401, '2023-05-10 09:16:56.847806');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1179, 'Sint Laurens', 687, NULL, 19660701, '2023-05-10 09:16:56.849188');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1180, 'Sint Pieter', 935, NULL, 19200101, '2023-05-10 09:16:56.850335');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1181, 'Sloten (NH)', 363, NULL, 19210101, '2023-05-10 09:16:56.901238');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1182, 'Sluipwijk', 595, NULL, 18700701, '2023-05-10 09:16:56.902635');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1183, 'Soerendonk, Sterksel en Gastel', 811, NULL, 19250101, '2023-05-10 09:16:56.903897');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1184, 'Sommelsdijk', 559, NULL, 19660101, '2023-05-10 09:16:56.905109');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1185, 'Spaarndam', 392, NULL, 19270501, '2023-05-10 09:16:56.906568');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1186, 'Spanbroek', 432, NULL, 19590701, '2023-05-10 09:16:56.908346');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1187, 'Sprang', 849, NULL, 19230101, '2023-05-10 09:16:56.909739');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1188, 'Stad aan ''t Haringvliet', 559, NULL, 19660101, '2023-05-10 09:16:56.911281');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1189, 'Stad-Almelo', 141, NULL, 19140101, '2023-05-10 09:16:56.912662');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1190, 'Stad-Doetinchem', 222, NULL, 19200101, '2023-05-10 09:16:56.914069');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1191, 'Stad-Hardenberg', 160, NULL, 19410501, '2023-05-10 09:16:56.915309');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1192, 'Stad-Ommen', 175, NULL, 19230501, '2023-05-10 09:16:56.916453');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1193, 'Stad-Vollenhove', 185, NULL, 19420201, '2023-05-10 09:16:56.917733');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1194, 'Stein (ZH)', 595, NULL, 18700701, '2023-05-10 09:16:56.919134');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1195, 'Stellendam', 511, NULL, 19660101, '2023-05-10 09:16:56.920264');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1196, 'Stiphout', 794, NULL, 19680101, '2023-05-10 09:16:56.921528');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1197, 'Stompwijk', 548, NULL, 19380101, '2023-05-10 09:16:56.922747');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1198, 'Stoppeldijk', 719, NULL, 19360701, '2023-05-10 09:16:56.923964');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1199, 'Stratum', 772, NULL, 19200101, '2023-05-10 09:16:56.925279');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1200, 'Strucht', 1171, NULL, 18790102, '2023-05-10 09:16:56.926511');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1201, 'Strijp', 772, NULL, 19200101, '2023-05-10 09:16:56.927661');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1202, 'Tienhoven (U)', 333, NULL, 19570701, '2023-05-10 09:16:56.928931');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1203, 'Tongelre', 772, NULL, 19200101, '2023-05-10 09:16:56.93022');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1204, 'Tudderen', NULL, 19490422, 19630801, '2023-05-10 09:16:56.931498');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1205, 'Tull en ''t Waal', 321, NULL, 19620101, '2023-05-10 09:16:56.932704');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1206, 'Veldhoven en Meerveldhoven', 861, NULL, 19210501, '2023-05-10 09:16:56.933806');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1207, 'Veldhuizen', 347, NULL, 19540101, '2023-05-10 09:16:56.935081');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1208, 'Velp', 786, NULL, 19420701, '2023-05-10 09:16:56.936321');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1209, 'Veur', 548, NULL, 19380101, '2023-05-10 09:16:56.937623');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1210, 'Vlaardinger-Ambacht', 622, NULL, 19410801, '2023-05-10 09:16:56.938723');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1211, 'Vleuten', 347, NULL, 19540101, '2023-05-10 09:16:56.940167');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1212, 'Vlierden', 762, NULL, 19260101, '2023-05-10 09:16:56.941359');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1213, 'Vreeland', 329, NULL, 19640401, '2023-05-10 09:16:56.942617');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1214, 'Vrouwenpolder', 717, NULL, 19660701, '2023-05-10 09:16:56.944144');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1215, 'Vrijenban', 503, NULL, 19210101, '2023-05-10 09:16:56.945372');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1216, 'Vrijhoeve-Capelle', 849, NULL, 19230101, '2023-05-10 09:16:56.946775');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1217, 'Waarder', 506, NULL, 19640201, '2023-05-10 09:16:56.948006');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1218, 'Wadenoijen', 281, NULL, 19560701, '2023-05-10 09:16:56.949288');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1219, 'Watergraafsmeer', 363, NULL, 19210101, '2023-05-10 09:16:56.950478');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1220, 'Wedde', 7, NULL, 19680901, '2023-05-10 09:16:56.951631');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1221, 'Weesperkarspel', 363, NULL, 19660801, '2023-05-10 09:16:56.953066');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1222, 'de Werken en Sleeuwijk', 870, NULL, 19501001, '2023-05-10 09:16:56.954213');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1223, 'Werkhoven', 312, NULL, 19640901, '2023-05-10 09:16:56.955526');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1224, 'Westbroek', 334, NULL, 19570701, '2023-05-10 09:16:56.956673');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1225, 'Wildervank', 47, NULL, 19690101, '2023-05-10 09:16:56.957863');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1226, 'Willige-Langerak', 331, NULL, 19430101, '2023-05-10 09:16:56.959003');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1227, 'Wilsum', 191, NULL, 19370101, '2023-05-10 09:16:56.960233');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1228, 'Woensel', 772, NULL, 19200101, '2023-05-10 09:16:57.020835');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1229, 'Wijk aan Zee en Duin', 375, NULL, 19360501, '2023-05-10 09:16:57.022379');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1230, 'IJsselmonde', 599, NULL, 19410801, '2023-05-10 09:16:57.023999');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1231, 'IJzendoorn', 227, NULL, 19230501, '2023-05-10 09:16:57.025444');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1232, 'Zalk en Veecaten', 191, NULL, 19370101, '2023-05-10 09:16:57.026812');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1233, 'Zeelst', 861, NULL, 19210501, '2023-05-10 09:16:57.028045');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1234, 'Zegwaart', 637, NULL, 19350501, '2023-05-10 09:16:57.029384');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1235, 'Zesgehuchten', 781, NULL, 19210501, '2023-05-10 09:16:57.030809');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1236, 'Zonnemaire', 656, NULL, 19610101, '2023-05-10 09:16:57.032077');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1237, 'Zoutelande', 720, NULL, 19660701, '2023-05-10 09:16:57.033411');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1238, 'Zuid-Scharwoude', 416, NULL, 19410801, '2023-05-10 09:16:57.034679');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1239, 'Zuid-Waddinxveen', 627, NULL, 18700701, '2023-05-10 09:16:57.035878');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1240, 'Zuidbroek', 33, NULL, 19650701, '2023-05-10 09:16:57.037194');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1241, 'Zuidschalkwijk', 393, NULL, 18630922, '2023-05-10 09:16:57.038533');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1242, 'Zuilen', 344, NULL, 19540101, '2023-05-10 09:16:57.039948');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1243, 'Zuilichem', 212, NULL, 19550701, '2023-05-10 09:16:57.041083');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1244, 'Zwammerdam', 484, NULL, 19640201, '2023-05-10 09:16:57.042452');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1245, 'Zwollerkerspel', 193, NULL, 19670801, '2023-05-10 09:16:57.043756');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1246, 'Bangert', 498, 19790101, 19800101, '2023-05-10 09:16:57.04513');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1247, 'Beek (NB)', 832, 19420101, 19510101, '2023-05-10 09:16:57.046502');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1248, 'Driel', 263, NULL, 19440801, '2023-05-10 09:16:57.047781');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1249, 'Nieuwer-Amstel', 362, NULL, 19640101, '2023-05-10 09:16:57.049244');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1250, 'Onstwedde', 37, NULL, 19690101, '2023-05-10 09:16:57.050681');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1251, 'Etten en Leur', 777, NULL, 19680101, '2023-05-10 09:16:57.051871');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1252, 'Valkenburg (L)', 982, NULL, 19410715, '2023-05-10 09:16:57.053032');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1253, 'Wissekerke', 670, NULL, 19580801, '2023-05-10 09:16:57.054382');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1254, 'Borssele', 654, NULL, 19700101, '2023-05-10 09:16:57.055637');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1255, 'Eethen, Genderen en Heesbeen', 1060, NULL, 19080801, '2023-05-10 09:16:57.057132');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1256, 'Koudekerk', 540, NULL, 19380101, '2023-05-10 09:16:57.058367');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1257, 'Staveren', 92, 19390101, 19790101, '2023-05-10 09:16:57.059838');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1258, 'Rijsoort en Strevelshoek', 597, 18460101, 18550901, '2023-05-10 09:16:57.061283');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1259, 'Millingen', 265, NULL, 19550101, '2023-05-10 09:16:57.062544');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1260, 'Hemelumer Oldephaert en Noordwolde', 75, NULL, 19560101, '2023-05-10 09:16:57.063746');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1261, 'Simonshaven', 509, NULL, 18550901, '2023-05-10 09:16:57.064926');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1262, 'Bleskensgraaf', 496, NULL, 18550901, '2023-05-10 09:16:57.066103');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1263, 'Drongelen, Hangoort,Gansoyen en Doeveren', 1049, NULL, 19080801, '2023-05-10 09:16:57.067356');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1264, 'Dussen, Munster en Muilkerk', 769, NULL, 19080801, '2023-05-10 09:16:57.068581');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1265, 'Meeuwen, Hill en Babyloniënbroek', 1111, NULL, 19080801, '2023-05-10 09:16:57.069766');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1301, 'Abtsregt', 1215, NULL, 18550901, '2023-05-10 09:16:57.071032');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1302, 'Achthoven', 328, NULL, 18570908, '2023-05-10 09:16:57.072467');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1303, 'Achttienhoven (bij Nieuwkoop)', 569, NULL, 18550901, '2023-05-10 09:16:57.07378');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1304, 'Ackersdijk en Vrouwenregt', 1215, NULL, 18550901, '2023-05-10 09:16:57.074998');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1305, 'Benthorn', 490, NULL, 18460101, '2023-05-10 09:16:57.076423');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1306, 'Berkenrode', 397, NULL, 18580101, '2023-05-10 09:16:57.078097');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1307, 'Biert', 509, NULL, 18550901, '2023-05-10 09:16:57.079517');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1308, 'Biesland', 1215, NULL, 18330101, '2023-05-10 09:16:57.080952');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1309, 'Bijlmermeer', 1221, NULL, 18460101, '2023-05-10 09:16:57.082119');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1310, 'Cabauw', 1226, NULL, 18570908, '2023-05-10 09:16:57.083369');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1311, 'Cillaarshoek', 554, NULL, 18320101, '2023-05-10 09:16:57.084688');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1312, 'Darthuizen', 326, NULL, 18570908, '2023-05-10 09:16:57.085883');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1313, 'Dorth', 239, NULL, 18310701, '2023-05-10 09:16:57.087292');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1314, 'Duist', 320, NULL, 18570908, '2023-05-10 09:16:57.088428');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1315, 'Edam', 385, NULL, 19750101, '2023-05-10 09:16:57.089691');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1316, 'Etersheim', 430, NULL, 18480101, '2023-05-10 09:16:57.090958');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1317, 'Gapinge', 1214, NULL, 18571002, '2023-05-10 09:16:57.092225');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1318, 'Gerverscop', 318, NULL, 18570908, '2023-05-10 09:16:57.093332');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1319, 'Goidschalxoord', 528, NULL, 18550901, '2023-05-10 09:16:57.094486');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1320, '''s-Gravenambacht', 1152, NULL, 18340101, '2023-05-10 09:16:57.095708');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1321, '''s-Gravesloot', 323, NULL, 18570908, '2023-05-10 09:16:57.096843');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1322, 'Groeneveld', 1082, NULL, 18550901, '2023-05-10 09:16:57.098086');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1323, 'Groet', 444, NULL, 18340101, '2023-05-10 09:16:57.099414');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1324, 'Grosthuizen', 368, NULL, 18540531, '2023-05-10 09:16:57.100729');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1325, 'Haarlemmerliede', 393, NULL, 18570908, '2023-05-10 09:16:57.103754');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1326, '''s Heer Hendriks Kinderen', 670, NULL, 18570801, '2023-05-10 09:16:57.136462');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1327, 'Heer Oudelands Ambacht', 1066, NULL, 18570819, '2023-05-10 09:16:57.138728');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1328, 'Hodenpijl', 607, NULL, 18550901, '2023-05-10 09:16:57.140966');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1329, 'Hofwegen', 496, NULL, 18550901, '2023-05-10 09:16:57.143321');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1330, 'Hoog en Woud Harnasch', 1082, NULL, 18330101, '2023-05-10 09:16:57.14515');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1331, 'Hoogeveen in Delfland', 577, NULL, 18320101, '2023-05-10 09:16:57.146924');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1332, 'Hoogeveen in Rijnland', 490, NULL, 18550901, '2023-05-10 09:16:57.148781');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1333, 'Hoogmade', 633, NULL, 18550917, '2023-05-10 09:16:57.150493');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1334, 'Kalslagen', 549, NULL, 18540531, '2023-05-10 09:16:57.152405');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1335, 'Kamerik Houtdijken', 323, NULL, 18570908, '2023-05-10 09:16:57.154143');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1336, 'Kamerik Mijzijde', 323, NULL, 18570908, '2023-05-10 09:16:57.156059');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1337, 'Kijfhoek', 1066, NULL, 18570819, '2023-05-10 09:16:57.157615');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1338, 'Kleine Lindt', 526, NULL, 18570613, '2023-05-10 09:16:57.159321');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1339, 'Kleverskerke', 649, NULL, 18571002, '2023-05-10 09:16:57.161076');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1340, 'Laagblokland', 582, NULL, 18580101, '2023-05-10 09:16:57.211144');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1341, 'Loenen en Wolveren', 283, NULL, 18540420, '2023-05-10 09:16:57.212698');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1342, 'Maarssenbroek', 333, NULL, 18570908, '2023-05-10 09:16:57.214248');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1343, 'Meerdervoort', 642, NULL, 18550901, '2023-05-10 09:16:57.215566');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1344, 'Middelburg (ZH)', 595, NULL, 18550901, '2023-05-10 09:16:57.217176');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1345, 'De Mijl', 507, NULL, 18570131, '2023-05-10 09:16:57.21891');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1346, 'Naters', 598, NULL, 18560101, '2023-05-10 09:16:57.220492');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1347, 'Nederslingelandt', 1154, NULL, 18570819, '2023-05-10 09:16:57.221791');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1348, 'Nieuwland, Kortland en ''s-Graveland', 1096, NULL, 18560101, '2023-05-10 09:16:57.223012');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1349, 'Nieuwveen in Delfland', 577, NULL, 18320101, '2023-05-10 09:16:57.224372');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1350, 'Noord-Polsbroek', 338, NULL, 18570908, '2023-05-10 09:16:57.225756');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1351, 'Onwaard', 1113, NULL, 18580101, '2023-05-10 09:16:57.227135');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1352, 'Oost-Barendrecht', 1134, NULL, 18360101, '2023-05-10 09:16:57.22846');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1353, 'Oost-Souburg', 1135, NULL, 18340101, '2023-05-10 09:16:57.229681');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1355, 'Oud-Wulven', 321, NULL, 18580101, '2023-05-10 09:16:57.231178');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1356, 'Oude en Nieuwe Struiten', 1118, NULL, 18550901, '2023-05-10 09:16:57.232391');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1357, 'Oudhuizen', 350, NULL, 18580101, '2023-05-10 09:16:57.233573');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1358, 'Oukoop', 1075, NULL, 18570819, '2023-05-10 09:16:57.234897');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1359, 'Portengen', 1028, NULL, 18590101, '2023-05-10 09:16:57.236225');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1360, 'Rhijnauwen', 312, NULL, 18570908, '2023-05-10 09:16:57.237525');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1361, 'Rietwijkeroord', 1249, NULL, 18540623, '2023-05-10 09:16:57.238692');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1362, 'Rijsoort', 1258, NULL, 18550101, '2023-05-10 09:16:57.239873');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1363, 'Roxenisse', 1113, NULL, 18580101, '2023-05-10 09:16:57.241363');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1364, 'Ruijven', 594, NULL, 18460101, '2023-05-10 09:16:57.242889');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1365, 'Sandelingen-Ambacht', 531, NULL, 18550901, '2023-05-10 09:16:57.244125');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1366, 'Schardam', 371, NULL, 18540531, '2023-05-10 09:16:57.245331');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1367, 'Scharwoude', 368, NULL, 18540531, '2023-05-10 09:16:57.246666');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1368, 'Schellingwoude', 1157, NULL, 18570919, '2023-05-10 09:16:57.247865');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1369, 'Schokland', 166, NULL, 18580901, '2023-05-10 09:16:57.24903');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1370, 'Schonauwen', 321, NULL, 18580101, '2023-05-10 09:16:57.250408');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1371, 'Schuddebeurs en Simonshaven', 509, NULL, 18550711, '2023-05-10 09:16:57.251702');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1372, 'Sint Anthonypolder', 554, NULL, 18320101, '2023-05-10 09:16:57.253006');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1373, 'St. Maartensregt', 607, NULL, 18550901, '2023-05-10 09:16:57.254272');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1374, 'Spaarnwoude', 393, NULL, 18570908, '2023-05-10 09:16:57.255557');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1375, 'Spijk', 533, NULL, 18550901, '2023-05-10 09:16:57.256799');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1376, 'Steenbergen en Kruisland', 851, NULL, 19620625, '2023-05-10 09:16:57.258015');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1377, 'Sterkenburg', 1048, NULL, 18570908, '2023-05-10 09:16:57.259141');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1378, 'Stormpolder', 542, NULL, 18550901, '2023-05-10 09:16:57.260319');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1380, 'Strevelshoek', 1258, NULL, 18460101, '2023-05-10 09:16:57.310853');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1381, 'Strijensas', 617, NULL, 18550901, '2023-05-10 09:16:57.312314');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1382, 'Teckop', 323, NULL, 18570908, '2023-05-10 09:16:57.31366');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1383, 'Tempel', 493, NULL, 18580711, '2023-05-10 09:16:57.315061');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1384, 'Veenhuizen', 398, NULL, 18540413, '2023-05-10 09:16:57.316348');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1385, 'De Vennip', 534, NULL, 18550815, '2023-05-10 09:16:57.317591');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1386, 'Verwolde', 259, NULL, 18540522, '2023-05-10 09:16:57.319088');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1387, 'Vinkeveen', 346, NULL, 18410101, '2023-05-10 09:16:57.320299');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1388, 'Vliet', 521, NULL, 18460101, '2023-05-10 09:16:57.321591');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1390, 'Vrije en Lage Boekhorst', 483, NULL, 18550815, '2023-05-10 09:16:57.323496');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1391, 'Vrijhoeven', 480, NULL, 18400710, '2023-05-10 09:16:57.324993');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1392, 'de Vuursche', 308, NULL, 18571201, '2023-05-10 09:16:57.326299');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1393, 'Waverveen', 346, NULL, 18410101, '2023-05-10 09:16:57.327629');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1394, 'West-Barendrecht', 1134, NULL, 18360101, '2023-05-10 09:16:57.328875');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1395, 'West-Souburg', 1135, NULL, 18340101, '2023-05-10 09:16:57.33013');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1396, 'Wieldrecht', 507, NULL, 18570131, '2023-05-10 09:16:57.331539');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1397, 'Wimmenum', 387, NULL, 18570713, '2023-05-10 09:16:57.332799');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1398, 'Wulverhorst', 328, NULL, 18570908, '2023-05-10 09:16:57.334084');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1399, 'Zevender', 1226, NULL, 18570908, '2023-05-10 09:16:57.335379');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1400, 'Zouteveen', 1210, NULL, 18550901, '2023-05-10 09:16:57.336684');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1401, 'Zuid-Polsbroek', 338, NULL, 18570908, '2023-05-10 09:16:57.337935');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1402, 'Zuidbroek (ZH)', 491, NULL, 18570613, '2023-05-10 09:16:57.339115');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1403, 'Zuidwijk', 499, NULL, 18460101, '2023-05-10 09:16:57.340307');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1404, 'de Noordoostelijke Polder', 171, NULL, 19620701, '2023-05-10 09:16:57.391199');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1507, 'Horst aan de Maas', NULL, 20010101, NULL, '2023-05-10 09:16:57.393201');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1509, 'Oude IJsselstreek', NULL, 20050101, NULL, '2023-05-10 09:16:57.394608');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1525, 'Teylingen', NULL, 20060101, NULL, '2023-05-10 09:16:57.395829');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1581, 'Utrechtse Heuvelrug', NULL, 20060101, NULL, '2023-05-10 09:16:57.39724');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1586, 'Oost Gelre', NULL, 20060519, NULL, '2023-05-10 09:16:57.398573');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1598, 'Koggenland', NULL, 20070101, NULL, '2023-05-10 09:16:57.399953');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1621, 'Lansingerland', NULL, 20070101, NULL, '2023-05-10 09:16:57.401343');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1640, 'Leudal', NULL, 20070101, NULL, '2023-05-10 09:16:57.402563');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1641, 'Maasgouw', NULL, 20070101, NULL, '2023-05-10 09:16:57.403787');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1651, 'Eemsmond', 1966, 19920101, 20190101, '2023-05-10 09:16:57.404993');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1652, 'Gemert-Bakel', NULL, 19970101, NULL, '2023-05-10 09:16:57.40639');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1655, 'Halderberge', NULL, 19970101, NULL, '2023-05-10 09:16:57.40755');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1658, 'Heeze-Leende', NULL, 19970101, NULL, '2023-05-10 09:16:57.40884');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1659, 'Laarbeek', NULL, 19970101, NULL, '2023-05-10 09:16:57.410145');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1661, 'Reiderland', 1895, 19910701, 20100101, '2023-05-10 09:16:57.411615');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1663, 'De Marne', 1966, 19920101, 20190101, '2023-05-10 09:16:57.412822');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1665, 'Made', 1719, 19970101, 19980425, '2023-05-10 09:16:57.414043');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1666, 'Zevenhuizen-Moerkapelle', 1892, 19920201, 20100101, '2023-05-10 09:16:57.415414');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1667, 'Reusel-De Mierden', NULL, 19970101, NULL, '2023-05-10 09:16:57.416554');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1669, 'Roerdalen', NULL, 19930101, NULL, '2023-05-10 09:16:57.417847');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1670, 'Roggel en Neer', 1640, 19930101, 20070101, '2023-05-10 09:16:57.419166');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1671, 'Maasdonk', 796, 19930101, 20150101, '2023-05-10 09:16:57.420633');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1672, 'Rijnwoude', 484, 19930101, 20140101, '2023-05-10 09:16:57.422108');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1673, 'Liemeer', 569, 19940101, 20070101, '2023-05-10 09:16:57.42356');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1674, 'Roosendaal', NULL, 19970101, NULL, '2023-05-10 09:16:57.424748');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1676, 'Schouwen-Duiveland', NULL, 19970101, NULL, '2023-05-10 09:16:57.425959');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1679, 'Ambt Montfort', 1669, 19940201, 20070101, '2023-05-10 09:16:57.42736');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1680, 'Aa en Hunze', NULL, 19980101, NULL, '2023-05-10 09:16:57.42866');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1681, 'Borger-Odoorn', NULL, 19980101, NULL, '2023-05-10 09:16:57.430051');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1684, 'Cuijk', 1982, 19940101, 20220101, '2023-05-10 09:16:57.43137');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1685, 'Landerd', 1991, 19940101, 20220101, '2023-05-10 09:16:57.432674');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1690, 'De Wolden', NULL, 19980101, NULL, '2023-05-10 09:16:57.434128');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1691, 'St. Anthonis', 1702, 19940101, 19950704, '2023-05-10 09:16:57.435562');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1695, 'Noord-Beveland', NULL, 19950101, NULL, '2023-05-10 09:16:57.436746');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1696, 'Wijdemeren', NULL, 20020101, NULL, '2023-05-10 09:16:57.437917');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1697, 'Middenveld', 1731, 19980101, 20000101, '2023-05-10 09:16:57.439094');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1698, 'Sluis-Aardenburg', 1714, 19950101, 20030101, '2023-05-10 09:16:57.440418');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1699, 'Noordenveld', NULL, 19980101, NULL, '2023-05-10 09:16:57.500856');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1700, 'Twenterand', NULL, 20020601, NULL, '2023-05-10 09:16:57.502445');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1701, 'Westerveld', NULL, 19980101, NULL, '2023-05-10 09:16:57.503682');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1702, 'Sint Anthonis', 1982, 19950704, 20220101, '2023-05-10 09:16:57.504923');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1705, 'Lingewaard', NULL, 20030101, NULL, '2023-05-10 09:16:57.506282');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1706, 'Cranendonck', NULL, 19980128, NULL, '2023-05-10 09:16:57.507547');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1708, 'Steenwijkerland', NULL, 20030101, NULL, '2023-05-10 09:16:57.509084');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1709, 'Moerdijk', NULL, 19980401, NULL, '2023-05-10 09:16:57.511332');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1711, 'Echt-Susteren', NULL, 20030101, NULL, '2023-05-10 09:16:57.51302');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1714, 'Sluis', NULL, 20030101, NULL, '2023-05-10 09:16:57.514753');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1719, 'Drimmelen', NULL, 19980425, NULL, '2023-05-10 09:16:57.516243');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1721, 'Bernheze', NULL, 19950128, NULL, '2023-05-10 09:16:57.517487');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1722, 'Ferwerderadiel', 1970, 19990101, 20190101, '2023-05-10 09:16:57.518663');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1723, 'Alphen-Chaam', NULL, 19970101, NULL, '2023-05-10 09:16:57.520013');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1724, 'Bergeijk', NULL, 19990101, NULL, '2023-05-10 09:16:57.52108');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1728, 'Bladel', NULL, 19970101, NULL, '2023-05-10 09:16:57.52229');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1729, 'Gulpen-Wittem', NULL, 19990101, NULL, '2023-05-10 09:16:57.523446');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1730, 'Tynaarlo', NULL, 19991201, NULL, '2023-05-10 09:16:57.524795');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1731, 'Midden-Drenthe', NULL, 20000101, NULL, '2023-05-10 09:16:57.52635');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1734, 'Overbetuwe', NULL, 20010101, NULL, '2023-05-10 09:16:57.527785');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1735, 'Hof van Twente', NULL, 20010101, NULL, '2023-05-10 09:16:57.529024');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1740, 'Neder-Betuwe', NULL, 20030401, NULL, '2023-05-10 09:16:57.53018');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1742, 'Rijssen-Holten', NULL, 20030315, NULL, '2023-05-10 09:16:57.531377');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1771, 'Geldrop-Mierlo', NULL, 20040101, NULL, '2023-05-10 09:16:57.532949');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1773, 'Olst-Wijhe', NULL, 20020326, NULL, '2023-05-10 09:16:57.534165');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1774, 'Dinkelland', NULL, 20020601, NULL, '2023-05-10 09:16:57.535404');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1783, 'Westland', NULL, 20040101, NULL, '2023-05-10 09:16:57.536681');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1842, 'Midden-Delfland', NULL, 20040101, NULL, '2023-05-10 09:16:57.537939');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1859, 'Berkelland', NULL, 20050101, NULL, '2023-05-10 09:16:57.539285');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1876, 'Bronckhorst', NULL, 20050101, NULL, '2023-05-10 09:16:57.540552');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1883, 'Sittard-Geleen', NULL, 20010101, NULL, '2023-05-10 09:16:57.542164');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1884, 'Kaag en Braassem', NULL, 20090101, NULL, '2023-05-10 09:16:57.543586');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1891, 'Dantumadiel', NULL, 20090101, NULL, '2023-05-10 09:16:57.545417');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1892, 'Zuidplas', NULL, 20100101, NULL, '2023-05-10 09:16:57.54656');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1894, 'Peel en Maas', NULL, 20100101, NULL, '2023-05-10 09:16:57.547743');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1895, 'Oldambt', NULL, 20100101, NULL, '2023-05-10 09:16:57.549039');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1896, 'Zwartewaterland', NULL, 20010101, NULL, '2023-05-10 09:16:57.550206');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1900, 'Súdwest-Fryslân', NULL, 20110101, NULL, '2023-05-10 09:16:57.610899');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1901, 'Bodegraven-Reeuwijk', NULL, 20110101, NULL, '2023-05-10 09:16:57.612727');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1903, 'Eijsden-Margraten', NULL, 20110101, NULL, '2023-05-10 09:16:57.614379');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1904, 'Stichtse Vecht', NULL, 20110101, NULL, '2023-05-10 09:16:57.615593');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1908, 'Menameradiel', 1949, 20110101, 20180101, '2023-05-10 09:16:57.617098');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1911, 'Hollands Kroon', NULL, 20120101, NULL, '2023-05-10 09:16:57.618521');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1916, 'Leidschendam-Voorburg', NULL, 20020101, NULL, '2023-05-10 09:16:57.619823');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1921, 'De Friese Meren', 1940, 20140101, 20150701, '2023-05-10 09:16:57.62104');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1924, 'Goeree-Overflakkee', NULL, 20130101, NULL, '2023-05-10 09:16:57.622328');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1926, 'Pijnacker-Nootdorp', NULL, 20020101, NULL, '2023-05-10 09:16:57.623819');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1927, 'Molenwaard', 1978, 20130101, 20190101, '2023-05-10 09:16:57.624986');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1930, 'Nissewaard', NULL, 20150101, NULL, '2023-05-10 09:16:57.626141');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1931, 'Krimpenerwaard', NULL, 20150101, NULL, '2023-05-10 09:16:57.62742');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1937, 'Heel', 1641, 19910101, 20070101, '2023-05-10 09:16:57.628794');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1940, 'De Fryske Marren', NULL, 20150701, NULL, '2023-05-10 09:16:57.630373');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1942, 'Gooise Meren', NULL, 20160101, NULL, '2023-05-10 09:16:57.631744');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1945, 'Berg en Dal', NULL, 20160101, NULL, '2023-05-10 09:16:57.63298');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1948, 'Meierijstad', NULL, 20170101, NULL, '2023-05-10 09:16:57.63423');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1949, 'Waadhoeke', NULL, 20180101, NULL, '2023-05-10 09:16:57.635392');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1950, 'Westerwolde', NULL, 20180101, NULL, '2023-05-10 09:16:57.636665');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1952, 'Midden-Groningen', NULL, 20180101, NULL, '2023-05-10 09:16:57.638576');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1954, 'Beekdaelen', NULL, 20190101, NULL, '2023-05-10 09:16:57.639927');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1955, 'Montferland', NULL, 20050101, NULL, '2023-05-10 09:16:57.641199');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1959, 'Altena', NULL, 20190101, NULL, '2023-05-10 09:16:57.642723');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1960, 'West Betuwe', NULL, 20190101, NULL, '2023-05-10 09:16:57.644103');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1961, 'Vijfheerenlanden', NULL, 20190101, NULL, '2023-05-10 09:16:57.64543');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1963, 'Hoeksche Waard', NULL, 20190101, NULL, '2023-05-10 09:16:57.646755');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1966, 'Het Hogeland', NULL, 20190101, NULL, '2023-05-10 09:16:57.6482');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1969, 'Westerkwartier', NULL, 20190101, NULL, '2023-05-10 09:16:57.649382');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1970, 'Noardeast-Fryslân', NULL, 20190101, NULL, '2023-05-10 09:16:57.650514');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1978, 'Molenlanden', NULL, 20190101, NULL, '2023-05-10 09:16:57.651764');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1979, 'Eemsdelta', NULL, 20210101, NULL, '2023-05-10 09:16:57.65305');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1980, 'Dijk en Waard', NULL, 20220101, NULL, '2023-05-10 09:16:57.654304');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1982, 'Land van Cuijk', NULL, 20220101, NULL, '2023-05-10 09:16:57.655605');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1987, 'Menterwolde', 1952, 19910201, 20180101, '2023-05-10 09:16:57.656998');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1991, 'Maashorst', NULL, 20220101, NULL, '2023-05-10 09:16:57.658227');
INSERT INTO public.lo3_gemeente (gemeente_code, gemeente_naam, nieuwe_gemeente_code, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1999, 'Registratie Niet Ingezetenen (RNI)', NULL, 20140106, NULL, '2023-05-10 09:16:57.65946');


--
-- Data for Name: lo3_gezagsverhouding; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--

INSERT INTO public.lo3_gezagsverhouding (gezagsverhouding_code, gezagsverhouding_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES ('1', 'Ouder1 heeft het gezag', NULL, NULL, '2023-05-10 09:16:54.130544');
INSERT INTO public.lo3_gezagsverhouding (gezagsverhouding_code, gezagsverhouding_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES ('12', 'Ouder1 en ouder2 hebben het gezag', NULL, NULL, '2023-05-10 09:16:54.13385');
INSERT INTO public.lo3_gezagsverhouding (gezagsverhouding_code, gezagsverhouding_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES ('1D', 'Ouder1 en een derde hebben het gezag', NULL, NULL, '2023-05-10 09:16:54.181377');
INSERT INTO public.lo3_gezagsverhouding (gezagsverhouding_code, gezagsverhouding_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES ('2', 'Ouder2 heeft het gezag', NULL, NULL, '2023-05-10 09:16:54.183315');
INSERT INTO public.lo3_gezagsverhouding (gezagsverhouding_code, gezagsverhouding_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES ('2D', 'Ouder2 en een derde hebben het gezag', NULL, NULL, '2023-05-10 09:16:54.185478');
INSERT INTO public.lo3_gezagsverhouding (gezagsverhouding_code, gezagsverhouding_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES ('D', 'Een of meer derden hebben het gezag', NULL, NULL, '2023-05-10 09:16:54.187982');
INSERT INTO public.lo3_gezagsverhouding (gezagsverhouding_code, gezagsverhouding_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES ('3D', 'ouder1 + ouder2 + een of meer derden hebben het gezag', NULL, NULL, '2023-05-10 09:16:54.190066');


--
-- Data for Name: lo3_land; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--

INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (0, 'Onbekend', NULL, NULL, '2023-05-10 09:16:54.127685');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5001, 'Canada', 18670701, NULL, '2023-05-10 09:16:54.172265');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5002, 'Frankrijk', NULL, NULL, '2023-05-10 09:16:54.174113');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5003, 'Zwitserland', NULL, NULL, '2023-05-10 09:16:54.176008');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5004, 'Rhodesië', 19651111, 19790601, '2023-05-10 09:16:54.177742');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5005, 'Malawi', 19640706, NULL, '2023-05-10 09:16:54.179647');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5006, 'Cuba', NULL, NULL, '2023-05-10 09:16:54.182006');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5007, 'Suriname', NULL, NULL, '2023-05-10 09:16:54.18467');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5008, 'Tunesië', NULL, NULL, '2023-05-10 09:16:54.187009');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5009, 'Oostenrijk', NULL, NULL, '2023-05-10 09:16:54.189703');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5010, 'België', NULL, NULL, '2023-05-10 09:16:54.193835');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5011, 'Botswana', 19660930, NULL, '2023-05-10 09:16:54.195561');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5012, 'Iran', NULL, NULL, '2023-05-10 09:16:54.197754');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5013, 'Nieuw-Zeeland', NULL, NULL, '2023-05-10 09:16:54.200842');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5014, 'Zuid-Afrika', NULL, NULL, '2023-05-10 09:16:54.202408');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5015, 'Denemarken', NULL, NULL, '2023-05-10 09:16:54.204433');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5016, 'Noord-Jemen', NULL, 19900522, '2023-05-10 09:16:54.206133');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5017, 'Hongarije', NULL, NULL, '2023-05-10 09:16:54.208261');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5018, 'Saoedi-Arabië', NULL, NULL, '2023-05-10 09:16:54.209889');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5019, 'Liberia', 18470726, NULL, '2023-05-10 09:16:54.212359');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5020, 'Ethiopië', NULL, NULL, '2023-05-10 09:16:54.214313');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5021, 'Chili', NULL, NULL, '2023-05-10 09:16:54.216287');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5022, 'Marokko', NULL, NULL, '2023-05-10 09:16:54.218655');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5023, 'Togo', NULL, NULL, '2023-05-10 09:16:54.220444');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5024, 'Ghana', 19570306, NULL, '2023-05-10 09:16:54.222228');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5025, 'Laos', NULL, NULL, '2023-05-10 09:16:54.22387');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5026, 'Angola', NULL, NULL, '2023-05-10 09:16:54.225938');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5027, 'Filipijnen', NULL, NULL, '2023-05-10 09:16:54.227496');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5028, 'Zambia', 19641024, NULL, '2023-05-10 09:16:54.229784');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5029, 'Mali', 19600620, NULL, '2023-05-10 09:16:54.235554');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5030, 'Ivoorkust', NULL, NULL, '2023-05-10 09:16:54.282405');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5031, 'Burma', NULL, 19890618, '2023-05-10 09:16:54.284743');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5032, 'Monaco', NULL, NULL, '2023-05-10 09:16:54.286885');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5033, 'Colombia', NULL, NULL, '2023-05-10 09:16:54.2893');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5034, 'Albanië', NULL, NULL, '2023-05-10 09:16:54.290848');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5035, 'Kameroen', 19600101, NULL, '2023-05-10 09:16:54.293562');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5036, 'Zuid-Vietnam', NULL, 19760702, '2023-05-10 09:16:54.301666');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5037, 'Singapore', NULL, NULL, '2023-05-10 09:16:54.305908');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5038, 'Paraguay', NULL, NULL, '2023-05-10 09:16:54.351295');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5039, 'Zweden', NULL, NULL, '2023-05-10 09:16:54.353547');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5040, 'Cyprus', NULL, NULL, '2023-05-10 09:16:54.355435');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5041, 'Australisch Nieuw-Guinea', NULL, 19750916, '2023-05-10 09:16:54.357063');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5042, 'Brunei', NULL, NULL, '2023-05-10 09:16:54.358646');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5043, 'Irak', NULL, NULL, '2023-05-10 09:16:54.360908');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5044, 'Mauritius', NULL, NULL, '2023-05-10 09:16:54.362698');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5045, 'Vaticaanstad', 19290211, NULL, '2023-05-10 09:16:54.36441');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5046, 'Kashmir', NULL, 19910601, '2023-05-10 09:16:54.366481');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5047, 'Myanmar', 19890618, NULL, '2023-05-10 09:16:54.367937');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5048, 'Jemen', 19900522, NULL, '2023-05-10 09:16:54.370146');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5049, 'Slovenië', 19920115, NULL, '2023-05-10 09:16:54.372162');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5050, 'Zaïre', 19711027, 19970715, '2023-05-10 09:16:54.374068');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5051, 'Kroatië', 19920115, NULL, '2023-05-10 09:16:54.375797');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5052, 'Taiwan', NULL, NULL, '2023-05-10 09:16:54.377889');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5053, 'Rusland', 19911231, NULL, '2023-05-10 09:16:54.379636');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5054, 'Armenië', 19911231, NULL, '2023-05-10 09:16:54.381525');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5055, 'Ascension', NULL, NULL, '2023-05-10 09:16:54.383293');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5056, 'Azoren', NULL, NULL, '2023-05-10 09:16:54.385029');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5057, 'Bahrein', NULL, NULL, '2023-05-10 09:16:54.38829');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5058, 'Bhutan', NULL, NULL, '2023-05-10 09:16:54.392028');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5059, 'Britse Antillen', 19620201, 19811101, '2023-05-10 09:16:54.396529');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5060, 'Comoren', NULL, NULL, '2023-05-10 09:16:54.399661');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5061, 'Falklandeilanden', NULL, NULL, '2023-05-10 09:16:54.404605');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5062, 'Frans-Guyana', NULL, NULL, '2023-05-10 09:16:54.406376');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5063, 'Frans-Somaliland', NULL, 19770627, '2023-05-10 09:16:54.408115');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5064, 'Gilbert- en Ellice-eilanden', NULL, 19751001, '2023-05-10 09:16:54.410242');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5065, 'Groenland', NULL, NULL, '2023-05-10 09:16:54.412577');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5066, 'Guadeloupe', NULL, NULL, '2023-05-10 09:16:54.41463');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5067, 'Kaapverdische Eilanden', NULL, 19750705, '2023-05-10 09:16:54.416384');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5068, 'Macau', NULL, 19991220, '2023-05-10 09:16:54.418389');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5069, 'Martinique', NULL, NULL, '2023-05-10 09:16:54.42112');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5070, 'Mozambique', 19750625, NULL, '2023-05-10 09:16:54.425598');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5071, 'Pitcairneilanden', NULL, NULL, '2023-05-10 09:16:54.42828');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5072, 'Guinee-Bissau', NULL, NULL, '2023-05-10 09:16:54.430823');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5073, 'Réunion', NULL, NULL, '2023-05-10 09:16:54.434366');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5074, 'Saint Pierre en Miquelon', NULL, NULL, '2023-05-10 09:16:54.437964');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5075, 'Seychellen en Amiranten', NULL, 19910601, '2023-05-10 09:16:54.439818');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5076, 'Tonga', NULL, NULL, '2023-05-10 09:16:54.4416');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5077, 'Wallis en Futuna', NULL, NULL, '2023-05-10 09:16:54.442997');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5078, 'Zuidwest-Afrika', NULL, 19900321, '2023-05-10 09:16:54.444957');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5079, 'Frans-Indië', NULL, 19910601, '2023-05-10 09:16:54.446748');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5080, 'Johnston', NULL, NULL, '2023-05-10 09:16:54.450088');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5081, 'Kedah', NULL, 19460401, '2023-05-10 09:16:54.452318');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5082, 'Kelantan', NULL, 19460401, '2023-05-10 09:16:54.500942');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5083, 'Malakka', NULL, 19630916, '2023-05-10 09:16:54.502737');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5084, 'Mayotte', NULL, NULL, '2023-05-10 09:16:54.504644');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5085, 'Negri Sembilan', NULL, 19460401, '2023-05-10 09:16:54.506713');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5086, 'Pahang', NULL, 19460401, '2023-05-10 09:16:54.507971');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5087, 'Perak', NULL, 19460401, '2023-05-10 09:16:54.509673');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5088, 'Perlis', NULL, 19460401, '2023-05-10 09:16:54.511001');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5089, 'Portugees-Indië', NULL, 19611218, '2023-05-10 09:16:54.512713');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5090, 'Selangor', NULL, 19460401, '2023-05-10 09:16:54.51441');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5091, 'Sikkim', NULL, 19910601, '2023-05-10 09:16:54.515832');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5092, 'Saint Vincent en de Grenadines', 19791027, NULL, '2023-05-10 09:16:54.517642');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5093, 'Spitsbergen', NULL, 19910601, '2023-05-10 09:16:54.519315');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5094, 'Trengganu', NULL, 19460401, '2023-05-10 09:16:54.521023');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5095, 'Aruba', 19860101, NULL, '2023-05-10 09:16:54.52232');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5096, 'Burkina Faso', 19840804, NULL, '2023-05-10 09:16:54.523578');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5097, 'Azerbeidzjan', 19911231, NULL, '2023-05-10 09:16:54.525087');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5098, 'Belarus', 19911231, NULL, '2023-05-10 09:16:54.526549');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5099, 'Kazachstan', 19911231, NULL, '2023-05-10 09:16:54.527755');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5100, 'Macedonië', 19930419, 20190212, '2023-05-10 09:16:54.529102');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5101, 'Timor Leste', 20020520, NULL, '2023-05-10 09:16:54.530332');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5102, 'Servië en Montenegro', 20030204, 20060603, '2023-05-10 09:16:54.53149');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5103, 'Servië', 20060603, NULL, '2023-05-10 09:16:54.533309');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5104, 'Montenegro', 20060603, NULL, '2023-05-10 09:16:54.534666');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5105, 'Kosovo', 20080217, NULL, '2023-05-10 09:16:54.536038');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5106, 'Bonaire', 20101010, NULL, '2023-05-10 09:16:54.537821');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5107, 'Curaçao', 20101010, NULL, '2023-05-10 09:16:54.539631');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5108, 'Saba', 20101010, NULL, '2023-05-10 09:16:54.541178');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5109, 'Sint Eustatius', 20101010, NULL, '2023-05-10 09:16:54.543068');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5110, 'Sint Maarten', 20101010, NULL, '2023-05-10 09:16:54.545064');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5111, 'Zuid-Soedan', 20110709, NULL, '2023-05-10 09:16:54.546819');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5112, 'Gazastrook en Westelijke Jordaanoever', 19480515, NULL, '2023-05-10 09:16:54.548556');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5113, 'Republiek Noord-Macedonië', 20190212, NULL, '2023-05-10 09:16:54.550405');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6000, 'Moldavië', 19911231, NULL, '2023-05-10 09:16:54.552082');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6001, 'Burundi', 19620701, NULL, '2023-05-10 09:16:54.553484');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6002, 'Finland', NULL, NULL, '2023-05-10 09:16:54.555254');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6003, 'Griekenland', NULL, NULL, '2023-05-10 09:16:54.556636');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6004, 'Guatemala', NULL, NULL, '2023-05-10 09:16:54.55848');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6005, 'Nigeria', NULL, NULL, '2023-05-10 09:16:54.561316');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6006, 'Libië', NULL, NULL, '2023-05-10 09:16:54.563301');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6007, 'Ierland', NULL, NULL, '2023-05-10 09:16:54.565097');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6008, 'Brazilië', NULL, NULL, '2023-05-10 09:16:54.566783');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6009, 'Rwanda', 19620701, NULL, '2023-05-10 09:16:54.568595');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6010, 'Venezuela', NULL, NULL, '2023-05-10 09:16:54.570445');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6011, 'IJsland', NULL, NULL, '2023-05-10 09:16:54.572245');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6012, 'Liechtenstein', NULL, NULL, '2023-05-10 09:16:54.574695');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6013, 'Somalië', 19600701, NULL, '2023-05-10 09:16:54.576463');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6014, 'Verenigde Staten van Amerika', NULL, NULL, '2023-05-10 09:16:54.57839');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6015, 'Bolivia', NULL, NULL, '2023-05-10 09:16:54.581276');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6016, 'Australië', NULL, NULL, '2023-05-10 09:16:54.583092');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6017, 'Jamaica', NULL, NULL, '2023-05-10 09:16:54.585455');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6018, 'Luxemburg', NULL, NULL, '2023-05-10 09:16:54.58699');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6019, 'Tsjaad', NULL, NULL, '2023-05-10 09:16:54.588347');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6020, 'Mauritanië', NULL, NULL, '2023-05-10 09:16:54.589837');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6021, 'Kirgizië', 19911231, NULL, '2023-05-10 09:16:54.591063');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6022, 'China', NULL, NULL, '2023-05-10 09:16:54.592288');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6023, 'Afghanistan', NULL, NULL, '2023-05-10 09:16:54.593736');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6024, 'Indonesië', 19491227, NULL, '2023-05-10 09:16:54.595177');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6025, 'Guyana', 19660526, NULL, '2023-05-10 09:16:54.596412');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6026, 'Noord-Vietnam', 19450902, 19760702, '2023-05-10 09:16:54.597932');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6027, 'Noorwegen', NULL, NULL, '2023-05-10 09:16:54.599491');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6028, 'San Marino', NULL, NULL, '2023-05-10 09:16:54.600829');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6029, 'Duitsland', NULL, 19910601, '2023-05-10 09:16:54.602193');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6030, 'Nederland', NULL, NULL, '2023-05-10 09:16:54.603503');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6031, 'Cambodja', NULL, NULL, '2023-05-10 09:16:54.604819');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6032, 'Fiji', NULL, NULL, '2023-05-10 09:16:54.60678');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6033, 'Bahama''s', NULL, NULL, '2023-05-10 09:16:54.608012');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6034, 'Israël', 19480514, NULL, '2023-05-10 09:16:54.615168');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6035, 'Nepal', NULL, NULL, '2023-05-10 09:16:54.616633');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6036, 'Zuid-Korea', NULL, NULL, '2023-05-10 09:16:54.617994');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6037, 'Spanje', NULL, NULL, '2023-05-10 09:16:54.619521');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6038, 'Oekraïne', 19911231, NULL, '2023-05-10 09:16:54.621105');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6039, 'Groot-Brittannië', NULL, NULL, '2023-05-10 09:16:54.62231');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6040, 'Niger', NULL, NULL, '2023-05-10 09:16:54.623678');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6041, 'Haïti', NULL, NULL, '2023-05-10 09:16:54.624882');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6042, 'Jordanië', NULL, NULL, '2023-05-10 09:16:54.627226');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6043, 'Turkije', NULL, NULL, '2023-05-10 09:16:54.628785');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6044, 'Trinidad en Tobago', NULL, NULL, '2023-05-10 09:16:54.630166');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6045, 'Joegoslavië', NULL, 19960601, '2023-05-10 09:16:54.631469');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6046, 'Opper-Volta', NULL, 19840804, '2023-05-10 09:16:54.633454');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6047, 'Algerije', NULL, NULL, '2023-05-10 09:16:54.635273');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6048, 'Gabon', NULL, NULL, '2023-05-10 09:16:54.63691');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6049, 'Noord-Korea', 19450906, NULL, '2023-05-10 09:16:54.638616');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6050, 'Oezbekistan', 19911231, NULL, '2023-05-10 09:16:54.640882');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6051, 'Sierra Leone', NULL, NULL, '2023-05-10 09:16:54.642323');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6052, 'Brits-Honduras', NULL, 19730601, '2023-05-10 09:16:54.644145');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6053, 'Canarische Eilanden', NULL, NULL, '2023-05-10 09:16:54.646612');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6054, 'Frans-Polynesië', NULL, NULL, '2023-05-10 09:16:54.648219');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6055, 'Gibraltar', NULL, NULL, '2023-05-10 09:16:54.649569');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6056, 'Portugees-Timor', NULL, 19760717, '2023-05-10 09:16:54.651481');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6057, 'Tadzjikistan', 19911231, NULL, '2023-05-10 09:16:54.653334');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6058, 'Britse Salomonseilanden', NULL, 19780707, '2023-05-10 09:16:54.65477');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6059, 'São Tomé en Principe', NULL, NULL, '2023-05-10 09:16:54.656777');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6060, 'Sint-Helena', NULL, NULL, '2023-05-10 09:16:54.658529');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6061, 'Tristan Da Cunha', NULL, NULL, '2023-05-10 09:16:54.660348');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6062, 'West-Samoa', NULL, 19970704, '2023-05-10 09:16:54.662179');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6063, 'Turkmenistan', 19911231, NULL, '2023-05-10 09:16:54.663559');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6064, 'Georgië', 19911231, NULL, '2023-05-10 09:16:54.664946');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6065, 'Bosnië-Herzegovina', 19920406, NULL, '2023-05-10 09:16:54.666244');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6066, 'Tsjechië', 19930101, NULL, '2023-05-10 09:16:54.668045');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6067, 'Slowakije', 19930101, NULL, '2023-05-10 09:16:54.669802');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6068, 'Federale Republiek Joegoslavië', 19920427, 20040201, '2023-05-10 09:16:54.671576');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6069, 'Democratische Republiek Congo', 19970517, NULL, '2023-05-10 09:16:54.672919');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7001, 'Uganda', NULL, NULL, '2023-05-10 09:16:54.674285');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7002, 'Kenya', 19631212, NULL, '2023-05-10 09:16:54.6756');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7003, 'Malta', NULL, NULL, '2023-05-10 09:16:54.676862');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7004, 'Barbados', NULL, NULL, '2023-05-10 09:16:54.678558');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7005, 'Andorra', NULL, NULL, '2023-05-10 09:16:54.680306');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7006, 'Mexico', NULL, NULL, '2023-05-10 09:16:54.681683');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7007, 'Costa Rica', NULL, NULL, '2023-05-10 09:16:54.682889');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7008, 'Gambia', NULL, NULL, '2023-05-10 09:16:54.684159');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7009, 'Syrië', NULL, NULL, '2023-05-10 09:16:54.685461');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7011, 'Nederlandse Antillen', NULL, 20101010, '2023-05-10 09:16:54.686661');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7012, 'Zuid-Jemen', 19671127, 19900522, '2023-05-10 09:16:54.68789');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7014, 'Egypte', NULL, NULL, '2023-05-10 09:16:54.689053');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7015, 'Argentinië', NULL, NULL, '2023-05-10 09:16:54.690381');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7016, 'Lesotho', 19661004, NULL, '2023-05-10 09:16:54.740706');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7017, 'Honduras', NULL, NULL, '2023-05-10 09:16:54.742529');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7018, 'Nicaragua', NULL, NULL, '2023-05-10 09:16:54.745232');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7020, 'Pakistan', NULL, NULL, '2023-05-10 09:16:54.746487');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7021, 'Senegal', NULL, NULL, '2023-05-10 09:16:54.747993');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7023, 'Dahomey', NULL, 19751130, '2023-05-10 09:16:54.749791');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7024, 'Bulgarije', NULL, NULL, '2023-05-10 09:16:54.751258');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7026, 'Maleisië', 19630916, NULL, '2023-05-10 09:16:54.753143');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7027, 'Dominicaanse Republiek', NULL, NULL, '2023-05-10 09:16:54.754607');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7028, 'Polen', NULL, NULL, '2023-05-10 09:16:54.755848');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7029, 'Rusland (oud)', NULL, 19171107, '2023-05-10 09:16:54.757139');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7030, 'Britse Maagdeneilanden', NULL, NULL, '2023-05-10 09:16:54.758313');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7031, 'Tanzania', 19640427, NULL, '2023-05-10 09:16:54.759654');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7032, 'El Salvador', NULL, NULL, '2023-05-10 09:16:54.761018');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7033, 'Sri Lanka', 19720522, NULL, '2023-05-10 09:16:54.762502');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7034, 'Soedan', NULL, NULL, '2023-05-10 09:16:54.76415');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7035, 'Japan', NULL, NULL, '2023-05-10 09:16:54.765257');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7036, 'Hongkong', NULL, 19970701, '2023-05-10 09:16:54.766616');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7037, 'Panama', NULL, NULL, '2023-05-10 09:16:54.768313');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7038, 'Uruguay', NULL, NULL, '2023-05-10 09:16:54.769865');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7039, 'Ecuador', NULL, NULL, '2023-05-10 09:16:54.771712');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7040, 'Guinee', NULL, NULL, '2023-05-10 09:16:54.773297');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7041, 'Maldiven', NULL, NULL, '2023-05-10 09:16:54.775199');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7042, 'Thailand', NULL, NULL, '2023-05-10 09:16:54.778503');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7043, 'Libanon', NULL, NULL, '2023-05-10 09:16:54.782551');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7044, 'Italië', NULL, NULL, '2023-05-10 09:16:54.784665');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7045, 'Koeweit', NULL, NULL, '2023-05-10 09:16:54.78612');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7046, 'India', NULL, NULL, '2023-05-10 09:16:54.787587');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7047, 'Roemenië', NULL, NULL, '2023-05-10 09:16:54.788804');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7048, 'Tsjecho-Slowakije', NULL, 19930101, '2023-05-10 09:16:54.790243');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7049, 'Peru', NULL, NULL, '2023-05-10 09:16:54.791558');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7050, 'Portugal', NULL, NULL, '2023-05-10 09:16:54.793956');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7051, 'Oman', 19700809, NULL, '2023-05-10 09:16:54.797404');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7052, 'Mongolië', NULL, NULL, '2023-05-10 09:16:54.799821');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7053, 'Samoa', 19970704, NULL, '2023-05-10 09:16:54.801226');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7054, 'Verenigde Arabische Emiraten', 19711202, NULL, '2023-05-10 09:16:54.802616');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7055, 'Tibet', NULL, NULL, '2023-05-10 09:16:54.803994');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7057, 'Nauru', NULL, NULL, '2023-05-10 09:16:54.805477');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7058, 'Nederlands Nieuw-Guinea', NULL, 19621001, '2023-05-10 09:16:54.808703');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7059, 'Tanganyika', NULL, 19640427, '2023-05-10 09:16:54.811722');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7060, 'Palestina', NULL, 19480515, '2023-05-10 09:16:54.816523');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7062, 'Brits West-Indië', NULL, 19620201, '2023-05-10 09:16:54.818955');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7063, 'Portugees-Afrika', NULL, 19910601, '2023-05-10 09:16:54.820873');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7064, 'Letland', 19181118, NULL, '2023-05-10 09:16:54.822242');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7065, 'Estland', NULL, NULL, '2023-05-10 09:16:54.823629');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7066, 'Litouwen', 19180216, NULL, '2023-05-10 09:16:54.824865');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7067, 'Brits-Afrika', NULL, 19910601, '2023-05-10 09:16:54.826852');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7068, 'Belgisch-Congo', NULL, 19600630, '2023-05-10 09:16:54.829499');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7070, 'Brits-Indië', NULL, 19470815, '2023-05-10 09:16:54.833031');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7071, 'Noord-Rhodesië', NULL, 19641024, '2023-05-10 09:16:54.835002');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7072, 'Zuid-Rhodesië', NULL, 19651111, '2023-05-10 09:16:54.83661');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7073, 'Saarland', NULL, 19910601, '2023-05-10 09:16:54.838216');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7074, 'Frans Indochina', NULL, 19910601, '2023-05-10 09:16:54.839919');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7075, 'Brits West-Borneo', NULL, 19630916, '2023-05-10 09:16:54.841878');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7076, 'Goudkust', NULL, 19570306, '2023-05-10 09:16:54.844106');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7077, 'Ras al-Khaimah', NULL, 19910601, '2023-05-10 09:16:54.847366');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7079, 'Frans-Congo', NULL, 19600815, '2023-05-10 09:16:54.848993');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7080, 'Siam', NULL, 19910601, '2023-05-10 09:16:54.850827');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7082, 'Brits Oost-Afrika', NULL, 19631212, '2023-05-10 09:16:54.852554');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7083, 'Brits Noord-Borneo', NULL, 19630916, '2023-05-10 09:16:54.854433');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7084, 'Bangladesh', 19711216, NULL, '2023-05-10 09:16:54.855657');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7085, 'Duitse Democratische Republiek', 19491007, 19901003, '2023-05-10 09:16:54.856964');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7087, 'Madeira-eilanden', NULL, NULL, '2023-05-10 09:16:54.858629');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7088, 'Amerikaanse Maagdeneilanden', NULL, NULL, '2023-05-10 09:16:54.86006');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7089, 'Australische Salomonseilanden', NULL, 19750916, '2023-05-10 09:16:54.862055');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7091, 'Spaanse Sahara', NULL, 19760226, '2023-05-10 09:16:54.864038');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7092, 'Caymaneilanden', NULL, NULL, '2023-05-10 09:16:54.865257');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7093, 'Caicoseilanden', NULL, 19910601, '2023-05-10 09:16:54.866483');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7094, 'Turkseilanden', NULL, 19910601, '2023-05-10 09:16:54.867732');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7095, 'Brits Antarctisch Territorium', NULL, NULL, '2023-05-10 09:16:54.869262');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7096, 'Brits Indische Oceaanterritorium', NULL, NULL, '2023-05-10 09:16:54.870567');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7097, 'Cookeilanden', NULL, NULL, '2023-05-10 09:16:54.871857');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7098, 'Tokelau', NULL, NULL, '2023-05-10 09:16:54.87316');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7099, 'Nieuw-Caledonië', NULL, NULL, '2023-05-10 09:16:54.874531');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (8000, 'Hawaii-eilanden', NULL, 19910601, '2023-05-10 09:16:54.87611');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (8001, 'Guam', NULL, NULL, '2023-05-10 09:16:54.877484');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (8002, 'Amerikaans-Samoa', NULL, NULL, '2023-05-10 09:16:54.878666');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (8003, 'Midway', NULL, NULL, '2023-05-10 09:16:54.879985');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (8004, 'Riukiu-eilanden', NULL, 19910601, '2023-05-10 09:16:54.881144');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (8005, 'Wake', NULL, NULL, '2023-05-10 09:16:54.882228');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (8006, 'Pacific-eilanden', NULL, 19910601, '2023-05-10 09:16:54.88353');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (8008, 'Grenada', NULL, NULL, '2023-05-10 09:16:54.884921');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (8009, 'Marianen', NULL, NULL, '2023-05-10 09:16:54.886221');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (8010, 'Cabinda', NULL, 19910601, '2023-05-10 09:16:54.887551');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (8011, 'Canton en Enderbury', NULL, 19910601, '2023-05-10 09:16:54.888754');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (8012, 'Christmaseiland', NULL, NULL, '2023-05-10 09:16:54.89014');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (8013, 'Cocoseilanden', NULL, NULL, '2023-05-10 09:16:54.891298');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (8014, 'Faeröer', NULL, NULL, '2023-05-10 09:16:54.892965');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (8015, 'Montserrat', NULL, NULL, '2023-05-10 09:16:54.8945');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (8016, 'Norfolk', NULL, NULL, '2023-05-10 09:16:54.896');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (8017, 'Belize', NULL, NULL, '2023-05-10 09:16:54.897454');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (8018, 'Tasmanië', NULL, 19910601, '2023-05-10 09:16:54.89874');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (8019, 'Turks- en Caicoseilanden', NULL, NULL, '2023-05-10 09:16:54.899989');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (8020, 'Puerto Rico', NULL, NULL, '2023-05-10 09:16:54.90147');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (8021, 'Papoea-Nieuw-Guinea', 19750916, NULL, '2023-05-10 09:16:54.904107');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (8022, 'Salomonseilanden', 19780707, NULL, '2023-05-10 09:16:54.906787');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (8023, 'Benin', 19751130, NULL, '2023-05-10 09:16:54.909386');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (8024, 'Vietnam', NULL, NULL, '2023-05-10 09:16:54.912019');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (8025, 'Kaapverdië', NULL, NULL, '2023-05-10 09:16:54.970307');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (8026, 'Seychellen', NULL, NULL, '2023-05-10 09:16:54.971704');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (8027, 'Kiribati', 19790712, NULL, '2023-05-10 09:16:54.972865');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (8028, 'Tuvalu', 19751001, NULL, '2023-05-10 09:16:54.974021');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (8029, 'Saint Lucia', NULL, NULL, '2023-05-10 09:16:54.975195');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (8030, 'Dominica', NULL, NULL, '2023-05-10 09:16:54.976483');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (8031, 'Zimbabwe', 19790601, NULL, '2023-05-10 09:16:54.977899');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (8032, 'Dubai', NULL, 19910601, '2023-05-10 09:16:54.979267');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (8033, 'Nieuwe Hebriden', NULL, 19800730, '2023-05-10 09:16:54.980479');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (8034, 'Kanaaleilanden', NULL, NULL, '2023-05-10 09:16:54.981788');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (8035, 'Man', NULL, NULL, '2023-05-10 09:16:54.982957');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (8036, 'Anguilla', NULL, NULL, '2023-05-10 09:16:54.984164');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (8037, 'Saint Kitts en Nevis', NULL, NULL, '2023-05-10 09:16:54.985475');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (8038, 'Antigua', NULL, 19811101, '2023-05-10 09:16:54.98671');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (8039, 'Saint Vincent', NULL, 19791027, '2023-05-10 09:16:54.98786');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (8040, 'Gilberteilanden', NULL, 19790712, '2023-05-10 09:16:54.988963');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (8041, 'Panamakanaalzone', NULL, NULL, '2023-05-10 09:16:54.990179');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (8042, 'Saint Kitts, Nevis en Anguilla', 19670227, 19801219, '2023-05-10 09:16:54.9913');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (8043, 'Belau', NULL, 19941001, '2023-05-10 09:16:54.992506');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (8044, 'Palau', 19941001, NULL, '2023-05-10 09:16:54.994057');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (8045, 'Antigua en Barbuda', 19811101, NULL, '2023-05-10 09:16:54.995479');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9000, 'Newfoundland', NULL, 19910601, '2023-05-10 09:16:54.996619');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9001, 'Nyasaland', NULL, 19640706, '2023-05-10 09:16:54.997903');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9003, 'Eritrea', NULL, NULL, '2023-05-10 09:16:54.99911');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9005, 'Ifni', NULL, 19690106, '2023-05-10 09:16:55.000287');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9006, 'Brits-Kameroen', NULL, 19611001, '2023-05-10 09:16:55.051499');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9007, 'Keizer Wilhelmsland', NULL, 19910601, '2023-05-10 09:16:55.053507');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9008, 'Congo', 19600815, NULL, '2023-05-10 09:16:55.05507');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9009, 'Congo-Kinshasa', NULL, 19711027, '2023-05-10 09:16:55.056347');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9010, 'Madagaskar', NULL, NULL, '2023-05-10 09:16:55.057676');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9013, 'Congo-Brazzaville', NULL, 19600815, '2023-05-10 09:16:55.059113');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9014, 'Leewardeilanden', NULL, 19910601, '2023-05-10 09:16:55.060417');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9015, 'Windwardeilanden', NULL, 19910601, '2023-05-10 09:16:55.061629');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9016, 'Frans Territorium voor Afars en Issa''s', NULL, 19770627, '2023-05-10 09:16:55.062769');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9017, 'Phoenixeilanden', NULL, 19910601, '2023-05-10 09:16:55.063973');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9020, 'Portugees-Guinee', NULL, 19740910, '2023-05-10 09:16:55.065148');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9022, 'Duits Zuidwest-Afrika', NULL, 19910601, '2023-05-10 09:16:55.06623');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9023, 'Namibië', 19680131, NULL, '2023-05-10 09:16:55.067446');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9027, 'Brits-Somaliland', NULL, 19600701, '2023-05-10 09:16:55.068641');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9028, 'Italiaans-Somaliland', NULL, 19600701, '2023-05-10 09:16:55.069809');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9030, 'Nederlands-Indië', NULL, 19491227, '2023-05-10 09:16:55.070971');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9031, 'Brits-Guyana', NULL, 19660526, '2023-05-10 09:16:55.072135');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9036, 'Swaziland', NULL, 20180419, '2023-05-10 09:16:55.073754');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9037, 'Qatar', NULL, NULL, '2023-05-10 09:16:55.074961');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9038, 'Eswatini', 20180419, NULL, '2023-05-10 09:16:55.076282');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9041, 'Aden', NULL, 19910601, '2023-05-10 09:16:55.077931');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9042, 'Zuid-Arabische Federatie', 19590211, 19671127, '2023-05-10 09:16:55.079441');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9043, 'Equatoriaal-Guinea', NULL, NULL, '2023-05-10 09:16:55.080778');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9044, 'Spaans-Guinee', NULL, 19910601, '2023-05-10 09:16:55.081856');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9047, 'Verenigde Arabische Republiek', 19580222, 19610928, '2023-05-10 09:16:55.083079');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9048, 'Bermuda', NULL, NULL, '2023-05-10 09:16:55.084303');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9049, 'Sovjet-Unie', 19171107, 19911231, '2023-05-10 09:16:55.085794');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9050, 'Duits Oost-Afrika', NULL, 19910601, '2023-05-10 09:16:55.087085');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9051, 'Zanzibar', NULL, 19640427, '2023-05-10 09:16:55.088348');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9052, 'Ceylon', NULL, 19720522, '2023-05-10 09:16:55.089665');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9053, 'Muscat en Oman', NULL, 19700809, '2023-05-10 09:16:55.091');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9054, 'Trucial Oman', NULL, 19711202, '2023-05-10 09:16:55.092996');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9055, 'Indochina', NULL, 19910601, '2023-05-10 09:16:55.094741');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9056, 'Marshalleilanden', NULL, NULL, '2023-05-10 09:16:55.096304');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9057, 'Sarawak', NULL, 19910601, '2023-05-10 09:16:55.098077');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9058, 'Brits-Borneo', NULL, 19630916, '2023-05-10 09:16:55.099623');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9060, 'Sabah', NULL, 19910601, '2023-05-10 09:16:55.101466');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9061, 'Abu Dhabi', NULL, 19910601, '2023-05-10 09:16:55.103049');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9062, 'Ajman', NULL, 19910601, '2023-05-10 09:16:55.104312');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9063, 'Basutoland', NULL, 19661004, '2023-05-10 09:16:55.10558');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9064, 'Bechuanaland', NULL, 19660930, '2023-05-10 09:16:55.106743');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9065, 'Fujairah', NULL, 19910601, '2023-05-10 09:16:55.108294');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9066, 'Frans-Kameroen', NULL, 19600101, '2023-05-10 09:16:55.11');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9067, 'Johore', NULL, 19460401, '2023-05-10 09:16:55.111369');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9068, 'Korea', NULL, 19910601, '2023-05-10 09:16:55.112612');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9069, 'Labuan', NULL, 19910601, '2023-05-10 09:16:55.113786');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9070, 'Umm Al-Qaiwain', NULL, 19910601, '2023-05-10 09:16:55.114937');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9071, 'Oostenrijk-Hongarije', NULL, 19910601, '2023-05-10 09:16:55.116107');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9072, 'Portugees Oost-Afrika', NULL, 19750625, '2023-05-10 09:16:55.117348');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9073, 'Portugees West-Afrika', NULL, 19751111, '2023-05-10 09:16:55.11855');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9074, 'Sharjah', NULL, 19910601, '2023-05-10 09:16:55.11984');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9075, 'Straits Settlements', NULL, 19460401, '2023-05-10 09:16:55.121231');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9076, 'Abessinië', NULL, 19910601, '2023-05-10 09:16:55.122696');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9077, 'Frans West-Afrika', NULL, 19910601, '2023-05-10 09:16:55.124584');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9078, 'Frans Equatoriaal-Afrika', NULL, 19910601, '2023-05-10 09:16:55.125983');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9081, 'Urundi', NULL, 19910601, '2023-05-10 09:16:55.127296');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9082, 'Ruanda-Urundi', NULL, 19620701, '2023-05-10 09:16:55.128506');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9084, 'Goa', NULL, 19611218, '2023-05-10 09:16:55.129716');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9085, 'Dantzig', NULL, 19390901, '2023-05-10 09:16:55.130993');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9086, 'Centraal-Afrikaanse Republiek', NULL, NULL, '2023-05-10 09:16:55.132225');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9087, 'Djibouti', 19770627, NULL, '2023-05-10 09:16:55.133447');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9088, 'Transjordanië', 19230515, 19910601, '2023-05-10 09:16:55.134626');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9089, 'Bondsrepubliek Duitsland', 19490801, NULL, '2023-05-10 09:16:55.135777');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9090, 'Vanuatu', 19800730, NULL, '2023-05-10 09:16:55.136942');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9091, 'Niue', NULL, NULL, '2023-05-10 09:16:55.138064');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9092, 'Spaans Noord-Afrika', NULL, 19910601, '2023-05-10 09:16:55.140012');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9093, 'Westelijke Sahara', 19760226, NULL, '2023-05-10 09:16:55.141456');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9094, 'Micronesia', NULL, NULL, '2023-05-10 09:16:55.142991');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9095, 'Svalbardeilanden', NULL, NULL, '2023-05-10 09:16:55.14445');
INSERT INTO public.lo3_land (land_code, land_naam, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9999, 'Internationaal gebied', NULL, NULL, '2023-05-10 09:16:55.145873');


--
-- Data for Name: lo3_mailbox; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--



--
-- Data for Name: lo3_nationaliteit; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--

INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (0, 'Onbekend', NULL, NULL, '2023-05-10 09:16:54.128623');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1, 'Nederlandse', NULL, NULL, '2023-05-10 09:16:54.131837');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (2, 'Behandeld als Nederlander', 20070401, 20070401, '2023-05-10 09:16:54.134109');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (27, 'Slowaakse', 19930101, NULL, '2023-05-10 09:16:54.136418');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (28, 'Tsjechische', 19930101, NULL, '2023-05-10 09:16:54.138668');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (29, 'Burger van Bosnië-Herzegovina', 19920406, NULL, '2023-05-10 09:16:54.140379');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (30, 'Georgische', 19911231, NULL, '2023-05-10 09:16:54.141608');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (31, 'Turkmeense', 19911231, NULL, '2023-05-10 09:16:54.142855');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (32, 'Tadzjiekse', 19911231, NULL, '2023-05-10 09:16:54.144341');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (33, 'Oezbeekse', 19911231, NULL, '2023-05-10 09:16:54.145633');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (34, 'Oekraïense', 19911231, NULL, '2023-05-10 09:16:54.146864');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (35, 'Kirgizische', 19911231, NULL, '2023-05-10 09:16:54.148138');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (36, 'Moldavische', 19911231, NULL, '2023-05-10 09:16:54.149364');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (37, 'Kazachse', 19911231, NULL, '2023-05-10 09:16:54.150562');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (38, 'Belarussische', 19911231, NULL, '2023-05-10 09:16:54.151799');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (39, 'Azerbeidzjaanse', 19911231, NULL, '2023-05-10 09:16:54.153094');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (40, 'Armeense', 19911231, NULL, '2023-05-10 09:16:54.154592');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (41, 'Russische', 19911231, NULL, '2023-05-10 09:16:54.155903');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (42, 'Sloveense', 19920115, NULL, '2023-05-10 09:16:54.15723');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (43, 'Kroatische', 19920115, NULL, '2023-05-10 09:16:54.158514');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (44, 'Letse', 19910828, NULL, '2023-05-10 09:16:54.15978');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (45, 'Estische', 19910828, NULL, '2023-05-10 09:16:54.161118');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (46, 'Litouwse', 19910828, NULL, '2023-05-10 09:16:54.162424');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (47, 'Marshalleilandse', NULL, NULL, '2023-05-10 09:16:54.163609');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (48, 'Myanmarese', NULL, NULL, '2023-05-10 09:16:54.164797');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (49, 'Namibische', NULL, NULL, '2023-05-10 09:16:54.165976');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (50, 'Albanese', NULL, NULL, '2023-05-10 09:16:54.167153');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (51, 'Andorrese', NULL, NULL, '2023-05-10 09:16:54.168303');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (52, 'Belgische', NULL, NULL, '2023-05-10 09:16:54.169516');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (53, 'Bulgaarse', NULL, NULL, '2023-05-10 09:16:54.172088');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (54, 'Deense', NULL, NULL, '2023-05-10 09:16:54.173473');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (55, 'Burger van de Bondsrepubliek Duitsland', NULL, NULL, '2023-05-10 09:16:54.175358');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (56, 'Finse', NULL, NULL, '2023-05-10 09:16:54.177197');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (57, 'Franse', NULL, NULL, '2023-05-10 09:16:54.178928');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (58, 'Jemenitische', 19900522, NULL, '2023-05-10 09:16:54.181637');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (59, 'Griekse', NULL, NULL, '2023-05-10 09:16:54.184439');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (60, 'Brits burger', NULL, NULL, '2023-05-10 09:16:54.187043');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (61, 'Hongaarse', NULL, NULL, '2023-05-10 09:16:54.189699');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (62, 'Ierse', NULL, NULL, '2023-05-10 09:16:54.191619');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (63, 'IJslandse', NULL, NULL, '2023-05-10 09:16:54.24059');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (64, 'Italiaanse', NULL, NULL, '2023-05-10 09:16:54.241831');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (65, 'Joegoslavische', NULL, 20040201, '2023-05-10 09:16:54.243334');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (66, 'Liechtensteinse', NULL, NULL, '2023-05-10 09:16:54.246256');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (67, 'Luxemburgse', NULL, NULL, '2023-05-10 09:16:54.250289');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (68, 'Maltese', NULL, NULL, '2023-05-10 09:16:54.25196');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (69, 'Monegaskische', NULL, NULL, '2023-05-10 09:16:54.253952');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (70, 'Noorse', NULL, NULL, '2023-05-10 09:16:54.25564');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (71, 'Oostenrijkse', NULL, NULL, '2023-05-10 09:16:54.257365');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (72, 'Poolse', NULL, NULL, '2023-05-10 09:16:54.258742');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (73, 'Portugese', NULL, NULL, '2023-05-10 09:16:54.26101');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (74, 'Roemeense', NULL, NULL, '2023-05-10 09:16:54.267051');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (75, 'Burger van de Sovjet-Unie', NULL, 19911231, '2023-05-10 09:16:54.269714');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (76, 'San Marinese', NULL, NULL, '2023-05-10 09:16:54.271854');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (77, 'Spaanse', NULL, NULL, '2023-05-10 09:16:54.273256');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (78, 'Tsjecho-Slowaakse', NULL, 19930101, '2023-05-10 09:16:54.274459');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (79, 'Vaticaanse', NULL, NULL, '2023-05-10 09:16:54.275607');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (80, 'Zweedse', NULL, NULL, '2023-05-10 09:16:54.277766');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (81, 'Zwitserse', NULL, NULL, '2023-05-10 09:16:54.281173');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (82, 'Oost-Duitse', NULL, 19901003, '2023-05-10 09:16:54.284071');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (83, 'Brits onderdaan', NULL, NULL, '2023-05-10 09:16:54.286131');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (84, 'Eritrese', 19930528, NULL, '2023-05-10 09:16:54.288183');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (85, 'Brits overzees burger', NULL, NULL, '2023-05-10 09:16:54.289972');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (86, 'Macedonische', 19930419, 20190212, '2023-05-10 09:16:54.291682');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (87, 'Kosovaarse', 20080615, NULL, '2023-05-10 09:16:54.295313');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (88, 'Macedonische/Burger van Noord-Macedonië', 20190212, NULL, '2023-05-10 09:16:54.300146');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (100, 'Algerijnse', NULL, NULL, '2023-05-10 09:16:54.304507');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (101, 'Angolese', NULL, NULL, '2023-05-10 09:16:54.351373');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (104, 'Burundese', NULL, NULL, '2023-05-10 09:16:54.353166');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (105, 'Botswaanse', NULL, NULL, '2023-05-10 09:16:54.354545');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (106, 'Burkinese', NULL, NULL, '2023-05-10 09:16:54.35624');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (108, 'Centraal-Afrikaanse', NULL, NULL, '2023-05-10 09:16:54.357918');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (109, 'Comorese', NULL, NULL, '2023-05-10 09:16:54.360045');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (110, 'Burger van Congo', NULL, NULL, '2023-05-10 09:16:54.362218');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (111, 'Beninse', NULL, NULL, '2023-05-10 09:16:54.364085');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (112, 'Egyptische', NULL, NULL, '2023-05-10 09:16:54.365801');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (113, 'Equatoriaal-Guinese', NULL, NULL, '2023-05-10 09:16:54.36714');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (114, 'Ethiopische', NULL, NULL, '2023-05-10 09:16:54.368569');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (115, 'Djiboutiaanse', NULL, NULL, '2023-05-10 09:16:54.370192');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (116, 'Gabonese', NULL, NULL, '2023-05-10 09:16:54.371831');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (117, 'Gambiaanse', NULL, NULL, '2023-05-10 09:16:54.373446');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (118, 'Ghanese', NULL, NULL, '2023-05-10 09:16:54.375094');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (119, 'Guinese', NULL, NULL, '2023-05-10 09:16:54.377704');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (120, 'Ivoriaanse', NULL, NULL, '2023-05-10 09:16:54.379979');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (121, 'Kaapverdische', NULL, NULL, '2023-05-10 09:16:54.381891');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (122, 'Kameroense', NULL, NULL, '2023-05-10 09:16:54.383761');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (123, 'Kenyaanse', NULL, NULL, '2023-05-10 09:16:54.385658');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (124, 'Zaïrese', NULL, 19970715, '2023-05-10 09:16:54.389088');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (125, 'Lesothaanse', NULL, NULL, '2023-05-10 09:16:54.393211');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (126, 'Liberiaanse', NULL, NULL, '2023-05-10 09:16:54.397611');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (127, 'Libische', NULL, NULL, '2023-05-10 09:16:54.400526');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (128, 'Malagassische', NULL, NULL, '2023-05-10 09:16:54.405798');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (129, 'Malawische', NULL, NULL, '2023-05-10 09:16:54.407533');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (130, 'Malinese', NULL, NULL, '2023-05-10 09:16:54.40972');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (131, 'Marokkaanse', NULL, NULL, '2023-05-10 09:16:54.412011');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (132, 'Mauritaanse', NULL, NULL, '2023-05-10 09:16:54.414181');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (133, 'Mauritiaanse', NULL, NULL, '2023-05-10 09:16:54.415927');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (134, 'Mozambikaanse', NULL, NULL, '2023-05-10 09:16:54.41781');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (135, 'Swazische', NULL, 20180419, '2023-05-10 09:16:54.419717');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (136, 'Nigerese', NULL, NULL, '2023-05-10 09:16:54.424466');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (137, 'Nigeriaanse', NULL, NULL, '2023-05-10 09:16:54.427583');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (138, 'Ugandese', NULL, NULL, '2023-05-10 09:16:54.430101');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (139, 'Guinee-Bissause', NULL, NULL, '2023-05-10 09:16:54.432806');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (140, 'Zuid-Afrikaanse', NULL, NULL, '2023-05-10 09:16:54.436619');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (141, 'Eswatinische', 20180419, NULL, '2023-05-10 09:16:54.439098');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (142, 'Zimbabwaanse', NULL, NULL, '2023-05-10 09:16:54.440407');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (143, 'Rwandese', NULL, NULL, '2023-05-10 09:16:54.490609');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (144, 'Burger van São Tomé en Principe', NULL, NULL, '2023-05-10 09:16:54.492292');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (145, 'Senegalese', NULL, NULL, '2023-05-10 09:16:54.493549');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (147, 'Sierra Leoonse', NULL, NULL, '2023-05-10 09:16:54.494979');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (148, 'Soedanese', NULL, NULL, '2023-05-10 09:16:54.49618');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (149, 'Somalische', NULL, NULL, '2023-05-10 09:16:54.498007');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (151, 'Tanzaniaanse', NULL, NULL, '2023-05-10 09:16:54.499818');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (152, 'Togolese', NULL, NULL, '2023-05-10 09:16:54.501472');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (154, 'Tsjadische', NULL, NULL, '2023-05-10 09:16:54.503316');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (155, 'Tunesische', NULL, NULL, '2023-05-10 09:16:54.505232');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (156, 'Zambiaanse', NULL, NULL, '2023-05-10 09:16:54.506573');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (157, 'Zuid-Soedanese', 20110709, NULL, '2023-05-10 09:16:54.50816');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (200, 'Bahamaanse', NULL, NULL, '2023-05-10 09:16:54.510217');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (202, 'Belizaanse', NULL, NULL, '2023-05-10 09:16:54.511603');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (204, 'Canadese', NULL, NULL, '2023-05-10 09:16:54.513257');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (205, 'Costa Ricaanse', NULL, NULL, '2023-05-10 09:16:54.515094');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (206, 'Cubaanse', NULL, NULL, '2023-05-10 09:16:54.51628');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (207, 'Dominicaanse', NULL, NULL, '2023-05-10 09:16:54.51748');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (208, 'Salvadoraanse', NULL, NULL, '2023-05-10 09:16:54.518696');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (211, 'Guatemalaanse', NULL, NULL, '2023-05-10 09:16:54.520421');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (212, 'Haïtiaanse', NULL, NULL, '2023-05-10 09:16:54.522465');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (213, 'Hondurese', NULL, NULL, '2023-05-10 09:16:54.524257');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (214, 'Jamaicaanse', NULL, NULL, '2023-05-10 09:16:54.525599');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (216, 'Mexicaanse', NULL, NULL, '2023-05-10 09:16:54.527315');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (218, 'Nicaraguaanse', NULL, NULL, '2023-05-10 09:16:54.529197');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (219, 'Panamese', NULL, NULL, '2023-05-10 09:16:54.531007');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (222, 'Burger van Trinidad en Tobago', NULL, NULL, '2023-05-10 09:16:54.532742');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (223, 'Amerikaans burger', NULL, NULL, '2023-05-10 09:16:54.534915');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (250, 'Argentijnse', NULL, NULL, '2023-05-10 09:16:54.536782');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (251, 'Barbadaanse', NULL, NULL, '2023-05-10 09:16:54.538368');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (252, 'Boliviaanse', NULL, NULL, '2023-05-10 09:16:54.540366');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (253, 'Braziliaanse', NULL, NULL, '2023-05-10 09:16:54.541991');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (254, 'Chileense', NULL, NULL, '2023-05-10 09:16:54.543681');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (255, 'Colombiaanse', NULL, NULL, '2023-05-10 09:16:54.545809');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (256, 'Ecuadoraanse', NULL, NULL, '2023-05-10 09:16:54.547441');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (259, 'Guyaanse', NULL, NULL, '2023-05-10 09:16:54.5492');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (261, 'Paraguayaanse', NULL, NULL, '2023-05-10 09:16:54.550926');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (262, 'Peruaanse', NULL, NULL, '2023-05-10 09:16:54.600976');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (263, 'Surinaamse', NULL, NULL, '2023-05-10 09:16:54.602819');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (264, 'Uruguayaanse', NULL, NULL, '2023-05-10 09:16:54.604293');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (265, 'Venezolaanse', NULL, NULL, '2023-05-10 09:16:54.606058');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (267, 'Grenadaanse', NULL, NULL, '2023-05-10 09:16:54.607485');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (268, 'Burger van Saint Kitts en Nevis', NULL, NULL, '2023-05-10 09:16:54.609249');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (300, 'Afghaanse', NULL, NULL, '2023-05-10 09:16:54.615563');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (301, 'Bahreinse', NULL, NULL, '2023-05-10 09:16:54.617521');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (302, 'Bhutaanse', NULL, NULL, '2023-05-10 09:16:54.619386');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (303, 'Burmaanse', NULL, 19890618, '2023-05-10 09:16:54.620641');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (304, 'Bruneise', NULL, NULL, '2023-05-10 09:16:54.622463');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (305, 'Cambodjaanse', NULL, NULL, '2023-05-10 09:16:54.624249');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (306, 'Sri Lankaanse', NULL, NULL, '2023-05-10 09:16:54.625437');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (307, 'Chinese', NULL, NULL, '2023-05-10 09:16:54.62716');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (308, 'Cyprische', NULL, NULL, '2023-05-10 09:16:54.628632');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (309, 'Filipijnse', NULL, NULL, '2023-05-10 09:16:54.630308');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (310, 'Taiwanese', NULL, NULL, '2023-05-10 09:16:54.63209');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (312, 'Indiase', NULL, NULL, '2023-05-10 09:16:54.633972');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (313, 'Indonesische', NULL, NULL, '2023-05-10 09:16:54.635139');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (314, 'Iraakse', NULL, NULL, '2023-05-10 09:16:54.636336');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (315, 'Iraanse', NULL, NULL, '2023-05-10 09:16:54.638031');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (316, 'Israëlische', NULL, NULL, '2023-05-10 09:16:54.639843');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (317, 'Japanse', NULL, NULL, '2023-05-10 09:16:54.641699');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (318, 'Noord-Jemenitische', NULL, 19900522, '2023-05-10 09:16:54.64349');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (319, 'Jordaanse', NULL, NULL, '2023-05-10 09:16:54.645341');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (320, 'Koeweitse', NULL, NULL, '2023-05-10 09:16:54.646757');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (321, 'Laotiaanse', NULL, NULL, '2023-05-10 09:16:54.648114');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (322, 'Libanese', NULL, NULL, '2023-05-10 09:16:54.649557');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (324, 'Maldivische', NULL, NULL, '2023-05-10 09:16:54.651453');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (325, 'Maleisische', NULL, NULL, '2023-05-10 09:16:54.653705');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (326, 'Mongolische', NULL, NULL, '2023-05-10 09:16:54.655373');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (327, 'Omaanse', NULL, NULL, '2023-05-10 09:16:54.657401');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (328, 'Nepalese', NULL, NULL, '2023-05-10 09:16:54.65915');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (329, 'Noord-Koreaanse', NULL, NULL, '2023-05-10 09:16:54.661002');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (331, 'Pakistaanse', NULL, NULL, '2023-05-10 09:16:54.710366');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (333, 'Qatarese', NULL, NULL, '2023-05-10 09:16:54.711626');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (334, 'Saoedi-Arabische', NULL, NULL, '2023-05-10 09:16:54.712926');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (335, 'Singaporese', NULL, NULL, '2023-05-10 09:16:54.714147');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (336, 'Syrische', NULL, NULL, '2023-05-10 09:16:54.715446');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (337, 'Thaise', NULL, NULL, '2023-05-10 09:16:54.716581');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (338, 'Burger van de Verenigde Arabische Emiraten', NULL, NULL, '2023-05-10 09:16:54.717837');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (339, 'Turkse', NULL, NULL, '2023-05-10 09:16:54.719039');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (340, 'Zuid-Jemenitische', NULL, 19900522, '2023-05-10 09:16:54.720276');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (341, 'Zuid-Koreaanse', NULL, NULL, '2023-05-10 09:16:54.721488');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (342, 'Vietnamese', NULL, NULL, '2023-05-10 09:16:54.722593');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (345, 'Bengalese', NULL, NULL, '2023-05-10 09:16:54.723737');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (400, 'Australische', NULL, NULL, '2023-05-10 09:16:54.724861');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (401, 'Papoea-Nieuw-Guinese', NULL, NULL, '2023-05-10 09:16:54.72603');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (402, 'Nieuw-Zeelandse', NULL, NULL, '2023-05-10 09:16:54.727233');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (404, 'West-Samoaanse', NULL, 19970704, '2023-05-10 09:16:54.728394');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (405, 'Samoaanse', 19970704, NULL, '2023-05-10 09:16:54.729533');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (421, 'Burger van Antigua en Barbuda', NULL, NULL, '2023-05-10 09:16:54.730802');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (424, 'Vanuatuaanse', NULL, NULL, '2023-05-10 09:16:54.732057');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (425, 'Fijische', NULL, NULL, '2023-05-10 09:16:54.733255');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (429, 'Burger van Britse afhankelijke gebieden', NULL, NULL, '2023-05-10 09:16:54.734468');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (430, 'Tongaanse', NULL, NULL, '2023-05-10 09:16:54.735746');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (431, 'Nauruaanse', NULL, NULL, '2023-05-10 09:16:54.737184');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (432, 'Palause', 19941001, NULL, '2023-05-10 09:16:54.738519');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (437, 'Amerikaans onderdaan', NULL, NULL, '2023-05-10 09:16:54.739914');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (442, 'Salomonseilandse', NULL, NULL, '2023-05-10 09:16:54.741164');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (443, 'Micronesische', NULL, NULL, '2023-05-10 09:16:54.742405');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (444, 'Seychelse', NULL, NULL, '2023-05-10 09:16:54.744378');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (445, 'Kiribatische', NULL, NULL, '2023-05-10 09:16:54.74594');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (446, 'Tuvaluaanse', NULL, NULL, '2023-05-10 09:16:54.747194');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (447, 'Saint Luciaanse', NULL, NULL, '2023-05-10 09:16:54.748366');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (448, 'Burger van Dominica', NULL, NULL, '2023-05-10 09:16:54.749691');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (449, 'Burger van Saint Vincent en de Grenadines', NULL, NULL, '2023-05-10 09:16:54.75108');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (450, 'British National (overseas)', 19870701, NULL, '2023-05-10 09:16:54.752648');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (451, 'Burger van Democratische Republiek Congo', 19970517, NULL, '2023-05-10 09:16:54.754062');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (452, 'Burger van Timor Leste', 20020520, NULL, '2023-05-10 09:16:54.755294');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (453, 'Burger van Servië en Montenegro', 20030204, 20060603, '2023-05-10 09:16:54.756511');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (454, 'Servische', 20060603, NULL, '2023-05-10 09:16:54.75765');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (455, 'Montenegrijnse', 20060603, NULL, '2023-05-10 09:16:54.758957');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (499, 'Staatloos', NULL, NULL, '2023-05-10 09:16:54.76042');
INSERT INTO public.lo3_nationaliteit (nationaliteit_code, nationaliteit_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (500, 'Vastgesteld niet-Nederlander', 20070401, 20070401, '2023-05-10 09:16:54.761732');


--
-- Data for Name: lo3_nl_nat_verkrijg_verlies_reden; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--

INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (0, 'Onbekend', '', NULL, NULL, '2023-05-10 09:16:54.129321');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (1, 'Wet op het Nederlanderschap 1892, art. 1, onder a', 'VK', 18930701, 19850101, '2023-05-10 09:16:54.133276');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (2, 'Wet op het Nederlanderschap 1892, art. 1, onder b', 'VK', 18930701, 19850101, '2023-05-10 09:16:54.182326');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (3, 'Wet op het Nederlanderschap 1892, art. 1, onder c', 'VK', 18930701, 19850101, '2023-05-10 09:16:54.183979');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (4, 'Wet op het Nederlanderschap 1892, art. 1, onder d', 'VK', 18930701, 19850101, '2023-05-10 09:16:54.18644');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (5, 'Wet op het Nederlanderschap 1892 i.v.m. wijziging 1962, art. 1bis', 'VK', 19561101, 19850101, '2023-05-10 09:16:54.188731');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (6, 'Wet op het Nederlanderschap 1892, art. 2, onder a', 'VK', 18930701, 19850101, '2023-05-10 09:16:54.191199');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (7, 'Wet op het Nederlanderschap 1892, art. 2, onder b', 'VK', 18930701, 19850101, '2023-05-10 09:16:54.194404');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (8, 'Wet op het Nederlanderschap 1892, art. 2, onder c', 'VK', 18930701, 19850101, '2023-05-10 09:16:54.196436');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9, 'Wet op het Nederlanderschap 1892, art. 3', 'VK', 18930701, 19850101, '2023-05-10 09:16:54.198399');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (10, 'Wet op het Nederlanderschap 1892, art. 4', 'VK', 18930701, 19850101, '2023-05-10 09:16:54.201648');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (11, 'Wet op het Nederlanderschap 1892, art. 5', 'VK', 18930701, 19640301, '2023-05-10 09:16:54.203106');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (12, 'Wet op het Nederlanderschap 1892, art. 6', 'VK', 18930701, 19850101, '2023-05-10 09:16:54.205065');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (13, 'Wet op het Nederlanderschap 1892 i.v.m. wijziging 1963, art. 8', 'VK', 19640301, 19850101, '2023-05-10 09:16:54.206785');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (14, 'Wet op het Nederlanderschap 1892 i.v.m. wijziging 1963, art. 8b', 'VK', 19640301, 19850101, '2023-05-10 09:16:54.208101');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (15, 'Wet op het Nederlanderschap 1892 i.v.m. wijziging 1963, art. 9', 'VK', 19640301, 19770315, '2023-05-10 09:16:54.209765');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (16, 'Wet op het Nederlanderschap 1892, art. 10', 'VK', 18930701, 19850101, '2023-05-10 09:16:54.211788');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (17, 'Rijkswet op het Nederlanderschap 1984, art. 3, lid 1', 'VK', 19850101, NULL, '2023-05-10 09:16:54.213414');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (18, 'Rijkswet op het Nederlanderschap 1984, art. 3, lid 2', 'VK', 19850101, NULL, '2023-05-10 09:16:54.214674');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (19, 'Rijkswet op het Nederlanderschap 1984, art. 3, lid 3', 'VK', 19850101, 20030401, '2023-05-10 09:16:54.216168');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (20, 'Rijkswet op het Nederlanderschap 1984, art. 4, lid 1', 'VK', 19850101, 20030401, '2023-05-10 09:16:54.217983');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (21, 'Rijkswet op het Nederlanderschap 1984, art. 4, lid 2', 'VK', 19850101, 20030401, '2023-05-10 09:16:54.219734');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (22, 'Rijkswet op het Nederlanderschap 1984, art. 4, lid 3', 'VK', 19850101, 20030401, '2023-05-10 09:16:54.221704');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (23, 'Rijkswet op het Nederlanderschap 1984, art. 5, lid 1', 'VK', 19850101, 20040101, '2023-05-10 09:16:54.223749');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (24, 'Rijkswet op het Nederlanderschap 1984, art. 5, lid 2', 'VK', 19850101, 19981001, '2023-05-10 09:16:54.225184');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (25, 'Rijkswet op het Nederlanderschap 1984, art. 6, lid 1, onder a', 'VK', 19850101, 20030401, '2023-05-10 09:16:54.22705');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (26, 'Rijkswet op het Nederlanderschap 1984, art. 6, lid 1, onder b', 'VK', 19850101, 20030401, '2023-05-10 09:16:54.229407');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (27, 'Rijkswet op het Nederlanderschap 1984, art. 7', 'VK', 19850101, NULL, '2023-05-10 09:16:54.233407');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (28, 'Rijkswet op het Nederlanderschap 1984, art. 10', 'VK', 19850101, NULL, '2023-05-10 09:16:54.282667');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (29, 'Rijkswet op het Nederlanderschap 1984, art. 27, lid 2', 'VK', 19850101, 19880101, '2023-05-10 09:16:54.28577');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (30, 'Rijkswet op het Nederlanderschap 1984, art. 11', 'VK', 19850101, 20030401, '2023-05-10 09:16:54.287404');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (31, 'Toescheidingsovereenkomst Nederland - Suriname, art. 6, lid 1', 'VK', 19751125, 19931125, '2023-05-10 09:16:54.289441');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (32, 'Toescheidingsovereenkomst Nederland - Suriname, art. 6, lid 2', 'VK', 19751125, 19931125, '2023-05-10 09:16:54.29187');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (33, 'Toescheidingsovereenkomst Nederland - Suriname, art. 6, lid 4', 'VK', 19751125, 19981125, '2023-05-10 09:16:54.295356');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (34, 'Toescheidingsovereenkomst Nederland-Suriname, art. 2, lid 1, jo. art. 5, lid 2', 'VL', 19751125, NULL, '2023-05-10 09:16:54.301469');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (35, 'Toescheidingsovereenkomst Nederland-Suriname, art. 2, lid 1, jo. art. 6, lid 1', 'VL', 19751125, 19931125, '2023-05-10 09:16:54.304328');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (36, 'Toescheidingsovereenkomst Nederland-Suriname, art. 2, lid 1, jo. art. 6, lid 2', 'VL', 19751125, 19931125, '2023-05-10 09:16:54.351123');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (37, 'Toescheidingsovereenkomst Nederland-Suriname, art. 2, lid 1, jo art. 6, lid 4', 'VL', 19751125, 19981125, '2023-05-10 09:16:54.352635');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (38, 'Toescheidingsovereenkomst Nederland-Suriname, art. 2, lid 1, jo. art. 7, lid 1', 'VL', 19751125, NULL, '2023-05-10 09:16:54.353982');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (39, 'Toescheidingsovereenkomst Nederland-Suriname, art. 2, lid 1, jo. art. 7, lid 2', 'VL', 19751125, NULL, '2023-05-10 09:16:54.356152');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (40, 'Overgangsbep. bij Wet op het Nederlanderschap 1892. Bep.: Wet 15 juli 1910', 'VK', 19100816, 19100817, '2023-05-10 09:16:54.357672');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (41, 'Overgangsbep. bij Wet op het Nederl. 1892. Bep: Rijkswet 14-11-63, art. 3, sub I', 'VK', 19640301, 20030401, '2023-05-10 09:16:54.359291');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (42, 'Overg.bep. bij Wet op het Nederl. 1892. Bep: Rijkswet 14-11-63, art. 3, sub III', 'VK', 19640301, 20030401, '2023-05-10 09:16:54.360697');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (43, 'Overgangsbep. bij Wet op het Nederl. 1892. Bep: Rijkswet 14-11-63, art. 3, sub V', 'VK', 19640301, 20030401, '2023-05-10 09:16:54.362039');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (44, 'Toescheidingsovereenkomst Nederland-Suriname, art. 6, lid 5', 'VK', 19751125, 19981125, '2023-05-10 09:16:54.363929');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (45, 'Toescheidingsovereenkomst Nederland-Suriname, art. 7, lid 1', 'VK', 19751125, NULL, '2023-05-10 09:16:54.36562');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (46, 'Toescheidingsovereenkomst Nederland-Suriname, art. 7, lid 2', 'VK', 19751125, NULL, '2023-05-10 09:16:54.367466');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (47, 'Toescheidingsovereenkomst Nederland-Suriname, art. 8, lid 1', 'VK', 19751125, 19761125, '2023-05-10 09:16:54.369582');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (48, 'Toescheidingsovereenkomst Nederland-Suriname, art. 10', 'VK', 19751125, 19761125, '2023-05-10 09:16:54.372033');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (49, 'Rijkswet op het Nederlanderschap 1984, art. 28', 'VK', 19850101, 20030401, '2023-05-10 09:16:54.374224');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (50, 'Toescheidingsovereenkomst Nederland-Suriname, art. 2, lid 1, jo. art. 8, lid 2', 'VL', 19751125, 19761125, '2023-05-10 09:16:54.377506');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (51, 'Toescheidingsovereenkomst Nederland-Suriname, art. 2, lid 1, jo. art. 9', 'VL', 19751125, 19781125, '2023-05-10 09:16:54.379735');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (52, 'Wet op het Nederlanderschap 1892 i.v.m. wijziging 1962, art. 2bis', 'VK', 19521226, 19751125, '2023-05-10 09:16:54.381333');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (53, 'Wet 30 juli 1953, art. 1, lid 1', 'VK', 19530805, 19770315, '2023-05-10 09:16:54.383238');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (54, 'Wet 30 juli 1953, art. 1, lid 2', 'VK', 19530805, 19770315, '2023-05-10 09:16:54.385143');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (55, 'Wet 3 november 1954, art. 2', 'VK', 19541108, 19751125, '2023-05-10 09:16:54.388427');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (56, 'Wet 3 november 1954, art. 3', 'VK', 19541108, 19751125, '2023-05-10 09:16:54.392724');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (57, 'Wet op het Nederlanderschap 1892 i.v.m. wijziging 1976, art. 5', 'VK', 19770315, 19850101, '2023-05-10 09:16:54.39692');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (58, 'Wet op het Nederlanderschap 1892, art. 5', 'VL', 18930701, 19640301, '2023-05-10 09:16:54.401833');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (59, 'Wet op het Nederlanderschap 1892 i.v.m. wijziging 1976, art. 5', 'VL', 19770315, 19770315, '2023-05-10 09:16:54.405603');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (60, 'Wet op het Nederlanderschap 1892, art. 7, onder 1', 'VL', 18930701, 19850101, '2023-05-10 09:16:54.407538');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (61, 'Wet op het Nederlanderschap 1892, art. 7, onder 2', 'VL', 19370701, 19850101, '2023-05-10 09:16:54.409576');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (62, 'Wet op het Nederlanderschap 1892, art. 7, onder 3', 'VL', 18930701, 19850101, '2023-05-10 09:16:54.412262');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (63, 'Wet op het Nederlanderschap 1892, art. 7, onder 4', 'VL', 18930701, 19850101, '2023-05-10 09:16:54.414002');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (64, 'Wet op het Nederlanderschap 1892, art. 7, onder 5', 'VL', 18930701, 19850101, '2023-05-10 09:16:54.415942');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (65, 'Wet op het Nederlanderschap 1892 i.v.m. wijziging 1963, art. 8a', 'VL', 19640301, 19850101, '2023-05-10 09:16:54.417683');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (66, 'Wet op het Nederlanderschap 1892 i.v.m. wijziging 1963, art. 8c', 'VL', 19640301, 19850101, '2023-05-10 09:16:54.41989');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (67, 'Wet op het Nederlanderschap 1892 i.v.m. wijziging 1963, art. 9', 'VL', 19640301, 19770315, '2023-05-10 09:16:54.425229');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (68, 'Overgangsbep. bij Wet op het Nederl. 1892. Bep.: Wet 21 dec. 1936', 'VL', 19370701, 19850101, '2023-05-10 09:16:54.428468');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (69, 'Overg.bep. bij de Wet op het Nederl. 1892. Bep: Wet 12-7-62. VERVALLEN!', 'VL', 19621001, 19911101, '2023-05-10 09:16:54.430934');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (70, 'Overg.bep. bij Wet op het Nederl. 1892.  Bep: Rijkswet 14-11-63, art. 3, sub II', 'VL', 19640301, 19850101, '2023-05-10 09:16:54.434366');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (71, 'Overg.bep. bij Wet op het Nederl. 1892. Bep: Rijkswet 14-11-1963, art. 3, sub IV', 'VL', 19640301, 19850101, '2023-05-10 09:16:54.437845');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (72, 'Overg.bep. bij Wet op het Nederl. 1892. Bep: Rijkswet  14-11-1963, art. 3, sub V', 'VL', 19640301, 19850101, '2023-05-10 09:16:54.439653');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (73, 'Toescheidingsovereenkomst Nederland - Suriname, art. 2, lid 1, jo. art. 3', 'VL', 19751125, 19751126, '2023-05-10 09:16:54.441003');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (74, 'Toescheidingsovereenkomst Nederland - Suriname, art. 2, lid 1, jo. art. 4, sub a', 'VL', 19751125, 19751126, '2023-05-10 09:16:54.44217');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (75, 'Toescheidingsovereenkomst Nederland - Suriname, art. 2, lid 1, jo. art. 4, sub b', 'VL', 19751125, 19751126, '2023-05-10 09:16:54.443776');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (76, 'Toescheidingsovereenkomst Nederland - Suriname, art. 2, lid 1, jo. art. 5, lid 1', 'VL', 19751125, 19860101, '2023-05-10 09:16:54.44571');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (77, 'Rijkswet op het Nederlanderschap 1984, art. 15, onder a', 'VL', 19850101, 20030401, '2023-05-10 09:16:54.448171');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (78, 'Rijkswet op het Nederlanderschap 1984, art. 15, onder b', 'VL', 19850101, 20030401, '2023-05-10 09:16:54.450537');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (79, 'Rijkswet op het Nederlanderschap 1984, art. 15, onder c', 'VL', 19850101, 20030401, '2023-05-10 09:16:54.452894');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (80, 'Rijkswet op het Nederlanderschap 1984, art. 15, onder d', 'VL', 19850101, 20030401, '2023-05-10 09:16:54.454466');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (81, 'Rijkswet op het Nederlanderschap 1984, art. 16, lid 1, onder a', 'VL', 19850101, 20030401, '2023-05-10 09:16:54.45602');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (82, 'Rijkswet op het Nederlanderschap 1984, art. 16, lid 1, onder b', 'VL', 19850101, 20030401, '2023-05-10 09:16:54.457438');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (83, 'Rijkswet op het Nederlanderschap 1984, art. 16, lid 1, onder c', 'VL', 19850101, 20030401, '2023-05-10 09:16:54.458852');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (84, 'Rijkswet op het Nederlanderschap 1984, art. 16, lid 1, onder d', 'VL', 19850101, 20030401, '2023-05-10 09:16:54.460719');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (85, 'Rijkswet 14 september 1962, art. 3, lid 1', 'VK', 19620921, NULL, '2023-05-10 09:16:54.462588');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (86, 'Rijkswet 14 september 1962, art. 3, lid 2', 'VL', 19620921, 19850101, '2023-05-10 09:16:54.463922');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (87, 'Rijkswet 8 september 1976, art. II', 'VK', 19770315, 19850101, '2023-05-10 09:16:54.465166');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (88, 'Wet op het Nederlanderschap 1892, art. 6', 'VL', 18930701, 19850101, '2023-05-10 09:16:54.466363');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (89, 'Wet op het Nederlanderschap 1892, art. 8', 'VK', 18930701, 19640301, '2023-05-10 09:16:54.467651');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (90, 'Wet op het Nederlanderschap 1892 i.v.m. wijziging 1958, art. 8a', 'VK', 19580901, 19640301, '2023-05-10 09:16:54.469185');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (91, 'Wet op het Nederlanderschap 1892 i.v.m. wijziging 1958, art. 8a', 'VL', 19580901, 19640301, '2023-05-10 09:16:54.470544');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (92, 'Wet op het Nederlanderschap 1892, art. 9', 'VL', 18930701, 19640301, '2023-05-10 09:16:54.471777');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (93, 'Koninklijk Besluit 17 november 1945, art. 2, lid 1', 'VL', 19400511, 19510113, '2023-05-10 09:16:54.472987');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (94, 'Wet 29 december 1950, art. 2', 'VK', 19400511, 19510113, '2023-05-10 09:16:54.474238');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (95, 'Wet 29 december 1950, art. 3, lid 2', 'VK', 19400511, NULL, '2023-05-10 09:16:54.475418');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (96, 'Wet 23 december 1953, art. I', 'VL', 19540301, 19540302, '2023-05-10 09:16:54.476681');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (97, 'Wet 23 december 1953, art. II', 'VK', 19540301, NULL, '2023-05-10 09:16:54.477979');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (98, 'Wet 23 december 1953, art. III', 'VK', 19540301, 19760301, '2023-05-10 09:16:54.479329');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (99, 'Overgangsbep. van de Wet op het Nederlanderschap 1892', 'VK', 18930701, 18930702, '2023-05-10 09:16:54.480928');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (100, 'Toescheidingsovereenkomst Nederland-Indonesië, art. 3', 'VL', 19491227, 19511228, '2023-05-10 09:16:54.482242');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (101, 'Toescheidingsovereenkomst Nederland-Indonesië, art. 4, lid 1', 'VK', 19491227, 19491228, '2023-05-10 09:16:54.483478');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (102, 'Toescheidingsovereenkomst Nederland-Indonesië, art. 4, lid 2, sub a', 'VK', 19491227, 19511228, '2023-05-10 09:16:54.484769');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (103, 'Toescheidingsovereenkomst Nederland-Indonesië, art. 4, lid 2, sub b', 'VK', 19491227, 19491228, '2023-05-10 09:16:54.486407');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (104, 'Toescheidingsovereenkomst Nederland-Indonesië, art. 4, lid 2, sub b', 'VL', 19491227, 19511228, '2023-05-10 09:16:54.487664');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (105, 'Toescheidingsovereenkomst Nederland-Indonesië, art. 5, 2e volzin', 'VK', 19491227, 19511228, '2023-05-10 09:16:54.489051');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (106, 'Toescheidingsovereenkomst Nederland-Indonesië, art. 5, 3e volzin', 'VK', 19491227, 19511228, '2023-05-10 09:16:54.49033');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (107, 'Toescheidingsovereenkomst Nederland-Indonesië, art. 6', 'VK', 19491227, 19491228, '2023-05-10 09:16:54.491603');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (108, 'Toescheidingsovereenkomst Nederland-Indonesië, art. 6', 'VL', 19491227, 19511228, '2023-05-10 09:16:54.492937');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (109, 'Toescheidingsovereenkomst Nederland-Indonesië, art. 7', 'VK', 19491227, 19491228, '2023-05-10 09:16:54.494267');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (110, 'Toescheidingsovereenkomst Nederland-Indonesië, art. 7', 'VL', 19491227, 19511228, '2023-05-10 09:16:54.495528');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (111, 'Toescheidingsovereenkomst Nederland-Indonesië, art. 8', 'VK', 19491227, 19671226, '2023-05-10 09:16:54.497392');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (112, 'Toescheidingsovereenkomst Nederland-Indonesië, art. 8', 'VL', 19491227, 19671226, '2023-05-10 09:16:54.499134');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (113, 'Toescheidingsovereenkomst Nederland-Indonesië, art. 10', 'VK', 19491227, NULL, '2023-05-10 09:16:54.501126');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (114, 'Toescheidingsovereenkomst Nederland-Indonesië, art. 10', 'VL', 19491227, NULL, '2023-05-10 09:16:54.551107');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (115, 'Rijkswet op het Nederlanderschap 1984, art. 14, lid 1', 'VL', 19850101, 20030401, '2023-05-10 09:16:54.552803');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (116, 'Toescheidingsovereenkomst Nederland-Suriname, art. 3 VERVALLEN!', 'VL', 19751125, 19911101, '2023-05-10 09:16:54.554062');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (117, 'Overeenkomst van Bern van 13 september 1973, art. 3, jo. art. 1, lid 1', 'VK', 19850519, 19850520, '2023-05-10 09:16:54.5563');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (118, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 1998, art. 5, lid 2', 'VK', 19981001, 20040101, '2023-05-10 09:16:54.557835');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (119, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 1998, art. 5, lid 3', 'VK', 19981001, 20040101, '2023-05-10 09:16:54.5599');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (120, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 1998, art. 5, lid 4', 'VK', 19981001, 20040101, '2023-05-10 09:16:54.562053');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (121, 'Overg.bep. bij wijz. Rijkswet Nederl.  Bep: Rijkswet 21-12-2000, art. V, lid 2', 'VK', 20010201, 20030401, '2023-05-10 09:16:54.563968');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (122, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2000, art. 3, lid 3', 'VK', 20030401, NULL, '2023-05-10 09:16:54.565699');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (123, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2000, art. 4, lid 1', 'VK', 20030401, NULL, '2023-05-10 09:16:54.567402');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (124, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2000, art. 4, lid 2', 'VK', 20030401, 20090301, '2023-05-10 09:16:54.569282');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (125, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2000, art. 6, lid 1, onder a', 'VK', 20030401, NULL, '2023-05-10 09:16:54.571018');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (126, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2000, art. 6, lid 1, onder b', 'VK', 20030401, NULL, '2023-05-10 09:16:54.572943');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (127, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2002, art. 6, lid 1, onder c', 'VK', 20030401, 20090301, '2023-05-10 09:16:54.575123');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (128, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2002, art. 6, lid 1, onder d', 'VK', 20030401, NULL, '2023-05-10 09:16:54.577128');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (129, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2000, art. 6, lid 1, onder e', 'VK', 20030401, NULL, '2023-05-10 09:16:54.57999');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (130, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2000, art. 6, lid 1, onder f', 'VK', 20030401, NULL, '2023-05-10 09:16:54.581786');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (131, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2000, art. 6, lid 1, onder g', 'VK', 20030401, NULL, '2023-05-10 09:16:54.640543');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (132, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2000, art. 6, lid 1, onder h', 'VK', 20030401, NULL, '2023-05-10 09:16:54.642286');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (133, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2002, art. 6, lid 7', 'VK', 20030401, 20090301, '2023-05-10 09:16:54.644336');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (134, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2000, art. 11, lid 1', 'VK', 20030401, NULL, '2023-05-10 09:16:54.646163');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (135, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2002, art. 11, lid 4', 'VK', 20030401, 20090301, '2023-05-10 09:16:54.647593');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (136, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2002, art. 11, lid 5', 'VK', 20030401, 20090301, '2023-05-10 09:16:54.648863');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (137, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2000, art. 11, lid 7', 'VK', 20030401, NULL, '2023-05-10 09:16:54.650789');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (138, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2000, art. 14, lid 1', 'VL', 20030401, NULL, '2023-05-10 09:16:54.652655');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (139, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2000, art. 14, lid 2', 'VL', 20030401, 20101001, '2023-05-10 09:16:54.654247');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (140, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2000, art. 15, lid 1, onder c', 'VL', 20030401, NULL, '2023-05-10 09:16:54.656132');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (141, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2000, art. 15, lid 1, onder e', 'VL', 20030401, 20170301, '2023-05-10 09:16:54.658012');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (142, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2000, art. 15A, onder a', 'VL', 20030401, 20040101, '2023-05-10 09:16:54.65978');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (143, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2000, art. 15A, onder b', 'VL', 20030401, 20040101, '2023-05-10 09:16:54.661607');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (144, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2002, art. 16, lid 1, onder a', 'VL', 20030401, NULL, '2023-05-10 09:16:54.662944');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (145, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2002, art. 16, lid 1, onder b', 'VL', 20030401, 20090301, '2023-05-10 09:16:54.664211');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (146, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2002, art. 16, lid 1, onder c', 'VL', 20030401, NULL, '2023-05-10 09:16:54.665597');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (147, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2002, art. 16, lid 1, onder d', 'VL', 20030401, NULL, '2023-05-10 09:16:54.667374');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (148, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2002, art. 16, lid 1, onder e', 'VL', 20030401, NULL, '2023-05-10 09:16:54.669088');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (149, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2000, art. 16A', 'VL', 20030401, 20040101, '2023-05-10 09:16:54.670906');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (150, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2002, art. 26, lid 3', 'VK', 20030401, 20090301, '2023-05-10 09:16:54.673045');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (151, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2000, art. 28, lid 1', 'VK', 20030401, NULL, '2023-05-10 09:16:54.674491');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (152, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2002, art. 28, lid 3', 'VK', 20030401, 20090301, '2023-05-10 09:16:54.676131');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (153, 'Overgangsbep. bij wijz. Rijkswet Nederl. Bep: Rijkswet 21-12-2000, art. V, lid 1', 'VK', 20030401, 20050401, '2023-05-10 09:16:54.677469');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (154, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2000, art. 15, lid 1, onder a', 'VL', 20030401, NULL, '2023-05-10 09:16:54.679211');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (155, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2000, art. 15, lid 1, onder b', 'VL', 20030401, NULL, '2023-05-10 09:16:54.681053');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (156, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2000, art. 15, lid 1, onder d', 'VL', 20030401, NULL, '2023-05-10 09:16:54.730311');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (157, 'Verdrag van Straatsburg van 6 mei 1963, art. 1, lid 1', 'VL', 19850610, NULL, '2023-05-10 09:16:54.73147');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (158, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2003, art. 5', 'VK', 20040101, NULL, '2023-05-10 09:16:54.732648');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (159, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2003, art. 5a, lid 1', 'VK', 20040101, NULL, '2023-05-10 09:16:54.73377');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (160, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2003, art. 5a, lid 2', 'VK', 20040101, NULL, '2023-05-10 09:16:54.735086');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (161, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2003, art. 5b, lid 1', 'VK', 20040101, NULL, '2023-05-10 09:16:54.736533');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (162, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2003, art. 5b, lid 2', 'VK', 20040101, NULL, '2023-05-10 09:16:54.737869');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (163, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2003, art. 5c', 'VK', 20040101, NULL, '2023-05-10 09:16:54.73909');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (164, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2008, art. 4, lid 2', 'VK', 20090301, NULL, '2023-05-10 09:16:54.740538');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (165, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2008, art. 4, lid 3', 'VK', 20090301, NULL, '2023-05-10 09:16:54.741801');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (166, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2008, art. 4, lid 4', 'VK', 20090301, NULL, '2023-05-10 09:16:54.743089');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (167, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2008, art. 4, lid 5', 'VK', 20090301, NULL, '2023-05-10 09:16:54.745029');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (168, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2008, art. 6, lid 1, onder c', 'VK', 20090301, NULL, '2023-05-10 09:16:54.746512');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (169, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2008, art. 6, lid 8', 'VK', 20090301, NULL, '2023-05-10 09:16:54.747895');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (170, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2008, art. 11, lid 4', 'VK', 20090301, NULL, '2023-05-10 09:16:54.74921');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (171, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2008, art. 11, lid 5', 'VK', 20090301, NULL, '2023-05-10 09:16:54.750467');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (172, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2008, art. 16, lid 1, onder b', 'VL', 20090301, NULL, '2023-05-10 09:16:54.800614');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (173, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2008, art. 26, lid 3', 'VK', 20090301, NULL, '2023-05-10 09:16:54.802091');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (174, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2008, art. 28, lid 3', 'VK', 20090301, NULL, '2023-05-10 09:16:54.803473');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (175, 'Wijziging Rw. Nederl. Bep: Rw. 27-06-2008 art. II, lid 1, sub a (Stb. 2008, 270)', 'VK', 20090301, NULL, '2023-05-10 09:16:54.804799');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (176, 'Wijziging Rw. Nederl. Bep: Rw. 27-06-2008 art. II, lid 1, sub b (Stb. 2008, 270)', 'VK', 20090301, NULL, '2023-05-10 09:16:54.807069');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (177, 'Wijziging Rw. Nederl. Bep: Rw. 27-06-2008 art. II, lid 1, sub c (Stb. 2008, 270)', 'VK', 20090301, NULL, '2023-05-10 09:16:54.810704');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (178, 'Wijziging Rw. Nederl. Bep: Rw. 27-06-2008 art. II, lid 2 (Stb. 2008, 270)', 'VK', 20090301, NULL, '2023-05-10 09:16:54.815269');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (179, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2010, art. 6, lid 1, onder i', 'VK', 20101001, NULL, '2023-05-10 09:16:54.818478');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (180, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2010, art. 6, lid 1, onder j', 'VK', 20101001, NULL, '2023-05-10 09:16:54.820321');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (181, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2010, art. 6, lid 1, onder k', 'VK', 20101001, NULL, '2023-05-10 09:16:54.821759');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (182, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2010, art. 6, lid 1, onder l', 'VK', 20101001, NULL, '2023-05-10 09:16:54.823079');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (183, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2010, art. 6, lid 1, onder m', 'VK', 20101001, NULL, '2023-05-10 09:16:54.824401');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (184, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2010, art. 6, lid 1, onder n', 'VK', 20101001, NULL, '2023-05-10 09:16:54.825825');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (185, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2010, art. 6, lid 1, onder o', 'VK', 20101001, NULL, '2023-05-10 09:16:54.828369');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (186, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2010, art. 14, lid 2', 'VL', 20101001, NULL, '2023-05-10 09:16:54.832174');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (187, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2010, art. 14, lid 4', 'VL', 20101001, 20170301, '2023-05-10 09:16:54.834448');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (188, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2010, art. 15, lid 1, onder f', 'VL', 20101001, 20170301, '2023-05-10 09:16:54.836007');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (189, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2017, art. 14, lid 3', 'VL', 20170301, NULL, '2023-05-10 09:16:54.837432');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (190, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2017, art. 14, lid 4', 'VL', 20170301, NULL, '2023-05-10 09:16:54.838675');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (191, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2017, art. 14, lid 6', 'VL', 20170301, NULL, '2023-05-10 09:16:54.840538');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (192, 'Rijkswet Nederlanderschap 1984 i.v.m. wijziging 2017, art. 15, lid 1, onder e', 'VL', 20170301, NULL, '2023-05-10 09:16:54.842');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (301, 'Vaststelling bezit vreemde nationaliteit', 'OP', NULL, NULL, '2023-05-10 09:16:54.844071');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (310, 'Vaststelling bijzonder Nederlanderschap', 'OP', NULL, NULL, '2023-05-10 09:16:54.84743');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (311, 'Vaststelling onbekende nationaliteit', 'OP', NULL, NULL, '2023-05-10 09:16:54.849696');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (312, 'Vaststelling staatloosheid', 'OP', NULL, NULL, '2023-05-10 09:16:54.851396');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (401, 'Verlies vreemde nationaliteit', 'BE', NULL, NULL, '2023-05-10 09:16:54.853145');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (402, 'Afstand van vreemde nationaliteit', 'BE', NULL, NULL, '2023-05-10 09:16:54.855034');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (403, 'Vervallen vreemde nationaliteit', 'BE', NULL, NULL, '2023-05-10 09:16:54.856333');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (404, 'Beëindiging registratie (niet-Nederlandse) nationaliteit', 'BE', NULL, NULL, '2023-05-10 09:16:54.85776');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (405, 'Correctie in verband met ten onrechte opgenomen gegevens', 'BE', NULL, NULL, '2023-05-10 09:16:54.859012');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (410, 'Verlies bijzonder Nederlanderschap', 'BE', NULL, NULL, '2023-05-10 09:16:54.861193');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (411, 'Ongedaan maken onbekende nationaliteit', 'BE', NULL, NULL, '2023-05-10 09:16:54.862789');
INSERT INTO public.lo3_nl_nat_verkrijg_verlies_reden (nl_nat_verkrijg_verlies_reden, nl_nat_reden_oms, nl_nat_reden_soort, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (412, 'Beëindiging staatloosheid', 'BE', NULL, NULL, '2023-05-10 09:16:54.864697');


--
-- Data for Name: lo3_nl_reis_doc_autoriteit; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--



--
-- Data for Name: lo3_nl_reis_doc_soort; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--



--
-- Data for Name: lo3_pl; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--



--
-- Data for Name: lo3_pl_afnemer_ind; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--



--
-- Data for Name: lo3_pl_gezagsverhouding; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--



--
-- Data for Name: lo3_pl_nationaliteit; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--



--
-- Data for Name: lo3_pl_overlijden; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--



--
-- Data for Name: lo3_pl_paw_index_2; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--



--
-- Data for Name: lo3_pl_persoon; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--



--
-- Data for Name: lo3_pl_reis_doc; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--



--
-- Data for Name: lo3_pl_serialized; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--



--
-- Data for Name: lo3_pl_verblijfplaats; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--



--
-- Data for Name: lo3_pl_verblijfstitel; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--



--
-- Data for Name: lo3_relatie_eind_reden; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--



--
-- Data for Name: lo3_rni_deelnemer; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--

INSERT INTO public.lo3_rni_deelnemer (deelnemer_code, deelnemer_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (0, 'Onbekend', NULL, NULL, '2023-05-10 09:16:54.129922');
INSERT INTO public.lo3_rni_deelnemer (deelnemer_code, deelnemer_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (101, 'Belastingdienst (inzake heffingen en toeslagen)', 20140106, NULL, '2023-05-10 09:16:54.182453');
INSERT INTO public.lo3_rni_deelnemer (deelnemer_code, deelnemer_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (201, 'Sociale Verzekeringsbank (inzake AOW, Anw en AKW)', 20150601, NULL, '2023-05-10 09:16:54.18484');
INSERT INTO public.lo3_rni_deelnemer (deelnemer_code, deelnemer_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (301, 'Uitvoeringsinstituut werknemersverzekeringen (inzake uitkeringen)', 20150420, NULL, '2023-05-10 09:16:54.187843');
INSERT INTO public.lo3_rni_deelnemer (deelnemer_code, deelnemer_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (401, 'CAK (inzake zorgverzekeringen)', 20170101, NULL, '2023-05-10 09:16:54.190346');
INSERT INTO public.lo3_rni_deelnemer (deelnemer_code, deelnemer_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (501, 'Immigratie- en naturalisatiedienst (inzake nationaliteitsgegevens)', 20170301, NULL, '2023-05-10 09:16:54.193985');
INSERT INTO public.lo3_rni_deelnemer (deelnemer_code, deelnemer_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (601, 'Ministerie van Buitenlandse Zaken (inzake geprivilegieerden)', 20140106, NULL, '2023-05-10 09:16:54.196754');
INSERT INTO public.lo3_rni_deelnemer (deelnemer_code, deelnemer_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9999, 'Noodvoorziening loket-inschrijving', 20140106, NULL, '2023-05-10 09:16:54.198607');


--
-- Data for Name: lo3_titel_predicaat; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--

INSERT INTO public.lo3_titel_predicaat (titel_predicaat, titel_predicaat_oms, titel_predicaat_soort, creatie_dt) VALUES ('B', 'baron', 'titel', '2023-05-10 09:16:54.128235');
INSERT INTO public.lo3_titel_predicaat (titel_predicaat, titel_predicaat_oms, titel_predicaat_soort, creatie_dt) VALUES ('BS', 'barones', 'titel', '2023-05-10 09:16:54.17148');
INSERT INTO public.lo3_titel_predicaat (titel_predicaat, titel_predicaat_oms, titel_predicaat_soort, creatie_dt) VALUES ('G', 'graaf', 'titel', '2023-05-10 09:16:54.172877');
INSERT INTO public.lo3_titel_predicaat (titel_predicaat, titel_predicaat_oms, titel_predicaat_soort, creatie_dt) VALUES ('GI', 'gravin', 'titel', '2023-05-10 09:16:54.174782');
INSERT INTO public.lo3_titel_predicaat (titel_predicaat, titel_predicaat_oms, titel_predicaat_soort, creatie_dt) VALUES ('H', 'hertog', 'titel', '2023-05-10 09:16:54.176606');
INSERT INTO public.lo3_titel_predicaat (titel_predicaat, titel_predicaat_oms, titel_predicaat_soort, creatie_dt) VALUES ('HI', 'hertogin', 'titel', '2023-05-10 09:16:54.178445');
INSERT INTO public.lo3_titel_predicaat (titel_predicaat, titel_predicaat_oms, titel_predicaat_soort, creatie_dt) VALUES ('JH', 'jonkheer', 'predicaat', '2023-05-10 09:16:54.180921');
INSERT INTO public.lo3_titel_predicaat (titel_predicaat, titel_predicaat_oms, titel_predicaat_soort, creatie_dt) VALUES ('JV', 'jonkvrouw', 'predicaat', '2023-05-10 09:16:54.182812');
INSERT INTO public.lo3_titel_predicaat (titel_predicaat, titel_predicaat_oms, titel_predicaat_soort, creatie_dt) VALUES ('M', 'markies', 'titel', '2023-05-10 09:16:54.185126');
INSERT INTO public.lo3_titel_predicaat (titel_predicaat, titel_predicaat_oms, titel_predicaat_soort, creatie_dt) VALUES ('MI', 'markiezin', 'titel', '2023-05-10 09:16:54.187303');
INSERT INTO public.lo3_titel_predicaat (titel_predicaat, titel_predicaat_oms, titel_predicaat_soort, creatie_dt) VALUES ('P', 'prins', 'titel', '2023-05-10 09:16:54.18922');
INSERT INTO public.lo3_titel_predicaat (titel_predicaat, titel_predicaat_oms, titel_predicaat_soort, creatie_dt) VALUES ('PS', 'prinses', 'titel', '2023-05-10 09:16:54.191893');
INSERT INTO public.lo3_titel_predicaat (titel_predicaat, titel_predicaat_oms, titel_predicaat_soort, creatie_dt) VALUES ('R', 'ridder', 'titel', '2023-05-10 09:16:54.194683');


--
-- Data for Name: lo3_verblijfstitel_aand; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--

INSERT INTO public.lo3_verblijfstitel_aand (verblijfstitel_aand, verblijfstitel_aand_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (0, 'Onbekend', NULL, NULL, '2023-05-10 09:16:54.129577');
INSERT INTO public.lo3_verblijfstitel_aand (verblijfstitel_aand, verblijfstitel_aand_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (9, 'Art. 9 van de Vreemdelingenwet', NULL, 19941001, '2023-05-10 09:16:54.18179');
INSERT INTO public.lo3_verblijfstitel_aand (verblijfstitel_aand, verblijfstitel_aand_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (10, 'Art. 10 van de Vreemdelingenwet', NULL, 19941001, '2023-05-10 09:16:54.183952');
INSERT INTO public.lo3_verblijfstitel_aand (verblijfstitel_aand, verblijfstitel_aand_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (11, 'Vergunning art. 9 Vw, zonder beperking, dan wel gerechtigd krachtens art. 10 Vw', 19670101, 20010401, '2023-05-10 09:16:54.186138');
INSERT INTO public.lo3_verblijfstitel_aand (verblijfstitel_aand, verblijfstitel_aand_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (12, 'Vergunning art. 9 Vw, met beperking, die elke vorm arbeid in loondienst toestaat', 19670101, 20010401, '2023-05-10 09:16:54.188654');
INSERT INTO public.lo3_verblijfstitel_aand (verblijfstitel_aand, verblijfstitel_aand_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (13, 'Vergunning art. 9 Vw, met beperking, die arbeid in loondienst niet toestaat', 19670101, 20010401, '2023-05-10 09:16:54.191411');
INSERT INTO public.lo3_verblijfstitel_aand (verblijfstitel_aand, verblijfstitel_aand_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (14, 'Voorwaardelijke vergunning art. 9a Vw', 19940101, 20010401, '2023-05-10 09:16:54.194193');
INSERT INTO public.lo3_verblijfstitel_aand (verblijfstitel_aand, verblijfstitel_aand_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (15, 'Benelux of EG richtl nrs 68/360/EEG, 73/148/EEG 75/34/EEG, verord nr 1251/70/EEG', 19520723, 20010401, '2023-05-10 09:16:54.197028');
INSERT INTO public.lo3_verblijfstitel_aand (verblijfstitel_aand, verblijfstitel_aand_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (16, 'EG-richtlijnen nrs. 90/364/EEG, 90/365/EEG en 90/366/EEG', 19520723, 20010401, '2023-05-10 09:16:54.199084');
INSERT INTO public.lo3_verblijfstitel_aand (verblijfstitel_aand, verblijfstitel_aand_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (17, 'Verzoek tot toelating als vluchteling, uitzetting blijft achterwege', 19540421, 20010401, '2023-05-10 09:16:54.201708');
INSERT INTO public.lo3_verblijfstitel_aand (verblijfstitel_aand, verblijfstitel_aand_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (18, 'Gemeld bij VD, geen verzoek toelating als vluchteling, geen uitzetting', 19460101, 20010401, '2023-05-10 09:16:54.203711');
INSERT INTO public.lo3_verblijfstitel_aand (verblijfstitel_aand, verblijfstitel_aand_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (19, 'Vergunning art. 9 Vw, met andere beperking dan hierboven', 19670101, 20010401, '2023-05-10 09:16:54.20553');
INSERT INTO public.lo3_verblijfstitel_aand (verblijfstitel_aand, verblijfstitel_aand_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (20, 'Ander verdrag dan hierboven', 19460101, 20010401, '2023-05-10 09:16:54.207723');
INSERT INTO public.lo3_verblijfstitel_aand (verblijfstitel_aand, verblijfstitel_aand_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (21, 'Vw 2000 art. 8, onder a, vergunning regulier bepaalde tijd, arbeid vrij', NULL, NULL, '2023-05-10 09:16:54.20912');
INSERT INTO public.lo3_verblijfstitel_aand (verblijfstitel_aand, verblijfstitel_aand_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (22, 'Vw2000 art. 8, sub a, VVR bep tijd arbeid mits TWV, VVR bep tijd verblijf&arbeid', NULL, NULL, '2023-05-10 09:16:54.210467');
INSERT INTO public.lo3_verblijfstitel_aand (verblijfstitel_aand, verblijfstitel_aand_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (23, 'Vw 2000 art. 8, onder a, vergunning regulier bepaalde tijd, arbeid specifiek', NULL, NULL, '2023-05-10 09:16:54.264182');
INSERT INTO public.lo3_verblijfstitel_aand (verblijfstitel_aand, verblijfstitel_aand_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (24, 'Vw 2000 art. 8, onder a, vergunning regulier bepaalde tijd, geen arbeid', NULL, NULL, '2023-05-10 09:16:54.26854');
INSERT INTO public.lo3_verblijfstitel_aand (verblijfstitel_aand, verblijfstitel_aand_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (25, 'Vw 2000 art. 8, sub b, verg. reg. onbep. tijd of langdurig ingez., arbeid vrij', NULL, NULL, '2023-05-10 09:16:54.270386');
INSERT INTO public.lo3_verblijfstitel_aand (verblijfstitel_aand, verblijfstitel_aand_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (26, 'Vw 2000 art. 8, onder c, vergunning asiel bepaalde tijd, arbeid vrij', NULL, NULL, '2023-05-10 09:16:54.271886');
INSERT INTO public.lo3_verblijfstitel_aand (verblijfstitel_aand, verblijfstitel_aand_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (27, 'Vw 2000 art. 8, sub d, verg. asiel onbep. tijd of langdurig ingez., arbeid vrij', NULL, NULL, '2023-05-10 09:16:54.273889');
INSERT INTO public.lo3_verblijfstitel_aand (verblijfstitel_aand, verblijfstitel_aand_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (28, 'Vw 2000 art. 8, onder e, gemeenschapsonderdaan econ. actief, arbeid vrij', NULL, NULL, '2023-05-10 09:16:54.275108');
INSERT INTO public.lo3_verblijfstitel_aand (verblijfstitel_aand, verblijfstitel_aand_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (29, 'Vw 2000 art. 8, onder e, gemeenschapsonderdaan econ. niet-actief, arbeid vrij', NULL, NULL, '2023-05-10 09:16:54.276666');
INSERT INTO public.lo3_verblijfstitel_aand (verblijfstitel_aand, verblijfstitel_aand_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (30, 'Vw 2000 art. 8, onder e, toetsing aan het gemeenschapsrecht, arbeid vrij', NULL, NULL, '2023-05-10 09:16:54.280601');
INSERT INTO public.lo3_verblijfstitel_aand (verblijfstitel_aand, verblijfstitel_aand_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (31, 'Vw 2000 art. 8, onder f en h, in procedure voor vergunning art. 14 Vw 2000', NULL, NULL, '2023-05-10 09:16:54.283672');
INSERT INTO public.lo3_verblijfstitel_aand (verblijfstitel_aand, verblijfstitel_aand_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (32, 'Vw 2000 art. 8, onder f en h, in procedure voor vergunning art. 28 Vw 2000', NULL, NULL, '2023-05-10 09:16:54.285369');
INSERT INTO public.lo3_verblijfstitel_aand (verblijfstitel_aand, verblijfstitel_aand_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (33, 'Vw 2000 art. 8, onder g en h, in procedure voortgezet verblijf, tijdige aanvr.', NULL, NULL, '2023-05-10 09:16:54.286962');
INSERT INTO public.lo3_verblijfstitel_aand (verblijfstitel_aand, verblijfstitel_aand_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (34, 'Vw 2000 art. 8, onder g en h, in procedure voortgezet verblijf, ontijdige aanvr.', NULL, NULL, '2023-05-10 09:16:54.289802');
INSERT INTO public.lo3_verblijfstitel_aand (verblijfstitel_aand, verblijfstitel_aand_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (35, 'Vw 2000 art. 8, onder l, Associatiebesluit 1/80 EEG/Turkije, arbeid specifiek', NULL, NULL, '2023-05-10 09:16:54.292481');
INSERT INTO public.lo3_verblijfstitel_aand (verblijfstitel_aand, verblijfstitel_aand_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (36, 'Vw 2000 art. 8, onder e, gemeenschapsonderdaan econ. actief, arbeid specifiek', 20040501, NULL, '2023-05-10 09:16:54.298354');
INSERT INTO public.lo3_verblijfstitel_aand (verblijfstitel_aand, verblijfstitel_aand_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (37, 'Vw 2000 art. 8, onder e, gemeenschapsonderdaan econ. niet-actief, arbeid spec.', 20040501, NULL, '2023-05-10 09:16:54.302566');
INSERT INTO public.lo3_verblijfstitel_aand (verblijfstitel_aand, verblijfstitel_aand_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (38, 'Vw 2000 art. 8, onder e, toetsing aan het gemeenschapsrecht, arbeid specifiek', 20040501, NULL, '2023-05-10 09:16:54.306239');
INSERT INTO public.lo3_verblijfstitel_aand (verblijfstitel_aand, verblijfstitel_aand_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (39, 'Vw 2000 art. 8, onder m, in afwachting indiening asielaanvraag, geen arbeid', 20000101, 20140101, '2023-05-10 09:16:54.30817');
INSERT INTO public.lo3_verblijfstitel_aand (verblijfstitel_aand, verblijfstitel_aand_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (40, 'Vw 2000 art. 8, onder e, gemeenschapsonderdaan duurzaam verblijf, arbeid vrij', NULL, NULL, '2023-05-10 09:16:54.311699');
INSERT INTO public.lo3_verblijfstitel_aand (verblijfstitel_aand, verblijfstitel_aand_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (41, 'Rechtmatig verblijf Vw 2000 art. 8, onder e, is beëindigd', 20000101, NULL, '2023-05-10 09:16:54.314169');
INSERT INTO public.lo3_verblijfstitel_aand (verblijfstitel_aand, verblijfstitel_aand_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (42, 'Rechtmatig verblijf op grond van voorlopige maatregel EHRM, geen arbeid', 20000101, NULL, '2023-05-10 09:16:54.316217');
INSERT INTO public.lo3_verblijfstitel_aand (verblijfstitel_aand, verblijfstitel_aand_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (43, 'Rechtmatig verblijf op aanwijzing Minister van Justitie, geen arbeid', 20000101, NULL, '2023-05-10 09:16:54.31828');
INSERT INTO public.lo3_verblijfstitel_aand (verblijfstitel_aand, verblijfstitel_aand_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (44, 'Vw 2000 art. 8, onder m, Dublinclaimant, wacht op overdracht, rva, geen arbeid', 20140101, NULL, '2023-05-10 09:16:54.320868');
INSERT INTO public.lo3_verblijfstitel_aand (verblijfstitel_aand, verblijfstitel_aand_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (45, 'Vw 2000 art. 8, onder i, onderzoeker/student, verblijfsrecht in EU-land', 20180523, NULL, '2023-05-10 09:16:54.324176');
INSERT INTO public.lo3_verblijfstitel_aand (verblijfstitel_aand, verblijfstitel_aand_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (46, 'Vw2000 art 8, onder f en h, EU-richtl 2001/55, in proc art 28, arbeid loondienst', NULL, NULL, '2023-05-10 09:16:54.330388');
INSERT INTO public.lo3_verblijfstitel_aand (verblijfstitel_aand, verblijfstitel_aand_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (91, 'Vw 2000 art. 115, lid 4, vergunning onbepaalde tijd, arbeid vrij', NULL, 20140106, '2023-05-10 09:16:54.334142');
INSERT INTO public.lo3_verblijfstitel_aand (verblijfstitel_aand, verblijfstitel_aand_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (92, 'Vw 2000 art. 115, lid 6, vergunning asiel bepaalde tijd, arbeid vrij', NULL, 20140106, '2023-05-10 09:16:54.336156');
INSERT INTO public.lo3_verblijfstitel_aand (verblijfstitel_aand, verblijfstitel_aand_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (93, 'Vw 2000 art. 115, lid 2, verg. regulier bepaalde tijd, arbeid nader te bepalen', NULL, 20140106, '2023-05-10 09:16:54.33792');
INSERT INTO public.lo3_verblijfstitel_aand (verblijfstitel_aand, verblijfstitel_aand_oms, tabel_regel_start_datum, tabel_regel_eind_datum, creatie_dt) VALUES (98, 'geen verblijfstitel (meer)', NULL, NULL, '2023-05-10 09:16:54.33969');


--
-- Data for Name: lo3_voorvoegsel; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--



--
-- Data for Name: lo3_voorwaarde_regel_aut; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--



--
-- Data for Name: lo3_vospg_instructie; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--



--
-- Data for Name: lookup_codering; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--



--
-- Data for Name: lookup_codewaarde; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--



--
-- Data for Name: miteller; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--



--
-- Data for Name: miteller_marker; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--



--
-- Data for Name: monitor; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--



--
-- Data for Name: selectie_enumeratie; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--



--
-- Data for Name: selectie_instelling; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--



--
-- Data for Name: spg_mailbox; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--



--
-- Data for Name: spg_schema; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--



--
-- Data for Name: tmp_convert_special_characters_adres; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--



--
-- Data for Name: tmp_convert_special_characters_persoon; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--



--
-- Data for Name: toestand_overgang; Type: TABLE DATA; Schema: public; Owner: haalcentraal
--



--
-- Data for Name: pl_bericht; Type: TABLE DATA; Schema: vospg; Owner: haalcentraal
--



--
-- Name: activiteit_id_sequence; Type: SEQUENCE SET; Schema: public; Owner: haalcentraal
--

SELECT pg_catalog.setval('public.activiteit_id_sequence', 1, false);


--
-- Name: adres_id_sequence; Type: SEQUENCE SET; Schema: public; Owner: haalcentraal
--

SELECT pg_catalog.setval('public.adres_id_sequence', 1, false);


--
-- Name: afnemer_id_sequence; Type: SEQUENCE SET; Schema: public; Owner: haalcentraal
--

SELECT pg_catalog.setval('public.afnemer_id_sequence', 1, false);


--
-- Name: gebeurtenis_data_id_sequence; Type: SEQUENCE SET; Schema: public; Owner: haalcentraal
--

SELECT pg_catalog.setval('public.gebeurtenis_data_id_sequence', 1, false);


--
-- Name: gebeurtenis_id_sequence; Type: SEQUENCE SET; Schema: public; Owner: haalcentraal
--

SELECT pg_catalog.setval('public.gebeurtenis_id_sequence', 1, false);


--
-- Name: lo3_autorisatie_id_sequence; Type: SEQUENCE SET; Schema: public; Owner: haalcentraal
--

SELECT pg_catalog.setval('public.lo3_autorisatie_id_sequence', 1, false);


--
-- Name: lo3_bericht_id_sequence; Type: SEQUENCE SET; Schema: public; Owner: haalcentraal
--

SELECT pg_catalog.setval('public.lo3_bericht_id_sequence', 1, false);


--
-- Name: lo3_pl_id_sequence; Type: SEQUENCE SET; Schema: public; Owner: haalcentraal
--

SELECT pg_catalog.setval('public.lo3_pl_id_sequence', 1, false);


--
-- Name: lo3_vospg_instructie_id_sequence; Type: SEQUENCE SET; Schema: public; Owner: haalcentraal
--

SELECT pg_catalog.setval('public.lo3_vospg_instructie_id_sequence', 1, false);


--
-- Name: monitor_id_sequence; Type: SEQUENCE SET; Schema: public; Owner: haalcentraal
--

SELECT pg_catalog.setval('public.monitor_id_sequence', 1, false);


--
-- Name: selectie_instelling_id_sequence; Type: SEQUENCE SET; Schema: public; Owner: haalcentraal
--

SELECT pg_catalog.setval('public.selectie_instelling_id_sequence', 1, false);


--
-- Name: toestand_overgang_id_sequence; Type: SEQUENCE SET; Schema: public; Owner: haalcentraal
--

SELECT pg_catalog.setval('public.toestand_overgang_id_sequence', 1, false);


--
-- Name: pl_bericht_id_sequence; Type: SEQUENCE SET; Schema: vospg; Owner: haalcentraal
--

SELECT pg_catalog.setval('vospg.pl_bericht_id_sequence', 1, false);


--
-- Name: activiteit_small activiteit_small_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.activiteit_small
    ADD CONSTRAINT activiteit_small_pk PRIMARY KEY (activiteit_id);


--
-- Name: afnemer afnemer_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.afnemer
    ADD CONSTRAINT afnemer_pk PRIMARY KEY (afnemer_id);


--
-- Name: gebeurtenis_data gebeurtenis_data_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.gebeurtenis_data
    ADD CONSTRAINT gebeurtenis_data_pk PRIMARY KEY (gebeurtenis_data_id);


--
-- Name: gebeurtenis_small gebeurtenis_small_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.gebeurtenis_small
    ADD CONSTRAINT gebeurtenis_small_pk PRIMARY KEY (gebeurtenis_id);


--
-- Name: haalcentraal_vraag haalcentraal_vraag_pk; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.haalcentraal_vraag
    ADD CONSTRAINT haalcentraal_vraag_pk PRIMARY KEY (request_id);


--
-- Name: herindeling herindeling_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.herindeling
    ADD CONSTRAINT herindeling_pk PRIMARY KEY (herindeling_id);


--
-- Name: lo3_adres_afnemer_ind lo3_adres_afnemer_ind_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_adres_afnemer_ind
    ADD CONSTRAINT lo3_adres_afnemer_ind_pk PRIMARY KEY (adres_id, afnemer_code);


--
-- Name: lo3_adres lo3_adres_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_adres
    ADD CONSTRAINT lo3_adres_pk PRIMARY KEY (adres_id);


--
-- Name: lo3_afnemers_verstrekking_aut lo3_afnemers_verstrekking_aut_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_afnemers_verstrekking_aut
    ADD CONSTRAINT lo3_afnemers_verstrekking_aut_pk PRIMARY KEY (autorisatie_id, afnemer_code);


--
-- Name: lo3_akte_aand lo3_akte_aand_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_akte_aand
    ADD CONSTRAINT lo3_akte_aand_pk PRIMARY KEY (akte_aand);


--
-- Name: lo3_autorisatie lo3_autorisatie_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_autorisatie
    ADD CONSTRAINT lo3_autorisatie_pk PRIMARY KEY (autorisatie_id);


--
-- Name: lo3_bericht lo3_bericht_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_bericht
    ADD CONSTRAINT lo3_bericht_pk PRIMARY KEY (lo3_bericht_id);


--
-- Name: lo3_gba_deelnemer lo3_gba_deelnemer_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_gba_deelnemer
    ADD CONSTRAINT lo3_gba_deelnemer_pk PRIMARY KEY (deelnemer_code);


--
-- Name: lo3_gemeente lo3_gemeente_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_gemeente
    ADD CONSTRAINT lo3_gemeente_pk PRIMARY KEY (gemeente_code);


--
-- Name: lo3_gezagsverhouding lo3_gezagsverhouding_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_gezagsverhouding
    ADD CONSTRAINT lo3_gezagsverhouding_pk PRIMARY KEY (gezagsverhouding_code);


--
-- Name: lo3_land lo3_land_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_land
    ADD CONSTRAINT lo3_land_pk PRIMARY KEY (land_code);


--
-- Name: lo3_mailbox lo3_mailbox_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_mailbox
    ADD CONSTRAINT lo3_mailbox_pk PRIMARY KEY (lo3_mailbox_nummer);


--
-- Name: lo3_nationaliteit lo3_nationaliteit_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_nationaliteit
    ADD CONSTRAINT lo3_nationaliteit_pk PRIMARY KEY (nationaliteit_code);


--
-- Name: lo3_nl_nat_verkrijg_verlies_reden lo3_nl_nat_verkrijg_verlies_reden_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_nl_nat_verkrijg_verlies_reden
    ADD CONSTRAINT lo3_nl_nat_verkrijg_verlies_reden_pk PRIMARY KEY (nl_nat_verkrijg_verlies_reden);


--
-- Name: lo3_nl_reis_doc_autoriteit lo3_nl_reis_doc_autoriteit_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_nl_reis_doc_autoriteit
    ADD CONSTRAINT lo3_nl_reis_doc_autoriteit_pk PRIMARY KEY (nl_reis_doc_autoriteit_code);


--
-- Name: lo3_nl_reis_doc_soort lo3_nl_reis_doc_soort_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_nl_reis_doc_soort
    ADD CONSTRAINT lo3_nl_reis_doc_soort_pk PRIMARY KEY (nl_reis_doc_soort);


--
-- Name: lo3_pl_afnemer_ind lo3_pl_afnemer_ind_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_pl_afnemer_ind
    ADD CONSTRAINT lo3_pl_afnemer_ind_pk PRIMARY KEY (pl_id, stapel_nr, volg_nr);


--
-- Name: lo3_pl_gezagsverhouding lo3_pl_gezagsverhouding_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_pl_gezagsverhouding
    ADD CONSTRAINT lo3_pl_gezagsverhouding_pk PRIMARY KEY (pl_id, volg_nr);


--
-- Name: lo3_pl_nationaliteit lo3_pl_nationaliteit_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_pl_nationaliteit
    ADD CONSTRAINT lo3_pl_nationaliteit_pk PRIMARY KEY (pl_id, stapel_nr, volg_nr);


--
-- Name: lo3_pl_overlijden lo3_pl_overlijden_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_pl_overlijden
    ADD CONSTRAINT lo3_pl_overlijden_pk PRIMARY KEY (pl_id, volg_nr);


--
-- Name: lo3_pl_paw_index_2 lo3_pl_paw_index_2_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_pl_paw_index_2
    ADD CONSTRAINT lo3_pl_paw_index_2_pk PRIMARY KEY (pl_id);


--
-- Name: lo3_pl_persoon lo3_pl_persoon_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_pl_persoon
    ADD CONSTRAINT lo3_pl_persoon_pk PRIMARY KEY (pl_id, persoon_type, stapel_nr, volg_nr);

ALTER TABLE public.lo3_pl_persoon CLUSTER ON lo3_pl_persoon_pk;


--
-- Name: lo3_pl lo3_pl_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_pl
    ADD CONSTRAINT lo3_pl_pk PRIMARY KEY (pl_id);


--
-- Name: lo3_pl_reis_doc lo3_pl_reis_doc_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_pl_reis_doc
    ADD CONSTRAINT lo3_pl_reis_doc_pk PRIMARY KEY (pl_id, stapel_nr);

ALTER TABLE public.lo3_pl_reis_doc CLUSTER ON lo3_pl_reis_doc_pk;


--
-- Name: lo3_pl_serialized lo3_pl_serialized_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_pl_serialized
    ADD CONSTRAINT lo3_pl_serialized_pk PRIMARY KEY (pl_id);


--
-- Name: lo3_pl_verblijfplaats lo3_pl_verblijfplaats_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_pl_verblijfplaats
    ADD CONSTRAINT lo3_pl_verblijfplaats_pk PRIMARY KEY (pl_id, volg_nr);

ALTER TABLE public.lo3_pl_verblijfplaats CLUSTER ON lo3_pl_verblijfplaats_pk;


--
-- Name: lo3_pl_verblijfstitel lo3_pl_verblijfstitel_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_pl_verblijfstitel
    ADD CONSTRAINT lo3_pl_verblijfstitel_pk PRIMARY KEY (pl_id, volg_nr);


--
-- Name: lo3_relatie_eind_reden lo3_relatie_eind_reden_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_relatie_eind_reden
    ADD CONSTRAINT lo3_relatie_eind_reden_pk PRIMARY KEY (relatie_eind_reden);


--
-- Name: lo3_rni_deelnemer lo3_rni_deelnemer_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_rni_deelnemer
    ADD CONSTRAINT lo3_rni_deelnemer_pk PRIMARY KEY (deelnemer_code);


--
-- Name: lo3_titel_predicaat lo3_titel_predikaat_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_titel_predicaat
    ADD CONSTRAINT lo3_titel_predikaat_pk PRIMARY KEY (titel_predicaat);


--
-- Name: lo3_voorvoegsel lo3_voorvoegsel_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_voorvoegsel
    ADD CONSTRAINT lo3_voorvoegsel_pk PRIMARY KEY (voorvoegsel);


--
-- Name: lo3_voorwaarde_regel_aut lo3_voorwaarde_regel_aut_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_voorwaarde_regel_aut
    ADD CONSTRAINT lo3_voorwaarde_regel_aut_pk PRIMARY KEY (voorwaarde_type, autorisatie_id);


--
-- Name: lookup_codering lookup_codering_codering_naam_key; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lookup_codering
    ADD CONSTRAINT lookup_codering_codering_naam_key UNIQUE (codering_naam);


--
-- Name: lookup_codering lookup_codering_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lookup_codering
    ADD CONSTRAINT lookup_codering_pk PRIMARY KEY (lookup_codering_id);


--
-- Name: lookup_codewaarde lookup_codewaarde_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lookup_codewaarde
    ADD CONSTRAINT lookup_codewaarde_pk PRIMARY KEY (lookup_codering_id, lookup_omschrijving);


--
-- Name: monitor monitor_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.monitor
    ADD CONSTRAINT monitor_pk PRIMARY KEY (monitor_id);


--
-- Name: selectie_enumeratie selectie_enumeratie_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.selectie_enumeratie
    ADD CONSTRAINT selectie_enumeratie_pk PRIMARY KEY (selectie_instelling_id);


--
-- Name: selectie_instelling selectie_instelling_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.selectie_instelling
    ADD CONSTRAINT selectie_instelling_pk PRIMARY KEY (selectie_instelling_id);


--
-- Name: spg_mailbox spg_mailbox_pl; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.spg_mailbox
    ADD CONSTRAINT spg_mailbox_pl PRIMARY KEY (spg_mailbox_instantie);


--
-- Name: toestand_overgang toestand_overgang_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.toestand_overgang
    ADD CONSTRAINT toestand_overgang_pk PRIMARY KEY (toestand_overgang_id);


--
-- Name: lo3_verblijfstitel_aand verblijfstitel_aand_pk; Type: CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_verblijfstitel_aand
    ADD CONSTRAINT verblijfstitel_aand_pk PRIMARY KEY (verblijfstitel_aand);


--
-- Name: pl_bericht pl_bericht_pk; Type: CONSTRAINT; Schema: vospg; Owner: haalcentraal
--

ALTER TABLE ONLY vospg.pl_bericht
    ADD CONSTRAINT pl_bericht_pk PRIMARY KEY (pl_bericht_id);


--
-- Name: activiteit_small_idx_1; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX activiteit_small_idx_1 ON public.activiteit_small USING btree (pl_id);


--
-- Name: activiteit_small_idx_2; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX activiteit_small_idx_2 ON public.activiteit_small USING btree (start_dt, activiteit_type, toestand, activiteit_subtype);


--
-- Name: activiteit_small_idx_3; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE UNIQUE INDEX activiteit_small_idx_3 ON public.activiteit_small USING btree (moeder_id, toestand, activiteit_id);


--
-- Name: activiteit_small_idx_4; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX activiteit_small_idx_4 ON public.activiteit_small USING btree (activiteit_type, toestand, activiteit_subtype);


--
-- Name: activiteit_small_idx_5; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX activiteit_small_idx_5 ON public.activiteit_small USING btree (communicatie_partner, toestand, activiteit_type, activiteit_subtype);


--
-- Name: activiteit_small_idx_6; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX activiteit_small_idx_6 ON public.activiteit_small USING btree (activiteit_type, toestand, activiteit_id, laatste_actie_dt) WHERE ((activiteit_type = 100) AND ((toestand = 10000) OR (toestand = 10002)));


--
-- Name: activiteit_small_idx_8; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX activiteit_small_idx_8 ON public.activiteit_small USING btree (uiterlijke_actie_dt, toestand) WHERE ((toestand < 8000) OR (toestand > 9999));


--
-- Name: afnemer_idx_0; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE UNIQUE INDEX afnemer_idx_0 ON public.afnemer USING btree (afnemer_code);


--
-- Name: afnemer_idx_1; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE UNIQUE INDEX afnemer_idx_1 ON public.afnemer USING btree (oin);


--
-- Name: gebeurtenis_data_idx_1; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX gebeurtenis_data_idx_1 ON public.gebeurtenis_data USING btree (gebeurtenis_id);


--
-- Name: gebeurtenis_small_idx_1; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX gebeurtenis_small_idx_1 ON public.gebeurtenis_small USING btree (activiteit_id);


--
-- Name: gebeurtenis_small_idx_2; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX gebeurtenis_small_idx_2 ON public.gebeurtenis_small USING btree (gebeurtenis_type, gebeurtenis_hash, gebeurtenis_dt) WHERE ((gebeurtenis_type = 1103) OR (gebeurtenis_type = 1104) OR (gebeurtenis_type = 1105) OR (gebeurtenis_type = 1106) OR (gebeurtenis_type = 1110) OR (gebeurtenis_type = 1111) OR (gebeurtenis_type = 1112) OR (gebeurtenis_type = 1119));


--
-- Name: gebeurtenis_small_idx_3; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX gebeurtenis_small_idx_3 ON public.gebeurtenis_small USING btree (gebeurtenis_type, gebeurtenis_dt) WHERE ((gebeurtenis_type >= 4000) AND (gebeurtenis_type <= 4999));


--
-- Name: herindeling_idx_0; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE UNIQUE INDEX herindeling_idx_0 ON public.herindeling USING btree (nieuwe_gemeente_code, herindeling_datum);


--
-- Name: lo3_adres_afnemer_ind_idx_1; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE UNIQUE INDEX lo3_adres_afnemer_ind_idx_1 ON public.lo3_adres_afnemer_ind USING btree (afnemer_code, adres_id);


--
-- Name: lo3_adres_idx_0; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE UNIQUE INDEX lo3_adres_idx_0 ON public.lo3_adres USING btree (gemeente_code, COALESCE(gemeente_deel, ''::character varying), COALESCE(straat_naam, ''::character varying), COALESCE(diak_straat_naam, ''::character varying), COALESCE(open_ruimte_naam, ''::character varying), COALESCE(diak_open_ruimte_naam, ''::character varying), COALESCE(huis_nr, 666666), COALESCE(huis_letter, ''::bpchar), COALESCE(huis_nr_toevoeging, ''::character varying), COALESCE(huis_nr_aand, ''::character varying), COALESCE(postcode, ''::character varying), COALESCE(woon_plaats_naam, ''::character varying), COALESCE(diak_woon_plaats_naam, ''::character varying), COALESCE(locatie_beschrijving, ''::character varying), COALESCE(diak_locatie_beschrijving, ''::character varying), COALESCE(verblijf_plaats_ident_code, ''::character varying), COALESCE(nummer_aand_ident_code, ''::character varying));


--
-- Name: lo3_adres_idx_1; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_adres_idx_1 ON public.lo3_adres USING btree (lower((postcode)::text) text_pattern_ops, huis_nr, huis_letter, huis_nr_toevoeging);


--
-- Name: lo3_adres_idx_2; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_adres_idx_2 ON public.lo3_adres USING btree (gemeente_code, lower((straat_naam)::text) text_pattern_ops, huis_nr, huis_letter, huis_nr_toevoeging);


--
-- Name: lo3_adres_idx_3; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_adres_idx_3 ON public.lo3_adres USING btree (lower((straat_naam)::text) text_pattern_ops, huis_nr, huis_letter, huis_nr_toevoeging);


--
-- Name: lo3_adres_idx_4; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_adres_idx_4 ON public.lo3_adres USING btree (lower((locatie_beschrijving)::text) text_pattern_ops);


--
-- Name: lo3_bericht_idx_1; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_bericht_idx_1 ON public.lo3_bericht USING btree (eref);


--
-- Name: lo3_bericht_idx_2; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_bericht_idx_2 ON public.lo3_bericht USING btree (bref);


--
-- Name: lo3_bericht_idx_3; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_bericht_idx_3 ON public.lo3_bericht USING btree (bericht_activiteit_id);


--
-- Name: lo3_bericht_idx_4; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_bericht_idx_4 ON public.lo3_bericht USING btree (dispatch_sequence_number);


--
-- Name: lo3_bericht_idx_5; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_bericht_idx_5 ON public.lo3_bericht USING btree (berichtcyclus_id);


--
-- Name: lo3_bericht_idx_6; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_bericht_idx_6 ON public.lo3_bericht USING btree (bref, originator_or_recipient, aanduiding_in_uit);


--
-- Name: lo3_pl_afnemer_ind_idx_1; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_pl_afnemer_ind_idx_1 ON public.lo3_pl_afnemer_ind USING btree (afnemer_code, geldigheid_start_datum);


--
-- Name: lo3_pl_paw_index_2_idx_1; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_pl_paw_index_2_idx_1 ON public.lo3_pl_paw_index_2 USING btree (lower((geslachts_naam)::text) text_pattern_ops, inschrijving_gemeente_code, lower((straat_naam)::text) text_pattern_ops);


--
-- Name: lo3_pl_paw_index_2_idx_2; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_pl_paw_index_2_idx_2 ON public.lo3_pl_paw_index_2 USING btree (lower((postcode)::text) text_pattern_ops, lower((geslachts_naam)::text) text_pattern_ops);


--
-- Name: lo3_pl_paw_index_2_idx_3; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_pl_paw_index_2_idx_3 ON public.lo3_pl_paw_index_2 USING btree (geboorte_datum, lower((postcode)::text) text_pattern_ops);


--
-- Name: lo3_pl_paw_index_2_idx_4; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_pl_paw_index_2_idx_4 ON public.lo3_pl_paw_index_2 USING btree (lower((straat_naam)::text) text_pattern_ops, lower((geslachts_naam)::text) text_pattern_ops);


--
-- Name: lo3_pl_persoon_idx_0; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE UNIQUE INDEX lo3_pl_persoon_idx_0 ON public.lo3_pl_persoon USING btree (a_nr) WHERE ((persoon_type = 'P'::bpchar) AND (stapel_nr = 0) AND (volg_nr = 0));


--
-- Name: lo3_pl_persoon_idx_1; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_pl_persoon_idx_1 ON public.lo3_pl_persoon USING btree (a_nr, persoon_type, stapel_nr, volg_nr);


--
-- Name: lo3_pl_persoon_idx_2; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_pl_persoon_idx_2 ON public.lo3_pl_persoon USING btree (burger_service_nr, persoon_type, stapel_nr, volg_nr);


--
-- Name: lo3_pl_persoon_idx_3; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_pl_persoon_idx_3 ON public.lo3_pl_persoon USING btree (lower((geslachts_naam)::text) text_pattern_ops, persoon_type, stapel_nr, volg_nr, lower((voor_naam)::text) text_pattern_ops);


--
-- Name: lo3_pl_persoon_idx_4; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_pl_persoon_idx_4 ON public.lo3_pl_persoon USING btree (geboorte_datum, lower((geslachts_naam)::text) text_pattern_ops, persoon_type, stapel_nr, volg_nr, lower((voor_naam)::text) text_pattern_ops);


--
-- Name: lo3_pl_serialized_idx_1; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_pl_serialized_idx_1 ON public.lo3_pl_serialized USING btree (mutatie_dt);


--
-- Name: lo3_pl_verblijfplaats_idx_1; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_pl_verblijfplaats_idx_1 ON public.lo3_pl_verblijfplaats USING btree (inschrijving_gemeente_code, volg_nr, geldigheid_start_datum);


--
-- Name: lo3_pl_verblijfplaats_idx_2; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE INDEX lo3_pl_verblijfplaats_idx_2 ON public.lo3_pl_verblijfplaats USING btree (adres_id, volg_nr, geldigheid_start_datum);


--
-- Name: lookup_codewaarde_idx_1; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE UNIQUE INDEX lookup_codewaarde_idx_1 ON public.lookup_codewaarde USING btree (lookup_codering_id, referentie_waarde_num);


--
-- Name: lookup_codewaarde_idx_2; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE UNIQUE INDEX lookup_codewaarde_idx_2 ON public.lookup_codewaarde USING btree (lookup_codering_id, referentie_waarde_alfa);


--
-- Name: spg_mailbox_nr; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE UNIQUE INDEX spg_mailbox_nr ON public.spg_mailbox USING btree (spg_mailbox_nummer);


--
-- Name: toestand_overgang_idx_1; Type: INDEX; Schema: public; Owner: haalcentraal
--

CREATE UNIQUE INDEX toestand_overgang_idx_1 ON public.toestand_overgang USING btree (activiteit_type, activiteit_subtype, toestand_huidig, gebeurtenis_type, toestand_nieuw);


--
-- Name: pl_bericht_idx_1; Type: INDEX; Schema: vospg; Owner: haalcentraal
--

CREATE INDEX pl_bericht_idx_1 ON vospg.pl_bericht USING btree (verzender, a_nr);


--
-- Name: pl_bericht_idx_2; Type: INDEX; Schema: vospg; Owner: haalcentraal
--

CREATE INDEX pl_bericht_idx_2 ON vospg.pl_bericht USING btree (tijdstip_ontvangst);


--
-- Name: lo3_bericht_view_insert_update view_lo3_bericht_ins; Type: RULE; Schema: public; Owner: haalcentraal
--

CREATE RULE view_lo3_bericht_ins AS
    ON INSERT TO public.lo3_bericht_view_insert_update DO INSTEAD  INSERT INTO public.lo3_bericht (lo3_bericht_id, aanduiding_in_uit, bericht_activiteit_id, medium, originator_or_recipient, spg_mailbox_instantie, eref, bref, eref2, tijdstip_verzending_ontvangst, dispatch_sequence_number, report_delivery_time, non_delivery_reason, non_receipt_reason, bericht_data, kop_random_key, kop_berichtsoort_nummer, kop_a_nummer, kop_oud_a_nummer, kop_herhaling, kop_foutreden, kop_datum_tijd)
  VALUES (new.lo3_bericht_id, new.aanduiding_in_uit, new.bericht_activiteit_id, new.medium, new.originator_or_recipient, new.spg_mailbox_instantie, new.eref, new.bref, new.eref2, new.tijdstip_verzending_ontvangst, new.dispatch_sequence_number, new.report_delivery_time, new.non_delivery_reason, new.non_receipt_reason, new.bericht_data, new.kop_random_key, new.kop_berichtsoort_nummer, new.kop_a_nummer, new.kop_oud_a_nummer, new.kop_herhaling, new.kop_foutreden, new.kop_datum_tijd);


--
-- Name: lo3_bericht_view_insert_update view_lo3_bericht_upd; Type: RULE; Schema: public; Owner: haalcentraal
--

CREATE RULE view_lo3_bericht_upd AS
    ON UPDATE TO public.lo3_bericht_view_insert_update DO INSTEAD  UPDATE public.lo3_bericht SET aanduiding_in_uit = new.aanduiding_in_uit, bericht_activiteit_id = new.bericht_activiteit_id, medium = new.medium, originator_or_recipient = new.originator_or_recipient, spg_mailbox_instantie = new.spg_mailbox_instantie, eref = new.eref, bref = new.bref, eref2 = new.eref2, tijdstip_verzending_ontvangst = new.tijdstip_verzending_ontvangst, dispatch_sequence_number = new.dispatch_sequence_number, report_delivery_time = new.report_delivery_time, non_delivery_reason = new.non_delivery_reason, non_receipt_reason = new.non_receipt_reason, bericht_data = new.bericht_data, kop_random_key = new.kop_random_key, kop_berichtsoort_nummer = new.kop_berichtsoort_nummer, kop_a_nummer = new.kop_a_nummer, kop_oud_a_nummer = new.kop_oud_a_nummer, kop_herhaling = new.kop_herhaling, kop_foutreden = new.kop_foutreden, kop_datum_tijd = new.kop_datum_tijd
  WHERE (lo3_bericht.lo3_bericht_id = old.lo3_bericht_id);


--
-- Name: lo3_pl_verblijfplaats lo3_pl_verblijfplaats_adres_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_pl_verblijfplaats
    ADD CONSTRAINT lo3_pl_verblijfplaats_adres_id_fkey FOREIGN KEY (adres_id) REFERENCES public.lo3_adres(adres_id);


--
-- Name: lo3_vospg_instructie lo3_vospg_instructie_spg_mailbox_instantie_fkey; Type: FK CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lo3_vospg_instructie
    ADD CONSTRAINT lo3_vospg_instructie_spg_mailbox_instantie_fkey FOREIGN KEY (spg_mailbox_instantie) REFERENCES public.spg_mailbox(spg_mailbox_instantie);


--
-- Name: lookup_codewaarde lookup_codewaarde_lookup_codering_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.lookup_codewaarde
    ADD CONSTRAINT lookup_codewaarde_lookup_codering_id_fkey FOREIGN KEY (lookup_codering_id) REFERENCES public.lookup_codering(lookup_codering_id);


--
-- Name: selectie_enumeratie selectie_enumeratie_selectie_instelling_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.selectie_enumeratie
    ADD CONSTRAINT selectie_enumeratie_selectie_instelling_id_fkey FOREIGN KEY (selectie_instelling_id) REFERENCES public.selectie_instelling(selectie_instelling_id);


--
-- Name: selectie_instelling selectie_instelling_autorisatie_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: haalcentraal
--

ALTER TABLE ONLY public.selectie_instelling
    ADD CONSTRAINT selectie_instelling_autorisatie_id_fkey FOREIGN KEY (autorisatie_id) REFERENCES public.lo3_autorisatie(autorisatie_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 10.1
-- Dumped by pg_dump version 10.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: core; Type: SCHEMA; Schema: -; Owner: svcm
--

CREATE SCHEMA core;


ALTER SCHEMA core OWNER TO svcm;

--
-- Name: SCHEMA core; Type: COMMENT; Schema: -; Owner: svcm
--

COMMENT ON SCHEMA core IS 'Основные бизнес-объекты системы';


--
-- Name: stream; Type: SCHEMA; Schema: -; Owner: svcm
--

CREATE SCHEMA stream;


ALTER SCHEMA stream OWNER TO svcm;

--
-- Name: SCHEMA stream; Type: COMMENT; Schema: -; Owner: svcm
--

COMMENT ON SCHEMA stream IS 'Организация распределенного обмена данными и интеграцией';


--
-- Name: sys; Type: SCHEMA; Schema: -; Owner: svcm
--

CREATE SCHEMA sys;


ALTER SCHEMA sys OWNER TO svcm;

--
-- Name: SCHEMA sys; Type: COMMENT; Schema: -; Owner: svcm
--

COMMENT ON SCHEMA sys IS 'Хранение данных о пользователях, ролях, функциях сервиса, правах доступа, а так же логи работы пользователя';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = core, pg_catalog;

--
-- Name: d_description; Type: DOMAIN; Schema: core; Owner: svcm
--

CREATE DOMAIN d_description AS text;


ALTER DOMAIN d_description OWNER TO svcm;

--
-- Name: DOMAIN d_description; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON DOMAIN d_description IS 'Тип поля - описаниe';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: cobject; Type: TABLE; Schema: core; Owner: svcm
--

CREATE TABLE cobject (
    id bigint NOT NULL,
    parent_id bigint,
    construction_id smallint,
    cobject_type_id smallint NOT NULL,
    code character varying(32),
    number character varying(32),
    descr character varying(8192)
);


ALTER TABLE cobject OWNER TO svcm;

--
-- Name: TABLE cobject; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON TABLE cobject IS 'Объекты проектирования';


--
-- Name: COLUMN cobject.id; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN cobject.id IS 'Индентификатр';


--
-- Name: COLUMN cobject.parent_id; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN cobject.parent_id IS '-> object';


--
-- Name: COLUMN cobject.construction_id; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN cobject.construction_id IS '-> construction';


--
-- Name: COLUMN cobject.cobject_type_id; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN cobject.cobject_type_id IS '-> object_type';


--
-- Name: COLUMN cobject.code; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN cobject.code IS 'Код объекта';


--
-- Name: COLUMN cobject.number; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN cobject.number IS 'Номер объекта';


--
-- Name: COLUMN cobject.descr; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN cobject.descr IS 'Описание/наименование';


--
-- Name: cobject_id_seq; Type: SEQUENCE; Schema: core; Owner: svcm
--

CREATE SEQUENCE cobject_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cobject_id_seq OWNER TO svcm;

--
-- Name: cobject_id_seq; Type: SEQUENCE OWNED BY; Schema: core; Owner: svcm
--

ALTER SEQUENCE cobject_id_seq OWNED BY cobject.id;


--
-- Name: cobject_type; Type: TABLE; Schema: core; Owner: svcm
--

CREATE TABLE cobject_type (
    id smallint NOT NULL,
    code character varying(1),
    name character varying(16),
    descr character varying(32)
);


ALTER TABLE cobject_type OWNER TO svcm;

--
-- Name: TABLE cobject_type; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON TABLE cobject_type IS 'Типы объектов проектирования';


--
-- Name: COLUMN cobject_type.id; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN cobject_type.id IS 'Идентификатор';


--
-- Name: COLUMN cobject_type.code; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN cobject_type.code IS 'Код';


--
-- Name: COLUMN cobject_type.name; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN cobject_type.name IS 'Наименование';


--
-- Name: COLUMN cobject_type.descr; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN cobject_type.descr IS 'Описание';


--
-- Name: cobject_type_id_seq; Type: SEQUENCE; Schema: core; Owner: svcm
--

CREATE SEQUENCE cobject_type_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cobject_type_id_seq OWNER TO svcm;

--
-- Name: cobject_type_id_seq; Type: SEQUENCE OWNED BY; Schema: core; Owner: svcm
--

ALTER SEQUENCE cobject_type_id_seq OWNED BY cobject_type.id;


--
-- Name: construction; Type: TABLE; Schema: core; Owner: svcm
--

CREATE TABLE construction (
    id smallint NOT NULL,
    code character varying(16) NOT NULL,
    name character varying(8192)
);


ALTER TABLE construction OWNER TO svcm;

--
-- Name: TABLE construction; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON TABLE construction IS 'Комплексы';


--
-- Name: COLUMN construction.id; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN construction.id IS 'Идентификатор';


--
-- Name: COLUMN construction.code; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN construction.code IS 'Код комплекса';


--
-- Name: COLUMN construction.name; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN construction.name IS 'Наименование';


--
-- Name: construction_id_seq; Type: SEQUENCE; Schema: core; Owner: svcm
--

CREATE SEQUENCE construction_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE construction_id_seq OWNER TO svcm;

--
-- Name: construction_id_seq; Type: SEQUENCE OWNED BY; Schema: core; Owner: svcm
--

ALTER SEQUENCE construction_id_seq OWNED BY construction.id;


--
-- Name: contract; Type: TABLE; Schema: core; Owner: svcm
--

CREATE TABLE contract (
    id integer NOT NULL,
    construction_id smallint NOT NULL,
    oipks character varying(16),
    contractor_id integer NOT NULL,
    phase_id smallint,
    developer_id integer,
    inner_num character varying(128),
    title character varying(8192) NOT NULL,
    contract_num character varying(16) NOT NULL,
    contract_year smallint,
    contract_date date,
    contract_status character varying(32),
    ius_code character varying(32),
    techdirector character varying(32),
    gips character varying(128),
    date_sign date,
    work_start date,
    work_finish date,
    order_start date,
    order_finish date,
    work_types character varying(32)
);


ALTER TABLE contract OWNER TO svcm;

--
-- Name: TABLE contract; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON TABLE contract IS 'Договор';


--
-- Name: COLUMN contract.id; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN contract.id IS 'Идентификатор';


--
-- Name: COLUMN contract.construction_id; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN contract.construction_id IS '-> construction';


--
-- Name: COLUMN contract.oipks; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN contract.oipks IS 'Код ОИП КС';


--
-- Name: COLUMN contract.contractor_id; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN contract.contractor_id IS '-> ref_contractor';


--
-- Name: COLUMN contract.phase_id; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN contract.phase_id IS '-> ref_phase';


--
-- Name: COLUMN contract.developer_id; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN contract.developer_id IS '-> ref_developer';


--
-- Name: COLUMN contract.inner_num; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN contract.inner_num IS 'Внутренний номер договора';


--
-- Name: COLUMN contract.title; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN contract.title IS 'Предмет договора';


--
-- Name: COLUMN contract.contract_num; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN contract.contract_num IS 'Номер договора';


--
-- Name: COLUMN contract.contract_year; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN contract.contract_year IS 'Год договора';


--
-- Name: COLUMN contract.contract_date; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN contract.contract_date IS 'Дата договора';


--
-- Name: COLUMN contract.contract_status; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN contract.contract_status IS 'Статус договора (АПБП): не определен, перспективный, проект, подписан, приостановлен, расторгнут, выполнен';


--
-- Name: COLUMN contract.ius_code; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN contract.ius_code IS 'Код ИУС (АПБП)';


--
-- Name: COLUMN contract.techdirector; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN contract.techdirector IS 'Технический директор (АПБП)';


--
-- Name: COLUMN contract.gips; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN contract.gips IS 'ГИПы по договору (АПБП)';


--
-- Name: COLUMN contract.date_sign; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN contract.date_sign IS 'Дата заключения договора (АПБП)';


--
-- Name: COLUMN contract.work_start; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN contract.work_start IS 'Начало работ по договору (АПБП)';


--
-- Name: COLUMN contract.work_finish; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN contract.work_finish IS 'Окончание работ по договору (АПБП)';


--
-- Name: COLUMN contract.order_start; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN contract.order_start IS 'Начало работ по приказу (АПБП)';


--
-- Name: COLUMN contract.order_finish; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN contract.order_finish IS 'Окончание работ по приказу (АПБП)';


--
-- Name: COLUMN contract.work_types; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN contract.work_types IS 'Виды работ (АПБП)';


--
-- Name: contract_id_seq; Type: SEQUENCE; Schema: core; Owner: svcm
--

CREATE SEQUENCE contract_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE contract_id_seq OWNER TO svcm;

--
-- Name: contract_id_seq; Type: SEQUENCE OWNED BY; Schema: core; Owner: svcm
--

ALTER SEQUENCE contract_id_seq OWNED BY contract.id;


--
-- Name: docset; Type: TABLE; Schema: core; Owner: svcm
--

CREATE TABLE docset (
    id bigint NOT NULL,
    cobject_id bigint,
    settype character varying(10),
    cipher character varying(50) NOT NULL,
    mark_ref_id integer,
    name character varying(2048) NOT NULL,
    datestart date,
    datefinish date,
    invoice_num character varying(100),
    invoice_date date,
    ds_type_id smallint
);


ALTER TABLE docset OWNER TO svcm;

--
-- Name: TABLE docset; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON TABLE docset IS 'Комплекты';


--
-- Name: COLUMN docset.id; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN docset.id IS 'Идентификатор';


--
-- Name: COLUMN docset.cobject_id; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN docset.cobject_id IS '-> cobject';


--
-- Name: COLUMN docset.settype; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN docset.settype IS 'Тип комплекта (ОТ, ВТ)';


--
-- Name: COLUMN docset.cipher; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN docset.cipher IS 'Обозначение комплекта';


--
-- Name: COLUMN docset.mark_ref_id; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN docset.mark_ref_id IS '-> mark_ref';


--
-- Name: COLUMN docset.name; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN docset.name IS 'Наименование';


--
-- Name: COLUMN docset.datestart; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN docset.datestart IS 'Дата начала';


--
-- Name: COLUMN docset.datefinish; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN docset.datefinish IS 'Дата окончания';


--
-- Name: COLUMN docset.invoice_num; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN docset.invoice_num IS '№ накладной';


--
-- Name: COLUMN docset.invoice_date; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN docset.invoice_date IS 'Дата накладной';


--
-- Name: COLUMN docset.ds_type_id; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN docset.ds_type_id IS '-> ds_type';


--
-- Name: docset_id_seq; Type: SEQUENCE; Schema: core; Owner: svcm
--

CREATE SEQUENCE docset_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE docset_id_seq OWNER TO svcm;

--
-- Name: docset_id_seq; Type: SEQUENCE OWNED BY; Schema: core; Owner: svcm
--

ALTER SEQUENCE docset_id_seq OWNED BY docset.id;


--
-- Name: docset_mon; Type: TABLE; Schema: core; Owner: svcm
--

CREATE TABLE docset_mon (
    id bigint NOT NULL,
    docset_id bigint NOT NULL,
    mondate date NOT NULL,
    monpercent smallint DEFAULT 0 NOT NULL,
    description character varying(1024),
    created timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT docset_mon_percent_chk CHECK (((monpercent >= 0) AND (monpercent <= 100)))
);


ALTER TABLE docset_mon OWNER TO svcm;

--
-- Name: TABLE docset_mon; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON TABLE docset_mon IS 'Мониторинг выпуска комплектов';


--
-- Name: COLUMN docset_mon.id; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN docset_mon.id IS 'Идентификатор';


--
-- Name: COLUMN docset_mon.docset_id; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN docset_mon.docset_id IS 'Ссылка на комплект документации';


--
-- Name: COLUMN docset_mon.mondate; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN docset_mon.mondate IS 'Дата мониторинга разработки комплекта';


--
-- Name: COLUMN docset_mon.monpercent; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN docset_mon.monpercent IS '% разработки комплекта';


--
-- Name: COLUMN docset_mon.description; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN docset_mon.description IS 'Комментарии/описание';


--
-- Name: COLUMN docset_mon.created; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN docset_mon.created IS 'Дата создания записи';


--
-- Name: docset_mon_id_seq; Type: SEQUENCE; Schema: core; Owner: svcm
--

CREATE SEQUENCE docset_mon_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE docset_mon_id_seq OWNER TO svcm;

--
-- Name: docset_mon_id_seq; Type: SEQUENCE OWNED BY; Schema: core; Owner: svcm
--

ALTER SEQUENCE docset_mon_id_seq OWNED BY docset_mon.id;


--
-- Name: ds_bsd; Type: TABLE; Schema: core; Owner: svcm
--

CREATE TABLE ds_bsd (
    id bigint NOT NULL,
    docset_id bigint NOT NULL,
    name text NOT NULL,
    cipher character varying(128) NOT NULL,
    dev_dep character varying(32),
    oipks_id smallint,
    contractor_id integer,
    contract_id integer,
    phase_id smallint,
    phase_num character varying(32),
    developer_id integer,
    constrpart_id integer,
    constrpart_num character varying(4),
    building_id integer,
    building_num character varying(3),
    mark_id integer,
    mark_path character varying(3),
    cipher_doc character varying(3),
    cstage character varying(32),
    izm_num smallint DEFAULT 0,
    gip character varying(128),
    status text,
    object_time timestamp with time zone
);


ALTER TABLE ds_bsd OWNER TO svcm;

--
-- Name: TABLE ds_bsd; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON TABLE ds_bsd IS 'Детализация составного документа - Комплект';


--
-- Name: COLUMN ds_bsd.id; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ds_bsd.id IS 'Идентификатор';


--
-- Name: COLUMN ds_bsd.docset_id; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ds_bsd.docset_id IS '-> docset';


--
-- Name: COLUMN ds_bsd.name; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ds_bsd.name IS 'Наименование';


--
-- Name: COLUMN ds_bsd.cipher; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ds_bsd.cipher IS 'Шифр документа (обозначение)';


--
-- Name: COLUMN ds_bsd.dev_dep; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ds_bsd.dev_dep IS 'Код подразделения-исполнителя';


--
-- Name: COLUMN ds_bsd.oipks_id; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ds_bsd.oipks_id IS '1 - код ОИП КС -> core.construction';


--
-- Name: COLUMN ds_bsd.contractor_id; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ds_bsd.contractor_id IS '2 - код заказчика -> core.ref_contractor';


--
-- Name: COLUMN ds_bsd.contract_id; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ds_bsd.contract_id IS '3 - договор -> core.contract';


--
-- Name: COLUMN ds_bsd.phase_id; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ds_bsd.phase_id IS '4 - стадия -> core.ref_phase';


--
-- Name: COLUMN ds_bsd.phase_num; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ds_bsd.phase_num IS '4 - уточнение: этапы/стадии договора может быть 1/1-3, т.е. этап 1 подэтапы 1-3';


--
-- Name: COLUMN ds_bsd.developer_id; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ds_bsd.developer_id IS '5 - субъект разработки -> core.ref_developer';


--
-- Name: COLUMN ds_bsd.constrpart_id; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ds_bsd.constrpart_id IS '6 - часть комплекса -> core.ref_constrpart';


--
-- Name: COLUMN ds_bsd.constrpart_num; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ds_bsd.constrpart_num IS '7 - номер части комплекса';


--
-- Name: COLUMN ds_bsd.building_id; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ds_bsd.building_id IS '8 - здание/сооружение/сеть -> core.ref_building';


--
-- Name: COLUMN ds_bsd.building_num; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ds_bsd.building_num IS '9 - позиция здания/сооружения/сети по генплану';


--
-- Name: COLUMN ds_bsd.mark_id; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ds_bsd.mark_id IS '10 - марка основного комплекта -> core.ref_mark';


--
-- Name: COLUMN ds_bsd.mark_path; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ds_bsd.mark_path IS '11 - номер части марки';


--
-- Name: COLUMN ds_bsd.cipher_doc; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ds_bsd.cipher_doc IS '12 - шифр документа';


--
-- Name: COLUMN ds_bsd.cstage; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ds_bsd.cstage IS 'Этап по генподрядному договру';


--
-- Name: COLUMN ds_bsd.izm_num; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ds_bsd.izm_num IS '№ изменения';


--
-- Name: COLUMN ds_bsd.gip; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ds_bsd.gip IS 'ГИП';


--
-- Name: COLUMN ds_bsd.status; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ds_bsd.status IS 'Статус';


--
-- Name: COLUMN ds_bsd.object_time; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ds_bsd.object_time IS 'Время изменения оригинала';


--
-- Name: ds_bsd_id_seq; Type: SEQUENCE; Schema: core; Owner: svcm
--

CREATE SEQUENCE ds_bsd_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ds_bsd_id_seq OWNER TO svcm;

--
-- Name: ds_bsd_id_seq; Type: SEQUENCE OWNED BY; Schema: core; Owner: svcm
--

ALTER SEQUENCE ds_bsd_id_seq OWNED BY ds_bsd.id;


--
-- Name: ds_type; Type: TABLE; Schema: core; Owner: svcm
--

CREATE TABLE ds_type (
    id smallint NOT NULL,
    name character varying(25) NOT NULL,
    descr text
);


ALTER TABLE ds_type OWNER TO svcm;

--
-- Name: TABLE ds_type; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON TABLE ds_type IS 'Типы единиц проектной продукции';


--
-- Name: COLUMN ds_type.id; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ds_type.id IS 'Идентификатор';


--
-- Name: COLUMN ds_type.name; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ds_type.name IS 'Наименование';


--
-- Name: COLUMN ds_type.descr; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ds_type.descr IS 'Описание';


--
-- Name: ds_type_id_seq; Type: SEQUENCE; Schema: core; Owner: svcm
--

CREATE SEQUENCE ds_type_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ds_type_id_seq OWNER TO svcm;

--
-- Name: ds_type_id_seq; Type: SEQUENCE OWNED BY; Schema: core; Owner: svcm
--

ALTER SEQUENCE ds_type_id_seq OWNED BY ds_type.id;


--
-- Name: ref_building; Type: TABLE; Schema: core; Owner: svcm
--

CREATE TABLE ref_building (
    id integer NOT NULL,
    group_id integer,
    code character varying(8) NOT NULL,
    name character varying(512) NOT NULL
);


ALTER TABLE ref_building OWNER TO svcm;

--
-- Name: TABLE ref_building; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON TABLE ref_building IS 'Классификатор зданий, сооружений, систем и установок';


--
-- Name: COLUMN ref_building.id; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ref_building.id IS 'Индентификатр';


--
-- Name: COLUMN ref_building.group_id; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ref_building.group_id IS '-> building_group';


--
-- Name: COLUMN ref_building.code; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ref_building.code IS 'Код';


--
-- Name: COLUMN ref_building.name; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ref_building.name IS 'Наименование';


--
-- Name: ref_building_group; Type: TABLE; Schema: core; Owner: svcm
--

CREATE TABLE ref_building_group (
    id integer NOT NULL,
    parent_id integer,
    code_range character varying(32),
    name character varying(512) NOT NULL
);


ALTER TABLE ref_building_group OWNER TO svcm;

--
-- Name: TABLE ref_building_group; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON TABLE ref_building_group IS 'Классификатор групп зданий, сооружений, систем и установок';


--
-- Name: COLUMN ref_building_group.id; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ref_building_group.id IS 'Идентификатор';


--
-- Name: COLUMN ref_building_group.parent_id; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ref_building_group.parent_id IS 'Ccылка на группу-родитель';


--
-- Name: COLUMN ref_building_group.code_range; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ref_building_group.code_range IS 'Диапазон кодов';


--
-- Name: COLUMN ref_building_group.name; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ref_building_group.name IS 'Наименование';


--
-- Name: ref_building_group_id_seq; Type: SEQUENCE; Schema: core; Owner: svcm
--

CREATE SEQUENCE ref_building_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ref_building_group_id_seq OWNER TO svcm;

--
-- Name: ref_building_group_id_seq; Type: SEQUENCE OWNED BY; Schema: core; Owner: svcm
--

ALTER SEQUENCE ref_building_group_id_seq OWNED BY ref_building_group.id;


--
-- Name: ref_building_id_seq; Type: SEQUENCE; Schema: core; Owner: svcm
--

CREATE SEQUENCE ref_building_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ref_building_id_seq OWNER TO svcm;

--
-- Name: ref_building_id_seq; Type: SEQUENCE OWNED BY; Schema: core; Owner: svcm
--

ALTER SEQUENCE ref_building_id_seq OWNED BY ref_building.id;


--
-- Name: ref_chaptercode; Type: TABLE; Schema: core; Owner: svcm
--

CREATE TABLE ref_chaptercode (
    id integer NOT NULL,
    chaptercodetype_id smallint,
    chapter smallint,
    subchapter smallint,
    code character varying(16) NOT NULL,
    name character varying(2048)
);


ALTER TABLE ref_chaptercode OWNER TO svcm;

--
-- Name: TABLE ref_chaptercode; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON TABLE ref_chaptercode IS 'Разделы проектной документации';


--
-- Name: COLUMN ref_chaptercode.chaptercodetype_id; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ref_chaptercode.chaptercodetype_id IS '-> chaptercode_type';


--
-- Name: COLUMN ref_chaptercode.chapter; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ref_chaptercode.chapter IS 'Номер раздела';


--
-- Name: COLUMN ref_chaptercode.subchapter; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ref_chaptercode.subchapter IS 'Номер подраздела';


--
-- Name: COLUMN ref_chaptercode.code; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ref_chaptercode.code IS 'Шифр';


--
-- Name: COLUMN ref_chaptercode.name; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ref_chaptercode.name IS 'Наименование';


--
-- Name: ref_chaptercode_id_seq; Type: SEQUENCE; Schema: core; Owner: svcm
--

CREATE SEQUENCE ref_chaptercode_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ref_chaptercode_id_seq OWNER TO svcm;

--
-- Name: ref_chaptercode_id_seq; Type: SEQUENCE OWNED BY; Schema: core; Owner: svcm
--

ALTER SEQUENCE ref_chaptercode_id_seq OWNED BY ref_chaptercode.id;


--
-- Name: ref_chaptercode_type; Type: TABLE; Schema: core; Owner: svcm
--

CREATE TABLE ref_chaptercode_type (
    id smallint NOT NULL,
    short_name character varying(8) NOT NULL,
    name character varying(256) NOT NULL
);


ALTER TABLE ref_chaptercode_type OWNER TO svcm;

--
-- Name: TABLE ref_chaptercode_type; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON TABLE ref_chaptercode_type IS 'Виды разделов ПД';


--
-- Name: COLUMN ref_chaptercode_type.id; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ref_chaptercode_type.id IS 'Индентификатр';


--
-- Name: COLUMN ref_chaptercode_type.short_name; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ref_chaptercode_type.short_name IS 'Обозначение';


--
-- Name: COLUMN ref_chaptercode_type.name; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ref_chaptercode_type.name IS 'Наименование';


--
-- Name: ref_chaptercode_type_id_seq; Type: SEQUENCE; Schema: core; Owner: svcm
--

CREATE SEQUENCE ref_chaptercode_type_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ref_chaptercode_type_id_seq OWNER TO svcm;

--
-- Name: ref_chaptercode_type_id_seq; Type: SEQUENCE OWNED BY; Schema: core; Owner: svcm
--

ALTER SEQUENCE ref_chaptercode_type_id_seq OWNED BY ref_chaptercode_type.id;


--
-- Name: ref_constrpart; Type: TABLE; Schema: core; Owner: svcm
--

CREATE TABLE ref_constrpart (
    id integer NOT NULL,
    group_id integer,
    code character varying(8) NOT NULL,
    name character varying(512) NOT NULL
);


ALTER TABLE ref_constrpart OWNER TO svcm;

--
-- Name: TABLE ref_constrpart; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON TABLE ref_constrpart IS 'Классификатор частей комплексов строек';


--
-- Name: COLUMN ref_constrpart.id; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ref_constrpart.id IS 'Индентификатр';


--
-- Name: COLUMN ref_constrpart.group_id; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ref_constrpart.group_id IS '-> constrpart_group';


--
-- Name: COLUMN ref_constrpart.code; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ref_constrpart.code IS 'Код';


--
-- Name: COLUMN ref_constrpart.name; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ref_constrpart.name IS 'Наименование';


--
-- Name: ref_constrpart_group; Type: TABLE; Schema: core; Owner: svcm
--

CREATE TABLE ref_constrpart_group (
    id integer NOT NULL,
    code_range character varying(32),
    name character varying(512) NOT NULL
);


ALTER TABLE ref_constrpart_group OWNER TO svcm;

--
-- Name: TABLE ref_constrpart_group; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON TABLE ref_constrpart_group IS 'Классификатор групп частей комплексов строек';


--
-- Name: COLUMN ref_constrpart_group.id; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ref_constrpart_group.id IS 'Идентификатор';


--
-- Name: COLUMN ref_constrpart_group.code_range; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ref_constrpart_group.code_range IS 'Диапазон кодов';


--
-- Name: COLUMN ref_constrpart_group.name; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ref_constrpart_group.name IS 'Наименование';


--
-- Name: ref_constrpart_group_id_seq; Type: SEQUENCE; Schema: core; Owner: svcm
--

CREATE SEQUENCE ref_constrpart_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ref_constrpart_group_id_seq OWNER TO svcm;

--
-- Name: ref_constrpart_group_id_seq; Type: SEQUENCE OWNED BY; Schema: core; Owner: svcm
--

ALTER SEQUENCE ref_constrpart_group_id_seq OWNED BY ref_constrpart_group.id;


--
-- Name: ref_constrpart_id_seq; Type: SEQUENCE; Schema: core; Owner: svcm
--

CREATE SEQUENCE ref_constrpart_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ref_constrpart_id_seq OWNER TO svcm;

--
-- Name: ref_constrpart_id_seq; Type: SEQUENCE OWNED BY; Schema: core; Owner: svcm
--

ALTER SEQUENCE ref_constrpart_id_seq OWNED BY ref_constrpart.id;


--
-- Name: ref_contractor; Type: TABLE; Schema: core; Owner: svcm
--

CREATE TABLE ref_contractor (
    id integer NOT NULL,
    name character varying(256) NOT NULL,
    customer_code character varying(16)
);


ALTER TABLE ref_contractor OWNER TO svcm;

--
-- Name: TABLE ref_contractor; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON TABLE ref_contractor IS 'Контрагенты';


--
-- Name: COLUMN ref_contractor.id; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ref_contractor.id IS 'Идентификатор';


--
-- Name: COLUMN ref_contractor.name; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ref_contractor.name IS 'Наименование';


--
-- Name: COLUMN ref_contractor.customer_code; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ref_contractor.customer_code IS 'Код заказчика';


--
-- Name: ref_contractor_id_seq; Type: SEQUENCE; Schema: core; Owner: svcm
--

CREATE SEQUENCE ref_contractor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ref_contractor_id_seq OWNER TO svcm;

--
-- Name: ref_contractor_id_seq; Type: SEQUENCE OWNED BY; Schema: core; Owner: svcm
--

ALTER SEQUENCE ref_contractor_id_seq OWNED BY ref_contractor.id;


--
-- Name: ref_developer; Type: TABLE; Schema: core; Owner: svcm
--

CREATE TABLE ref_developer (
    id integer NOT NULL,
    code character varying(16) NOT NULL,
    name character varying(256)
);


ALTER TABLE ref_developer OWNER TO svcm;

--
-- Name: TABLE ref_developer; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON TABLE ref_developer IS 'Субъекты разработки';


--
-- Name: COLUMN ref_developer.id; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ref_developer.id IS 'Идентификатор';


--
-- Name: COLUMN ref_developer.code; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ref_developer.code IS 'Код';


--
-- Name: COLUMN ref_developer.name; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ref_developer.name IS 'Наименование';


--
-- Name: ref_developer_id_seq; Type: SEQUENCE; Schema: core; Owner: svcm
--

CREATE SEQUENCE ref_developer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ref_developer_id_seq OWNER TO svcm;

--
-- Name: ref_developer_id_seq; Type: SEQUENCE OWNED BY; Schema: core; Owner: svcm
--

ALTER SEQUENCE ref_developer_id_seq OWNED BY ref_developer.id;


--
-- Name: ref_doccode; Type: TABLE; Schema: core; Owner: svcm
--

CREATE TABLE ref_doccode (
    id integer NOT NULL,
    code character varying(16) NOT NULL,
    name character varying(256),
    additional boolean DEFAULT false NOT NULL,
    numeric_part boolean DEFAULT false NOT NULL
);


ALTER TABLE ref_doccode OWNER TO svcm;

--
-- Name: TABLE ref_doccode; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON TABLE ref_doccode IS 'Классификатор шифров прилагаемых документов';


--
-- Name: COLUMN ref_doccode.id; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ref_doccode.id IS 'Идентификатор';


--
-- Name: COLUMN ref_doccode.code; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ref_doccode.code IS 'Шифр';


--
-- Name: COLUMN ref_doccode.name; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ref_doccode.name IS 'Наименование';


--
-- Name: COLUMN ref_doccode.additional; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ref_doccode.additional IS 'Являтся дополнительным';


--
-- Name: COLUMN ref_doccode.numeric_part; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ref_doccode.numeric_part IS 'Может подразделяться на номерные группы';


--
-- Name: ref_doccode_id_seq; Type: SEQUENCE; Schema: core; Owner: svcm
--

CREATE SEQUENCE ref_doccode_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ref_doccode_id_seq OWNER TO svcm;

--
-- Name: ref_doccode_id_seq; Type: SEQUENCE OWNED BY; Schema: core; Owner: svcm
--

ALTER SEQUENCE ref_doccode_id_seq OWNED BY ref_doccode.id;


--
-- Name: ref_mark; Type: TABLE; Schema: core; Owner: svcm
--

CREATE TABLE ref_mark (
    id integer NOT NULL,
    code character varying(16) NOT NULL,
    name character varying(2048),
    comment character varying(2048),
    additional boolean DEFAULT false NOT NULL
);


ALTER TABLE ref_mark OWNER TO svcm;

--
-- Name: TABLE ref_mark; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON TABLE ref_mark IS 'Классификатор марок основных комплектов рабочих чертежей';


--
-- Name: COLUMN ref_mark.id; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ref_mark.id IS 'Идентификатор';


--
-- Name: COLUMN ref_mark.code; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ref_mark.code IS 'Шифр';


--
-- Name: COLUMN ref_mark.name; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ref_mark.name IS 'Наименование';


--
-- Name: COLUMN ref_mark.comment; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ref_mark.comment IS 'Примечание';


--
-- Name: COLUMN ref_mark.additional; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ref_mark.additional IS 'Являтся дополнительным';


--
-- Name: ref_mark_id_seq; Type: SEQUENCE; Schema: core; Owner: svcm
--

CREATE SEQUENCE ref_mark_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ref_mark_id_seq OWNER TO svcm;

--
-- Name: ref_mark_id_seq; Type: SEQUENCE OWNED BY; Schema: core; Owner: svcm
--

ALTER SEQUENCE ref_mark_id_seq OWNED BY ref_mark.id;


--
-- Name: ref_phase; Type: TABLE; Schema: core; Owner: svcm
--

CREATE TABLE ref_phase (
    id smallint NOT NULL,
    code character varying(16) NOT NULL,
    name character varying(128)
);


ALTER TABLE ref_phase OWNER TO svcm;

--
-- Name: TABLE ref_phase; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON TABLE ref_phase IS 'Стадии проектирования';


--
-- Name: COLUMN ref_phase.id; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ref_phase.id IS 'Идентификатор';


--
-- Name: COLUMN ref_phase.code; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ref_phase.code IS 'Буквенный код';


--
-- Name: COLUMN ref_phase.name; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN ref_phase.name IS 'Наименование';


--
-- Name: ref_phase_id_seq; Type: SEQUENCE; Schema: core; Owner: svcm
--

CREATE SEQUENCE ref_phase_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ref_phase_id_seq OWNER TO svcm;

--
-- Name: ref_phase_id_seq; Type: SEQUENCE OWNED BY; Schema: core; Owner: svcm
--

ALTER SEQUENCE ref_phase_id_seq OWNED BY ref_phase.id;


--
-- Name: summary_construction; Type: MATERIALIZED VIEW; Schema: core; Owner: svcm
--

CREATE MATERIALIZED VIEW summary_construction AS
 SELECT c.id,
    co1.id AS cobject_id,
    c.code,
    c.name,
    count(ds.id) AS cnt_id,
    count(ds.datestart) AS cnt_datestart,
    count(ds.datefinish) AS cnt_datefinish,
    count(ds.invoice_num) AS cnt_invoicenum
   FROM ((((construction c
     JOIN cobject co1 ON ((co1.construction_id = c.id)))
     JOIN cobject_type cot ON (((cot.id = co1.cobject_type_id) AND ((cot.name)::text = 'CONSTR'::text))))
     JOIN cobject co2 ON ((co2.construction_id = c.id)))
     LEFT JOIN docset ds ON ((ds.cobject_id = co2.id)))
  GROUP BY c.id, co1.id, c.code, c.name
  ORDER BY c.code, c.name
  WITH NO DATA;


ALTER TABLE summary_construction OWNER TO svcm;

--
-- Name: MATERIALIZED VIEW summary_construction; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON MATERIALIZED VIEW summary_construction IS 'Обобщенные данные по комплектам(DocSet) для Constructions';


--
-- Name: COLUMN summary_construction.id; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN summary_construction.id IS 'Идентификатор (construction_id)';


--
-- Name: COLUMN summary_construction.cobject_id; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN summary_construction.cobject_id IS 'Идентификатор (CObject_id)';


--
-- Name: COLUMN summary_construction.code; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN summary_construction.code IS 'Код комплекса';


--
-- Name: COLUMN summary_construction.name; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN summary_construction.name IS 'Наименование комплекса';


--
-- Name: COLUMN summary_construction.cnt_id; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN summary_construction.cnt_id IS 'Кол-во комплектов комплекса';


--
-- Name: COLUMN summary_construction.cnt_datestart; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN summary_construction.cnt_datestart IS 'Кол-во комплектов, у которых есть дата начала';


--
-- Name: COLUMN summary_construction.cnt_datefinish; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN summary_construction.cnt_datefinish IS 'Кол-во комплектов, у которых есть дата окончания';


--
-- Name: COLUMN summary_construction.cnt_invoicenum; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN summary_construction.cnt_invoicenum IS 'Кол-во комплектов, у которых есть № накладной';


--
-- Name: waybill; Type: TABLE; Schema: core; Owner: svcm
--

CREATE TABLE waybill (
    id bigint NOT NULL,
    waybill_num character varying(100) NOT NULL,
    waybill_date date NOT NULL,
    descr d_description
);


ALTER TABLE waybill OWNER TO svcm;

--
-- Name: TABLE waybill; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON TABLE waybill IS 'Список транспортных накладных';


--
-- Name: COLUMN waybill.id; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN waybill.id IS 'Идентификатор';


--
-- Name: COLUMN waybill.waybill_num; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN waybill.waybill_num IS 'Номер накладной';


--
-- Name: COLUMN waybill.waybill_date; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN waybill.waybill_date IS 'Дата накладной';


--
-- Name: COLUMN waybill.descr; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN waybill.descr IS 'Описание';


--
-- Name: waybill_id_seq; Type: SEQUENCE; Schema: core; Owner: svcm
--

CREATE SEQUENCE waybill_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE waybill_id_seq OWNER TO svcm;

--
-- Name: waybill_id_seq; Type: SEQUENCE OWNED BY; Schema: core; Owner: svcm
--

ALTER SEQUENCE waybill_id_seq OWNED BY waybill.id;


--
-- Name: waybill_link; Type: TABLE; Schema: core; Owner: svcm
--

CREATE TABLE waybill_link (
    id bigint NOT NULL,
    docset_id bigint NOT NULL,
    waybill_id bigint NOT NULL
);


ALTER TABLE waybill_link OWNER TO svcm;

--
-- Name: TABLE waybill_link; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON TABLE waybill_link IS 'core.docset <---> core.waybill';


--
-- Name: COLUMN waybill_link.id; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN waybill_link.id IS 'Идентификатор';


--
-- Name: COLUMN waybill_link.docset_id; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN waybill_link.docset_id IS '-> core.docset';


--
-- Name: COLUMN waybill_link.waybill_id; Type: COMMENT; Schema: core; Owner: svcm
--

COMMENT ON COLUMN waybill_link.waybill_id IS '-> core.waybill';


--
-- Name: waybill_link_id_seq; Type: SEQUENCE; Schema: core; Owner: svcm
--

CREATE SEQUENCE waybill_link_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE waybill_link_id_seq OWNER TO svcm;

--
-- Name: waybill_link_id_seq; Type: SEQUENCE OWNED BY; Schema: core; Owner: svcm
--

ALTER SEQUENCE waybill_link_id_seq OWNED BY waybill_link.id;


SET search_path = public, pg_catalog;

--
-- Name: cost_assign; Type: TABLE; Schema: public; Owner: svcm
--

CREATE TABLE cost_assign (
    id smallint NOT NULL,
    name character varying(64) NOT NULL
);


ALTER TABLE cost_assign OWNER TO svcm;

--
-- Name: TABLE cost_assign; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON TABLE cost_assign IS 'Типы отнесения затрат';


--
-- Name: COLUMN cost_assign.name; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN cost_assign.name IS 'Наименование';


--
-- Name: cost_assign_id_seq; Type: SEQUENCE; Schema: public; Owner: svcm
--

CREATE SEQUENCE cost_assign_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cost_assign_id_seq OWNER TO svcm;

--
-- Name: cost_assign_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: svcm
--

ALTER SEQUENCE cost_assign_id_seq OWNED BY cost_assign.id;


--
-- Name: cost_group; Type: TABLE; Schema: public; Owner: svcm
--

CREATE TABLE cost_group (
    id smallint NOT NULL,
    parent_id smallint,
    name character varying(100) NOT NULL
);


ALTER TABLE cost_group OWNER TO svcm;

--
-- Name: TABLE cost_group; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON TABLE cost_group IS 'Статьи/группы видов затрат';


--
-- Name: COLUMN cost_group.id; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN cost_group.id IS 'Идентификатор';


--
-- Name: COLUMN cost_group.parent_id; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN cost_group.parent_id IS '-> cost_group';


--
-- Name: COLUMN cost_group.name; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN cost_group.name IS 'Наименование';


--
-- Name: cost_group_id_seq; Type: SEQUENCE; Schema: public; Owner: svcm
--

CREATE SEQUENCE cost_group_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cost_group_id_seq OWNER TO svcm;

--
-- Name: cost_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: svcm
--

ALTER SEQUENCE cost_group_id_seq OWNED BY cost_group.id;


--
-- Name: cost_kind; Type: TABLE; Schema: public; Owner: svcm
--

CREATE TABLE cost_kind (
    id smallint NOT NULL,
    code character varying(6) NOT NULL,
    code_old character varying(6),
    name character varying(2048) NOT NULL,
    cost_group_id smallint,
    cost_assign_id smallint,
    iusi_plan_form_id smallint
);


ALTER TABLE cost_kind OWNER TO svcm;

--
-- Name: TABLE cost_kind; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON TABLE cost_kind IS 'Классификатор видов затрат';


--
-- Name: COLUMN cost_kind.id; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN cost_kind.id IS 'Идентификтор';


--
-- Name: COLUMN cost_kind.code; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN cost_kind.code IS 'Код';


--
-- Name: COLUMN cost_kind.code_old; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN cost_kind.code_old IS 'Код до 2018.08';


--
-- Name: COLUMN cost_kind.name; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN cost_kind.name IS 'Наименование';


--
-- Name: COLUMN cost_kind.cost_group_id; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN cost_kind.cost_group_id IS '-> cost_group';


--
-- Name: COLUMN cost_kind.cost_assign_id; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN cost_kind.cost_assign_id IS '-> cost_assign';


--
-- Name: COLUMN cost_kind.iusi_plan_form_id; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN cost_kind.iusi_plan_form_id IS '-> iusi_plan_form';


--
-- Name: cost_kind_id_seq; Type: SEQUENCE; Schema: public; Owner: svcm
--

CREATE SEQUENCE cost_kind_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cost_kind_id_seq OWNER TO svcm;

--
-- Name: cost_kind_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: svcm
--

ALTER SEQUENCE cost_kind_id_seq OWNED BY cost_kind.id;


--
-- Name: estimate; Type: TABLE; Schema: public; Owner: svcm
--

CREATE TABLE estimate (
    id bigint NOT NULL,
    checksum bigint,
    machine_id character varying(32),
    developer_id integer,
    origin_key character varying(128),
    cobject_id bigint,
    contract_id integer,
    phase_id smallint,
    title character varying(2048),
    type_id smallint,
    parent_id bigint,
    chapter_num smallint,
    line_num smallint,
    subline1_num smallint,
    subline2_num smallint,
    subline3_num smallint,
    subline4_num smallint,
    subline5_num smallint,
    local_num smallint,
    phase_id_num smallint,
    changeset_num smallint,
    addenda_num smallint,
    source_num character varying(32),
    is_annulled boolean DEFAULT false NOT NULL,
    replaces_id bigint,
    volume_value numeric(15,2),
    volume_measure character varying(64),
    cost_code_id integer,
    construction_cost numeric(15,2),
    installation_cost numeric(15,2),
    equipment_cost numeric(15,2),
    material_cost numeric(15,2),
    other_cost numeric(15,2),
    total_cost numeric(15,2),
    comments text,
    price_at date,
    approval_date date,
    state_at date NOT NULL,
    basis character varying(2048),
    book_cipher character varying(256),
    load_date timestamp without time zone NOT NULL,
    tm_from timestamp without time zone,
    tm_to timestamp without time zone
);


ALTER TABLE estimate OWNER TO svcm;

--
-- Name: TABLE estimate; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON TABLE estimate IS 'Сметы';


--
-- Name: COLUMN estimate.id; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate.id IS 'Идентификатор';


--
-- Name: COLUMN estimate.checksum; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate.checksum IS 'Идентификатор источника (число)';


--
-- Name: COLUMN estimate.machine_id; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate.machine_id IS 'Машинный номер сметы';


--
-- Name: COLUMN estimate.developer_id; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate.developer_id IS 'Разработчик (филиал)';


--
-- Name: COLUMN estimate.origin_key; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate.origin_key IS 'Идентификатор сметы разработчика';


--
-- Name: COLUMN estimate.cobject_id; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate.cobject_id IS 'Объект проектирования (стройка)';


--
-- Name: COLUMN estimate.contract_id; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate.contract_id IS 'Проект (договор)';


--
-- Name: COLUMN estimate.phase_id; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate.phase_id IS 'Стадия проектирования';


--
-- Name: COLUMN estimate.title; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate.title IS 'Заголовок сметы (наименование работ и затрат...)';


--
-- Name: COLUMN estimate.type_id; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate.type_id IS 'Тип сметы: объектная, локальная...';


--
-- Name: COLUMN estimate.parent_id; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate.parent_id IS 'Cсылка на объектную смету';


--
-- Name: COLUMN estimate.chapter_num; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate.chapter_num IS 'Номер главы';


--
-- Name: COLUMN estimate.line_num; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate.line_num IS 'Номер объектной сметы';


--
-- Name: COLUMN estimate.subline1_num; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate.subline1_num IS 'Номер подобъектной сметы 1';


--
-- Name: COLUMN estimate.subline2_num; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate.subline2_num IS 'Номер подобъектной сметы 2';


--
-- Name: COLUMN estimate.subline3_num; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate.subline3_num IS 'Номер подобъектной сметы 3';


--
-- Name: COLUMN estimate.subline4_num; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate.subline4_num IS 'Номер подобъектной сметы 4';


--
-- Name: COLUMN estimate.subline5_num; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate.subline5_num IS 'Номер подобъектной сметы 5';


--
-- Name: COLUMN estimate.local_num; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate.local_num IS 'Номер локальной сметы';


--
-- Name: COLUMN estimate.phase_id_num; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate.phase_id_num IS 'Стадия проектирования в номере сметы';


--
-- Name: COLUMN estimate.changeset_num; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate.changeset_num IS 'Номер изменения';


--
-- Name: COLUMN estimate.addenda_num; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate.addenda_num IS 'Номер дополнения';


--
-- Name: COLUMN estimate.source_num; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate.source_num IS 'Номер сметы (из источника)';


--
-- Name: COLUMN estimate.is_annulled; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate.is_annulled IS 'Признак что смета аннулирована';


--
-- Name: COLUMN estimate.replaces_id; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate.replaces_id IS 'Ссылка на заменённую смету';


--
-- Name: COLUMN estimate.volume_value; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate.volume_value IS 'Объемный показатель - количество';


--
-- Name: COLUMN estimate.volume_measure; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate.volume_measure IS 'Объемный показатель - ед. изм.';


--
-- Name: COLUMN estimate.cost_code_id; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate.cost_code_id IS 'Код вида затрат (МРД)';


--
-- Name: COLUMN estimate.construction_cost; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate.construction_cost IS 'Стоимость строительных работ';


--
-- Name: COLUMN estimate.installation_cost; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate.installation_cost IS 'Стоимость монтажных работ';


--
-- Name: COLUMN estimate.equipment_cost; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate.equipment_cost IS 'Стоимость оборудования';


--
-- Name: COLUMN estimate.material_cost; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate.material_cost IS 'Стоимость материалов';


--
-- Name: COLUMN estimate.other_cost; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate.other_cost IS 'Стоимость прочих работ';


--
-- Name: COLUMN estimate.total_cost; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate.total_cost IS 'Стоимость итого';


--
-- Name: COLUMN estimate.comments; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate.comments IS 'Комментарий';


--
-- Name: COLUMN estimate.price_at; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate.price_at IS 'Уровень цен на дату';


--
-- Name: COLUMN estimate.approval_date; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate.approval_date IS 'Дата утверждения сметы';


--
-- Name: COLUMN estimate.state_at; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate.state_at IS 'По состоянию на';


--
-- Name: COLUMN estimate.basis; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate.basis IS 'Основание для разработки';


--
-- Name: COLUMN estimate.book_cipher; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate.book_cipher IS 'Шифр тома СД';


--
-- Name: COLUMN estimate.load_date; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate.load_date IS 'Дата загрузки в систему';


--
-- Name: COLUMN estimate.tm_from; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate.tm_from IS 'Дата начала действия';


--
-- Name: COLUMN estimate.tm_to; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate.tm_to IS 'Дата окончания действия';


--
-- Name: estimate_fission; Type: TABLE; Schema: public; Owner: svcm
--

CREATE TABLE estimate_fission (
    id bigint NOT NULL,
    estimate_id bigint,
    checksum bigint,
    title character varying(2048),
    cost_code_id integer,
    construction_cost numeric(15,2),
    installation_cost numeric(15,2),
    equipment_cost numeric(15,2),
    other_cost numeric(15,2),
    load_date timestamp with time zone NOT NULL
);


ALTER TABLE estimate_fission OWNER TO svcm;

--
-- Name: TABLE estimate_fission; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON TABLE estimate_fission IS 'Разделенные сметы';


--
-- Name: COLUMN estimate_fission.id; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate_fission.id IS 'Идентификатор';


--
-- Name: COLUMN estimate_fission.estimate_id; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate_fission.estimate_id IS '-> estimate';


--
-- Name: COLUMN estimate_fission.checksum; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate_fission.checksum IS 'Идентификатор источника';


--
-- Name: COLUMN estimate_fission.title; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate_fission.title IS 'Заголовок сметы';


--
-- Name: COLUMN estimate_fission.cost_code_id; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate_fission.cost_code_id IS 'Код вида затрат (МРД)';


--
-- Name: COLUMN estimate_fission.construction_cost; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate_fission.construction_cost IS 'Стоимость строительных работ';


--
-- Name: COLUMN estimate_fission.installation_cost; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate_fission.installation_cost IS 'Стоимость монтажных работ';


--
-- Name: COLUMN estimate_fission.equipment_cost; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate_fission.equipment_cost IS 'Стоимость оборудования';


--
-- Name: COLUMN estimate_fission.other_cost; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate_fission.other_cost IS 'Стоимость прочих работ';


--
-- Name: COLUMN estimate_fission.load_date; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate_fission.load_date IS 'Дата загрузки в систему';


--
-- Name: estimate_fission_id_seq; Type: SEQUENCE; Schema: public; Owner: svcm
--

CREATE SEQUENCE estimate_fission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE estimate_fission_id_seq OWNER TO svcm;

--
-- Name: estimate_fission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: svcm
--

ALTER SEQUENCE estimate_fission_id_seq OWNED BY estimate_fission.id;


--
-- Name: estimate_id_seq; Type: SEQUENCE; Schema: public; Owner: svcm
--

CREATE SEQUENCE estimate_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE estimate_id_seq OWNER TO svcm;

--
-- Name: estimate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: svcm
--

ALTER SEQUENCE estimate_id_seq OWNED BY estimate.id;


--
-- Name: estimate_link; Type: TABLE; Schema: public; Owner: svcm
--

CREATE TABLE estimate_link (
    id bigint NOT NULL,
    estimate_id bigint,
    link_type_id smallint NOT NULL,
    link_id bigint NOT NULL
);


ALTER TABLE estimate_link OWNER TO svcm;

--
-- Name: TABLE estimate_link; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON TABLE estimate_link IS 'Смета -> Комплект';


--
-- Name: COLUMN estimate_link.id; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate_link.id IS 'Идентификатор';


--
-- Name: COLUMN estimate_link.estimate_id; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate_link.estimate_id IS '-> estimate.id';


--
-- Name: COLUMN estimate_link.link_type_id; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate_link.link_type_id IS 'Тип связываемого документа';


--
-- Name: COLUMN estimate_link.link_id; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate_link.link_id IS 'Идентификатор связываемого документа';


--
-- Name: estimate_link_id_seq; Type: SEQUENCE; Schema: public; Owner: svcm
--

CREATE SEQUENCE estimate_link_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE estimate_link_id_seq OWNER TO svcm;

--
-- Name: estimate_link_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: svcm
--

ALTER SEQUENCE estimate_link_id_seq OWNED BY estimate_link.id;


--
-- Name: estimate_type; Type: TABLE; Schema: public; Owner: svcm
--

CREATE TABLE estimate_type (
    id smallint NOT NULL,
    short_name character varying(8) NOT NULL,
    name character varying(256) NOT NULL
);


ALTER TABLE estimate_type OWNER TO svcm;

--
-- Name: TABLE estimate_type; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON TABLE estimate_type IS 'Типы смет';


--
-- Name: COLUMN estimate_type.id; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate_type.id IS 'Идентификатор';


--
-- Name: COLUMN estimate_type.short_name; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate_type.short_name IS 'Сокращенное наименование';


--
-- Name: COLUMN estimate_type.name; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN estimate_type.name IS 'Наименование';


--
-- Name: estimate_type_id_seq; Type: SEQUENCE; Schema: public; Owner: svcm
--

CREATE SEQUENCE estimate_type_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE estimate_type_id_seq OWNER TO svcm;

--
-- Name: estimate_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: svcm
--

ALTER SEQUENCE estimate_type_id_seq OWNED BY estimate_type.id;


--
-- Name: iusi_plan_form; Type: TABLE; Schema: public; Owner: svcm
--

CREATE TABLE iusi_plan_form (
    id smallint NOT NULL,
    name character varying(64) NOT NULL,
    cost_code character varying(10)
);


ALTER TABLE iusi_plan_form OWNER TO svcm;

--
-- Name: TABLE iusi_plan_form; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON TABLE iusi_plan_form IS 'Форматы планирования ИУС И';


--
-- Name: COLUMN iusi_plan_form.id; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN iusi_plan_form.id IS 'Идентификатор';


--
-- Name: COLUMN iusi_plan_form.name; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN iusi_plan_form.name IS 'Наименование формата планирования';


--
-- Name: COLUMN iusi_plan_form.cost_code; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN iusi_plan_form.cost_code IS 'Код вида затрат ИУС И';


--
-- Name: iusi_plan_form_id_seq; Type: SEQUENCE; Schema: public; Owner: svcm
--

CREATE SEQUENCE iusi_plan_form_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE iusi_plan_form_id_seq OWNER TO svcm;

--
-- Name: iusi_plan_form_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: svcm
--

ALTER SEQUENCE iusi_plan_form_id_seq OWNED BY iusi_plan_form.id;


--
-- Name: mrd_object; Type: TABLE; Schema: public; Owner: svcm
--

CREATE TABLE mrd_object (
    id integer NOT NULL,
    parent_id integer,
    construction_id smallint NOT NULL,
    type_id integer,
    type character(1) NOT NULL,
    code character varying(32),
    number character varying(32),
    descr character varying(8192)
);


ALTER TABLE mrd_object OWNER TO svcm;

--
-- Name: mrd_object_id_seq; Type: SEQUENCE; Schema: public; Owner: svcm
--

CREATE SEQUENCE mrd_object_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE mrd_object_id_seq OWNER TO svcm;

--
-- Name: mrd_object_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: svcm
--

ALTER SEQUENCE mrd_object_id_seq OWNED BY mrd_object.id;


--
-- Name: mrd_object_link; Type: TABLE; Schema: public; Owner: svcm
--

CREATE TABLE mrd_object_link (
    id integer NOT NULL,
    cobject_id bigint NOT NULL,
    mrd_object_id integer NOT NULL
);


ALTER TABLE mrd_object_link OWNER TO svcm;

--
-- Name: mrd_object_link_id_seq; Type: SEQUENCE; Schema: public; Owner: svcm
--

CREATE SEQUENCE mrd_object_link_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE mrd_object_link_id_seq OWNER TO svcm;

--
-- Name: mrd_object_link_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: svcm
--

ALTER SEQUENCE mrd_object_link_id_seq OWNED BY mrd_object_link.id;


--
-- Name: mrd_objecttype; Type: TABLE; Schema: public; Owner: svcm
--

CREATE TABLE mrd_objecttype (
    id character(1) NOT NULL,
    codename character varying(16),
    name character varying(32)
);


ALTER TABLE mrd_objecttype OWNER TO svcm;

--
-- Name: TABLE mrd_objecttype; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON TABLE mrd_objecttype IS 'Типы объектов МРД';


--
-- Name: COLUMN mrd_objecttype.id; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN mrd_objecttype.id IS 'Идентификатор';


--
-- Name: COLUMN mrd_objecttype.codename; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN mrd_objecttype.codename IS 'Кодовое наименование';


--
-- Name: COLUMN mrd_objecttype.name; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN mrd_objecttype.name IS 'Наименование';


--
-- Name: mrd_oksgroup; Type: TABLE; Schema: public; Owner: svcm
--

CREATE TABLE mrd_oksgroup (
    id integer NOT NULL,
    code_range character varying(32),
    name character varying(512) NOT NULL
);


ALTER TABLE mrd_oksgroup OWNER TO svcm;

--
-- Name: COLUMN mrd_oksgroup.code_range; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN mrd_oksgroup.code_range IS 'диапазон кодов';


--
-- Name: COLUMN mrd_oksgroup.name; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN mrd_oksgroup.name IS 'наименование группы ОКС';


--
-- Name: mrd_oksgroup_id_seq; Type: SEQUENCE; Schema: public; Owner: svcm
--

CREATE SEQUENCE mrd_oksgroup_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE mrd_oksgroup_id_seq OWNER TO svcm;

--
-- Name: mrd_oksgroup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: svcm
--

ALTER SEQUENCE mrd_oksgroup_id_seq OWNED BY mrd_oksgroup.id;


--
-- Name: mrd_oksref; Type: TABLE; Schema: public; Owner: svcm
--

CREATE TABLE mrd_oksref (
    id integer NOT NULL,
    oksgroup_id integer,
    code character varying(8) NOT NULL,
    name character varying(512) NOT NULL
);


ALTER TABLE mrd_oksref OWNER TO svcm;

--
-- Name: COLUMN mrd_oksref.oksgroup_id; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN mrd_oksref.oksgroup_id IS 'ссылка на группу ОКС';


--
-- Name: COLUMN mrd_oksref.code; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN mrd_oksref.code IS 'код вида ОКС';


--
-- Name: COLUMN mrd_oksref.name; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN mrd_oksref.name IS 'наименования вида ОКС';


--
-- Name: mrd_oksref_id_seq; Type: SEQUENCE; Schema: public; Owner: svcm
--

CREATE SEQUENCE mrd_oksref_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE mrd_oksref_id_seq OWNER TO svcm;

--
-- Name: mrd_oksref_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: svcm
--

ALTER SEQUENCE mrd_oksref_id_seq OWNED BY mrd_oksref.id;


--
-- Name: mrd_ossrgroup; Type: TABLE; Schema: public; Owner: svcm
--

CREATE TABLE mrd_ossrgroup (
    id integer NOT NULL,
    code_range character varying(32),
    name character varying(512) NOT NULL
);


ALTER TABLE mrd_ossrgroup OWNER TO svcm;

--
-- Name: COLUMN mrd_ossrgroup.code_range; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN mrd_ossrgroup.code_range IS 'диапазон кодов';


--
-- Name: COLUMN mrd_ossrgroup.name; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN mrd_ossrgroup.name IS 'наименование группы ОКС';


--
-- Name: mrd_ossrgroup_id_seq; Type: SEQUENCE; Schema: public; Owner: svcm
--

CREATE SEQUENCE mrd_ossrgroup_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE mrd_ossrgroup_id_seq OWNER TO svcm;

--
-- Name: mrd_ossrgroup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: svcm
--

ALTER SEQUENCE mrd_ossrgroup_id_seq OWNED BY mrd_ossrgroup.id;


--
-- Name: mrd_ossrref; Type: TABLE; Schema: public; Owner: svcm
--

CREATE TABLE mrd_ossrref (
    id integer NOT NULL,
    ossrgroup_id integer,
    code character varying(8) NOT NULL,
    name character varying(512) NOT NULL
);


ALTER TABLE mrd_ossrref OWNER TO svcm;

--
-- Name: COLUMN mrd_ossrref.ossrgroup_id; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN mrd_ossrref.ossrgroup_id IS 'ccылка на группу ОССР';


--
-- Name: COLUMN mrd_ossrref.code; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN mrd_ossrref.code IS 'код вида ОССР';


--
-- Name: COLUMN mrd_ossrref.name; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN mrd_ossrref.name IS 'наименования вида ОССР';


--
-- Name: mrd_ossrref_id_seq; Type: SEQUENCE; Schema: public; Owner: svcm
--

CREATE SEQUENCE mrd_ossrref_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE mrd_ossrref_id_seq OWNER TO svcm;

--
-- Name: mrd_ossrref_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: svcm
--

ALTER SEQUENCE mrd_ossrref_id_seq OWNED BY mrd_ossrref.id;


--
-- Name: ssr_chapter; Type: TABLE; Schema: public; Owner: svcm
--

CREATE TABLE ssr_chapter (
    id smallint NOT NULL,
    code character varying(8) NOT NULL,
    name character varying(256) NOT NULL
);


ALTER TABLE ssr_chapter OWNER TO svcm;

--
-- Name: TABLE ssr_chapter; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON TABLE ssr_chapter IS 'Главы ССР';


--
-- Name: COLUMN ssr_chapter.id; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN ssr_chapter.id IS 'Идентификатор';


--
-- Name: COLUMN ssr_chapter.code; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN ssr_chapter.code IS 'Номер';


--
-- Name: COLUMN ssr_chapter.name; Type: COMMENT; Schema: public; Owner: svcm
--

COMMENT ON COLUMN ssr_chapter.name IS 'Наименование';


--
-- Name: ssr_chapter_id_seq; Type: SEQUENCE; Schema: public; Owner: svcm
--

CREATE SEQUENCE ssr_chapter_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ssr_chapter_id_seq OWNER TO svcm;

--
-- Name: ssr_chapter_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: svcm
--

ALTER SEQUENCE ssr_chapter_id_seq OWNED BY ssr_chapter.id;


SET search_path = stream, pg_catalog;

--
-- Name: building; Type: TABLE; Schema: stream; Owner: svcm
--

CREATE TABLE building (
    id bigint NOT NULL,
    hid bigint,
    hid_str character varying(128),
    hid_uuid uuid,
    h_ptype character varying(32),
    hpid bigint,
    hpid_str character varying(128),
    hpid_uuid uuid,
    hcontract_id bigint,
    hcontract_id_str character varying(128),
    hcontract_uuid uuid,
    stream_status smallint DEFAULT 0 NOT NULL,
    successor_id bigint,
    code character varying(16) NOT NULL,
    num character varying(16) NOT NULL,
    name character varying(8192),
    gip character varying(128),
    object_time timestamp with time zone,
    insert_time timestamp with time zone
);


ALTER TABLE building OWNER TO svcm;

--
-- Name: TABLE building; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON TABLE building IS 'Поток сооружений';


--
-- Name: COLUMN building.id; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN building.id IS 'Идентификатор';


--
-- Name: COLUMN building.hid; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN building.hid IS 'ИД оригинала';


--
-- Name: COLUMN building.hid_str; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN building.hid_str IS 'ИД оригинала';


--
-- Name: COLUMN building.hid_uuid; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN building.hid_uuid IS 'ИД оригинала';


--
-- Name: COLUMN building.h_ptype; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN building.h_ptype IS 'Тип род. объекта';


--
-- Name: COLUMN building.hpid; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN building.hpid IS 'ИД род. объекта оригинала';


--
-- Name: COLUMN building.hpid_str; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN building.hpid_str IS 'ИД род. объекта оригинала';


--
-- Name: COLUMN building.hpid_uuid; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN building.hpid_uuid IS 'ИД род. объекта оригинала';


--
-- Name: COLUMN building.hcontract_id; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN building.hcontract_id IS 'ИД договора оригинала';


--
-- Name: COLUMN building.hcontract_id_str; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN building.hcontract_id_str IS 'ИД договора оригинала';


--
-- Name: COLUMN building.hcontract_uuid; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN building.hcontract_uuid IS 'ИД договора оригинала';


--
-- Name: COLUMN building.stream_status; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN building.stream_status IS 'Статус обработки';


--
-- Name: COLUMN building.successor_id; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN building.successor_id IS 'ИД записи-наследника';


--
-- Name: COLUMN building.code; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN building.code IS 'Код';


--
-- Name: COLUMN building.num; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN building.num IS 'Номер';


--
-- Name: COLUMN building.name; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN building.name IS 'Наименование';


--
-- Name: COLUMN building.gip; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN building.gip IS 'ГИП';


--
-- Name: COLUMN building.object_time; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN building.object_time IS 'Время изменения оригинала';


--
-- Name: COLUMN building.insert_time; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN building.insert_time IS 'Время импорта';


--
-- Name: building_id_seq; Type: SEQUENCE; Schema: stream; Owner: svcm
--

CREATE SEQUENCE building_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE building_id_seq OWNER TO svcm;

--
-- Name: building_id_seq; Type: SEQUENCE OWNED BY; Schema: stream; Owner: svcm
--

ALTER SEQUENCE building_id_seq OWNED BY building.id;


--
-- Name: constrpart; Type: TABLE; Schema: stream; Owner: svcm
--

CREATE TABLE constrpart (
    id bigint NOT NULL,
    hid bigint,
    hid_str character varying(128),
    hid_uuid uuid,
    h_ptype character varying(32),
    hpid bigint,
    hpid_str character varying(128),
    hpid_uuid uuid,
    stream_status smallint DEFAULT 0 NOT NULL,
    successor_id bigint,
    code character varying(16) NOT NULL,
    num character varying(16) NOT NULL,
    name character varying(8192),
    gip character varying(128),
    object_time timestamp with time zone,
    insert_time timestamp with time zone
);


ALTER TABLE constrpart OWNER TO svcm;

--
-- Name: TABLE constrpart; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON TABLE constrpart IS 'Поток частей комплексов';


--
-- Name: COLUMN constrpart.id; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN constrpart.id IS 'Идентификатор';


--
-- Name: COLUMN constrpart.hid; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN constrpart.hid IS 'ИД оригинала';


--
-- Name: COLUMN constrpart.hid_str; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN constrpart.hid_str IS 'ИД оригинала';


--
-- Name: COLUMN constrpart.hid_uuid; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN constrpart.hid_uuid IS 'ИД оригинала';


--
-- Name: COLUMN constrpart.h_ptype; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN constrpart.h_ptype IS 'Тип род. объекта';


--
-- Name: COLUMN constrpart.hpid; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN constrpart.hpid IS 'ИД род. объекта оригинала';


--
-- Name: COLUMN constrpart.hpid_str; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN constrpart.hpid_str IS 'ИД род. объекта оригинала';


--
-- Name: COLUMN constrpart.hpid_uuid; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN constrpart.hpid_uuid IS 'ИД род. объекта оригинала';


--
-- Name: COLUMN constrpart.stream_status; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN constrpart.stream_status IS 'Статус обработки';


--
-- Name: COLUMN constrpart.successor_id; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN constrpart.successor_id IS 'ИД записи-наследника';


--
-- Name: COLUMN constrpart.code; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN constrpart.code IS 'Код';


--
-- Name: COLUMN constrpart.num; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN constrpart.num IS 'Номер';


--
-- Name: COLUMN constrpart.name; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN constrpart.name IS 'Наименование';


--
-- Name: COLUMN constrpart.gip; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN constrpart.gip IS 'ГИП';


--
-- Name: COLUMN constrpart.object_time; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN constrpart.object_time IS 'Время изменения оригинала';


--
-- Name: COLUMN constrpart.insert_time; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN constrpart.insert_time IS 'Время импорта';


--
-- Name: constrpart_id_seq; Type: SEQUENCE; Schema: stream; Owner: svcm
--

CREATE SEQUENCE constrpart_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE constrpart_id_seq OWNER TO svcm;

--
-- Name: constrpart_id_seq; Type: SEQUENCE OWNED BY; Schema: stream; Owner: svcm
--

ALTER SEQUENCE constrpart_id_seq OWNED BY constrpart.id;


--
-- Name: construction; Type: TABLE; Schema: stream; Owner: svcm
--

CREATE TABLE construction (
    id bigint NOT NULL,
    hid bigint,
    hid_str character varying(128),
    hid_uuid uuid,
    stream_status smallint DEFAULT 0 NOT NULL,
    successor_id bigint,
    code character varying(16) NOT NULL,
    name character varying(8192),
    gip character varying(128),
    object_time timestamp with time zone,
    insert_time timestamp with time zone
);


ALTER TABLE construction OWNER TO svcm;

--
-- Name: TABLE construction; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON TABLE construction IS 'Поток комплексов';


--
-- Name: COLUMN construction.id; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN construction.id IS 'Идентификатор';


--
-- Name: COLUMN construction.hid; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN construction.hid IS 'Идентификатор оригинала';


--
-- Name: COLUMN construction.hid_str; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN construction.hid_str IS 'Идентификатор оригинала';


--
-- Name: COLUMN construction.hid_uuid; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN construction.hid_uuid IS 'Идентификатор оригинала';


--
-- Name: COLUMN construction.stream_status; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN construction.stream_status IS 'Статус обработки';


--
-- Name: COLUMN construction.successor_id; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN construction.successor_id IS 'ИД записи-наследника';


--
-- Name: COLUMN construction.code; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN construction.code IS 'Код комплекса';


--
-- Name: COLUMN construction.name; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN construction.name IS 'Наименование';


--
-- Name: COLUMN construction.gip; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN construction.gip IS 'Ответственный руководитель';


--
-- Name: COLUMN construction.object_time; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN construction.object_time IS 'Время изменения оригинала';


--
-- Name: COLUMN construction.insert_time; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN construction.insert_time IS 'Время импорта';


--
-- Name: construction_id_seq; Type: SEQUENCE; Schema: stream; Owner: svcm
--

CREATE SEQUENCE construction_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE construction_id_seq OWNER TO svcm;

--
-- Name: construction_id_seq; Type: SEQUENCE OWNED BY; Schema: stream; Owner: svcm
--

ALTER SEQUENCE construction_id_seq OWNED BY construction.id;


--
-- Name: contract; Type: TABLE; Schema: stream; Owner: svcm
--

CREATE TABLE contract (
    id bigint NOT NULL,
    hid bigint,
    hid_str character varying(128),
    hid_uuid uuid,
    stream_status smallint DEFAULT 0 NOT NULL,
    successor_id bigint,
    inner_num character varying(128),
    oipks character varying(16),
    contractor_code character varying(16) NOT NULL,
    contractor_name character varying(256),
    contract_num character varying(16) NOT NULL,
    contract_year smallint,
    contract_date date,
    name character varying(8192),
    contract_status character varying(32),
    ius_code character varying(32),
    dev_code character varying(4),
    dev_name character varying(256),
    techdirector character varying(32),
    gips character varying(128),
    date_sign date,
    work_start date,
    work_finish date,
    order_start date,
    order_finish date,
    work_types character varying(32),
    object_time timestamp with time zone,
    insert_time timestamp with time zone
);


ALTER TABLE contract OWNER TO svcm;

--
-- Name: TABLE contract; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON TABLE contract IS 'Поток договоров';


--
-- Name: COLUMN contract.id; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN contract.id IS 'Идентификатор';


--
-- Name: COLUMN contract.hid; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN contract.hid IS 'ИД оригинала';


--
-- Name: COLUMN contract.hid_str; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN contract.hid_str IS 'ИД оригинала';


--
-- Name: COLUMN contract.hid_uuid; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN contract.hid_uuid IS 'ИД оригинала';


--
-- Name: COLUMN contract.stream_status; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN contract.stream_status IS 'Статус обработки';


--
-- Name: COLUMN contract.successor_id; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN contract.successor_id IS 'ИД записи-наследника';


--
-- Name: COLUMN contract.inner_num; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN contract.inner_num IS 'Внутренний номер договора';


--
-- Name: COLUMN contract.oipks; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN contract.oipks IS 'Код стройки/шифр';


--
-- Name: COLUMN contract.contractor_code; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN contract.contractor_code IS 'Код заказчика';


--
-- Name: COLUMN contract.contractor_name; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN contract.contractor_name IS 'Наименование заказчика';


--
-- Name: COLUMN contract.contract_num; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN contract.contract_num IS 'Номер договора';


--
-- Name: COLUMN contract.contract_year; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN contract.contract_year IS 'Год договора';


--
-- Name: COLUMN contract.contract_date; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN contract.contract_date IS 'Дата договора';


--
-- Name: COLUMN contract.name; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN contract.name IS 'Наименование';


--
-- Name: COLUMN contract.contract_status; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN contract.contract_status IS 'Статус договора (АПБП): не определен, перспективный, проект, подписан, приостановлен, расторгнут, выполнен';


--
-- Name: COLUMN contract.ius_code; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN contract.ius_code IS 'Код ИУС (АПБП)';


--
-- Name: COLUMN contract.dev_code; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN contract.dev_code IS 'Ответственный филиал: код';


--
-- Name: COLUMN contract.dev_name; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN contract.dev_name IS 'Ответственный филиал: наименование';


--
-- Name: COLUMN contract.techdirector; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN contract.techdirector IS 'Технический директор';


--
-- Name: COLUMN contract.gips; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN contract.gips IS 'ГИПы по договору';


--
-- Name: COLUMN contract.date_sign; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN contract.date_sign IS 'Дата заключения договора';


--
-- Name: COLUMN contract.work_start; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN contract.work_start IS 'Начало работ по договору';


--
-- Name: COLUMN contract.work_finish; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN contract.work_finish IS 'Окончание работ по договору';


--
-- Name: COLUMN contract.order_start; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN contract.order_start IS 'Начало работ по приказу';


--
-- Name: COLUMN contract.order_finish; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN contract.order_finish IS 'Окончание работ по приказу';


--
-- Name: COLUMN contract.work_types; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN contract.work_types IS 'Виды работ';


--
-- Name: COLUMN contract.object_time; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN contract.object_time IS 'Время изменения оригинала';


--
-- Name: COLUMN contract.insert_time; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN contract.insert_time IS 'Время импорта';


--
-- Name: contract_id_seq; Type: SEQUENCE; Schema: stream; Owner: svcm
--

CREATE SEQUENCE contract_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE contract_id_seq OWNER TO svcm;

--
-- Name: contract_id_seq; Type: SEQUENCE OWNED BY; Schema: stream; Owner: svcm
--

ALTER SEQUENCE contract_id_seq OWNED BY contract.id;


--
-- Name: contract_stage; Type: TABLE; Schema: stream; Owner: svcm
--

CREATE TABLE contract_stage (
    id bigint NOT NULL,
    contractstage_guid character varying(64) NOT NULL,
    contract_guid character varying(64) NOT NULL,
    status character varying(32),
    stage_num character varying(32) NOT NULL,
    name character varying(20),
    plan_start date,
    plan_finish character varying(20),
    wait_start date,
    wait_finish character varying(20),
    work_types character varying(32)
);


ALTER TABLE contract_stage OWNER TO svcm;

--
-- Name: TABLE contract_stage; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON TABLE contract_stage IS 'Этапы договора';


--
-- Name: COLUMN contract_stage.id; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN contract_stage.id IS 'Идентификатор';


--
-- Name: COLUMN contract_stage.contractstage_guid; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN contract_stage.contractstage_guid IS 'GUID этапа (АПБП)';


--
-- Name: COLUMN contract_stage.contract_guid; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN contract_stage.contract_guid IS 'GUID договора, ссылка на договор (АПБП)';


--
-- Name: COLUMN contract_stage.status; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN contract_stage.status IS 'Статус этапа (АПБП): не определен, перспективный, проект, подписан, приостановлен, расторгнут, выполнен';


--
-- Name: COLUMN contract_stage.stage_num; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN contract_stage.stage_num IS 'Номер этапа';


--
-- Name: COLUMN contract_stage.name; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN contract_stage.name IS 'Наименование этапа';


--
-- Name: COLUMN contract_stage.plan_start; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN contract_stage.plan_start IS 'План начала работ';


--
-- Name: COLUMN contract_stage.plan_finish; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN contract_stage.plan_finish IS 'План окончания работ';


--
-- Name: COLUMN contract_stage.wait_start; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN contract_stage.wait_start IS 'Ожидание начало работ';


--
-- Name: COLUMN contract_stage.wait_finish; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN contract_stage.wait_finish IS 'Ожидание окончания работ';


--
-- Name: COLUMN contract_stage.work_types; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN contract_stage.work_types IS 'Виды работ';


--
-- Name: contract_stage_id_seq; Type: SEQUENCE; Schema: stream; Owner: svcm
--

CREATE SEQUENCE contract_stage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE contract_stage_id_seq OWNER TO svcm;

--
-- Name: contract_stage_id_seq; Type: SEQUENCE OWNED BY; Schema: stream; Owner: svcm
--

ALTER SEQUENCE contract_stage_id_seq OWNED BY contract_stage.id;


--
-- Name: docset; Type: TABLE; Schema: stream; Owner: svcm
--

CREATE TABLE docset (
    id bigint NOT NULL,
    hid bigint,
    hid_str character varying(128),
    hid_uuid uuid,
    h_ptype character varying(32),
    hpid bigint,
    hpid_str character varying(128),
    hpid_uuid uuid,
    stream_status smallint DEFAULT 0 NOT NULL,
    successor_id bigint,
    name character varying(8192),
    cipher character varying(128),
    dev_dep character varying(32),
    oipks character varying(32),
    ccode character varying(32),
    num character varying(32),
    pstage character varying(32),
    dev_org character varying(32),
    cpcode character varying(32),
    cpnum character varying(32),
    bcode character varying(32),
    bnum character varying(32),
    mark character varying(32),
    mark_path character varying(32),
    cipher_doc character varying(32),
    bstage character varying(32),
    cstage character varying(32),
    izm_num character varying(32),
    gip character varying(128),
    status character varying(512),
    object_time timestamp with time zone,
    insert_time timestamp with time zone
);


ALTER TABLE docset OWNER TO svcm;

--
-- Name: TABLE docset; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON TABLE docset IS 'Поток составных документов';


--
-- Name: COLUMN docset.id; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN docset.id IS 'Идентификатор';


--
-- Name: COLUMN docset.hid; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN docset.hid IS 'ИД оригинала';


--
-- Name: COLUMN docset.hid_str; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN docset.hid_str IS 'ИД оригинала';


--
-- Name: COLUMN docset.hid_uuid; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN docset.hid_uuid IS 'ИД оригинала';


--
-- Name: COLUMN docset.h_ptype; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN docset.h_ptype IS 'Ти род. объекта';


--
-- Name: COLUMN docset.hpid; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN docset.hpid IS 'ИД род. объекта оригинала';


--
-- Name: COLUMN docset.hpid_str; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN docset.hpid_str IS 'ИД род. объекта оригинала';


--
-- Name: COLUMN docset.hpid_uuid; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN docset.hpid_uuid IS 'ИД род. объекта оригинала';


--
-- Name: COLUMN docset.stream_status; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN docset.stream_status IS 'Статус обработки';


--
-- Name: COLUMN docset.successor_id; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN docset.successor_id IS 'ИД записи-наследника';


--
-- Name: COLUMN docset.name; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN docset.name IS 'Наименование';


--
-- Name: COLUMN docset.cipher; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN docset.cipher IS 'Шифр документа (обозначение)';


--
-- Name: COLUMN docset.dev_dep; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN docset.dev_dep IS 'Код подразделения-исполнителя';


--
-- Name: COLUMN docset.oipks; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN docset.oipks IS '1 - код ОИП КС';


--
-- Name: COLUMN docset.ccode; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN docset.ccode IS '2 - код заказчика';


--
-- Name: COLUMN docset.num; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN docset.num IS '3 - номер договора';


--
-- Name: COLUMN docset.pstage; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN docset.pstage IS '4 - стадия';


--
-- Name: COLUMN docset.dev_org; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN docset.dev_org IS '5 - субъект разработки';


--
-- Name: COLUMN docset.cpcode; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN docset.cpcode IS '6 - код части комплекса';


--
-- Name: COLUMN docset.cpnum; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN docset.cpnum IS '7 - номер части комплекса';


--
-- Name: COLUMN docset.bcode; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN docset.bcode IS '8 - код сооружения/сети ';


--
-- Name: COLUMN docset.bnum; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN docset.bnum IS '9 - позиция по генплану';


--
-- Name: COLUMN docset.mark; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN docset.mark IS '10 - марка основного комплекта';


--
-- Name: COLUMN docset.mark_path; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN docset.mark_path IS '11 - номер части марки';


--
-- Name: COLUMN docset.cipher_doc; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN docset.cipher_doc IS '12 - шифр документа';


--
-- Name: COLUMN docset.bstage; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN docset.bstage IS 'Этап строительства по договору';


--
-- Name: COLUMN docset.cstage; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN docset.cstage IS 'Этап по генподрядному договру';


--
-- Name: COLUMN docset.izm_num; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN docset.izm_num IS 'Изменение';


--
-- Name: COLUMN docset.gip; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN docset.gip IS 'Гип';


--
-- Name: COLUMN docset.status; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN docset.status IS 'Статус';


--
-- Name: COLUMN docset.object_time; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN docset.object_time IS 'Время изменения оригинала';


--
-- Name: COLUMN docset.insert_time; Type: COMMENT; Schema: stream; Owner: svcm
--

COMMENT ON COLUMN docset.insert_time IS 'Время импорта';


--
-- Name: docset_id_seq; Type: SEQUENCE; Schema: stream; Owner: svcm
--

CREATE SEQUENCE docset_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE docset_id_seq OWNER TO svcm;

--
-- Name: docset_id_seq; Type: SEQUENCE OWNED BY; Schema: stream; Owner: svcm
--

ALTER SEQUENCE docset_id_seq OWNED BY docset.id;


SET search_path = sys, pg_catalog;

--
-- Name: acl_account; Type: TABLE; Schema: sys; Owner: svcm
--

CREATE TABLE acl_account (
    id integer NOT NULL,
    login character varying(32) NOT NULL,
    pwd character varying(64),
    salt character varying(64),
    firstname character varying(128),
    middlename character varying(128),
    lastname character varying(128),
    tabnum character varying(32),
    email character varying(128) NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE acl_account OWNER TO svcm;

--
-- Name: TABLE acl_account; Type: COMMENT; Schema: sys; Owner: svcm
--

COMMENT ON TABLE acl_account IS 'Пользователи';


--
-- Name: COLUMN acl_account.id; Type: COMMENT; Schema: sys; Owner: svcm
--

COMMENT ON COLUMN acl_account.id IS 'Идентификатор';


--
-- Name: COLUMN acl_account.login; Type: COMMENT; Schema: sys; Owner: svcm
--

COMMENT ON COLUMN acl_account.login IS 'Логин';


--
-- Name: COLUMN acl_account.pwd; Type: COMMENT; Schema: sys; Owner: svcm
--

COMMENT ON COLUMN acl_account.pwd IS 'Пароль';


--
-- Name: COLUMN acl_account.salt; Type: COMMENT; Schema: sys; Owner: svcm
--

COMMENT ON COLUMN acl_account.salt IS 'Соль';


--
-- Name: COLUMN acl_account.firstname; Type: COMMENT; Schema: sys; Owner: svcm
--

COMMENT ON COLUMN acl_account.firstname IS 'Имя';


--
-- Name: COLUMN acl_account.middlename; Type: COMMENT; Schema: sys; Owner: svcm
--

COMMENT ON COLUMN acl_account.middlename IS 'Отчество';


--
-- Name: COLUMN acl_account.lastname; Type: COMMENT; Schema: sys; Owner: svcm
--

COMMENT ON COLUMN acl_account.lastname IS 'Фамилия';


--
-- Name: COLUMN acl_account.tabnum; Type: COMMENT; Schema: sys; Owner: svcm
--

COMMENT ON COLUMN acl_account.tabnum IS 'Табельный номер';


--
-- Name: COLUMN acl_account.email; Type: COMMENT; Schema: sys; Owner: svcm
--

COMMENT ON COLUMN acl_account.email IS 'E-mail';


--
-- Name: COLUMN acl_account.is_active; Type: COMMENT; Schema: sys; Owner: svcm
--

COMMENT ON COLUMN acl_account.is_active IS 'Статус активности';


--
-- Name: acl_account_id_seq; Type: SEQUENCE; Schema: sys; Owner: svcm
--

CREATE SEQUENCE acl_account_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE acl_account_id_seq OWNER TO svcm;

--
-- Name: acl_account_id_seq; Type: SEQUENCE OWNED BY; Schema: sys; Owner: svcm
--

ALTER SEQUENCE acl_account_id_seq OWNED BY acl_account.id;


--
-- Name: acl_account_role; Type: TABLE; Schema: sys; Owner: svcm
--

CREATE TABLE acl_account_role (
    id bigint NOT NULL,
    account_id integer NOT NULL,
    role_id integer NOT NULL
);


ALTER TABLE acl_account_role OWNER TO svcm;

--
-- Name: TABLE acl_account_role; Type: COMMENT; Schema: sys; Owner: svcm
--

COMMENT ON TABLE acl_account_role IS 'acl_account <-> acl_role';


--
-- Name: COLUMN acl_account_role.id; Type: COMMENT; Schema: sys; Owner: svcm
--

COMMENT ON COLUMN acl_account_role.id IS 'Идентификатор';


--
-- Name: COLUMN acl_account_role.account_id; Type: COMMENT; Schema: sys; Owner: svcm
--

COMMENT ON COLUMN acl_account_role.account_id IS '-> acl_account';


--
-- Name: COLUMN acl_account_role.role_id; Type: COMMENT; Schema: sys; Owner: svcm
--

COMMENT ON COLUMN acl_account_role.role_id IS '-> acl_role';


--
-- Name: acl_account_role_id_seq; Type: SEQUENCE; Schema: sys; Owner: svcm
--

CREATE SEQUENCE acl_account_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE acl_account_role_id_seq OWNER TO svcm;

--
-- Name: acl_account_role_id_seq; Type: SEQUENCE OWNED BY; Schema: sys; Owner: svcm
--

ALTER SEQUENCE acl_account_role_id_seq OWNED BY acl_account_role.id;


--
-- Name: acl_function; Type: TABLE; Schema: sys; Owner: svcm
--

CREATE TABLE acl_function (
    id integer NOT NULL,
    name character varying(32) NOT NULL,
    descr character varying(512)
);


ALTER TABLE acl_function OWNER TO svcm;

--
-- Name: TABLE acl_function; Type: COMMENT; Schema: sys; Owner: svcm
--

COMMENT ON TABLE acl_function IS 'Функции доступа';


--
-- Name: COLUMN acl_function.id; Type: COMMENT; Schema: sys; Owner: svcm
--

COMMENT ON COLUMN acl_function.id IS 'Идентификатор';


--
-- Name: COLUMN acl_function.name; Type: COMMENT; Schema: sys; Owner: svcm
--

COMMENT ON COLUMN acl_function.name IS 'Наименование';


--
-- Name: COLUMN acl_function.descr; Type: COMMENT; Schema: sys; Owner: svcm
--

COMMENT ON COLUMN acl_function.descr IS 'Описание';


--
-- Name: acl_function_id_seq; Type: SEQUENCE; Schema: sys; Owner: svcm
--

CREATE SEQUENCE acl_function_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE acl_function_id_seq OWNER TO svcm;

--
-- Name: acl_function_id_seq; Type: SEQUENCE OWNED BY; Schema: sys; Owner: svcm
--

ALTER SEQUENCE acl_function_id_seq OWNED BY acl_function.id;


--
-- Name: acl_group; Type: TABLE; Schema: sys; Owner: svcm
--

CREATE TABLE acl_group (
    id integer NOT NULL,
    name character varying(256) NOT NULL,
    descr character varying(1024)
);


ALTER TABLE acl_group OWNER TO svcm;

--
-- Name: TABLE acl_group; Type: COMMENT; Schema: sys; Owner: svcm
--

COMMENT ON TABLE acl_group IS 'Группы пользователей';


--
-- Name: COLUMN acl_group.id; Type: COMMENT; Schema: sys; Owner: svcm
--

COMMENT ON COLUMN acl_group.id IS 'Идентификатор';


--
-- Name: COLUMN acl_group.name; Type: COMMENT; Schema: sys; Owner: svcm
--

COMMENT ON COLUMN acl_group.name IS 'Наименование';


--
-- Name: COLUMN acl_group.descr; Type: COMMENT; Schema: sys; Owner: svcm
--

COMMENT ON COLUMN acl_group.descr IS 'Идентификатор';


--
-- Name: acl_group_id_seq; Type: SEQUENCE; Schema: sys; Owner: svcm
--

CREATE SEQUENCE acl_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE acl_group_id_seq OWNER TO svcm;

--
-- Name: acl_group_id_seq; Type: SEQUENCE OWNED BY; Schema: sys; Owner: svcm
--

ALTER SEQUENCE acl_group_id_seq OWNED BY acl_group.id;


--
-- Name: acl_role; Type: TABLE; Schema: sys; Owner: svcm
--

CREATE TABLE acl_role (
    id integer NOT NULL,
    name character varying(256) NOT NULL,
    descr character varying(1024)
);


ALTER TABLE acl_role OWNER TO svcm;

--
-- Name: TABLE acl_role; Type: COMMENT; Schema: sys; Owner: svcm
--

COMMENT ON TABLE acl_role IS 'Роли доступа';


--
-- Name: COLUMN acl_role.id; Type: COMMENT; Schema: sys; Owner: svcm
--

COMMENT ON COLUMN acl_role.id IS 'Идентификатор';


--
-- Name: COLUMN acl_role.name; Type: COMMENT; Schema: sys; Owner: svcm
--

COMMENT ON COLUMN acl_role.name IS 'Наименование';


--
-- Name: COLUMN acl_role.descr; Type: COMMENT; Schema: sys; Owner: svcm
--

COMMENT ON COLUMN acl_role.descr IS 'Описание';


--
-- Name: acl_role_function; Type: TABLE; Schema: sys; Owner: svcm
--

CREATE TABLE acl_role_function (
    id bigint NOT NULL,
    role_id integer NOT NULL,
    function_id integer NOT NULL
);


ALTER TABLE acl_role_function OWNER TO svcm;

--
-- Name: TABLE acl_role_function; Type: COMMENT; Schema: sys; Owner: svcm
--

COMMENT ON TABLE acl_role_function IS 'acl_role <-> acl_function';


--
-- Name: COLUMN acl_role_function.id; Type: COMMENT; Schema: sys; Owner: svcm
--

COMMENT ON COLUMN acl_role_function.id IS 'Идентификатор';


--
-- Name: COLUMN acl_role_function.role_id; Type: COMMENT; Schema: sys; Owner: svcm
--

COMMENT ON COLUMN acl_role_function.role_id IS '-> acl_role';


--
-- Name: COLUMN acl_role_function.function_id; Type: COMMENT; Schema: sys; Owner: svcm
--

COMMENT ON COLUMN acl_role_function.function_id IS '-> acl_function';


--
-- Name: acl_role_function_id_seq; Type: SEQUENCE; Schema: sys; Owner: svcm
--

CREATE SEQUENCE acl_role_function_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE acl_role_function_id_seq OWNER TO svcm;

--
-- Name: acl_role_function_id_seq; Type: SEQUENCE OWNED BY; Schema: sys; Owner: svcm
--

ALTER SEQUENCE acl_role_function_id_seq OWNED BY acl_role_function.id;


--
-- Name: acl_role_id_seq; Type: SEQUENCE; Schema: sys; Owner: svcm
--

CREATE SEQUENCE acl_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE acl_role_id_seq OWNER TO svcm;

--
-- Name: acl_role_id_seq; Type: SEQUENCE OWNED BY; Schema: sys; Owner: svcm
--

ALTER SEQUENCE acl_role_id_seq OWNED BY acl_role.id;


--
-- Name: logevent; Type: TABLE; Schema: sys; Owner: svcm
--

CREATE TABLE logevent (
    id bigint NOT NULL,
    account_id integer NOT NULL,
    eventtype_id integer NOT NULL,
    eventtime timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    schema_name character varying(25),
    operation_name character varying(250) NOT NULL,
    operation_pk_id bigint,
    operation_pk_time timestamp with time zone,
    details json,
    descr core.d_description
);


ALTER TABLE logevent OWNER TO svcm;

--
-- Name: TABLE logevent; Type: COMMENT; Schema: sys; Owner: svcm
--

COMMENT ON TABLE logevent IS 'Аудит действий пользователя';


--
-- Name: COLUMN logevent.id; Type: COMMENT; Schema: sys; Owner: svcm
--

COMMENT ON COLUMN logevent.id IS 'Идентификатор';


--
-- Name: COLUMN logevent.account_id; Type: COMMENT; Schema: sys; Owner: svcm
--

COMMENT ON COLUMN logevent.account_id IS '-> acl_account';


--
-- Name: COLUMN logevent.eventtype_id; Type: COMMENT; Schema: sys; Owner: svcm
--

COMMENT ON COLUMN logevent.eventtype_id IS '-> ref_logeventtype';


--
-- Name: COLUMN logevent.eventtime; Type: COMMENT; Schema: sys; Owner: svcm
--

COMMENT ON COLUMN logevent.eventtime IS 'Дата и время события';


--
-- Name: COLUMN logevent.schema_name; Type: COMMENT; Schema: sys; Owner: svcm
--

COMMENT ON COLUMN logevent.schema_name IS 'Имя схемы БД для операции';


--
-- Name: COLUMN logevent.operation_name; Type: COMMENT; Schema: sys; Owner: svcm
--

COMMENT ON COLUMN logevent.operation_name IS 'Имя операции - логируемая таблица/отчет/функция и т.д.';


--
-- Name: COLUMN logevent.operation_pk_id; Type: COMMENT; Schema: sys; Owner: svcm
--

COMMENT ON COLUMN logevent.operation_pk_id IS 'Id первичного ключа логируемой таблицы';


--
-- Name: COLUMN logevent.operation_pk_time; Type: COMMENT; Schema: sys; Owner: svcm
--

COMMENT ON COLUMN logevent.operation_pk_time IS 'Дата и время первичного ключа логируемой таблицы';


--
-- Name: COLUMN logevent.details; Type: COMMENT; Schema: sys; Owner: svcm
--

COMMENT ON COLUMN logevent.details IS 'Детализация данных операции';


--
-- Name: COLUMN logevent.descr; Type: COMMENT; Schema: sys; Owner: svcm
--

COMMENT ON COLUMN logevent.descr IS 'Описание';


--
-- Name: logevent_id_seq; Type: SEQUENCE; Schema: sys; Owner: svcm
--

CREATE SEQUENCE logevent_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE logevent_id_seq OWNER TO svcm;

--
-- Name: logevent_id_seq; Type: SEQUENCE OWNED BY; Schema: sys; Owner: svcm
--

ALTER SEQUENCE logevent_id_seq OWNED BY logevent.id;


--
-- Name: ref_logeventtype; Type: TABLE; Schema: sys; Owner: svcm
--

CREATE TABLE ref_logeventtype (
    id integer NOT NULL,
    name character varying(10) NOT NULL,
    descr core.d_description
);


ALTER TABLE ref_logeventtype OWNER TO svcm;

--
-- Name: TABLE ref_logeventtype; Type: COMMENT; Schema: sys; Owner: svcm
--

COMMENT ON TABLE ref_logeventtype IS 'Типы событий для аудита';


--
-- Name: COLUMN ref_logeventtype.id; Type: COMMENT; Schema: sys; Owner: svcm
--

COMMENT ON COLUMN ref_logeventtype.id IS 'Идентификатор';


--
-- Name: COLUMN ref_logeventtype.name; Type: COMMENT; Schema: sys; Owner: svcm
--

COMMENT ON COLUMN ref_logeventtype.name IS 'Наименование действия';


--
-- Name: COLUMN ref_logeventtype.descr; Type: COMMENT; Schema: sys; Owner: svcm
--

COMMENT ON COLUMN ref_logeventtype.descr IS 'Описание';


--
-- Name: ref_logeventtype_id_seq; Type: SEQUENCE; Schema: sys; Owner: svcm
--

CREATE SEQUENCE ref_logeventtype_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ref_logeventtype_id_seq OWNER TO svcm;

--
-- Name: ref_logeventtype_id_seq; Type: SEQUENCE OWNED BY; Schema: sys; Owner: svcm
--

ALTER SEQUENCE ref_logeventtype_id_seq OWNED BY ref_logeventtype.id;


SET search_path = core, pg_catalog;

--
-- Name: cobject id; Type: DEFAULT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY cobject ALTER COLUMN id SET DEFAULT nextval('cobject_id_seq'::regclass);


--
-- Name: cobject_type id; Type: DEFAULT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY cobject_type ALTER COLUMN id SET DEFAULT nextval('cobject_type_id_seq'::regclass);


--
-- Name: construction id; Type: DEFAULT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY construction ALTER COLUMN id SET DEFAULT nextval('construction_id_seq'::regclass);


--
-- Name: contract id; Type: DEFAULT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY contract ALTER COLUMN id SET DEFAULT nextval('contract_id_seq'::regclass);


--
-- Name: docset id; Type: DEFAULT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY docset ALTER COLUMN id SET DEFAULT nextval('docset_id_seq'::regclass);


--
-- Name: docset_mon id; Type: DEFAULT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY docset_mon ALTER COLUMN id SET DEFAULT nextval('docset_mon_id_seq'::regclass);


--
-- Name: ds_bsd id; Type: DEFAULT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY ds_bsd ALTER COLUMN id SET DEFAULT nextval('ds_bsd_id_seq'::regclass);


--
-- Name: ds_type id; Type: DEFAULT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY ds_type ALTER COLUMN id SET DEFAULT nextval('ds_type_id_seq'::regclass);


--
-- Name: ref_building id; Type: DEFAULT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY ref_building ALTER COLUMN id SET DEFAULT nextval('ref_building_id_seq'::regclass);


--
-- Name: ref_building_group id; Type: DEFAULT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY ref_building_group ALTER COLUMN id SET DEFAULT nextval('ref_building_group_id_seq'::regclass);


--
-- Name: ref_chaptercode id; Type: DEFAULT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY ref_chaptercode ALTER COLUMN id SET DEFAULT nextval('ref_chaptercode_id_seq'::regclass);


--
-- Name: ref_chaptercode_type id; Type: DEFAULT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY ref_chaptercode_type ALTER COLUMN id SET DEFAULT nextval('ref_chaptercode_type_id_seq'::regclass);


--
-- Name: ref_constrpart id; Type: DEFAULT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY ref_constrpart ALTER COLUMN id SET DEFAULT nextval('ref_constrpart_id_seq'::regclass);


--
-- Name: ref_constrpart_group id; Type: DEFAULT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY ref_constrpart_group ALTER COLUMN id SET DEFAULT nextval('ref_constrpart_group_id_seq'::regclass);


--
-- Name: ref_contractor id; Type: DEFAULT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY ref_contractor ALTER COLUMN id SET DEFAULT nextval('ref_contractor_id_seq'::regclass);


--
-- Name: ref_developer id; Type: DEFAULT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY ref_developer ALTER COLUMN id SET DEFAULT nextval('ref_developer_id_seq'::regclass);


--
-- Name: ref_doccode id; Type: DEFAULT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY ref_doccode ALTER COLUMN id SET DEFAULT nextval('ref_doccode_id_seq'::regclass);


--
-- Name: ref_mark id; Type: DEFAULT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY ref_mark ALTER COLUMN id SET DEFAULT nextval('ref_mark_id_seq'::regclass);


--
-- Name: ref_phase id; Type: DEFAULT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY ref_phase ALTER COLUMN id SET DEFAULT nextval('ref_phase_id_seq'::regclass);


--
-- Name: waybill id; Type: DEFAULT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY waybill ALTER COLUMN id SET DEFAULT nextval('waybill_id_seq'::regclass);


--
-- Name: waybill_link id; Type: DEFAULT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY waybill_link ALTER COLUMN id SET DEFAULT nextval('waybill_link_id_seq'::regclass);


SET search_path = public, pg_catalog;

--
-- Name: cost_assign id; Type: DEFAULT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY cost_assign ALTER COLUMN id SET DEFAULT nextval('cost_assign_id_seq'::regclass);


--
-- Name: cost_group id; Type: DEFAULT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY cost_group ALTER COLUMN id SET DEFAULT nextval('cost_group_id_seq'::regclass);


--
-- Name: cost_kind id; Type: DEFAULT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY cost_kind ALTER COLUMN id SET DEFAULT nextval('cost_kind_id_seq'::regclass);


--
-- Name: estimate id; Type: DEFAULT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY estimate ALTER COLUMN id SET DEFAULT nextval('estimate_id_seq'::regclass);


--
-- Name: estimate_fission id; Type: DEFAULT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY estimate_fission ALTER COLUMN id SET DEFAULT nextval('estimate_fission_id_seq'::regclass);


--
-- Name: estimate_link id; Type: DEFAULT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY estimate_link ALTER COLUMN id SET DEFAULT nextval('estimate_link_id_seq'::regclass);


--
-- Name: estimate_type id; Type: DEFAULT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY estimate_type ALTER COLUMN id SET DEFAULT nextval('estimate_type_id_seq'::regclass);


--
-- Name: iusi_plan_form id; Type: DEFAULT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY iusi_plan_form ALTER COLUMN id SET DEFAULT nextval('iusi_plan_form_id_seq'::regclass);


--
-- Name: mrd_object id; Type: DEFAULT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY mrd_object ALTER COLUMN id SET DEFAULT nextval('mrd_object_id_seq'::regclass);


--
-- Name: mrd_object_link id; Type: DEFAULT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY mrd_object_link ALTER COLUMN id SET DEFAULT nextval('mrd_object_link_id_seq'::regclass);


--
-- Name: mrd_oksgroup id; Type: DEFAULT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY mrd_oksgroup ALTER COLUMN id SET DEFAULT nextval('mrd_oksgroup_id_seq'::regclass);


--
-- Name: mrd_oksref id; Type: DEFAULT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY mrd_oksref ALTER COLUMN id SET DEFAULT nextval('mrd_oksref_id_seq'::regclass);


--
-- Name: mrd_ossrgroup id; Type: DEFAULT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY mrd_ossrgroup ALTER COLUMN id SET DEFAULT nextval('mrd_ossrgroup_id_seq'::regclass);


--
-- Name: mrd_ossrref id; Type: DEFAULT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY mrd_ossrref ALTER COLUMN id SET DEFAULT nextval('mrd_ossrref_id_seq'::regclass);


--
-- Name: ssr_chapter id; Type: DEFAULT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY ssr_chapter ALTER COLUMN id SET DEFAULT nextval('ssr_chapter_id_seq'::regclass);


SET search_path = stream, pg_catalog;

--
-- Name: building id; Type: DEFAULT; Schema: stream; Owner: svcm
--

ALTER TABLE ONLY building ALTER COLUMN id SET DEFAULT nextval('building_id_seq'::regclass);


--
-- Name: constrpart id; Type: DEFAULT; Schema: stream; Owner: svcm
--

ALTER TABLE ONLY constrpart ALTER COLUMN id SET DEFAULT nextval('constrpart_id_seq'::regclass);


--
-- Name: construction id; Type: DEFAULT; Schema: stream; Owner: svcm
--

ALTER TABLE ONLY construction ALTER COLUMN id SET DEFAULT nextval('construction_id_seq'::regclass);


--
-- Name: contract id; Type: DEFAULT; Schema: stream; Owner: svcm
--

ALTER TABLE ONLY contract ALTER COLUMN id SET DEFAULT nextval('contract_id_seq'::regclass);


--
-- Name: contract_stage id; Type: DEFAULT; Schema: stream; Owner: svcm
--

ALTER TABLE ONLY contract_stage ALTER COLUMN id SET DEFAULT nextval('contract_stage_id_seq'::regclass);


--
-- Name: docset id; Type: DEFAULT; Schema: stream; Owner: svcm
--

ALTER TABLE ONLY docset ALTER COLUMN id SET DEFAULT nextval('docset_id_seq'::regclass);


SET search_path = sys, pg_catalog;

--
-- Name: acl_account id; Type: DEFAULT; Schema: sys; Owner: svcm
--

ALTER TABLE ONLY acl_account ALTER COLUMN id SET DEFAULT nextval('acl_account_id_seq'::regclass);


--
-- Name: acl_account_role id; Type: DEFAULT; Schema: sys; Owner: svcm
--

ALTER TABLE ONLY acl_account_role ALTER COLUMN id SET DEFAULT nextval('acl_account_role_id_seq'::regclass);


--
-- Name: acl_function id; Type: DEFAULT; Schema: sys; Owner: svcm
--

ALTER TABLE ONLY acl_function ALTER COLUMN id SET DEFAULT nextval('acl_function_id_seq'::regclass);


--
-- Name: acl_group id; Type: DEFAULT; Schema: sys; Owner: svcm
--

ALTER TABLE ONLY acl_group ALTER COLUMN id SET DEFAULT nextval('acl_group_id_seq'::regclass);


--
-- Name: acl_role id; Type: DEFAULT; Schema: sys; Owner: svcm
--

ALTER TABLE ONLY acl_role ALTER COLUMN id SET DEFAULT nextval('acl_role_id_seq'::regclass);


--
-- Name: acl_role_function id; Type: DEFAULT; Schema: sys; Owner: svcm
--

ALTER TABLE ONLY acl_role_function ALTER COLUMN id SET DEFAULT nextval('acl_role_function_id_seq'::regclass);


--
-- Name: logevent id; Type: DEFAULT; Schema: sys; Owner: svcm
--

ALTER TABLE ONLY logevent ALTER COLUMN id SET DEFAULT nextval('logevent_id_seq'::regclass);


--
-- Name: ref_logeventtype id; Type: DEFAULT; Schema: sys; Owner: svcm
--

ALTER TABLE ONLY ref_logeventtype ALTER COLUMN id SET DEFAULT nextval('ref_logeventtype_id_seq'::regclass);


SET search_path = core, pg_catalog;

--
-- Data for Name: cobject; Type: TABLE DATA; Schema: core; Owner: svcm
--

COPY cobject (id, parent_id, construction_id, cobject_type_id, code, number, descr) FROM stdin;
\.


--
-- Data for Name: cobject_type; Type: TABLE DATA; Schema: core; Owner: svcm
--

COPY cobject_type (id, code, name, descr) FROM stdin;
1	C	CONSTR	Комплекс
2	P	CONSTR_PART	Часть комплекса
3	B	BUILDING	Здание/сооружение
4	M	MARK	Марка
5	F	FOLDER	Папка
\.


--
-- Data for Name: construction; Type: TABLE DATA; Schema: core; Owner: svcm
--

COPY construction (id, code, name) FROM stdin;
\.


--
-- Data for Name: contract; Type: TABLE DATA; Schema: core; Owner: svcm
--

COPY contract (id, construction_id, oipks, contractor_id, phase_id, developer_id, inner_num, title, contract_num, contract_year, contract_date, contract_status, ius_code, techdirector, gips, date_sign, work_start, work_finish, order_start, order_finish, work_types) FROM stdin;
\.


--
-- Data for Name: docset; Type: TABLE DATA; Schema: core; Owner: svcm
--

COPY docset (id, cobject_id, settype, cipher, mark_ref_id, name, datestart, datefinish, invoice_num, invoice_date, ds_type_id) FROM stdin;
\.


--
-- Data for Name: docset_mon; Type: TABLE DATA; Schema: core; Owner: svcm
--

COPY docset_mon (id, docset_id, mondate, monpercent, description, created) FROM stdin;
\.


--
-- Data for Name: ds_bsd; Type: TABLE DATA; Schema: core; Owner: svcm
--

COPY ds_bsd (id, docset_id, name, cipher, dev_dep, oipks_id, contractor_id, contract_id, phase_id, phase_num, developer_id, constrpart_id, constrpart_num, building_id, building_num, mark_id, mark_path, cipher_doc, cstage, izm_num, gip, status, object_time) FROM stdin;
\.


--
-- Data for Name: ds_type; Type: TABLE DATA; Schema: core; Owner: svcm
--

COPY ds_type (id, name, descr) FROM stdin;
1	Комплект	Комплект проектной продукции (стадия Р)
2	Том	Том (стадия П, ИИ)
\.


--
-- Data for Name: ref_building; Type: TABLE DATA; Schema: core; Owner: svcm
--

COPY ref_building (id, group_id, code, name) FROM stdin;
1	\N	0001	Блок-бокс подготовки газа на собственные нужды
2	\N	0002	Блок-бокс узла редуцирования газа
3	\N	0003	Установка емкости одоранта
4	\N	0004	Установка емкости сбора продуктов очистки газа
5	\N	0005	Здание входных ниток
6	\N	0006	Здание входных сепараторов
7	\N	0007	Здание газораспределительной станции
8	\N	0008	Здание деэтанизации конденсата
9	\N	0009	Здание пробкоуловителей
10	\N	0010	Здание разделителей конденсата
11	\N	0011	Здание теплообменников и насосов конденсата
12	\N	0012	Здание турбодетандеров
13	\N	0013	Здание установки выветривания конденсата
14	\N	0014	Здание установки механической очистки и осушки газа
15	\N	0015	Здание установки осушки газа
16	\N	0016	Здание установки стабилизации конденсата
17	\N	0017	Здание фильтров-сепараторов газа
18	\N	0018	Здание цеха очистки газа
19	\N	0019	Здание цеха подготовки газа
20	\N	0020	Здание цеха подготовки газа и конденсата
21	\N	0021	Здание цеха сепарации газа
22	\N	0022	Здание компрессорного цеха
23	\N	0023	Установка подготовки импульсного газа
24	\N	0024	Установка теплообменников и АВО
25	\N	0025	Установка АВО газа
26	\N	0026	Установка АВО ДЭГа
27	\N	0027	Установка АВО конденсата
28	\N	0028	Установка АВО метанола
29	\N	0029	Установка АВО охлаждающей жидкости
30	\N	0030	Установка буферных емкостей
31	\N	0031	Установка впрыска метанола
32	\N	0032	Установка входных ниток
33	\N	0033	Установка входных сепараторов
34	\N	0034	Установка газовоздушных подогревателей
35	\N	0035	Установка дегазатора конденсата
36	\N	0036	Установка дегазатора насыщенного метанола
37	\N	0037	Установка деэтанизации конденсата
38	\N	0038	Установка емкостей дегазатора конденсата
39	\N	0039	Установка компрессорная
40	\N	0040	Установка одоризации газа
41	\N	0041	Установка осушки газа
42	\N	0042	Установка очистки конденсата
43	\N	0043	Установка переработки конденсата
44	\N	0044	Установка печей ГСН
45	\N	0045	Установка печей стабилизации конденсата
46	\N	0046	Установка подготовки буферного газа
47	\N	0047	Установка подготовки газа на собственные нужды
48	\N	0048	Установка подготовки конденсата газа
49	\N	0049	Установка подготовки топливного газа
50	\N	0050	Установка подготовки топливного и импульсного газа
51	\N	0051	Установка подогрева газа
52	\N	0052	Установка подогрева конденсата
53	\N	0053	Установка подогрева теплоносителя
54	\N	0054	Установка получения жидких углеводородов
55	\N	0055	Установка получения пропана
56	\N	0056	Установка получения сжиженных газов
57	\N	0057	Установка промывки и осушки газа
58	\N	0058	Установка разделителей конденсата
59	\N	0059	Установка разделительных емкостей конденсата
60	\N	0060	Установка реактора очистки конденсата с арматурными блоками печей
61	\N	0061	Установка регенерации фильтров масла
62	\N	0062	Установка редуцирования газа
63	\N	0063	Установка сбора конденсата
64	\N	0064	Установка сепарации газа
65	\N	0065	Установка стабилизации конденсата
66	\N	0066	Установка теплообменников газа
67	\N	0067	Установка теплообменников конденсата
68	\N	0068	Установка трапная концевая
69	\N	0069	Установка турбодетандеров
70	\N	0070	Установка фильтров-сепараторов газа
71	\N	0071	Установка фракционирования конденсата
72	\N	0072	Установка эжектирования газа
73	\N	0073	Установка удаления ртути
74	\N	0074	Установка аминовой очистки газа
75	\N	0075	Установка адсорбционной очистки газа
76	\N	0076	Установка сжижения природного газа
77	\N	0101	Установка емкости сбора шлама
78	\N	0102	Здание компрессорной станции нефтяного газа
79	\N	0103	Здание цеха переработки нефтеконденсатной смеси
80	\N	0104	Установка выветривания и разделения нефти
82	\N	0106	Установка переработки нефти
84	\N	0108	Установка подготовки нефти
86	\N	0110	Установка производства моторных топлив
88	\N	0202	Здание регенерации гликоля
90	\N	0204	Здание регенерации метанола
92	\N	0206	Склад хлористого кальция
94	\N	0208	Установка дозирования ингибитора коррозии
96	\N	0210	Установка приготовления ингибитора коррозии
98	\N	0212	Установка регенерации метанола
100	\N	0214	Установка регенерации амина
102	\N	0302	Емкость дренажная факельной системы
104	\N	0304	Установка свечи рассеивания
106	\N	0306	Установка свечных сепараторов
108	\N	0308	Установка факельных сепараторов
110	\N	0310	Установка факельная горизонтальная (амбар факельный)
112	\N	0402	Скважина газоконденсатная
114	\N	0404	Скважина нефтяная
116	\N	0406	Установка емкостей задавочного раствора
118	\N	0408	Установка распределения газлифтного газа
120	\N	0410	Якорь скважинный
122	\N	0502	Блок-бокс насосной хлористого кальция
124	\N	0504	Здание насосной жидких химреагентов
126	\N	0506	Здание насосной конденсата и реагентов
128	\N	0508	Здание насосной моторных топлив
130	\N	0510	Здание насосной рассола
132	\N	0512	Здание насосной станции масел
134	\N	0514	Здание насосной ШФЛУ
136	\N	0516	Установка насосная дизельного топлива
138	\N	0518	Установка насосная конденсата
140	\N	0520	Установка насосная нефтепродуктов
142	\N	0522	Установка насосная реагентов
144	\N	0524	Установка насосная товарной нефти
146	\N	0602	Здание пункта распределения газа
148	\N	0604	Здание узлов редуцирования газа
150	\N	0606	Манифольдная дизельного топлива
152	\N	0608	Манифольдная метанола
154	\N	0610	Манифольдная ШФЛУ
156	\N	0612	Установка переключающей арматуры
158	\N	0614	Установка распределения газа
160	\N	0702	Газгольдер
162	\N	0704	Здание склада химреагентов
164	\N	0706	Резервуарный парк выветренного конденсата и бензиновой фракции аварийный
166	\N	0708	Резервуарный парк конденсата
168	\N	0710	Резервуарный парк моторных топлив
170	\N	0712	Резервуарный парк пластовой воды
172	\N	0714	Резервуарный парк ШФЛУ
174	\N	0716	Склад жидких химреагентов
176	\N	0718	Склад пропан-бутана технического
178	\N	0720	Склад темных нефтепродуктов
180	\N	0722	Установка аварийной емкости ШФЛУ
182	\N	0724	Установка дренажной емкости
184	\N	0726	Установка дренажной емкости бензина
186	\N	0728	Установка дренажной емкости керосина
188	\N	0730	Установка дренажной емкости метанола
190	\N	0732	Установка дренажной емкости нефти
192	\N	0734	Установка дренажной емкости рассола
194	\N	0736	Установка дренажных емкостей ДЭГа и метанола
196	\N	0738	Установка емкости теплоносителя
198	\N	0740	Установка емкостей сбора обессоленного гликоля
200	\N	0742	Установка емкости хранения ШФЛУ
202	\N	0744	Установка расходных емкостей бензина и дизельного топлива
204	\N	0746	Установка расходных емкостей ДЭГа
206	\N	0748	Установка расходных емкостей метанола
208	\N	0750	Установка расходных емкостей ТЭГа и конденсата
210	\N	0752	Установка резервуара - осветлителя
212	\N	0754	Установка резервуара гликоля
214	\N	0756	Установка резервуара теплоносителя
216	\N	0758	Установка резервуара траншейного
218	\N	0801	Газораздаточная станция
220	\N	0803	Стояк верхнего налива автоцистерн
222	\N	0805	Стояк слива и налива автоцистерн
224	\N	0807	Установка газозаправочных колонок
226	\N	0809	Установка нижнего слива из ж/д цистерн
228	\N	0811	Эстакада сливо-наливная железнодорожная
230	\N	0902	Блок-бокс замера нефти
232	\N	0904	Здание пункта измерения конденсата
234	\N	0906	Узел измерения расхода конденсата
236	\N	0908	Шкаф измерительной системы
81	\N	0105	Установка очистки сжиженных углеводородов
83	\N	0107	Установка печей цехов стабилизации конденсата и получения дизельного топлива
85	\N	0109	Установка подогревателя нефти
87	\N	0201	Здание приготовления ингибитора парафиноотложения
89	\N	0203	Здание регенерации ДЭГа
91	\N	0205	Здание регенерации ТЭГа
93	\N	0207	Установка АВО керосина
95	\N	0209	Установка дозирования химреагентов
97	\N	0211	Установка регенерации ДЭГа
99	\N	0213	Установка теплообменников керосина
101	\N	0301	Блок-бокс насосной станции факельной системы
103	\N	0303	Установка свечей с гидрозатвором
105	\N	0305	Установка свечи рассеивания и горизонтального факела
107	\N	0307	Установка сепараторов свечных и факельных
109	\N	0309	Установка факельная вертикальная
111	\N	0401	Скважина газовая
113	\N	0403	Скважина наблюдательная
115	\N	0405	Узел растворно-солевой
117	\N	0407	Установка исследования скважин
119	\N	0409	Установка фонтанной арматуры
121	\N	0501	Блок-бокс насосной метанола
123	\N	0503	Здание насосной ДЭГа
125	\N	0505	Здание насосной конденсата
127	\N	0507	Здание насосной метанола
129	\N	0509	Здание насосной пластовой воды
131	\N	0511	Здание насосной светлых нефтепродуктов
133	\N	0513	Здание насосной ТЭГа
135	\N	0515	Установка насосная антифриза
137	\N	0517	Установка насосная ДЭГа
139	\N	0519	Установка насосная метанола
141	\N	0521	Установка насосная откачки нефти
143	\N	0523	Установка насосная сырой нефти
145	\N	0601	Здание (площадка) переключающей арматуры
147	\N	0603	Здание пылеуловителей
149	\N	0605	Манифольдная ГСМ
151	\N	0607	Манифольдная конденсата
153	\N	0609	Манифольдная светлых нефтепродуктов
155	\N	0611	Установка кранов пускового контура
157	\N	0613	Установка подачи метанола и затворного газа
159	\N	0701	Блок-бокс хранения пенообразователя
161	\N	0703	Здание пункта сбора газа
163	\N	0705	Парк хранения СПГ
165	\N	0707	Резервуарный парк дизельного топлива
167	\N	0709	Резервуарный парк метанола
169	\N	0711	Резервуарный парк нефти аварийный
171	\N	0713	Резервуарный парк СУГ
173	\N	0715	Склад дизельного топлива
175	\N	0717	Склад конденсата газового стабильного
177	\N	0719	Склад сжиженных газов
179	\N	0721	Установка аварийной емкости
181	\N	0723	Установка аварийных емкостей конденсата
183	\N	0725	Установка дренажной емкости (конденсат, пластовая вода)
185	\N	0727	Установка дренажной емкости ДЭГа
187	\N	0729	Установка дренажной емкости масла
189	\N	0731	Установка дренажной емкости моторного топлива
191	\N	0733	Установка дренажной емкости подтоварной воды
193	\N	0735	Установка дренажных емкостей дизельного топлива
195	\N	0737	Установка емкости вакуум-сборника
197	\N	0739	Установка емкости сбора конденсата
199	\N	0741	Установка емкости хранения нефтеконденсатной смеси
201	\N	0743	Установка насосная пластовой воды
203	\N	0745	Установка расходных емкостей дизельного топлива
205	\N	0747	Установка расходных емкостей конденсата и моторных топлив
207	\N	0749	Установка расходных емкостей метанола и ВМР
209	\N	0751	Установка расходных емкостей амина
211	\N	0753	Установка резервуара - усреднителя
213	\N	0755	Установка резервуара сбора нефти
215	\N	0757	Установка резервуара товарной нефти
217	\N	0759	Установка технологических емкостей конденсата
219	\N	0802	Стендеры отгрузки СПГ и приема отпарного газа
221	\N	0804	Стояк верхнего слива из ж/д цистерн
223	\N	0806	Стояк слива и налива ж/д цистерн
225	\N	0808	Установка нижнего налива в ж/д цистерны
227	\N	0810	Эстакада сливо-наливная автомобильная
229	\N	0901	Блок-контейнер приборный
231	\N	0903	Здание пункта измерения расхода газа
233	\N	0905	Узел измерения расхода газа
630	\N	3754	Карьер торфа
235	\N	0907	Установка исследовательского сепаратора
237	\N	0921	Коммуникации по эстакадам
239	\N	0923	Сети внутриплощадочные
241	\N	0925	Сети внутриплощадочные масла
243	\N	0927	Сети внутриплощадочные пластовой воды
245	\N	0929	Участок внутриплощадочной открытой технологической сети
247	\N	1002	Блок-бокс очистки масла
249	\N	1004	Градирня холодильной установки
251	\N	1006	Здание маслохозяйства
253	\N	1008	Здание насосно-компрессорного отделения
255	\N	1010	Здание поста электрической централизации
257	\N	1012	Здание склада масел
259	\N	1014	Здание склада резервных двигателей ГПА
261	\N	1016	Трубопроводы технологические обвязки компрессорных агрегатов
263	\N	1018	Узел подключения КС
265	\N	1020	Установка АВО теплоносителя
267	\N	1022	Установка газоизмерительной станции
269	\N	1024	Установка замера конденсата
271	\N	1026	Установка компрессорная модульная
273	\N	1028	Установка компрессорная дожимная
275	\N	1030	Установка маслозаправочная
277	\N	1032	Установка охлаждения газа
279	\N	1034	Установка подготовки масла ГПА
281	\N	1036	Установка расходных емкостей масла
283	\N	1038	Участок внутриплощадочной сети ТХ (сети внутриплощадочные)
285	\N	1101	Газоизмерительная станция
238	\N	0922	Сети внеплощадочные
240	\N	0924	Сети внутриплощадочные диэтиленгликоля
242	\N	0926	Сети внутриплощадочные метанола
244	\N	0928	Участок внутриплощадочной подземной технологической сети
246	\N	1001	Блок-бокс откачки масла
248	\N	1003	Внутриплощадочные сети технологического газа
250	\N	1005	Установка дренажной емкости
252	\N	1007	Здание насосной масел
254	\N	1009	Здание операторной
256	\N	1011	Здание редуцирования топливного газа
258	\N	1013	Здание склада масел в таре
260	\N	1015	Здание цеха регенерации масла
262	\N	1017	Узел крановый
264	\N	1019	Установка АВО масла
266	\N	1021	Установка воздухосборника
268	\N	1023	Установка замера газа
270	\N	1025	Установка испарителя газа
272	\N	1027	Установка компрессорная мобильная
274	\N	1029	Установка компрессорных агрегатов
276	\N	1031	Установка опреснительная термическая
278	\N	1033	Установка очистки газа
280	\N	1035	Установка подготовки топливного пускового и импульсного газа
282	\N	1037	Установка регенерации масел
284	\N	1039	Шлейфы КС (входные и выходные) и перемычки между ними
286	\N	1102	Газораспределительная станция
287	\N	1103	Крановый узел
288	\N	1104	Линейная часть газопровода
289	\N	1105	Переход трубопровода через преграду (если переход выпускается не в составе всего газопровода)
290	\N	1106	Узел запуска и/или приема внутритрубных устройств
291	\N	1107	Узел защиты от превышения давления
292	\N	1108	Узел измерения расхода газа
293	\N	1109	Узел подключения ГИС
294	\N	1110	Узел редуцирования
295	\N	1111	Установка дозирования деэмульгатора
296	\N	1112	Участок газопровода-отвода
297	\N	1113	Участок трубопровода
298	\N	1151	Газопровод подключения КЦ
299	\N	1152	Газопроводы для подачи газа в продуктивные пласты
300	\N	1153	Газопроводы для транспортировки газа к эксплуатационным скважинам при газлифтном способе добычи
301	\N	1154	Газопроводы для транспортирования газа от ЦПС до сооружения магистрального транспорта газа
302	\N	1155	Газопроводы для транспортирования нефтяного газа
303	\N	1156	Газосборные коллекторы от обвязки газовых скважин (от кустов скважин)
304	\N	1157	Деэмульгаторопроводы
305	\N	1158	Нефтегазосборные трубопроводы
306	\N	1159	Нефтепроводы для транспортирования газонасыщенной или разгазированной обводненной или безводной нефти
307	\N	1160	Нефтепроводы для транспортирования товарной нефти от ЦПС до сооружения магистрального транспорта
308	\N	1161	Трубопроводы выкидные от нефтяных скважин
309	\N	2040	Септик
310	\N	1162	Трубопроводы для подачи очищенного газа и ингибитора
311	\N	1163	Трубопроводы между площадками отдельных объектов ПХГ
312	\N	1164	Трубопроводы ПХГ
313	\N	1165	Трубопроводы систем заводнения нефтяных пластов
314	\N	1166	Трубопроводы стабильного и нестабильного газового конденсата
315	\N	1167	Трубопроводы сточных вод
316	\N	1201	Блок-бокс вентиляционной камеры
317	\N	1202	Блок-бокс учета тепла
318	\N	1203	Венткамера вытяжная
319	\N	1204	Венткамера приточная
320	\N	1205	Установка нагревательная газовоздушная
321	\N	1206	Установка охлаждения воздуха
322	\N	1301	Блок-бокс узла редуцирования газа
323	\N	1302	Внутриплощадочные сети газоснабжения
324	\N	1303	Здание АВО газа
325	\N	1304	Станция газонаполнительная
326	\N	1305	Станция газораспределительная
327	\N	1401	Блок-бокс котельная
328	\N	1402	Блочная бойлерная
329	\N	1403	Здание котельной
330	\N	1404	Здание (установка) станции насосной теплофикационной
331	\N	1405	Здание (установка) станции утилизации тепла
332	\N	1406	Пункт тепловой
333	\N	1407	Камера тепловая
334	\N	1408	Пункт тепловой центральный
335	\N	1409	Теплообменник утилизационный
336	\N	1410	Труба дымовая
631	\N	3755	Карьер щебня
337	\N	1411	Установка водонагревательная емкостная газовая
339	\N	1413	Установка дренажных емкостей теплоагента
341	\N	1415	Установка узла нагрева
343	\N	1502	Установка емкостей сбора жидкого хладагента
345	\N	1504	Холодильник
347	\N	1602	Участок внутриплощадочной сети ТГС
349	\N	2002	Биологический пруд
351	\N	2004	Блок-бокс канализационной насосной установки
353	\N	2006	Блок-бокс учета сточных вод
355	\N	2008	Выпуск дренажных вод
357	\N	2010	Грязеотстойник (выгреб)
359	\N	2012	Емкость аварийная флотопены
361	\N	2014	Емкость дождевых стоков
363	\N	2016	Жироуловитель
365	\N	2018	Здание (установка) канализационной насосной станции промышленных сточных вод
367	\N	2020	Здание (установка) канализационной насосной станции взрывоопасных сточных вод
369	\N	2022	Здание (установка) канализационной насосной станции очищенных сточных вод
371	\N	2024	Здание (установка) насосной станции дренажных вод
373	\N	2026	Здание (установка) очистных сооружений сточных вод
375	\N	2028	Нейтрализатор промышленных сточных вод огневой
377	\N	2030	Отстойник производственных стоков
379	\N	2032	Площадка обслуживания очистных сооружений
381	\N	2034	Поле фильтрации
383	\N	2036	Пруд испарительный
385	\N	2038	Резервуар накопитель дождевых сточных вод
387	\N	2041	Септик-выгреб
389	\N	2043	Склад обезвоженного осадка
391	\N	2045	Сооружения обработки осадка отстойников
393	\N	2047	Установка очистки дождевых сточных вод
395	\N	2049	Установка биологических очистных
397	\N	2051	Установка насосная водяного конденсата
399	\N	2053	Установка очистки бытовых сточных вод
401	\N	2055	Установка флотационная
403	\N	2101	Блочно-комплектное устройство (установка) подготовки питьевой воды
405	\N	2103	Здание (установка) приготовления и розлива кондиционированной воды
407	\N	2105	Камера задвижек станции автоматического водяного охлаждения
409	\N	2107	Пункт водосборный
411	\N	2109	Станция комплексной электрокоагуляционной подготовки воды
413	\N	2111	Узел водомерный
415	\N	2113	Установка обработки промывных вод
417	\N	2115	Установка очистки воды
419	\N	2117	Фильтр-поглотитель
421	\N	2202	Блок-бокс учета воды
423	\N	2204	Водозабор
425	\N	2206	Здание (блок-бокс) насосной станции производственного водоснабжения
427	\N	2208	Здание (блок-бокс) насосной станции хозяйственно-производственного и противопожарного водоснабжения
429	\N	2210	Насосная станция 2-го подъема
431	\N	2212	Насосная станция водоснабжения
491	\N	3018	Установка получения гелия-сырца
433	\N	2214	Насосная станция оборотного водоснабжения
435	\N	2216	Насосная станция подкачки воды
437	\N	2218	Насосная станция циркуляционная
439	\N	2220	Резервуар артезианской воды
441	\N	2222	Резервуар запаса питьевой воды
443	\N	2224	Скважина водозаборная
445	\N	2226	Шахтный колодец
447	\N	2302	Блок-бокс модулей газового пожаротушения
449	\N	2304	Блочно-комплектная насосная станция пожаротушения
451	\N	2306	Гидрант
453	\N	2308	Здание обслуживания огнетушителей
455	\N	2310	Камера задвижек пенного пожаротушения
457	\N	2312	Резервуар запаса пенообразователя
459	\N	2314	Склад пенообразователя
461	\N	2317	Установка газового пожаротушения
463	\N	2319	Установка емкостей противопожарного запаса воды
465	\N	2321	Установка пожарного лафетного стационарного ствола
467	\N	2323	Установка узла управления паровой защиты технологических печей
469	\N	2402	Внеплощадочные сети водоснабжения
471	\N	2404	Внутриплощадочные сети водоснабжения
473	\N	2406	Внутриплощадочные сети канализации
475	\N	3002	Здание производственное РЭУ
477	\N	3004	Здание столярной мастерской
479	\N	3006	Здание цеха аппаратного линейного
481	\N	3008	Здание цеха промывочных жидкостей
483	\N	3010	Здание цеха энергоклинкера
485	\N	3012	Станция ацетиленовая
338	\N	1412	Установка водонагревательная резервуарная
340	\N	1414	Установка паротурбинная утилизационная
342	\N	1501	Здание цеха компримирования хладагента
344	\N	1503	Установка холодильная
346	\N	1601	Участок внеплощадочной сети ТГС
348	\N	2001	Бензоуловитель
350	\N	2003	Биотуалет
352	\N	2005	Блок-бокс обработки осадка
354	\N	2007	Блочно-комплектное устройство (установка) очистки сточных вод
356	\N	2009	Выпуск сточных вод
358	\N	2011	Емкость условно чистых стоков
360	\N	2013	Емкость бытовых сточных вод
362	\N	2015	Емкость промышленных сточных вод
364	\N	2017	Здание (установка) биологической очистки сточных вод
366	\N	2019	Здание (установка) канализационной насосной станции бытовых сточных вод
368	\N	2021	Здание (установка) канализационной насосной станции дождевых сточных вод
370	\N	2023	Здание (установка) канализационной насосной станции условно-чистых сточных вод
372	\N	2025	Здание (установка) насосной станции по закачке промышленных сточных вод в пласт
374	\N	2027	Коллектор канализационный
376	\N	2029	Отстойник пластовой воды
378	\N	2031	Площадка иловая
380	\N	2033	Площадка песковая
382	\N	2035	Полигон закачки
384	\N	2037	Пруд-испаритель
386	\N	2039	Резервуар очищенных сточных вод
388	\N	2042	Скважина поглощающая
390	\N	2044	Сооружение водопропускное
392	\N	2046	Сооружения очистные канализационные
394	\N	2048	Узел учета сточных вод
396	\N	2050	Установка доочистки сточных вод
398	\N	2052	Установка нефтеотделителя
400	\N	2054	Установка очистки промышленных сточных вод
402	\N	2056	Утилизатор промышленных сточных вод газовый
404	\N	2102	Здание (установка) очистки некондиционного рассола
406	\N	2104	Здание (установка) станции подготовки питьевой воды
408	\N	2106	Песколовка
410	\N	2108	Сооружения для повторного использования воды после промывки фильтров
412	\N	2110	Станция очистки воды
414	\N	2112	Установка водоподготовки
416	\N	2114	Установка охлаждения воды
418	\N	2116	Установка хлораторная
420	\N	2201	Башня водопроводная(водонапорная) стальная
422	\N	2203	Блочно-комплектная насосная станция хозяйственно-питьевого водоснабжения (здание)
424	\N	2205	Здание (блок-бокс) насосной станции пожаротушения
426	\N	2207	Здание (блок-бокс) насосной станции хозяйственно-питьевого водоснабжения
428	\N	2209	Насосная станция 1-го подъема
430	\N	2211	Насосная станция 3-го подъема
493	\N	3020	Установка приготовления антифриза
432	\N	2213	Насосная станция 1 подъема на водозаборных скважинах
434	\N	2215	Насосная станция подачи воды на ЦПС
436	\N	2217	Насосная станция противопожарного водоснабжения
438	\N	2219	Площадка обслуживания шкафов-укрытий горелок водонагревателей
440	\N	2221	Резервуар запаса воды для мойки
442	\N	2223	Резервуар хозяйственно-питьевого запаса воды
444	\N	2225	Установка емкостей для накопления воды
446	\N	2301	База рукавная
448	\N	2303	Блок-бокс пожарного инвентаря
450	\N	2305	Водоем пожарный
452	\N	2307	Здание газового пожаротушения
454	\N	2309	Здание склада пенообразователя
456	\N	2311	Модуль изотермический для жидкой двуокиси углерода
458	\N	2313	Резервуар противопожарного запаса воды
460	\N	2316	Установка аварийных агрегатов
462	\N	2318	Установка дозирования пенообразователя
464	\N	2320	Установка пенного пожаротушения
466	\N	2322	Установка порошкового пожаротушения
468	\N	2401	Внеплощадочные сети водоснабжения и канализации
470	\N	2403	Внеплощадочные сети канализации
472	\N	2405	Внутриплощадочные сети водоснабжения и канализации
474	\N	3001	Здание кислородной станции
476	\N	3003	Здание сварочного цеха
478	\N	3005	Здание укрупнительной сборки
480	\N	3007	Здание цеха переработки металлолома
482	\N	3009	Здание цеха стеклокремнезита
484	\N	3011	Полигон испытательный
486	\N	3013	Станция воздушно-азотная
488	\N	3015	Узел бетонно-растворный
490	\N	3017	Установка обработки серы
492	\N	3019	Установка получения серы
494	\N	3021	Установка приготовления хладагента
496	\N	3102	Блок-бокс мастерская
498	\N	3104	Здание аккумуляторной
500	\N	3106	Здание производственно-энергетического блока
502	\N	3108	Здание ремонта инклинометров
504	\N	3110	Здание ремонтно-испытательного пункта
506	\N	3112	Здание ремонтно-механической мастерской
508	\N	3114	Здание ремонтно-эксплуатационного блока
510	\N	3116	Здание службы добычи
512	\N	3118	Здание служебно-эксплуатационного блока
514	\N	3120	Здание цеха ремонта запорной арматуры
516	\N	3122	Площадка обслуживания резервуаров
518	\N	3124	Пост сварочный
520	\N	3126	Установка мойки контейнеров
522	\N	3128	Установка покрасочная
524	\N	3202	Автостанция
526	\N	3204	Автостоянка открытая с воздухообогревом для автомобильной и специальной техники
528	\N	3206	Здание автомобильной газонаполнительной компрессорной станции
530	\N	3208	Здание (площадка) мойки машин
532	\N	3210	Здание ТО и ТР спецтехники
534	\N	3212	Павильон АЗС
536	\N	3214	Установка взвешивания автомобилей
538	\N	3302	Блок-бокс для сушки одежды
540	\N	3304	Здание бани
542	\N	3306	Здание гостиницы
544	\N	3308	Здание душевой
546	\N	3310	Здание клуба
548	\N	3312	Здание комплекса психологической разгрузки
550	\N	3314	Здание магазина
552	\N	3316	Здание профилактория
554	\N	3318	Здание хлебопекарни
556	\N	3401	Дымокамера
558	\N	3403	Здание газодымозащитной службы
560	\N	3405	Здание пожарного депо
562	\N	3407	Переход через обвалование
564	\N	3409	Полоса препятствий
566	\N	3411	Пост пожарный временный
568	\N	3413	Установка учебной емкости
570	\N	3501	Здание геофизической службы
572	\N	3503	Лабораторный комплекс модульный
574	\N	3505	Пункт экологического контроля
576	\N	3507	Установка поверочная с блоком качества
578	\N	3602	Док
580	\N	3604	Емкость слива масла
582	\N	3606	Насосная станция ГСМ
584	\N	3608	Пирс
586	\N	3610	Площадка разгрузо-погрузочная
588	\N	3612	Причальное сооружение
590	\N	3614	Установка герметизированного налива автоцистерн
592	\N	3701	Блок-бокс хранения материалов и баллонов
594	\N	3703	Здание зернохранилища
487	\N	3014	Станция кислородная
489	\N	3016	Установка грануляции серы
495	\N	3101	Блок-бокс инженерного обеспечения
497	\N	3103	Здание аварийно-ремонтного пункта
499	\N	3105	Здание линейно-эксплуатационной службы
501	\N	3107	Здание пункта опорного
503	\N	3109	Здание ремонтной мастерской
505	\N	3111	Здание ремонтно-механического цеха
507	\N	3113	Здание ремонтно-строительного цеха
509	\N	3115	Здание сервисной службы
511	\N	3117	Здание служебно-ремонтно-эксплуатационного блока
513	\N	3119	Здание хозяйственного блока
515	\N	3121	Здание электроремонтного цеха
517	\N	3123	Площадка под агрегат для ремонта скважин
519	\N	3125	Установка зарядная углекислотная
521	\N	3127	Установка подсобных средств
523	\N	3201	Автопавильон
525	\N	3203	Автостоянка открытая
527	\N	3205	Гараж-стоянка
529	\N	3207	Здание автостоянки
531	\N	3209	Здание производственного корпуса
533	\N	3211	Операторная заправки автомашин
535	\N	3213	Топливозаправочный пункт
537	\N	3301	Беседка
539	\N	3303	Здание аптеки
541	\N	3305	Здание бани-прачечной
543	\N	3307	Здание детского сада
545	\N	3309	Здание киоска
547	\N	3311	Здание комбината бытового обслуживания
549	\N	3313	Здание общественного блока
551	\N	3315	Здание прачечной
553	\N	3317	Здание пункта здравоохранения
555	\N	3319	Здание столовой
557	\N	3402	Башня учебная пожарная
559	\N	3404	Здание газоспасательной станции
561	\N	3406	Огневая полоса психологической подготовки пожарных
563	\N	3408	Площадка с учебно-тренировочным устьем
565	\N	3410	Пост пожарный
567	\N	3412	Предохранительная подушка учебной башни
569	\N	3414	Щит пожарный
571	\N	3502	Здание лабораторного комплекса
573	\N	3504	Метеостанция
575	\N	3506	Сооружение геотехнического мониторинга
577	\N	3601	Выносное причальное устройство
579	\N	3603	Емкость аварийного слива топлива
581	\N	3605	Многоточечный причал
583	\N	3607	Одноточечный причал
585	\N	3609	Площадка для слива автоцистерн
587	\N	3611	Причал
589	\N	3613	Слип
591	\N	3615	Ящик грузозахватных приспособлений
593	\N	3702	Бункер мокрого хранения соли
595	\N	3704	Здание овощехранилища
596	\N	3705	Здание продуктового склада
597	\N	3706	Здание промтоварного склада
598	\N	3707	Здание ремонтно-складского блока
599	\N	3708	Здание склада взрывчатых материалов
600	\N	3709	Здание склада масел
601	\N	3710	Здание склада МТЦ неотапливаемое
602	\N	3711	Здание склада МТЦ отапливаемое
603	\N	3712	Здание склада пожарного назначения
604	\N	3713	Здание склада промышленных отходов
605	\N	3714	Здание склада радиоактивных источников
606	\N	3715	Здание склада химреагентов
607	\N	3716	Резервуар авиационного топлива
608	\N	3717	Резервуар хранения бензина
609	\N	3718	Резервуар хранения дизельного топлива
610	\N	3719	Резервуар хранения нефтепродуктов
611	\N	3720	Резервуарный парк масел
612	\N	3721	Склад ГСМ
613	\N	3722	Склад кислородных баллонов
614	\N	3723	Склад со стеллажами для хранения аварийного запаса труб
615	\N	3724	Склад масла в таре
616	\N	3725	Склад металлолома
617	\N	3726	Склад металлопроката
618	\N	3727	Склад МТЦ
619	\N	3728	Склад оборудования и техники
620	\N	3729	Склад одоранта
621	\N	3730	Склад серы
622	\N	3731	Склад соли
623	\N	3732	Склад труб
624	\N	3733	Стеллаж-эстакада для крупногабаритного оборудования
625	\N	3734	Установка расходных емкостей масел
626	\N	3735	Установка расходных емкостей моторных топлив
627	\N	3751	Дизбарьер
628	\N	3752	Животноводческая ферма
629	\N	3753	Карьер песка
632	\N	3756	Крытый загон для скота
634	\N	3758	Площадка компостирования
636	\N	3760	Приямок для каныги
638	\N	3762	Склад для костей
640	\N	3764	Теплица
642	\N	3801	Берегоукрепительное сооружение
644	\N	3803	Мол
646	\N	3805	Оградительное сооружение
648	\N	3852	Ресивер азота
650	\N	3854	Установка азотная передвижная
652	\N	3901	Внутриплощадочные сети воздухоснабжения
654	\N	3903	Ресивер воздуха
656	\N	3905	Установка воздушного обогрева автомобилей
658	\N	3907	Установка кислорододобывающая
660	\N	4001	Блок-бокс обогрева вахтенного персонала
662	\N	4003	Здание административное
664	\N	4005	Здание блока вспомогательных помещений
666	\N	4007	Здание общественных организаций
668	\N	4009	Здание технического надзора
670	\N	4011	Здание учебного назначения
672	\N	4013	Здание учебно-производственного корпуса
674	\N	4102	Вагон для проживания
676	\N	4104	Дом сторожа
678	\N	4106	Здание общежития
680	\N	4201	Блок-бокс КПП
682	\N	4203	Городок служебных собак
684	\N	4205	Зона запретная
686	\N	4207	Ограждение металлическое
688	\N	4209	Сооружение гражданской обороны защитное
690	\N	4211	Шлагбаум
692	\N	4302	Здание спортивного зала
694	\N	4401	Блок-бокс дизельной электростанции
696	\N	4403	Блок-бокс ЭХЗ
698	\N	4405	Здание производственно-энергетического блока
700	\N	4407	Здание электростанции газотурбинной
702	\N	4409	Установка парогазовая
704	\N	4502	Блок-бокс повышающего трансформатора
706	\N	4504	Блок-бокс разделительного трансформатора
708	\N	4506	Блок-бокс согласующего трансформатора
710	\N	4508	Блочно-комплектное закрытое распределительное устройство
712	\N	4510	Блок электротехнических сооружений
714	\N	4512	Здание закрытого распределительного устройства
716	\N	4514	Здание комплектной трансформаторной подстанции
718	\N	4516	Пункт усилительный необслуживаемый
720	\N	4518	Реакторная камера
722	\N	4520	Установка зарядная для электрокар
724	\N	4522	Установка разделительного трансформатора
726	\N	4601	Мачта осветительная
728	\N	4603	Молниеотвод
730	\N	4605	Установка заземляющего устройства
732	\N	4701	Участок внеплощадочной сети ЭТК
734	\N	4703	Участок линии электропередачи
736	\N	4802	Блок-контейнер радиооборудования
738	\N	4804	Здание телефонной станции
740	\N	4806	Кабельная линия связи
742	\N	4808	Мачта радиорелейная
744	\N	4810	Пост антенный
746	\N	4812	Сеть связи
748	\N	4814	Сеть фиксированной телефонной связи
750	\N	4816	Сеть видеотелефонной и видеоконференцсвязи
752	\N	4818	Сеть подвижной радиосвязи
754	\N	4820	Система видеотелефонной и видеоконференцсвязи
756	\N	4822	Система оповещения персонала о сигналах ГО и ЧС, радиофикации, громкоговорящей распорядительно-поисковой и двусторонней диспетчерской связи
758	\N	4824	Система связи совещаний
760	\N	4826	Система электрочасофикации
762	\N	4828	Участок внутриплощадочной сети СПБА
764	\N	4830	Локальная вычислительная сеть. Структурированная кабельная система
766	\N	4832	Внеплощадочные сети связи
768	\N	4861	Комплекс технических средств охраны
770	\N	4863	Система пожарной сигнализации, контроля загазованности и пожаротушения
772	\N	4865	Система пожарной сигнализации
774	\N	4867	Установка автоматическая пожарной сигнализации
776	\N	4903	Блок-контейнер операторная
778	\N	4905	Блок-контейнер телемеханики
780	\N	4907	Внутриплощадочные сети КИПиА
782	\N	4909	Здание КИПиА
784	\N	4911	Объекты АСУ ТП, КИПиА
786	\N	4913	Шкаф телемеханики
788	\N	5001	Ванна дезинфекции
790	\N	5003	Полигон ТКО
792	\N	5005	Установка термического обезвреживания
794	\N	5101	Участок внеплощадочной эстакады
796	\N	5201	Автодорога внутрипромысловая
633	\N	3757	Площадка для навоза
635	\N	3759	Поле орошения земледельческое
637	\N	3761	Птицеводческая ферма
639	\N	3763	Сооружение для разгрузки скота
641	\N	3765	Хозпостройка
643	\N	3802	Волнолом
645	\N	3804	Набережная
647	\N	3851	Внутриплощадочные сети азотоснабжения
649	\N	3853	Установка азотная
651	\N	3855	Установка редуцирования азота
653	\N	3902	Здание компрессорной станции сжатого воздуха
655	\N	3904	Установка воздуходувная
657	\N	3906	Установка компрессорной станции сжатого воздуха
659	\N	3908	Установка очистки воздуха
661	\N	4002	Здание административно-бытового корпуса
663	\N	4004	Здание блока бытовых помещений
665	\N	4006	Здание вычислительного центра
667	\N	4008	Здание рыбнадзора
669	\N	4010	Здание уборной
671	\N	4012	Здание инженерно-лабораторного корпуса
673	\N	4101	Блок-бокс жилой для рабочих
675	\N	4103	Дом жилой
677	\N	4105	Жилой модуль для ИТР
679	\N	4107	Зимовье
681	\N	4202	Вольер
683	\N	4204	Здание КПП
685	\N	4206	Ограждение железобетонное
687	\N	4208	Помещение караульное
689	\N	4210	Устройство противотаранное
691	\N	4301	Здание спортивно-оздоровительного комплекса
693	\N	4303	Площадка игровая
695	\N	4402	Блок-бокс электрообогрева
697	\N	4404	Здание низковольтного оборудования
699	\N	4406	Здание электростанции газопоршневой
701	\N	4408	Здание энергоблока
703	\N	4501	Блок-бокс гарантированного питания
705	\N	4503	Блок-бокс понижающего трансформатора
707	\N	4505	Блок-бокс РУ
709	\N	4507	Блочно-комплектная трансформаторная подстанция
711	\N	4509	Блочно-комплектное устройство электроснабжения линейных потребителей
713	\N	4511	Здание блока трансформаторных подстанций
715	\N	4513	Здание ЗРУ с операторной КИПиА
717	\N	4515	Здание преобразователей частоты
719	\N	4517	Пункт усилительный обслуживаемый
721	\N	4519	Трансформаторная подстанция
723	\N	4521	Установка оборудования высокочастотной обработки линии электропередачи
725	\N	4523	Установка согласующего трансформатора
727	\N	4602	Мачта прожекторная с молниеотводом
729	\N	4604	Установка глубинного заземлителя
731	\N	4606	Устройство частичного заземления нейтрали
733	\N	4702	Участок внутриплощадочной сети ЭТК
735	\N	4801	Блок-контейнер оборудования связи
737	\N	4803	Здание радиорелейной станции
739	\N	4805	Здание узла связи
741	\N	4807	Локальная вычислительная сеть
743	\N	4809	Опора антенная
745	\N	4811	Радиорелейная линия связи
747	\N	4813	Сеть диспетчерской связи
749	\N	4815	Сеть передачи данных
751	\N	4817	Сеть связи совещаний
753	\N	4819	Сеть передачи данных систем телемеханики
755	\N	4821	Система диспетчерской связи
757	\N	4823	Система промышленного видеонаблюдения
759	\N	4825	Система структурированная кабельная
761	\N	4827	Станция референцная
763	\N	4829	Система ТВ
765	\N	4831	Внутриплощадочные сети связи
767	\N	4833	Локальная система оповещения
769	\N	4862	Система контроля целостности газопровода
771	\N	4864	Система оповещения и управления эвакуацией людей при пожаре
773	\N	4866	Система пожарной сигнализации, оповещения и управления эвакуацией людей при пожаре
775	\N	4868	Установка автоматическая пожаротушения
777	\N	4904	Блок-контейнер САУ
779	\N	4906	Внеплощадочные сети КИПиА
781	\N	4908	Здание диспетчерского пункта
783	\N	4910	Кабельный канал КИПиА
785	\N	4912	Шкаф КИПиА (б/б САУ)
787	\N	4914	Шкаф САУ
789	\N	5002	Карты складирования отходов
791	\N	5004	Установка доочистки отходящих дымовых газов
793	\N	5006	Установка утилизации отходов ТКО
795	\N	5102	Участок внутриплощадочной эстакады
797	\N	5202	Автодорога зимняя
799	\N	5204	Аэродром
801	\N	5206	Галерея
798	\N	5203	Автодорога подъездная
800	\N	5205	Площадка посадочная для вертолетов
802	\N	5207	Дорога автомобильная лежневая
804	\N	5209	Закрытый переход
806	\N	5211	Здание железнодорожного депо
808	\N	5213	Мост
810	\N	5215	Путь дорожно-ремонтный
812	\N	5217	Сооружение берегоукрепительное
814	\N	5219	Тоннель
816	\N	5301	Подпорная стенка
818	\N	0077	Здание (установка) входных ниток и пробкоуловителей
820	\N	0311	Установка вертикальных факелов и горизонтального факела
822	\N	2057	Установка очистки дренажных вод
824	\N	2501	Внутренние системы водоснабжения и канализации
826	\N	2503	Внутренние системы канализации
828	\N	2701	Наружные сети канализации
830	\N	4410	Установка газотурбинных агрегатов
832	\N	4525	Блочно-комплектное устройство с пунктами автоматического регулирования напряжения
834	\N	4916	Блок-бокс узла подключения
836	\N	5008	Площадка временного хранения отходов
838	\N	5221	Переезды при пересечении газопроводом автодорог
840	\N	5303	Противоэрозионные сооружения
842	\N	4902	Автоматизированная система управления энергоснабжением (допускается применять аббревиатуру - АСУ Э)
803	\N	5208	Железнодорожный путь
805	\N	5210	Здание дорожно-ремонтного пункта
807	\N	5212	Лежачий полицейский
809	\N	5214	Переход через железную дорогу
811	\N	5216	Светофор
813	\N	5218	Станция железнодорожная
815	\N	5220	Эстакада досмотра автотранспорта
817	\N	5302	Переливная плотина
819	\N	0078	Здание печей стабилизации конденсата
821	\N	0525	Насосная резервуарного парка конденсата и метанола
823	\N	2407	Внутриплощадочные сети дренажа
825	\N	2502	Внутренние системы водоснабжения 
827	\N	2601	Наружные сети водоснабжения
829	\N	3951	Блок технологический АЗС
831	\N	4524	Электрощитовая
833	\N	4915	Автоматизированная информационно-измерительная система коммерческого учета электроэнергии (АИИС КУЭ)
835	\N	5007	Площадка для санобработки
837	\N	5009	Амбар-отстойник для проведения гидроиспытаний
839	\N	5222	Автопроезды площадок КС
841	\N	4901	Автоматизированная система управления технологическими процессами (допускается применять аббревиатуру - АСУ ТП)
\.


--
-- Data for Name: ref_building_group; Type: TABLE DATA; Schema: core; Owner: svcm
--

COPY ref_building_group (id, parent_id, code_range, name) FROM stdin;
1	\N	0001-0999	Производственные объекты основного назначения
2	\N	1001-1199	Объекты магистральных трубопроводов и компрессорных станций
3	\N	1201-1999	Объекты теплогазоснабжения и вентиляции
4	\N	2001-2999	Объекты водоснабжения и водоотведения
5	\N	3001-3999	Объекты вспомогательные
6	\N	4001-4399	Строительные объекты
7	\N	4401-4799	Электротехнические объекты
8	\N	4801-4899	Объекты инфраструктуры (системы противопожарной защиты, комплексы технических средств охраны, связь)
9	\N	4901-4999	Объекты КИП и А
10	\N	5001-5099	Объекты охраны окружающей среды
11	\N	5101-5199	Технологические коммуникации
12	\N	5201-5299	Объекты транспорта
13	\N	0001-0099	Объекты подготовки газа и конденсата
14	\N	0101-0199	Объекты подготовки и переработка нефти
15	\N	0201-0299	Объекты приготовления и регенерации абсорбентов
16	\N	0301-0399	Объекты факельного хозяйства
17	\N	0401-0499	Объекты обустройства скважин
18	\N	0501-0599	Объекты перекачки сред
19	\N	0601-0699	Объекты регулирования подачи сред
20	\N	0701-0799	Объекты сбора, хранения сред
21	\N	0801-0899	Объекты слива/налива сред
22	\N	0901-0919	Объекты замера и учёта продуктов
23	\N	0921-0939	Технологические сети и инженерные коммуникации
24	\N	1001-1099	Объекты компрессорных станций
25	\N	1101-1149	Объекты магистральных трубопроводов
26	\N	1151-1199	Объекты промысловых трубопроводов
27	\N	1201-1299	Объекты отопления, вентиляции и кондиционирования
28	\N	1301-1399	Объекты газоснабжения
29	\N	1401-1499	Объекты теплоснабжения
30	\N	1501-1599	Объекты холодоснабжения
31	\N	1601-1699	Сети ТГС наружние
32	\N	1701-1799	Система электрообогрева коммуникаций
33	\N	2001-2099	Объекты канализации
34	\N	2101-2199	Объекты водозабора и водоподготовки
35	\N	2201-2299	Объекты водоснабжения
36	\N	2301-2399	Объекты пожаротушения
37	\N	2401-2499	Наружные сети водоснабжения и канализации
38	\N	2501-2599	Внутренние системы водоснабжения и канализации
39	\N	2601-2699	Наружные сети водоснабжения
40	\N	2701-2799	Наружные сети канализации
41	\N	3001-3099	Производственные объекты
42	\N	3101-3199	Объекты обеспечения эксплуатации и ремонта
43	\N	3201-3299	Объекты обслуживания автотехники
44	\N	3301-3399	Объекты сферы обслуживания
45	\N	3401-3499	Объекты противопожарной защиты
46	\N	3501-3599	Объекты исследования и мониторинга
47	\N	3601-3699	Объекты обеспечения погрузки/разгрузки
48	\N	3701-3749	Объекты хранения
49	\N	3751-3799	Объекты подсобного хозяйства
50	\N	3801-3849	Объекты береговых сооружений оградительные и защитные
51	\N	3851-3899	Объекты технологии азота
52	\N	3901-3949	Объекты воздухоснабжения
53	\N	3951-3999	Объекты АЗС
54	\N	4001-4099	Объекты административные и бытовые
55	\N	4101-4199	Жилые сооружения
56	\N	4201-4299	Объекты режимные
57	\N	4301-4399	Объекты спортивно-оздоровительные
58	\N	4401-4499	Объекты силового электрооборудования
59	\N	4501-4599	Объекты электроснабжения, трансформаторные подстанции, распредустройства
60	\N	4601-4699	Объекты наружного электроосвещения, молниезащиты и заземления
61	\N	4701-4799	Линии электропередач воздушные и электротехнические коммуникации
62	\N	4801-4859	Объекты связи
63	\N	4861-4899	Объекты систем противопожарной защиты, комплексов технических средств охраны
\.


--
-- Data for Name: ref_chaptercode; Type: TABLE DATA; Schema: core; Owner: svcm
--

COPY ref_chaptercode (id, chaptercodetype_id, chapter, subchapter, code, name) FROM stdin;
1	\N	1	0	ПЗ	Пояснительная записка
2	\N	2	0	ПЗУ	Схема планировочной организации земельного участка
3	\N	3	0	АР	Архитектурные решения
4	\N	4	0	КР	Конструктивные и объемно-планировочные решения
5	\N	5	0	ИОС	Сведения об инженерном оборудовании, о сетях инженерно технического обеспечения, перечень инженерно-технических мероприятий, содержание технологических решений
6	\N	5	1	ИОС1	Система электроснабжения
7	\N	5	2	ИОС2	Система водоснабжения
8	\N	5	3	ИОС3	Система водоотведения
9	\N	5	4	ИОС4	Отопление, вентиляция и кондиционирование воздуха, тепловые сети
10	\N	5	5	ИОС5	Сети связи
11	\N	5	6	ИОС6	Система газоснабжения
12	\N	5	7	ИОС7	Технологические решения
13	\N	6	0	ПОС	Проект организации строительства
14	\N	7	0	ПОД	Проект организации работ по сносу или демонтажу объектов капительного строительства
15	\N	8	0	ООС	Перечень мероприятий по охране окружающей среды
16	\N	9	0	ПБ	Мероприятия по обеспечению пожарной безопасности
17	\N	10	0	ОДИ	Мероприятия по обеспечению доступа инвалидов
18	\N	10	0	ЭЭ	Мероприятия по обеспечению соблюдения требований энергетической эффективности и требований оснащенности зданий, строений и сооружений приборами учета используемых энергетических ресурсов
19	\N	11	0	СМ	Смета на строительство объектов капитального строительства
20	\N	12	0	ГОЧС	Иная документация в случаях, предусмотренных федеральными законами, в том числе: Перечень мероприятий по гражданской обороне, мероприятий по предупреждению чрезвычайных ситуаций природного и техногенного характера
21	\N	12	0	ДПБ	Декларация промышленной безопасности опасных производственных объектов
22	\N	12	0	ДБГ	Декларация безопасности гидротехнических сооружений
23	\N	12	0	ТБЭ	Требования к обеспечению безопасной эксплуатации объекта капитального строительства
24	\N	12	0	ОГ	Обоснование границ горного отвода
25	\N	12	0	ТЭП	Технико-экономические показатели
26	\N	12	0	МПБ	Мероприятия по обеспечению промышленной безопасности
27	\N	12	0	МТБ	Мероприятия по обеспечению техники безопасности
28	\N	12	0	КИТСО	Комплекс инженерно-технических средств охраны
29	\N	12	0	ИБ	Информационная безопасность
30	\N	12	0	ЭМС	Электромагнитная совместимость
31	\N	12	0	МЛА	Мероприятия по ликвидации возможных аварий при строительстве и эксплуатации объекта
32	\N	12	0	МО	Метрологическое обеспечение
33	\N	1	0	ПЗ	Пояснительная записка
34	\N	2	0	ППО	Проект полосы отвода
35	\N	3	0	ТКР	Технологические и конструктивные решения линейного объекта. Искусственные сооружения
36	\N	4	0	ИЛО	Здания, строения и сооружения, входящие в инфраструктуру линейного объекта
37	\N	5	0	ПОС	Проект организации строительства
38	\N	6	0	ПОД	Проект организации по сносу (демонтажу) линейного объекта
39	\N	7	0	ООС	Мероприятия по охране окружающей среды
40	\N	8	0	ПБ	Мероприятия по обеспечению пожарной безопасности
41	\N	9	0	СМ	Смета на строительство
42	\N	10	0	ГОЧС	Иная документация в случаях, предусмотренных федеральными законами, в том числе: Перечень мероприятий по гражданской обороне, мероприятий по предупреждению чрезвычайных ситуаций природного и техногенного характера
43	\N	10	0	ДПБ	Декларация промышленной безопасности опасных производственных объектов
44	\N	10	0	ДБГ	Декларация безопасности гидротехнических сооружений
45	\N	10	0	ТБЭ	Требования к обеспечению безопасной эксплуатации объекта капитального строительства
46	\N	10	0	ОГ	Обоснование границ горного отвода
47	\N	10	0	ТЭП	Технико-экономические показатели
48	\N	10	0	МПБ	Мероприятия по обеспечению промышленной безопасности
49	\N	10	0	МТБ	Мероприятия по обеспечению техники безопасности
50	\N	10	0	КИТСО	Комплекс инженерно-технических средств охраны
51	\N	10	0	ИБ	Информационная безопасность
52	\N	10	0	ЭМС	Электромагнитная совместимость
54	\N	10	0	МО	Метрологическое обеспечение
53	\N	10	0	МЛА	Мероприятия по ликвидации возможных аварий при строительстве и эксплуатации объекта
\.


--
-- Data for Name: ref_chaptercode_type; Type: TABLE DATA; Schema: core; Owner: svcm
--

COPY ref_chaptercode_type (id, short_name, name) FROM stdin;
\.


--
-- Data for Name: ref_constrpart; Type: TABLE DATA; Schema: core; Owner: svcm
--

COPY ref_constrpart (id, group_id, code, name) FROM stdin;
1	\N	005	Временные здания и сооружения
2	\N	006	Газопровод промысловый
3	\N	007	Газопровод промысловый замерного газа
4	\N	008	Газопровод магистральный
5	\N	009	Газопроводы газораспределительных систем
6	\N	010	Газопровод подключения
7	\N	011	Газопровод-отвод
8	\N	012	Газопровод-шлейф
9	\N	013	Газосборный пункт
10	\N	014	Глубинное анодное заземление
11	\N	015	Головные сооружения
12	\N	016	Головные сооружения газопровода
13	\N	017	Головные сооружения нефтепровода
14	\N	018	Завод газоперерабатывающий
15	\N	019	Завод конденсатоперерабатывающий
16	\N	020	Завод нефтеперерабатывающий
17	\N	021	Завод по сжижению природного газа
18	\N	022	Завод синтетических жидких топлив
19	\N	023	Завод стабилизации конденсата
20	\N	024	Здание (узел) переключающей арматуры
21	\N	025	Ингибиторопровод
22	\N	026	Ингибиторопровод промысловый
23	\N	027	Испытательный стенд
24	\N	028	Коллектор газосборный
25	\N	029	Коллектор газовый нагнетательный
26	\N	030	Коллектор нефтесборный
27	\N	031	Комплекс водорассольный
28	\N	032	Комплекс газохимический
29	\N	033	Конденсатопровод
30	\N	034	Конденсатопровод промысловый
31	\N	035	Конденсатопровод магистральный
32	\N	036	Конденсатопровод подключения
33	\N	037	Котлован стартовый
34	\N	038	Куст газовых скважин
35	\N	039	Куст нефтяных скважин
36	\N	040	Куст газоконденсатных скважин
37	\N	041	Куст скважин газовых нагнетательных
38	\N	042	Линейное производственное управление
39	\N	043	Манифольд кустовой
40	\N	044	Манифольд сборный
41	\N	045	Месторождение
42	\N	046	Метанолопровод промысловый
43	\N	047	Метанолопровод магистральный
44	\N	048	Метанолопровод подключения
45	\N	049	Морской технологический комплекс
46	\N	050	Насосная станция головная
47	\N	051	Нефтепровод промысловый
48	\N	052	Нефтепровод магистральный
49	\N	053	Нефтепровод подключения
50	\N	054	Опорный пункт
51	\N	055	Парк горючих жидкостей
52	\N	056	Парк (склад) метанола и жидких реагентов резервуарный
53	\N	057	Парк нефти резервуарный
54	\N	058	Парк резервуарный ЛВЖ
55	\N	059	Парк прирельсовый резервуарный
56	\N	060	Парк СУГ резервуарный
57	\N	061	Парк товарный центральный
58	\N	062	Парк ШФЛУ
59	\N	063	Площадка АВО газа
60	\N	064	Площадка аварийного запаса труб
61	\N	065	Площадка буртования грунта
62	\N	066	Площадка замера газа
63	\N	067	Площадка замера конденсата
64	\N	068	Площадка испытания
65	\N	069	Площадка кустов скважин
66	\N	070	Площадка монтажная
67	\N	071	Площадка приема сырьевого газа
68	\N	072	Площадка печей подогревателей нефти
69	\N	073	Площадка печей подогревателей газа
70	\N	074	Площадка (установка) подогревателей газа
71	\N	075	Площадка управления подводным добычным комплексом
72	\N	076	Площадка управления морским технологическим комплексом
73	\N	077	Продуктопровод промысловый
74	\N	078	Продуктопровод магистральный
75	\N	079	Продуктопровод подключения
76	\N	080	Пункт выдачи баллонов
77	\N	081	Пункт газораспределительный
78	\N	082	Пункт измерения расхода конденсата
79	\N	083	Пункт измерения расхода газа
80	\N	084	Пункт контроля загазованности
81	\N	085	Пункт сбора центральный
82	\N	086	Пункт учёта конденсата
83	\N	087	Пункт учета нефти
84	\N	088	Пункт хозрасчетного замера конденсата
85	\N	089	Сбор газа
86	\N	003	Береговой технологический комплекс
87	\N	004	Блок одоризации газа
88	\N	002	База кустовая сжиженного газа
89	\N	090	Сбор нефти
90	\N	091	Сборный пункт газа
91	\N	092	Сепаратор низконапорный
93	\N	094	Сеть газовая нагнетательная
95	\N	096	Скважина газовая
97	\N	098	Скважина наблюдательная
99	\N	100	Скважина нефтяная
101	\N	102	Склад сжиженных газов
103	\N	104	Склад углеводородов
105	\N	106	Склад хранения метанола
107	\N	108	Станция дожимная насосная
109	\N	110	Станция газонаполнительная
111	\N	112	Станция катодной защиты
113	\N	114	Станция компрессорная газлифтная
115	\N	116	Станция компрессорная дожимная
117	\N	118	Станция компрессорная закачки газа в пласт
119	\N	120	Станция компрессорная ПХГ
121	\N	122	Станция насосная кустовая
123	\N	124	Станция насосная подкачки
125	\N	126	Станция нефтеперекачивающая
127	\N	128	Терминал по приему (отгрузке) нефтесодержащих продуктов
129	\N	130	Трубопровод внутрипромысловый
131	\N	132	Трубопроводы выкидные
133	\N	134	Узел измерения, редуцирования и одоризации газа
135	\N	136	Узел защиты от превышения давления
137	\N	138	Узел коммерческого учета конденсата
139	\N	140	Узел подключения ГИС
141	\N	142	Узел подключения КС
143	\N	144	Узел редуцирования газа
145	\N	146	Установка выделения гелиевого концентрата
147	\N	148	Установка для сжигания газообразных продуктов
149	\N	150	Установка комплексной подготовки нефти
151	\N	152	Установка метанольная
153	\N	154	Установка (узел) одоризации газа
155	\N	156	Установка подготовки конденсата
157	\N	158	Установка подготовки газа деэтанизации
159	\N	160	Установка подготовки сырьевого газа
161	\N	162	Установка (узел) подогрева нефти
163	\N	164	Установка получения сжиженных углеводородов
165	\N	166	Установка предварительной сепарации нефти
167	\N	168	Установка комбинированная производства этан-этилена
169	\N	364	Станция радиорелейная узловая
171	\N	171	Хозяйство факельное
173	\N	173	Цех компрессорный
175	\N	175	Эстакада сливно-наливная
177	\N	201	Комплекс энергоутилизационный
179	\N	203	Линия электропередачи воздушная межплощадочная
181	\N	205	Площадка под блок-контейнер электроснабжения
183	\N	207	Пункт автоматического регулирования напряжения
185	\N	209	Установка газотурбинная - теплоэлектроцентраль
187	\N	211	Установка утилизации тепла
189	\N	213	Электроснабжение внешнее
191	\N	215	Электростанция газотурбинная
193	\N	251	Арык, открытый канал 
195	\N	253	Водовод (водопровод) и канализация межплощадочные
197	\N	255	Водовод (водопровод) межплощадочный
199	\N	257	Внутриплощадочные сети водоснабжения
201	\N	259	Емкость сезонного регулирования
203	\N	261	Канализационная насосная станция (блок-бокс)
205	\N	263	Коллектор канализационный
207	\N	265	Насосная питьевой воды
209	\N	267	Поля фильтрации
211	\N	269	Полигон захоронения твердых коммунальных отходов
213	\N	271	Полигон захоронения твердых коммунальных и промышленных отходов
215	\N	273	Пруд-испаритель
217	\N	275	Резервуары запаса противопожарной воды
219	\N	277	Резервуары-накопители производственных стоков
221	\N	279	Скважина водозабора
223	\N	281	Сеть водосборная
225	\N	283	Станция водоснабжения
227	\N	285	Станция насосная перекачки сточных вод
229	\N	287	Сооружения очистные канализационные
231	\N	301	Информационно-управляющая система диспетчерского управления
233	\N	303	Коммуникации внеплощадочные
235	\N	305	Коммуникации межпромысловые
237	\N	352	Корпус производственно-технической связи
239	\N	354	Линия связи кабельная
241	\N	356	Линия связи радиорелейная
243	\N	358	Опора антенная
245	\N	360	Пункт усилительный необслуживаемый
247	\N	362	Станция радиорелейная оконечная
249	\N	365	Станция связи базовая
251	\N	367	Узел связи
253	\N	401	Парк резервуарный азота
92	\N	093	Сеть водораспределительная подтоварной воды
94	\N	095	Система электрохимической защиты от коррозии
96	\N	097	Скважина газоконденсатная
98	\N	099	Скважина нагнетательная
100	\N	101	Склад серы
102	\N	103	Склад сжиженных углеводородов
104	\N	105	Склад химических реактивов
106	\N	107	Складское прирельсовое хозяйство
108	\N	109	Станция газоизмерительная
110	\N	111	Станция газораспределительная
112	\N	113	Станция компрессорная
114	\N	115	Станция компрессорная головная
116	\N	117	Станция компрессорная дожимная подводная
118	\N	119	Станция компрессорная нефтяного газа
120	\N	121	Станция насосная внешней перекачки конденсата
122	\N	123	Станция насосная подачи конденсата
124	\N	125	Станция насосная утилизационная
126	\N	127	Станция охлаждения газа
128	\N	129	Тоннель для прокладки трубопровода
130	\N	131	Трубопровод топливного газа
132	\N	133	Узел измерения расхода конденсата
134	\N	135	Узел запуска и/или приема внутритрубных устройств
136	\N	137	Узел коммерческого учета газа
138	\N	139	Узел крановый (линейный, охранный кран, краны на межсистемных перемычках)
140	\N	141	Узел подключения ДКС
142	\N	143	Узел подключения магистрального нефтепровода
144	\N	145	Узел улавливания жидкости
146	\N	147	Установка деэтанизации конденсата
148	\N	149	Установка комплексной подготовки газа
150	\N	151	Установка концевая сепарационная
152	\N	153	Установка низкотемпературной сепарации
154	\N	155	Установка очистки газа
156	\N	157	Установка подготовки конденсата к транспорту
158	\N	159	Установка подготовки нефти
160	\N	161	Установка (узел) подогрева конденсата
162	\N	163	Установка получения серы
164	\N	165	Установка предварительной подготовки газа
166	\N	167	Установка производства полиэтилена высокого давления
168	\N	169	Установка стабилизации конденсата
170	\N	170	Установка факельная горизонтальная
172	\N	172	Хранилище природного газа подземное
174	\N	174	Шлейфы ПХГ
176	\N	176	Шлангокабель
178	\N	202	Котельная
180	\N	204	Линия электропередачи кабельная межплощадочная
182	\N	206	Подстанция понизительная
184	\N	208	Сеть тепловая межплощадочная
186	\N	210	Установка парогазовая
188	\N	212	Установка утилизационная паротурбинная
190	\N	214	Электроснабжение линейных потребителей
192	\N	216	Электростанция собственных нужд
194	\N	252	Блок-боксы различного назначения (например, блок-бокс установки водоочистки)
196	\N	254	Водовод (водопровод) магистральный
198	\N	256	Внутриплощадочные сети водоснабжения и канализации
200	\N	258	Внутриплощадочные сети канализации
202	\N	260	Канализация внеплощадочная
204	\N	262	Каптаж
206	\N	264	Напорная плотина
208	\N	266	Площадка водозаборных сооружений
210	\N	268	Полигон подземного захоронения промышленных сточных вод
212	\N	270	Полигон захоронения твердых отходов
214	\N	272	Противопожарная насосная
216	\N	274	Резервуары питьевой воды
218	\N	276	Резервуары-накопители дождевых стоков
220	\N	278	Резервуары-накопители бытовых стоков
222	\N	280	Скважина поглощающая
224	\N	282	Сеть канализационная распределительная
226	\N	284	Станция насосная канализационная
228	\N	286	Сооружения очистные водопроводные
230	\N	289	Установка утилизации производственных и бытовых отходов
232	\N	302	Информационно-управляющая система производственными процессами
234	\N	304	Тепловые сети
236	\N	351	Кабель телемеханики
238	\N	353	Линия связи воздушная
240	\N	355	Линия связи магистральная
242	\N	357	Локальная вычислительная сеть производственно-хозяйственной деятельности
244	\N	359	Пункт диспетчерский центральный
246	\N	361	Станция радиорелейная
248	\N	363	Станция радиорелейная промежуточная
250	\N	366	Структурированные кабельные сети
252	\N	368	Учрежденческая телефонная станция
254	\N	402	Станция азотная
256	\N	404	Станция компрессорная воздушная
258	\N	451	Периметральное ограждение комплекса
260	\N	453	Пожарная часть
262	\N	455	Станция газоспасательная
264	\N	457	Укрытие противорадиационное
266	\N	502	Гостиничный комплекс
268	\N	504	Комплекс водолазно-медицинский
270	\N	506	Лабораторный комплекс
272	\N	508	Профилакторий, больница
274	\N	510	Центр учебный
276	\N	551	Аэродром
278	\N	553	Дорога автомобильная внутрипромысловая
280	\N	555	Дорога автомобильная межпромысловая
282	\N	557	Дороги автомобильные
284	\N	559	Площадка посадочная для вертолетов
286	\N	561	Порт речной
288	\N	563	Пункт дорожно-ремонтный
290	\N	565	Пункт топливно-заправочный
292	\N	567	Резервуарный парк дизельного топлива
294	\N	569	Склад ГСМ
296	\N	571	Склад ГСМ промежуточный
298	\N	573	Станция газозаправочная автомобильная
300	\N	575	Транспортный цех
302	\N	602	База геофизиков
304	\N	604	База дирекции
306	\N	606	База капитального ремонта скважин
308	\N	608	База рабочего снабжения
310	\N	610	База обеспечения морских операций
312	\N	612	База перевалочная
314	\N	614	База промысла опорная
316	\N	616	База ремонтно-восстановительного поезда (ж.д.)
318	\N	618	База ремонтно-строительного управления
320	\N	620	База стройиндустрии
322	\N	622	База эксплуатации
324	\N	624	Базовая станция
326	\N	626	Завод железобетонных изделий
328	\N	628	Завод рыбоводный
330	\N	630	Карьер гидронамывной
332	\N	632	Карьер песка
334	\N	634	Карьер торфа
336	\N	636	Комбинат теплично-овощной
338	\N	638	Комплекс рыбохозяйственный
340	\N	640	Нефтебаза
342	\N	642	Площадка временная накопительная
344	\N	644	Площадка временная под трубосварочную базу
346	\N	646	Площадка под базу временного хранения материально-технических ресурсов и оборудования централизованной поставки
348	\N	648	Площадка разворотная
350	\N	650	Площадка укрупненной сборки
352	\N	652	Предприятие мясоперерабатывающее
354	\N	654	Пункт аварийно-ремонтный
255	\N	403	Станция азотно-кислородная
257	\N	405	Станция кислородная
259	\N	452	Пожарное депо
261	\N	454	Пункт обеззараживания автомобильной техники
263	\N	456	Служба противофонтанная
265	\N	501	Административное здание
267	\N	503	Зона административно-бытовая
269	\N	505	Комплекс спортивно-оздоровительный
271	\N	507	Площадка управления магистральных газопроводов
273	\N	509	Центр административно-инженерный
275	\N	511	Храмовый комплекс
277	\N	552	Аэропорт
279	\N	554	Дорога автомобильная зимняя
281	\N	556	Дорога автомобильная подъездная
283	\N	558	Мастерская ремонтно-механическая
285	\N	560	Порт морской
287	\N	562	Предприятие автотранспортное
289	\N	564	Пункт ремонтно-испытательный
291	\N	566	Путь железнодорожный подъездной
293	\N	568	Сервис автодорожный
295	\N	570	Склад ГСМ базовый
297	\N	572	Станция автозаправочная
299	\N	574	Станция газонаполнительная автомобильная
301	\N	601	База бурения
303	\N	603	База горюче-смазочных материалов
305	\N	605	База заказчика
307	\N	607	База линейно-эксплуатационной службы
309	\N	609	База отдыха
311	\N	611	База опорная
313	\N	613	База переработки металлолома
315	\N	615	База ремонтно-восстановительного поезда (авто)
317	\N	617	База ремонтно-механическая
319	\N	619	База спецслужб
321	\N	621	База товарно-сырьевая
323	\N	623	База эксплуатации и сервисного обслуживания
325	\N	625	Завод асфальтобетонный
327	\N	627	Завод металлоконструкций
329	\N	629	Земледельческие поля орошения
331	\N	631	Карьер грунта
333	\N	633	Карьер песчано-гравийной смеси
335	\N	635	Карьер щебня
337	\N	637	Комплекс животноводческий
339	\N	639	Комплекс сельскохозяйственный
341	\N	641	Общераспространенные полезные ископаемые
343	\N	643	Площадка временная под административно-хозяйственную базу
345	\N	645	Площадка прирельсовая погрузочно-разгрузочная
347	\N	647	Площадка под базу временного хранения материально-технических ресурсов и оборудования поставки подрядчика
349	\N	649	Площадка складирования грузов
351	\N	651	Полигон испытательный
353	\N	653	Промбаза
355	\N	655	Пункт комплексный сборный
356	\N	656	Склад взрывчатых материалов
357	\N	657	Склад геофизических материалов
358	\N	658	Склад прирельсовый механизированный
359	\N	659	Узел растворобетонный
360	\N	660	Хозяйство оленеводческое
361	\N	661	Хозяйство прудовое
362	\N	662	Центр торгово-общественный
363	\N	701	Дом линейного обходчика
364	\N	702	Дом оператора
365	\N	703	Зимовье
366	\N	704	Комплекс жилой
367	\N	705	Комплекс жилой вахтовый
368	\N	706	Пункт обогрева
369	\N	707	Поселок жилой временный
370	\N	177	Платформа стационарная ледостойкая
371	\N	178	Блок-кондуктор ледостойкий
372	\N	179	Морская стационарная платформа
373	\N	180	Скважина, законченная с подводным устьевым оборудованием
374	\N	001	Комплекс термического обезвреживания жидких отходов
\.


--
-- Data for Name: ref_constrpart_group; Type: TABLE DATA; Schema: core; Owner: svcm
--

COPY ref_constrpart_group (id, code_range, name) FROM stdin;
1	001-200	Основное производство
2	201-250	Сооружения энергоснабжения
3	251-300	Сооружения водоснабжения, локализации стоков и твердых отходов
4	301-350	Технологические и инженерные коммуникации
5	351-400	Сооружения телекоммуникаций и связи
6	401-450	Сооружения обеспечения воздухом и продуктами его разделения
7	451-500	Сооружения обеспечения безопасности
8	501-550	Административные и бытовые сооружения
9	551-600	Сооружения транспорта
10	601-700	Базы 
11	701-750	Жилые комплексы
\.


--
-- Data for Name: ref_contractor; Type: TABLE DATA; Schema: core; Owner: svcm
--

COPY ref_contractor (id, name, customer_code) FROM stdin;
1	ГАЗПРОМ ИНВЕСТ ООО	001
2	ГАЗПРОМ ТРАНСГАЗ УФА ООО	002
3	ГАЗПРОМ ИНВЕСТ ЮГ ЗАО	003
4	ГАЗПРОМ ПОДЗЕМРЕМОНТ УРЕНГОЙ ООО	004
5	СЕВКАВНИПИГАЗ ОАО	005
6	ГАЗПРОМ ДОБЫЧА УРЕНГОЙ ООО	006
7	ЛЛОЙДС ЭНЕРДЖИ ООО	007
8	ВНИПИГАЗДОБЫЧА ПАО	008
9	ГАЗПРОМ ПРОМГАЗ АО	009
10	ГАЗПРОМ ДОБЫЧА ЯМБУРГ ООО	010
11	ГАЗПРОМ ЦЕНТРРЕМОНТ ООО	011
12	ГАЗПРОМ ДОБЫЧА НАДЫМ ООО	012
13	ГАЗПРОМ СПГ САНКТ-ПЕТЕРБУРГ ООО	014
14	ГИПРОСПЕЦГАЗ АО	015
15	ЯМАЛГАЗИНВЕСТ ЗАО	017
16	ГАЗПРОМ ПАО	018
17	ГАЗПРОМ ТРАНСГАЗ ТОМСК ООО	019
18	ГАЗПРОМ ДОБЫЧА ИРКУТСК ООО	020
19	ЦКБН АО	021
20	ОАО "Газпром трансгаз Беларусь"	024
21	ИНВЕСТСТРОЙ ООО	025
22	ГАЗПРОМ КОМПЛЕКТАЦИЯ ООО	026
23	ПОДЗЕМБУРГАЗ ПАО	027
24	ГАЗПРОМ ДОБЫЧА КУЗНЕЦК ООО	028
25	ГИПРОГАЗЦЕНТР АО	029
26	ГАЗПРОМ ГЕОТЕХНОЛОГИИ ООО	030
27	ТЮМЕННИИГИПРОГАЗ ООО	031
28	АЧИМГАЗ АО	032
29	ОсОО "Газпром Кыргызстан"	033
30	Nord Stream 2 AG	034
31	МЕССОЯХАНЕФТЕГАЗ АО	035
32	ТНГ-ГРУПП ООО	036
33	НИПИ НГ ПЕТОН ООО	037
34	ГАЗПРОМ СОЦИНВЕСТ ООО	038
35	ГАЗПРОМ ТРАНСГАЗ ВОЛГОГРАД ООО	039
36	ООО "Газпром трансгаз Екатеринбург"	040
37	ООО "Газпром трансгаз Казань"	041
38	ГАЗПРОМ ТРАНСГАЗ КРАСНОДАР ООО	042
39	ООО "Газпром трансгаз Махачкала"	043
40	ООО "Газпром трансгаз Москва"	044
41	ООО "Газпром трансгаз Н. Новгород"	045
42	ООО "Газпром трансгаз Самара"	046
43	ГАЗПРОМ ТРАНСГАЗ САНКТ-ПЕТЕРБУРГ ООО	047
44	ООО "Газпром трансгаз Саратов"	048
45	ГАЗПРОМ ТРАНСГАЗ СТАВРОПОЛЬ ООО	049
46	ООО "Газпром трансгаз Сургут"	050
47	ООО "Газпром трансгаз Ухта"	051
48	ООО "Газпром трансгаз Чайковский"	052
49	ООО "Газпром трансгаз Югорск"	053
50	ГАЗПРОМ ПЕРЕРАБОТКА ООО	054
51	ООО "Газпром ПХГ"	055
52	ГАЗПРОМ ДОБЫЧА АСТРАХАНЬ ООО	056
53	ГАЗПРОМ ДОБЫЧА КРАСНОДАР ООО	057
54	ГАЗПРОМ ДОБЫЧА НОЯБРЬСК ООО	058
55	ГАЗПРОМ ДОБЫЧА ОРЕНБУРГ ООО	059
56	ОАО "Севернефтегазпром"	060
57	Сибирское ордена "Знак Почета" открытое акционерное общество по проектированию и изысканиям объектов	061
58	МОСОБЛГАЗ ГУП МО	062
59	НОВАТЭК-ТАРКОСАЛЕНЕФТЕГАЗ, ООО	063
60	СЭУ ООО	064
61	АДМИНИСТРАЦИЯ БЕЛОКАЛИТВИНСКОГО РАЙОНА	065
62	ЗАО "Ижорский трубный завод"	066
63	Общество с ограниченной ответственностью «Газпром газомоторное топливо»	067
64	ИНК ООО	068
65	КРАСНОЯРСКГАЗПРОМ НЕФТЕГАЗПРОЕКТ ООО	069
66	ВОЛГОГРАДНЕФТЕМАШ ОАО	070
67	ЭЛВЕСТ ООО	071
68	ООО «Шахтоуправление «Майское»	076
69	ГИПРОКИСЛОРОД АО	077
70	ВНИПИГАЗДОБЫЧА ПАО	078
71	ВНИПИГАЗДОБЫЧА ПАО, НОВОСИБИРСКИЙ ФИЛИАЛ	079
72	"Институт "ИМИДИС",ООО	080
\.


--
-- Data for Name: ref_developer; Type: TABLE DATA; Schema: core; Owner: svcm
--

COPY ref_developer (id, code, name) FROM stdin;
1	0001	Санкт-Петербургcкий филиал
2	0002	Московский филиал
3	0003	Нижегородский филиал
4	0004	Саратовский филиал
5	0005	Ставропольский филиал
6	0006	Оренбургский филиал
7	0007	Тюменский филиал
8	0008	Новосибирский филиал
9	0009	Подольский филиал
10	0010	Махачкалинский филиал
11	0011	Уренгойский филиал
12	0012	Тюменский экспериментальный завод
\.


--
-- Data for Name: ref_doccode; Type: TABLE DATA; Schema: core; Owner: svcm
--

COPY ref_doccode (id, code, name, additional, numeric_part) FROM stdin;
1	СО	Спецификация оборудования, изделий и материалов	f	t
2	Н	Эскизный чертежобщего виданетипового изделия	f	f
3	И	Рабочий чертеж строительного изделия	f	f
4	ОЛ	Опросный лист	f	f
5	ГЧ	Габаритный чертеж	f	f
6	ЛС	Локальная смета	f	f
7	РР	Расчеты	f	f
8	ВР	Ведомость объемов строительныхи монтажных работ	t	f
9	СЗС	Сводные заказные спецификации	t	f
10	КЗ	Карта заказана систему телемеханики	t	f
\.


--
-- Data for Name: ref_mark; Type: TABLE DATA; Schema: core; Owner: svcm
--

COPY ref_mark (id, code, name, comment, additional) FROM stdin;
1	ТХ	Технология производства		f
2	ТК	Технологические коммуникации	При объединении рабочих чертежей всех технологических коммуникаций	f
3	ГТ	Генеральный план и сооружения транспорта	При объединении рабочих чертежей генерального плана и сооружений транспорта	f
4	ГП	Генеральный план		f
5	АР	Архитектурные решения		f
6	АС	Архитектурно-строительные решения	При объединении рабочих чертежей архитектурных и конструктивных решений (кроме КМ)	f
7	АИ	Интерьеры		f
8	КЖ	Конструкции железобетонные		f
9	КМ	Конструкции металлические		f
10	КМД	Конструкции металлические деталировочные		f
11	КД	Конструкции деревянные		f
12	ВК	Внутренние системы водоснабжения и канализации		f
13	ОВ	Отопление, вентиляция и кондиционирование		f
14	ТМ	Тепломеханические решения	Котельных, ТЭЦ и т.п.	f
15	ВС	Воздухоснабжение		f
16	ПУ	Пылеудаление		f
17	ХС	Холодоснабжение		f
18	ГСВ	Газоснабжение (внутренние устройства)		f
19	ЭМ	Силовое электрооборудование		f
20	ЭО	Электрическое освещение (внутреннее)		f
21	РТ	Радиосвязь, радиовещание и телевидение		f
22	ПТ	Пожаротушение		f
23	ПС	Пожарная сигнализация		f
24	ОС	Охранная сигнализация		f
25	ГР	Гидротехнические решения		f
26	АЗ	Антикоррозионная защита конструкций зданий, сооружений		f
27	АЗО	Антикоррозионная защита технологических аппаратов, газоходов и трубопроводов		f
28	ТИ	Тепловая изоляция оборудования и трубопроводов		f
29	АД	Автомобильные дороги		f
30	ПЖ	Железнодорожные пути		f
31	ТР	Сооружения транспорта	При объединении рабочих чертежей автомобильных, железных и других дорог	f
32	НВК	Наружные сети водоснабжения и канализации	При объединении рабочих чертежей наружных сетей водоснабжения и канализации	f
33	НВ	Наружные сети водоснабжения		f
34	НК	Наружные сети канализации		f
35	ТС	Тепломеханические решения тепловых сетей		f
36	ГСН	Наружные газопроводы		f
37	ЭН	Наружное электроосвещение		f
38	ЭС	Электроснабжение		f
39	АК	Автоматизация комплексная	При объединении рабочих чертежей различных технологических процессов и инженерных систем	f
40	АТХ	Системы автоматизации технологических процессов (контроль и регулирование технологических параметров, системы автоматизированного управления технологическим процессом (АСУТП), диспетчеризация технологического процесса, автоматизация узла, установки)	Наименование основного комплекта и марки принято по ГОСТ 21.408, приложение А	f
41	АПУ	Автоматизация систем пылеудаления	Наименование основного комплекта и марки принято по ГОСТ 21.408, приложение А	f
42	АОВ	Автоматизация систем отопления, вентиляции и кондиционирования	Наименование основного комплекта и марки принято по ГОСТ 21.408, приложение А	f
43	АВК	Автоматизация систем водоснабжения и канализации	Наименование основного комплекта и марки принято по ГОСТ 21.408, приложение А	f
44	АНВ	Автоматизация наружных систем водоснабжения (насосные станции, системы оборотного водоснабжения)	Наименование основного комплекта и марки принято по ГОСТ 21.408, приложение А (при разделении основного комплекта марки АНВК)	f
45	АНК	Автоматизация наружных систем канализации	Наименование основного комплекта и марки принято по ГОСТ 21.408, приложение А (при разделении основного комплекта марки АНВК)	f
46	АНВК	Автоматизация наружных систем водоснабжения и канализации	Наименование основного комплекта и марки принято по ГОСТ 21.408, приложение А	f
47	АГСВ	Автоматизация систем газоснабжения (внутренние устройства)	Наименование основного комплекта и марки принято по ГОСТ 21.408, приложение А	f
48	АГСН	Автоматизация систем газоснабжения (наружные устройства и сети)	Наименование основного комплекта и марки принято по ГОСТ 21.408, приложение А	f
49	КСМТР	Заявки на пополнение справочника МТР		t
50	АТМТС	Автоматизация тепломеханических решений тепловых сетей	Наименование основного комплекта и марки принято по ГОСТ 21.408, приложение А	f
52	АПТ	Автоматизация систем пожаротушения, дымоудаления	Наименование основного комплекта и марки принято по ГОСТ 21.408, приложение А	f
54	АВС	Автоматизация систем воздухоснабжения	Наименование основного комплекта и марки принято по ГОСТ 21.408, приложение А	f
56	СС	Проводные средства связи внутренних сетей предприятий и организаций	ГОСТ Р 21.1703	f
58	АОК	Автоматизация обогрева коммуникаций		t
60	ЭТА	Автоматизация электротехнической части		t
62	АСКУЭ	Автоматизированная система коммерческого учета электроэнергии		t
64	ЭАК	Автоматизированная система контроля показателей качества электроэнергии		t
66	АСУПХД	Автоматизированная система управления производственно-хозяйственной деятельностью		t
68	АСУТП	Автоматизированная система управления технологическими процессами		t
70	АСУЭС	Автоматизированная система управления электроснабжением		t
72	АСУ	Автоматизированные системы управления		t
74	АПС	Автоматическая пожарная сигнализация		t
76	АТС	Автоматическая телефонная станция		t
78	СПА	Автоматические системы пожарной сигнализации, контроля загазованности, пожаротушения и оповещения (АСПС, КЗ, ПТиО)		t
80	АН	Анализ		t
82	БСН	Бурение наблюдательных скважин		t
84	ЭС1	Внешнее электроснабжение		t
86	ВП	Водопонижение		t
88	ЭТВ	Вторичная коммутация, схемы внешних соединений		t
90	ГЗТ	Газовое тушение		t
92	ГТД	Геолого-технологические данные		t
94	ГТП	Геотехнический паспорт		t
96	ГОС	Гидрогеологическое обоснование закачки промстоков		t
98	ПД	Декларация пожарной безопасности		t
100	ДИМО	Диспетчеризация. Информационно математическое обеспечение		t
102	ДС	Диспетчерская связь		t
104	ЗИО	Заводские испытания АСУ на объекте		t
106	ЭЗ	Защита релейная		t
108	ЗССТ	Земная станция спутникового телевидения и радиовещания		t
110	ИЗ	Изыскания		t
112	ИР	Инженерные расчеты		t
114	ИМ	Инженерный мониторинг		t
116	ИБ	Информационная безопасность		t
118	ИМО	Информационно-математическое обеспечение		t
120	ИТ	Информационные технологии		t
122	КТМ	Картографические материалы		t
124	КР	Конструктивные и объемно-планировочные решения		t
126	КО	Коррозионное обследование		t
128	МК	Коррозионный мониторинг		t
130	ТЛ	Линейная часть магистрального трубопровода (в том числе трубопроводы-отводы)		t
132	ЭК	Линии электропередач кабельные		t
134	ЛВС	Локальная вычислительная сеть		t
136	ММО	Магнитометрическое обследование		t
138	МО	Математическое обеспечение		t
140	МК	Междугородный коммутатор		t
142	МЛА	Мероприятия по ликвидации возможных аварий при строительстве (реконструкции) и эксплуатации объектов		t
144	МЕО	Метрологическое обеспечение		t
146	ЭГ	Молниезащита и заземление		t
148	НД	Наружный дренаж		t
150	НП	Нормативы природопользования		t
152	ОЗС	Обследование несущих строительных конструкций зданий и сооружений		t
154	ОБС	Объектовая охранная сигнализация		t
156	КЖОГ	Ограждение площадки для ЦРРЛ связи, ГРС, ГИС		t
158	СОП	Оповещение о пожаре		t
160	ОДД	Организация дорожного движения		t
162	ТМР	Организация радиосвязи для системы ТМ		t
164	ОФ	Основания и фундаменты		t
166	ОТС	Оценка технического состояния трубопроводов		t
168	ПСП	Первичные средства пожаротушения		t
170	ПП	Перечень параметров		t
172	ПЛА	План ликвидации аварий		t
174	ПССТВ	Приемная станция спутникового телевидения и радиовещания		t
176	ПНВ	Программа наблюдения за водными объектами		t
178	ПТИ	Программно-техническая инфраструктура		t
51	АТМ	Автоматизация тепломеханических решений котельных	Наименование основного комплекта и марки принято по ГОСТ 21.408, приложение А	f
53	АХС	Автоматизация систем холодоснабжения	Наименование основного комплекта и марки принято по ГОСТ 21.408, приложение А	f
55	АЭС	Автоматизация систем электроснабжения	Наименование основного комплекта и марки принято по ГОСТ 21.408, приложение А	f
57	АТН	Автоматизация нефтяной технологии		t
59	АХД	Автоматизация производственно-хозяйственной и финансово-экономической деятельности		t
61	ЭА	Автоматизация энергоснабжения		t
63	АСКУЭР	Автоматизированная система комплексного учета энергоресурсов		t
65	АСУПТК	Автоматизированная система управления производственно-технологическими процессами		t
67	АСУРМ	Автоматизированная система управления разработкой месторождения		t
69	АСУФЭД	Автоматизированная система управления финансово-экономической деятельностью		t
71	АСУЭ	Автоматизированная система управления энергоснабжением		t
73	АТ	Автоматика и телемеханика		t
75	АПЗ	Автоматическая противопожарная защита		t
77	АКТС	Автоматически коммутируемая телефонная сеть		t
79	АЗП	Азотопровод		t
81	АСТ	Архитектурно-строительные конструкции трубопроводов и вдольтрассовых сооружений		t
83	БС	Бурение скважин		t
85	ЭС2	Внутриплощадочное электроснабжение		t
87	ВПК	Водопропускной коллектор		t
89	СВЛ	Высокочастотная связь по ЛЭП		t
91	ГХ	Геолого-промысловая характеристика		t
93	ГТМ	Геотехнический мониторинг		t
95	ГОВ	Гидрогеологическое обоснование водоснабжения		t
97	ГОЗ	Гидрогеологическое обоснование утилизации захоронения сточных вод		t
99	ДР	Дизайнерские решения		t
101	ДТО	Диспетчеризация. Техническое обеспечение		t
103	ДК	Дренажная канализация		t
105	ЗИПП	Заводские испытания АСУ на полигоне поставщика		t
107	ЗВОС	Заявление о воздействии на окружающую среду		t
109	ЗССС	Земная станция спутниковой связи		t
111	ИГТМ	Инженерно-геотехнический мониторинг		t
113	ИНЖД	Инженерный дизайн		t
115	ИАСУТП	Интегрированная автоматизированная система управления технологическими процессами		t
117	ИО	Информационное обеспечение		t
119	ИУС	Информационно-управляющие системы		t
121	КЛС	Кабельные линии связи		t
123	КТСО	Комплекс технических средств охраны		t
125	КЗ	Контроль загазованности		t
127	КИ	Коррозионные изыскания и исследования		t
129	ЛВ	Ливневая канализация		t
131	ЭВ	Линии электропередач воздушные		t
133	ЛС	Линия связи		t
135	ЛСО	Локальная система оповещения		t
137	МС	Маслохозяйство		t
139	МОЗ	Материалы к отводу земель		t
141	МСС	Межстанционные системы связи		t
143	МПАР	Методические подходы и алгоритмы расчетов		t
145	МКСС	Микросотовая система связи		t
147	НПТ	Наружные сети автоматического газового пожаротушения		t
149	НДС	Нормативы допустимых сбросов		t
151	ОНСК	Обследование несущих строительных конструкций зданий и сооружений		t
153	ОР	Общесистемные решения		t
155	ОГ	Ограждение площадки		t
157	ЭУ	Оперативное управление электроснабжением		t
159	ОРО	Организационное обеспечение		t
161	ТМК	Организация КЛС для системы ТМ		t
163	ЭОЗМ	Освещение, заземление, молниезащита		t
165	ТГС	Отопление, вентиляция и кондиционирование воздуха, тепловые сети		t
167	ЭТП	Первичная коммутация		t
169	ПССС	Перевозимая станция спутниковой связи		t
171	ПРОС	Периметральная охранная сигнализация		t
173	ПЭ	Предложения по эксплуатации		t
175	ПМИ	Программа и методика испытаний АСУ		t
177	ПО	Программное обеспечение		t
179	ПНООЛР	Проект нормативов образования отходов и лимитов на их размещение		t
180	ПДВ	Проект нормативов предельно-допустимых выбросов		t
182	ППО	Проект полосы отвода		t
184	БСП	Проекты бурения поглощающих и наблюдательных скважин		t
186	ПХД	Производственно-хозяйственная деятельность		t
188	ПРТ	Промышленное телевидение		t
190	РРС	Радиорелейная станция		t
192	РТС	Радиотелефонная связь		t
194	РСП	Расчет на статистическую прочность		t
196	РПТС	Расчет показателей технического состояния эксплуатируемых объектов		t
198	РСБЭ	Расчет срока безопасной эксплуатации		t
200	РЧ	Расчет численности		t
202	ЗТС	Резервная телефонная связь		t
204	РЗ	Рекультивация нарушенных земель		t
206	СЗЗ	Санитарно-защитная зона		t
208	ССО2	Сборник спецификаций материалов подрядчика		t
210	ССО3	Сборник спецификаций оборудования, не требующего монтажа		t
212	СВС	Связь совещаний		t
214	СПРС	Сеть подвижной радиосвязи		t
216	САРД	Система абонентского радиодоступа		t
218	ВКС	Система видеоконференцсвязи		t
220	СЗИ	Система защиты информации		t
222	СКД	Система контроля и управления доступом		t
224	СМЦ	Система мониторинга целостности		t
226	СОДУ	Система оперативно-диспетчерского управления		t
228	СОТ	Система охранная телевизионная		t
230	СПСС	Система передачи системы связи		t
232	СПБА	Система пожарной безопасности. Автоматизация		t
234	ССД	Система связи дальняя		t
236	ССС	Система спутниковой связи		t
238	АТТ	Система телемеханики		t
240	ССР	Системно-сетевые решения		t
242	САЗ	Средства антитеррористической защиты		t
244	СИС	Статические испытания свай		t
246	КЖСС	Строительная часть для ИСОБ (КТСО)		t
248	АССД	Строительная часть для кабельной линии связи		t
250	АСЭВ	Строительная часть для электроснабжения		t
252	СКС	Структурированная кабельная система		t
254	ТЛМ	Телемеханика производственная		t
256	РТГС	Теплогидравлический расчет систем		t
258	ТМЭ	Тепломеханическая часть электростанций		t
260	ТНО	Теплотехнологическое и нестандартное оборудование		t
262	ТЭП	Технико-экономические показатели		t
264	ТТ	Технические требования		t
266	ТВЗ	Технология водозаборной станции		t
268	ТВР	Технология водо-рассольного комплекса		t
270	ТГ	Технология газовая		t
272	ТХГП	Технология газотранспортных производств		t
274	ТН	Технология нефтяная		t
276	Л	Технология трубопроводного транспорта		t
278	УРИРГ	Узел редуцирования и измерения расхода газа		t
280	УЭ	Учет электроэнергии		t
282	ФТС	Фиксированная телефонная связь		t
284	ХЛ	Химическая лаборатория		t
286	ЦДС	Центральная диспетчерская связь		t
288	ЭМС	Электромагнитная совместимость		t
181	ПОС	Проект организации строительства		t
183	БСВ	Проекты бурения водозаборных и наблюдательных скважин		t
185	БСЭ	Проекты бурения скважин для электрохимзащиты		t
187	ПЭМ	Производственный экологический мониторинг		t
189	РРЛ	Радиорелейная линия связи		t
191	УКВ	Радиосвязь УКВ		t
193	РВ	Разделительная ведомость		t
195	РПН	Расчет показателей надежности проектируемых объектов		t
197	РПТР	Расчет потребности в трудовых ресурсах		t
199	РСК	Расчет строительных конструкций		t
201	РГ	Расчеты гидравлические		t
203	РПХГ	Реконструкция ПХГ		t
205	РК	Ручной коммутатор		t
207	СК	Сантехнические коммуникации	При объединении рабочих чертежей отдельных комплектов сантехнических коммуникаций (НВК+ТС+ГСН) или другом сочетании	t
209	ССО1	Сборник спецификаций оборудования заказчика		t
211	ССП	Связь и сигнализация на промышленной площадке		t
213	ЭЛ	Сети электроснабжения, кабельное хозяйство		t
215	СРФС	Сеть референцных станций		t
217	СБ	Система безопасности		t
219	ВН	Система видеонаблюдения (видеоконтроля)		t
221	СКТ	Система кабельного телевидения		t
223	СМОН	Система мониторинга		t
225	НУМ	Система нумерации		t
227	СОМ	Система освещения мачт		t
229	СПД	Система передачи данных		t
231	СПБ	Система пожарной безопасности		t
233	СПБС	Система пожарной безопасности. Связь		t
235	ССКТ	Система спутникового и кабельного телевидения		t
237	СТМ	Система телемеханизации		t
239	СУ	Система управления		t
241	СП	Ситуационный план		t
243	СТСС	Станция спутниковой связи		t
245	СПТ	Стационарные системы внутреннего и наружного пожаротушения		t
247	АССС	Строительная часть для ИСОБ (КТСО) для КП ТЛМ и УКЗ, УКВ		t
249	АСТМ	Строительная часть для КП ТЛМ и УКЗ, УКВ		t
251	АСЭК	Строительная часть КТП, реклоузер		t
253	ТСС	Тактовая сетевая синхронизация		t
255	ТЛН	Теленаблюдение		t
257	РТГУ	Теплогидравлический расчет узлов и оборудования		t
259	ТОПР	Теплотехническое обоснование проектных решений		t
261	ТСГ	Термостабилизация грунтов		t
263	ТЕР	Технические решения		t
265	ТХР	Технологический регламент		t
267	ТВОС	Технология водопроводной очистной станции		t
269	ТХВ	Технология вспомогательных производств		t
271	ТХГ	Технология газораспределительных станций		t
273	ТКС	Технология канализационных очистных сооружений		t
275	ТП	Технология предприятий металлообработки и ремонта		t
277	РС	Транкинговая связь		t
279	УС	Узел связи		t
281	УЭР	Учет энергоресурсов		t
283	ХЗ	Химическая защита		t
285	ЦОД	Центр обработки данных		t
287	Щ	Щит автоматики		t
289	ЭОБ	Электрообогрев	В эту марку входит электрообогрев коммуникаций; технологического оборудования и резервуаров; полов открытых площадок, лестниц и пандусов; кровель и водостоков	t
290	ЭОП	Электроснабжение средств оповещения о пожаре		t
291	ЭП	Электроснабжение. Подстанции		t
292	ЭТ	Электротехническая часть, электротехнические решения		t
293	ЭХЗ	Электрохимическая защита		t
294	ЭОК	Электрообогрев коммуникаций	В эту марку входит обеспечение электропитания всех элементов электрообогрева коммуникаций; технологического оборудования и\r\nрезервуаров; полов открытых площадок, лестниц и пандусов; кровель и водостоков\r\n	t
\.


--
-- Data for Name: ref_phase; Type: TABLE DATA; Schema: core; Owner: svcm
--

COPY ref_phase (id, code, name) FROM stdin;
1	ПИ	Прединвестиционные исследования
2	П	Проектная документация
3	P	Рабочая документация
\.


--
-- Data for Name: waybill; Type: TABLE DATA; Schema: core; Owner: svcm
--

COPY waybill (id, waybill_num, waybill_date, descr) FROM stdin;
\.


--
-- Data for Name: waybill_link; Type: TABLE DATA; Schema: core; Owner: svcm
--

COPY waybill_link (id, docset_id, waybill_id) FROM stdin;
\.


SET search_path = public, pg_catalog;

--
-- Data for Name: cost_assign; Type: TABLE DATA; Schema: public; Owner: svcm
--

COPY cost_assign (id, name) FROM stdin;
1	Косвенные
2	Прямые
\.


--
-- Data for Name: cost_group; Type: TABLE DATA; Schema: public; Owner: svcm
--

COPY cost_group (id, parent_id, name) FROM stdin;
1	\N	Подрядные работы
2	\N	Прочие затраты
3	\N	Оборудование
4	\N	За итогом глав ССР
5	1	Строительные работы
6	1	Монтажные работы
7	1	Прочие работы, связанные с организацией строительного производства
8	2	Прочие затраты Заказчика (Агента)
9	3	Оборудование
\.


--
-- Data for Name: cost_kind; Type: TABLE DATA; Schema: public; Owner: svcm
--

COPY cost_kind (id, code, code_old, name, cost_group_id, cost_assign_id, iusi_plan_form_id) FROM stdin;
1	101	101	Строительные и специальные строительные работы	5	2	1
2	103	103	Приобретение оборудования	9	2	10
3	116	103-01	Приобретение газоперекачивающих агрегатов	9	2	10
4	117	103-02	Приобретение оборудования для эксплуатационного и разведочного бурения	9	2	10
5	753	703-17	Затраты на выполнение шефмонтажа оборудования	\N	\N	\N
6	301	302-02	Средства на оплату затрат, связанных с освобождением территории строительства от имеющихся на ней строений, т.е. по сносу (переносу и строительству взамен сносимого на другом месте) зданий и сооружений, по валке леса, корчевке пней, очистке от кустарника, уборке камней, вывозке промышленных отвалов (отработанные породы, шлак и т.п.), переносу и переустройству инженерных сетей, коммуникаций, сооружений	7	1	1
7	302	302-03	Организация рельефа при строительстве площадочных сооружений до начала их возведения	7	1	1
8	303	302-04	Проведение технической рекультивации	7	1	1
9	304	\N	Проведение биологической рекультивация	\N	\N	\N
10	305	301-07	Осушение территории строительства, проведение других мероприятий, связанных с прекращением или изменением условий водопользования, а также с защитой окружающей среды и ликвидацией неблагоприятных условий строительства	\N	\N	\N
11	306	\N	Затраты на подготовку территории для строительства титульных ВЗиС, размещенных за пределами участка, отведенного под застройку	\N	\N	\N
12	307	302	Прочие работы, связанные с освоением территории строительства	7	1	1
13	501	501	Благоустройство и озеленение территории	7	1	1
14	601	601	Средства на строительство титульных временных устройств и обустройств	7	1	1
15	603	602-01	Строительство временных коммуникаций для обеспечения стройки электроэнергией, водой, теплом и т.п. от источника подключения до распределительных устройств на строительной площадке (территории строительства)	7	1	1
16	604	602-02	Строительство временной дороги вдоль трассы (притрассовой дороги) при строительстве магистральных линейных сооружений общей сети с целью первоначального освоения района строительства	7	1	1
17	605	602-03	Строительство и демонтаж временных лежневых дорог	7	1	1
18	606	602-04	Устройство земляных амбаров для гидроиспьгганий	7	1	1
19	607	602-05	Ледовые переправы (при переходе зимних автодорог через водотоки, при осуществлении строительства в районах Крайнего Севера преимущественно в зимний период, не менее 0,5 года)	7	1	1
20	608	602-06	Временные подъездные автодороги к строящимся основным линейным и площадочным (КС, УКПГ и т.д.) сооружениям, включая автодороги к площадкам временных строительных баз и полевым вахтовым поселкам подрядных организаций	7	1	1
21	609	602-07	Зимние автодороги (при ведении строительства в районах Крайнего Севера преимущественно в зимний период, не менее 0,5 года)	7	1	1
22	610	602-08	Усиление существующих автодорог и мостов (ПАО «Газпром» или его предприятий и организаций), несущая способность которых не выдерживает нагрузок от транспортировки по ним грузов при строительстве (реконструкции) объекта	7	1	1
23	602	602	Прочие титульные временные устройства и обустройства, размещенные за пределами участка, отведенного под застройку и не учтенные нормами	7	1	1
24	911	911	Средства, связанные с устройством и испытанием свай, проводимых подрядной организацией в период разработки проектной документации по техническому заданию заказчика строительства	7	1	1
25	912	912	Затраты на проверку сплошности бетонирования и целостности ствола буронабивных свай	7	1	1
26	730	703	Иные прочие затраты Подрядчика	7	1	1
27	701	701	Дополнительные затраты при производстве строительно-монтажных, ремонтно-строительных и пусконаладочных работ в зимнее время	7	1	1
28	702	702-01	Первоначальная очистка от снега площадки (трассы) для строительства, которое начинается в зимнее время	7	1	1
29	703	702-02	Затраты по снегоборьбе в районах Крайнего Севера и местностях, приравненных к ним, а также в сельских местностях, расположенных в пределах IV, V, VI температурных зон	7	1	1
30	704	702	Прочие затраты, связанные с производством работ в зимнее время и не учтенные нормами	7	1	1
83	107	101-02	Сварочно-монтажные работы магистральных трубопроводов	5	2	1
31	705	703-01	Затраты на содержание действующих постоянных автомобильных дорог и восстановление их после окончания строительства	7	1	1
32	706	703-02	Затраты на содержание и восстановление после окончания строительства (ремонта) объекта существующих автодорог с твердым покрытием (ПАО "Газпром’1 или его предприятий и организаций)	7	1	1
33	707	703-03	Затраты на оплату за проезд по платным автомобильным дорогам	7	1	1
34	708	703-04	Затраты, связанные с изменением расстояния транспортирования материалов	7	1	1
35	709	703-06	Средства на покрытие затрат строительных организаций на оплату сборов за перевозку негабаритных грузов по дорогам и мостам	7	1	1
36	710	703-07	Затраты на содержание и ремонт зимников, в том числе ледовых переправ (для Северного района)	7	1	1
37	711	703-08	Затраты на оплату услуг владельцам понтонной переправы	7	1	1
38	712	703-09	Затраты на оплату услуг владельцам зимней дороги	7	1	1
39	713	703-16	Затраты на содержание железнодорожных станций для приема строительных грузов на период строительства (в том числе, при необходимости, подготовка ж.д. станции для приема грузов)	7	1	1
40	714	\N	Прочие затраты, связанные с использованием действующих объектов транспортной инфраструктуры	\N	\N	\N
41	715	703-11	Затраты по перевозке работников строительных и монтажных организаций автомобильным транспортом к месту работы и обратно на расстояние более 3 км в одном направлении при отсутствии городских пассажирских маршрутов, или компенсацию расходов по организации специальных маршрутов городского пассажирского транспорта	7	1	1
42	716	703-12	Затраты, связанные с осуществлением работ вахтовым методом (за исключением вахтовой надбавки к тарифной ставке, учитываемой в локальных сметах)	7	1	1
43	717	703-13	Средства на возмещение затрат, связанных с командированием (за исключением затрат, учтенных фондом оплаты труда)	7	1	1
44	718	703-14	Затраты, связанные с перебазированием строительно-монтажных организаций с одной стройки на другую (кроме перебазировки строительных машин и механизмов, которые учтены в стоимости эксплуатации машин и механизмов)	7	1	1
45	719	703-18	Затраты на проведение мероприятий по обеспечению нормальных условий труда (борьба с радиоактивностью, силикозом, малярией, энцефалитным клещом, гнусом и т.д.)	7	1	1
46	720	\N	Прочие затраты, связанные с мобилизацией строительной организации	\N	\N	\N
47	721	703-15	Затраты на строительство временных перевалочных баз подрядчика и заказчика в пунктах перегрузки материалов и конструкций с одного вида транспорта на другой, а так же строительство перевалочных баз подрядчика и заказчика за пределами строительной площадки (при необходимости)	7	1	1
48	722	703-20	Затраты на возмещение налогов, сборов, отчислений, установленные законодательными актами Российской Федерации и решениями местных (региональных) органов власти -затрат, не учтенных нормой накладных расходов: плата за забор воды из водных объектов (водный налог), в случае, если этот вид затрат не учтен в стоимости воды; выплаты в природоохранительные организации и др.	7	1	1
49	723	703-22	Затраты на оплату размещения отходов в период строительства	7	1	1
50	724	703-23	Затраты на оплату за выбросы загрязняющих веществ в атмосферу	7	1	1
51	725	703-24	Выплаты за организованный сброс загрязняющих веществ в водные объекты	7	1	1
52	726	703-25	Выплаты за неорганизованный сброс загрязняющих веществ в водные объекты	7	1	1
53	727	703-29	Затраты на контроль изоляции трубопровода	7	1	1
54	728	703-34	Затраты на мойку колес автотранспорта	7	1	1
55	729	703-35	Затраты, связанные с использованием электроэнергии от стационарных сетей и передвижных источников электроснабжения (при необходимости)	7	1	1
56	328	301-01	Средства на отвод земельного участка в натуре, выдачу архитектурно-планировочных заданий и красных линий застройки	8	1	4
57	308	301-02	Средства на разбивку основных осей зданий и сооружений и переносу их в натуру, строительно-монтажные работы по закреплению их пунктами и знаками	8	1	4
58	739	703-32	Затраты на совершенствование отраслевой сметно-нормативной базы	\N	\N	\N
84	108	101-03	Подводно-строительные (водолазные) работы	5	2	1
59	740	703-33	Затраты по техническому освидетельствованию после монтажа и до пуска в работу сосудов, работающих под давлением, грузоподъемных механизмов (при отсутствии затрат в нормах на монтаж)	\N	\N	\N
60	309	301-05	Средства на оплату затрат, связанных с получением заказчиком и проектной организацией исходных данных, технических условий на проектирование, и проведение необходимых согласований по проектным решениям, а также выполнение, по требованию органов местного самоуправления, исполнительной контрольной съемки построенных инженерных сетей	8	1	4
61	310	301-06	Землеустроительные работы в части разработки горно-геологического обоснования по застройке территории месторождении с целью получения разрешения на застройку территории залегания полезных ископаемых	8	1	4
62	311	301-08	Затраты по оформлению разрешительной документации в части недропользования (без изъятия воды) при добыче нерудных общераспространенных полезных ископаемых	8	1	4
63	312	301-09	Затраты по оформлению разрешительной документации по особо охраняемым природным территориям	8	1	4
64	313	301-10	Затраты на земляные и подготовительные работы для выполнения диагностического обследования существующих трубопроводов в местах пересечения с проектируемыми трубопроводами	8	1	4
65	314	301-11	Средства на оплату затрат, связанных с разминированием территории строительства в районах бывших боевых действий	8	1	4
66	315	301-12	Средства на оплату затрат, связанных с выполнением археологических раскопок в пределах строительной площадки	8	1	4
67	316	301-13	Средства на выполнение комплекса работ по оформлению прав ПАО «Газпром» на земельные (лесные) участки, необходимые для строительства объектов	8	1	4
68	317	301-03	Средства на оплату за землю при изъятии (выкупе) земельного участка для строительства, а также выплата земельного налога (аренды) в период строительства	8	1	5
69	318	301-04	Средства на оплату затрат за землю, отвод для строительства титульных ВЗиС, размещенных за пределами участка, отведенного под застройку	8	1	5
70	319	301	Прочие затраты, связанные с оформлением земельного участка	8	1	4
71	320	302-01	Средства на оплату затрат, связанных с компенсацией за сносимые строения и садово-огородные насаждения, затрат на незавершенное производство - посев, вспашку и другие сельскохозяйственные работы, затрат, связанных с компенсацией ущерба, наносимого природной среде произведенного на отчуждаемой территории, средства на оплату затрат по возмещению убытков, причиняемых проведением водохозяйственных мероприятий, прекращением или изменением условий водопользования, ущерб водным биологическим ресурсам и ущерб, наносимый объектам животного мира	\N	\N	\N
72	321	302-05	Средства на компенсацию затрат землепользователей на биологическую рекультивацию	7	1	1
73	322	302-06	Средства на оплату затрат, связанных с неблагоприятными гидрогеологическими условиями территории строительства и необходимостью устройства объездов для городского транспорта	\N	\N	\N
74	323	302-07	Затраты на возмещение ущерба водным биологическим ресурсам (при необходимости)	\N	\N	\N
75	104	104	Затраты на приобретение буферного газа	8	1	3
76	731	703-05	Средства на возмещение вреда, причиняемого транспортными средствами, осуществляющими перевозки тяжеловесных грузов	\N	\N	\N
77	732	703-10	Средства на оплату затрат, связанных с услугами по технологическому подключению к действующим сетям инженерно-технического обеспечения	\N	\N	\N
78	733	703-19	Затраты по санитарно-экологическому сопровождению строительства и составлению санитарно-экологического паспорта объекта (производственно-экологический мониторинг на период строительства)	\N	\N	\N
79	734	703-21	Затраты по наблюдению в ходе строительства за осадкой зданий и сооружений, возводимых на просадочных, вечномерзлых, насыпных грунтах, а также уникальных объектов (геотехнический мониторинг (ГТМ) в период строительства)	\N	\N	\N
80	735	703-26	Затраты на техническую инвентаризацию объектов недвижимого имущества и изготовление документов кадастрового и технического учета	\N	\N	\N
81	736	703-27	Затраты на оплату материалов для первоначального заполнения систем	\N	\N	\N
82	106	101-01	Земляные работы, в том числе буро-взрывные работы	5	2	1
85	109	101-04	Эксплуатационное и разведочное бурение	5	2	1
86	110	101-06	Приобретение труб большого диаметра	5	2	2
87	112	101-05	Создание сети геотехнического мониторинга (ГТМ) для объектов газового комплекса в криолитозоне	5	1	1
88	102	102	Монтажные работы	6	2	1
89	113	102-01	Сварочно-монтажные работ технологических трубопроводов	\N	\N	\N
90	114	\N	Приобретение труб большого диаметра для монтажа технологических трубопроводов	\N	\N	\N
91	737	703-28	Затраты на стравливание газа при подключении к единой системе газоснабжения вновь построенных объектов	\N	\N	\N
92	738	703-30	Затраты по оформлению разрешения на использование радиочастот и по оплате радиочастотного спектра на этапе строительства объектов	\N	\N	\N
93	325	303-02	Затраты на технико-техническое сопровождение при помощи телесистемы бурения наклонной скважины с горизонтальным вскрытием продуктивных горизонтов	8	1	3
94	327	303-04	Затраты на проведение комплексных газодинамических исследований и анализа пластовых флюидов	8	1	3
95	749	704-01	Затраты на переработку буровых отходов	8	1	3
96	750	704-02	Затраты на сопровождение бурения (сервисные услуги, топографо-геодезические работы и т. Д-)	8	1	3
97	751	704-03	Затраты на услуги по пожарной безопасности	8	1	3
98	752	\N	Иные прочие затраты при эксплуатационном бурении	\N	\N	\N
99	801	801	Содержание службы заказчика	8	1	7
100	901	901	Затраты на разработку предпроектной документации	8	1	8
101	902	902	Инженерные изыскания на стадии «Проектная документация»	8	1	8
102	903	903	Разработка проектной документации	8	1	8
103	904	904	Инженерные изыскания на стадии «Рабочая документация»	8	1	8
104	905	905	Разработка рабочей документации	8	1	8
105	906	906	Авторский надзор	8	1	8
106	907	907	Затраты на проведение экспертизы проектной документации	8	1	9
107	908	908	Затраты на мониторинг соответствия стоимостных параметров	8	1	8
108	909	909	Публичный технологический и ценовой аудит	8	1	8
109	910	910	Разработка конкурсной документации	8	1	8
110	913	913	Работы по научно-техническому сопровождению (в т.ч. разработка технических регламентов)	8	1	8
111	914	914	Затраты на разработку и регистрацию декларации пожарной безопасности	8	1	8
112	915	915	Затраты на разработку, регистрацию и экспертизу декларации промышленной безопасности	8	1	8
113	001	001	Резерв средств на непредвиденные работы и затраты	4	1	11
114	002	002	Средства на покрытие затрат по уплате налога на добавленную стоимость (НДС)	4	1	12
115	003	\N	Затраты, учитываемые за итогом ССР	\N	\N	\N
116	741	703-36	Затраты на разработку исполнительной документации «как построено»	\N	\N	\N
117	742	703-37	Затраты на осуществление мероприятий по поиску и захоронению останков погибших во время Великой Отечественной войны на территории, отводимой под строительство в местах, относимых к районам бывших военных действий (при необходимости)	\N	\N	\N
118	743	703-38	Затраты по усиленной охране объектов специализированными охранными организациями МВД России и частными предприятиями.	\N	\N	\N
119	744	703-39	Затраты на проведение внутритрубной дефектоскопии перед вводом газопроводов в эксплуатацию	\N	\N	\N
120	745	703-40	Затраты, связанные с использованием военно-строительных частей, студенческих отрядов и других контингентов (организованный набор рабочих)	\N	\N	\N
121	746	703-41	Затраты, связанные с премированием за ввод в действие построенных объектов	\N	\N	\N
122	747	703-42	Затраты на страхование	\N	\N	\N
123	748	703-31	Затраты на проведение пусконаладочных работ "вхолостую"	\N	\N	\N
124	324	303-01	Затраты на организацию приема грузов	8	1	3
125	326	303-03	Затраты на топографо-геодезические работы (при эксплуатационном бурении)	8	1	3
126	802	802	Строительный контроль	8	1	3
\.


--
-- Data for Name: estimate; Type: TABLE DATA; Schema: public; Owner: svcm
--

COPY estimate (id, checksum, machine_id, developer_id, origin_key, cobject_id, contract_id, phase_id, title, type_id, parent_id, chapter_num, line_num, subline1_num, subline2_num, subline3_num, subline4_num, subline5_num, local_num, phase_id_num, changeset_num, addenda_num, source_num, is_annulled, replaces_id, volume_value, volume_measure, cost_code_id, construction_cost, installation_cost, equipment_cost, material_cost, other_cost, total_cost, comments, price_at, approval_date, state_at, basis, book_cipher, load_date, tm_from, tm_to) FROM stdin;
\.


--
-- Data for Name: estimate_fission; Type: TABLE DATA; Schema: public; Owner: svcm
--

COPY estimate_fission (id, estimate_id, checksum, title, cost_code_id, construction_cost, installation_cost, equipment_cost, other_cost, load_date) FROM stdin;
\.


--
-- Data for Name: estimate_link; Type: TABLE DATA; Schema: public; Owner: svcm
--

COPY estimate_link (id, estimate_id, link_type_id, link_id) FROM stdin;
\.


--
-- Data for Name: estimate_type; Type: TABLE DATA; Schema: public; Owner: svcm
--

COPY estimate_type (id, short_name, name) FROM stdin;
1	ОС	Объектная
2	ПОС	Подобъектная
3	ЛС	Локальная
4	СУМ	Суммирующая
\.


--
-- Data for Name: iusi_plan_form; Type: TABLE DATA; Schema: public; Owner: svcm
--

COPY iusi_plan_form (id, name, cost_code) FROM stdin;
1	Подрядные работы	Т800000200
2	Материалы, трубная продукция	Т800000202
3	Иные прочие	Т800000599
4	Землеотвод	Т800000500
5	Землеотвод, аренда	Т800000501
6	Пуско наладочные работы "вхолостую"	Т800000505
7	Услуги Заказчика	Т800000509
8	Проектирование (ПД, РД)	Т800000100
9	Экспертиза	Т800000508
10	Оборудование	Т800000301
11	не учитывается	\N
12	учитывается отдельно	\N
\.


--
-- Data for Name: mrd_object; Type: TABLE DATA; Schema: public; Owner: svcm
--

COPY mrd_object (id, parent_id, construction_id, type_id, type, code, number, descr) FROM stdin;
\.


--
-- Data for Name: mrd_object_link; Type: TABLE DATA; Schema: public; Owner: svcm
--

COPY mrd_object_link (id, cobject_id, mrd_object_id) FROM stdin;
\.


--
-- Data for Name: mrd_objecttype; Type: TABLE DATA; Schema: public; Owner: svcm
--

COPY mrd_objecttype (id, codename, name) FROM stdin;
C	CONSTR	Комплекс
S	OKS	ОКС
R	OSSR	ОССР
\.


--
-- Data for Name: mrd_oksgroup; Type: TABLE DATA; Schema: public; Owner: svcm
--

COPY mrd_oksgroup (id, code_range, name) FROM stdin;
1	1000-1999	Добыча газа и жидких углеводородов
2	2000-2999	Трубопроводный транспорт газа и жидких углеводородов
3	3000-3999	Переработка газа и жидких углеводородов
4	4000-4999	Подземное хранение газа
5	5000-5999	Сжижение природного газа
6	6001-6999	Вспомогательные виды деятельности
\.


--
-- Data for Name: mrd_oksref; Type: TABLE DATA; Schema: public; Owner: svcm
--

COPY mrd_oksref (id, oksgroup_id, code, name) FROM stdin;
1	1	1001	Объекты газовых, газоконденсатных промыслов на месторождении
2	1	1002	Объекты добычи и транспортировки газа на шельфе
3	1	1003	Объекты нефтяных промыслов на месторождении
4	2	2001	Объекты магистральных газопроводов
5	2	2002	Объекты морских магистральных газопроводов
6	2	2003	Объекты магистральных нефтепроводов
7	3	3001	Объекты в составе комплексов по переработке газа и жидких углеводородов
8	4	4001	Объекты подземного хранения газа
9	5	5001	Объекты сжижения, хранения и отгрузки природного газа
10	6	6001	Прочие виды объектов капитального строительства, не относящиеся к основным видам деятельности
\.


--
-- Data for Name: mrd_ossrgroup; Type: TABLE DATA; Schema: public; Owner: svcm
--

COPY mrd_ossrgroup (id, code_range, name) FROM stdin;
1	0000-0999	Объекты основного производственного назначения
2	1000-1999	Объекты энергетической инфраструктуры
3	2000-2999	Сооружения водоснабжения и канализации
4	3000-3999	Сооружения газоснабжения
5	4000-4999	Объекты транспортной инфраструктуры
6	5000-5999	Сооружения систем автоматизации и связи
7	6000-6999	Сооружения обеспечения безопасности и охраны
8	7000-7999	Объекты жилого, административного и бытового назначения
9	8000-8999	Объекты вспомогательного, обслуживающего и складского назначения
\.


--
-- Data for Name: mrd_ossrref; Type: TABLE DATA; Schema: public; Owner: svcm
--

COPY mrd_ossrref (id, ossrgroup_id, code, name) FROM stdin;
1	1	0001	Скважины (кусты скважин) газовые и газоконденсатные
2	1	0002	Объекты устьевой обвязки газовых и газоконденсатных скважин (кустов скважин)
3	1	0003	Объекты внутрипромысловых систем сбора газа, газового конденсата и метанолопроводы
4	1	0004	Объекты предварительной, комплексной подготовки газа и газового конденсата
5	1	0005	Объекты межпромысловых трубопроводов на месторождениях
6	1	0101	Скважины (кусты скважин) нефтяные
7	1	0102	Объекты устьевой обвязки нефтяных скважин (кустов скважин)
8	1	0103	Объекты внутрипромысловых систем сбора нефти
9	1	0104	Объекты подготовки нефти
10	1	0105	Объекты насосных станций
11	1	0106	Объекты межпромысловых продуктопроводов на месторождениях
12	1	0107	Объекты хранения нефти
13	1	0108	Объекты учета нефти
14	1	0201	Объекты подводных добычных комплексов
15	1	0202	Объекты морских добычных платформ с комплексом технологического оборудования
16	1	0203	Объекты в составе полупогруженных плавучих буровых установок
17	1	0204	Объекты в составе морских промысловых трубопроводов
18	1	0205	Объекты в составе комплекса берегового технологического оборудования по приемке, переработке и транспортировке продуктов морских месторождений
19	1	0301	Объекты линейной части магистрального газопровода
20	1	0302	Объекты магистральных конденсатопроводов
21	1	0303	Объекты компрессорных станций
22	1	0304	Объекты станций охлаждения газа
23	1	0305	Объекты линейной части газопроводов-отводов
24	1	0306	Объекты газораспределительных станций
25	1	0307	Объекты газоизмерительных станций
26	1	0401	Объекты линейной части магистрального нефтепровода
27	1	0402	Объекты головных и промежуточных перекачивающих станции
28	1	0403	Объекты наливных станций
29	1	0404	Объекты морских сливо-наливных пунктов
30	1	0405	Объекты хранения нефти
31	1	0406	Объекты подогрева нефти и нефтепродуктов
32	1	0501	Объекты линейной части морского подводного трубопровода
33	1	0502	Объекты морской отгрузки углеводородов
34	1	0601	Объекты в составе завода по стабилизации конденсата
35	1	0602	Объекты в составе газоперерабатывающего завода
36	1	0603	Объекты в составе гелиевого завода
37	1	0604	Объекты в составе нефтегазохимического комплекса
38	1	0701	Объекты в составе завода по сжижению природного газа
39	1	0702	Объекты в составе завода по производству малотоннажного СПГ
40	1	0703	Объекты в составе терминала по регазификации
41	1	0704	Объекты в составе наливных терминалов
42	2	1001	Электростанции
43	2	1002	Электрическая подстанция
44	2	1003	Воздушная линия электропередачи и токопроводы
45	2	1004	Кабельная линия электропередачи
46	2	1005	Объекты наружного электроосвещения, молниезащиты и заземления
47	2	1006	Котельная
48	2	1007	Тепловые сети
49	2	1008	Объекты электрохимзащиты
50	3	2001	Водозаборные сооружения
51	3	2002	Очистные сооружения и объекты водоподготовки
52	3	2003	Резервуары и водонапорные башни
53	3	2004	Водопроводные сети и сооружения на них
54	3	2005	Сооружения очистки сточных вод
55	3	2006	Канализационные сети и сооружения на них
56	3	2007	Объекты утилизации сточных вод
57	4	3001	Газораспределительные сети
58	4	3002	Газорегуляторные пункты и установки
59	4	3003	Резервуарные установки СУГ
60	4	3004	Газонаполнительные станции СУГ
61	5	4001	Объекты аэродромов и аэропортов
62	5	4002	Площадка посадочная для вертолетов
63	5	4003	Автомобильные дороги и сооружения на них
64	5	4004	Вдольтрассовый проезд
65	5	4005	Дорога автомобильная зимняя
66	5	4006	Объекты железнодорожного транспорта
67	5	4007	Объекты в составе морского терминала
68	5	4008	Портовые гидротехнические сооружения
69	5	4009	Объекты в составе речных портов
70	6	5001	Объекты технологической связи
71	6	5002	Диспетчерские центры управления сетями связи
72	6	5003	Объекты автоматизации
73	7	6001	Охранная система объектов
74	7	6002	Комплекс зданий и сооружений по обеспечению промышленной, экологической, противопожарной и противофонтанной безопасности
75	7	6003	Инженерная защита территорий и сооружений от опасных геологических процессов
76	8	7001	Объекты вахтовых поселков
77	8	7002	Объекты жилых комплексов
78	8	7003	Административные здания и сооружения
79	8	7004	Бытовые здания и сооружения
80	8	7005	Объекты спортивно-оздоровительные
81	9	8001	Объекты производственно-эксплуатационных баз
82	9	8002	Объекты размещения отходов
83	9	8003	Объекты хранения
84	9	8004	Объекты обеспечения эксплуатации и ремонта
85	9	8005	Объекты обслуживания автотехники
86	9	8006	Объекты исследования и мониторинга
87	9	8007	Объекты подсобного хозяйства
88	9	8008	Галереи и эстакады
\.


--
-- Data for Name: ssr_chapter; Type: TABLE DATA; Schema: public; Owner: svcm
--

COPY ssr_chapter (id, code, name) FROM stdin;
1	1	Подготовка территории строительства
2	2	Основные объекты строительства
3	3	Объекты подсобного и обслуживающего назначения
4	4	Объекты энергетического хозяйства
5	5	Объекты транспортного хозяйства и связи
6	6	Наружные сети и сооружения водоснабжения, канализации, теплоснабжения и газоснабжения
7	7	Благоустройство и озеленение территории
8	8	Временные здания и сооружения
9	9	Прочие работы и затраты
10	10	Содержание службы заказчика. Строительный контроль
11	12	Проектные и изыскательские работы
\.


SET search_path = stream, pg_catalog;

--
-- Data for Name: building; Type: TABLE DATA; Schema: stream; Owner: svcm
--

COPY building (id, hid, hid_str, hid_uuid, h_ptype, hpid, hpid_str, hpid_uuid, hcontract_id, hcontract_id_str, hcontract_uuid, stream_status, successor_id, code, num, name, gip, object_time, insert_time) FROM stdin;
\.


--
-- Data for Name: constrpart; Type: TABLE DATA; Schema: stream; Owner: svcm
--

COPY constrpart (id, hid, hid_str, hid_uuid, h_ptype, hpid, hpid_str, hpid_uuid, stream_status, successor_id, code, num, name, gip, object_time, insert_time) FROM stdin;
\.


--
-- Data for Name: construction; Type: TABLE DATA; Schema: stream; Owner: svcm
--

COPY construction (id, hid, hid_str, hid_uuid, stream_status, successor_id, code, name, gip, object_time, insert_time) FROM stdin;
\.


--
-- Data for Name: contract; Type: TABLE DATA; Schema: stream; Owner: svcm
--

COPY contract (id, hid, hid_str, hid_uuid, stream_status, successor_id, inner_num, oipks, contractor_code, contractor_name, contract_num, contract_year, contract_date, name, contract_status, ius_code, dev_code, dev_name, techdirector, gips, date_sign, work_start, work_finish, order_start, order_finish, work_types, object_time, insert_time) FROM stdin;
\.


--
-- Data for Name: contract_stage; Type: TABLE DATA; Schema: stream; Owner: svcm
--

COPY contract_stage (id, contractstage_guid, contract_guid, status, stage_num, name, plan_start, plan_finish, wait_start, wait_finish, work_types) FROM stdin;
\.


--
-- Data for Name: docset; Type: TABLE DATA; Schema: stream; Owner: svcm
--

COPY docset (id, hid, hid_str, hid_uuid, h_ptype, hpid, hpid_str, hpid_uuid, stream_status, successor_id, name, cipher, dev_dep, oipks, ccode, num, pstage, dev_org, cpcode, cpnum, bcode, bnum, mark, mark_path, cipher_doc, bstage, cstage, izm_num, gip, status, object_time, insert_time) FROM stdin;
\.


SET search_path = sys, pg_catalog;

--
-- Data for Name: acl_account; Type: TABLE DATA; Schema: sys; Owner: svcm
--

COPY acl_account (id, login, pwd, salt, firstname, middlename, lastname, tabnum, email, is_active) FROM stdin;
1	admin	\N	\N	administrator	\N	adm	\N	sec-sd-setd@gazpromproject.ru	t
\.


--
-- Data for Name: acl_account_role; Type: TABLE DATA; Schema: sys; Owner: svcm
--

COPY acl_account_role (id, account_id, role_id) FROM stdin;
1	1	1
\.


--
-- Data for Name: acl_function; Type: TABLE DATA; Schema: sys; Owner: svcm
--

COPY acl_function (id, name, descr) FROM stdin;
1	sys.AclFunctions.c	Создание функции
2	sys.AclFunctions.r	Чтение функций
3	sys.AclFunctions.u	Изменение функции
4	sys.AclFunctions.d	Удаление функции
5	sys.AclFunctions.l	Создание/удаление записи в связанной таблице
6	sys.AclAccounts.c	Создание пользователя
7	sys.AclAccounts.r	Чтение пользователей
8	sys.AclAccounts.u	Изменение пользователя
9	sys.AclAccounts.d	Удаление пользователя
10	sys.AclAccounts.l	Создание/удаление записи в связанной таблице
11	sys.AclRoles.c	Создание роли
12	sys.AclRoles.r	Чтение ролей
13	sys.AclRoles.u	Изменение роли
14	sys.AclRoles.d	Удаление роли
15	sys.AclRoles.l	Создание/удаление записи в связанной таблице
16	sys.AclGroups.c	Создание группы
17	sys.AclGroups.r	Чтение групп
18	sys.AclGroups.u	Изменение группы
19	sys.AclGroups.d	Удаление группы
20	sys.LogEvents.r	Чтение записей аудита
21	core.Constructions.c	Создание комплекса
22	core.Constructions.r	Чтение комплексов
23	core.Constructions.u	Изменение комплекса
24	core.Constructions.d	Удаление комплекса
25	core.RefConstrPartGroups.c	Создание классификатора групп частей комплексов строек
26	core.RefConstrPartGroups.r	Чтение классификаторов групп частей комплексов строек
27	core.RefConstrPartGroups.u	Изменение классификатора групп частей комплексов строек
28	core.RefConstrPartGroups.d	Удаление классификатора групп частей комплексов строек
29	core.RefConstrPartGroups.l	Создание/удаление записи в связанной таблице
30	core.RefConstrParts.c	Создание классификатора частей комплексов строек
31	core.RefConstrParts.r	Чтение классификаторов частей комплексов строек
32	core.RefConstrParts.u	Изменение классификатора частей комплексов строек
33	core.RefConstrParts.d	Удаление классификатора частей коплексов строек
34	core.RefConstrParts.l	Создание/удаление записи в связанной таблице
35	core.RefBuildingGroups.c	Создание классификатора частей комплексов строек
36	core.RefBuildingGroups.r	Чтение классификаторов частей комплексов строек 
37	core.RefBuildingGroups.u	Изменение классификатора частей комплексов строек
38	core.RefBuildingGroups.d	Удаление классификатора частей коплексов строек
39	core.RefBuildings.c	Создание классификатора зданий, сооружений, систем и установок
40	core.RefBuildings.r	Чтение классификаторов зданий, сооружений, систем и установок
41	core.RefBuildings.u	Изменение классификатора зданий, сооружений, систем и установок
42	core.RefBuildings.d	Удаление классификатора зданий, сооружений, систем и установок
43	core.CObjects.c	Создание объектов проектирования
44	core.CObjects.r	Чтение объектов проектирования
45	core.CObjects.u	Изменение объектов проектирования
46	core.CObjects.d	Удаление объектов проектирования
47	core.CObjects.l	Создание/удаление записи в связанной таблице
48	core.RefPhases.c	Создание классификатора стадий проектирования
49	core.RefPhases.r	Чтение классификаторов стадий проектирования
50	core.RefPhases.u	Изменение классификатора стадий проектирования
51	core.RefPhases.d	Удаление классификатора стадий проектирования
52	core.RefDevelopers.c	Создание субъекта разработки
53	core.RefDevelopers.r	Чтение субъектов разработки
54	core.RefDevelopers.u	Изменение субъекта разработки
55	core.RefDevelopers.d	Удаление субъекта разработки
56	core.RefContractors.c	Создание контрагента
57	core.RefContractors.r	Чтение контрагентов
58	core.RefContractors.u	Изменение контрагента
59	core.RefContractors.d	Удаление контрагента
60	core.Contracts.c	Создание договора
61	core.Contracts.r	Чтение договоров
62	core.Contracts.u	Изменение договора
63	core.Contracts.d	Удаление договора
64	core.Contracts.l	Создание/удаление записи в связанной таблице
65	core.RefDocCodes.c	Создание классификатора шифров прилагаемых документов
66	core.RefDocCodes.r	Чтение классификаторов шифров прилагаемых документов
67	core.RefDocCodes.u	Изменение классификатора шифров прилагаемых документов
68	core.RefDocCodes.d	Удаление классификатора шифров прилагаемых документов
69	core.RefMarks.c	Создание классификатора марок комплектов рабочих чертежей
70	core.RefMarks.r	Чтение классификаторов марок комплектов рабочих чертежей
71	core.RefMarks.u	Изменение классификатора марок комплектов рабочих чертежей
72	core.RefMarks.d	Удаление классификатора марок комплектов рабочих чертежей
73	core.RefChapterCodeTypes.c	Создание классификатора видов разделов ПД
74	core.RefChapterCodeTypes.r	Чтение классификаторов видов разделов ПД
75	core.RefChapterCodeTypes.u	Изменение классификатора видов разделов ПД
76	core.RefChapterCodeTypes.d	Удаление классификатора видов разделов ПД
77	core.RefChapterCodes.c	Создание классификатора разделов ПД
78	core.RefChapterCodes.r	Чтение классификаторов разделов ПД
79	core.RefChapterCodes.u	Изменение классификатора разделов ПД
80	core.RefChapterCodes.d	Удаление классификатора разделов ПД
81	core.DocsetTypes.r	Чтение типов единиц проектной продукции
82	core.DocsetTypes.c	Создание типа единицы проектной продукции
83	core.DocsetTypes.u	Изменение типа единицы проектной продукции
84	core.DocsetTypes.d	Удаление типа единицы проектной продукции
85	core.DocsetTypes.l	Создание/удаление записи в связанной таблице
86	core.Docsets.c	Создание комплекта
87	core.Docsets.r	Чтение комплектов
88	core.Docsets.u	Изменение комплекта
89	core.Docsets.d	Удаление комплекта
90	core.DocsetMons.c	Создание записи в мониторинге выпуска комплектов
91	core.DocsetMons.r	Чтение записей мониторинга выпуска комплектов
92	core.DocsetMons.u	Изменение записи мониторинга выпуска комплектов
93	core.DocsetMons.d	Удаление записи мониторинга выпуска комплектов
94	core.Waybills.c	Создание накладной
95	core.Waybills.r	Чтение накладных
96	core.Waybills.u	Изменение накладной
97	core.Waybills.d	Удаление накладной
98	core.DSBSDs.c	Создание Комплекта в составном документе
99	core.DSBSDs.r	Чтение Комплектов в составном документе
100	core.DSBSDs.u	Изменение Комплекта в составном документе
101	core.DSBSDs.d	Удаление Комплекта из составного документа
102	core.SummaryConstructions.r	Чтение данных комплектов для Комплексов
103	est.Estimates.c	Создание смет
104	est.Estimates.r	Чтение смет
105	est.Estimates.u	Изменение смет
106	est.Estimates.d	Удаление смет
107	stream.StreamConstructions.c	Создание в потоке комплексов
108	stream.StreamConstructions.r	Чтение потока комплексов
109	stream.StreamConstructions.u	Изменение в потоке комплексов
110	stream.StreamConstructions.d	Удаление из потока комплексов
111	stream.StreamContracts.c	Создание в потоке договоров
112	stream.StreamContracts.r	Чтение потока договоров
113	stream.StreamContracts.u	Изменение в потоке договоров
114	stream.StreamContracts.d	Удаление из потока договоров
115	stream.ContractStages.c	Создание в потоке этапов
116	stream.ContractStages.r	Чтение потока этапов
117	stream.ContractStages.u	Изменение в потоке этапов
118	stream.ContractStages.d	Удаление из потока этапов
119	stream.StreamConstrParts.c	Создание в потоке частей комплексов
120	stream.StreamConstrParts.r	Чтение потока частей комплексов
121	stream.StreamConstrParts.u	Изменение в потоке частей комплексов
122	stream.StreamConstrParts.d	Удаление из потока частей комплексов
123	stream.StreamBuildings.c	Создание в потоке сооружений
124	stream.StreamBuildings.r	Чтение потока сооружений
125	stream.StreamBuildings.u	Изменение в потоке сооружений
126	stream.StreamBuildings.d	Удаление из потока сооружений
127	stream.StreamDocsets.c	Создание в потоке составных документов
128	stream.StreamDocsets.r	Чтение потока составных документов
129	stream.StreamDocsets.u	Изменение в потоке составных документов
130	stream.StreamDocsets.d	Удаление из потока составных документов
\.


--
-- Data for Name: acl_group; Type: TABLE DATA; Schema: sys; Owner: svcm
--

COPY acl_group (id, name, descr) FROM stdin;
\.


--
-- Data for Name: acl_role; Type: TABLE DATA; Schema: sys; Owner: svcm
--

COPY acl_role (id, name, descr) FROM stdin;
1	Super	СуперАдминистратор
2	User	Пользователь
\.


--
-- Data for Name: acl_role_function; Type: TABLE DATA; Schema: sys; Owner: svcm
--

COPY acl_role_function (id, role_id, function_id) FROM stdin;
1	1	1
2	1	2
3	1	3
4	1	4
5	1	5
6	1	6
7	1	7
8	1	8
9	1	9
10	1	10
11	1	11
12	1	12
13	1	13
14	1	14
15	1	15
16	1	16
17	1	17
18	1	18
19	1	19
20	1	20
21	1	21
22	1	22
23	1	23
24	1	24
25	1	25
26	1	26
27	1	27
28	1	28
29	1	29
30	1	30
31	1	31
32	1	32
33	1	33
34	1	34
35	1	35
36	1	36
37	1	37
38	1	38
39	1	39
40	1	40
41	1	41
42	1	42
43	1	43
44	1	44
45	1	45
46	1	46
47	1	47
48	1	48
49	1	49
50	1	50
51	1	51
52	1	52
53	1	53
54	1	54
55	1	55
56	1	56
57	1	57
58	1	58
59	1	59
60	1	60
61	1	61
62	1	62
63	1	63
64	1	64
65	1	65
66	1	66
67	1	67
68	1	68
69	1	69
70	1	70
71	1	71
72	1	72
73	1	73
74	1	74
75	1	75
76	1	76
77	1	77
78	1	78
79	1	79
80	1	80
81	1	81
82	1	82
83	1	83
84	1	84
85	1	85
86	1	86
87	1	87
88	1	88
89	1	89
90	1	90
91	1	91
92	1	92
93	1	93
94	1	94
95	1	95
96	1	96
97	1	97
98	1	98
99	1	99
100	1	100
101	1	101
102	1	102
103	1	103
104	1	104
105	1	105
106	1	106
107	1	107
108	1	108
109	1	109
110	1	110
111	1	111
112	1	112
113	1	113
114	1	114
115	1	115
116	1	116
117	1	117
118	1	118
119	1	119
120	1	120
121	1	121
122	1	122
123	1	123
124	1	124
125	1	125
126	1	126
127	1	127
128	1	128
129	1	129
130	1	130
131	2	22
132	2	26
133	2	31
134	2	36
135	2	40
136	2	44
137	2	49
138	2	53
139	2	57
140	2	61
141	2	66
142	2	70
143	2	74
144	2	78
145	2	81
146	2	87
147	2	91
148	2	95
149	2	99
150	2	102
\.


--
-- Data for Name: logevent; Type: TABLE DATA; Schema: sys; Owner: svcm
--

COPY logevent (id, account_id, eventtype_id, eventtime, schema_name, operation_name, operation_pk_id, operation_pk_time, details, descr) FROM stdin;
1	1	1	2019-05-23 15:00:19.299133+03	core	RefConstrPartGroups	1	\N	{"srcName":"core.RefConstrPartGroups.c","srcPK":"1"}	Create data
2	1	1	2019-05-23 15:00:19.61765+03	core	RefConstrPartGroups	2	\N	{"srcName":"core.RefConstrPartGroups.c","srcPK":"2"}	Create data
3	1	1	2019-05-23 15:00:19.796925+03	core	RefConstrPartGroups	3	\N	{"srcName":"core.RefConstrPartGroups.c","srcPK":"3"}	Create data
4	1	1	2019-05-23 15:00:19.975797+03	core	RefConstrPartGroups	4	\N	{"srcName":"core.RefConstrPartGroups.c","srcPK":"4"}	Create data
5	1	1	2019-05-23 15:00:20.173059+03	core	RefConstrPartGroups	5	\N	{"srcName":"core.RefConstrPartGroups.c","srcPK":"5"}	Create data
6	1	1	2019-05-23 15:00:20.331165+03	core	RefConstrPartGroups	6	\N	{"srcName":"core.RefConstrPartGroups.c","srcPK":"6"}	Create data
7	1	1	2019-05-23 15:00:20.513273+03	core	RefConstrPartGroups	7	\N	{"srcName":"core.RefConstrPartGroups.c","srcPK":"7"}	Create data
8	1	1	2019-05-23 15:00:20.689554+03	core	RefConstrPartGroups	8	\N	{"srcName":"core.RefConstrPartGroups.c","srcPK":"8"}	Create data
9	1	1	2019-05-23 15:00:20.833458+03	core	RefConstrPartGroups	9	\N	{"srcName":"core.RefConstrPartGroups.c","srcPK":"9"}	Create data
10	1	1	2019-05-23 15:00:21.000949+03	core	RefConstrPartGroups	10	\N	{"srcName":"core.RefConstrPartGroups.c","srcPK":"10"}	Create data
11	1	1	2019-05-23 15:00:21.205123+03	core	RefConstrPartGroups	11	\N	{"srcName":"core.RefConstrPartGroups.c","srcPK":"11"}	Create data
12	1	1	2019-05-23 15:00:21.39751+03	core	RefConstrParts	1	\N	{"srcName":"core.RefConstrParts.c","srcPK":"1"}	Create data
13	1	1	2019-05-23 15:00:21.60154+03	core	RefConstrParts	2	\N	{"srcName":"core.RefConstrParts.c","srcPK":"2"}	Create data
14	1	1	2019-05-23 15:00:21.830374+03	core	RefConstrParts	3	\N	{"srcName":"core.RefConstrParts.c","srcPK":"3"}	Create data
15	1	1	2019-05-23 15:00:21.997254+03	core	RefConstrParts	4	\N	{"srcName":"core.RefConstrParts.c","srcPK":"4"}	Create data
16	1	1	2019-05-23 15:00:22.197675+03	core	RefConstrParts	5	\N	{"srcName":"core.RefConstrParts.c","srcPK":"5"}	Create data
17	1	1	2019-05-23 15:00:22.378073+03	core	RefConstrParts	6	\N	{"srcName":"core.RefConstrParts.c","srcPK":"6"}	Create data
18	1	1	2019-05-23 15:00:22.556433+03	core	RefConstrParts	7	\N	{"srcName":"core.RefConstrParts.c","srcPK":"7"}	Create data
19	1	1	2019-05-23 15:00:22.722952+03	core	RefConstrParts	8	\N	{"srcName":"core.RefConstrParts.c","srcPK":"8"}	Create data
20	1	1	2019-05-23 15:00:22.938975+03	core	RefConstrParts	9	\N	{"srcName":"core.RefConstrParts.c","srcPK":"9"}	Create data
21	1	1	2019-05-23 15:00:23.098304+03	core	RefConstrParts	10	\N	{"srcName":"core.RefConstrParts.c","srcPK":"10"}	Create data
22	1	1	2019-05-23 15:00:23.27347+03	core	RefConstrParts	11	\N	{"srcName":"core.RefConstrParts.c","srcPK":"11"}	Create data
23	1	1	2019-05-23 15:00:23.462131+03	core	RefConstrParts	12	\N	{"srcName":"core.RefConstrParts.c","srcPK":"12"}	Create data
24	1	1	2019-05-23 15:00:23.623807+03	core	RefConstrParts	13	\N	{"srcName":"core.RefConstrParts.c","srcPK":"13"}	Create data
25	1	1	2019-05-23 15:00:23.791278+03	core	RefConstrParts	14	\N	{"srcName":"core.RefConstrParts.c","srcPK":"14"}	Create data
26	1	1	2019-05-23 15:00:23.950424+03	core	RefConstrParts	15	\N	{"srcName":"core.RefConstrParts.c","srcPK":"15"}	Create data
27	1	1	2019-05-23 15:00:24.34596+03	core	RefConstrParts	16	\N	{"srcName":"core.RefConstrParts.c","srcPK":"16"}	Create data
28	1	1	2019-05-23 15:00:24.593829+03	core	RefConstrParts	17	\N	{"srcName":"core.RefConstrParts.c","srcPK":"17"}	Create data
29	1	1	2019-05-23 15:00:24.813375+03	core	RefConstrParts	18	\N	{"srcName":"core.RefConstrParts.c","srcPK":"18"}	Create data
30	1	1	2019-05-23 15:00:24.969385+03	core	RefConstrParts	19	\N	{"srcName":"core.RefConstrParts.c","srcPK":"19"}	Create data
31	1	1	2019-05-23 15:00:25.179937+03	core	RefConstrParts	20	\N	{"srcName":"core.RefConstrParts.c","srcPK":"20"}	Create data
32	1	1	2019-05-23 15:00:25.340527+03	core	RefConstrParts	21	\N	{"srcName":"core.RefConstrParts.c","srcPK":"21"}	Create data
33	1	1	2019-05-23 15:00:25.489686+03	core	RefConstrParts	22	\N	{"srcName":"core.RefConstrParts.c","srcPK":"22"}	Create data
34	1	1	2019-05-23 15:00:25.631243+03	core	RefConstrParts	23	\N	{"srcName":"core.RefConstrParts.c","srcPK":"23"}	Create data
35	1	1	2019-05-23 15:00:25.823096+03	core	RefConstrParts	24	\N	{"srcName":"core.RefConstrParts.c","srcPK":"24"}	Create data
36	1	1	2019-05-23 15:00:26.016893+03	core	RefConstrParts	25	\N	{"srcName":"core.RefConstrParts.c","srcPK":"25"}	Create data
37	1	1	2019-05-23 15:00:26.187808+03	core	RefConstrParts	26	\N	{"srcName":"core.RefConstrParts.c","srcPK":"26"}	Create data
38	1	1	2019-05-23 15:00:26.352809+03	core	RefConstrParts	27	\N	{"srcName":"core.RefConstrParts.c","srcPK":"27"}	Create data
39	1	1	2019-05-23 15:00:26.511472+03	core	RefConstrParts	28	\N	{"srcName":"core.RefConstrParts.c","srcPK":"28"}	Create data
40	1	1	2019-05-23 15:00:26.727972+03	core	RefConstrParts	29	\N	{"srcName":"core.RefConstrParts.c","srcPK":"29"}	Create data
41	1	1	2019-05-23 15:00:26.987032+03	core	RefConstrParts	30	\N	{"srcName":"core.RefConstrParts.c","srcPK":"30"}	Create data
42	1	1	2019-05-23 15:00:27.157256+03	core	RefConstrParts	31	\N	{"srcName":"core.RefConstrParts.c","srcPK":"31"}	Create data
43	1	1	2019-05-23 15:00:27.329501+03	core	RefConstrParts	32	\N	{"srcName":"core.RefConstrParts.c","srcPK":"32"}	Create data
44	1	1	2019-05-23 15:00:27.474526+03	core	RefConstrParts	33	\N	{"srcName":"core.RefConstrParts.c","srcPK":"33"}	Create data
45	1	1	2019-05-23 15:00:27.625269+03	core	RefConstrParts	34	\N	{"srcName":"core.RefConstrParts.c","srcPK":"34"}	Create data
46	1	1	2019-05-23 15:00:27.766459+03	core	RefConstrParts	35	\N	{"srcName":"core.RefConstrParts.c","srcPK":"35"}	Create data
47	1	1	2019-05-23 15:00:27.939149+03	core	RefConstrParts	36	\N	{"srcName":"core.RefConstrParts.c","srcPK":"36"}	Create data
48	1	1	2019-05-23 15:00:28.106819+03	core	RefConstrParts	37	\N	{"srcName":"core.RefConstrParts.c","srcPK":"37"}	Create data
49	1	1	2019-05-23 15:00:28.267561+03	core	RefConstrParts	38	\N	{"srcName":"core.RefConstrParts.c","srcPK":"38"}	Create data
50	1	1	2019-05-23 15:00:28.468392+03	core	RefConstrParts	39	\N	{"srcName":"core.RefConstrParts.c","srcPK":"39"}	Create data
51	1	1	2019-05-23 15:00:28.662885+03	core	RefConstrParts	40	\N	{"srcName":"core.RefConstrParts.c","srcPK":"40"}	Create data
52	1	1	2019-05-23 15:00:28.893974+03	core	RefConstrParts	41	\N	{"srcName":"core.RefConstrParts.c","srcPK":"41"}	Create data
54	1	1	2019-05-23 15:00:29.333001+03	core	RefConstrParts	43	\N	{"srcName":"core.RefConstrParts.c","srcPK":"43"}	Create data
56	1	1	2019-05-23 15:00:29.647286+03	core	RefConstrParts	45	\N	{"srcName":"core.RefConstrParts.c","srcPK":"45"}	Create data
58	1	1	2019-05-23 15:00:30.182662+03	core	RefConstrParts	47	\N	{"srcName":"core.RefConstrParts.c","srcPK":"47"}	Create data
60	1	1	2019-05-23 15:00:30.567502+03	core	RefConstrParts	49	\N	{"srcName":"core.RefConstrParts.c","srcPK":"49"}	Create data
62	1	1	2019-05-23 15:00:31.040642+03	core	RefConstrParts	51	\N	{"srcName":"core.RefConstrParts.c","srcPK":"51"}	Create data
64	1	1	2019-05-23 15:00:31.481036+03	core	RefConstrParts	53	\N	{"srcName":"core.RefConstrParts.c","srcPK":"53"}	Create data
66	1	1	2019-05-23 15:00:31.808307+03	core	RefConstrParts	55	\N	{"srcName":"core.RefConstrParts.c","srcPK":"55"}	Create data
68	1	1	2019-05-23 15:00:32.138553+03	core	RefConstrParts	57	\N	{"srcName":"core.RefConstrParts.c","srcPK":"57"}	Create data
70	1	1	2019-05-23 15:00:32.475693+03	core	RefConstrParts	59	\N	{"srcName":"core.RefConstrParts.c","srcPK":"59"}	Create data
72	1	1	2019-05-23 15:00:32.77778+03	core	RefConstrParts	61	\N	{"srcName":"core.RefConstrParts.c","srcPK":"61"}	Create data
74	1	1	2019-05-23 15:00:33.224081+03	core	RefConstrParts	63	\N	{"srcName":"core.RefConstrParts.c","srcPK":"63"}	Create data
76	1	1	2019-05-23 15:00:33.52774+03	core	RefConstrParts	65	\N	{"srcName":"core.RefConstrParts.c","srcPK":"65"}	Create data
78	1	1	2019-05-23 15:00:33.841867+03	core	RefConstrParts	67	\N	{"srcName":"core.RefConstrParts.c","srcPK":"67"}	Create data
80	1	1	2019-05-23 15:00:34.27259+03	core	RefConstrParts	69	\N	{"srcName":"core.RefConstrParts.c","srcPK":"69"}	Create data
82	1	1	2019-05-23 15:00:34.772377+03	core	RefConstrParts	71	\N	{"srcName":"core.RefConstrParts.c","srcPK":"71"}	Create data
53	1	1	2019-05-23 15:00:29.053763+03	core	RefConstrParts	42	\N	{"srcName":"core.RefConstrParts.c","srcPK":"42"}	Create data
55	1	1	2019-05-23 15:00:29.486191+03	core	RefConstrParts	44	\N	{"srcName":"core.RefConstrParts.c","srcPK":"44"}	Create data
57	1	1	2019-05-23 15:00:29.86539+03	core	RefConstrParts	46	\N	{"srcName":"core.RefConstrParts.c","srcPK":"46"}	Create data
59	1	1	2019-05-23 15:00:30.36453+03	core	RefConstrParts	48	\N	{"srcName":"core.RefConstrParts.c","srcPK":"48"}	Create data
61	1	1	2019-05-23 15:00:30.848749+03	core	RefConstrParts	50	\N	{"srcName":"core.RefConstrParts.c","srcPK":"50"}	Create data
63	1	1	2019-05-23 15:00:31.223845+03	core	RefConstrParts	52	\N	{"srcName":"core.RefConstrParts.c","srcPK":"52"}	Create data
65	1	1	2019-05-23 15:00:31.649829+03	core	RefConstrParts	54	\N	{"srcName":"core.RefConstrParts.c","srcPK":"54"}	Create data
67	1	1	2019-05-23 15:00:31.967249+03	core	RefConstrParts	56	\N	{"srcName":"core.RefConstrParts.c","srcPK":"56"}	Create data
69	1	1	2019-05-23 15:00:32.30098+03	core	RefConstrParts	58	\N	{"srcName":"core.RefConstrParts.c","srcPK":"58"}	Create data
71	1	1	2019-05-23 15:00:32.606682+03	core	RefConstrParts	60	\N	{"srcName":"core.RefConstrParts.c","srcPK":"60"}	Create data
73	1	1	2019-05-23 15:00:32.943098+03	core	RefConstrParts	62	\N	{"srcName":"core.RefConstrParts.c","srcPK":"62"}	Create data
75	1	1	2019-05-23 15:00:33.375948+03	core	RefConstrParts	64	\N	{"srcName":"core.RefConstrParts.c","srcPK":"64"}	Create data
77	1	1	2019-05-23 15:00:33.689999+03	core	RefConstrParts	66	\N	{"srcName":"core.RefConstrParts.c","srcPK":"66"}	Create data
79	1	1	2019-05-23 15:00:34.012846+03	core	RefConstrParts	68	\N	{"srcName":"core.RefConstrParts.c","srcPK":"68"}	Create data
81	1	1	2019-05-23 15:00:34.438129+03	core	RefConstrParts	70	\N	{"srcName":"core.RefConstrParts.c","srcPK":"70"}	Create data
83	1	1	2019-05-23 15:00:35.179833+03	core	RefConstrParts	72	\N	{"srcName":"core.RefConstrParts.c","srcPK":"72"}	Create data
84	1	1	2019-05-23 15:00:35.56664+03	core	RefConstrParts	73	\N	{"srcName":"core.RefConstrParts.c","srcPK":"73"}	Create data
85	1	1	2019-05-23 15:00:35.996943+03	core	RefConstrParts	74	\N	{"srcName":"core.RefConstrParts.c","srcPK":"74"}	Create data
86	1	1	2019-05-23 15:00:36.230691+03	core	RefConstrParts	75	\N	{"srcName":"core.RefConstrParts.c","srcPK":"75"}	Create data
87	1	1	2019-05-23 15:00:36.453762+03	core	RefConstrParts	76	\N	{"srcName":"core.RefConstrParts.c","srcPK":"76"}	Create data
88	1	1	2019-05-23 15:00:36.740104+03	core	RefConstrParts	77	\N	{"srcName":"core.RefConstrParts.c","srcPK":"77"}	Create data
89	1	1	2019-05-23 15:00:36.923176+03	core	RefConstrParts	78	\N	{"srcName":"core.RefConstrParts.c","srcPK":"78"}	Create data
90	1	1	2019-05-23 15:00:37.124572+03	core	RefConstrParts	79	\N	{"srcName":"core.RefConstrParts.c","srcPK":"79"}	Create data
91	1	1	2019-05-23 15:00:37.347335+03	core	RefConstrParts	80	\N	{"srcName":"core.RefConstrParts.c","srcPK":"80"}	Create data
92	1	1	2019-05-23 15:00:37.644341+03	core	RefConstrParts	81	\N	{"srcName":"core.RefConstrParts.c","srcPK":"81"}	Create data
93	1	1	2019-05-23 15:00:37.925341+03	core	RefConstrParts	82	\N	{"srcName":"core.RefConstrParts.c","srcPK":"82"}	Create data
94	1	1	2019-05-23 15:00:38.421554+03	core	RefConstrParts	83	\N	{"srcName":"core.RefConstrParts.c","srcPK":"83"}	Create data
95	1	1	2019-05-23 15:00:39.099347+03	core	RefConstrParts	84	\N	{"srcName":"core.RefConstrParts.c","srcPK":"84"}	Create data
96	1	1	2019-05-23 15:00:39.292697+03	core	RefConstrParts	85	\N	{"srcName":"core.RefConstrParts.c","srcPK":"85"}	Create data
97	1	1	2019-05-23 15:00:39.481703+03	core	RefConstrParts	86	\N	{"srcName":"core.RefConstrParts.c","srcPK":"86"}	Create data
98	1	1	2019-05-23 15:00:39.893009+03	core	RefConstrParts	87	\N	{"srcName":"core.RefConstrParts.c","srcPK":"87"}	Create data
99	1	1	2019-05-23 15:00:40.144087+03	core	RefConstrParts	88	\N	{"srcName":"core.RefConstrParts.c","srcPK":"88"}	Create data
100	1	1	2019-05-23 15:00:40.380001+03	core	RefConstrParts	89	\N	{"srcName":"core.RefConstrParts.c","srcPK":"89"}	Create data
101	1	1	2019-05-23 15:00:40.589297+03	core	RefConstrParts	90	\N	{"srcName":"core.RefConstrParts.c","srcPK":"90"}	Create data
102	1	1	2019-05-23 15:00:41.001304+03	core	RefConstrParts	91	\N	{"srcName":"core.RefConstrParts.c","srcPK":"91"}	Create data
103	1	1	2019-05-23 15:00:41.155387+03	core	RefConstrParts	92	\N	{"srcName":"core.RefConstrParts.c","srcPK":"92"}	Create data
104	1	1	2019-05-23 15:00:41.33954+03	core	RefConstrParts	93	\N	{"srcName":"core.RefConstrParts.c","srcPK":"93"}	Create data
105	1	1	2019-05-23 15:00:41.497908+03	core	RefConstrParts	94	\N	{"srcName":"core.RefConstrParts.c","srcPK":"94"}	Create data
106	1	1	2019-05-23 15:00:41.657842+03	core	RefConstrParts	95	\N	{"srcName":"core.RefConstrParts.c","srcPK":"95"}	Create data
107	1	1	2019-05-23 15:00:41.819988+03	core	RefConstrParts	96	\N	{"srcName":"core.RefConstrParts.c","srcPK":"96"}	Create data
108	1	1	2019-05-23 15:00:42.316016+03	core	RefConstrParts	97	\N	{"srcName":"core.RefConstrParts.c","srcPK":"97"}	Create data
109	1	1	2019-05-23 15:00:43.059479+03	core	RefConstrParts	98	\N	{"srcName":"core.RefConstrParts.c","srcPK":"98"}	Create data
110	1	1	2019-05-23 15:00:43.484037+03	core	RefConstrParts	99	\N	{"srcName":"core.RefConstrParts.c","srcPK":"99"}	Create data
111	1	1	2019-05-23 15:00:44.010217+03	core	RefConstrParts	100	\N	{"srcName":"core.RefConstrParts.c","srcPK":"100"}	Create data
112	1	1	2019-05-23 15:00:44.636116+03	core	RefConstrParts	101	\N	{"srcName":"core.RefConstrParts.c","srcPK":"101"}	Create data
113	1	1	2019-05-23 15:00:45.028013+03	core	RefConstrParts	102	\N	{"srcName":"core.RefConstrParts.c","srcPK":"102"}	Create data
114	1	1	2019-05-23 15:00:45.278291+03	core	RefConstrParts	103	\N	{"srcName":"core.RefConstrParts.c","srcPK":"103"}	Create data
115	1	1	2019-05-23 15:00:45.447725+03	core	RefConstrParts	104	\N	{"srcName":"core.RefConstrParts.c","srcPK":"104"}	Create data
116	1	1	2019-05-23 15:00:45.706848+03	core	RefConstrParts	105	\N	{"srcName":"core.RefConstrParts.c","srcPK":"105"}	Create data
117	1	1	2019-05-23 15:00:45.906124+03	core	RefConstrParts	106	\N	{"srcName":"core.RefConstrParts.c","srcPK":"106"}	Create data
118	1	1	2019-05-23 15:00:46.081173+03	core	RefConstrParts	107	\N	{"srcName":"core.RefConstrParts.c","srcPK":"107"}	Create data
119	1	1	2019-05-23 15:00:46.230349+03	core	RefConstrParts	108	\N	{"srcName":"core.RefConstrParts.c","srcPK":"108"}	Create data
120	1	1	2019-05-23 15:00:46.496472+03	core	RefConstrParts	109	\N	{"srcName":"core.RefConstrParts.c","srcPK":"109"}	Create data
122	1	1	2019-05-23 15:00:47.137084+03	core	RefConstrParts	111	\N	{"srcName":"core.RefConstrParts.c","srcPK":"111"}	Create data
124	1	1	2019-05-23 15:00:47.720348+03	core	RefConstrParts	113	\N	{"srcName":"core.RefConstrParts.c","srcPK":"113"}	Create data
126	1	1	2019-05-23 15:00:48.09281+03	core	RefConstrParts	115	\N	{"srcName":"core.RefConstrParts.c","srcPK":"115"}	Create data
128	1	1	2019-05-23 15:00:48.54734+03	core	RefConstrParts	117	\N	{"srcName":"core.RefConstrParts.c","srcPK":"117"}	Create data
130	1	1	2019-05-23 15:00:48.852067+03	core	RefConstrParts	119	\N	{"srcName":"core.RefConstrParts.c","srcPK":"119"}	Create data
132	1	1	2019-05-23 15:00:49.135771+03	core	RefConstrParts	121	\N	{"srcName":"core.RefConstrParts.c","srcPK":"121"}	Create data
134	1	1	2019-05-23 15:00:49.428378+03	core	RefConstrParts	123	\N	{"srcName":"core.RefConstrParts.c","srcPK":"123"}	Create data
136	1	1	2019-05-23 15:00:49.740494+03	core	RefConstrParts	125	\N	{"srcName":"core.RefConstrParts.c","srcPK":"125"}	Create data
138	1	1	2019-05-23 15:00:50.311241+03	core	RefConstrParts	127	\N	{"srcName":"core.RefConstrParts.c","srcPK":"127"}	Create data
140	1	1	2019-05-23 15:00:50.610597+03	core	RefConstrParts	129	\N	{"srcName":"core.RefConstrParts.c","srcPK":"129"}	Create data
142	1	1	2019-05-23 15:00:50.991153+03	core	RefConstrParts	131	\N	{"srcName":"core.RefConstrParts.c","srcPK":"131"}	Create data
144	1	1	2019-05-23 15:00:51.357166+03	core	RefConstrParts	133	\N	{"srcName":"core.RefConstrParts.c","srcPK":"133"}	Create data
146	1	1	2019-05-23 15:00:51.90937+03	core	RefConstrParts	135	\N	{"srcName":"core.RefConstrParts.c","srcPK":"135"}	Create data
148	1	1	2019-05-23 15:00:52.684532+03	core	RefConstrParts	137	\N	{"srcName":"core.RefConstrParts.c","srcPK":"137"}	Create data
150	1	1	2019-05-23 15:00:53.068129+03	core	RefConstrParts	139	\N	{"srcName":"core.RefConstrParts.c","srcPK":"139"}	Create data
152	1	1	2019-05-23 15:00:53.387102+03	core	RefConstrParts	141	\N	{"srcName":"core.RefConstrParts.c","srcPK":"141"}	Create data
154	1	1	2019-05-23 15:00:53.718542+03	core	RefConstrParts	143	\N	{"srcName":"core.RefConstrParts.c","srcPK":"143"}	Create data
156	1	1	2019-05-23 15:00:54.144934+03	core	RefConstrParts	145	\N	{"srcName":"core.RefConstrParts.c","srcPK":"145"}	Create data
158	1	1	2019-05-23 15:00:54.454396+03	core	RefConstrParts	147	\N	{"srcName":"core.RefConstrParts.c","srcPK":"147"}	Create data
160	1	1	2019-05-23 15:00:54.888673+03	core	RefConstrParts	149	\N	{"srcName":"core.RefConstrParts.c","srcPK":"149"}	Create data
162	1	1	2019-05-23 15:00:55.561602+03	core	RefConstrParts	151	\N	{"srcName":"core.RefConstrParts.c","srcPK":"151"}	Create data
164	1	1	2019-05-23 15:00:55.88159+03	core	RefConstrParts	153	\N	{"srcName":"core.RefConstrParts.c","srcPK":"153"}	Create data
166	1	1	2019-05-23 15:00:56.186258+03	core	RefConstrParts	155	\N	{"srcName":"core.RefConstrParts.c","srcPK":"155"}	Create data
168	1	1	2019-05-23 15:00:56.619992+03	core	RefConstrParts	157	\N	{"srcName":"core.RefConstrParts.c","srcPK":"157"}	Create data
170	1	1	2019-05-23 15:00:56.913125+03	core	RefConstrParts	159	\N	{"srcName":"core.RefConstrParts.c","srcPK":"159"}	Create data
172	1	1	2019-05-23 15:00:57.256948+03	core	RefConstrParts	161	\N	{"srcName":"core.RefConstrParts.c","srcPK":"161"}	Create data
174	1	1	2019-05-23 15:00:57.691865+03	core	RefConstrParts	163	\N	{"srcName":"core.RefConstrParts.c","srcPK":"163"}	Create data
176	1	1	2019-05-23 15:00:58.083133+03	core	RefConstrParts	165	\N	{"srcName":"core.RefConstrParts.c","srcPK":"165"}	Create data
178	1	1	2019-05-23 15:00:58.45385+03	core	RefConstrParts	167	\N	{"srcName":"core.RefConstrParts.c","srcPK":"167"}	Create data
180	1	1	2019-05-23 15:00:58.799849+03	core	RefConstrParts	169	\N	{"srcName":"core.RefConstrParts.c","srcPK":"169"}	Create data
182	1	1	2019-05-23 15:00:59.208977+03	core	RefConstrParts	171	\N	{"srcName":"core.RefConstrParts.c","srcPK":"171"}	Create data
184	1	1	2019-05-23 15:00:59.490056+03	core	RefConstrParts	173	\N	{"srcName":"core.RefConstrParts.c","srcPK":"173"}	Create data
186	1	1	2019-05-23 15:00:59.757074+03	core	RefConstrParts	175	\N	{"srcName":"core.RefConstrParts.c","srcPK":"175"}	Create data
188	1	1	2019-05-23 15:01:00.182887+03	core	RefConstrParts	177	\N	{"srcName":"core.RefConstrParts.c","srcPK":"177"}	Create data
190	1	1	2019-05-23 15:01:00.526767+03	core	RefConstrParts	179	\N	{"srcName":"core.RefConstrParts.c","srcPK":"179"}	Create data
192	1	1	2019-05-23 15:01:01.014147+03	core	RefConstrParts	181	\N	{"srcName":"core.RefConstrParts.c","srcPK":"181"}	Create data
194	1	1	2019-05-23 15:01:01.319755+03	core	RefConstrParts	183	\N	{"srcName":"core.RefConstrParts.c","srcPK":"183"}	Create data
196	1	1	2019-05-23 15:01:01.745267+03	core	RefConstrParts	185	\N	{"srcName":"core.RefConstrParts.c","srcPK":"185"}	Create data
198	1	1	2019-05-23 15:01:02.093659+03	core	RefConstrParts	187	\N	{"srcName":"core.RefConstrParts.c","srcPK":"187"}	Create data
200	1	1	2019-05-23 15:01:02.546966+03	core	RefConstrParts	189	\N	{"srcName":"core.RefConstrParts.c","srcPK":"189"}	Create data
202	1	1	2019-05-23 15:01:02.899729+03	core	RefConstrParts	191	\N	{"srcName":"core.RefConstrParts.c","srcPK":"191"}	Create data
204	1	1	2019-05-23 15:01:03.273089+03	core	RefConstrParts	193	\N	{"srcName":"core.RefConstrParts.c","srcPK":"193"}	Create data
206	1	1	2019-05-23 15:01:03.725328+03	core	RefConstrParts	195	\N	{"srcName":"core.RefConstrParts.c","srcPK":"195"}	Create data
208	1	1	2019-05-23 15:01:04.132099+03	core	RefConstrParts	197	\N	{"srcName":"core.RefConstrParts.c","srcPK":"197"}	Create data
210	1	1	2019-05-23 15:01:04.507559+03	core	RefConstrParts	199	\N	{"srcName":"core.RefConstrParts.c","srcPK":"199"}	Create data
212	1	1	2019-05-23 15:01:04.9167+03	core	RefConstrParts	201	\N	{"srcName":"core.RefConstrParts.c","srcPK":"201"}	Create data
214	1	1	2019-05-23 15:01:05.468817+03	core	RefConstrParts	203	\N	{"srcName":"core.RefConstrParts.c","srcPK":"203"}	Create data
216	1	1	2019-05-23 15:01:05.825689+03	core	RefConstrParts	205	\N	{"srcName":"core.RefConstrParts.c","srcPK":"205"}	Create data
218	1	1	2019-05-23 15:01:06.132486+03	core	RefConstrParts	207	\N	{"srcName":"core.RefConstrParts.c","srcPK":"207"}	Create data
220	1	1	2019-05-23 15:01:06.4676+03	core	RefConstrParts	209	\N	{"srcName":"core.RefConstrParts.c","srcPK":"209"}	Create data
222	1	1	2019-05-23 15:01:06.959828+03	core	RefConstrParts	211	\N	{"srcName":"core.RefConstrParts.c","srcPK":"211"}	Create data
121	1	1	2019-05-23 15:00:46.792854+03	core	RefConstrParts	110	\N	{"srcName":"core.RefConstrParts.c","srcPK":"110"}	Create data
123	1	1	2019-05-23 15:00:47.478095+03	core	RefConstrParts	112	\N	{"srcName":"core.RefConstrParts.c","srcPK":"112"}	Create data
125	1	1	2019-05-23 15:00:47.903904+03	core	RefConstrParts	114	\N	{"srcName":"core.RefConstrParts.c","srcPK":"114"}	Create data
127	1	1	2019-05-23 15:00:48.370966+03	core	RefConstrParts	116	\N	{"srcName":"core.RefConstrParts.c","srcPK":"116"}	Create data
129	1	1	2019-05-23 15:00:48.712932+03	core	RefConstrParts	118	\N	{"srcName":"core.RefConstrParts.c","srcPK":"118"}	Create data
131	1	1	2019-05-23 15:00:48.993541+03	core	RefConstrParts	120	\N	{"srcName":"core.RefConstrParts.c","srcPK":"120"}	Create data
133	1	1	2019-05-23 15:00:49.277345+03	core	RefConstrParts	122	\N	{"srcName":"core.RefConstrParts.c","srcPK":"122"}	Create data
135	1	1	2019-05-23 15:00:49.580381+03	core	RefConstrParts	124	\N	{"srcName":"core.RefConstrParts.c","srcPK":"124"}	Create data
137	1	1	2019-05-23 15:00:50.109104+03	core	RefConstrParts	126	\N	{"srcName":"core.RefConstrParts.c","srcPK":"126"}	Create data
139	1	1	2019-05-23 15:00:50.476276+03	core	RefConstrParts	128	\N	{"srcName":"core.RefConstrParts.c","srcPK":"128"}	Create data
141	1	1	2019-05-23 15:00:50.76578+03	core	RefConstrParts	130	\N	{"srcName":"core.RefConstrParts.c","srcPK":"130"}	Create data
143	1	1	2019-05-23 15:00:51.175947+03	core	RefConstrParts	132	\N	{"srcName":"core.RefConstrParts.c","srcPK":"132"}	Create data
145	1	1	2019-05-23 15:00:51.608847+03	core	RefConstrParts	134	\N	{"srcName":"core.RefConstrParts.c","srcPK":"134"}	Create data
147	1	1	2019-05-23 15:00:52.510048+03	core	RefConstrParts	136	\N	{"srcName":"core.RefConstrParts.c","srcPK":"136"}	Create data
149	1	1	2019-05-23 15:00:52.920204+03	core	RefConstrParts	138	\N	{"srcName":"core.RefConstrParts.c","srcPK":"138"}	Create data
151	1	1	2019-05-23 15:00:53.234455+03	core	RefConstrParts	140	\N	{"srcName":"core.RefConstrParts.c","srcPK":"140"}	Create data
153	1	1	2019-05-23 15:00:53.544833+03	core	RefConstrParts	142	\N	{"srcName":"core.RefConstrParts.c","srcPK":"142"}	Create data
155	1	1	2019-05-23 15:00:53.876694+03	core	RefConstrParts	144	\N	{"srcName":"core.RefConstrParts.c","srcPK":"144"}	Create data
157	1	1	2019-05-23 15:00:54.304387+03	core	RefConstrParts	146	\N	{"srcName":"core.RefConstrParts.c","srcPK":"146"}	Create data
159	1	1	2019-05-23 15:00:54.639199+03	core	RefConstrParts	148	\N	{"srcName":"core.RefConstrParts.c","srcPK":"148"}	Create data
161	1	1	2019-05-23 15:00:55.271004+03	core	RefConstrParts	150	\N	{"srcName":"core.RefConstrParts.c","srcPK":"150"}	Create data
163	1	1	2019-05-23 15:00:55.713536+03	core	RefConstrParts	152	\N	{"srcName":"core.RefConstrParts.c","srcPK":"152"}	Create data
165	1	1	2019-05-23 15:00:56.036198+03	core	RefConstrParts	154	\N	{"srcName":"core.RefConstrParts.c","srcPK":"154"}	Create data
167	1	1	2019-05-23 15:00:56.348144+03	core	RefConstrParts	156	\N	{"srcName":"core.RefConstrParts.c","srcPK":"156"}	Create data
169	1	1	2019-05-23 15:00:56.770518+03	core	RefConstrParts	158	\N	{"srcName":"core.RefConstrParts.c","srcPK":"158"}	Create data
171	1	1	2019-05-23 15:00:57.056464+03	core	RefConstrParts	160	\N	{"srcName":"core.RefConstrParts.c","srcPK":"160"}	Create data
173	1	1	2019-05-23 15:00:57.406588+03	core	RefConstrParts	162	\N	{"srcName":"core.RefConstrParts.c","srcPK":"162"}	Create data
175	1	1	2019-05-23 15:00:57.920535+03	core	RefConstrParts	164	\N	{"srcName":"core.RefConstrParts.c","srcPK":"164"}	Create data
177	1	1	2019-05-23 15:00:58.274174+03	core	RefConstrParts	166	\N	{"srcName":"core.RefConstrParts.c","srcPK":"166"}	Create data
179	1	1	2019-05-23 15:00:58.591442+03	core	RefConstrParts	168	\N	{"srcName":"core.RefConstrParts.c","srcPK":"168"}	Create data
181	1	1	2019-05-23 15:00:59.009331+03	core	RefConstrParts	170	\N	{"srcName":"core.RefConstrParts.c","srcPK":"170"}	Create data
183	1	1	2019-05-23 15:00:59.366259+03	core	RefConstrParts	172	\N	{"srcName":"core.RefConstrParts.c","srcPK":"172"}	Create data
185	1	1	2019-05-23 15:00:59.615329+03	core	RefConstrParts	174	\N	{"srcName":"core.RefConstrParts.c","srcPK":"174"}	Create data
187	1	1	2019-05-23 15:00:59.908201+03	core	RefConstrParts	176	\N	{"srcName":"core.RefConstrParts.c","srcPK":"176"}	Create data
189	1	1	2019-05-23 15:01:00.319979+03	core	RefConstrParts	178	\N	{"srcName":"core.RefConstrParts.c","srcPK":"178"}	Create data
191	1	1	2019-05-23 15:01:00.769912+03	core	RefConstrParts	180	\N	{"srcName":"core.RefConstrParts.c","srcPK":"180"}	Create data
193	1	1	2019-05-23 15:01:01.161761+03	core	RefConstrParts	182	\N	{"srcName":"core.RefConstrParts.c","srcPK":"182"}	Create data
195	1	1	2019-05-23 15:01:01.479017+03	core	RefConstrParts	184	\N	{"srcName":"core.RefConstrParts.c","srcPK":"184"}	Create data
197	1	1	2019-05-23 15:01:01.919458+03	core	RefConstrParts	186	\N	{"srcName":"core.RefConstrParts.c","srcPK":"186"}	Create data
199	1	1	2019-05-23 15:01:02.314108+03	core	RefConstrParts	188	\N	{"srcName":"core.RefConstrParts.c","srcPK":"188"}	Create data
201	1	1	2019-05-23 15:01:02.702819+03	core	RefConstrParts	190	\N	{"srcName":"core.RefConstrParts.c","srcPK":"190"}	Create data
203	1	1	2019-05-23 15:01:03.096314+03	core	RefConstrParts	192	\N	{"srcName":"core.RefConstrParts.c","srcPK":"192"}	Create data
205	1	1	2019-05-23 15:01:03.490337+03	core	RefConstrParts	194	\N	{"srcName":"core.RefConstrParts.c","srcPK":"194"}	Create data
207	1	1	2019-05-23 15:01:03.948701+03	core	RefConstrParts	196	\N	{"srcName":"core.RefConstrParts.c","srcPK":"196"}	Create data
209	1	1	2019-05-23 15:01:04.349834+03	core	RefConstrParts	198	\N	{"srcName":"core.RefConstrParts.c","srcPK":"198"}	Create data
211	1	1	2019-05-23 15:01:04.691012+03	core	RefConstrParts	200	\N	{"srcName":"core.RefConstrParts.c","srcPK":"200"}	Create data
213	1	1	2019-05-23 15:01:05.249328+03	core	RefConstrParts	202	\N	{"srcName":"core.RefConstrParts.c","srcPK":"202"}	Create data
215	1	1	2019-05-23 15:01:05.668855+03	core	RefConstrParts	204	\N	{"srcName":"core.RefConstrParts.c","srcPK":"204"}	Create data
217	1	1	2019-05-23 15:01:05.984565+03	core	RefConstrParts	206	\N	{"srcName":"core.RefConstrParts.c","srcPK":"206"}	Create data
219	1	1	2019-05-23 15:01:06.28527+03	core	RefConstrParts	208	\N	{"srcName":"core.RefConstrParts.c","srcPK":"208"}	Create data
221	1	1	2019-05-23 15:01:06.673275+03	core	RefConstrParts	210	\N	{"srcName":"core.RefConstrParts.c","srcPK":"210"}	Create data
223	1	1	2019-05-23 15:01:07.168926+03	core	RefConstrParts	212	\N	{"srcName":"core.RefConstrParts.c","srcPK":"212"}	Create data
224	1	1	2019-05-23 15:01:07.368695+03	core	RefConstrParts	213	\N	{"srcName":"core.RefConstrParts.c","srcPK":"213"}	Create data
226	1	1	2019-05-23 15:01:07.711259+03	core	RefConstrParts	215	\N	{"srcName":"core.RefConstrParts.c","srcPK":"215"}	Create data
228	1	1	2019-05-23 15:01:08.042655+03	core	RefConstrParts	217	\N	{"srcName":"core.RefConstrParts.c","srcPK":"217"}	Create data
230	1	1	2019-05-23 15:01:08.330127+03	core	RefConstrParts	219	\N	{"srcName":"core.RefConstrParts.c","srcPK":"219"}	Create data
232	1	1	2019-05-23 15:01:08.762237+03	core	RefConstrParts	221	\N	{"srcName":"core.RefConstrParts.c","srcPK":"221"}	Create data
234	1	1	2019-05-23 15:01:09.088214+03	core	RefConstrParts	223	\N	{"srcName":"core.RefConstrParts.c","srcPK":"223"}	Create data
236	1	1	2019-05-23 15:01:09.442752+03	core	RefConstrParts	225	\N	{"srcName":"core.RefConstrParts.c","srcPK":"225"}	Create data
238	1	1	2019-05-23 15:01:09.773013+03	core	RefConstrParts	227	\N	{"srcName":"core.RefConstrParts.c","srcPK":"227"}	Create data
240	1	1	2019-05-23 15:01:10.270552+03	core	RefConstrParts	229	\N	{"srcName":"core.RefConstrParts.c","srcPK":"229"}	Create data
242	1	1	2019-05-23 15:01:10.58047+03	core	RefConstrParts	231	\N	{"srcName":"core.RefConstrParts.c","srcPK":"231"}	Create data
244	1	1	2019-05-23 15:01:10.916774+03	core	RefConstrParts	233	\N	{"srcName":"core.RefConstrParts.c","srcPK":"233"}	Create data
246	1	1	2019-05-23 15:01:11.24176+03	core	RefConstrParts	235	\N	{"srcName":"core.RefConstrParts.c","srcPK":"235"}	Create data
248	1	1	2019-05-23 15:01:11.616552+03	core	RefConstrParts	237	\N	{"srcName":"core.RefConstrParts.c","srcPK":"237"}	Create data
250	1	1	2019-05-23 15:01:12.542232+03	core	RefConstrParts	239	\N	{"srcName":"core.RefConstrParts.c","srcPK":"239"}	Create data
252	1	1	2019-05-23 15:01:13.126028+03	core	RefConstrParts	241	\N	{"srcName":"core.RefConstrParts.c","srcPK":"241"}	Create data
254	1	1	2019-05-23 15:01:13.551737+03	core	RefConstrParts	243	\N	{"srcName":"core.RefConstrParts.c","srcPK":"243"}	Create data
256	1	1	2019-05-23 15:01:14.052531+03	core	RefConstrParts	245	\N	{"srcName":"core.RefConstrParts.c","srcPK":"245"}	Create data
258	1	1	2019-05-23 15:01:14.485487+03	core	RefConstrParts	247	\N	{"srcName":"core.RefConstrParts.c","srcPK":"247"}	Create data
260	1	1	2019-05-23 15:01:14.927568+03	core	RefConstrParts	249	\N	{"srcName":"core.RefConstrParts.c","srcPK":"249"}	Create data
262	1	1	2019-05-23 15:01:15.553409+03	core	RefConstrParts	251	\N	{"srcName":"core.RefConstrParts.c","srcPK":"251"}	Create data
264	1	1	2019-05-23 15:01:15.865411+03	core	RefConstrParts	253	\N	{"srcName":"core.RefConstrParts.c","srcPK":"253"}	Create data
266	1	1	2019-05-23 15:01:16.430267+03	core	RefConstrParts	255	\N	{"srcName":"core.RefConstrParts.c","srcPK":"255"}	Create data
268	1	1	2019-05-23 15:01:16.803003+03	core	RefConstrParts	257	\N	{"srcName":"core.RefConstrParts.c","srcPK":"257"}	Create data
270	1	1	2019-05-23 15:01:17.148972+03	core	RefConstrParts	259	\N	{"srcName":"core.RefConstrParts.c","srcPK":"259"}	Create data
272	1	1	2019-05-23 15:01:17.464978+03	core	RefConstrParts	261	\N	{"srcName":"core.RefConstrParts.c","srcPK":"261"}	Create data
274	1	1	2019-05-23 15:01:17.815432+03	core	RefConstrParts	263	\N	{"srcName":"core.RefConstrParts.c","srcPK":"263"}	Create data
276	1	1	2019-05-23 15:01:18.244114+03	core	RefConstrParts	265	\N	{"srcName":"core.RefConstrParts.c","srcPK":"265"}	Create data
278	1	1	2019-05-23 15:01:18.559983+03	core	RefConstrParts	267	\N	{"srcName":"core.RefConstrParts.c","srcPK":"267"}	Create data
280	1	1	2019-05-23 15:01:18.982942+03	core	RefConstrParts	269	\N	{"srcName":"core.RefConstrParts.c","srcPK":"269"}	Create data
282	1	1	2019-05-23 15:01:19.300213+03	core	RefConstrParts	271	\N	{"srcName":"core.RefConstrParts.c","srcPK":"271"}	Create data
284	1	1	2019-05-23 15:01:19.599625+03	core	RefConstrParts	273	\N	{"srcName":"core.RefConstrParts.c","srcPK":"273"}	Create data
286	1	1	2019-05-23 15:01:19.976787+03	core	RefConstrParts	275	\N	{"srcName":"core.RefConstrParts.c","srcPK":"275"}	Create data
288	1	1	2019-05-23 15:01:20.452479+03	core	RefConstrParts	277	\N	{"srcName":"core.RefConstrParts.c","srcPK":"277"}	Create data
290	1	1	2019-05-23 15:01:20.783676+03	core	RefConstrParts	279	\N	{"srcName":"core.RefConstrParts.c","srcPK":"279"}	Create data
292	1	1	2019-05-23 15:01:21.075784+03	core	RefConstrParts	281	\N	{"srcName":"core.RefConstrParts.c","srcPK":"281"}	Create data
294	1	1	2019-05-23 15:01:21.453337+03	core	RefConstrParts	283	\N	{"srcName":"core.RefConstrParts.c","srcPK":"283"}	Create data
296	1	1	2019-05-23 15:01:21.804409+03	core	RefConstrParts	285	\N	{"srcName":"core.RefConstrParts.c","srcPK":"285"}	Create data
298	1	1	2019-05-23 15:01:22.160866+03	core	RefConstrParts	287	\N	{"srcName":"core.RefConstrParts.c","srcPK":"287"}	Create data
300	1	1	2019-05-23 15:01:22.494003+03	core	RefConstrParts	289	\N	{"srcName":"core.RefConstrParts.c","srcPK":"289"}	Create data
302	1	1	2019-05-23 15:01:23.066521+03	core	RefConstrParts	291	\N	{"srcName":"core.RefConstrParts.c","srcPK":"291"}	Create data
304	1	1	2019-05-23 15:01:23.693128+03	core	RefConstrParts	293	\N	{"srcName":"core.RefConstrParts.c","srcPK":"293"}	Create data
306	1	1	2019-05-23 15:01:24.008203+03	core	RefConstrParts	295	\N	{"srcName":"core.RefConstrParts.c","srcPK":"295"}	Create data
308	1	1	2019-05-23 15:01:24.399433+03	core	RefConstrParts	297	\N	{"srcName":"core.RefConstrParts.c","srcPK":"297"}	Create data
310	1	1	2019-05-23 15:01:24.714331+03	core	RefConstrParts	299	\N	{"srcName":"core.RefConstrParts.c","srcPK":"299"}	Create data
312	1	1	2019-05-23 15:01:25.106231+03	core	RefConstrParts	301	\N	{"srcName":"core.RefConstrParts.c","srcPK":"301"}	Create data
314	1	1	2019-05-23 15:01:25.533492+03	core	RefConstrParts	303	\N	{"srcName":"core.RefConstrParts.c","srcPK":"303"}	Create data
316	1	1	2019-05-23 15:01:25.88475+03	core	RefConstrParts	305	\N	{"srcName":"core.RefConstrParts.c","srcPK":"305"}	Create data
318	1	1	2019-05-23 15:01:26.316788+03	core	RefConstrParts	307	\N	{"srcName":"core.RefConstrParts.c","srcPK":"307"}	Create data
320	1	1	2019-05-23 15:01:26.63562+03	core	RefConstrParts	309	\N	{"srcName":"core.RefConstrParts.c","srcPK":"309"}	Create data
322	1	1	2019-05-23 15:01:27.085411+03	core	RefConstrParts	311	\N	{"srcName":"core.RefConstrParts.c","srcPK":"311"}	Create data
324	1	1	2019-05-23 15:01:27.488808+03	core	RefConstrParts	313	\N	{"srcName":"core.RefConstrParts.c","srcPK":"313"}	Create data
326	1	1	2019-05-23 15:01:27.85618+03	core	RefConstrParts	315	\N	{"srcName":"core.RefConstrParts.c","srcPK":"315"}	Create data
225	1	1	2019-05-23 15:01:07.543955+03	core	RefConstrParts	214	\N	{"srcName":"core.RefConstrParts.c","srcPK":"214"}	Create data
227	1	1	2019-05-23 15:01:07.903036+03	core	RefConstrParts	216	\N	{"srcName":"core.RefConstrParts.c","srcPK":"216"}	Create data
229	1	1	2019-05-23 15:01:08.169105+03	core	RefConstrParts	218	\N	{"srcName":"core.RefConstrParts.c","srcPK":"218"}	Create data
231	1	1	2019-05-23 15:01:08.589123+03	core	RefConstrParts	220	\N	{"srcName":"core.RefConstrParts.c","srcPK":"220"}	Create data
233	1	1	2019-05-23 15:01:08.904559+03	core	RefConstrParts	222	\N	{"srcName":"core.RefConstrParts.c","srcPK":"222"}	Create data
235	1	1	2019-05-23 15:01:09.27986+03	core	RefConstrParts	224	\N	{"srcName":"core.RefConstrParts.c","srcPK":"224"}	Create data
237	1	1	2019-05-23 15:01:09.604463+03	core	RefConstrParts	226	\N	{"srcName":"core.RefConstrParts.c","srcPK":"226"}	Create data
239	1	1	2019-05-23 15:01:09.964213+03	core	RefConstrParts	228	\N	{"srcName":"core.RefConstrParts.c","srcPK":"228"}	Create data
241	1	1	2019-05-23 15:01:10.412959+03	core	RefConstrParts	230	\N	{"srcName":"core.RefConstrParts.c","srcPK":"230"}	Create data
243	1	1	2019-05-23 15:01:10.750452+03	core	RefConstrParts	232	\N	{"srcName":"core.RefConstrParts.c","srcPK":"232"}	Create data
245	1	1	2019-05-23 15:01:11.083273+03	core	RefConstrParts	234	\N	{"srcName":"core.RefConstrParts.c","srcPK":"234"}	Create data
247	1	1	2019-05-23 15:01:11.459174+03	core	RefConstrParts	236	\N	{"srcName":"core.RefConstrParts.c","srcPK":"236"}	Create data
249	1	1	2019-05-23 15:01:11.894594+03	core	RefConstrParts	238	\N	{"srcName":"core.RefConstrParts.c","srcPK":"238"}	Create data
251	1	1	2019-05-23 15:01:12.919178+03	core	RefConstrParts	240	\N	{"srcName":"core.RefConstrParts.c","srcPK":"240"}	Create data
253	1	1	2019-05-23 15:01:13.336273+03	core	RefConstrParts	242	\N	{"srcName":"core.RefConstrParts.c","srcPK":"242"}	Create data
255	1	1	2019-05-23 15:01:13.743916+03	core	RefConstrParts	244	\N	{"srcName":"core.RefConstrParts.c","srcPK":"244"}	Create data
257	1	1	2019-05-23 15:01:14.291994+03	core	RefConstrParts	246	\N	{"srcName":"core.RefConstrParts.c","srcPK":"246"}	Create data
259	1	1	2019-05-23 15:01:14.72604+03	core	RefConstrParts	248	\N	{"srcName":"core.RefConstrParts.c","srcPK":"248"}	Create data
261	1	1	2019-05-23 15:01:15.294967+03	core	RefConstrParts	250	\N	{"srcName":"core.RefConstrParts.c","srcPK":"250"}	Create data
263	1	1	2019-05-23 15:01:15.705202+03	core	RefConstrParts	252	\N	{"srcName":"core.RefConstrParts.c","srcPK":"252"}	Create data
265	1	1	2019-05-23 15:01:16.146523+03	core	RefConstrParts	254	\N	{"srcName":"core.RefConstrParts.c","srcPK":"254"}	Create data
267	1	1	2019-05-23 15:01:16.584703+03	core	RefConstrParts	256	\N	{"srcName":"core.RefConstrParts.c","srcPK":"256"}	Create data
269	1	1	2019-05-23 15:01:16.98105+03	core	RefConstrParts	258	\N	{"srcName":"core.RefConstrParts.c","srcPK":"258"}	Create data
271	1	1	2019-05-23 15:01:17.314573+03	core	RefConstrParts	260	\N	{"srcName":"core.RefConstrParts.c","srcPK":"260"}	Create data
273	1	1	2019-05-23 15:01:17.632569+03	core	RefConstrParts	262	\N	{"srcName":"core.RefConstrParts.c","srcPK":"262"}	Create data
275	1	1	2019-05-23 15:01:17.952129+03	core	RefConstrParts	264	\N	{"srcName":"core.RefConstrParts.c","srcPK":"264"}	Create data
277	1	1	2019-05-23 15:01:18.398919+03	core	RefConstrParts	266	\N	{"srcName":"core.RefConstrParts.c","srcPK":"266"}	Create data
279	1	1	2019-05-23 15:01:18.78462+03	core	RefConstrParts	268	\N	{"srcName":"core.RefConstrParts.c","srcPK":"268"}	Create data
281	1	1	2019-05-23 15:01:19.14401+03	core	RefConstrParts	270	\N	{"srcName":"core.RefConstrParts.c","srcPK":"270"}	Create data
283	1	1	2019-05-23 15:01:19.456806+03	core	RefConstrParts	272	\N	{"srcName":"core.RefConstrParts.c","srcPK":"272"}	Create data
285	1	1	2019-05-23 15:01:19.751153+03	core	RefConstrParts	274	\N	{"srcName":"core.RefConstrParts.c","srcPK":"274"}	Create data
287	1	1	2019-05-23 15:01:20.253415+03	core	RefConstrParts	276	\N	{"srcName":"core.RefConstrParts.c","srcPK":"276"}	Create data
289	1	1	2019-05-23 15:01:20.619031+03	core	RefConstrParts	278	\N	{"srcName":"core.RefConstrParts.c","srcPK":"278"}	Create data
291	1	1	2019-05-23 15:01:20.925681+03	core	RefConstrParts	280	\N	{"srcName":"core.RefConstrParts.c","srcPK":"280"}	Create data
293	1	1	2019-05-23 15:01:21.293474+03	core	RefConstrParts	282	\N	{"srcName":"core.RefConstrParts.c","srcPK":"282"}	Create data
295	1	1	2019-05-23 15:01:21.612253+03	core	RefConstrParts	284	\N	{"srcName":"core.RefConstrParts.c","srcPK":"284"}	Create data
297	1	1	2019-05-23 15:01:22.00321+03	core	RefConstrParts	286	\N	{"srcName":"core.RefConstrParts.c","srcPK":"286"}	Create data
299	1	1	2019-05-23 15:01:22.352615+03	core	RefConstrParts	288	\N	{"srcName":"core.RefConstrParts.c","srcPK":"288"}	Create data
301	1	1	2019-05-23 15:01:22.647874+03	core	RefConstrParts	290	\N	{"srcName":"core.RefConstrParts.c","srcPK":"290"}	Create data
303	1	1	2019-05-23 15:01:23.410663+03	core	RefConstrParts	292	\N	{"srcName":"core.RefConstrParts.c","srcPK":"292"}	Create data
305	1	1	2019-05-23 15:01:23.852852+03	core	RefConstrParts	294	\N	{"srcName":"core.RefConstrParts.c","srcPK":"294"}	Create data
307	1	1	2019-05-23 15:01:24.19896+03	core	RefConstrParts	296	\N	{"srcName":"core.RefConstrParts.c","srcPK":"296"}	Create data
309	1	1	2019-05-23 15:01:24.560399+03	core	RefConstrParts	298	\N	{"srcName":"core.RefConstrParts.c","srcPK":"298"}	Create data
311	1	1	2019-05-23 15:01:24.922782+03	core	RefConstrParts	300	\N	{"srcName":"core.RefConstrParts.c","srcPK":"300"}	Create data
313	1	1	2019-05-23 15:01:25.392178+03	core	RefConstrParts	302	\N	{"srcName":"core.RefConstrParts.c","srcPK":"302"}	Create data
315	1	1	2019-05-23 15:01:25.702419+03	core	RefConstrParts	304	\N	{"srcName":"core.RefConstrParts.c","srcPK":"304"}	Create data
317	1	1	2019-05-23 15:01:26.160061+03	core	RefConstrParts	306	\N	{"srcName":"core.RefConstrParts.c","srcPK":"306"}	Create data
319	1	1	2019-05-23 15:01:26.468472+03	core	RefConstrParts	308	\N	{"srcName":"core.RefConstrParts.c","srcPK":"308"}	Create data
321	1	1	2019-05-23 15:01:26.863691+03	core	RefConstrParts	310	\N	{"srcName":"core.RefConstrParts.c","srcPK":"310"}	Create data
323	1	1	2019-05-23 15:01:27.25436+03	core	RefConstrParts	312	\N	{"srcName":"core.RefConstrParts.c","srcPK":"312"}	Create data
325	1	1	2019-05-23 15:01:27.689976+03	core	RefConstrParts	314	\N	{"srcName":"core.RefConstrParts.c","srcPK":"314"}	Create data
327	1	1	2019-05-23 15:01:28.086215+03	core	RefConstrParts	316	\N	{"srcName":"core.RefConstrParts.c","srcPK":"316"}	Create data
328	1	1	2019-05-23 15:01:28.229687+03	core	RefConstrParts	317	\N	{"srcName":"core.RefConstrParts.c","srcPK":"317"}	Create data
330	1	1	2019-05-23 15:01:28.689186+03	core	RefConstrParts	319	\N	{"srcName":"core.RefConstrParts.c","srcPK":"319"}	Create data
332	1	1	2019-05-23 15:01:29.005061+03	core	RefConstrParts	321	\N	{"srcName":"core.RefConstrParts.c","srcPK":"321"}	Create data
334	1	1	2019-05-23 15:01:29.364537+03	core	RefConstrParts	323	\N	{"srcName":"core.RefConstrParts.c","srcPK":"323"}	Create data
336	1	1	2019-05-23 15:01:29.705251+03	core	RefConstrParts	325	\N	{"srcName":"core.RefConstrParts.c","srcPK":"325"}	Create data
338	1	1	2019-05-23 15:01:30.08053+03	core	RefConstrParts	327	\N	{"srcName":"core.RefConstrParts.c","srcPK":"327"}	Create data
340	1	1	2019-05-23 15:01:30.565117+03	core	RefConstrParts	329	\N	{"srcName":"core.RefConstrParts.c","srcPK":"329"}	Create data
342	1	1	2019-05-23 15:01:30.875427+03	core	RefConstrParts	331	\N	{"srcName":"core.RefConstrParts.c","srcPK":"331"}	Create data
344	1	1	2019-05-23 15:01:31.272334+03	core	RefConstrParts	333	\N	{"srcName":"core.RefConstrParts.c","srcPK":"333"}	Create data
346	1	1	2019-05-23 15:01:31.631351+03	core	RefConstrParts	335	\N	{"srcName":"core.RefConstrParts.c","srcPK":"335"}	Create data
348	1	1	2019-05-23 15:01:31.984516+03	core	RefConstrParts	337	\N	{"srcName":"core.RefConstrParts.c","srcPK":"337"}	Create data
350	1	1	2019-05-23 15:01:32.359342+03	core	RefConstrParts	339	\N	{"srcName":"core.RefConstrParts.c","srcPK":"339"}	Create data
352	1	1	2019-05-23 15:01:32.752415+03	core	RefConstrParts	341	\N	{"srcName":"core.RefConstrParts.c","srcPK":"341"}	Create data
354	1	1	2019-05-23 15:01:33.102325+03	core	RefConstrParts	343	\N	{"srcName":"core.RefConstrParts.c","srcPK":"343"}	Create data
356	1	1	2019-05-23 15:01:33.561089+03	core	RefConstrParts	345	\N	{"srcName":"core.RefConstrParts.c","srcPK":"345"}	Create data
358	1	1	2019-05-23 15:01:33.834144+03	core	RefConstrParts	347	\N	{"srcName":"core.RefConstrParts.c","srcPK":"347"}	Create data
360	1	1	2019-05-23 15:01:34.144751+03	core	RefConstrParts	349	\N	{"srcName":"core.RefConstrParts.c","srcPK":"349"}	Create data
362	1	1	2019-05-23 15:01:34.41293+03	core	RefConstrParts	351	\N	{"srcName":"core.RefConstrParts.c","srcPK":"351"}	Create data
364	1	1	2019-05-23 15:01:34.872101+03	core	RefConstrParts	353	\N	{"srcName":"core.RefConstrParts.c","srcPK":"353"}	Create data
329	1	1	2019-05-23 15:01:28.394462+03	core	RefConstrParts	318	\N	{"srcName":"core.RefConstrParts.c","srcPK":"318"}	Create data
331	1	1	2019-05-23 15:01:28.846368+03	core	RefConstrParts	320	\N	{"srcName":"core.RefConstrParts.c","srcPK":"320"}	Create data
333	1	1	2019-05-23 15:01:29.188022+03	core	RefConstrParts	322	\N	{"srcName":"core.RefConstrParts.c","srcPK":"322"}	Create data
335	1	1	2019-05-23 15:01:29.553993+03	core	RefConstrParts	324	\N	{"srcName":"core.RefConstrParts.c","srcPK":"324"}	Create data
337	1	1	2019-05-23 15:01:29.881046+03	core	RefConstrParts	326	\N	{"srcName":"core.RefConstrParts.c","srcPK":"326"}	Create data
339	1	1	2019-05-23 15:01:30.413179+03	core	RefConstrParts	328	\N	{"srcName":"core.RefConstrParts.c","srcPK":"328"}	Create data
341	1	1	2019-05-23 15:01:30.722161+03	core	RefConstrParts	330	\N	{"srcName":"core.RefConstrParts.c","srcPK":"330"}	Create data
343	1	1	2019-05-23 15:01:31.076084+03	core	RefConstrParts	332	\N	{"srcName":"core.RefConstrParts.c","srcPK":"332"}	Create data
345	1	1	2019-05-23 15:01:31.456427+03	core	RefConstrParts	334	\N	{"srcName":"core.RefConstrParts.c","srcPK":"334"}	Create data
347	1	1	2019-05-23 15:01:31.814993+03	core	RefConstrParts	336	\N	{"srcName":"core.RefConstrParts.c","srcPK":"336"}	Create data
349	1	1	2019-05-23 15:01:32.200552+03	core	RefConstrParts	338	\N	{"srcName":"core.RefConstrParts.c","srcPK":"338"}	Create data
351	1	1	2019-05-23 15:01:32.560739+03	core	RefConstrParts	340	\N	{"srcName":"core.RefConstrParts.c","srcPK":"340"}	Create data
353	1	1	2019-05-23 15:01:32.949468+03	core	RefConstrParts	342	\N	{"srcName":"core.RefConstrParts.c","srcPK":"342"}	Create data
355	1	1	2019-05-23 15:01:33.318518+03	core	RefConstrParts	344	\N	{"srcName":"core.RefConstrParts.c","srcPK":"344"}	Create data
357	1	1	2019-05-23 15:01:33.70242+03	core	RefConstrParts	346	\N	{"srcName":"core.RefConstrParts.c","srcPK":"346"}	Create data
359	1	1	2019-05-23 15:01:33.977385+03	core	RefConstrParts	348	\N	{"srcName":"core.RefConstrParts.c","srcPK":"348"}	Create data
361	1	1	2019-05-23 15:01:34.280918+03	core	RefConstrParts	350	\N	{"srcName":"core.RefConstrParts.c","srcPK":"350"}	Create data
363	1	1	2019-05-23 15:01:34.636481+03	core	RefConstrParts	352	\N	{"srcName":"core.RefConstrParts.c","srcPK":"352"}	Create data
365	1	1	2019-05-23 15:01:35.30408+03	core	RefConstrParts	354	\N	{"srcName":"core.RefConstrParts.c","srcPK":"354"}	Create data
366	1	1	2019-05-23 15:01:35.87065+03	core	RefConstrParts	355	\N	{"srcName":"core.RefConstrParts.c","srcPK":"355"}	Create data
367	1	1	2019-05-23 15:01:36.037747+03	core	RefConstrParts	356	\N	{"srcName":"core.RefConstrParts.c","srcPK":"356"}	Create data
368	1	1	2019-05-23 15:01:36.242249+03	core	RefConstrParts	357	\N	{"srcName":"core.RefConstrParts.c","srcPK":"357"}	Create data
369	1	1	2019-05-23 15:01:36.421383+03	core	RefConstrParts	358	\N	{"srcName":"core.RefConstrParts.c","srcPK":"358"}	Create data
370	1	1	2019-05-23 15:01:36.5885+03	core	RefConstrParts	359	\N	{"srcName":"core.RefConstrParts.c","srcPK":"359"}	Create data
371	1	1	2019-05-23 15:01:36.791127+03	core	RefConstrParts	360	\N	{"srcName":"core.RefConstrParts.c","srcPK":"360"}	Create data
372	1	1	2019-05-23 15:01:37.054418+03	core	RefConstrParts	361	\N	{"srcName":"core.RefConstrParts.c","srcPK":"361"}	Create data
373	1	1	2019-05-23 15:01:37.364305+03	core	RefConstrParts	362	\N	{"srcName":"core.RefConstrParts.c","srcPK":"362"}	Create data
374	1	1	2019-05-23 15:01:37.599292+03	core	RefConstrParts	363	\N	{"srcName":"core.RefConstrParts.c","srcPK":"363"}	Create data
375	1	1	2019-05-23 15:01:37.832605+03	core	RefConstrParts	364	\N	{"srcName":"core.RefConstrParts.c","srcPK":"364"}	Create data
376	1	1	2019-05-23 15:01:37.989917+03	core	RefConstrParts	365	\N	{"srcName":"core.RefConstrParts.c","srcPK":"365"}	Create data
377	1	1	2019-05-23 15:01:38.138417+03	core	RefConstrParts	366	\N	{"srcName":"core.RefConstrParts.c","srcPK":"366"}	Create data
378	1	1	2019-05-23 15:01:38.300477+03	core	RefConstrParts	367	\N	{"srcName":"core.RefConstrParts.c","srcPK":"367"}	Create data
379	1	1	2019-05-23 15:01:38.482309+03	core	RefConstrParts	368	\N	{"srcName":"core.RefConstrParts.c","srcPK":"368"}	Create data
380	1	1	2019-05-23 15:01:38.716837+03	core	RefConstrParts	369	\N	{"srcName":"core.RefConstrParts.c","srcPK":"369"}	Create data
381	1	1	2019-05-23 15:01:38.925167+03	core	RefConstrParts	370	\N	{"srcName":"core.RefConstrParts.c","srcPK":"370"}	Create data
382	1	1	2019-05-23 15:01:39.133937+03	core	RefConstrParts	371	\N	{"srcName":"core.RefConstrParts.c","srcPK":"371"}	Create data
383	1	1	2019-05-23 15:01:39.305591+03	core	RefConstrParts	372	\N	{"srcName":"core.RefConstrParts.c","srcPK":"372"}	Create data
384	1	1	2019-05-23 15:01:39.518559+03	core	RefConstrParts	373	\N	{"srcName":"core.RefConstrParts.c","srcPK":"373"}	Create data
385	1	1	2019-05-23 15:01:39.699744+03	core	RefConstrParts	374	\N	{"srcName":"core.RefConstrParts.c","srcPK":"374"}	Create data
386	1	1	2019-05-23 15:01:39.885035+03	core	RefBuildings	1	\N	{"srcName":"core.RefBuildings.c","srcPK":"1"}	Create data
387	1	1	2019-05-23 15:01:40.084634+03	core	RefBuildings	2	\N	{"srcName":"core.RefBuildings.c","srcPK":"2"}	Create data
388	1	1	2019-05-23 15:01:40.490956+03	core	RefBuildings	3	\N	{"srcName":"core.RefBuildings.c","srcPK":"3"}	Create data
389	1	1	2019-05-23 15:01:40.710714+03	core	RefBuildings	4	\N	{"srcName":"core.RefBuildings.c","srcPK":"4"}	Create data
390	1	1	2019-05-23 15:01:40.861119+03	core	RefBuildings	5	\N	{"srcName":"core.RefBuildings.c","srcPK":"5"}	Create data
391	1	1	2019-05-23 15:01:41.044636+03	core	RefBuildings	6	\N	{"srcName":"core.RefBuildings.c","srcPK":"6"}	Create data
392	1	1	2019-05-23 15:01:41.194963+03	core	RefBuildings	7	\N	{"srcName":"core.RefBuildings.c","srcPK":"7"}	Create data
393	1	1	2019-05-23 15:01:41.336631+03	core	RefBuildings	8	\N	{"srcName":"core.RefBuildings.c","srcPK":"8"}	Create data
394	1	1	2019-05-23 15:01:41.486808+03	core	RefBuildings	9	\N	{"srcName":"core.RefBuildings.c","srcPK":"9"}	Create data
395	1	1	2019-05-23 15:01:41.646066+03	core	RefBuildings	10	\N	{"srcName":"core.RefBuildings.c","srcPK":"10"}	Create data
396	1	1	2019-05-23 15:01:41.885653+03	core	RefBuildings	11	\N	{"srcName":"core.RefBuildings.c","srcPK":"11"}	Create data
397	1	1	2019-05-23 15:01:42.019301+03	core	RefBuildings	12	\N	{"srcName":"core.RefBuildings.c","srcPK":"12"}	Create data
398	1	1	2019-05-23 15:01:42.188363+03	core	RefBuildings	13	\N	{"srcName":"core.RefBuildings.c","srcPK":"13"}	Create data
399	1	1	2019-05-23 15:01:42.353354+03	core	RefBuildings	14	\N	{"srcName":"core.RefBuildings.c","srcPK":"14"}	Create data
401	1	1	2019-05-23 15:01:42.6368+03	core	RefBuildings	16	\N	{"srcName":"core.RefBuildings.c","srcPK":"16"}	Create data
403	1	1	2019-05-23 15:01:42.933154+03	core	RefBuildings	18	\N	{"srcName":"core.RefBuildings.c","srcPK":"18"}	Create data
405	1	1	2019-05-23 15:01:43.364309+03	core	RefBuildings	20	\N	{"srcName":"core.RefBuildings.c","srcPK":"20"}	Create data
407	1	1	2019-05-23 15:01:43.867023+03	core	RefBuildings	22	\N	{"srcName":"core.RefBuildings.c","srcPK":"22"}	Create data
409	1	1	2019-05-23 15:01:44.230572+03	core	RefBuildings	24	\N	{"srcName":"core.RefBuildings.c","srcPK":"24"}	Create data
411	1	1	2019-05-23 15:01:44.549415+03	core	RefBuildings	26	\N	{"srcName":"core.RefBuildings.c","srcPK":"26"}	Create data
413	1	1	2019-05-23 15:01:44.883018+03	core	RefBuildings	28	\N	{"srcName":"core.RefBuildings.c","srcPK":"28"}	Create data
415	1	1	2019-05-23 15:01:45.517246+03	core	RefBuildings	30	\N	{"srcName":"core.RefBuildings.c","srcPK":"30"}	Create data
417	1	1	2019-05-23 15:01:45.837863+03	core	RefBuildings	32	\N	{"srcName":"core.RefBuildings.c","srcPK":"32"}	Create data
419	1	1	2019-05-23 15:01:46.229904+03	core	RefBuildings	34	\N	{"srcName":"core.RefBuildings.c","srcPK":"34"}	Create data
421	1	1	2019-05-23 15:01:46.626521+03	core	RefBuildings	36	\N	{"srcName":"core.RefBuildings.c","srcPK":"36"}	Create data
423	1	1	2019-05-23 15:01:46.960659+03	core	RefBuildings	38	\N	{"srcName":"core.RefBuildings.c","srcPK":"38"}	Create data
425	1	1	2019-05-23 15:01:47.343075+03	core	RefBuildings	40	\N	{"srcName":"core.RefBuildings.c","srcPK":"40"}	Create data
427	1	1	2019-05-23 15:01:47.654231+03	core	RefBuildings	42	\N	{"srcName":"core.RefBuildings.c","srcPK":"42"}	Create data
429	1	1	2019-05-23 15:01:47.988256+03	core	RefBuildings	44	\N	{"srcName":"core.RefBuildings.c","srcPK":"44"}	Create data
431	1	1	2019-05-23 15:01:48.310813+03	core	RefBuildings	46	\N	{"srcName":"core.RefBuildings.c","srcPK":"46"}	Create data
433	1	1	2019-05-23 15:01:48.586577+03	core	RefBuildings	48	\N	{"srcName":"core.RefBuildings.c","srcPK":"48"}	Create data
435	1	1	2019-05-23 15:01:48.955316+03	core	RefBuildings	50	\N	{"srcName":"core.RefBuildings.c","srcPK":"50"}	Create data
437	1	1	2019-05-23 15:01:49.322021+03	core	RefBuildings	52	\N	{"srcName":"core.RefBuildings.c","srcPK":"52"}	Create data
439	1	1	2019-05-23 15:01:49.732815+03	core	RefBuildings	54	\N	{"srcName":"core.RefBuildings.c","srcPK":"54"}	Create data
441	1	1	2019-05-23 15:01:50.174843+03	core	RefBuildings	56	\N	{"srcName":"core.RefBuildings.c","srcPK":"56"}	Create data
443	1	1	2019-05-23 15:01:50.672304+03	core	RefBuildings	58	\N	{"srcName":"core.RefBuildings.c","srcPK":"58"}	Create data
445	1	1	2019-05-23 15:01:50.985433+03	core	RefBuildings	60	\N	{"srcName":"core.RefBuildings.c","srcPK":"60"}	Create data
447	1	1	2019-05-23 15:01:51.324284+03	core	RefBuildings	62	\N	{"srcName":"core.RefBuildings.c","srcPK":"62"}	Create data
449	1	1	2019-05-23 15:01:51.750206+03	core	RefBuildings	64	\N	{"srcName":"core.RefBuildings.c","srcPK":"64"}	Create data
451	1	1	2019-05-23 15:01:52.10093+03	core	RefBuildings	66	\N	{"srcName":"core.RefBuildings.c","srcPK":"66"}	Create data
453	1	1	2019-05-23 15:01:52.411954+03	core	RefBuildings	68	\N	{"srcName":"core.RefBuildings.c","srcPK":"68"}	Create data
455	1	1	2019-05-23 15:01:52.712716+03	core	RefBuildings	70	\N	{"srcName":"core.RefBuildings.c","srcPK":"70"}	Create data
457	1	1	2019-05-23 15:01:53.024968+03	core	RefBuildings	72	\N	{"srcName":"core.RefBuildings.c","srcPK":"72"}	Create data
459	1	1	2019-05-23 15:01:53.311733+03	core	RefBuildings	74	\N	{"srcName":"core.RefBuildings.c","srcPK":"74"}	Create data
461	1	1	2019-05-23 15:01:53.67781+03	core	RefBuildings	76	\N	{"srcName":"core.RefBuildings.c","srcPK":"76"}	Create data
463	1	1	2019-05-23 15:01:53.986407+03	core	RefBuildings	78	\N	{"srcName":"core.RefBuildings.c","srcPK":"78"}	Create data
465	1	1	2019-05-23 15:01:54.652173+03	core	RefBuildings	80	\N	{"srcName":"core.RefBuildings.c","srcPK":"80"}	Create data
467	1	1	2019-05-23 15:01:55.003742+03	core	RefBuildings	82	\N	{"srcName":"core.RefBuildings.c","srcPK":"82"}	Create data
469	1	1	2019-05-23 15:01:55.336702+03	core	RefBuildings	84	\N	{"srcName":"core.RefBuildings.c","srcPK":"84"}	Create data
471	1	1	2019-05-23 15:01:55.846903+03	core	RefBuildings	86	\N	{"srcName":"core.RefBuildings.c","srcPK":"86"}	Create data
473	1	1	2019-05-23 15:01:56.19787+03	core	RefBuildings	88	\N	{"srcName":"core.RefBuildings.c","srcPK":"88"}	Create data
475	1	1	2019-05-23 15:01:56.506859+03	core	RefBuildings	90	\N	{"srcName":"core.RefBuildings.c","srcPK":"90"}	Create data
477	1	1	2019-05-23 15:01:56.91542+03	core	RefBuildings	92	\N	{"srcName":"core.RefBuildings.c","srcPK":"92"}	Create data
479	1	1	2019-05-23 15:01:57.274537+03	core	RefBuildings	94	\N	{"srcName":"core.RefBuildings.c","srcPK":"94"}	Create data
481	1	1	2019-05-23 15:01:57.632764+03	core	RefBuildings	96	\N	{"srcName":"core.RefBuildings.c","srcPK":"96"}	Create data
483	1	1	2019-05-23 15:01:58.124563+03	core	RefBuildings	98	\N	{"srcName":"core.RefBuildings.c","srcPK":"98"}	Create data
485	1	1	2019-05-23 15:01:58.484019+03	core	RefBuildings	100	\N	{"srcName":"core.RefBuildings.c","srcPK":"100"}	Create data
487	1	1	2019-05-23 15:01:58.85496+03	core	RefBuildings	102	\N	{"srcName":"core.RefBuildings.c","srcPK":"102"}	Create data
489	1	1	2019-05-23 15:01:59.224537+03	core	RefBuildings	104	\N	{"srcName":"core.RefBuildings.c","srcPK":"104"}	Create data
491	1	1	2019-05-23 15:01:59.576637+03	core	RefBuildings	106	\N	{"srcName":"core.RefBuildings.c","srcPK":"106"}	Create data
493	1	1	2019-05-23 15:01:59.883685+03	core	RefBuildings	108	\N	{"srcName":"core.RefBuildings.c","srcPK":"108"}	Create data
495	1	1	2019-05-23 15:02:00.201934+03	core	RefBuildings	110	\N	{"srcName":"core.RefBuildings.c","srcPK":"110"}	Create data
497	1	1	2019-05-23 15:02:00.669242+03	core	RefBuildings	112	\N	{"srcName":"core.RefBuildings.c","srcPK":"112"}	Create data
499	1	1	2019-05-23 15:02:01.027599+03	core	RefBuildings	114	\N	{"srcName":"core.RefBuildings.c","srcPK":"114"}	Create data
501	1	1	2019-05-23 15:02:01.47077+03	core	RefBuildings	116	\N	{"srcName":"core.RefBuildings.c","srcPK":"116"}	Create data
400	1	1	2019-05-23 15:01:42.473093+03	core	RefBuildings	15	\N	{"srcName":"core.RefBuildings.c","srcPK":"15"}	Create data
402	1	1	2019-05-23 15:01:42.772171+03	core	RefBuildings	17	\N	{"srcName":"core.RefBuildings.c","srcPK":"17"}	Create data
404	1	1	2019-05-23 15:01:43.149912+03	core	RefBuildings	19	\N	{"srcName":"core.RefBuildings.c","srcPK":"19"}	Create data
406	1	1	2019-05-23 15:01:43.522015+03	core	RefBuildings	21	\N	{"srcName":"core.RefBuildings.c","srcPK":"21"}	Create data
408	1	1	2019-05-23 15:01:44.075603+03	core	RefBuildings	23	\N	{"srcName":"core.RefBuildings.c","srcPK":"23"}	Create data
410	1	1	2019-05-23 15:01:44.391121+03	core	RefBuildings	25	\N	{"srcName":"core.RefBuildings.c","srcPK":"25"}	Create data
412	1	1	2019-05-23 15:01:44.697818+03	core	RefBuildings	27	\N	{"srcName":"core.RefBuildings.c","srcPK":"27"}	Create data
414	1	1	2019-05-23 15:01:45.168656+03	core	RefBuildings	29	\N	{"srcName":"core.RefBuildings.c","srcPK":"29"}	Create data
416	1	1	2019-05-23 15:01:45.668835+03	core	RefBuildings	31	\N	{"srcName":"core.RefBuildings.c","srcPK":"31"}	Create data
418	1	1	2019-05-23 15:01:46.068929+03	core	RefBuildings	33	\N	{"srcName":"core.RefBuildings.c","srcPK":"33"}	Create data
420	1	1	2019-05-23 15:01:46.434463+03	core	RefBuildings	35	\N	{"srcName":"core.RefBuildings.c","srcPK":"35"}	Create data
422	1	1	2019-05-23 15:01:46.810108+03	core	RefBuildings	37	\N	{"srcName":"core.RefBuildings.c","srcPK":"37"}	Create data
424	1	1	2019-05-23 15:01:47.154021+03	core	RefBuildings	39	\N	{"srcName":"core.RefBuildings.c","srcPK":"39"}	Create data
426	1	1	2019-05-23 15:01:47.495218+03	core	RefBuildings	41	\N	{"srcName":"core.RefBuildings.c","srcPK":"41"}	Create data
428	1	1	2019-05-23 15:01:47.828811+03	core	RefBuildings	43	\N	{"srcName":"core.RefBuildings.c","srcPK":"43"}	Create data
430	1	1	2019-05-23 15:01:48.143618+03	core	RefBuildings	45	\N	{"srcName":"core.RefBuildings.c","srcPK":"45"}	Create data
432	1	1	2019-05-23 15:01:48.444265+03	core	RefBuildings	47	\N	{"srcName":"core.RefBuildings.c","srcPK":"47"}	Create data
434	1	1	2019-05-23 15:01:48.765343+03	core	RefBuildings	49	\N	{"srcName":"core.RefBuildings.c","srcPK":"49"}	Create data
436	1	1	2019-05-23 15:01:49.114563+03	core	RefBuildings	51	\N	{"srcName":"core.RefBuildings.c","srcPK":"51"}	Create data
438	1	1	2019-05-23 15:01:49.547576+03	core	RefBuildings	53	\N	{"srcName":"core.RefBuildings.c","srcPK":"53"}	Create data
440	1	1	2019-05-23 15:01:49.997829+03	core	RefBuildings	55	\N	{"srcName":"core.RefBuildings.c","srcPK":"55"}	Create data
442	1	1	2019-05-23 15:01:50.523837+03	core	RefBuildings	57	\N	{"srcName":"core.RefBuildings.c","srcPK":"57"}	Create data
444	1	1	2019-05-23 15:01:50.840459+03	core	RefBuildings	59	\N	{"srcName":"core.RefBuildings.c","srcPK":"59"}	Create data
446	1	1	2019-05-23 15:01:51.182218+03	core	RefBuildings	61	\N	{"srcName":"core.RefBuildings.c","srcPK":"61"}	Create data
448	1	1	2019-05-23 15:01:51.534253+03	core	RefBuildings	63	\N	{"srcName":"core.RefBuildings.c","srcPK":"63"}	Create data
450	1	1	2019-05-23 15:01:51.899+03	core	RefBuildings	65	\N	{"srcName":"core.RefBuildings.c","srcPK":"65"}	Create data
452	1	1	2019-05-23 15:01:52.276274+03	core	RefBuildings	67	\N	{"srcName":"core.RefBuildings.c","srcPK":"67"}	Create data
454	1	1	2019-05-23 15:01:52.57384+03	core	RefBuildings	69	\N	{"srcName":"core.RefBuildings.c","srcPK":"69"}	Create data
456	1	1	2019-05-23 15:01:52.88325+03	core	RefBuildings	71	\N	{"srcName":"core.RefBuildings.c","srcPK":"71"}	Create data
458	1	1	2019-05-23 15:01:53.168734+03	core	RefBuildings	73	\N	{"srcName":"core.RefBuildings.c","srcPK":"73"}	Create data
460	1	1	2019-05-23 15:01:53.469688+03	core	RefBuildings	75	\N	{"srcName":"core.RefBuildings.c","srcPK":"75"}	Create data
462	1	1	2019-05-23 15:01:53.836141+03	core	RefBuildings	77	\N	{"srcName":"core.RefBuildings.c","srcPK":"77"}	Create data
464	1	1	2019-05-23 15:01:54.357703+03	core	RefBuildings	79	\N	{"srcName":"core.RefBuildings.c","srcPK":"79"}	Create data
466	1	1	2019-05-23 15:01:54.845932+03	core	RefBuildings	81	\N	{"srcName":"core.RefBuildings.c","srcPK":"81"}	Create data
468	1	1	2019-05-23 15:01:55.187564+03	core	RefBuildings	83	\N	{"srcName":"core.RefBuildings.c","srcPK":"83"}	Create data
470	1	1	2019-05-23 15:01:55.696125+03	core	RefBuildings	85	\N	{"srcName":"core.RefBuildings.c","srcPK":"85"}	Create data
472	1	1	2019-05-23 15:01:56.00624+03	core	RefBuildings	87	\N	{"srcName":"core.RefBuildings.c","srcPK":"87"}	Create data
474	1	1	2019-05-23 15:01:56.356041+03	core	RefBuildings	89	\N	{"srcName":"core.RefBuildings.c","srcPK":"89"}	Create data
476	1	1	2019-05-23 15:01:56.706608+03	core	RefBuildings	91	\N	{"srcName":"core.RefBuildings.c","srcPK":"91"}	Create data
478	1	1	2019-05-23 15:01:57.097098+03	core	RefBuildings	93	\N	{"srcName":"core.RefBuildings.c","srcPK":"93"}	Create data
480	1	1	2019-05-23 15:01:57.474538+03	core	RefBuildings	95	\N	{"srcName":"core.RefBuildings.c","srcPK":"95"}	Create data
482	1	1	2019-05-23 15:01:57.8332+03	core	RefBuildings	97	\N	{"srcName":"core.RefBuildings.c","srcPK":"97"}	Create data
484	1	1	2019-05-23 15:01:58.308531+03	core	RefBuildings	99	\N	{"srcName":"core.RefBuildings.c","srcPK":"99"}	Create data
486	1	1	2019-05-23 15:01:58.654005+03	core	RefBuildings	101	\N	{"srcName":"core.RefBuildings.c","srcPK":"101"}	Create data
488	1	1	2019-05-23 15:01:59.013164+03	core	RefBuildings	103	\N	{"srcName":"core.RefBuildings.c","srcPK":"103"}	Create data
490	1	1	2019-05-23 15:01:59.377038+03	core	RefBuildings	105	\N	{"srcName":"core.RefBuildings.c","srcPK":"105"}	Create data
492	1	1	2019-05-23 15:01:59.735273+03	core	RefBuildings	107	\N	{"srcName":"core.RefBuildings.c","srcPK":"107"}	Create data
494	1	1	2019-05-23 15:02:00.060042+03	core	RefBuildings	109	\N	{"srcName":"core.RefBuildings.c","srcPK":"109"}	Create data
496	1	1	2019-05-23 15:02:00.343975+03	core	RefBuildings	111	\N	{"srcName":"core.RefBuildings.c","srcPK":"111"}	Create data
498	1	1	2019-05-23 15:02:00.855293+03	core	RefBuildings	113	\N	{"srcName":"core.RefBuildings.c","srcPK":"113"}	Create data
500	1	1	2019-05-23 15:02:01.253153+03	core	RefBuildings	115	\N	{"srcName":"core.RefBuildings.c","srcPK":"115"}	Create data
502	1	1	2019-05-23 15:02:01.645949+03	core	RefBuildings	117	\N	{"srcName":"core.RefBuildings.c","srcPK":"117"}	Create data
503	1	1	2019-05-23 15:02:01.856731+03	core	RefBuildings	118	\N	{"srcName":"core.RefBuildings.c","srcPK":"118"}	Create data
505	1	1	2019-05-23 15:02:02.246348+03	core	RefBuildings	120	\N	{"srcName":"core.RefBuildings.c","srcPK":"120"}	Create data
507	1	1	2019-05-23 15:02:02.672346+03	core	RefBuildings	122	\N	{"srcName":"core.RefBuildings.c","srcPK":"122"}	Create data
509	1	1	2019-05-23 15:02:03.0724+03	core	RefBuildings	124	\N	{"srcName":"core.RefBuildings.c","srcPK":"124"}	Create data
511	1	1	2019-05-23 15:02:03.412154+03	core	RefBuildings	126	\N	{"srcName":"core.RefBuildings.c","srcPK":"126"}	Create data
513	1	1	2019-05-23 15:02:03.754242+03	core	RefBuildings	128	\N	{"srcName":"core.RefBuildings.c","srcPK":"128"}	Create data
515	1	1	2019-05-23 15:02:04.121055+03	core	RefBuildings	130	\N	{"srcName":"core.RefBuildings.c","srcPK":"130"}	Create data
517	1	1	2019-05-23 15:02:04.46666+03	core	RefBuildings	132	\N	{"srcName":"core.RefBuildings.c","srcPK":"132"}	Create data
519	1	1	2019-05-23 15:02:05.090233+03	core	RefBuildings	134	\N	{"srcName":"core.RefBuildings.c","srcPK":"134"}	Create data
521	1	1	2019-05-23 15:02:05.583138+03	core	RefBuildings	136	\N	{"srcName":"core.RefBuildings.c","srcPK":"136"}	Create data
523	1	1	2019-05-23 15:02:05.983124+03	core	RefBuildings	138	\N	{"srcName":"core.RefBuildings.c","srcPK":"138"}	Create data
525	1	1	2019-05-23 15:02:06.291574+03	core	RefBuildings	140	\N	{"srcName":"core.RefBuildings.c","srcPK":"140"}	Create data
527	1	1	2019-05-23 15:02:06.588813+03	core	RefBuildings	142	\N	{"srcName":"core.RefBuildings.c","srcPK":"142"}	Create data
529	1	1	2019-05-23 15:02:06.885496+03	core	RefBuildings	144	\N	{"srcName":"core.RefBuildings.c","srcPK":"144"}	Create data
531	1	1	2019-05-23 15:02:07.234218+03	core	RefBuildings	146	\N	{"srcName":"core.RefBuildings.c","srcPK":"146"}	Create data
533	1	1	2019-05-23 15:02:07.540624+03	core	RefBuildings	148	\N	{"srcName":"core.RefBuildings.c","srcPK":"148"}	Create data
535	1	1	2019-05-23 15:02:07.887164+03	core	RefBuildings	150	\N	{"srcName":"core.RefBuildings.c","srcPK":"150"}	Create data
537	1	1	2019-05-23 15:02:08.236829+03	core	RefBuildings	152	\N	{"srcName":"core.RefBuildings.c","srcPK":"152"}	Create data
539	1	1	2019-05-23 15:02:08.616615+03	core	RefBuildings	154	\N	{"srcName":"core.RefBuildings.c","srcPK":"154"}	Create data
541	1	1	2019-05-23 15:02:08.944952+03	core	RefBuildings	156	\N	{"srcName":"core.RefBuildings.c","srcPK":"156"}	Create data
543	1	1	2019-05-23 15:02:09.69729+03	core	RefBuildings	158	\N	{"srcName":"core.RefBuildings.c","srcPK":"158"}	Create data
545	1	1	2019-05-23 15:02:10.031023+03	core	RefBuildings	160	\N	{"srcName":"core.RefBuildings.c","srcPK":"160"}	Create data
547	1	1	2019-05-23 15:02:10.332802+03	core	RefBuildings	162	\N	{"srcName":"core.RefBuildings.c","srcPK":"162"}	Create data
549	1	1	2019-05-23 15:02:10.863731+03	core	RefBuildings	164	\N	{"srcName":"core.RefBuildings.c","srcPK":"164"}	Create data
551	1	1	2019-05-23 15:02:11.238782+03	core	RefBuildings	166	\N	{"srcName":"core.RefBuildings.c","srcPK":"166"}	Create data
553	1	1	2019-05-23 15:02:11.616208+03	core	RefBuildings	168	\N	{"srcName":"core.RefBuildings.c","srcPK":"168"}	Create data
555	1	1	2019-05-23 15:02:12.024517+03	core	RefBuildings	170	\N	{"srcName":"core.RefBuildings.c","srcPK":"170"}	Create data
557	1	1	2019-05-23 15:02:12.401141+03	core	RefBuildings	172	\N	{"srcName":"core.RefBuildings.c","srcPK":"172"}	Create data
559	1	1	2019-05-23 15:02:12.809205+03	core	RefBuildings	174	\N	{"srcName":"core.RefBuildings.c","srcPK":"174"}	Create data
561	1	1	2019-05-23 15:02:13.100702+03	core	RefBuildings	176	\N	{"srcName":"core.RefBuildings.c","srcPK":"176"}	Create data
563	1	1	2019-05-23 15:02:13.4178+03	core	RefBuildings	178	\N	{"srcName":"core.RefBuildings.c","srcPK":"178"}	Create data
565	1	1	2019-05-23 15:02:13.733909+03	core	RefBuildings	180	\N	{"srcName":"core.RefBuildings.c","srcPK":"180"}	Create data
567	1	1	2019-05-23 15:02:14.041253+03	core	RefBuildings	182	\N	{"srcName":"core.RefBuildings.c","srcPK":"182"}	Create data
569	1	1	2019-05-23 15:02:14.353168+03	core	RefBuildings	184	\N	{"srcName":"core.RefBuildings.c","srcPK":"184"}	Create data
571	1	1	2019-05-23 15:02:14.798547+03	core	RefBuildings	186	\N	{"srcName":"core.RefBuildings.c","srcPK":"186"}	Create data
573	1	1	2019-05-23 15:02:15.456269+03	core	RefBuildings	188	\N	{"srcName":"core.RefBuildings.c","srcPK":"188"}	Create data
575	1	1	2019-05-23 15:02:15.951968+03	core	RefBuildings	190	\N	{"srcName":"core.RefBuildings.c","srcPK":"190"}	Create data
577	1	1	2019-05-23 15:02:16.375667+03	core	RefBuildings	192	\N	{"srcName":"core.RefBuildings.c","srcPK":"192"}	Create data
579	1	1	2019-05-23 15:02:16.683792+03	core	RefBuildings	194	\N	{"srcName":"core.RefBuildings.c","srcPK":"194"}	Create data
581	1	1	2019-05-23 15:02:16.982925+03	core	RefBuildings	196	\N	{"srcName":"core.RefBuildings.c","srcPK":"196"}	Create data
583	1	1	2019-05-23 15:02:17.334337+03	core	RefBuildings	198	\N	{"srcName":"core.RefBuildings.c","srcPK":"198"}	Create data
585	1	1	2019-05-23 15:02:17.683769+03	core	RefBuildings	200	\N	{"srcName":"core.RefBuildings.c","srcPK":"200"}	Create data
587	1	1	2019-05-23 15:02:18.051306+03	core	RefBuildings	202	\N	{"srcName":"core.RefBuildings.c","srcPK":"202"}	Create data
589	1	1	2019-05-23 15:02:18.352889+03	core	RefBuildings	204	\N	{"srcName":"core.RefBuildings.c","srcPK":"204"}	Create data
591	1	1	2019-05-23 15:02:18.68462+03	core	RefBuildings	206	\N	{"srcName":"core.RefBuildings.c","srcPK":"206"}	Create data
593	1	1	2019-05-23 15:02:19.011873+03	core	RefBuildings	208	\N	{"srcName":"core.RefBuildings.c","srcPK":"208"}	Create data
595	1	1	2019-05-23 15:02:19.512245+03	core	RefBuildings	210	\N	{"srcName":"core.RefBuildings.c","srcPK":"210"}	Create data
597	1	1	2019-05-23 15:02:20.020714+03	core	RefBuildings	212	\N	{"srcName":"core.RefBuildings.c","srcPK":"212"}	Create data
599	1	1	2019-05-23 15:02:20.378305+03	core	RefBuildings	214	\N	{"srcName":"core.RefBuildings.c","srcPK":"214"}	Create data
601	1	1	2019-05-23 15:02:20.844005+03	core	RefBuildings	216	\N	{"srcName":"core.RefBuildings.c","srcPK":"216"}	Create data
603	1	1	2019-05-23 15:02:21.212973+03	core	RefBuildings	218	\N	{"srcName":"core.RefBuildings.c","srcPK":"218"}	Create data
605	1	1	2019-05-23 15:02:21.680157+03	core	RefBuildings	220	\N	{"srcName":"core.RefBuildings.c","srcPK":"220"}	Create data
504	1	1	2019-05-23 15:02:02.038429+03	core	RefBuildings	119	\N	{"srcName":"core.RefBuildings.c","srcPK":"119"}	Create data
506	1	1	2019-05-23 15:02:02.521659+03	core	RefBuildings	121	\N	{"srcName":"core.RefBuildings.c","srcPK":"121"}	Create data
508	1	1	2019-05-23 15:02:02.889312+03	core	RefBuildings	123	\N	{"srcName":"core.RefBuildings.c","srcPK":"123"}	Create data
510	1	1	2019-05-23 15:02:03.275315+03	core	RefBuildings	125	\N	{"srcName":"core.RefBuildings.c","srcPK":"125"}	Create data
512	1	1	2019-05-23 15:02:03.554025+03	core	RefBuildings	127	\N	{"srcName":"core.RefBuildings.c","srcPK":"127"}	Create data
514	1	1	2019-05-23 15:02:03.956806+03	core	RefBuildings	129	\N	{"srcName":"core.RefBuildings.c","srcPK":"129"}	Create data
516	1	1	2019-05-23 15:02:04.265461+03	core	RefBuildings	131	\N	{"srcName":"core.RefBuildings.c","srcPK":"131"}	Create data
518	1	1	2019-05-23 15:02:04.634075+03	core	RefBuildings	133	\N	{"srcName":"core.RefBuildings.c","srcPK":"133"}	Create data
520	1	1	2019-05-23 15:02:05.241765+03	core	RefBuildings	135	\N	{"srcName":"core.RefBuildings.c","srcPK":"135"}	Create data
522	1	1	2019-05-23 15:02:05.783824+03	core	RefBuildings	137	\N	{"srcName":"core.RefBuildings.c","srcPK":"137"}	Create data
524	1	1	2019-05-23 15:02:06.138958+03	core	RefBuildings	139	\N	{"srcName":"core.RefBuildings.c","srcPK":"139"}	Create data
526	1	1	2019-05-23 15:02:06.434034+03	core	RefBuildings	141	\N	{"srcName":"core.RefBuildings.c","srcPK":"141"}	Create data
528	1	1	2019-05-23 15:02:06.733838+03	core	RefBuildings	143	\N	{"srcName":"core.RefBuildings.c","srcPK":"143"}	Create data
530	1	1	2019-05-23 15:02:07.076853+03	core	RefBuildings	145	\N	{"srcName":"core.RefBuildings.c","srcPK":"145"}	Create data
532	1	1	2019-05-23 15:02:07.385843+03	core	RefBuildings	147	\N	{"srcName":"core.RefBuildings.c","srcPK":"147"}	Create data
534	1	1	2019-05-23 15:02:07.692132+03	core	RefBuildings	149	\N	{"srcName":"core.RefBuildings.c","srcPK":"149"}	Create data
536	1	1	2019-05-23 15:02:08.079169+03	core	RefBuildings	151	\N	{"srcName":"core.RefBuildings.c","srcPK":"151"}	Create data
538	1	1	2019-05-23 15:02:08.379367+03	core	RefBuildings	153	\N	{"srcName":"core.RefBuildings.c","srcPK":"153"}	Create data
540	1	1	2019-05-23 15:02:08.782945+03	core	RefBuildings	155	\N	{"srcName":"core.RefBuildings.c","srcPK":"155"}	Create data
542	1	1	2019-05-23 15:02:09.426209+03	core	RefBuildings	157	\N	{"srcName":"core.RefBuildings.c","srcPK":"157"}	Create data
544	1	1	2019-05-23 15:02:09.8726+03	core	RefBuildings	159	\N	{"srcName":"core.RefBuildings.c","srcPK":"159"}	Create data
546	1	1	2019-05-23 15:02:10.188291+03	core	RefBuildings	161	\N	{"srcName":"core.RefBuildings.c","srcPK":"161"}	Create data
548	1	1	2019-05-23 15:02:10.707717+03	core	RefBuildings	163	\N	{"srcName":"core.RefBuildings.c","srcPK":"163"}	Create data
550	1	1	2019-05-23 15:02:11.015604+03	core	RefBuildings	165	\N	{"srcName":"core.RefBuildings.c","srcPK":"165"}	Create data
552	1	1	2019-05-23 15:02:11.433986+03	core	RefBuildings	167	\N	{"srcName":"core.RefBuildings.c","srcPK":"167"}	Create data
554	1	1	2019-05-23 15:02:11.874914+03	core	RefBuildings	169	\N	{"srcName":"core.RefBuildings.c","srcPK":"169"}	Create data
556	1	1	2019-05-23 15:02:12.250706+03	core	RefBuildings	171	\N	{"srcName":"core.RefBuildings.c","srcPK":"171"}	Create data
558	1	1	2019-05-23 15:02:12.55932+03	core	RefBuildings	173	\N	{"srcName":"core.RefBuildings.c","srcPK":"173"}	Create data
560	1	1	2019-05-23 15:02:12.949988+03	core	RefBuildings	175	\N	{"srcName":"core.RefBuildings.c","srcPK":"175"}	Create data
562	1	1	2019-05-23 15:02:13.252481+03	core	RefBuildings	177	\N	{"srcName":"core.RefBuildings.c","srcPK":"177"}	Create data
564	1	1	2019-05-23 15:02:13.576187+03	core	RefBuildings	179	\N	{"srcName":"core.RefBuildings.c","srcPK":"179"}	Create data
566	1	1	2019-05-23 15:02:13.879119+03	core	RefBuildings	181	\N	{"srcName":"core.RefBuildings.c","srcPK":"181"}	Create data
568	1	1	2019-05-23 15:02:14.211002+03	core	RefBuildings	183	\N	{"srcName":"core.RefBuildings.c","srcPK":"183"}	Create data
570	1	1	2019-05-23 15:02:14.539649+03	core	RefBuildings	185	\N	{"srcName":"core.RefBuildings.c","srcPK":"185"}	Create data
572	1	1	2019-05-23 15:02:15.256499+03	core	RefBuildings	187	\N	{"srcName":"core.RefBuildings.c","srcPK":"187"}	Create data
574	1	1	2019-05-23 15:02:15.794209+03	core	RefBuildings	189	\N	{"srcName":"core.RefBuildings.c","srcPK":"189"}	Create data
576	1	1	2019-05-23 15:02:16.136907+03	core	RefBuildings	191	\N	{"srcName":"core.RefBuildings.c","srcPK":"191"}	Create data
578	1	1	2019-05-23 15:02:16.534577+03	core	RefBuildings	193	\N	{"srcName":"core.RefBuildings.c","srcPK":"193"}	Create data
580	1	1	2019-05-23 15:02:16.839304+03	core	RefBuildings	195	\N	{"srcName":"core.RefBuildings.c","srcPK":"195"}	Create data
582	1	1	2019-05-23 15:02:17.124508+03	core	RefBuildings	197	\N	{"srcName":"core.RefBuildings.c","srcPK":"197"}	Create data
584	1	1	2019-05-23 15:02:17.533507+03	core	RefBuildings	199	\N	{"srcName":"core.RefBuildings.c","srcPK":"199"}	Create data
586	1	1	2019-05-23 15:02:17.833826+03	core	RefBuildings	201	\N	{"srcName":"core.RefBuildings.c","srcPK":"201"}	Create data
588	1	1	2019-05-23 15:02:18.209504+03	core	RefBuildings	203	\N	{"srcName":"core.RefBuildings.c","srcPK":"203"}	Create data
590	1	1	2019-05-23 15:02:18.533326+03	core	RefBuildings	205	\N	{"srcName":"core.RefBuildings.c","srcPK":"205"}	Create data
592	1	1	2019-05-23 15:02:18.860081+03	core	RefBuildings	207	\N	{"srcName":"core.RefBuildings.c","srcPK":"207"}	Create data
594	1	1	2019-05-23 15:02:19.342647+03	core	RefBuildings	209	\N	{"srcName":"core.RefBuildings.c","srcPK":"209"}	Create data
596	1	1	2019-05-23 15:02:19.694807+03	core	RefBuildings	211	\N	{"srcName":"core.RefBuildings.c","srcPK":"211"}	Create data
598	1	1	2019-05-23 15:02:20.212888+03	core	RefBuildings	213	\N	{"srcName":"core.RefBuildings.c","srcPK":"213"}	Create data
600	1	1	2019-05-23 15:02:20.57075+03	core	RefBuildings	215	\N	{"srcName":"core.RefBuildings.c","srcPK":"215"}	Create data
602	1	1	2019-05-23 15:02:21.004407+03	core	RefBuildings	217	\N	{"srcName":"core.RefBuildings.c","srcPK":"217"}	Create data
604	1	1	2019-05-23 15:02:21.421269+03	core	RefBuildings	219	\N	{"srcName":"core.RefBuildings.c","srcPK":"219"}	Create data
606	1	1	2019-05-23 15:02:21.972752+03	core	RefBuildings	221	\N	{"srcName":"core.RefBuildings.c","srcPK":"221"}	Create data
607	1	1	2019-05-23 15:02:22.222951+03	core	RefBuildings	222	\N	{"srcName":"core.RefBuildings.c","srcPK":"222"}	Create data
609	1	1	2019-05-23 15:02:22.705983+03	core	RefBuildings	224	\N	{"srcName":"core.RefBuildings.c","srcPK":"224"}	Create data
611	1	1	2019-05-23 15:02:23.040048+03	core	RefBuildings	226	\N	{"srcName":"core.RefBuildings.c","srcPK":"226"}	Create data
613	1	1	2019-05-23 15:02:23.399916+03	core	RefBuildings	228	\N	{"srcName":"core.RefBuildings.c","srcPK":"228"}	Create data
615	1	1	2019-05-23 15:02:23.748098+03	core	RefBuildings	230	\N	{"srcName":"core.RefBuildings.c","srcPK":"230"}	Create data
617	1	1	2019-05-23 15:02:24.107418+03	core	RefBuildings	232	\N	{"srcName":"core.RefBuildings.c","srcPK":"232"}	Create data
619	1	1	2019-05-23 15:02:24.498891+03	core	RefBuildings	234	\N	{"srcName":"core.RefBuildings.c","srcPK":"234"}	Create data
621	1	1	2019-05-23 15:02:24.857929+03	core	RefBuildings	236	\N	{"srcName":"core.RefBuildings.c","srcPK":"236"}	Create data
623	1	1	2019-05-23 15:02:25.220103+03	core	RefBuildings	238	\N	{"srcName":"core.RefBuildings.c","srcPK":"238"}	Create data
625	1	1	2019-05-23 15:02:26.06299+03	core	RefBuildings	240	\N	{"srcName":"core.RefBuildings.c","srcPK":"240"}	Create data
627	1	1	2019-05-23 15:02:26.429285+03	core	RefBuildings	242	\N	{"srcName":"core.RefBuildings.c","srcPK":"242"}	Create data
629	1	1	2019-05-23 15:02:26.769464+03	core	RefBuildings	244	\N	{"srcName":"core.RefBuildings.c","srcPK":"244"}	Create data
631	1	1	2019-05-23 15:02:27.154481+03	core	RefBuildings	246	\N	{"srcName":"core.RefBuildings.c","srcPK":"246"}	Create data
633	1	1	2019-05-23 15:02:27.586963+03	core	RefBuildings	248	\N	{"srcName":"core.RefBuildings.c","srcPK":"248"}	Create data
635	1	1	2019-05-23 15:02:28.080032+03	core	RefBuildings	250	\N	{"srcName":"core.RefBuildings.c","srcPK":"250"}	Create data
637	1	1	2019-05-23 15:02:28.55753+03	core	RefBuildings	252	\N	{"srcName":"core.RefBuildings.c","srcPK":"252"}	Create data
639	1	1	2019-05-23 15:02:28.861899+03	core	RefBuildings	254	\N	{"srcName":"core.RefBuildings.c","srcPK":"254"}	Create data
641	1	1	2019-05-23 15:02:29.197123+03	core	RefBuildings	256	\N	{"srcName":"core.RefBuildings.c","srcPK":"256"}	Create data
643	1	1	2019-05-23 15:02:29.505927+03	core	RefBuildings	258	\N	{"srcName":"core.RefBuildings.c","srcPK":"258"}	Create data
645	1	1	2019-05-23 15:02:29.814982+03	core	RefBuildings	260	\N	{"srcName":"core.RefBuildings.c","srcPK":"260"}	Create data
647	1	1	2019-05-23 15:02:30.415934+03	core	RefBuildings	262	\N	{"srcName":"core.RefBuildings.c","srcPK":"262"}	Create data
649	1	1	2019-05-23 15:02:30.940841+03	core	RefBuildings	264	\N	{"srcName":"core.RefBuildings.c","srcPK":"264"}	Create data
651	1	1	2019-05-23 15:02:31.308212+03	core	RefBuildings	266	\N	{"srcName":"core.RefBuildings.c","srcPK":"266"}	Create data
653	1	1	2019-05-23 15:02:31.641573+03	core	RefBuildings	268	\N	{"srcName":"core.RefBuildings.c","srcPK":"268"}	Create data
655	1	1	2019-05-23 15:02:31.980511+03	core	RefBuildings	270	\N	{"srcName":"core.RefBuildings.c","srcPK":"270"}	Create data
657	1	1	2019-05-23 15:02:32.318256+03	core	RefBuildings	272	\N	{"srcName":"core.RefBuildings.c","srcPK":"272"}	Create data
659	1	1	2019-05-23 15:02:32.709635+03	core	RefBuildings	274	\N	{"srcName":"core.RefBuildings.c","srcPK":"274"}	Create data
661	1	1	2019-05-23 15:02:33.085678+03	core	RefBuildings	276	\N	{"srcName":"core.RefBuildings.c","srcPK":"276"}	Create data
663	1	1	2019-05-23 15:02:33.452082+03	core	RefBuildings	278	\N	{"srcName":"core.RefBuildings.c","srcPK":"278"}	Create data
665	1	1	2019-05-23 15:02:33.80282+03	core	RefBuildings	280	\N	{"srcName":"core.RefBuildings.c","srcPK":"280"}	Create data
667	1	1	2019-05-23 15:02:34.219873+03	core	RefBuildings	282	\N	{"srcName":"core.RefBuildings.c","srcPK":"282"}	Create data
669	1	1	2019-05-23 15:02:34.603047+03	core	RefBuildings	284	\N	{"srcName":"core.RefBuildings.c","srcPK":"284"}	Create data
608	1	1	2019-05-23 15:02:22.515133+03	core	RefBuildings	223	\N	{"srcName":"core.RefBuildings.c","srcPK":"223"}	Create data
610	1	1	2019-05-23 15:02:22.890331+03	core	RefBuildings	225	\N	{"srcName":"core.RefBuildings.c","srcPK":"225"}	Create data
612	1	1	2019-05-23 15:02:23.223789+03	core	RefBuildings	227	\N	{"srcName":"core.RefBuildings.c","srcPK":"227"}	Create data
614	1	1	2019-05-23 15:02:23.599045+03	core	RefBuildings	229	\N	{"srcName":"core.RefBuildings.c","srcPK":"229"}	Create data
616	1	1	2019-05-23 15:02:23.920081+03	core	RefBuildings	231	\N	{"srcName":"core.RefBuildings.c","srcPK":"231"}	Create data
618	1	1	2019-05-23 15:02:24.308957+03	core	RefBuildings	233	\N	{"srcName":"core.RefBuildings.c","srcPK":"233"}	Create data
620	1	1	2019-05-23 15:02:24.669196+03	core	RefBuildings	235	\N	{"srcName":"core.RefBuildings.c","srcPK":"235"}	Create data
622	1	1	2019-05-23 15:02:25.037992+03	core	RefBuildings	237	\N	{"srcName":"core.RefBuildings.c","srcPK":"237"}	Create data
624	1	1	2019-05-23 15:02:25.654256+03	core	RefBuildings	239	\N	{"srcName":"core.RefBuildings.c","srcPK":"239"}	Create data
626	1	1	2019-05-23 15:02:26.228432+03	core	RefBuildings	241	\N	{"srcName":"core.RefBuildings.c","srcPK":"241"}	Create data
628	1	1	2019-05-23 15:02:26.60317+03	core	RefBuildings	243	\N	{"srcName":"core.RefBuildings.c","srcPK":"243"}	Create data
630	1	1	2019-05-23 15:02:26.945245+03	core	RefBuildings	245	\N	{"srcName":"core.RefBuildings.c","srcPK":"245"}	Create data
632	1	1	2019-05-23 15:02:27.354149+03	core	RefBuildings	247	\N	{"srcName":"core.RefBuildings.c","srcPK":"247"}	Create data
634	1	1	2019-05-23 15:02:27.787719+03	core	RefBuildings	249	\N	{"srcName":"core.RefBuildings.c","srcPK":"249"}	Create data
636	1	1	2019-05-23 15:02:28.29011+03	core	RefBuildings	251	\N	{"srcName":"core.RefBuildings.c","srcPK":"251"}	Create data
638	1	1	2019-05-23 15:02:28.714067+03	core	RefBuildings	253	\N	{"srcName":"core.RefBuildings.c","srcPK":"253"}	Create data
640	1	1	2019-05-23 15:02:29.012114+03	core	RefBuildings	255	\N	{"srcName":"core.RefBuildings.c","srcPK":"255"}	Create data
642	1	1	2019-05-23 15:02:29.356156+03	core	RefBuildings	257	\N	{"srcName":"core.RefBuildings.c","srcPK":"257"}	Create data
644	1	1	2019-05-23 15:02:29.66408+03	core	RefBuildings	259	\N	{"srcName":"core.RefBuildings.c","srcPK":"259"}	Create data
646	1	1	2019-05-23 15:02:30.113822+03	core	RefBuildings	261	\N	{"srcName":"core.RefBuildings.c","srcPK":"261"}	Create data
648	1	1	2019-05-23 15:02:30.598539+03	core	RefBuildings	263	\N	{"srcName":"core.RefBuildings.c","srcPK":"263"}	Create data
650	1	1	2019-05-23 15:02:31.14977+03	core	RefBuildings	265	\N	{"srcName":"core.RefBuildings.c","srcPK":"265"}	Create data
652	1	1	2019-05-23 15:02:31.491241+03	core	RefBuildings	267	\N	{"srcName":"core.RefBuildings.c","srcPK":"267"}	Create data
654	1	1	2019-05-23 15:02:31.826347+03	core	RefBuildings	269	\N	{"srcName":"core.RefBuildings.c","srcPK":"269"}	Create data
656	1	1	2019-05-23 15:02:32.13349+03	core	RefBuildings	271	\N	{"srcName":"core.RefBuildings.c","srcPK":"271"}	Create data
658	1	1	2019-05-23 15:02:32.552962+03	core	RefBuildings	273	\N	{"srcName":"core.RefBuildings.c","srcPK":"273"}	Create data
660	1	1	2019-05-23 15:02:32.892676+03	core	RefBuildings	275	\N	{"srcName":"core.RefBuildings.c","srcPK":"275"}	Create data
662	1	1	2019-05-23 15:02:33.268773+03	core	RefBuildings	277	\N	{"srcName":"core.RefBuildings.c","srcPK":"277"}	Create data
664	1	1	2019-05-23 15:02:33.619759+03	core	RefBuildings	279	\N	{"srcName":"core.RefBuildings.c","srcPK":"279"}	Create data
666	1	1	2019-05-23 15:02:34.027979+03	core	RefBuildings	281	\N	{"srcName":"core.RefBuildings.c","srcPK":"281"}	Create data
668	1	1	2019-05-23 15:02:34.431094+03	core	RefBuildings	283	\N	{"srcName":"core.RefBuildings.c","srcPK":"283"}	Create data
670	1	1	2019-05-23 15:02:34.850243+03	core	RefBuildings	285	\N	{"srcName":"core.RefBuildings.c","srcPK":"285"}	Create data
671	1	1	2019-05-23 15:02:35.11039+03	core	RefBuildings	286	\N	{"srcName":"core.RefBuildings.c","srcPK":"286"}	Create data
672	1	1	2019-05-23 15:02:35.436902+03	core	RefBuildings	287	\N	{"srcName":"core.RefBuildings.c","srcPK":"287"}	Create data
673	1	1	2019-05-23 15:02:35.628177+03	core	RefBuildings	288	\N	{"srcName":"core.RefBuildings.c","srcPK":"288"}	Create data
674	1	1	2019-05-23 15:02:36.089277+03	core	RefBuildings	289	\N	{"srcName":"core.RefBuildings.c","srcPK":"289"}	Create data
675	1	1	2019-05-23 15:02:36.263296+03	core	RefBuildings	290	\N	{"srcName":"core.RefBuildings.c","srcPK":"290"}	Create data
676	1	1	2019-05-23 15:02:36.455195+03	core	RefBuildings	291	\N	{"srcName":"core.RefBuildings.c","srcPK":"291"}	Create data
677	1	1	2019-05-23 15:02:36.63331+03	core	RefBuildings	292	\N	{"srcName":"core.RefBuildings.c","srcPK":"292"}	Create data
678	1	1	2019-05-23 15:02:36.814936+03	core	RefBuildings	293	\N	{"srcName":"core.RefBuildings.c","srcPK":"293"}	Create data
679	1	1	2019-05-23 15:02:37.022389+03	core	RefBuildings	294	\N	{"srcName":"core.RefBuildings.c","srcPK":"294"}	Create data
680	1	1	2019-05-23 15:02:37.204421+03	core	RefBuildings	295	\N	{"srcName":"core.RefBuildings.c","srcPK":"295"}	Create data
681	1	1	2019-05-23 15:02:37.439768+03	core	RefBuildings	296	\N	{"srcName":"core.RefBuildings.c","srcPK":"296"}	Create data
682	1	1	2019-05-23 15:02:37.63135+03	core	RefBuildings	297	\N	{"srcName":"core.RefBuildings.c","srcPK":"297"}	Create data
683	1	1	2019-05-23 15:02:37.789939+03	core	RefBuildings	298	\N	{"srcName":"core.RefBuildings.c","srcPK":"298"}	Create data
684	1	1	2019-05-23 15:02:37.941109+03	core	RefBuildings	299	\N	{"srcName":"core.RefBuildings.c","srcPK":"299"}	Create data
685	1	1	2019-05-23 15:02:38.082417+03	core	RefBuildings	300	\N	{"srcName":"core.RefBuildings.c","srcPK":"300"}	Create data
686	1	1	2019-05-23 15:02:38.294684+03	core	RefBuildings	301	\N	{"srcName":"core.RefBuildings.c","srcPK":"301"}	Create data
687	1	1	2019-05-23 15:02:38.441081+03	core	RefBuildings	302	\N	{"srcName":"core.RefBuildings.c","srcPK":"302"}	Create data
688	1	1	2019-05-23 15:02:38.59076+03	core	RefBuildings	303	\N	{"srcName":"core.RefBuildings.c","srcPK":"303"}	Create data
689	1	1	2019-05-23 15:02:38.783676+03	core	RefBuildings	304	\N	{"srcName":"core.RefBuildings.c","srcPK":"304"}	Create data
690	1	1	2019-05-23 15:02:38.942082+03	core	RefBuildings	305	\N	{"srcName":"core.RefBuildings.c","srcPK":"305"}	Create data
691	1	1	2019-05-23 15:02:39.10069+03	core	RefBuildings	306	\N	{"srcName":"core.RefBuildings.c","srcPK":"306"}	Create data
693	1	1	2019-05-23 15:02:39.493292+03	core	RefBuildings	308	\N	{"srcName":"core.RefBuildings.c","srcPK":"308"}	Create data
695	1	1	2019-05-23 15:02:39.880212+03	core	RefBuildings	310	\N	{"srcName":"core.RefBuildings.c","srcPK":"310"}	Create data
697	1	1	2019-05-23 15:02:40.260229+03	core	RefBuildings	312	\N	{"srcName":"core.RefBuildings.c","srcPK":"312"}	Create data
699	1	1	2019-05-23 15:02:40.651693+03	core	RefBuildings	314	\N	{"srcName":"core.RefBuildings.c","srcPK":"314"}	Create data
701	1	1	2019-05-23 15:02:41.292991+03	core	RefBuildings	316	\N	{"srcName":"core.RefBuildings.c","srcPK":"316"}	Create data
703	1	1	2019-05-23 15:02:41.720476+03	core	RefBuildings	318	\N	{"srcName":"core.RefBuildings.c","srcPK":"318"}	Create data
705	1	1	2019-05-23 15:02:42.049132+03	core	RefBuildings	320	\N	{"srcName":"core.RefBuildings.c","srcPK":"320"}	Create data
707	1	1	2019-05-23 15:02:42.438959+03	core	RefBuildings	322	\N	{"srcName":"core.RefBuildings.c","srcPK":"322"}	Create data
709	1	1	2019-05-23 15:02:42.783234+03	core	RefBuildings	324	\N	{"srcName":"core.RefBuildings.c","srcPK":"324"}	Create data
711	1	1	2019-05-23 15:02:43.105161+03	core	RefBuildings	326	\N	{"srcName":"core.RefBuildings.c","srcPK":"326"}	Create data
713	1	1	2019-05-23 15:02:43.422598+03	core	RefBuildings	328	\N	{"srcName":"core.RefBuildings.c","srcPK":"328"}	Create data
715	1	1	2019-05-23 15:02:43.780929+03	core	RefBuildings	330	\N	{"srcName":"core.RefBuildings.c","srcPK":"330"}	Create data
717	1	1	2019-05-23 15:02:44.114934+03	core	RefBuildings	332	\N	{"srcName":"core.RefBuildings.c","srcPK":"332"}	Create data
719	1	1	2019-05-23 15:02:44.415608+03	core	RefBuildings	334	\N	{"srcName":"core.RefBuildings.c","srcPK":"334"}	Create data
721	1	1	2019-05-23 15:02:44.716904+03	core	RefBuildings	336	\N	{"srcName":"core.RefBuildings.c","srcPK":"336"}	Create data
723	1	1	2019-05-23 15:02:45.100774+03	core	RefBuildings	338	\N	{"srcName":"core.RefBuildings.c","srcPK":"338"}	Create data
725	1	1	2019-05-23 15:02:45.483697+03	core	RefBuildings	340	\N	{"srcName":"core.RefBuildings.c","srcPK":"340"}	Create data
727	1	1	2019-05-23 15:02:45.809201+03	core	RefBuildings	342	\N	{"srcName":"core.RefBuildings.c","srcPK":"342"}	Create data
729	1	1	2019-05-23 15:02:46.335032+03	core	RefBuildings	344	\N	{"srcName":"core.RefBuildings.c","srcPK":"344"}	Create data
731	1	1	2019-05-23 15:02:46.709928+03	core	RefBuildings	346	\N	{"srcName":"core.RefBuildings.c","srcPK":"346"}	Create data
733	1	1	2019-05-23 15:02:47.043456+03	core	RefBuildings	348	\N	{"srcName":"core.RefBuildings.c","srcPK":"348"}	Create data
735	1	1	2019-05-23 15:02:47.435859+03	core	RefBuildings	350	\N	{"srcName":"core.RefBuildings.c","srcPK":"350"}	Create data
737	1	1	2019-05-23 15:02:47.76944+03	core	RefBuildings	352	\N	{"srcName":"core.RefBuildings.c","srcPK":"352"}	Create data
739	1	1	2019-05-23 15:02:48.137524+03	core	RefBuildings	354	\N	{"srcName":"core.RefBuildings.c","srcPK":"354"}	Create data
741	1	1	2019-05-23 15:02:48.454557+03	core	RefBuildings	356	\N	{"srcName":"core.RefBuildings.c","srcPK":"356"}	Create data
743	1	1	2019-05-23 15:02:48.81347+03	core	RefBuildings	358	\N	{"srcName":"core.RefBuildings.c","srcPK":"358"}	Create data
745	1	1	2019-05-23 15:02:49.129866+03	core	RefBuildings	360	\N	{"srcName":"core.RefBuildings.c","srcPK":"360"}	Create data
747	1	1	2019-05-23 15:02:49.514502+03	core	RefBuildings	362	\N	{"srcName":"core.RefBuildings.c","srcPK":"362"}	Create data
749	1	1	2019-05-23 15:02:49.847863+03	core	RefBuildings	364	\N	{"srcName":"core.RefBuildings.c","srcPK":"364"}	Create data
751	1	1	2019-05-23 15:02:50.213179+03	core	RefBuildings	366	\N	{"srcName":"core.RefBuildings.c","srcPK":"366"}	Create data
753	1	1	2019-05-23 15:02:50.519519+03	core	RefBuildings	368	\N	{"srcName":"core.RefBuildings.c","srcPK":"368"}	Create data
755	1	1	2019-05-23 15:02:50.961287+03	core	RefBuildings	370	\N	{"srcName":"core.RefBuildings.c","srcPK":"370"}	Create data
757	1	1	2019-05-23 15:02:51.532258+03	core	RefBuildings	372	\N	{"srcName":"core.RefBuildings.c","srcPK":"372"}	Create data
759	1	1	2019-05-23 15:02:52.032507+03	core	RefBuildings	374	\N	{"srcName":"core.RefBuildings.c","srcPK":"374"}	Create data
761	1	1	2019-05-23 15:02:52.428709+03	core	RefBuildings	376	\N	{"srcName":"core.RefBuildings.c","srcPK":"376"}	Create data
763	1	1	2019-05-23 15:02:52.767146+03	core	RefBuildings	378	\N	{"srcName":"core.RefBuildings.c","srcPK":"378"}	Create data
765	1	1	2019-05-23 15:02:53.167423+03	core	RefBuildings	380	\N	{"srcName":"core.RefBuildings.c","srcPK":"380"}	Create data
767	1	1	2019-05-23 15:02:53.558135+03	core	RefBuildings	382	\N	{"srcName":"core.RefBuildings.c","srcPK":"382"}	Create data
769	1	1	2019-05-23 15:02:53.900954+03	core	RefBuildings	384	\N	{"srcName":"core.RefBuildings.c","srcPK":"384"}	Create data
771	1	1	2019-05-23 15:02:54.293508+03	core	RefBuildings	386	\N	{"srcName":"core.RefBuildings.c","srcPK":"386"}	Create data
773	1	1	2019-05-23 15:02:54.611495+03	core	RefBuildings	388	\N	{"srcName":"core.RefBuildings.c","srcPK":"388"}	Create data
775	1	1	2019-05-23 15:02:54.953803+03	core	RefBuildings	390	\N	{"srcName":"core.RefBuildings.c","srcPK":"390"}	Create data
777	1	1	2019-05-23 15:02:55.287435+03	core	RefBuildings	392	\N	{"srcName":"core.RefBuildings.c","srcPK":"392"}	Create data
779	1	1	2019-05-23 15:02:55.670665+03	core	RefBuildings	394	\N	{"srcName":"core.RefBuildings.c","srcPK":"394"}	Create data
781	1	1	2019-05-23 15:02:56.004155+03	core	RefBuildings	396	\N	{"srcName":"core.RefBuildings.c","srcPK":"396"}	Create data
783	1	1	2019-05-23 15:02:56.828474+03	core	RefBuildings	398	\N	{"srcName":"core.RefBuildings.c","srcPK":"398"}	Create data
785	1	1	2019-05-23 15:02:57.20607+03	core	RefBuildings	400	\N	{"srcName":"core.RefBuildings.c","srcPK":"400"}	Create data
787	1	1	2019-05-23 15:02:57.539443+03	core	RefBuildings	402	\N	{"srcName":"core.RefBuildings.c","srcPK":"402"}	Create data
789	1	1	2019-05-23 15:02:57.864157+03	core	RefBuildings	404	\N	{"srcName":"core.RefBuildings.c","srcPK":"404"}	Create data
791	1	1	2019-05-23 15:02:58.242142+03	core	RefBuildings	406	\N	{"srcName":"core.RefBuildings.c","srcPK":"406"}	Create data
793	1	1	2019-05-23 15:02:58.58321+03	core	RefBuildings	408	\N	{"srcName":"core.RefBuildings.c","srcPK":"408"}	Create data
692	1	1	2019-05-23 15:02:39.283269+03	core	RefBuildings	307	\N	{"srcName":"core.RefBuildings.c","srcPK":"307"}	Create data
694	1	1	2019-05-23 15:02:39.691856+03	core	RefBuildings	309	\N	{"srcName":"core.RefBuildings.c","srcPK":"309"}	Create data
696	1	1	2019-05-23 15:02:40.127172+03	core	RefBuildings	311	\N	{"srcName":"core.RefBuildings.c","srcPK":"311"}	Create data
698	1	1	2019-05-23 15:02:40.501936+03	core	RefBuildings	313	\N	{"srcName":"core.RefBuildings.c","srcPK":"313"}	Create data
700	1	1	2019-05-23 15:02:40.892589+03	core	RefBuildings	315	\N	{"srcName":"core.RefBuildings.c","srcPK":"315"}	Create data
702	1	1	2019-05-23 15:02:41.495839+03	core	RefBuildings	317	\N	{"srcName":"core.RefBuildings.c","srcPK":"317"}	Create data
704	1	1	2019-05-23 15:02:41.899356+03	core	RefBuildings	319	\N	{"srcName":"core.RefBuildings.c","srcPK":"319"}	Create data
706	1	1	2019-05-23 15:02:42.271074+03	core	RefBuildings	321	\N	{"srcName":"core.RefBuildings.c","srcPK":"321"}	Create data
708	1	1	2019-05-23 15:02:42.596912+03	core	RefBuildings	323	\N	{"srcName":"core.RefBuildings.c","srcPK":"323"}	Create data
710	1	1	2019-05-23 15:02:42.938869+03	core	RefBuildings	325	\N	{"srcName":"core.RefBuildings.c","srcPK":"325"}	Create data
712	1	1	2019-05-23 15:02:43.246782+03	core	RefBuildings	327	\N	{"srcName":"core.RefBuildings.c","srcPK":"327"}	Create data
714	1	1	2019-05-23 15:02:43.602996+03	core	RefBuildings	329	\N	{"srcName":"core.RefBuildings.c","srcPK":"329"}	Create data
716	1	1	2019-05-23 15:02:43.930355+03	core	RefBuildings	331	\N	{"srcName":"core.RefBuildings.c","srcPK":"331"}	Create data
718	1	1	2019-05-23 15:02:44.260738+03	core	RefBuildings	333	\N	{"srcName":"core.RefBuildings.c","srcPK":"333"}	Create data
720	1	1	2019-05-23 15:02:44.565442+03	core	RefBuildings	335	\N	{"srcName":"core.RefBuildings.c","srcPK":"335"}	Create data
722	1	1	2019-05-23 15:02:44.900482+03	core	RefBuildings	337	\N	{"srcName":"core.RefBuildings.c","srcPK":"337"}	Create data
724	1	1	2019-05-23 15:02:45.29832+03	core	RefBuildings	339	\N	{"srcName":"core.RefBuildings.c","srcPK":"339"}	Create data
726	1	1	2019-05-23 15:02:45.649114+03	core	RefBuildings	341	\N	{"srcName":"core.RefBuildings.c","srcPK":"341"}	Create data
728	1	1	2019-05-23 15:02:45.949832+03	core	RefBuildings	343	\N	{"srcName":"core.RefBuildings.c","srcPK":"343"}	Create data
730	1	1	2019-05-23 15:02:46.551605+03	core	RefBuildings	345	\N	{"srcName":"core.RefBuildings.c","srcPK":"345"}	Create data
732	1	1	2019-05-23 15:02:46.885894+03	core	RefBuildings	347	\N	{"srcName":"core.RefBuildings.c","srcPK":"347"}	Create data
734	1	1	2019-05-23 15:02:47.252788+03	core	RefBuildings	349	\N	{"srcName":"core.RefBuildings.c","srcPK":"349"}	Create data
736	1	1	2019-05-23 15:02:47.594013+03	core	RefBuildings	351	\N	{"srcName":"core.RefBuildings.c","srcPK":"351"}	Create data
738	1	1	2019-05-23 15:02:47.961076+03	core	RefBuildings	353	\N	{"srcName":"core.RefBuildings.c","srcPK":"353"}	Create data
740	1	1	2019-05-23 15:02:48.303133+03	core	RefBuildings	355	\N	{"srcName":"core.RefBuildings.c","srcPK":"355"}	Create data
742	1	1	2019-05-23 15:02:48.6544+03	core	RefBuildings	357	\N	{"srcName":"core.RefBuildings.c","srcPK":"357"}	Create data
744	1	1	2019-05-23 15:02:48.970496+03	core	RefBuildings	359	\N	{"srcName":"core.RefBuildings.c","srcPK":"359"}	Create data
746	1	1	2019-05-23 15:02:49.330637+03	core	RefBuildings	361	\N	{"srcName":"core.RefBuildings.c","srcPK":"361"}	Create data
748	1	1	2019-05-23 15:02:49.670561+03	core	RefBuildings	363	\N	{"srcName":"core.RefBuildings.c","srcPK":"363"}	Create data
750	1	1	2019-05-23 15:02:50.055375+03	core	RefBuildings	365	\N	{"srcName":"core.RefBuildings.c","srcPK":"365"}	Create data
752	1	1	2019-05-23 15:02:50.364623+03	core	RefBuildings	367	\N	{"srcName":"core.RefBuildings.c","srcPK":"367"}	Create data
754	1	1	2019-05-23 15:02:50.739234+03	core	RefBuildings	369	\N	{"srcName":"core.RefBuildings.c","srcPK":"369"}	Create data
756	1	1	2019-05-23 15:02:51.349161+03	core	RefBuildings	371	\N	{"srcName":"core.RefBuildings.c","srcPK":"371"}	Create data
758	1	1	2019-05-23 15:02:51.790551+03	core	RefBuildings	373	\N	{"srcName":"core.RefBuildings.c","srcPK":"373"}	Create data
760	1	1	2019-05-23 15:02:52.214957+03	core	RefBuildings	375	\N	{"srcName":"core.RefBuildings.c","srcPK":"375"}	Create data
762	1	1	2019-05-23 15:02:52.584787+03	core	RefBuildings	377	\N	{"srcName":"core.RefBuildings.c","srcPK":"377"}	Create data
764	1	1	2019-05-23 15:02:52.978412+03	core	RefBuildings	379	\N	{"srcName":"core.RefBuildings.c","srcPK":"379"}	Create data
766	1	1	2019-05-23 15:02:53.335656+03	core	RefBuildings	381	\N	{"srcName":"core.RefBuildings.c","srcPK":"381"}	Create data
768	1	1	2019-05-23 15:02:53.751272+03	core	RefBuildings	383	\N	{"srcName":"core.RefBuildings.c","srcPK":"383"}	Create data
770	1	1	2019-05-23 15:02:54.093698+03	core	RefBuildings	385	\N	{"srcName":"core.RefBuildings.c","srcPK":"385"}	Create data
772	1	1	2019-05-23 15:02:54.450224+03	core	RefBuildings	387	\N	{"srcName":"core.RefBuildings.c","srcPK":"387"}	Create data
774	1	1	2019-05-23 15:02:54.770384+03	core	RefBuildings	389	\N	{"srcName":"core.RefBuildings.c","srcPK":"389"}	Create data
776	1	1	2019-05-23 15:02:55.111592+03	core	RefBuildings	391	\N	{"srcName":"core.RefBuildings.c","srcPK":"391"}	Create data
778	1	1	2019-05-23 15:02:55.470619+03	core	RefBuildings	393	\N	{"srcName":"core.RefBuildings.c","srcPK":"393"}	Create data
780	1	1	2019-05-23 15:02:55.837034+03	core	RefBuildings	395	\N	{"srcName":"core.RefBuildings.c","srcPK":"395"}	Create data
782	1	1	2019-05-23 15:02:56.252788+03	core	RefBuildings	397	\N	{"srcName":"core.RefBuildings.c","srcPK":"397"}	Create data
784	1	1	2019-05-23 15:02:57.02257+03	core	RefBuildings	399	\N	{"srcName":"core.RefBuildings.c","srcPK":"399"}	Create data
786	1	1	2019-05-23 15:02:57.387867+03	core	RefBuildings	401	\N	{"srcName":"core.RefBuildings.c","srcPK":"401"}	Create data
788	1	1	2019-05-23 15:02:57.714438+03	core	RefBuildings	403	\N	{"srcName":"core.RefBuildings.c","srcPK":"403"}	Create data
790	1	1	2019-05-23 15:02:58.006049+03	core	RefBuildings	405	\N	{"srcName":"core.RefBuildings.c","srcPK":"405"}	Create data
792	1	1	2019-05-23 15:02:58.430936+03	core	RefBuildings	407	\N	{"srcName":"core.RefBuildings.c","srcPK":"407"}	Create data
794	1	1	2019-05-23 15:02:58.774606+03	core	RefBuildings	409	\N	{"srcName":"core.RefBuildings.c","srcPK":"409"}	Create data
795	1	1	2019-05-23 15:02:58.921742+03	core	RefBuildings	410	\N	{"srcName":"core.RefBuildings.c","srcPK":"410"}	Create data
797	1	1	2019-05-23 15:02:59.224882+03	core	RefBuildings	412	\N	{"srcName":"core.RefBuildings.c","srcPK":"412"}	Create data
799	1	1	2019-05-23 15:02:59.574436+03	core	RefBuildings	414	\N	{"srcName":"core.RefBuildings.c","srcPK":"414"}	Create data
801	1	1	2019-05-23 15:02:59.931758+03	core	RefBuildings	416	\N	{"srcName":"core.RefBuildings.c","srcPK":"416"}	Create data
803	1	1	2019-05-23 15:03:00.333614+03	core	RefBuildings	418	\N	{"srcName":"core.RefBuildings.c","srcPK":"418"}	Create data
805	1	1	2019-05-23 15:03:00.700547+03	core	RefBuildings	420	\N	{"srcName":"core.RefBuildings.c","srcPK":"420"}	Create data
807	1	1	2019-05-23 15:03:01.297234+03	core	RefBuildings	422	\N	{"srcName":"core.RefBuildings.c","srcPK":"422"}	Create data
809	1	1	2019-05-23 15:03:01.64302+03	core	RefBuildings	424	\N	{"srcName":"core.RefBuildings.c","srcPK":"424"}	Create data
811	1	1	2019-05-23 15:03:02.089315+03	core	RefBuildings	426	\N	{"srcName":"core.RefBuildings.c","srcPK":"426"}	Create data
813	1	1	2019-05-23 15:03:02.465109+03	core	RefBuildings	428	\N	{"srcName":"core.RefBuildings.c","srcPK":"428"}	Create data
815	1	1	2019-05-23 15:03:02.783471+03	core	RefBuildings	430	\N	{"srcName":"core.RefBuildings.c","srcPK":"430"}	Create data
817	1	1	2019-05-23 15:03:03.213356+03	core	RefBuildings	432	\N	{"srcName":"core.RefBuildings.c","srcPK":"432"}	Create data
819	1	1	2019-05-23 15:03:03.571175+03	core	RefBuildings	434	\N	{"srcName":"core.RefBuildings.c","srcPK":"434"}	Create data
821	1	1	2019-05-23 15:03:03.909581+03	core	RefBuildings	436	\N	{"srcName":"core.RefBuildings.c","srcPK":"436"}	Create data
823	1	1	2019-05-23 15:03:04.390932+03	core	RefBuildings	438	\N	{"srcName":"core.RefBuildings.c","srcPK":"438"}	Create data
825	1	1	2019-05-23 15:03:04.756583+03	core	RefBuildings	440	\N	{"srcName":"core.RefBuildings.c","srcPK":"440"}	Create data
827	1	1	2019-05-23 15:03:05.139265+03	core	RefBuildings	442	\N	{"srcName":"core.RefBuildings.c","srcPK":"442"}	Create data
829	1	1	2019-05-23 15:03:05.539575+03	core	RefBuildings	444	\N	{"srcName":"core.RefBuildings.c","srcPK":"444"}	Create data
831	1	1	2019-05-23 15:03:05.841277+03	core	RefBuildings	446	\N	{"srcName":"core.RefBuildings.c","srcPK":"446"}	Create data
833	1	1	2019-05-23 15:03:06.258053+03	core	RefBuildings	448	\N	{"srcName":"core.RefBuildings.c","srcPK":"448"}	Create data
835	1	1	2019-05-23 15:03:06.602238+03	core	RefBuildings	450	\N	{"srcName":"core.RefBuildings.c","srcPK":"450"}	Create data
837	1	1	2019-05-23 15:03:07.148587+03	core	RefBuildings	452	\N	{"srcName":"core.RefBuildings.c","srcPK":"452"}	Create data
839	1	1	2019-05-23 15:03:07.432139+03	core	RefBuildings	454	\N	{"srcName":"core.RefBuildings.c","srcPK":"454"}	Create data
841	1	1	2019-05-23 15:03:07.733072+03	core	RefBuildings	456	\N	{"srcName":"core.RefBuildings.c","srcPK":"456"}	Create data
843	1	1	2019-05-23 15:03:08.083874+03	core	RefBuildings	458	\N	{"srcName":"core.RefBuildings.c","srcPK":"458"}	Create data
845	1	1	2019-05-23 15:03:08.409901+03	core	RefBuildings	460	\N	{"srcName":"core.RefBuildings.c","srcPK":"460"}	Create data
847	1	1	2019-05-23 15:03:08.764417+03	core	RefBuildings	462	\N	{"srcName":"core.RefBuildings.c","srcPK":"462"}	Create data
849	1	1	2019-05-23 15:03:09.310636+03	core	RefBuildings	464	\N	{"srcName":"core.RefBuildings.c","srcPK":"464"}	Create data
851	1	1	2019-05-23 15:03:09.752422+03	core	RefBuildings	466	\N	{"srcName":"core.RefBuildings.c","srcPK":"466"}	Create data
853	1	1	2019-05-23 15:03:10.339462+03	core	RefBuildings	468	\N	{"srcName":"core.RefBuildings.c","srcPK":"468"}	Create data
855	1	1	2019-05-23 15:03:10.671937+03	core	RefBuildings	470	\N	{"srcName":"core.RefBuildings.c","srcPK":"470"}	Create data
857	1	1	2019-05-23 15:03:10.995598+03	core	RefBuildings	472	\N	{"srcName":"core.RefBuildings.c","srcPK":"472"}	Create data
859	1	1	2019-05-23 15:03:11.555712+03	core	RefBuildings	474	\N	{"srcName":"core.RefBuildings.c","srcPK":"474"}	Create data
861	1	1	2019-05-23 15:03:11.923479+03	core	RefBuildings	476	\N	{"srcName":"core.RefBuildings.c","srcPK":"476"}	Create data
863	1	1	2019-05-23 15:03:12.347477+03	core	RefBuildings	478	\N	{"srcName":"core.RefBuildings.c","srcPK":"478"}	Create data
865	1	1	2019-05-23 15:03:12.707211+03	core	RefBuildings	480	\N	{"srcName":"core.RefBuildings.c","srcPK":"480"}	Create data
867	1	1	2019-05-23 15:03:13.041063+03	core	RefBuildings	482	\N	{"srcName":"core.RefBuildings.c","srcPK":"482"}	Create data
869	1	1	2019-05-23 15:03:13.408059+03	core	RefBuildings	484	\N	{"srcName":"core.RefBuildings.c","srcPK":"484"}	Create data
871	1	1	2019-05-23 15:03:13.734032+03	core	RefBuildings	486	\N	{"srcName":"core.RefBuildings.c","srcPK":"486"}	Create data
873	1	1	2019-05-23 15:03:14.083629+03	core	RefBuildings	488	\N	{"srcName":"core.RefBuildings.c","srcPK":"488"}	Create data
875	1	1	2019-05-23 15:03:14.401448+03	core	RefBuildings	490	\N	{"srcName":"core.RefBuildings.c","srcPK":"490"}	Create data
877	1	1	2019-05-23 15:03:14.74346+03	core	RefBuildings	492	\N	{"srcName":"core.RefBuildings.c","srcPK":"492"}	Create data
879	1	1	2019-05-23 15:03:15.144163+03	core	RefBuildings	494	\N	{"srcName":"core.RefBuildings.c","srcPK":"494"}	Create data
881	1	1	2019-05-23 15:03:15.476824+03	core	RefBuildings	496	\N	{"srcName":"core.RefBuildings.c","srcPK":"496"}	Create data
883	1	1	2019-05-23 15:03:15.928254+03	core	RefBuildings	498	\N	{"srcName":"core.RefBuildings.c","srcPK":"498"}	Create data
885	1	1	2019-05-23 15:03:16.528049+03	core	RefBuildings	500	\N	{"srcName":"core.RefBuildings.c","srcPK":"500"}	Create data
887	1	1	2019-05-23 15:03:16.870072+03	core	RefBuildings	502	\N	{"srcName":"core.RefBuildings.c","srcPK":"502"}	Create data
889	1	1	2019-05-23 15:03:17.187239+03	core	RefBuildings	504	\N	{"srcName":"core.RefBuildings.c","srcPK":"504"}	Create data
891	1	1	2019-05-23 15:03:17.544558+03	core	RefBuildings	506	\N	{"srcName":"core.RefBuildings.c","srcPK":"506"}	Create data
893	1	1	2019-05-23 15:03:17.811427+03	core	RefBuildings	508	\N	{"srcName":"core.RefBuildings.c","srcPK":"508"}	Create data
895	1	1	2019-05-23 15:03:18.19923+03	core	RefBuildings	510	\N	{"srcName":"core.RefBuildings.c","srcPK":"510"}	Create data
897	1	1	2019-05-23 15:03:18.555729+03	core	RefBuildings	512	\N	{"srcName":"core.RefBuildings.c","srcPK":"512"}	Create data
796	1	1	2019-05-23 15:02:59.065531+03	core	RefBuildings	411	\N	{"srcName":"core.RefBuildings.c","srcPK":"411"}	Create data
798	1	1	2019-05-23 15:02:59.375547+03	core	RefBuildings	413	\N	{"srcName":"core.RefBuildings.c","srcPK":"413"}	Create data
800	1	1	2019-05-23 15:02:59.74995+03	core	RefBuildings	415	\N	{"srcName":"core.RefBuildings.c","srcPK":"415"}	Create data
802	1	1	2019-05-23 15:03:00.142783+03	core	RefBuildings	417	\N	{"srcName":"core.RefBuildings.c","srcPK":"417"}	Create data
804	1	1	2019-05-23 15:03:00.525445+03	core	RefBuildings	419	\N	{"srcName":"core.RefBuildings.c","srcPK":"419"}	Create data
806	1	1	2019-05-23 15:03:00.885714+03	core	RefBuildings	421	\N	{"srcName":"core.RefBuildings.c","srcPK":"421"}	Create data
808	1	1	2019-05-23 15:03:01.451656+03	core	RefBuildings	423	\N	{"srcName":"core.RefBuildings.c","srcPK":"423"}	Create data
810	1	1	2019-05-23 15:03:01.793118+03	core	RefBuildings	425	\N	{"srcName":"core.RefBuildings.c","srcPK":"425"}	Create data
812	1	1	2019-05-23 15:03:02.286543+03	core	RefBuildings	427	\N	{"srcName":"core.RefBuildings.c","srcPK":"427"}	Create data
814	1	1	2019-05-23 15:03:02.612104+03	core	RefBuildings	429	\N	{"srcName":"core.RefBuildings.c","srcPK":"429"}	Create data
816	1	1	2019-05-23 15:03:03.055226+03	core	RefBuildings	431	\N	{"srcName":"core.RefBuildings.c","srcPK":"431"}	Create data
818	1	1	2019-05-23 15:03:03.379595+03	core	RefBuildings	433	\N	{"srcName":"core.RefBuildings.c","srcPK":"433"}	Create data
820	1	1	2019-05-23 15:03:03.721255+03	core	RefBuildings	435	\N	{"srcName":"core.RefBuildings.c","srcPK":"435"}	Create data
822	1	1	2019-05-23 15:03:04.212914+03	core	RefBuildings	437	\N	{"srcName":"core.RefBuildings.c","srcPK":"437"}	Create data
824	1	1	2019-05-23 15:03:04.572789+03	core	RefBuildings	439	\N	{"srcName":"core.RefBuildings.c","srcPK":"439"}	Create data
826	1	1	2019-05-23 15:03:04.973105+03	core	RefBuildings	441	\N	{"srcName":"core.RefBuildings.c","srcPK":"441"}	Create data
828	1	1	2019-05-23 15:03:05.33107+03	core	RefBuildings	443	\N	{"srcName":"core.RefBuildings.c","srcPK":"443"}	Create data
830	1	1	2019-05-23 15:03:05.689964+03	core	RefBuildings	445	\N	{"srcName":"core.RefBuildings.c","srcPK":"445"}	Create data
832	1	1	2019-05-23 15:03:06.000316+03	core	RefBuildings	447	\N	{"srcName":"core.RefBuildings.c","srcPK":"447"}	Create data
834	1	1	2019-05-23 15:03:06.423999+03	core	RefBuildings	449	\N	{"srcName":"core.RefBuildings.c","srcPK":"449"}	Create data
836	1	1	2019-05-23 15:03:07.006416+03	core	RefBuildings	451	\N	{"srcName":"core.RefBuildings.c","srcPK":"451"}	Create data
838	1	1	2019-05-23 15:03:07.29+03	core	RefBuildings	453	\N	{"srcName":"core.RefBuildings.c","srcPK":"453"}	Create data
840	1	1	2019-05-23 15:03:07.576588+03	core	RefBuildings	455	\N	{"srcName":"core.RefBuildings.c","srcPK":"455"}	Create data
842	1	1	2019-05-23 15:03:07.908788+03	core	RefBuildings	457	\N	{"srcName":"core.RefBuildings.c","srcPK":"457"}	Create data
844	1	1	2019-05-23 15:03:08.259371+03	core	RefBuildings	459	\N	{"srcName":"core.RefBuildings.c","srcPK":"459"}	Create data
846	1	1	2019-05-23 15:03:08.585964+03	core	RefBuildings	461	\N	{"srcName":"core.RefBuildings.c","srcPK":"461"}	Create data
848	1	1	2019-05-23 15:03:09.010436+03	core	RefBuildings	463	\N	{"srcName":"core.RefBuildings.c","srcPK":"463"}	Create data
850	1	1	2019-05-23 15:03:09.577209+03	core	RefBuildings	465	\N	{"srcName":"core.RefBuildings.c","srcPK":"465"}	Create data
852	1	1	2019-05-23 15:03:10.04168+03	core	RefBuildings	467	\N	{"srcName":"core.RefBuildings.c","srcPK":"467"}	Create data
854	1	1	2019-05-23 15:03:10.510534+03	core	RefBuildings	469	\N	{"srcName":"core.RefBuildings.c","srcPK":"469"}	Create data
856	1	1	2019-05-23 15:03:10.820389+03	core	RefBuildings	471	\N	{"srcName":"core.RefBuildings.c","srcPK":"471"}	Create data
858	1	1	2019-05-23 15:03:11.372091+03	core	RefBuildings	473	\N	{"srcName":"core.RefBuildings.c","srcPK":"473"}	Create data
860	1	1	2019-05-23 15:03:11.776019+03	core	RefBuildings	475	\N	{"srcName":"core.RefBuildings.c","srcPK":"475"}	Create data
862	1	1	2019-05-23 15:03:12.189911+03	core	RefBuildings	477	\N	{"srcName":"core.RefBuildings.c","srcPK":"477"}	Create data
864	1	1	2019-05-23 15:03:12.549504+03	core	RefBuildings	479	\N	{"srcName":"core.RefBuildings.c","srcPK":"479"}	Create data
866	1	1	2019-05-23 15:03:12.859245+03	core	RefBuildings	481	\N	{"srcName":"core.RefBuildings.c","srcPK":"481"}	Create data
868	1	1	2019-05-23 15:03:13.215967+03	core	RefBuildings	483	\N	{"srcName":"core.RefBuildings.c","srcPK":"483"}	Create data
870	1	1	2019-05-23 15:03:13.557897+03	core	RefBuildings	485	\N	{"srcName":"core.RefBuildings.c","srcPK":"485"}	Create data
872	1	1	2019-05-23 15:03:13.892195+03	core	RefBuildings	487	\N	{"srcName":"core.RefBuildings.c","srcPK":"487"}	Create data
874	1	1	2019-05-23 15:03:14.25084+03	core	RefBuildings	489	\N	{"srcName":"core.RefBuildings.c","srcPK":"489"}	Create data
876	1	1	2019-05-23 15:03:14.593013+03	core	RefBuildings	491	\N	{"srcName":"core.RefBuildings.c","srcPK":"491"}	Create data
878	1	1	2019-05-23 15:03:14.926431+03	core	RefBuildings	493	\N	{"srcName":"core.RefBuildings.c","srcPK":"493"}	Create data
880	1	1	2019-05-23 15:03:15.301973+03	core	RefBuildings	495	\N	{"srcName":"core.RefBuildings.c","srcPK":"495"}	Create data
882	1	1	2019-05-23 15:03:15.73937+03	core	RefBuildings	497	\N	{"srcName":"core.RefBuildings.c","srcPK":"497"}	Create data
884	1	1	2019-05-23 15:03:16.167488+03	core	RefBuildings	499	\N	{"srcName":"core.RefBuildings.c","srcPK":"499"}	Create data
886	1	1	2019-05-23 15:03:16.71999+03	core	RefBuildings	501	\N	{"srcName":"core.RefBuildings.c","srcPK":"501"}	Create data
888	1	1	2019-05-23 15:03:17.010604+03	core	RefBuildings	503	\N	{"srcName":"core.RefBuildings.c","srcPK":"503"}	Create data
890	1	1	2019-05-23 15:03:17.360795+03	core	RefBuildings	505	\N	{"srcName":"core.RefBuildings.c","srcPK":"505"}	Create data
892	1	1	2019-05-23 15:03:17.67592+03	core	RefBuildings	507	\N	{"srcName":"core.RefBuildings.c","srcPK":"507"}	Create data
894	1	1	2019-05-23 15:03:17.978995+03	core	RefBuildings	509	\N	{"srcName":"core.RefBuildings.c","srcPK":"509"}	Create data
896	1	1	2019-05-23 15:03:18.34696+03	core	RefBuildings	511	\N	{"srcName":"core.RefBuildings.c","srcPK":"511"}	Create data
898	1	1	2019-05-23 15:03:18.706107+03	core	RefBuildings	513	\N	{"srcName":"core.RefBuildings.c","srcPK":"513"}	Create data
899	1	1	2019-05-23 15:03:18.858884+03	core	RefBuildings	514	\N	{"srcName":"core.RefBuildings.c","srcPK":"514"}	Create data
901	1	1	2019-05-23 15:03:19.18166+03	core	RefBuildings	516	\N	{"srcName":"core.RefBuildings.c","srcPK":"516"}	Create data
903	1	1	2019-05-23 15:03:19.558035+03	core	RefBuildings	518	\N	{"srcName":"core.RefBuildings.c","srcPK":"518"}	Create data
905	1	1	2019-05-23 15:03:19.940852+03	core	RefBuildings	520	\N	{"srcName":"core.RefBuildings.c","srcPK":"520"}	Create data
907	1	1	2019-05-23 15:03:20.264693+03	core	RefBuildings	522	\N	{"srcName":"core.RefBuildings.c","srcPK":"522"}	Create data
909	1	1	2019-05-23 15:03:20.623822+03	core	RefBuildings	524	\N	{"srcName":"core.RefBuildings.c","srcPK":"524"}	Create data
911	1	1	2019-05-23 15:03:20.967368+03	core	RefBuildings	526	\N	{"srcName":"core.RefBuildings.c","srcPK":"526"}	Create data
913	1	1	2019-05-23 15:03:21.443046+03	core	RefBuildings	528	\N	{"srcName":"core.RefBuildings.c","srcPK":"528"}	Create data
915	1	1	2019-05-23 15:03:21.866258+03	core	RefBuildings	530	\N	{"srcName":"core.RefBuildings.c","srcPK":"530"}	Create data
917	1	1	2019-05-23 15:03:22.200476+03	core	RefBuildings	532	\N	{"srcName":"core.RefBuildings.c","srcPK":"532"}	Create data
919	1	1	2019-05-23 15:03:22.519619+03	core	RefBuildings	534	\N	{"srcName":"core.RefBuildings.c","srcPK":"534"}	Create data
921	1	1	2019-05-23 15:03:22.819101+03	core	RefBuildings	536	\N	{"srcName":"core.RefBuildings.c","srcPK":"536"}	Create data
923	1	1	2019-05-23 15:03:23.343748+03	core	RefBuildings	538	\N	{"srcName":"core.RefBuildings.c","srcPK":"538"}	Create data
925	1	1	2019-05-23 15:03:23.728864+03	core	RefBuildings	540	\N	{"srcName":"core.RefBuildings.c","srcPK":"540"}	Create data
927	1	1	2019-05-23 15:03:24.129403+03	core	RefBuildings	542	\N	{"srcName":"core.RefBuildings.c","srcPK":"542"}	Create data
929	1	1	2019-05-23 15:03:24.420245+03	core	RefBuildings	544	\N	{"srcName":"core.RefBuildings.c","srcPK":"544"}	Create data
931	1	1	2019-05-23 15:03:24.703412+03	core	RefBuildings	546	\N	{"srcName":"core.RefBuildings.c","srcPK":"546"}	Create data
933	1	1	2019-05-23 15:03:25.187509+03	core	RefBuildings	548	\N	{"srcName":"core.RefBuildings.c","srcPK":"548"}	Create data
935	1	1	2019-05-23 15:03:25.614414+03	core	RefBuildings	550	\N	{"srcName":"core.RefBuildings.c","srcPK":"550"}	Create data
937	1	1	2019-05-23 15:03:25.956776+03	core	RefBuildings	552	\N	{"srcName":"core.RefBuildings.c","srcPK":"552"}	Create data
939	1	1	2019-05-23 15:03:26.24761+03	core	RefBuildings	554	\N	{"srcName":"core.RefBuildings.c","srcPK":"554"}	Create data
941	1	1	2019-05-23 15:03:26.699547+03	core	RefBuildings	556	\N	{"srcName":"core.RefBuildings.c","srcPK":"556"}	Create data
943	1	1	2019-05-23 15:03:27.067585+03	core	RefBuildings	558	\N	{"srcName":"core.RefBuildings.c","srcPK":"558"}	Create data
945	1	1	2019-05-23 15:03:27.851944+03	core	RefBuildings	560	\N	{"srcName":"core.RefBuildings.c","srcPK":"560"}	Create data
947	1	1	2019-05-23 15:03:28.568263+03	core	RefBuildings	562	\N	{"srcName":"core.RefBuildings.c","srcPK":"562"}	Create data
949	1	1	2019-05-23 15:03:29.035576+03	core	RefBuildings	564	\N	{"srcName":"core.RefBuildings.c","srcPK":"564"}	Create data
951	1	1	2019-05-23 15:03:29.568307+03	core	RefBuildings	566	\N	{"srcName":"core.RefBuildings.c","srcPK":"566"}	Create data
953	1	1	2019-05-23 15:03:29.926839+03	core	RefBuildings	568	\N	{"srcName":"core.RefBuildings.c","srcPK":"568"}	Create data
955	1	1	2019-05-23 15:03:30.226276+03	core	RefBuildings	570	\N	{"srcName":"core.RefBuildings.c","srcPK":"570"}	Create data
957	1	1	2019-05-23 15:03:30.544472+03	core	RefBuildings	572	\N	{"srcName":"core.RefBuildings.c","srcPK":"572"}	Create data
959	1	1	2019-05-23 15:03:30.862075+03	core	RefBuildings	574	\N	{"srcName":"core.RefBuildings.c","srcPK":"574"}	Create data
961	1	1	2019-05-23 15:03:31.30404+03	core	RefBuildings	576	\N	{"srcName":"core.RefBuildings.c","srcPK":"576"}	Create data
963	1	1	2019-05-23 15:03:31.929156+03	core	RefBuildings	578	\N	{"srcName":"core.RefBuildings.c","srcPK":"578"}	Create data
965	1	1	2019-05-23 15:03:32.257167+03	core	RefBuildings	580	\N	{"srcName":"core.RefBuildings.c","srcPK":"580"}	Create data
967	1	1	2019-05-23 15:03:32.571574+03	core	RefBuildings	582	\N	{"srcName":"core.RefBuildings.c","srcPK":"582"}	Create data
969	1	1	2019-05-23 15:03:32.956185+03	core	RefBuildings	584	\N	{"srcName":"core.RefBuildings.c","srcPK":"584"}	Create data
971	1	1	2019-05-23 15:03:33.300571+03	core	RefBuildings	586	\N	{"srcName":"core.RefBuildings.c","srcPK":"586"}	Create data
973	1	1	2019-05-23 15:03:33.607813+03	core	RefBuildings	588	\N	{"srcName":"core.RefBuildings.c","srcPK":"588"}	Create data
975	1	1	2019-05-23 15:03:34.065468+03	core	RefBuildings	590	\N	{"srcName":"core.RefBuildings.c","srcPK":"590"}	Create data
977	1	1	2019-05-23 15:03:34.474276+03	core	RefBuildings	592	\N	{"srcName":"core.RefBuildings.c","srcPK":"592"}	Create data
979	1	1	2019-05-23 15:03:34.917322+03	core	RefBuildings	594	\N	{"srcName":"core.RefBuildings.c","srcPK":"594"}	Create data
900	1	1	2019-05-23 15:03:19.006453+03	core	RefBuildings	515	\N	{"srcName":"core.RefBuildings.c","srcPK":"515"}	Create data
902	1	1	2019-05-23 15:03:19.390352+03	core	RefBuildings	517	\N	{"srcName":"core.RefBuildings.c","srcPK":"517"}	Create data
904	1	1	2019-05-23 15:03:19.706346+03	core	RefBuildings	519	\N	{"srcName":"core.RefBuildings.c","srcPK":"519"}	Create data
906	1	1	2019-05-23 15:03:20.110548+03	core	RefBuildings	521	\N	{"srcName":"core.RefBuildings.c","srcPK":"521"}	Create data
908	1	1	2019-05-23 15:03:20.475377+03	core	RefBuildings	523	\N	{"srcName":"core.RefBuildings.c","srcPK":"523"}	Create data
910	1	1	2019-05-23 15:03:20.802194+03	core	RefBuildings	525	\N	{"srcName":"core.RefBuildings.c","srcPK":"525"}	Create data
912	1	1	2019-05-23 15:03:21.120969+03	core	RefBuildings	527	\N	{"srcName":"core.RefBuildings.c","srcPK":"527"}	Create data
914	1	1	2019-05-23 15:03:21.610084+03	core	RefBuildings	529	\N	{"srcName":"core.RefBuildings.c","srcPK":"529"}	Create data
916	1	1	2019-05-23 15:03:22.017989+03	core	RefBuildings	531	\N	{"srcName":"core.RefBuildings.c","srcPK":"531"}	Create data
918	1	1	2019-05-23 15:03:22.375635+03	core	RefBuildings	533	\N	{"srcName":"core.RefBuildings.c","srcPK":"533"}	Create data
920	1	1	2019-05-23 15:03:22.676524+03	core	RefBuildings	535	\N	{"srcName":"core.RefBuildings.c","srcPK":"535"}	Create data
922	1	1	2019-05-23 15:03:23.002633+03	core	RefBuildings	537	\N	{"srcName":"core.RefBuildings.c","srcPK":"537"}	Create data
924	1	1	2019-05-23 15:03:23.538591+03	core	RefBuildings	539	\N	{"srcName":"core.RefBuildings.c","srcPK":"539"}	Create data
926	1	1	2019-05-23 15:03:23.93864+03	core	RefBuildings	541	\N	{"srcName":"core.RefBuildings.c","srcPK":"541"}	Create data
928	1	1	2019-05-23 15:03:24.273222+03	core	RefBuildings	543	\N	{"srcName":"core.RefBuildings.c","srcPK":"543"}	Create data
930	1	1	2019-05-23 15:03:24.562643+03	core	RefBuildings	545	\N	{"srcName":"core.RefBuildings.c","srcPK":"545"}	Create data
932	1	1	2019-05-23 15:03:24.972665+03	core	RefBuildings	547	\N	{"srcName":"core.RefBuildings.c","srcPK":"547"}	Create data
934	1	1	2019-05-23 15:03:25.355137+03	core	RefBuildings	549	\N	{"srcName":"core.RefBuildings.c","srcPK":"549"}	Create data
936	1	1	2019-05-23 15:03:25.806662+03	core	RefBuildings	551	\N	{"srcName":"core.RefBuildings.c","srcPK":"551"}	Create data
938	1	1	2019-05-23 15:03:26.106916+03	core	RefBuildings	553	\N	{"srcName":"core.RefBuildings.c","srcPK":"553"}	Create data
940	1	1	2019-05-23 15:03:26.515605+03	core	RefBuildings	555	\N	{"srcName":"core.RefBuildings.c","srcPK":"555"}	Create data
942	1	1	2019-05-23 15:03:26.890336+03	core	RefBuildings	557	\N	{"srcName":"core.RefBuildings.c","srcPK":"557"}	Create data
944	1	1	2019-05-23 15:03:27.449063+03	core	RefBuildings	559	\N	{"srcName":"core.RefBuildings.c","srcPK":"559"}	Create data
946	1	1	2019-05-23 15:03:28.290501+03	core	RefBuildings	561	\N	{"srcName":"core.RefBuildings.c","srcPK":"561"}	Create data
948	1	1	2019-05-23 15:03:28.785734+03	core	RefBuildings	563	\N	{"srcName":"core.RefBuildings.c","srcPK":"563"}	Create data
950	1	1	2019-05-23 15:03:29.303201+03	core	RefBuildings	565	\N	{"srcName":"core.RefBuildings.c","srcPK":"565"}	Create data
952	1	1	2019-05-23 15:03:29.742606+03	core	RefBuildings	567	\N	{"srcName":"core.RefBuildings.c","srcPK":"567"}	Create data
954	1	1	2019-05-23 15:03:30.069247+03	core	RefBuildings	569	\N	{"srcName":"core.RefBuildings.c","srcPK":"569"}	Create data
956	1	1	2019-05-23 15:03:30.378291+03	core	RefBuildings	571	\N	{"srcName":"core.RefBuildings.c","srcPK":"571"}	Create data
958	1	1	2019-05-23 15:03:30.714485+03	core	RefBuildings	573	\N	{"srcName":"core.RefBuildings.c","srcPK":"573"}	Create data
960	1	1	2019-05-23 15:03:31.078866+03	core	RefBuildings	575	\N	{"srcName":"core.RefBuildings.c","srcPK":"575"}	Create data
962	1	1	2019-05-23 15:03:31.595609+03	core	RefBuildings	577	\N	{"srcName":"core.RefBuildings.c","srcPK":"577"}	Create data
964	1	1	2019-05-23 15:03:32.106864+03	core	RefBuildings	579	\N	{"srcName":"core.RefBuildings.c","srcPK":"579"}	Create data
966	1	1	2019-05-23 15:03:32.421566+03	core	RefBuildings	581	\N	{"srcName":"core.RefBuildings.c","srcPK":"581"}	Create data
968	1	1	2019-05-23 15:03:32.746728+03	core	RefBuildings	583	\N	{"srcName":"core.RefBuildings.c","srcPK":"583"}	Create data
970	1	1	2019-05-23 15:03:33.147424+03	core	RefBuildings	585	\N	{"srcName":"core.RefBuildings.c","srcPK":"585"}	Create data
972	1	1	2019-05-23 15:03:33.456465+03	core	RefBuildings	587	\N	{"srcName":"core.RefBuildings.c","srcPK":"587"}	Create data
974	1	1	2019-05-23 15:03:33.806656+03	core	RefBuildings	589	\N	{"srcName":"core.RefBuildings.c","srcPK":"589"}	Create data
976	1	1	2019-05-23 15:03:34.282531+03	core	RefBuildings	591	\N	{"srcName":"core.RefBuildings.c","srcPK":"591"}	Create data
978	1	1	2019-05-23 15:03:34.69951+03	core	RefBuildings	593	\N	{"srcName":"core.RefBuildings.c","srcPK":"593"}	Create data
980	1	1	2019-05-23 15:03:35.273001+03	core	RefBuildings	595	\N	{"srcName":"core.RefBuildings.c","srcPK":"595"}	Create data
981	1	1	2019-05-23 15:03:35.425884+03	core	RefBuildings	596	\N	{"srcName":"core.RefBuildings.c","srcPK":"596"}	Create data
982	1	1	2019-05-23 15:03:35.609062+03	core	RefBuildings	597	\N	{"srcName":"core.RefBuildings.c","srcPK":"597"}	Create data
983	1	1	2019-05-23 15:03:35.842415+03	core	RefBuildings	598	\N	{"srcName":"core.RefBuildings.c","srcPK":"598"}	Create data
984	1	1	2019-05-23 15:03:35.992644+03	core	RefBuildings	599	\N	{"srcName":"core.RefBuildings.c","srcPK":"599"}	Create data
985	1	1	2019-05-23 15:03:36.143553+03	core	RefBuildings	600	\N	{"srcName":"core.RefBuildings.c","srcPK":"600"}	Create data
986	1	1	2019-05-23 15:03:36.319693+03	core	RefBuildings	601	\N	{"srcName":"core.RefBuildings.c","srcPK":"601"}	Create data
987	1	1	2019-05-23 15:03:36.693923+03	core	RefBuildings	602	\N	{"srcName":"core.RefBuildings.c","srcPK":"602"}	Create data
988	1	1	2019-05-23 15:03:36.842102+03	core	RefBuildings	603	\N	{"srcName":"core.RefBuildings.c","srcPK":"603"}	Create data
989	1	1	2019-05-23 15:03:36.993851+03	core	RefBuildings	604	\N	{"srcName":"core.RefBuildings.c","srcPK":"604"}	Create data
990	1	1	2019-05-23 15:03:37.186406+03	core	RefBuildings	605	\N	{"srcName":"core.RefBuildings.c","srcPK":"605"}	Create data
991	1	1	2019-05-23 15:03:37.327517+03	core	RefBuildings	606	\N	{"srcName":"core.RefBuildings.c","srcPK":"606"}	Create data
992	1	1	2019-05-23 15:03:37.48692+03	core	RefBuildings	607	\N	{"srcName":"core.RefBuildings.c","srcPK":"607"}	Create data
994	1	1	2019-05-23 15:03:37.811281+03	core	RefBuildings	609	\N	{"srcName":"core.RefBuildings.c","srcPK":"609"}	Create data
996	1	1	2019-05-23 15:03:38.16231+03	core	RefBuildings	611	\N	{"srcName":"core.RefBuildings.c","srcPK":"611"}	Create data
998	1	1	2019-05-23 15:03:38.529609+03	core	RefBuildings	613	\N	{"srcName":"core.RefBuildings.c","srcPK":"613"}	Create data
1000	1	1	2019-05-23 15:03:38.919603+03	core	RefBuildings	615	\N	{"srcName":"core.RefBuildings.c","srcPK":"615"}	Create data
1002	1	1	2019-05-23 15:03:39.236454+03	core	RefBuildings	617	\N	{"srcName":"core.RefBuildings.c","srcPK":"617"}	Create data
1004	1	1	2019-05-23 15:03:39.539181+03	core	RefBuildings	619	\N	{"srcName":"core.RefBuildings.c","srcPK":"619"}	Create data
1006	1	1	2019-05-23 15:03:40.040311+03	core	RefBuildings	621	\N	{"srcName":"core.RefBuildings.c","srcPK":"621"}	Create data
1008	1	1	2019-05-23 15:03:40.481205+03	core	RefBuildings	623	\N	{"srcName":"core.RefBuildings.c","srcPK":"623"}	Create data
1010	1	1	2019-05-23 15:03:40.795043+03	core	RefBuildings	625	\N	{"srcName":"core.RefBuildings.c","srcPK":"625"}	Create data
1012	1	1	2019-05-23 15:03:41.159525+03	core	RefBuildings	627	\N	{"srcName":"core.RefBuildings.c","srcPK":"627"}	Create data
1014	1	1	2019-05-23 15:03:41.666212+03	core	RefBuildings	629	\N	{"srcName":"core.RefBuildings.c","srcPK":"629"}	Create data
1016	1	1	2019-05-23 15:03:42.082649+03	core	RefBuildings	631	\N	{"srcName":"core.RefBuildings.c","srcPK":"631"}	Create data
1018	1	1	2019-05-23 15:03:42.534874+03	core	RefBuildings	633	\N	{"srcName":"core.RefBuildings.c","srcPK":"633"}	Create data
1020	1	1	2019-05-23 15:03:42.944407+03	core	RefBuildings	635	\N	{"srcName":"core.RefBuildings.c","srcPK":"635"}	Create data
1022	1	1	2019-05-23 15:03:43.40184+03	core	RefBuildings	637	\N	{"srcName":"core.RefBuildings.c","srcPK":"637"}	Create data
1024	1	1	2019-05-23 15:03:43.735799+03	core	RefBuildings	639	\N	{"srcName":"core.RefBuildings.c","srcPK":"639"}	Create data
1026	1	1	2019-05-23 15:03:44.236673+03	core	RefBuildings	641	\N	{"srcName":"core.RefBuildings.c","srcPK":"641"}	Create data
1028	1	1	2019-05-23 15:03:44.578124+03	core	RefBuildings	643	\N	{"srcName":"core.RefBuildings.c","srcPK":"643"}	Create data
1030	1	1	2019-05-23 15:03:44.970827+03	core	RefBuildings	645	\N	{"srcName":"core.RefBuildings.c","srcPK":"645"}	Create data
1032	1	1	2019-05-23 15:03:45.346114+03	core	RefBuildings	647	\N	{"srcName":"core.RefBuildings.c","srcPK":"647"}	Create data
1034	1	1	2019-05-23 15:03:45.693749+03	core	RefBuildings	649	\N	{"srcName":"core.RefBuildings.c","srcPK":"649"}	Create data
1036	1	1	2019-05-23 15:03:46.113682+03	core	RefBuildings	651	\N	{"srcName":"core.RefBuildings.c","srcPK":"651"}	Create data
1038	1	1	2019-05-23 15:03:46.636842+03	core	RefBuildings	653	\N	{"srcName":"core.RefBuildings.c","srcPK":"653"}	Create data
1040	1	1	2019-05-23 15:03:46.998475+03	core	RefBuildings	655	\N	{"srcName":"core.RefBuildings.c","srcPK":"655"}	Create data
1042	1	1	2019-05-23 15:03:47.348699+03	core	RefBuildings	657	\N	{"srcName":"core.RefBuildings.c","srcPK":"657"}	Create data
1044	1	1	2019-05-23 15:03:47.661532+03	core	RefBuildings	659	\N	{"srcName":"core.RefBuildings.c","srcPK":"659"}	Create data
1046	1	1	2019-05-23 15:03:48.02239+03	core	RefBuildings	661	\N	{"srcName":"core.RefBuildings.c","srcPK":"661"}	Create data
1048	1	1	2019-05-23 15:03:48.307532+03	core	RefBuildings	663	\N	{"srcName":"core.RefBuildings.c","srcPK":"663"}	Create data
1050	1	1	2019-05-23 15:03:48.682731+03	core	RefBuildings	665	\N	{"srcName":"core.RefBuildings.c","srcPK":"665"}	Create data
1052	1	1	2019-05-23 15:03:49.04992+03	core	RefBuildings	667	\N	{"srcName":"core.RefBuildings.c","srcPK":"667"}	Create data
1054	1	1	2019-05-23 15:03:49.373926+03	core	RefBuildings	669	\N	{"srcName":"core.RefBuildings.c","srcPK":"669"}	Create data
1056	1	1	2019-05-23 15:03:49.699359+03	core	RefBuildings	671	\N	{"srcName":"core.RefBuildings.c","srcPK":"671"}	Create data
1058	1	1	2019-05-23 15:03:50.050956+03	core	RefBuildings	673	\N	{"srcName":"core.RefBuildings.c","srcPK":"673"}	Create data
1060	1	1	2019-05-23 15:03:50.378619+03	core	RefBuildings	675	\N	{"srcName":"core.RefBuildings.c","srcPK":"675"}	Create data
1062	1	1	2019-05-23 15:03:50.71886+03	core	RefBuildings	677	\N	{"srcName":"core.RefBuildings.c","srcPK":"677"}	Create data
1064	1	1	2019-05-23 15:03:51.02016+03	core	RefBuildings	679	\N	{"srcName":"core.RefBuildings.c","srcPK":"679"}	Create data
1066	1	1	2019-05-23 15:03:51.337137+03	core	RefBuildings	681	\N	{"srcName":"core.RefBuildings.c","srcPK":"681"}	Create data
1068	1	1	2019-05-23 15:03:51.912986+03	core	RefBuildings	683	\N	{"srcName":"core.RefBuildings.c","srcPK":"683"}	Create data
1070	1	1	2019-05-23 15:03:52.472184+03	core	RefBuildings	685	\N	{"srcName":"core.RefBuildings.c","srcPK":"685"}	Create data
1072	1	1	2019-05-23 15:03:52.905584+03	core	RefBuildings	687	\N	{"srcName":"core.RefBuildings.c","srcPK":"687"}	Create data
1074	1	1	2019-05-23 15:03:53.39718+03	core	RefBuildings	689	\N	{"srcName":"core.RefBuildings.c","srcPK":"689"}	Create data
1076	1	1	2019-05-23 15:03:53.739382+03	core	RefBuildings	691	\N	{"srcName":"core.RefBuildings.c","srcPK":"691"}	Create data
1078	1	1	2019-05-23 15:03:54.039593+03	core	RefBuildings	693	\N	{"srcName":"core.RefBuildings.c","srcPK":"693"}	Create data
1080	1	1	2019-05-23 15:03:54.340511+03	core	RefBuildings	695	\N	{"srcName":"core.RefBuildings.c","srcPK":"695"}	Create data
1082	1	1	2019-05-23 15:03:54.656904+03	core	RefBuildings	697	\N	{"srcName":"core.RefBuildings.c","srcPK":"697"}	Create data
1084	1	1	2019-05-23 15:03:55.009328+03	core	RefBuildings	699	\N	{"srcName":"core.RefBuildings.c","srcPK":"699"}	Create data
1086	1	1	2019-05-23 15:03:55.492083+03	core	RefBuildings	701	\N	{"srcName":"core.RefBuildings.c","srcPK":"701"}	Create data
1088	1	1	2019-05-23 15:03:55.783653+03	core	RefBuildings	703	\N	{"srcName":"core.RefBuildings.c","srcPK":"703"}	Create data
1090	1	1	2019-05-23 15:03:56.259071+03	core	RefBuildings	705	\N	{"srcName":"core.RefBuildings.c","srcPK":"705"}	Create data
1092	1	1	2019-05-23 15:03:56.963935+03	core	RefBuildings	707	\N	{"srcName":"core.RefBuildings.c","srcPK":"707"}	Create data
1094	1	1	2019-05-23 15:03:57.452948+03	core	RefBuildings	709	\N	{"srcName":"core.RefBuildings.c","srcPK":"709"}	Create data
993	1	1	2019-05-23 15:03:37.644266+03	core	RefBuildings	608	\N	{"srcName":"core.RefBuildings.c","srcPK":"608"}	Create data
995	1	1	2019-05-23 15:03:37.977614+03	core	RefBuildings	610	\N	{"srcName":"core.RefBuildings.c","srcPK":"610"}	Create data
997	1	1	2019-05-23 15:03:38.329708+03	core	RefBuildings	612	\N	{"srcName":"core.RefBuildings.c","srcPK":"612"}	Create data
999	1	1	2019-05-23 15:03:38.752608+03	core	RefBuildings	614	\N	{"srcName":"core.RefBuildings.c","srcPK":"614"}	Create data
1001	1	1	2019-05-23 15:03:39.103005+03	core	RefBuildings	616	\N	{"srcName":"core.RefBuildings.c","srcPK":"616"}	Create data
1003	1	1	2019-05-23 15:03:39.378879+03	core	RefBuildings	618	\N	{"srcName":"core.RefBuildings.c","srcPK":"618"}	Create data
1005	1	1	2019-05-23 15:03:39.829244+03	core	RefBuildings	620	\N	{"srcName":"core.RefBuildings.c","srcPK":"620"}	Create data
1007	1	1	2019-05-23 15:03:40.237705+03	core	RefBuildings	622	\N	{"srcName":"core.RefBuildings.c","srcPK":"622"}	Create data
1009	1	1	2019-05-23 15:03:40.63542+03	core	RefBuildings	624	\N	{"srcName":"core.RefBuildings.c","srcPK":"624"}	Create data
1011	1	1	2019-05-23 15:03:41.005806+03	core	RefBuildings	626	\N	{"srcName":"core.RefBuildings.c","srcPK":"626"}	Create data
1013	1	1	2019-05-23 15:03:41.323585+03	core	RefBuildings	628	\N	{"srcName":"core.RefBuildings.c","srcPK":"628"}	Create data
1015	1	1	2019-05-23 15:03:41.855806+03	core	RefBuildings	630	\N	{"srcName":"core.RefBuildings.c","srcPK":"630"}	Create data
1017	1	1	2019-05-23 15:03:42.291933+03	core	RefBuildings	632	\N	{"srcName":"core.RefBuildings.c","srcPK":"632"}	Create data
1019	1	1	2019-05-23 15:03:42.743073+03	core	RefBuildings	634	\N	{"srcName":"core.RefBuildings.c","srcPK":"634"}	Create data
1021	1	1	2019-05-23 15:03:43.219254+03	core	RefBuildings	636	\N	{"srcName":"core.RefBuildings.c","srcPK":"636"}	Create data
1023	1	1	2019-05-23 15:03:43.560379+03	core	RefBuildings	638	\N	{"srcName":"core.RefBuildings.c","srcPK":"638"}	Create data
1025	1	1	2019-05-23 15:03:43.955251+03	core	RefBuildings	640	\N	{"srcName":"core.RefBuildings.c","srcPK":"640"}	Create data
1027	1	1	2019-05-23 15:03:44.423539+03	core	RefBuildings	642	\N	{"srcName":"core.RefBuildings.c","srcPK":"642"}	Create data
1029	1	1	2019-05-23 15:03:44.721523+03	core	RefBuildings	644	\N	{"srcName":"core.RefBuildings.c","srcPK":"644"}	Create data
1031	1	1	2019-05-23 15:03:45.146581+03	core	RefBuildings	646	\N	{"srcName":"core.RefBuildings.c","srcPK":"646"}	Create data
1033	1	1	2019-05-23 15:03:45.513684+03	core	RefBuildings	648	\N	{"srcName":"core.RefBuildings.c","srcPK":"648"}	Create data
1035	1	1	2019-05-23 15:03:45.939028+03	core	RefBuildings	650	\N	{"srcName":"core.RefBuildings.c","srcPK":"650"}	Create data
1037	1	1	2019-05-23 15:03:46.297176+03	core	RefBuildings	652	\N	{"srcName":"core.RefBuildings.c","srcPK":"652"}	Create data
1039	1	1	2019-05-23 15:03:46.820485+03	core	RefBuildings	654	\N	{"srcName":"core.RefBuildings.c","srcPK":"654"}	Create data
1041	1	1	2019-05-23 15:03:47.190249+03	core	RefBuildings	656	\N	{"srcName":"core.RefBuildings.c","srcPK":"656"}	Create data
1043	1	1	2019-05-23 15:03:47.508405+03	core	RefBuildings	658	\N	{"srcName":"core.RefBuildings.c","srcPK":"658"}	Create data
1045	1	1	2019-05-23 15:03:47.840523+03	core	RefBuildings	660	\N	{"srcName":"core.RefBuildings.c","srcPK":"660"}	Create data
1047	1	1	2019-05-23 15:03:48.165928+03	core	RefBuildings	662	\N	{"srcName":"core.RefBuildings.c","srcPK":"662"}	Create data
1049	1	1	2019-05-23 15:03:48.490858+03	core	RefBuildings	664	\N	{"srcName":"core.RefBuildings.c","srcPK":"664"}	Create data
1051	1	1	2019-05-23 15:03:48.858537+03	core	RefBuildings	666	\N	{"srcName":"core.RefBuildings.c","srcPK":"666"}	Create data
1053	1	1	2019-05-23 15:03:49.201802+03	core	RefBuildings	668	\N	{"srcName":"core.RefBuildings.c","srcPK":"668"}	Create data
1055	1	1	2019-05-23 15:03:49.557311+03	core	RefBuildings	670	\N	{"srcName":"core.RefBuildings.c","srcPK":"670"}	Create data
1057	1	1	2019-05-23 15:03:49.835306+03	core	RefBuildings	672	\N	{"srcName":"core.RefBuildings.c","srcPK":"672"}	Create data
1059	1	1	2019-05-23 15:03:50.225847+03	core	RefBuildings	674	\N	{"srcName":"core.RefBuildings.c","srcPK":"674"}	Create data
1061	1	1	2019-05-23 15:03:50.528119+03	core	RefBuildings	676	\N	{"srcName":"core.RefBuildings.c","srcPK":"676"}	Create data
1063	1	1	2019-05-23 15:03:50.868646+03	core	RefBuildings	678	\N	{"srcName":"core.RefBuildings.c","srcPK":"678"}	Create data
1065	1	1	2019-05-23 15:03:51.186146+03	core	RefBuildings	680	\N	{"srcName":"core.RefBuildings.c","srcPK":"680"}	Create data
1067	1	1	2019-05-23 15:03:51.545342+03	core	RefBuildings	682	\N	{"srcName":"core.RefBuildings.c","srcPK":"682"}	Create data
1069	1	1	2019-05-23 15:03:52.129559+03	core	RefBuildings	684	\N	{"srcName":"core.RefBuildings.c","srcPK":"684"}	Create data
1071	1	1	2019-05-23 15:03:52.705194+03	core	RefBuildings	686	\N	{"srcName":"core.RefBuildings.c","srcPK":"686"}	Create data
1073	1	1	2019-05-23 15:03:53.105875+03	core	RefBuildings	688	\N	{"srcName":"core.RefBuildings.c","srcPK":"688"}	Create data
1075	1	1	2019-05-23 15:03:53.589146+03	core	RefBuildings	690	\N	{"srcName":"core.RefBuildings.c","srcPK":"690"}	Create data
1077	1	1	2019-05-23 15:03:53.887929+03	core	RefBuildings	692	\N	{"srcName":"core.RefBuildings.c","srcPK":"692"}	Create data
1079	1	1	2019-05-23 15:03:54.189996+03	core	RefBuildings	694	\N	{"srcName":"core.RefBuildings.c","srcPK":"694"}	Create data
1081	1	1	2019-05-23 15:03:54.481721+03	core	RefBuildings	696	\N	{"srcName":"core.RefBuildings.c","srcPK":"696"}	Create data
1083	1	1	2019-05-23 15:03:54.866965+03	core	RefBuildings	698	\N	{"srcName":"core.RefBuildings.c","srcPK":"698"}	Create data
1085	1	1	2019-05-23 15:03:55.308511+03	core	RefBuildings	700	\N	{"srcName":"core.RefBuildings.c","srcPK":"700"}	Create data
1087	1	1	2019-05-23 15:03:55.646954+03	core	RefBuildings	702	\N	{"srcName":"core.RefBuildings.c","srcPK":"702"}	Create data
1089	1	1	2019-05-23 15:03:56.025667+03	core	RefBuildings	704	\N	{"srcName":"core.RefBuildings.c","srcPK":"704"}	Create data
1091	1	1	2019-05-23 15:03:56.533903+03	core	RefBuildings	706	\N	{"srcName":"core.RefBuildings.c","srcPK":"706"}	Create data
1093	1	1	2019-05-23 15:03:57.210788+03	core	RefBuildings	708	\N	{"srcName":"core.RefBuildings.c","srcPK":"708"}	Create data
1095	1	1	2019-05-23 15:03:57.610889+03	core	RefBuildings	710	\N	{"srcName":"core.RefBuildings.c","srcPK":"710"}	Create data
1096	1	1	2019-05-23 15:03:57.770006+03	core	RefBuildings	711	\N	{"srcName":"core.RefBuildings.c","srcPK":"711"}	Create data
1098	1	1	2019-05-23 15:03:58.087098+03	core	RefBuildings	713	\N	{"srcName":"core.RefBuildings.c","srcPK":"713"}	Create data
1100	1	1	2019-05-23 15:03:58.41183+03	core	RefBuildings	715	\N	{"srcName":"core.RefBuildings.c","srcPK":"715"}	Create data
1102	1	1	2019-05-23 15:03:58.784627+03	core	RefBuildings	717	\N	{"srcName":"core.RefBuildings.c","srcPK":"717"}	Create data
1104	1	1	2019-05-23 15:03:59.181256+03	core	RefBuildings	719	\N	{"srcName":"core.RefBuildings.c","srcPK":"719"}	Create data
1106	1	1	2019-05-23 15:03:59.530318+03	core	RefBuildings	721	\N	{"srcName":"core.RefBuildings.c","srcPK":"721"}	Create data
1108	1	1	2019-05-23 15:03:59.895827+03	core	RefBuildings	723	\N	{"srcName":"core.RefBuildings.c","srcPK":"723"}	Create data
1110	1	1	2019-05-23 15:04:00.31769+03	core	RefBuildings	725	\N	{"srcName":"core.RefBuildings.c","srcPK":"725"}	Create data
1112	1	1	2019-05-23 15:04:01.165396+03	core	RefBuildings	727	\N	{"srcName":"core.RefBuildings.c","srcPK":"727"}	Create data
1114	1	1	2019-05-23 15:04:01.475053+03	core	RefBuildings	729	\N	{"srcName":"core.RefBuildings.c","srcPK":"729"}	Create data
1116	1	1	2019-05-23 15:04:01.931061+03	core	RefBuildings	731	\N	{"srcName":"core.RefBuildings.c","srcPK":"731"}	Create data
1118	1	1	2019-05-23 15:04:02.256037+03	core	RefBuildings	733	\N	{"srcName":"core.RefBuildings.c","srcPK":"733"}	Create data
1120	1	1	2019-05-23 15:04:02.707255+03	core	RefBuildings	735	\N	{"srcName":"core.RefBuildings.c","srcPK":"735"}	Create data
1122	1	1	2019-05-23 15:04:03.08345+03	core	RefBuildings	737	\N	{"srcName":"core.RefBuildings.c","srcPK":"737"}	Create data
1124	1	1	2019-05-23 15:04:03.383643+03	core	RefBuildings	739	\N	{"srcName":"core.RefBuildings.c","srcPK":"739"}	Create data
1126	1	1	2019-05-23 15:04:03.729118+03	core	RefBuildings	741	\N	{"srcName":"core.RefBuildings.c","srcPK":"741"}	Create data
1128	1	1	2019-05-23 15:04:04.150446+03	core	RefBuildings	743	\N	{"srcName":"core.RefBuildings.c","srcPK":"743"}	Create data
1130	1	1	2019-05-23 15:04:04.543924+03	core	RefBuildings	745	\N	{"srcName":"core.RefBuildings.c","srcPK":"745"}	Create data
1132	1	1	2019-05-23 15:04:05.009972+03	core	RefBuildings	747	\N	{"srcName":"core.RefBuildings.c","srcPK":"747"}	Create data
1134	1	1	2019-05-23 15:04:05.312744+03	core	RefBuildings	749	\N	{"srcName":"core.RefBuildings.c","srcPK":"749"}	Create data
1136	1	1	2019-05-23 15:04:05.718933+03	core	RefBuildings	751	\N	{"srcName":"core.RefBuildings.c","srcPK":"751"}	Create data
1138	1	1	2019-05-23 15:04:06.220344+03	core	RefBuildings	753	\N	{"srcName":"core.RefBuildings.c","srcPK":"753"}	Create data
1140	1	1	2019-05-23 15:04:06.553412+03	core	RefBuildings	755	\N	{"srcName":"core.RefBuildings.c","srcPK":"755"}	Create data
1142	1	1	2019-05-23 15:04:07.07057+03	core	RefBuildings	757	\N	{"srcName":"core.RefBuildings.c","srcPK":"757"}	Create data
1144	1	1	2019-05-23 15:04:07.35396+03	core	RefBuildings	759	\N	{"srcName":"core.RefBuildings.c","srcPK":"759"}	Create data
1146	1	1	2019-05-23 15:04:07.713739+03	core	RefBuildings	761	\N	{"srcName":"core.RefBuildings.c","srcPK":"761"}	Create data
1148	1	1	2019-05-23 15:04:08.030862+03	core	RefBuildings	763	\N	{"srcName":"core.RefBuildings.c","srcPK":"763"}	Create data
1150	1	1	2019-05-23 15:04:08.326226+03	core	RefBuildings	765	\N	{"srcName":"core.RefBuildings.c","srcPK":"765"}	Create data
1152	1	1	2019-05-23 15:04:08.630551+03	core	RefBuildings	767	\N	{"srcName":"core.RefBuildings.c","srcPK":"767"}	Create data
1154	1	1	2019-05-23 15:04:08.964228+03	core	RefBuildings	769	\N	{"srcName":"core.RefBuildings.c","srcPK":"769"}	Create data
1156	1	1	2019-05-23 15:04:09.289486+03	core	RefBuildings	771	\N	{"srcName":"core.RefBuildings.c","srcPK":"771"}	Create data
1158	1	1	2019-05-23 15:04:09.641928+03	core	RefBuildings	773	\N	{"srcName":"core.RefBuildings.c","srcPK":"773"}	Create data
1160	1	1	2019-05-23 15:04:10.043726+03	core	RefBuildings	775	\N	{"srcName":"core.RefBuildings.c","srcPK":"775"}	Create data
1162	1	1	2019-05-23 15:04:10.598383+03	core	RefBuildings	777	\N	{"srcName":"core.RefBuildings.c","srcPK":"777"}	Create data
1164	1	1	2019-05-23 15:04:11.006929+03	core	RefBuildings	779	\N	{"srcName":"core.RefBuildings.c","srcPK":"779"}	Create data
1166	1	1	2019-05-23 15:04:11.30163+03	core	RefBuildings	781	\N	{"srcName":"core.RefBuildings.c","srcPK":"781"}	Create data
1168	1	1	2019-05-23 15:04:11.669235+03	core	RefBuildings	783	\N	{"srcName":"core.RefBuildings.c","srcPK":"783"}	Create data
1170	1	1	2019-05-23 15:04:12.102165+03	core	RefBuildings	785	\N	{"srcName":"core.RefBuildings.c","srcPK":"785"}	Create data
1172	1	1	2019-05-23 15:04:12.436741+03	core	RefBuildings	787	\N	{"srcName":"core.RefBuildings.c","srcPK":"787"}	Create data
1174	1	1	2019-05-23 15:04:12.869668+03	core	RefBuildings	789	\N	{"srcName":"core.RefBuildings.c","srcPK":"789"}	Create data
1176	1	1	2019-05-23 15:04:13.206141+03	core	RefBuildings	791	\N	{"srcName":"core.RefBuildings.c","srcPK":"791"}	Create data
1178	1	1	2019-05-23 15:04:13.56482+03	core	RefBuildings	793	\N	{"srcName":"core.RefBuildings.c","srcPK":"793"}	Create data
1180	1	1	2019-05-23 15:04:13.971927+03	core	RefBuildings	795	\N	{"srcName":"core.RefBuildings.c","srcPK":"795"}	Create data
1182	1	1	2019-05-23 15:04:14.380056+03	core	RefBuildings	797	\N	{"srcName":"core.RefBuildings.c","srcPK":"797"}	Create data
1184	1	1	2019-05-23 15:04:14.704408+03	core	RefBuildings	799	\N	{"srcName":"core.RefBuildings.c","srcPK":"799"}	Create data
1186	1	1	2019-05-23 15:04:15.016851+03	core	RefBuildings	801	\N	{"srcName":"core.RefBuildings.c","srcPK":"801"}	Create data
1188	1	1	2019-05-23 15:04:15.357823+03	core	RefBuildings	803	\N	{"srcName":"core.RefBuildings.c","srcPK":"803"}	Create data
1190	1	1	2019-05-23 15:04:15.923988+03	core	RefBuildings	805	\N	{"srcName":"core.RefBuildings.c","srcPK":"805"}	Create data
1192	1	1	2019-05-23 15:04:16.442438+03	core	RefBuildings	807	\N	{"srcName":"core.RefBuildings.c","srcPK":"807"}	Create data
1194	1	1	2019-05-23 15:04:16.96971+03	core	RefBuildings	809	\N	{"srcName":"core.RefBuildings.c","srcPK":"809"}	Create data
1196	1	1	2019-05-23 15:04:17.360098+03	core	RefBuildings	811	\N	{"srcName":"core.RefBuildings.c","srcPK":"811"}	Create data
1198	1	1	2019-05-23 15:04:17.743884+03	core	RefBuildings	813	\N	{"srcName":"core.RefBuildings.c","srcPK":"813"}	Create data
1097	1	1	2019-05-23 15:03:57.932075+03	core	RefBuildings	712	\N	{"srcName":"core.RefBuildings.c","srcPK":"712"}	Create data
1099	1	1	2019-05-23 15:03:58.239168+03	core	RefBuildings	714	\N	{"srcName":"core.RefBuildings.c","srcPK":"714"}	Create data
1101	1	1	2019-05-23 15:03:58.640552+03	core	RefBuildings	716	\N	{"srcName":"core.RefBuildings.c","srcPK":"716"}	Create data
1103	1	1	2019-05-23 15:03:59.021601+03	core	RefBuildings	718	\N	{"srcName":"core.RefBuildings.c","srcPK":"718"}	Create data
1105	1	1	2019-05-23 15:03:59.353693+03	core	RefBuildings	720	\N	{"srcName":"core.RefBuildings.c","srcPK":"720"}	Create data
1107	1	1	2019-05-23 15:03:59.740855+03	core	RefBuildings	722	\N	{"srcName":"core.RefBuildings.c","srcPK":"722"}	Create data
1109	1	1	2019-05-23 15:04:00.036906+03	core	RefBuildings	724	\N	{"srcName":"core.RefBuildings.c","srcPK":"724"}	Create data
1111	1	1	2019-05-23 15:04:01.004888+03	core	RefBuildings	726	\N	{"srcName":"core.RefBuildings.c","srcPK":"726"}	Create data
1113	1	1	2019-05-23 15:04:01.320718+03	core	RefBuildings	728	\N	{"srcName":"core.RefBuildings.c","srcPK":"728"}	Create data
1115	1	1	2019-05-23 15:04:01.655813+03	core	RefBuildings	730	\N	{"srcName":"core.RefBuildings.c","srcPK":"730"}	Create data
1117	1	1	2019-05-23 15:04:02.081156+03	core	RefBuildings	732	\N	{"srcName":"core.RefBuildings.c","srcPK":"732"}	Create data
1119	1	1	2019-05-23 15:04:02.545107+03	core	RefBuildings	734	\N	{"srcName":"core.RefBuildings.c","srcPK":"734"}	Create data
1121	1	1	2019-05-23 15:04:02.882725+03	core	RefBuildings	736	\N	{"srcName":"core.RefBuildings.c","srcPK":"736"}	Create data
1123	1	1	2019-05-23 15:04:03.233134+03	core	RefBuildings	738	\N	{"srcName":"core.RefBuildings.c","srcPK":"738"}	Create data
1125	1	1	2019-05-23 15:04:03.558383+03	core	RefBuildings	740	\N	{"srcName":"core.RefBuildings.c","srcPK":"740"}	Create data
1127	1	1	2019-05-23 15:04:03.934662+03	core	RefBuildings	742	\N	{"srcName":"core.RefBuildings.c","srcPK":"742"}	Create data
1129	1	1	2019-05-23 15:04:04.307966+03	core	RefBuildings	744	\N	{"srcName":"core.RefBuildings.c","srcPK":"744"}	Create data
1131	1	1	2019-05-23 15:04:04.726587+03	core	RefBuildings	746	\N	{"srcName":"core.RefBuildings.c","srcPK":"746"}	Create data
1133	1	1	2019-05-23 15:04:05.159506+03	core	RefBuildings	748	\N	{"srcName":"core.RefBuildings.c","srcPK":"748"}	Create data
1135	1	1	2019-05-23 15:04:05.512175+03	core	RefBuildings	750	\N	{"srcName":"core.RefBuildings.c","srcPK":"750"}	Create data
1137	1	1	2019-05-23 15:04:05.894424+03	core	RefBuildings	752	\N	{"srcName":"core.RefBuildings.c","srcPK":"752"}	Create data
1139	1	1	2019-05-23 15:04:06.370979+03	core	RefBuildings	754	\N	{"srcName":"core.RefBuildings.c","srcPK":"754"}	Create data
1141	1	1	2019-05-23 15:04:06.915569+03	core	RefBuildings	756	\N	{"srcName":"core.RefBuildings.c","srcPK":"756"}	Create data
1143	1	1	2019-05-23 15:04:07.220431+03	core	RefBuildings	758	\N	{"srcName":"core.RefBuildings.c","srcPK":"758"}	Create data
1145	1	1	2019-05-23 15:04:07.562406+03	core	RefBuildings	760	\N	{"srcName":"core.RefBuildings.c","srcPK":"760"}	Create data
1147	1	1	2019-05-23 15:04:07.872299+03	core	RefBuildings	762	\N	{"srcName":"core.RefBuildings.c","srcPK":"762"}	Create data
1149	1	1	2019-05-23 15:04:08.184253+03	core	RefBuildings	764	\N	{"srcName":"core.RefBuildings.c","srcPK":"764"}	Create data
1151	1	1	2019-05-23 15:04:08.478864+03	core	RefBuildings	766	\N	{"srcName":"core.RefBuildings.c","srcPK":"766"}	Create data
1153	1	1	2019-05-23 15:04:08.771698+03	core	RefBuildings	768	\N	{"srcName":"core.RefBuildings.c","srcPK":"768"}	Create data
1155	1	1	2019-05-23 15:04:09.139483+03	core	RefBuildings	770	\N	{"srcName":"core.RefBuildings.c","srcPK":"770"}	Create data
1157	1	1	2019-05-23 15:04:09.439823+03	core	RefBuildings	772	\N	{"srcName":"core.RefBuildings.c","srcPK":"772"}	Create data
1159	1	1	2019-05-23 15:04:09.83433+03	core	RefBuildings	774	\N	{"srcName":"core.RefBuildings.c","srcPK":"774"}	Create data
1161	1	1	2019-05-23 15:04:10.317417+03	core	RefBuildings	776	\N	{"srcName":"core.RefBuildings.c","srcPK":"776"}	Create data
1163	1	1	2019-05-23 15:04:10.831946+03	core	RefBuildings	778	\N	{"srcName":"core.RefBuildings.c","srcPK":"778"}	Create data
1165	1	1	2019-05-23 15:04:11.148631+03	core	RefBuildings	780	\N	{"srcName":"core.RefBuildings.c","srcPK":"780"}	Create data
1167	1	1	2019-05-23 15:04:11.517617+03	core	RefBuildings	782	\N	{"srcName":"core.RefBuildings.c","srcPK":"782"}	Create data
1169	1	1	2019-05-23 15:04:11.951751+03	core	RefBuildings	784	\N	{"srcName":"core.RefBuildings.c","srcPK":"784"}	Create data
1171	1	1	2019-05-23 15:04:12.259563+03	core	RefBuildings	786	\N	{"srcName":"core.RefBuildings.c","srcPK":"786"}	Create data
1173	1	1	2019-05-23 15:04:12.619222+03	core	RefBuildings	788	\N	{"srcName":"core.RefBuildings.c","srcPK":"788"}	Create data
1175	1	1	2019-05-23 15:04:13.046664+03	core	RefBuildings	790	\N	{"srcName":"core.RefBuildings.c","srcPK":"790"}	Create data
1177	1	1	2019-05-23 15:04:13.390031+03	core	RefBuildings	792	\N	{"srcName":"core.RefBuildings.c","srcPK":"792"}	Create data
1179	1	1	2019-05-23 15:04:13.772739+03	core	RefBuildings	794	\N	{"srcName":"core.RefBuildings.c","srcPK":"794"}	Create data
1181	1	1	2019-05-23 15:04:14.164885+03	core	RefBuildings	796	\N	{"srcName":"core.RefBuildings.c","srcPK":"796"}	Create data
1183	1	1	2019-05-23 15:04:14.557344+03	core	RefBuildings	798	\N	{"srcName":"core.RefBuildings.c","srcPK":"798"}	Create data
1185	1	1	2019-05-23 15:04:14.857562+03	core	RefBuildings	800	\N	{"srcName":"core.RefBuildings.c","srcPK":"800"}	Create data
1187	1	1	2019-05-23 15:04:15.166293+03	core	RefBuildings	802	\N	{"srcName":"core.RefBuildings.c","srcPK":"802"}	Create data
1189	1	1	2019-05-23 15:04:15.60818+03	core	RefBuildings	804	\N	{"srcName":"core.RefBuildings.c","srcPK":"804"}	Create data
1191	1	1	2019-05-23 15:04:16.26634+03	core	RefBuildings	806	\N	{"srcName":"core.RefBuildings.c","srcPK":"806"}	Create data
1193	1	1	2019-05-23 15:04:16.627261+03	core	RefBuildings	808	\N	{"srcName":"core.RefBuildings.c","srcPK":"808"}	Create data
1195	1	1	2019-05-23 15:04:17.19527+03	core	RefBuildings	810	\N	{"srcName":"core.RefBuildings.c","srcPK":"810"}	Create data
1197	1	1	2019-05-23 15:04:17.536098+03	core	RefBuildings	812	\N	{"srcName":"core.RefBuildings.c","srcPK":"812"}	Create data
1199	1	1	2019-05-23 15:04:17.919593+03	core	RefBuildings	814	\N	{"srcName":"core.RefBuildings.c","srcPK":"814"}	Create data
1200	1	1	2019-05-23 15:04:18.103737+03	core	RefBuildings	815	\N	{"srcName":"core.RefBuildings.c","srcPK":"815"}	Create data
1202	1	1	2019-05-23 15:04:18.486104+03	core	RefBuildings	817	\N	{"srcName":"core.RefBuildings.c","srcPK":"817"}	Create data
1204	1	1	2019-05-23 15:04:18.795069+03	core	RefBuildings	819	\N	{"srcName":"core.RefBuildings.c","srcPK":"819"}	Create data
1206	1	1	2019-05-23 15:04:19.14511+03	core	RefBuildings	821	\N	{"srcName":"core.RefBuildings.c","srcPK":"821"}	Create data
1208	1	1	2019-05-23 15:04:19.494872+03	core	RefBuildings	823	\N	{"srcName":"core.RefBuildings.c","srcPK":"823"}	Create data
1210	1	1	2019-05-23 15:04:19.788887+03	core	RefBuildings	825	\N	{"srcName":"core.RefBuildings.c","srcPK":"825"}	Create data
1212	1	1	2019-05-23 15:04:20.13133+03	core	RefBuildings	827	\N	{"srcName":"core.RefBuildings.c","srcPK":"827"}	Create data
1214	1	1	2019-05-23 15:04:20.498282+03	core	RefBuildings	829	\N	{"srcName":"core.RefBuildings.c","srcPK":"829"}	Create data
1216	1	1	2019-05-23 15:04:20.898377+03	core	RefBuildings	831	\N	{"srcName":"core.RefBuildings.c","srcPK":"831"}	Create data
1218	1	1	2019-05-23 15:04:21.379566+03	core	RefBuildings	833	\N	{"srcName":"core.RefBuildings.c","srcPK":"833"}	Create data
1220	1	1	2019-05-23 15:04:21.663964+03	core	RefBuildings	835	\N	{"srcName":"core.RefBuildings.c","srcPK":"835"}	Create data
1222	1	1	2019-05-23 15:04:22.129495+03	core	RefBuildings	837	\N	{"srcName":"core.RefBuildings.c","srcPK":"837"}	Create data
1224	1	1	2019-05-23 15:04:22.474598+03	core	RefBuildings	839	\N	{"srcName":"core.RefBuildings.c","srcPK":"839"}	Create data
1226	1	1	2019-05-23 15:04:22.846591+03	core	RefBuildings	841	\N	{"srcName":"core.RefBuildings.c","srcPK":"841"}	Create data
1228	1	1	2019-05-23 15:04:23.167398+03	core	RefBuildingGroups	1	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"1"}	Create data
1230	1	1	2019-05-23 15:04:23.484207+03	core	RefBuildingGroups	3	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"3"}	Create data
1232	1	1	2019-05-23 15:04:23.781732+03	core	RefBuildingGroups	5	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"5"}	Create data
1234	1	1	2019-05-23 15:04:24.139462+03	core	RefBuildingGroups	7	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"7"}	Create data
1236	1	1	2019-05-23 15:04:24.560294+03	core	RefBuildingGroups	9	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"9"}	Create data
1238	1	1	2019-05-23 15:04:24.866209+03	core	RefBuildingGroups	11	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"11"}	Create data
1240	1	1	2019-05-23 15:04:25.177811+03	core	RefBuildingGroups	13	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"13"}	Create data
1242	1	1	2019-05-23 15:04:25.512303+03	core	RefBuildingGroups	15	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"15"}	Create data
1244	1	1	2019-05-23 15:04:25.835619+03	core	RefBuildingGroups	17	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"17"}	Create data
1246	1	1	2019-05-23 15:04:26.347067+03	core	RefBuildingGroups	19	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"19"}	Create data
1248	1	1	2019-05-23 15:04:26.729188+03	core	RefBuildingGroups	21	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"21"}	Create data
1250	1	1	2019-05-23 15:04:27.331654+03	core	RefBuildingGroups	23	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"23"}	Create data
1252	1	1	2019-05-23 15:04:27.70747+03	core	RefBuildingGroups	25	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"25"}	Create data
1254	1	1	2019-05-23 15:04:28.09019+03	core	RefBuildingGroups	27	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"27"}	Create data
1256	1	1	2019-05-23 15:04:28.482374+03	core	RefBuildingGroups	29	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"29"}	Create data
1258	1	1	2019-05-23 15:04:28.832257+03	core	RefBuildingGroups	31	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"31"}	Create data
1260	1	1	2019-05-23 15:04:29.174173+03	core	RefBuildingGroups	33	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"33"}	Create data
1262	1	1	2019-05-23 15:04:29.508781+03	core	RefBuildingGroups	35	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"35"}	Create data
1264	1	1	2019-05-23 15:04:29.842679+03	core	RefBuildingGroups	37	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"37"}	Create data
1266	1	1	2019-05-23 15:04:30.1671+03	core	RefBuildingGroups	39	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"39"}	Create data
1268	1	1	2019-05-23 15:04:30.54958+03	core	RefBuildingGroups	41	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"41"}	Create data
1270	1	1	2019-05-23 15:04:30.951081+03	core	RefBuildingGroups	43	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"43"}	Create data
1272	1	1	2019-05-23 15:04:31.775453+03	core	RefBuildingGroups	45	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"45"}	Create data
1274	1	1	2019-05-23 15:04:32.861528+03	core	RefBuildingGroups	47	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"47"}	Create data
1276	1	1	2019-05-23 15:04:33.285759+03	core	RefBuildingGroups	49	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"49"}	Create data
1278	1	1	2019-05-23 15:04:33.595023+03	core	RefBuildingGroups	51	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"51"}	Create data
1280	1	1	2019-05-23 15:04:33.894784+03	core	RefBuildingGroups	53	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"53"}	Create data
1282	1	1	2019-05-23 15:04:34.230139+03	core	RefBuildingGroups	55	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"55"}	Create data
1284	1	1	2019-05-23 15:04:34.55614+03	core	RefBuildingGroups	57	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"57"}	Create data
1286	1	1	2019-05-23 15:04:35.083657+03	core	RefBuildingGroups	59	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"59"}	Create data
1201	1	1	2019-05-23 15:04:18.319458+03	core	RefBuildings	816	\N	{"srcName":"core.RefBuildings.c","srcPK":"816"}	Create data
1203	1	1	2019-05-23 15:04:18.628404+03	core	RefBuildings	818	\N	{"srcName":"core.RefBuildings.c","srcPK":"818"}	Create data
1205	1	1	2019-05-23 15:04:18.950428+03	core	RefBuildings	820	\N	{"srcName":"core.RefBuildings.c","srcPK":"820"}	Create data
1207	1	1	2019-05-23 15:04:19.314105+03	core	RefBuildings	822	\N	{"srcName":"core.RefBuildings.c","srcPK":"822"}	Create data
1209	1	1	2019-05-23 15:04:19.645153+03	core	RefBuildings	824	\N	{"srcName":"core.RefBuildings.c","srcPK":"824"}	Create data
1211	1	1	2019-05-23 15:04:19.972149+03	core	RefBuildings	826	\N	{"srcName":"core.RefBuildings.c","srcPK":"826"}	Create data
1213	1	1	2019-05-23 15:04:20.331158+03	core	RefBuildings	828	\N	{"srcName":"core.RefBuildings.c","srcPK":"828"}	Create data
1215	1	1	2019-05-23 15:04:20.681503+03	core	RefBuildings	830	\N	{"srcName":"core.RefBuildings.c","srcPK":"830"}	Create data
1217	1	1	2019-05-23 15:04:21.195993+03	core	RefBuildings	832	\N	{"srcName":"core.RefBuildings.c","srcPK":"832"}	Create data
1219	1	1	2019-05-23 15:04:21.521699+03	core	RefBuildings	834	\N	{"srcName":"core.RefBuildings.c","srcPK":"834"}	Create data
1221	1	1	2019-05-23 15:04:21.823208+03	core	RefBuildings	836	\N	{"srcName":"core.RefBuildings.c","srcPK":"836"}	Create data
1223	1	1	2019-05-23 15:04:22.263022+03	core	RefBuildings	838	\N	{"srcName":"core.RefBuildings.c","srcPK":"838"}	Create data
1225	1	1	2019-05-23 15:04:22.668955+03	core	RefBuildings	840	\N	{"srcName":"core.RefBuildings.c","srcPK":"840"}	Create data
1227	1	1	2019-05-23 15:04:22.992626+03	core	RefBuildings	842	\N	{"srcName":"core.RefBuildings.c","srcPK":"842"}	Create data
1229	1	1	2019-05-23 15:04:23.335339+03	core	RefBuildingGroups	2	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"2"}	Create data
1231	1	1	2019-05-23 15:04:23.630103+03	core	RefBuildingGroups	4	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"4"}	Create data
1233	1	1	2019-05-23 15:04:23.934726+03	core	RefBuildingGroups	6	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"6"}	Create data
1235	1	1	2019-05-23 15:04:24.327547+03	core	RefBuildingGroups	8	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"8"}	Create data
1237	1	1	2019-05-23 15:04:24.710468+03	core	RefBuildingGroups	10	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"10"}	Create data
1239	1	1	2019-05-23 15:04:25.035649+03	core	RefBuildingGroups	12	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"12"}	Create data
1241	1	1	2019-05-23 15:04:25.354032+03	core	RefBuildingGroups	14	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"14"}	Create data
1243	1	1	2019-05-23 15:04:25.686929+03	core	RefBuildingGroups	16	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"16"}	Create data
1245	1	1	2019-05-23 15:04:26.032883+03	core	RefBuildingGroups	18	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"18"}	Create data
1247	1	1	2019-05-23 15:04:26.530664+03	core	RefBuildingGroups	20	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"20"}	Create data
1249	1	1	2019-05-23 15:04:27.097725+03	core	RefBuildingGroups	22	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"22"}	Create data
1251	1	1	2019-05-23 15:04:27.548297+03	core	RefBuildingGroups	24	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"24"}	Create data
1253	1	1	2019-05-23 15:04:27.889538+03	core	RefBuildingGroups	26	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"26"}	Create data
1255	1	1	2019-05-23 15:04:28.324341+03	core	RefBuildingGroups	28	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"28"}	Create data
1257	1	1	2019-05-23 15:04:28.639972+03	core	RefBuildingGroups	30	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"30"}	Create data
1259	1	1	2019-05-23 15:04:28.998753+03	core	RefBuildingGroups	32	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"32"}	Create data
1261	1	1	2019-05-23 15:04:29.363036+03	core	RefBuildingGroups	34	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"34"}	Create data
1263	1	1	2019-05-23 15:04:29.690838+03	core	RefBuildingGroups	36	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"36"}	Create data
1265	1	1	2019-05-23 15:04:30.016509+03	core	RefBuildingGroups	38	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"38"}	Create data
1267	1	1	2019-05-23 15:04:30.366425+03	core	RefBuildingGroups	40	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"40"}	Create data
1269	1	1	2019-05-23 15:04:30.775296+03	core	RefBuildingGroups	42	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"42"}	Create data
1271	1	1	2019-05-23 15:04:31.143659+03	core	RefBuildingGroups	44	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"44"}	Create data
1273	1	1	2019-05-23 15:04:32.233756+03	core	RefBuildingGroups	46	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"46"}	Create data
1275	1	1	2019-05-23 15:04:33.035561+03	core	RefBuildingGroups	48	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"48"}	Create data
1277	1	1	2019-05-23 15:04:33.442374+03	core	RefBuildingGroups	50	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"50"}	Create data
1279	1	1	2019-05-23 15:04:33.751118+03	core	RefBuildingGroups	52	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"52"}	Create data
1281	1	1	2019-05-23 15:04:34.055456+03	core	RefBuildingGroups	54	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"54"}	Create data
1283	1	1	2019-05-23 15:04:34.405536+03	core	RefBuildingGroups	56	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"56"}	Create data
1285	1	1	2019-05-23 15:04:34.746783+03	core	RefBuildingGroups	58	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"58"}	Create data
1287	1	1	2019-05-23 15:04:35.422872+03	core	RefBuildingGroups	60	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"60"}	Create data
1288	1	1	2019-05-23 15:04:35.731021+03	core	RefBuildingGroups	61	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"61"}	Create data
1289	1	1	2019-05-23 15:04:35.931894+03	core	RefBuildingGroups	62	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"62"}	Create data
1290	1	1	2019-05-23 15:04:36.107675+03	core	RefBuildingGroups	63	\N	{"srcName":"core.RefBuildingGroups.c","srcPK":"63"}	Create data
1291	1	1	2019-05-23 15:04:36.293124+03	core	RefDevelopers	1	\N	{"srcName":"core.RefDevelopers.c","srcPK":"1"}	Create data
1292	1	1	2019-05-23 15:04:36.457342+03	core	RefDevelopers	2	\N	{"srcName":"core.RefDevelopers.c","srcPK":"2"}	Create data
1293	1	1	2019-05-23 15:04:36.624223+03	core	RefDevelopers	3	\N	{"srcName":"core.RefDevelopers.c","srcPK":"3"}	Create data
1294	1	1	2019-05-23 15:04:36.781841+03	core	RefDevelopers	4	\N	{"srcName":"core.RefDevelopers.c","srcPK":"4"}	Create data
1295	1	1	2019-05-23 15:04:36.933053+03	core	RefDevelopers	5	\N	{"srcName":"core.RefDevelopers.c","srcPK":"5"}	Create data
1296	1	1	2019-05-23 15:04:37.351156+03	core	RefDevelopers	6	\N	{"srcName":"core.RefDevelopers.c","srcPK":"6"}	Create data
1298	1	1	2019-05-23 15:04:37.750099+03	core	RefDevelopers	8	\N	{"srcName":"core.RefDevelopers.c","srcPK":"8"}	Create data
1300	1	1	2019-05-23 15:04:38.119179+03	core	RefDevelopers	10	\N	{"srcName":"core.RefDevelopers.c","srcPK":"10"}	Create data
1302	1	1	2019-05-23 15:04:38.433936+03	core	RefDevelopers	12	\N	{"srcName":"core.RefDevelopers.c","srcPK":"12"}	Create data
1304	1	1	2019-05-23 15:04:38.826195+03	core	RefMarks	2	\N	{"srcName":"core.RefMarks.c","srcPK":"2"}	Create data
1306	1	1	2019-05-23 15:04:39.185245+03	core	RefMarks	4	\N	{"srcName":"core.RefMarks.c","srcPK":"4"}	Create data
1308	1	1	2019-05-23 15:04:39.501925+03	core	RefMarks	6	\N	{"srcName":"core.RefMarks.c","srcPK":"6"}	Create data
1310	1	1	2019-05-23 15:04:39.878503+03	core	RefMarks	8	\N	{"srcName":"core.RefMarks.c","srcPK":"8"}	Create data
1312	1	1	2019-05-23 15:04:40.310288+03	core	RefMarks	10	\N	{"srcName":"core.RefMarks.c","srcPK":"10"}	Create data
1314	1	1	2019-05-23 15:04:40.620289+03	core	RefMarks	12	\N	{"srcName":"core.RefMarks.c","srcPK":"12"}	Create data
1316	1	1	2019-05-23 15:04:40.995144+03	core	RefMarks	14	\N	{"srcName":"core.RefMarks.c","srcPK":"14"}	Create data
1318	1	1	2019-05-23 15:04:41.37911+03	core	RefMarks	16	\N	{"srcName":"core.RefMarks.c","srcPK":"16"}	Create data
1320	1	1	2019-05-23 15:04:41.729458+03	core	RefMarks	18	\N	{"srcName":"core.RefMarks.c","srcPK":"18"}	Create data
1322	1	1	2019-05-23 15:04:42.171764+03	core	RefMarks	20	\N	{"srcName":"core.RefMarks.c","srcPK":"20"}	Create data
1324	1	1	2019-05-23 15:04:42.642559+03	core	RefMarks	22	\N	{"srcName":"core.RefMarks.c","srcPK":"22"}	Create data
1326	1	1	2019-05-23 15:04:42.972283+03	core	RefMarks	24	\N	{"srcName":"core.RefMarks.c","srcPK":"24"}	Create data
1328	1	1	2019-05-23 15:04:43.299393+03	core	RefMarks	26	\N	{"srcName":"core.RefMarks.c","srcPK":"26"}	Create data
1330	1	1	2019-05-23 15:04:43.603322+03	core	RefMarks	28	\N	{"srcName":"core.RefMarks.c","srcPK":"28"}	Create data
1332	1	1	2019-05-23 15:04:44.291168+03	core	RefMarks	30	\N	{"srcName":"core.RefMarks.c","srcPK":"30"}	Create data
1334	1	1	2019-05-23 15:04:44.735605+03	core	RefMarks	32	\N	{"srcName":"core.RefMarks.c","srcPK":"32"}	Create data
1336	1	1	2019-05-23 15:04:45.217769+03	core	RefMarks	34	\N	{"srcName":"core.RefMarks.c","srcPK":"34"}	Create data
1338	1	1	2019-05-23 15:04:45.618715+03	core	RefMarks	36	\N	{"srcName":"core.RefMarks.c","srcPK":"36"}	Create data
1340	1	1	2019-05-23 15:04:45.944257+03	core	RefMarks	38	\N	{"srcName":"core.RefMarks.c","srcPK":"38"}	Create data
1342	1	1	2019-05-23 15:04:46.353867+03	core	RefMarks	40	\N	{"srcName":"core.RefMarks.c","srcPK":"40"}	Create data
1344	1	1	2019-05-23 15:04:46.669659+03	core	RefMarks	42	\N	{"srcName":"core.RefMarks.c","srcPK":"42"}	Create data
1346	1	1	2019-05-23 15:04:47.037471+03	core	RefMarks	44	\N	{"srcName":"core.RefMarks.c","srcPK":"44"}	Create data
1348	1	1	2019-05-23 15:04:47.579836+03	core	RefMarks	46	\N	{"srcName":"core.RefMarks.c","srcPK":"46"}	Create data
1350	1	1	2019-05-23 15:04:47.938629+03	core	RefMarks	48	\N	{"srcName":"core.RefMarks.c","srcPK":"48"}	Create data
1352	1	1	2019-05-23 15:04:48.274969+03	core	RefMarks	50	\N	{"srcName":"core.RefMarks.c","srcPK":"50"}	Create data
1354	1	1	2019-05-23 15:04:48.672653+03	core	RefMarks	52	\N	{"srcName":"core.RefMarks.c","srcPK":"52"}	Create data
1356	1	1	2019-05-23 15:04:49.106603+03	core	RefMarks	54	\N	{"srcName":"core.RefMarks.c","srcPK":"54"}	Create data
1358	1	1	2019-05-23 15:04:49.472723+03	core	RefMarks	56	\N	{"srcName":"core.RefMarks.c","srcPK":"56"}	Create data
1360	1	1	2019-05-23 15:04:49.806301+03	core	RefMarks	58	\N	{"srcName":"core.RefMarks.c","srcPK":"58"}	Create data
1362	1	1	2019-05-23 15:04:50.165984+03	core	RefMarks	60	\N	{"srcName":"core.RefMarks.c","srcPK":"60"}	Create data
1364	1	1	2019-05-23 15:04:50.465645+03	core	RefMarks	62	\N	{"srcName":"core.RefMarks.c","srcPK":"62"}	Create data
1366	1	1	2019-05-23 15:04:50.774388+03	core	RefMarks	64	\N	{"srcName":"core.RefMarks.c","srcPK":"64"}	Create data
1368	1	1	2019-05-23 15:04:51.144289+03	core	RefMarks	66	\N	{"srcName":"core.RefMarks.c","srcPK":"66"}	Create data
1370	1	1	2019-05-23 15:04:51.433527+03	core	RefMarks	68	\N	{"srcName":"core.RefMarks.c","srcPK":"68"}	Create data
1372	1	1	2019-05-23 15:04:51.855577+03	core	RefMarks	70	\N	{"srcName":"core.RefMarks.c","srcPK":"70"}	Create data
1374	1	1	2019-05-23 15:04:52.355572+03	core	RefMarks	72	\N	{"srcName":"core.RefMarks.c","srcPK":"72"}	Create data
1376	1	1	2019-05-23 15:04:52.839365+03	core	RefMarks	74	\N	{"srcName":"core.RefMarks.c","srcPK":"74"}	Create data
1378	1	1	2019-05-23 15:04:53.326112+03	core	RefMarks	76	\N	{"srcName":"core.RefMarks.c","srcPK":"76"}	Create data
1380	1	1	2019-05-23 15:04:53.626794+03	core	RefMarks	78	\N	{"srcName":"core.RefMarks.c","srcPK":"78"}	Create data
1382	1	1	2019-05-23 15:04:53.921188+03	core	RefMarks	80	\N	{"srcName":"core.RefMarks.c","srcPK":"80"}	Create data
1384	1	1	2019-05-23 15:04:54.430942+03	core	RefMarks	82	\N	{"srcName":"core.RefMarks.c","srcPK":"82"}	Create data
1386	1	1	2019-05-23 15:04:54.787692+03	core	RefMarks	84	\N	{"srcName":"core.RefMarks.c","srcPK":"84"}	Create data
1388	1	1	2019-05-23 15:04:55.129575+03	core	RefMarks	86	\N	{"srcName":"core.RefMarks.c","srcPK":"86"}	Create data
1390	1	1	2019-05-23 15:04:55.463215+03	core	RefMarks	88	\N	{"srcName":"core.RefMarks.c","srcPK":"88"}	Create data
1392	1	1	2019-05-23 15:04:55.815397+03	core	RefMarks	90	\N	{"srcName":"core.RefMarks.c","srcPK":"90"}	Create data
1394	1	1	2019-05-23 15:04:56.181312+03	core	RefMarks	92	\N	{"srcName":"core.RefMarks.c","srcPK":"92"}	Create data
1396	1	1	2019-05-23 15:04:56.556608+03	core	RefMarks	94	\N	{"srcName":"core.RefMarks.c","srcPK":"94"}	Create data
1398	1	1	2019-05-23 15:04:56.916941+03	core	RefMarks	96	\N	{"srcName":"core.RefMarks.c","srcPK":"96"}	Create data
1400	1	1	2019-05-23 15:04:57.452609+03	core	RefMarks	98	\N	{"srcName":"core.RefMarks.c","srcPK":"98"}	Create data
1402	1	1	2019-05-23 15:04:57.783614+03	core	RefMarks	100	\N	{"srcName":"core.RefMarks.c","srcPK":"100"}	Create data
1404	1	1	2019-05-23 15:04:58.117465+03	core	RefMarks	102	\N	{"srcName":"core.RefMarks.c","srcPK":"102"}	Create data
1406	1	1	2019-05-23 15:04:58.492764+03	core	RefMarks	104	\N	{"srcName":"core.RefMarks.c","srcPK":"104"}	Create data
1408	1	1	2019-05-23 15:04:58.841801+03	core	RefMarks	106	\N	{"srcName":"core.RefMarks.c","srcPK":"106"}	Create data
1297	1	1	2019-05-23 15:04:37.533009+03	core	RefDevelopers	7	\N	{"srcName":"core.RefDevelopers.c","srcPK":"7"}	Create data
1299	1	1	2019-05-23 15:04:37.908237+03	core	RefDevelopers	9	\N	{"srcName":"core.RefDevelopers.c","srcPK":"9"}	Create data
1301	1	1	2019-05-23 15:04:38.276903+03	core	RefDevelopers	11	\N	{"srcName":"core.RefDevelopers.c","srcPK":"11"}	Create data
1303	1	1	2019-05-23 15:04:38.626602+03	core	RefMarks	1	\N	{"srcName":"core.RefMarks.c","srcPK":"1"}	Create data
1305	1	1	2019-05-23 15:04:38.993184+03	core	RefMarks	3	\N	{"srcName":"core.RefMarks.c","srcPK":"3"}	Create data
1307	1	1	2019-05-23 15:04:39.352011+03	core	RefMarks	5	\N	{"srcName":"core.RefMarks.c","srcPK":"5"}	Create data
1309	1	1	2019-05-23 15:04:39.652638+03	core	RefMarks	7	\N	{"srcName":"core.RefMarks.c","srcPK":"7"}	Create data
1311	1	1	2019-05-23 15:04:40.070158+03	core	RefMarks	9	\N	{"srcName":"core.RefMarks.c","srcPK":"9"}	Create data
1313	1	1	2019-05-23 15:04:40.462445+03	core	RefMarks	11	\N	{"srcName":"core.RefMarks.c","srcPK":"11"}	Create data
1315	1	1	2019-05-23 15:04:40.800459+03	core	RefMarks	13	\N	{"srcName":"core.RefMarks.c","srcPK":"13"}	Create data
1317	1	1	2019-05-23 15:04:41.205208+03	core	RefMarks	15	\N	{"srcName":"core.RefMarks.c","srcPK":"15"}	Create data
1319	1	1	2019-05-23 15:04:41.571443+03	core	RefMarks	17	\N	{"srcName":"core.RefMarks.c","srcPK":"17"}	Create data
1321	1	1	2019-05-23 15:04:41.880055+03	core	RefMarks	19	\N	{"srcName":"core.RefMarks.c","srcPK":"19"}	Create data
1323	1	1	2019-05-23 15:04:42.379855+03	core	RefMarks	21	\N	{"srcName":"core.RefMarks.c","srcPK":"21"}	Create data
1325	1	1	2019-05-23 15:04:42.829494+03	core	RefMarks	23	\N	{"srcName":"core.RefMarks.c","srcPK":"23"}	Create data
1327	1	1	2019-05-23 15:04:43.147329+03	core	RefMarks	25	\N	{"srcName":"core.RefMarks.c","srcPK":"25"}	Create data
1329	1	1	2019-05-23 15:04:43.442338+03	core	RefMarks	27	\N	{"srcName":"core.RefMarks.c","srcPK":"27"}	Create data
1331	1	1	2019-05-23 15:04:43.784393+03	core	RefMarks	29	\N	{"srcName":"core.RefMarks.c","srcPK":"29"}	Create data
1333	1	1	2019-05-23 15:04:44.533907+03	core	RefMarks	31	\N	{"srcName":"core.RefMarks.c","srcPK":"31"}	Create data
1335	1	1	2019-05-23 15:04:44.976788+03	core	RefMarks	33	\N	{"srcName":"core.RefMarks.c","srcPK":"33"}	Create data
1337	1	1	2019-05-23 15:04:45.409615+03	core	RefMarks	35	\N	{"srcName":"core.RefMarks.c","srcPK":"35"}	Create data
1339	1	1	2019-05-23 15:04:45.776485+03	core	RefMarks	37	\N	{"srcName":"core.RefMarks.c","srcPK":"37"}	Create data
1341	1	1	2019-05-23 15:04:46.186307+03	core	RefMarks	39	\N	{"srcName":"core.RefMarks.c","srcPK":"39"}	Create data
1343	1	1	2019-05-23 15:04:46.518359+03	core	RefMarks	41	\N	{"srcName":"core.RefMarks.c","srcPK":"41"}	Create data
1345	1	1	2019-05-23 15:04:46.823927+03	core	RefMarks	43	\N	{"srcName":"core.RefMarks.c","srcPK":"43"}	Create data
1347	1	1	2019-05-23 15:04:47.421213+03	core	RefMarks	45	\N	{"srcName":"core.RefMarks.c","srcPK":"45"}	Create data
1349	1	1	2019-05-23 15:04:47.738971+03	core	RefMarks	47	\N	{"srcName":"core.RefMarks.c","srcPK":"47"}	Create data
1351	1	1	2019-05-23 15:04:48.087935+03	core	RefMarks	49	\N	{"srcName":"core.RefMarks.c","srcPK":"49"}	Create data
1353	1	1	2019-05-23 15:04:48.488675+03	core	RefMarks	51	\N	{"srcName":"core.RefMarks.c","srcPK":"51"}	Create data
1355	1	1	2019-05-23 15:04:48.864264+03	core	RefMarks	53	\N	{"srcName":"core.RefMarks.c","srcPK":"53"}	Create data
1357	1	1	2019-05-23 15:04:49.297565+03	core	RefMarks	55	\N	{"srcName":"core.RefMarks.c","srcPK":"55"}	Create data
1359	1	1	2019-05-23 15:04:49.647916+03	core	RefMarks	57	\N	{"srcName":"core.RefMarks.c","srcPK":"57"}	Create data
1361	1	1	2019-05-23 15:04:50.007524+03	core	RefMarks	59	\N	{"srcName":"core.RefMarks.c","srcPK":"59"}	Create data
1363	1	1	2019-05-23 15:04:50.31353+03	core	RefMarks	61	\N	{"srcName":"core.RefMarks.c","srcPK":"61"}	Create data
1365	1	1	2019-05-23 15:04:50.616328+03	core	RefMarks	63	\N	{"srcName":"core.RefMarks.c","srcPK":"63"}	Create data
1367	1	1	2019-05-23 15:04:50.933458+03	core	RefMarks	65	\N	{"srcName":"core.RefMarks.c","srcPK":"65"}	Create data
1369	1	1	2019-05-23 15:04:51.288337+03	core	RefMarks	67	\N	{"srcName":"core.RefMarks.c","srcPK":"67"}	Create data
1371	1	1	2019-05-23 15:04:51.609111+03	core	RefMarks	69	\N	{"srcName":"core.RefMarks.c","srcPK":"69"}	Create data
1373	1	1	2019-05-23 15:04:52.068876+03	core	RefMarks	71	\N	{"srcName":"core.RefMarks.c","srcPK":"71"}	Create data
1375	1	1	2019-05-23 15:04:52.526487+03	core	RefMarks	73	\N	{"srcName":"core.RefMarks.c","srcPK":"73"}	Create data
1377	1	1	2019-05-23 15:04:53.117484+03	core	RefMarks	75	\N	{"srcName":"core.RefMarks.c","srcPK":"75"}	Create data
1379	1	1	2019-05-23 15:04:53.479122+03	core	RefMarks	77	\N	{"srcName":"core.RefMarks.c","srcPK":"77"}	Create data
1381	1	1	2019-05-23 15:04:53.769649+03	core	RefMarks	79	\N	{"srcName":"core.RefMarks.c","srcPK":"79"}	Create data
1383	1	1	2019-05-23 15:04:54.273239+03	core	RefMarks	81	\N	{"srcName":"core.RefMarks.c","srcPK":"81"}	Create data
1385	1	1	2019-05-23 15:04:54.595235+03	core	RefMarks	83	\N	{"srcName":"core.RefMarks.c","srcPK":"83"}	Create data
1387	1	1	2019-05-23 15:04:54.938199+03	core	RefMarks	85	\N	{"srcName":"core.RefMarks.c","srcPK":"85"}	Create data
1389	1	1	2019-05-23 15:04:55.287838+03	core	RefMarks	87	\N	{"srcName":"core.RefMarks.c","srcPK":"87"}	Create data
1391	1	1	2019-05-23 15:04:55.663147+03	core	RefMarks	89	\N	{"srcName":"core.RefMarks.c","srcPK":"89"}	Create data
1393	1	1	2019-05-23 15:04:56.005683+03	core	RefMarks	91	\N	{"srcName":"core.RefMarks.c","srcPK":"91"}	Create data
1395	1	1	2019-05-23 15:04:56.358292+03	core	RefMarks	93	\N	{"srcName":"core.RefMarks.c","srcPK":"93"}	Create data
1397	1	1	2019-05-23 15:04:56.732272+03	core	RefMarks	95	\N	{"srcName":"core.RefMarks.c","srcPK":"95"}	Create data
1399	1	1	2019-05-23 15:04:57.106475+03	core	RefMarks	97	\N	{"srcName":"core.RefMarks.c","srcPK":"97"}	Create data
1401	1	1	2019-05-23 15:04:57.63168+03	core	RefMarks	99	\N	{"srcName":"core.RefMarks.c","srcPK":"99"}	Create data
1403	1	1	2019-05-23 15:04:57.941573+03	core	RefMarks	101	\N	{"srcName":"core.RefMarks.c","srcPK":"101"}	Create data
1405	1	1	2019-05-23 15:04:58.299247+03	core	RefMarks	103	\N	{"srcName":"core.RefMarks.c","srcPK":"103"}	Create data
1407	1	1	2019-05-23 15:04:58.663883+03	core	RefMarks	105	\N	{"srcName":"core.RefMarks.c","srcPK":"105"}	Create data
1409	1	1	2019-05-23 15:04:59.044061+03	core	RefMarks	107	\N	{"srcName":"core.RefMarks.c","srcPK":"107"}	Create data
1411	1	1	2019-05-23 15:04:59.401045+03	core	RefMarks	109	\N	{"srcName":"core.RefMarks.c","srcPK":"109"}	Create data
1410	1	1	2019-05-23 15:04:59.243191+03	core	RefMarks	108	\N	{"srcName":"core.RefMarks.c","srcPK":"108"}	Create data
1412	1	1	2019-05-23 15:04:59.560113+03	core	RefMarks	110	\N	{"srcName":"core.RefMarks.c","srcPK":"110"}	Create data
1414	1	1	2019-05-23 15:04:59.894085+03	core	RefMarks	112	\N	{"srcName":"core.RefMarks.c","srcPK":"112"}	Create data
1416	1	1	2019-05-23 15:05:00.292806+03	core	RefMarks	114	\N	{"srcName":"core.RefMarks.c","srcPK":"114"}	Create data
1418	1	1	2019-05-23 15:05:00.594393+03	core	RefMarks	116	\N	{"srcName":"core.RefMarks.c","srcPK":"116"}	Create data
1420	1	1	2019-05-23 15:05:00.919604+03	core	RefMarks	118	\N	{"srcName":"core.RefMarks.c","srcPK":"118"}	Create data
1422	1	1	2019-05-23 15:05:01.200393+03	core	RefMarks	120	\N	{"srcName":"core.RefMarks.c","srcPK":"120"}	Create data
1424	1	1	2019-05-23 15:05:01.512464+03	core	RefMarks	122	\N	{"srcName":"core.RefMarks.c","srcPK":"122"}	Create data
1426	1	1	2019-05-23 15:05:01.854056+03	core	RefMarks	124	\N	{"srcName":"core.RefMarks.c","srcPK":"124"}	Create data
1428	1	1	2019-05-23 15:05:02.363929+03	core	RefMarks	126	\N	{"srcName":"core.RefMarks.c","srcPK":"126"}	Create data
1430	1	1	2019-05-23 15:05:02.674553+03	core	RefMarks	128	\N	{"srcName":"core.RefMarks.c","srcPK":"128"}	Create data
1432	1	1	2019-05-23 15:05:03.056429+03	core	RefMarks	130	\N	{"srcName":"core.RefMarks.c","srcPK":"130"}	Create data
1434	1	1	2019-05-23 15:05:04.440787+03	core	RefMarks	132	\N	{"srcName":"core.RefMarks.c","srcPK":"132"}	Create data
1436	1	1	2019-05-23 15:05:04.818554+03	core	RefMarks	134	\N	{"srcName":"core.RefMarks.c","srcPK":"134"}	Create data
1438	1	1	2019-05-23 15:05:05.251779+03	core	RefMarks	136	\N	{"srcName":"core.RefMarks.c","srcPK":"136"}	Create data
1440	1	1	2019-05-23 15:05:05.62467+03	core	RefMarks	138	\N	{"srcName":"core.RefMarks.c","srcPK":"138"}	Create data
1442	1	1	2019-05-23 15:05:06.01025+03	core	RefMarks	140	\N	{"srcName":"core.RefMarks.c","srcPK":"140"}	Create data
1444	1	1	2019-05-23 15:05:06.377743+03	core	RefMarks	142	\N	{"srcName":"core.RefMarks.c","srcPK":"142"}	Create data
1446	1	1	2019-05-23 15:05:06.86897+03	core	RefMarks	144	\N	{"srcName":"core.RefMarks.c","srcPK":"144"}	Create data
1448	1	1	2019-05-23 15:05:07.212625+03	core	RefMarks	146	\N	{"srcName":"core.RefMarks.c","srcPK":"146"}	Create data
1450	1	1	2019-05-23 15:05:07.737408+03	core	RefMarks	148	\N	{"srcName":"core.RefMarks.c","srcPK":"148"}	Create data
1452	1	1	2019-05-23 15:05:08.187127+03	core	RefMarks	150	\N	{"srcName":"core.RefMarks.c","srcPK":"150"}	Create data
1454	1	1	2019-05-23 15:05:08.546539+03	core	RefMarks	152	\N	{"srcName":"core.RefMarks.c","srcPK":"152"}	Create data
1456	1	1	2019-05-23 15:05:08.897414+03	core	RefMarks	154	\N	{"srcName":"core.RefMarks.c","srcPK":"154"}	Create data
1458	1	1	2019-05-23 15:05:09.329656+03	core	RefMarks	156	\N	{"srcName":"core.RefMarks.c","srcPK":"156"}	Create data
1460	1	1	2019-05-23 15:05:09.630277+03	core	RefMarks	158	\N	{"srcName":"core.RefMarks.c","srcPK":"158"}	Create data
1462	1	1	2019-05-23 15:05:09.964083+03	core	RefMarks	160	\N	{"srcName":"core.RefMarks.c","srcPK":"160"}	Create data
1464	1	1	2019-05-23 15:05:10.389311+03	core	RefMarks	162	\N	{"srcName":"core.RefMarks.c","srcPK":"162"}	Create data
1466	1	1	2019-05-23 15:05:10.805795+03	core	RefMarks	164	\N	{"srcName":"core.RefMarks.c","srcPK":"164"}	Create data
1468	1	1	2019-05-23 15:05:11.13277+03	core	RefMarks	166	\N	{"srcName":"core.RefMarks.c","srcPK":"166"}	Create data
1470	1	1	2019-05-23 15:05:11.507532+03	core	RefMarks	168	\N	{"srcName":"core.RefMarks.c","srcPK":"168"}	Create data
1472	1	1	2019-05-23 15:05:11.80929+03	core	RefMarks	170	\N	{"srcName":"core.RefMarks.c","srcPK":"170"}	Create data
1474	1	1	2019-05-23 15:05:12.175697+03	core	RefMarks	172	\N	{"srcName":"core.RefMarks.c","srcPK":"172"}	Create data
1476	1	1	2019-05-23 15:05:12.6938+03	core	RefMarks	174	\N	{"srcName":"core.RefMarks.c","srcPK":"174"}	Create data
1478	1	1	2019-05-23 15:05:13.119886+03	core	RefMarks	176	\N	{"srcName":"core.RefMarks.c","srcPK":"176"}	Create data
1480	1	1	2019-05-23 15:05:13.445157+03	core	RefMarks	178	\N	{"srcName":"core.RefMarks.c","srcPK":"178"}	Create data
1482	1	1	2019-05-23 15:05:13.796028+03	core	RefMarks	180	\N	{"srcName":"core.RefMarks.c","srcPK":"180"}	Create data
1484	1	1	2019-05-23 15:05:14.163516+03	core	RefMarks	182	\N	{"srcName":"core.RefMarks.c","srcPK":"182"}	Create data
1486	1	1	2019-05-23 15:05:14.527628+03	core	RefMarks	184	\N	{"srcName":"core.RefMarks.c","srcPK":"184"}	Create data
1488	1	1	2019-05-23 15:05:14.81167+03	core	RefMarks	186	\N	{"srcName":"core.RefMarks.c","srcPK":"186"}	Create data
1490	1	1	2019-05-23 15:05:15.113566+03	core	RefMarks	188	\N	{"srcName":"core.RefMarks.c","srcPK":"188"}	Create data
1492	1	1	2019-05-23 15:05:15.422202+03	core	RefMarks	190	\N	{"srcName":"core.RefMarks.c","srcPK":"190"}	Create data
1494	1	1	2019-05-23 15:05:15.832349+03	core	RefMarks	192	\N	{"srcName":"core.RefMarks.c","srcPK":"192"}	Create data
1496	1	1	2019-05-23 15:05:16.214817+03	core	RefMarks	194	\N	{"srcName":"core.RefMarks.c","srcPK":"194"}	Create data
1498	1	1	2019-05-23 15:05:16.582248+03	core	RefMarks	196	\N	{"srcName":"core.RefMarks.c","srcPK":"196"}	Create data
1500	1	1	2019-05-23 15:05:16.954411+03	core	RefMarks	198	\N	{"srcName":"core.RefMarks.c","srcPK":"198"}	Create data
1502	1	1	2019-05-23 15:05:17.300233+03	core	RefMarks	200	\N	{"srcName":"core.RefMarks.c","srcPK":"200"}	Create data
1504	1	1	2019-05-23 15:05:17.809186+03	core	RefMarks	202	\N	{"srcName":"core.RefMarks.c","srcPK":"202"}	Create data
1506	1	1	2019-05-23 15:05:18.211393+03	core	RefMarks	204	\N	{"srcName":"core.RefMarks.c","srcPK":"204"}	Create data
1508	1	1	2019-05-23 15:05:18.542463+03	core	RefMarks	206	\N	{"srcName":"core.RefMarks.c","srcPK":"206"}	Create data
1510	1	1	2019-05-23 15:05:18.842024+03	core	RefMarks	208	\N	{"srcName":"core.RefMarks.c","srcPK":"208"}	Create data
1512	1	1	2019-05-23 15:05:19.20511+03	core	RefMarks	210	\N	{"srcName":"core.RefMarks.c","srcPK":"210"}	Create data
1514	1	1	2019-05-23 15:05:19.512946+03	core	RefMarks	212	\N	{"srcName":"core.RefMarks.c","srcPK":"212"}	Create data
1516	1	1	2019-05-23 15:05:19.814006+03	core	RefMarks	214	\N	{"srcName":"core.RefMarks.c","srcPK":"214"}	Create data
1518	1	1	2019-05-23 15:05:20.294916+03	core	RefMarks	216	\N	{"srcName":"core.RefMarks.c","srcPK":"216"}	Create data
1520	1	1	2019-05-23 15:05:20.611844+03	core	RefMarks	218	\N	{"srcName":"core.RefMarks.c","srcPK":"218"}	Create data
1522	1	1	2019-05-23 15:05:20.978648+03	core	RefMarks	220	\N	{"srcName":"core.RefMarks.c","srcPK":"220"}	Create data
1524	1	1	2019-05-23 15:05:21.363564+03	core	RefMarks	222	\N	{"srcName":"core.RefMarks.c","srcPK":"222"}	Create data
1413	1	1	2019-05-23 15:04:59.736226+03	core	RefMarks	111	\N	{"srcName":"core.RefMarks.c","srcPK":"111"}	Create data
1415	1	1	2019-05-23 15:05:00.120655+03	core	RefMarks	113	\N	{"srcName":"core.RefMarks.c","srcPK":"113"}	Create data
1417	1	1	2019-05-23 15:05:00.438101+03	core	RefMarks	115	\N	{"srcName":"core.RefMarks.c","srcPK":"115"}	Create data
1419	1	1	2019-05-23 15:05:00.794114+03	core	RefMarks	117	\N	{"srcName":"core.RefMarks.c","srcPK":"117"}	Create data
1421	1	1	2019-05-23 15:05:01.057417+03	core	RefMarks	119	\N	{"srcName":"core.RefMarks.c","srcPK":"119"}	Create data
1423	1	1	2019-05-23 15:05:01.353991+03	core	RefMarks	121	\N	{"srcName":"core.RefMarks.c","srcPK":"121"}	Create data
1425	1	1	2019-05-23 15:05:01.69546+03	core	RefMarks	123	\N	{"srcName":"core.RefMarks.c","srcPK":"123"}	Create data
1427	1	1	2019-05-23 15:05:02.063474+03	core	RefMarks	125	\N	{"srcName":"core.RefMarks.c","srcPK":"125"}	Create data
1429	1	1	2019-05-23 15:05:02.50618+03	core	RefMarks	127	\N	{"srcName":"core.RefMarks.c","srcPK":"127"}	Create data
1431	1	1	2019-05-23 15:05:02.865158+03	core	RefMarks	129	\N	{"srcName":"core.RefMarks.c","srcPK":"129"}	Create data
1433	1	1	2019-05-23 15:05:04.291941+03	core	RefMarks	131	\N	{"srcName":"core.RefMarks.c","srcPK":"131"}	Create data
1435	1	1	2019-05-23 15:05:04.633929+03	core	RefMarks	133	\N	{"srcName":"core.RefMarks.c","srcPK":"133"}	Create data
1437	1	1	2019-05-23 15:05:05.0333+03	core	RefMarks	135	\N	{"srcName":"core.RefMarks.c","srcPK":"135"}	Create data
1439	1	1	2019-05-23 15:05:05.425245+03	core	RefMarks	137	\N	{"srcName":"core.RefMarks.c","srcPK":"137"}	Create data
1441	1	1	2019-05-23 15:05:05.843531+03	core	RefMarks	139	\N	{"srcName":"core.RefMarks.c","srcPK":"139"}	Create data
1443	1	1	2019-05-23 15:05:06.22588+03	core	RefMarks	141	\N	{"srcName":"core.RefMarks.c","srcPK":"141"}	Create data
1445	1	1	2019-05-23 15:05:06.651528+03	core	RefMarks	143	\N	{"srcName":"core.RefMarks.c","srcPK":"143"}	Create data
1447	1	1	2019-05-23 15:05:07.026873+03	core	RefMarks	145	\N	{"srcName":"core.RefMarks.c","srcPK":"145"}	Create data
1449	1	1	2019-05-23 15:05:07.552651+03	core	RefMarks	147	\N	{"srcName":"core.RefMarks.c","srcPK":"147"}	Create data
1451	1	1	2019-05-23 15:05:08.019754+03	core	RefMarks	149	\N	{"srcName":"core.RefMarks.c","srcPK":"149"}	Create data
1453	1	1	2019-05-23 15:05:08.345626+03	core	RefMarks	151	\N	{"srcName":"core.RefMarks.c","srcPK":"151"}	Create data
1455	1	1	2019-05-23 15:05:08.739254+03	core	RefMarks	153	\N	{"srcName":"core.RefMarks.c","srcPK":"153"}	Create data
1457	1	1	2019-05-23 15:05:09.085292+03	core	RefMarks	155	\N	{"srcName":"core.RefMarks.c","srcPK":"155"}	Create data
1459	1	1	2019-05-23 15:05:09.47144+03	core	RefMarks	157	\N	{"srcName":"core.RefMarks.c","srcPK":"157"}	Create data
1461	1	1	2019-05-23 15:05:09.785343+03	core	RefMarks	159	\N	{"srcName":"core.RefMarks.c","srcPK":"159"}	Create data
1463	1	1	2019-05-23 15:05:10.230715+03	core	RefMarks	161	\N	{"srcName":"core.RefMarks.c","srcPK":"161"}	Create data
1465	1	1	2019-05-23 15:05:10.590699+03	core	RefMarks	163	\N	{"srcName":"core.RefMarks.c","srcPK":"163"}	Create data
1467	1	1	2019-05-23 15:05:10.982+03	core	RefMarks	165	\N	{"srcName":"core.RefMarks.c","srcPK":"165"}	Create data
1469	1	1	2019-05-23 15:05:11.316059+03	core	RefMarks	167	\N	{"srcName":"core.RefMarks.c","srcPK":"167"}	Create data
1471	1	1	2019-05-23 15:05:11.658446+03	core	RefMarks	169	\N	{"srcName":"core.RefMarks.c","srcPK":"169"}	Create data
1473	1	1	2019-05-23 15:05:12.025481+03	core	RefMarks	171	\N	{"srcName":"core.RefMarks.c","srcPK":"171"}	Create data
1475	1	1	2019-05-23 15:05:12.526939+03	core	RefMarks	173	\N	{"srcName":"core.RefMarks.c","srcPK":"173"}	Create data
1477	1	1	2019-05-23 15:05:12.900324+03	core	RefMarks	175	\N	{"srcName":"core.RefMarks.c","srcPK":"175"}	Create data
1479	1	1	2019-05-23 15:05:13.287343+03	core	RefMarks	177	\N	{"srcName":"core.RefMarks.c","srcPK":"177"}	Create data
1481	1	1	2019-05-23 15:05:13.612783+03	core	RefMarks	179	\N	{"srcName":"core.RefMarks.c","srcPK":"179"}	Create data
1483	1	1	2019-05-23 15:05:13.978889+03	core	RefMarks	181	\N	{"srcName":"core.RefMarks.c","srcPK":"181"}	Create data
1485	1	1	2019-05-23 15:05:14.373059+03	core	RefMarks	183	\N	{"srcName":"core.RefMarks.c","srcPK":"183"}	Create data
1487	1	1	2019-05-23 15:05:14.66972+03	core	RefMarks	185	\N	{"srcName":"core.RefMarks.c","srcPK":"185"}	Create data
1489	1	1	2019-05-23 15:05:14.970494+03	core	RefMarks	187	\N	{"srcName":"core.RefMarks.c","srcPK":"187"}	Create data
1491	1	1	2019-05-23 15:05:15.263953+03	core	RefMarks	189	\N	{"srcName":"core.RefMarks.c","srcPK":"189"}	Create data
1493	1	1	2019-05-23 15:05:15.622555+03	core	RefMarks	191	\N	{"srcName":"core.RefMarks.c","srcPK":"191"}	Create data
1495	1	1	2019-05-23 15:05:16.056215+03	core	RefMarks	193	\N	{"srcName":"core.RefMarks.c","srcPK":"193"}	Create data
1497	1	1	2019-05-23 15:05:16.37261+03	core	RefMarks	195	\N	{"srcName":"core.RefMarks.c","srcPK":"195"}	Create data
1499	1	1	2019-05-23 15:05:16.790183+03	core	RefMarks	197	\N	{"srcName":"core.RefMarks.c","srcPK":"197"}	Create data
1501	1	1	2019-05-23 15:05:17.124683+03	core	RefMarks	199	\N	{"srcName":"core.RefMarks.c","srcPK":"199"}	Create data
1503	1	1	2019-05-23 15:05:17.60647+03	core	RefMarks	201	\N	{"srcName":"core.RefMarks.c","srcPK":"201"}	Create data
1505	1	1	2019-05-23 15:05:18.035589+03	core	RefMarks	203	\N	{"srcName":"core.RefMarks.c","srcPK":"203"}	Create data
1507	1	1	2019-05-23 15:05:18.391425+03	core	RefMarks	205	\N	{"srcName":"core.RefMarks.c","srcPK":"205"}	Create data
1509	1	1	2019-05-23 15:05:18.692987+03	core	RefMarks	207	\N	{"srcName":"core.RefMarks.c","srcPK":"207"}	Create data
1511	1	1	2019-05-23 15:05:19.017882+03	core	RefMarks	209	\N	{"srcName":"core.RefMarks.c","srcPK":"209"}	Create data
1513	1	1	2019-05-23 15:05:19.356074+03	core	RefMarks	211	\N	{"srcName":"core.RefMarks.c","srcPK":"211"}	Create data
1515	1	1	2019-05-23 15:05:19.660203+03	core	RefMarks	213	\N	{"srcName":"core.RefMarks.c","srcPK":"213"}	Create data
1517	1	1	2019-05-23 15:05:20.143909+03	core	RefMarks	215	\N	{"srcName":"core.RefMarks.c","srcPK":"215"}	Create data
1519	1	1	2019-05-23 15:05:20.446491+03	core	RefMarks	217	\N	{"srcName":"core.RefMarks.c","srcPK":"217"}	Create data
1521	1	1	2019-05-23 15:05:20.803632+03	core	RefMarks	219	\N	{"srcName":"core.RefMarks.c","srcPK":"219"}	Create data
1523	1	1	2019-05-23 15:05:21.195864+03	core	RefMarks	221	\N	{"srcName":"core.RefMarks.c","srcPK":"221"}	Create data
1525	1	1	2019-05-23 15:05:21.504584+03	core	RefMarks	223	\N	{"srcName":"core.RefMarks.c","srcPK":"223"}	Create data
1527	1	1	2019-05-23 15:05:21.954391+03	core	RefMarks	225	\N	{"srcName":"core.RefMarks.c","srcPK":"225"}	Create data
1526	1	1	2019-05-23 15:05:21.748584+03	core	RefMarks	224	\N	{"srcName":"core.RefMarks.c","srcPK":"224"}	Create data
1528	1	1	2019-05-23 15:05:22.104733+03	core	RefMarks	226	\N	{"srcName":"core.RefMarks.c","srcPK":"226"}	Create data
1530	1	1	2019-05-23 15:05:22.647352+03	core	RefMarks	228	\N	{"srcName":"core.RefMarks.c","srcPK":"228"}	Create data
1532	1	1	2019-05-23 15:05:23.098337+03	core	RefMarks	230	\N	{"srcName":"core.RefMarks.c","srcPK":"230"}	Create data
1534	1	1	2019-05-23 15:05:23.42379+03	core	RefMarks	232	\N	{"srcName":"core.RefMarks.c","srcPK":"232"}	Create data
1536	1	1	2019-05-23 15:05:23.828942+03	core	RefMarks	234	\N	{"srcName":"core.RefMarks.c","srcPK":"234"}	Create data
1538	1	1	2019-05-23 15:05:24.241521+03	core	RefMarks	236	\N	{"srcName":"core.RefMarks.c","srcPK":"236"}	Create data
1540	1	1	2019-05-23 15:05:24.658297+03	core	RefMarks	238	\N	{"srcName":"core.RefMarks.c","srcPK":"238"}	Create data
1542	1	1	2019-05-23 15:05:25.065524+03	core	RefMarks	240	\N	{"srcName":"core.RefMarks.c","srcPK":"240"}	Create data
1544	1	1	2019-05-23 15:05:25.343212+03	core	RefMarks	242	\N	{"srcName":"core.RefMarks.c","srcPK":"242"}	Create data
1546	1	1	2019-05-23 15:05:25.608453+03	core	RefMarks	244	\N	{"srcName":"core.RefMarks.c","srcPK":"244"}	Create data
1548	1	1	2019-05-23 15:05:25.926554+03	core	RefMarks	246	\N	{"srcName":"core.RefMarks.c","srcPK":"246"}	Create data
1550	1	1	2019-05-23 15:05:26.236927+03	core	RefMarks	248	\N	{"srcName":"core.RefMarks.c","srcPK":"248"}	Create data
1552	1	1	2019-05-23 15:05:26.578593+03	core	RefMarks	250	\N	{"srcName":"core.RefMarks.c","srcPK":"250"}	Create data
1554	1	1	2019-05-23 15:05:26.91187+03	core	RefMarks	252	\N	{"srcName":"core.RefMarks.c","srcPK":"252"}	Create data
1556	1	1	2019-05-23 15:05:27.346182+03	core	RefMarks	254	\N	{"srcName":"core.RefMarks.c","srcPK":"254"}	Create data
1558	1	1	2019-05-23 15:05:27.854603+03	core	RefMarks	256	\N	{"srcName":"core.RefMarks.c","srcPK":"256"}	Create data
1560	1	1	2019-05-23 15:05:28.154573+03	core	RefMarks	258	\N	{"srcName":"core.RefMarks.c","srcPK":"258"}	Create data
1562	1	1	2019-05-23 15:05:28.473796+03	core	RefMarks	260	\N	{"srcName":"core.RefMarks.c","srcPK":"260"}	Create data
1564	1	1	2019-05-23 15:05:28.82974+03	core	RefMarks	262	\N	{"srcName":"core.RefMarks.c","srcPK":"262"}	Create data
1566	1	1	2019-05-23 15:05:29.142528+03	core	RefMarks	264	\N	{"srcName":"core.RefMarks.c","srcPK":"264"}	Create data
1568	1	1	2019-05-23 15:05:29.714275+03	core	RefMarks	266	\N	{"srcName":"core.RefMarks.c","srcPK":"266"}	Create data
1570	1	1	2019-05-23 15:05:30.275473+03	core	RefMarks	268	\N	{"srcName":"core.RefMarks.c","srcPK":"268"}	Create data
1572	1	1	2019-05-23 15:05:30.690857+03	core	RefMarks	270	\N	{"srcName":"core.RefMarks.c","srcPK":"270"}	Create data
1574	1	1	2019-05-23 15:05:31.10013+03	core	RefMarks	272	\N	{"srcName":"core.RefMarks.c","srcPK":"272"}	Create data
1576	1	1	2019-05-23 15:05:31.455253+03	core	RefMarks	274	\N	{"srcName":"core.RefMarks.c","srcPK":"274"}	Create data
1578	1	1	2019-05-23 15:05:31.840626+03	core	RefMarks	276	\N	{"srcName":"core.RefMarks.c","srcPK":"276"}	Create data
1580	1	1	2019-05-23 15:05:32.340574+03	core	RefMarks	278	\N	{"srcName":"core.RefMarks.c","srcPK":"278"}	Create data
1582	1	1	2019-05-23 15:05:33.143819+03	core	RefMarks	280	\N	{"srcName":"core.RefMarks.c","srcPK":"280"}	Create data
1584	1	1	2019-05-23 15:05:33.577447+03	core	RefMarks	282	\N	{"srcName":"core.RefMarks.c","srcPK":"282"}	Create data
1586	1	1	2019-05-23 15:05:33.929369+03	core	RefMarks	284	\N	{"srcName":"core.RefMarks.c","srcPK":"284"}	Create data
1588	1	1	2019-05-23 15:05:34.395629+03	core	RefMarks	286	\N	{"srcName":"core.RefMarks.c","srcPK":"286"}	Create data
1529	1	1	2019-05-23 15:05:22.280979+03	core	RefMarks	227	\N	{"srcName":"core.RefMarks.c","srcPK":"227"}	Create data
1531	1	1	2019-05-23 15:05:22.940922+03	core	RefMarks	229	\N	{"srcName":"core.RefMarks.c","srcPK":"229"}	Create data
1533	1	1	2019-05-23 15:05:23.254476+03	core	RefMarks	231	\N	{"srcName":"core.RefMarks.c","srcPK":"231"}	Create data
1535	1	1	2019-05-23 15:05:23.640172+03	core	RefMarks	233	\N	{"srcName":"core.RefMarks.c","srcPK":"233"}	Create data
1537	1	1	2019-05-23 15:05:23.983597+03	core	RefMarks	235	\N	{"srcName":"core.RefMarks.c","srcPK":"235"}	Create data
1539	1	1	2019-05-23 15:05:24.441377+03	core	RefMarks	237	\N	{"srcName":"core.RefMarks.c","srcPK":"237"}	Create data
1541	1	1	2019-05-23 15:05:24.857016+03	core	RefMarks	239	\N	{"srcName":"core.RefMarks.c","srcPK":"239"}	Create data
1543	1	1	2019-05-23 15:05:25.207547+03	core	RefMarks	241	\N	{"srcName":"core.RefMarks.c","srcPK":"241"}	Create data
1545	1	1	2019-05-23 15:05:25.481454+03	core	RefMarks	243	\N	{"srcName":"core.RefMarks.c","srcPK":"243"}	Create data
1547	1	1	2019-05-23 15:05:25.751027+03	core	RefMarks	245	\N	{"srcName":"core.RefMarks.c","srcPK":"245"}	Create data
1549	1	1	2019-05-23 15:05:26.090877+03	core	RefMarks	247	\N	{"srcName":"core.RefMarks.c","srcPK":"247"}	Create data
1551	1	1	2019-05-23 15:05:26.419771+03	core	RefMarks	249	\N	{"srcName":"core.RefMarks.c","srcPK":"249"}	Create data
1553	1	1	2019-05-23 15:05:26.761103+03	core	RefMarks	251	\N	{"srcName":"core.RefMarks.c","srcPK":"251"}	Create data
1555	1	1	2019-05-23 15:05:27.133322+03	core	RefMarks	253	\N	{"srcName":"core.RefMarks.c","srcPK":"253"}	Create data
1557	1	1	2019-05-23 15:05:27.665695+03	core	RefMarks	255	\N	{"srcName":"core.RefMarks.c","srcPK":"255"}	Create data
1559	1	1	2019-05-23 15:05:28.012995+03	core	RefMarks	257	\N	{"srcName":"core.RefMarks.c","srcPK":"257"}	Create data
1561	1	1	2019-05-23 15:05:28.323523+03	core	RefMarks	259	\N	{"srcName":"core.RefMarks.c","srcPK":"259"}	Create data
1563	1	1	2019-05-23 15:05:28.617158+03	core	RefMarks	261	\N	{"srcName":"core.RefMarks.c","srcPK":"261"}	Create data
1565	1	1	2019-05-23 15:05:28.980932+03	core	RefMarks	263	\N	{"srcName":"core.RefMarks.c","srcPK":"263"}	Create data
1567	1	1	2019-05-23 15:05:29.531629+03	core	RefMarks	265	\N	{"srcName":"core.RefMarks.c","srcPK":"265"}	Create data
1569	1	1	2019-05-23 15:05:29.865033+03	core	RefMarks	267	\N	{"srcName":"core.RefMarks.c","srcPK":"267"}	Create data
1571	1	1	2019-05-23 15:05:30.48074+03	core	RefMarks	269	\N	{"srcName":"core.RefMarks.c","srcPK":"269"}	Create data
1573	1	1	2019-05-23 15:05:30.87463+03	core	RefMarks	271	\N	{"srcName":"core.RefMarks.c","srcPK":"271"}	Create data
1575	1	1	2019-05-23 15:05:31.29033+03	core	RefMarks	273	\N	{"srcName":"core.RefMarks.c","srcPK":"273"}	Create data
1577	1	1	2019-05-23 15:05:31.652103+03	core	RefMarks	275	\N	{"srcName":"core.RefMarks.c","srcPK":"275"}	Create data
1579	1	1	2019-05-23 15:05:32.043147+03	core	RefMarks	277	\N	{"srcName":"core.RefMarks.c","srcPK":"277"}	Create data
1581	1	1	2019-05-23 15:05:32.876165+03	core	RefMarks	279	\N	{"srcName":"core.RefMarks.c","srcPK":"279"}	Create data
1583	1	1	2019-05-23 15:05:33.386739+03	core	RefMarks	281	\N	{"srcName":"core.RefMarks.c","srcPK":"281"}	Create data
1585	1	1	2019-05-23 15:05:33.771798+03	core	RefMarks	283	\N	{"srcName":"core.RefMarks.c","srcPK":"283"}	Create data
1587	1	1	2019-05-23 15:05:34.087415+03	core	RefMarks	285	\N	{"srcName":"core.RefMarks.c","srcPK":"285"}	Create data
1589	1	1	2019-05-23 15:05:35.170973+03	core	RefMarks	287	\N	{"srcName":"core.RefMarks.c","srcPK":"287"}	Create data
1590	1	1	2019-05-23 15:05:35.52765+03	core	RefMarks	288	\N	{"srcName":"core.RefMarks.c","srcPK":"288"}	Create data
1591	1	1	2019-05-23 15:05:35.920285+03	core	RefMarks	289	\N	{"srcName":"core.RefMarks.c","srcPK":"289"}	Create data
1592	1	1	2019-05-23 15:05:36.09348+03	core	RefMarks	290	\N	{"srcName":"core.RefMarks.c","srcPK":"290"}	Create data
1593	1	1	2019-05-23 15:05:36.25154+03	core	RefMarks	291	\N	{"srcName":"core.RefMarks.c","srcPK":"291"}	Create data
1594	1	1	2019-05-23 15:05:36.422492+03	core	RefMarks	292	\N	{"srcName":"core.RefMarks.c","srcPK":"292"}	Create data
1595	1	1	2019-05-23 15:05:36.629102+03	core	RefMarks	293	\N	{"srcName":"core.RefMarks.c","srcPK":"293"}	Create data
1596	1	1	2019-05-23 15:05:36.758685+03	core	RefMarks	294	\N	{"srcName":"core.RefMarks.c","srcPK":"294"}	Create data
1597	1	1	2019-05-23 15:05:36.91553+03	core	RefContractors	1	\N	{"srcName":"core.RefContractors.c","srcPK":"1"}	Create data
1598	1	1	2019-05-23 15:05:37.081221+03	core	RefContractors	2	\N	{"srcName":"core.RefContractors.c","srcPK":"2"}	Create data
1599	1	1	2019-05-23 15:05:37.251942+03	core	RefContractors	3	\N	{"srcName":"core.RefContractors.c","srcPK":"3"}	Create data
1600	1	1	2019-05-23 15:05:37.398917+03	core	RefContractors	4	\N	{"srcName":"core.RefContractors.c","srcPK":"4"}	Create data
1601	1	1	2019-05-23 15:05:37.609383+03	core	RefContractors	5	\N	{"srcName":"core.RefContractors.c","srcPK":"5"}	Create data
1602	1	1	2019-05-23 15:05:37.94151+03	core	RefContractors	6	\N	{"srcName":"core.RefContractors.c","srcPK":"6"}	Create data
1603	1	1	2019-05-23 15:05:38.106309+03	core	RefContractors	7	\N	{"srcName":"core.RefContractors.c","srcPK":"7"}	Create data
1604	1	1	2019-05-23 15:05:38.293931+03	core	RefContractors	8	\N	{"srcName":"core.RefContractors.c","srcPK":"8"}	Create data
1605	1	1	2019-05-23 15:05:38.499994+03	core	RefContractors	9	\N	{"srcName":"core.RefContractors.c","srcPK":"9"}	Create data
1606	1	1	2019-05-23 15:05:38.664856+03	core	RefContractors	10	\N	{"srcName":"core.RefContractors.c","srcPK":"10"}	Create data
1607	1	1	2019-05-23 15:05:38.908581+03	core	RefContractors	11	\N	{"srcName":"core.RefContractors.c","srcPK":"11"}	Create data
1608	1	1	2019-05-23 15:05:39.054314+03	core	RefContractors	12	\N	{"srcName":"core.RefContractors.c","srcPK":"12"}	Create data
1609	1	1	2019-05-23 15:05:39.346002+03	core	RefContractors	13	\N	{"srcName":"core.RefContractors.c","srcPK":"13"}	Create data
1610	1	1	2019-05-23 15:05:39.837724+03	core	RefContractors	14	\N	{"srcName":"core.RefContractors.c","srcPK":"14"}	Create data
1611	1	1	2019-05-23 15:05:40.039788+03	core	RefContractors	15	\N	{"srcName":"core.RefContractors.c","srcPK":"15"}	Create data
1612	1	1	2019-05-23 15:05:40.196937+03	core	RefContractors	16	\N	{"srcName":"core.RefContractors.c","srcPK":"16"}	Create data
1613	1	1	2019-05-23 15:05:40.456081+03	core	RefContractors	17	\N	{"srcName":"core.RefContractors.c","srcPK":"17"}	Create data
1614	1	1	2019-05-23 15:05:40.646881+03	core	RefContractors	18	\N	{"srcName":"core.RefContractors.c","srcPK":"18"}	Create data
1615	1	1	2019-05-23 15:05:40.853478+03	core	RefContractors	19	\N	{"srcName":"core.RefContractors.c","srcPK":"19"}	Create data
1617	1	1	2019-05-23 15:05:41.346965+03	core	RefContractors	21	\N	{"srcName":"core.RefContractors.c","srcPK":"21"}	Create data
1619	1	1	2019-05-23 15:05:41.773247+03	core	RefContractors	23	\N	{"srcName":"core.RefContractors.c","srcPK":"23"}	Create data
1621	1	1	2019-05-23 15:05:42.088912+03	core	RefContractors	25	\N	{"srcName":"core.RefContractors.c","srcPK":"25"}	Create data
1623	1	1	2019-05-23 15:05:42.339216+03	core	RefContractors	27	\N	{"srcName":"core.RefContractors.c","srcPK":"27"}	Create data
1625	1	1	2019-05-23 15:05:42.642519+03	core	RefContractors	29	\N	{"srcName":"core.RefContractors.c","srcPK":"29"}	Create data
1627	1	1	2019-05-23 15:05:43.225486+03	core	RefContractors	31	\N	{"srcName":"core.RefContractors.c","srcPK":"31"}	Create data
1629	1	1	2019-05-23 15:05:43.500128+03	core	RefContractors	33	\N	{"srcName":"core.RefContractors.c","srcPK":"33"}	Create data
1631	1	1	2019-05-23 15:05:43.900153+03	core	RefContractors	35	\N	{"srcName":"core.RefContractors.c","srcPK":"35"}	Create data
1633	1	1	2019-05-23 15:05:44.192995+03	core	RefContractors	37	\N	{"srcName":"core.RefContractors.c","srcPK":"37"}	Create data
1635	1	1	2019-05-23 15:05:44.519537+03	core	RefContractors	39	\N	{"srcName":"core.RefContractors.c","srcPK":"39"}	Create data
1637	1	1	2019-05-23 15:05:45.002347+03	core	RefContractors	41	\N	{"srcName":"core.RefContractors.c","srcPK":"41"}	Create data
1639	1	1	2019-05-23 15:05:45.387473+03	core	RefContractors	43	\N	{"srcName":"core.RefContractors.c","srcPK":"43"}	Create data
1641	1	1	2019-05-23 15:05:45.719758+03	core	RefContractors	45	\N	{"srcName":"core.RefContractors.c","srcPK":"45"}	Create data
1643	1	1	2019-05-23 15:05:46.053519+03	core	RefContractors	47	\N	{"srcName":"core.RefContractors.c","srcPK":"47"}	Create data
1645	1	1	2019-05-23 15:05:46.479025+03	core	RefContractors	49	\N	{"srcName":"core.RefContractors.c","srcPK":"49"}	Create data
1647	1	1	2019-05-23 15:05:46.839076+03	core	RefContractors	51	\N	{"srcName":"core.RefContractors.c","srcPK":"51"}	Create data
1649	1	1	2019-05-23 15:05:47.189509+03	core	RefContractors	53	\N	{"srcName":"core.RefContractors.c","srcPK":"53"}	Create data
1651	1	1	2019-05-23 15:05:47.522062+03	core	RefContractors	55	\N	{"srcName":"core.RefContractors.c","srcPK":"55"}	Create data
1653	1	1	2019-05-23 15:05:47.855825+03	core	RefContractors	57	\N	{"srcName":"core.RefContractors.c","srcPK":"57"}	Create data
1655	1	1	2019-05-23 15:05:48.157023+03	core	RefContractors	59	\N	{"srcName":"core.RefContractors.c","srcPK":"59"}	Create data
1657	1	1	2019-05-23 15:05:48.490412+03	core	RefContractors	61	\N	{"srcName":"core.RefContractors.c","srcPK":"61"}	Create data
1659	1	1	2019-05-23 15:05:48.829832+03	core	RefContractors	63	\N	{"srcName":"core.RefContractors.c","srcPK":"63"}	Create data
1661	1	1	2019-05-23 15:05:49.150376+03	core	RefContractors	65	\N	{"srcName":"core.RefContractors.c","srcPK":"65"}	Create data
1663	1	1	2019-05-23 15:05:49.501229+03	core	RefContractors	67	\N	{"srcName":"core.RefContractors.c","srcPK":"67"}	Create data
1665	1	1	2019-05-23 15:05:50.120202+03	core	RefContractors	69	\N	{"srcName":"core.RefContractors.c","srcPK":"69"}	Create data
1667	1	1	2019-05-23 15:05:50.442361+03	core	RefContractors	71	\N	{"srcName":"core.RefContractors.c","srcPK":"71"}	Create data
1669	1	1	2019-05-23 15:05:50.794759+03	core	RefDocCodes	1	\N	{"srcName":"core.RefDocCodes.c","srcPK":"1"}	Create data
1671	1	1	2019-05-23 15:05:51.126931+03	core	RefDocCodes	3	\N	{"srcName":"core.RefDocCodes.c","srcPK":"3"}	Create data
1673	1	1	2019-05-23 15:05:52.019903+03	core	RefDocCodes	5	\N	{"srcName":"core.RefDocCodes.c","srcPK":"5"}	Create data
1675	1	1	2019-05-23 15:05:53.31418+03	core	RefDocCodes	7	\N	{"srcName":"core.RefDocCodes.c","srcPK":"7"}	Create data
1677	1	1	2019-05-23 15:05:54.373541+03	core	RefDocCodes	9	\N	{"srcName":"core.RefDocCodes.c","srcPK":"9"}	Create data
1679	1	1	2019-05-23 15:05:55.190752+03	core	RefChapterCodes	1	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"1"}	Create data
1681	1	1	2019-05-23 15:05:55.709978+03	core	RefChapterCodes	3	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"3"}	Create data
1683	1	1	2019-05-23 15:05:56.057162+03	core	RefChapterCodes	5	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"5"}	Create data
1685	1	1	2019-05-23 15:05:56.426874+03	core	RefChapterCodes	7	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"7"}	Create data
1687	1	1	2019-05-23 15:05:56.750959+03	core	RefChapterCodes	9	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"9"}	Create data
1689	1	1	2019-05-23 15:05:57.022636+03	core	RefChapterCodes	11	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"11"}	Create data
1691	1	1	2019-05-23 15:05:57.43769+03	core	RefChapterCodes	13	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"13"}	Create data
1693	1	1	2019-05-23 15:05:57.811708+03	core	RefChapterCodes	15	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"15"}	Create data
1695	1	1	2019-05-23 15:05:58.208021+03	core	RefChapterCodes	17	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"17"}	Create data
1697	1	1	2019-05-23 15:05:58.579023+03	core	RefChapterCodes	19	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"19"}	Create data
1699	1	1	2019-05-23 15:05:58.929949+03	core	RefChapterCodes	21	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"21"}	Create data
1701	1	1	2019-05-23 15:05:59.247407+03	core	RefChapterCodes	23	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"23"}	Create data
1703	1	1	2019-05-23 15:05:59.588325+03	core	RefChapterCodes	25	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"25"}	Create data
1705	1	1	2019-05-23 15:05:59.916838+03	core	RefChapterCodes	27	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"27"}	Create data
1707	1	1	2019-05-23 15:06:00.231319+03	core	RefChapterCodes	29	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"29"}	Create data
1709	1	1	2019-05-23 15:06:00.723324+03	core	RefChapterCodes	31	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"31"}	Create data
1711	1	1	2019-05-23 15:06:01.206805+03	core	RefChapterCodes	33	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"33"}	Create data
1713	1	1	2019-05-23 15:06:01.533375+03	core	RefChapterCodes	35	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"35"}	Create data
1715	1	1	2019-05-23 15:06:01.933071+03	core	RefChapterCodes	37	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"37"}	Create data
1717	1	1	2019-05-23 15:06:02.246172+03	core	RefChapterCodes	39	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"39"}	Create data
1616	1	1	2019-05-23 15:05:41.012928+03	core	RefContractors	20	\N	{"srcName":"core.RefContractors.c","srcPK":"20"}	Create data
1618	1	1	2019-05-23 15:05:41.532431+03	core	RefContractors	22	\N	{"srcName":"core.RefContractors.c","srcPK":"22"}	Create data
1620	1	1	2019-05-23 15:05:41.908622+03	core	RefContractors	24	\N	{"srcName":"core.RefContractors.c","srcPK":"24"}	Create data
1622	1	1	2019-05-23 15:05:42.215392+03	core	RefContractors	26	\N	{"srcName":"core.RefContractors.c","srcPK":"26"}	Create data
1624	1	1	2019-05-23 15:05:42.508056+03	core	RefContractors	28	\N	{"srcName":"core.RefContractors.c","srcPK":"28"}	Create data
1626	1	1	2019-05-23 15:05:42.852407+03	core	RefContractors	30	\N	{"srcName":"core.RefContractors.c","srcPK":"30"}	Create data
1628	1	1	2019-05-23 15:05:43.342447+03	core	RefContractors	32	\N	{"srcName":"core.RefContractors.c","srcPK":"32"}	Create data
1630	1	1	2019-05-23 15:05:43.65125+03	core	RefContractors	34	\N	{"srcName":"core.RefContractors.c","srcPK":"34"}	Create data
1632	1	1	2019-05-23 15:05:44.041479+03	core	RefContractors	36	\N	{"srcName":"core.RefContractors.c","srcPK":"36"}	Create data
1634	1	1	2019-05-23 15:05:44.368609+03	core	RefContractors	38	\N	{"srcName":"core.RefContractors.c","srcPK":"38"}	Create data
1636	1	1	2019-05-23 15:05:44.810946+03	core	RefContractors	40	\N	{"srcName":"core.RefContractors.c","srcPK":"40"}	Create data
1638	1	1	2019-05-23 15:05:45.17773+03	core	RefContractors	42	\N	{"srcName":"core.RefContractors.c","srcPK":"42"}	Create data
1640	1	1	2019-05-23 15:05:45.574532+03	core	RefContractors	44	\N	{"srcName":"core.RefContractors.c","srcPK":"44"}	Create data
1642	1	1	2019-05-23 15:05:45.880802+03	core	RefContractors	46	\N	{"srcName":"core.RefContractors.c","srcPK":"46"}	Create data
1644	1	1	2019-05-23 15:05:46.222209+03	core	RefContractors	48	\N	{"srcName":"core.RefContractors.c","srcPK":"48"}	Create data
1646	1	1	2019-05-23 15:05:46.662253+03	core	RefContractors	50	\N	{"srcName":"core.RefContractors.c","srcPK":"50"}	Create data
1648	1	1	2019-05-23 15:05:46.989191+03	core	RefContractors	52	\N	{"srcName":"core.RefContractors.c","srcPK":"52"}	Create data
1650	1	1	2019-05-23 15:05:47.340469+03	core	RefContractors	54	\N	{"srcName":"core.RefContractors.c","srcPK":"54"}	Create data
1652	1	1	2019-05-23 15:05:47.705901+03	core	RefContractors	56	\N	{"srcName":"core.RefContractors.c","srcPK":"56"}	Create data
1654	1	1	2019-05-23 15:05:47.999515+03	core	RefContractors	58	\N	{"srcName":"core.RefContractors.c","srcPK":"58"}	Create data
1656	1	1	2019-05-23 15:05:48.331406+03	core	RefContractors	60	\N	{"srcName":"core.RefContractors.c","srcPK":"60"}	Create data
1658	1	1	2019-05-23 15:05:48.657419+03	core	RefContractors	62	\N	{"srcName":"core.RefContractors.c","srcPK":"62"}	Create data
1660	1	1	2019-05-23 15:05:49.005289+03	core	RefContractors	64	\N	{"srcName":"core.RefContractors.c","srcPK":"64"}	Create data
1662	1	1	2019-05-23 15:05:49.325565+03	core	RefContractors	66	\N	{"srcName":"core.RefContractors.c","srcPK":"66"}	Create data
1664	1	1	2019-05-23 15:05:49.866018+03	core	RefContractors	68	\N	{"srcName":"core.RefContractors.c","srcPK":"68"}	Create data
1666	1	1	2019-05-23 15:05:50.299784+03	core	RefContractors	70	\N	{"srcName":"core.RefContractors.c","srcPK":"70"}	Create data
1668	1	1	2019-05-23 15:05:50.618631+03	core	RefContractors	72	\N	{"srcName":"core.RefContractors.c","srcPK":"72"}	Create data
1670	1	1	2019-05-23 15:05:50.945175+03	core	RefDocCodes	2	\N	{"srcName":"core.RefDocCodes.c","srcPK":"2"}	Create data
1672	1	1	2019-05-23 15:05:51.581118+03	core	RefDocCodes	4	\N	{"srcName":"core.RefDocCodes.c","srcPK":"4"}	Create data
1674	1	1	2019-05-23 15:05:52.888225+03	core	RefDocCodes	6	\N	{"srcName":"core.RefDocCodes.c","srcPK":"6"}	Create data
1676	1	1	2019-05-23 15:05:53.775265+03	core	RefDocCodes	8	\N	{"srcName":"core.RefDocCodes.c","srcPK":"8"}	Create data
1678	1	1	2019-05-23 15:05:54.757956+03	core	RefDocCodes	10	\N	{"srcName":"core.RefDocCodes.c","srcPK":"10"}	Create data
1680	1	1	2019-05-23 15:05:55.493119+03	core	RefChapterCodes	2	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"2"}	Create data
1682	1	1	2019-05-23 15:05:55.859387+03	core	RefChapterCodes	4	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"4"}	Create data
1684	1	1	2019-05-23 15:05:56.239408+03	core	RefChapterCodes	6	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"6"}	Create data
1686	1	1	2019-05-23 15:05:56.575101+03	core	RefChapterCodes	8	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"8"}	Create data
1688	1	1	2019-05-23 15:05:56.88958+03	core	RefChapterCodes	10	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"10"}	Create data
1690	1	1	2019-05-23 15:05:57.251313+03	core	RefChapterCodes	12	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"12"}	Create data
1692	1	1	2019-05-23 15:05:57.630347+03	core	RefChapterCodes	14	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"14"}	Create data
1694	1	1	2019-05-23 15:05:58.003459+03	core	RefChapterCodes	16	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"16"}	Create data
1696	1	1	2019-05-23 15:05:58.39639+03	core	RefChapterCodes	18	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"18"}	Create data
1698	1	1	2019-05-23 15:05:58.7794+03	core	RefChapterCodes	20	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"20"}	Create data
1700	1	1	2019-05-23 15:05:59.09704+03	core	RefChapterCodes	22	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"22"}	Create data
1702	1	1	2019-05-23 15:05:59.397072+03	core	RefChapterCodes	24	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"24"}	Create data
1704	1	1	2019-05-23 15:05:59.763813+03	core	RefChapterCodes	26	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"26"}	Create data
1706	1	1	2019-05-23 15:06:00.08905+03	core	RefChapterCodes	28	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"28"}	Create data
1708	1	1	2019-05-23 15:06:00.531223+03	core	RefChapterCodes	30	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"30"}	Create data
1710	1	1	2019-05-23 15:06:00.915687+03	core	RefChapterCodes	32	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"32"}	Create data
1712	1	1	2019-05-23 15:06:01.35715+03	core	RefChapterCodes	34	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"34"}	Create data
1714	1	1	2019-05-23 15:06:01.749962+03	core	RefChapterCodes	36	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"36"}	Create data
1716	1	1	2019-05-23 15:06:02.098882+03	core	RefChapterCodes	38	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"38"}	Create data
1718	1	1	2019-05-23 15:06:02.468084+03	core	RefChapterCodes	40	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"40"}	Create data
1719	1	1	2019-05-23 15:06:02.65008+03	core	RefChapterCodes	41	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"41"}	Create data
1721	1	1	2019-05-23 15:06:03.042322+03	core	RefChapterCodes	43	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"43"}	Create data
1723	1	1	2019-05-23 15:06:03.401417+03	core	RefChapterCodes	45	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"45"}	Create data
1725	1	1	2019-05-23 15:06:03.7352+03	core	RefChapterCodes	47	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"47"}	Create data
1727	1	1	2019-05-23 15:06:04.069014+03	core	RefChapterCodes	49	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"49"}	Create data
1729	1	1	2019-05-23 15:06:04.434686+03	core	RefChapterCodes	51	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"51"}	Create data
1731	1	1	2019-05-23 15:06:04.786748+03	core	RefChapterCodes	53	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"53"}	Create data
1733	1	1	2019-05-23 15:06:05.213637+03	core	RefPhases	1	\N	{"srcName":"core.RefPhases.c","srcPK":"1"}	Create data
1735	1	1	2019-05-23 15:06:06.993982+03	core	RefPhases	3	\N	{"srcName":"core.RefPhases.c","srcPK":"3"}	Create data
1720	1	1	2019-05-23 15:06:02.8858+03	core	RefChapterCodes	42	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"42"}	Create data
1722	1	1	2019-05-23 15:06:03.22748+03	core	RefChapterCodes	44	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"44"}	Create data
1724	1	1	2019-05-23 15:06:03.585122+03	core	RefChapterCodes	46	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"46"}	Create data
1726	1	1	2019-05-23 15:06:03.885455+03	core	RefChapterCodes	48	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"48"}	Create data
1728	1	1	2019-05-23 15:06:04.301093+03	core	RefChapterCodes	50	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"50"}	Create data
1730	1	1	2019-05-23 15:06:04.620763+03	core	RefChapterCodes	52	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"52"}	Create data
1732	1	1	2019-05-23 15:06:05.044433+03	core	RefChapterCodes	54	\N	{"srcName":"core.RefChapterCodes.c","srcPK":"54"}	Create data
1734	1	1	2019-05-23 15:06:05.754397+03	core	RefPhases	2	\N	{"srcName":"core.RefPhases.c","srcPK":"2"}	Create data
\.


--
-- Data for Name: ref_logeventtype; Type: TABLE DATA; Schema: sys; Owner: svcm
--

COPY ref_logeventtype (id, name, descr) FROM stdin;
1	c	Создание
2	r	Чтение
3	u	Изменение
4	d	Удаление
5	p	Генерация отчета
6	e	Запуск процедуры
7	a	Аутентификация пользователя
8	h	Проверка прав доступа
9	l	Создание связи для таблиц
\.


SET search_path = core, pg_catalog;

--
-- Name: cobject_id_seq; Type: SEQUENCE SET; Schema: core; Owner: svcm
--

SELECT pg_catalog.setval('cobject_id_seq', 1, false);


--
-- Name: cobject_type_id_seq; Type: SEQUENCE SET; Schema: core; Owner: svcm
--

SELECT pg_catalog.setval('cobject_type_id_seq', 5, true);


--
-- Name: construction_id_seq; Type: SEQUENCE SET; Schema: core; Owner: svcm
--

SELECT pg_catalog.setval('construction_id_seq', 1, false);


--
-- Name: contract_id_seq; Type: SEQUENCE SET; Schema: core; Owner: svcm
--

SELECT pg_catalog.setval('contract_id_seq', 1, false);


--
-- Name: docset_id_seq; Type: SEQUENCE SET; Schema: core; Owner: svcm
--

SELECT pg_catalog.setval('docset_id_seq', 1, false);


--
-- Name: docset_mon_id_seq; Type: SEQUENCE SET; Schema: core; Owner: svcm
--

SELECT pg_catalog.setval('docset_mon_id_seq', 1, false);


--
-- Name: ds_bsd_id_seq; Type: SEQUENCE SET; Schema: core; Owner: svcm
--

SELECT pg_catalog.setval('ds_bsd_id_seq', 1, false);


--
-- Name: ds_type_id_seq; Type: SEQUENCE SET; Schema: core; Owner: svcm
--

SELECT pg_catalog.setval('ds_type_id_seq', 2, true);


--
-- Name: ref_building_group_id_seq; Type: SEQUENCE SET; Schema: core; Owner: svcm
--

SELECT pg_catalog.setval('ref_building_group_id_seq', 63, true);


--
-- Name: ref_building_id_seq; Type: SEQUENCE SET; Schema: core; Owner: svcm
--

SELECT pg_catalog.setval('ref_building_id_seq', 842, true);


--
-- Name: ref_chaptercode_id_seq; Type: SEQUENCE SET; Schema: core; Owner: svcm
--

SELECT pg_catalog.setval('ref_chaptercode_id_seq', 54, true);


--
-- Name: ref_chaptercode_type_id_seq; Type: SEQUENCE SET; Schema: core; Owner: svcm
--

SELECT pg_catalog.setval('ref_chaptercode_type_id_seq', 1, false);


--
-- Name: ref_constrpart_group_id_seq; Type: SEQUENCE SET; Schema: core; Owner: svcm
--

SELECT pg_catalog.setval('ref_constrpart_group_id_seq', 11, true);


--
-- Name: ref_constrpart_id_seq; Type: SEQUENCE SET; Schema: core; Owner: svcm
--

SELECT pg_catalog.setval('ref_constrpart_id_seq', 374, true);


--
-- Name: ref_contractor_id_seq; Type: SEQUENCE SET; Schema: core; Owner: svcm
--

SELECT pg_catalog.setval('ref_contractor_id_seq', 72, true);


--
-- Name: ref_developer_id_seq; Type: SEQUENCE SET; Schema: core; Owner: svcm
--

SELECT pg_catalog.setval('ref_developer_id_seq', 12, true);


--
-- Name: ref_doccode_id_seq; Type: SEQUENCE SET; Schema: core; Owner: svcm
--

SELECT pg_catalog.setval('ref_doccode_id_seq', 10, true);


--
-- Name: ref_mark_id_seq; Type: SEQUENCE SET; Schema: core; Owner: svcm
--

SELECT pg_catalog.setval('ref_mark_id_seq', 294, true);


--
-- Name: ref_phase_id_seq; Type: SEQUENCE SET; Schema: core; Owner: svcm
--

SELECT pg_catalog.setval('ref_phase_id_seq', 3, true);


--
-- Name: waybill_id_seq; Type: SEQUENCE SET; Schema: core; Owner: svcm
--

SELECT pg_catalog.setval('waybill_id_seq', 1, false);


--
-- Name: waybill_link_id_seq; Type: SEQUENCE SET; Schema: core; Owner: svcm
--

SELECT pg_catalog.setval('waybill_link_id_seq', 1, false);


SET search_path = public, pg_catalog;

--
-- Name: cost_assign_id_seq; Type: SEQUENCE SET; Schema: public; Owner: svcm
--

SELECT pg_catalog.setval('cost_assign_id_seq', 2, true);


--
-- Name: cost_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: svcm
--

SELECT pg_catalog.setval('cost_group_id_seq', 9, true);


--
-- Name: cost_kind_id_seq; Type: SEQUENCE SET; Schema: public; Owner: svcm
--

SELECT pg_catalog.setval('cost_kind_id_seq', 126, true);


--
-- Name: estimate_fission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: svcm
--

SELECT pg_catalog.setval('estimate_fission_id_seq', 1, false);


--
-- Name: estimate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: svcm
--

SELECT pg_catalog.setval('estimate_id_seq', 1, false);


--
-- Name: estimate_link_id_seq; Type: SEQUENCE SET; Schema: public; Owner: svcm
--

SELECT pg_catalog.setval('estimate_link_id_seq', 1, false);


--
-- Name: estimate_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: svcm
--

SELECT pg_catalog.setval('estimate_type_id_seq', 4, true);


--
-- Name: iusi_plan_form_id_seq; Type: SEQUENCE SET; Schema: public; Owner: svcm
--

SELECT pg_catalog.setval('iusi_plan_form_id_seq', 12, true);


--
-- Name: mrd_object_id_seq; Type: SEQUENCE SET; Schema: public; Owner: svcm
--

SELECT pg_catalog.setval('mrd_object_id_seq', 1, false);


--
-- Name: mrd_object_link_id_seq; Type: SEQUENCE SET; Schema: public; Owner: svcm
--

SELECT pg_catalog.setval('mrd_object_link_id_seq', 1, false);


--
-- Name: mrd_oksgroup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: svcm
--

SELECT pg_catalog.setval('mrd_oksgroup_id_seq', 6, true);


--
-- Name: mrd_oksref_id_seq; Type: SEQUENCE SET; Schema: public; Owner: svcm
--

SELECT pg_catalog.setval('mrd_oksref_id_seq', 10, true);


--
-- Name: mrd_ossrgroup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: svcm
--

SELECT pg_catalog.setval('mrd_ossrgroup_id_seq', 9, true);


--
-- Name: mrd_ossrref_id_seq; Type: SEQUENCE SET; Schema: public; Owner: svcm
--

SELECT pg_catalog.setval('mrd_ossrref_id_seq', 88, true);


--
-- Name: ssr_chapter_id_seq; Type: SEQUENCE SET; Schema: public; Owner: svcm
--

SELECT pg_catalog.setval('ssr_chapter_id_seq', 11, true);


SET search_path = stream, pg_catalog;

--
-- Name: building_id_seq; Type: SEQUENCE SET; Schema: stream; Owner: svcm
--

SELECT pg_catalog.setval('building_id_seq', 1, false);


--
-- Name: constrpart_id_seq; Type: SEQUENCE SET; Schema: stream; Owner: svcm
--

SELECT pg_catalog.setval('constrpart_id_seq', 1, false);


--
-- Name: construction_id_seq; Type: SEQUENCE SET; Schema: stream; Owner: svcm
--

SELECT pg_catalog.setval('construction_id_seq', 1, false);


--
-- Name: contract_id_seq; Type: SEQUENCE SET; Schema: stream; Owner: svcm
--

SELECT pg_catalog.setval('contract_id_seq', 1, false);


--
-- Name: contract_stage_id_seq; Type: SEQUENCE SET; Schema: stream; Owner: svcm
--

SELECT pg_catalog.setval('contract_stage_id_seq', 1, false);


--
-- Name: docset_id_seq; Type: SEQUENCE SET; Schema: stream; Owner: svcm
--

SELECT pg_catalog.setval('docset_id_seq', 1, false);


SET search_path = sys, pg_catalog;

--
-- Name: acl_account_id_seq; Type: SEQUENCE SET; Schema: sys; Owner: svcm
--

SELECT pg_catalog.setval('acl_account_id_seq', 1, true);


--
-- Name: acl_account_role_id_seq; Type: SEQUENCE SET; Schema: sys; Owner: svcm
--

SELECT pg_catalog.setval('acl_account_role_id_seq', 1, true);


--
-- Name: acl_function_id_seq; Type: SEQUENCE SET; Schema: sys; Owner: svcm
--

SELECT pg_catalog.setval('acl_function_id_seq', 130, true);


--
-- Name: acl_group_id_seq; Type: SEQUENCE SET; Schema: sys; Owner: svcm
--

SELECT pg_catalog.setval('acl_group_id_seq', 1, false);


--
-- Name: acl_role_function_id_seq; Type: SEQUENCE SET; Schema: sys; Owner: svcm
--

SELECT pg_catalog.setval('acl_role_function_id_seq', 150, true);


--
-- Name: acl_role_id_seq; Type: SEQUENCE SET; Schema: sys; Owner: svcm
--

SELECT pg_catalog.setval('acl_role_id_seq', 2, true);


--
-- Name: logevent_id_seq; Type: SEQUENCE SET; Schema: sys; Owner: svcm
--

SELECT pg_catalog.setval('logevent_id_seq', 1735, true);


--
-- Name: ref_logeventtype_id_seq; Type: SEQUENCE SET; Schema: sys; Owner: svcm
--

SELECT pg_catalog.setval('ref_logeventtype_id_seq', 9, true);


SET search_path = core, pg_catalog;

--
-- Name: cobject cobject_pkey; Type: CONSTRAINT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY cobject
    ADD CONSTRAINT cobject_pkey PRIMARY KEY (id);


--
-- Name: cobject_type cobject_type_pkey; Type: CONSTRAINT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY cobject_type
    ADD CONSTRAINT cobject_type_pkey PRIMARY KEY (id);


--
-- Name: construction construction_pkey; Type: CONSTRAINT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY construction
    ADD CONSTRAINT construction_pkey PRIMARY KEY (id);


--
-- Name: contract contract_pkey; Type: CONSTRAINT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY contract
    ADD CONSTRAINT contract_pkey PRIMARY KEY (id);


--
-- Name: docset_mon docset_mon_pkey; Type: CONSTRAINT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY docset_mon
    ADD CONSTRAINT docset_mon_pkey PRIMARY KEY (id);


--
-- Name: docset docset_pkey; Type: CONSTRAINT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY docset
    ADD CONSTRAINT docset_pkey PRIMARY KEY (id);


--
-- Name: ds_bsd ds_bsd_pkey; Type: CONSTRAINT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY ds_bsd
    ADD CONSTRAINT ds_bsd_pkey PRIMARY KEY (id);


--
-- Name: ds_type ds_type_name_key; Type: CONSTRAINT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY ds_type
    ADD CONSTRAINT ds_type_name_key UNIQUE (name);


--
-- Name: ds_type ds_type_pkey; Type: CONSTRAINT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY ds_type
    ADD CONSTRAINT ds_type_pkey PRIMARY KEY (id);


--
-- Name: ref_building_group ref_building_group_pkey; Type: CONSTRAINT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY ref_building_group
    ADD CONSTRAINT ref_building_group_pkey PRIMARY KEY (id);


--
-- Name: ref_building ref_building_pkey; Type: CONSTRAINT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY ref_building
    ADD CONSTRAINT ref_building_pkey PRIMARY KEY (id);


--
-- Name: ref_chaptercode ref_chaptercode_pkey; Type: CONSTRAINT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY ref_chaptercode
    ADD CONSTRAINT ref_chaptercode_pkey PRIMARY KEY (id);


--
-- Name: ref_chaptercode_type ref_chaptercode_type_pkey; Type: CONSTRAINT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY ref_chaptercode_type
    ADD CONSTRAINT ref_chaptercode_type_pkey PRIMARY KEY (id);


--
-- Name: ref_constrpart_group ref_constrpart_group_pkey; Type: CONSTRAINT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY ref_constrpart_group
    ADD CONSTRAINT ref_constrpart_group_pkey PRIMARY KEY (id);


--
-- Name: ref_constrpart ref_constrpart_pkey; Type: CONSTRAINT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY ref_constrpart
    ADD CONSTRAINT ref_constrpart_pkey PRIMARY KEY (id);


--
-- Name: ref_contractor ref_contractor_pkey; Type: CONSTRAINT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY ref_contractor
    ADD CONSTRAINT ref_contractor_pkey PRIMARY KEY (id);


--
-- Name: ref_developer ref_developer_pkey; Type: CONSTRAINT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY ref_developer
    ADD CONSTRAINT ref_developer_pkey PRIMARY KEY (id);


--
-- Name: ref_doccode ref_doccode_pkey; Type: CONSTRAINT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY ref_doccode
    ADD CONSTRAINT ref_doccode_pkey PRIMARY KEY (id);


--
-- Name: ref_mark ref_mark_pkey; Type: CONSTRAINT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY ref_mark
    ADD CONSTRAINT ref_mark_pkey PRIMARY KEY (id);


--
-- Name: ref_phase ref_phase_pkey; Type: CONSTRAINT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY ref_phase
    ADD CONSTRAINT ref_phase_pkey PRIMARY KEY (id);


--
-- Name: waybill_link waybill_link_pkey; Type: CONSTRAINT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY waybill_link
    ADD CONSTRAINT waybill_link_pkey PRIMARY KEY (id);


--
-- Name: waybill waybill_pkey; Type: CONSTRAINT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY waybill
    ADD CONSTRAINT waybill_pkey PRIMARY KEY (id);


SET search_path = public, pg_catalog;

--
-- Name: cost_assign cost_assign_pkey; Type: CONSTRAINT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY cost_assign
    ADD CONSTRAINT cost_assign_pkey PRIMARY KEY (id);


--
-- Name: cost_group cost_group_pkey; Type: CONSTRAINT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY cost_group
    ADD CONSTRAINT cost_group_pkey PRIMARY KEY (id);


--
-- Name: cost_kind cost_kind_pkey; Type: CONSTRAINT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY cost_kind
    ADD CONSTRAINT cost_kind_pkey PRIMARY KEY (id);


--
-- Name: estimate_fission estimate_fission_pkey; Type: CONSTRAINT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY estimate_fission
    ADD CONSTRAINT estimate_fission_pkey PRIMARY KEY (id);


--
-- Name: estimate_link estimate_link_pkey; Type: CONSTRAINT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY estimate_link
    ADD CONSTRAINT estimate_link_pkey PRIMARY KEY (id);


--
-- Name: estimate estimate_pkey; Type: CONSTRAINT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY estimate
    ADD CONSTRAINT estimate_pkey PRIMARY KEY (id);


--
-- Name: estimate_type estimate_type_pkey; Type: CONSTRAINT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY estimate_type
    ADD CONSTRAINT estimate_type_pkey PRIMARY KEY (id);


--
-- Name: iusi_plan_form iusi_plan_form_pkey; Type: CONSTRAINT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY iusi_plan_form
    ADD CONSTRAINT iusi_plan_form_pkey PRIMARY KEY (id);


--
-- Name: mrd_object_link mrd_object_link_pkey; Type: CONSTRAINT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY mrd_object_link
    ADD CONSTRAINT mrd_object_link_pkey PRIMARY KEY (id);


--
-- Name: mrd_object mrd_object_pkey; Type: CONSTRAINT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY mrd_object
    ADD CONSTRAINT mrd_object_pkey PRIMARY KEY (id);


--
-- Name: mrd_objecttype mrd_objecttype_pkey; Type: CONSTRAINT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY mrd_objecttype
    ADD CONSTRAINT mrd_objecttype_pkey PRIMARY KEY (id);


--
-- Name: mrd_oksgroup mrd_oksgroup_pkey; Type: CONSTRAINT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY mrd_oksgroup
    ADD CONSTRAINT mrd_oksgroup_pkey PRIMARY KEY (id);


--
-- Name: mrd_oksref mrd_oksref_pkey; Type: CONSTRAINT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY mrd_oksref
    ADD CONSTRAINT mrd_oksref_pkey PRIMARY KEY (id);


--
-- Name: mrd_ossrgroup mrd_ossrgroup_pkey; Type: CONSTRAINT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY mrd_ossrgroup
    ADD CONSTRAINT mrd_ossrgroup_pkey PRIMARY KEY (id);


--
-- Name: mrd_ossrref mrd_ossrref_pkey; Type: CONSTRAINT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY mrd_ossrref
    ADD CONSTRAINT mrd_ossrref_pkey PRIMARY KEY (id);


--
-- Name: ssr_chapter ssr_chapter_pkey; Type: CONSTRAINT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY ssr_chapter
    ADD CONSTRAINT ssr_chapter_pkey PRIMARY KEY (id);


SET search_path = stream, pg_catalog;

--
-- Name: building building_pkey; Type: CONSTRAINT; Schema: stream; Owner: svcm
--

ALTER TABLE ONLY building
    ADD CONSTRAINT building_pkey PRIMARY KEY (id);


--
-- Name: constrpart constrpart_pkey; Type: CONSTRAINT; Schema: stream; Owner: svcm
--

ALTER TABLE ONLY constrpart
    ADD CONSTRAINT constrpart_pkey PRIMARY KEY (id);


--
-- Name: construction construction_pkey; Type: CONSTRAINT; Schema: stream; Owner: svcm
--

ALTER TABLE ONLY construction
    ADD CONSTRAINT construction_pkey PRIMARY KEY (id);


--
-- Name: contract contract_pkey; Type: CONSTRAINT; Schema: stream; Owner: svcm
--

ALTER TABLE ONLY contract
    ADD CONSTRAINT contract_pkey PRIMARY KEY (id);


--
-- Name: contract_stage contract_stage_pkey; Type: CONSTRAINT; Schema: stream; Owner: svcm
--

ALTER TABLE ONLY contract_stage
    ADD CONSTRAINT contract_stage_pkey PRIMARY KEY (id);


--
-- Name: docset docset_pkey; Type: CONSTRAINT; Schema: stream; Owner: svcm
--

ALTER TABLE ONLY docset
    ADD CONSTRAINT docset_pkey PRIMARY KEY (id);


SET search_path = sys, pg_catalog;

--
-- Name: acl_account acl_account_email_key; Type: CONSTRAINT; Schema: sys; Owner: svcm
--

ALTER TABLE ONLY acl_account
    ADD CONSTRAINT acl_account_email_key UNIQUE (email);


--
-- Name: acl_account acl_account_login_key; Type: CONSTRAINT; Schema: sys; Owner: svcm
--

ALTER TABLE ONLY acl_account
    ADD CONSTRAINT acl_account_login_key UNIQUE (login);


--
-- Name: acl_account acl_account_pkey; Type: CONSTRAINT; Schema: sys; Owner: svcm
--

ALTER TABLE ONLY acl_account
    ADD CONSTRAINT acl_account_pkey PRIMARY KEY (id);


--
-- Name: acl_account_role acl_account_role_ar_key; Type: CONSTRAINT; Schema: sys; Owner: svcm
--

ALTER TABLE ONLY acl_account_role
    ADD CONSTRAINT acl_account_role_ar_key UNIQUE (account_id, role_id);


--
-- Name: acl_account_role acl_account_role_pkey; Type: CONSTRAINT; Schema: sys; Owner: svcm
--

ALTER TABLE ONLY acl_account_role
    ADD CONSTRAINT acl_account_role_pkey PRIMARY KEY (id);


--
-- Name: acl_function acl_function_name_key; Type: CONSTRAINT; Schema: sys; Owner: svcm
--

ALTER TABLE ONLY acl_function
    ADD CONSTRAINT acl_function_name_key UNIQUE (name);


--
-- Name: acl_function acl_function_pkey; Type: CONSTRAINT; Schema: sys; Owner: svcm
--

ALTER TABLE ONLY acl_function
    ADD CONSTRAINT acl_function_pkey PRIMARY KEY (id);


--
-- Name: acl_group acl_group_pkey; Type: CONSTRAINT; Schema: sys; Owner: svcm
--

ALTER TABLE ONLY acl_group
    ADD CONSTRAINT acl_group_pkey PRIMARY KEY (id);


--
-- Name: acl_role_function acl_role_function_pkey; Type: CONSTRAINT; Schema: sys; Owner: svcm
--

ALTER TABLE ONLY acl_role_function
    ADD CONSTRAINT acl_role_function_pkey PRIMARY KEY (id);


--
-- Name: acl_role_function acl_role_function_rf_key; Type: CONSTRAINT; Schema: sys; Owner: svcm
--

ALTER TABLE ONLY acl_role_function
    ADD CONSTRAINT acl_role_function_rf_key UNIQUE (role_id, function_id);


--
-- Name: acl_role acl_role_pkey; Type: CONSTRAINT; Schema: sys; Owner: svcm
--

ALTER TABLE ONLY acl_role
    ADD CONSTRAINT acl_role_pkey PRIMARY KEY (id);


--
-- Name: logevent logevent_pkey; Type: CONSTRAINT; Schema: sys; Owner: svcm
--

ALTER TABLE ONLY logevent
    ADD CONSTRAINT logevent_pkey PRIMARY KEY (id);


--
-- Name: ref_logeventtype ref_logeventtype_name_key; Type: CONSTRAINT; Schema: sys; Owner: svcm
--

ALTER TABLE ONLY ref_logeventtype
    ADD CONSTRAINT ref_logeventtype_name_key UNIQUE (name);


--
-- Name: ref_logeventtype ref_logeventtype_pkey; Type: CONSTRAINT; Schema: sys; Owner: svcm
--

ALTER TABLE ONLY ref_logeventtype
    ADD CONSTRAINT ref_logeventtype_pkey PRIMARY KEY (id);


SET search_path = core, pg_catalog;

--
-- Name: docset_mon_idx; Type: INDEX; Schema: core; Owner: svcm
--

CREATE INDEX docset_mon_idx ON docset_mon USING btree (docset_id, mondate, created DESC);


--
-- Name: cobject cobject_cobject_type_id_fkey; Type: FK CONSTRAINT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY cobject
    ADD CONSTRAINT cobject_cobject_type_id_fkey FOREIGN KEY (cobject_type_id) REFERENCES cobject_type(id);


--
-- Name: cobject cobject_construction_id_fkey; Type: FK CONSTRAINT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY cobject
    ADD CONSTRAINT cobject_construction_id_fkey FOREIGN KEY (construction_id) REFERENCES construction(id);


--
-- Name: cobject cobject_parent_id_fkey; Type: FK CONSTRAINT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY cobject
    ADD CONSTRAINT cobject_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES cobject(id);


--
-- Name: contract contract_construction_id_fkey; Type: FK CONSTRAINT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY contract
    ADD CONSTRAINT contract_construction_id_fkey FOREIGN KEY (construction_id) REFERENCES construction(id);


--
-- Name: contract contract_contractor_id_fkey; Type: FK CONSTRAINT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY contract
    ADD CONSTRAINT contract_contractor_id_fkey FOREIGN KEY (contractor_id) REFERENCES ref_contractor(id);


--
-- Name: contract contract_developer_id_fkey; Type: FK CONSTRAINT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY contract
    ADD CONSTRAINT contract_developer_id_fkey FOREIGN KEY (developer_id) REFERENCES ref_developer(id);


--
-- Name: contract contract_phase_id_fkey; Type: FK CONSTRAINT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY contract
    ADD CONSTRAINT contract_phase_id_fkey FOREIGN KEY (phase_id) REFERENCES ref_phase(id);


--
-- Name: docset docset_cobject_id_fkey; Type: FK CONSTRAINT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY docset
    ADD CONSTRAINT docset_cobject_id_fkey FOREIGN KEY (cobject_id) REFERENCES cobject(id);


--
-- Name: docset docset_ds_type_id_fkey; Type: FK CONSTRAINT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY docset
    ADD CONSTRAINT docset_ds_type_id_fkey FOREIGN KEY (ds_type_id) REFERENCES ds_type(id);


--
-- Name: docset docset_mark_ref_id_fkey; Type: FK CONSTRAINT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY docset
    ADD CONSTRAINT docset_mark_ref_id_fkey FOREIGN KEY (mark_ref_id) REFERENCES ref_mark(id);


--
-- Name: docset_mon docset_mon_docset_id_fkey; Type: FK CONSTRAINT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY docset_mon
    ADD CONSTRAINT docset_mon_docset_id_fkey FOREIGN KEY (docset_id) REFERENCES docset(id);


--
-- Name: ds_bsd ds_bsd_building_id_fkey; Type: FK CONSTRAINT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY ds_bsd
    ADD CONSTRAINT ds_bsd_building_id_fkey FOREIGN KEY (building_id) REFERENCES ref_building(id);


--
-- Name: ds_bsd ds_bsd_constrpart_id_fkey; Type: FK CONSTRAINT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY ds_bsd
    ADD CONSTRAINT ds_bsd_constrpart_id_fkey FOREIGN KEY (constrpart_id) REFERENCES ref_constrpart(id);


--
-- Name: ds_bsd ds_bsd_contract_id_fkey; Type: FK CONSTRAINT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY ds_bsd
    ADD CONSTRAINT ds_bsd_contract_id_fkey FOREIGN KEY (contract_id) REFERENCES contract(id);


--
-- Name: ds_bsd ds_bsd_contractor_id_fkey; Type: FK CONSTRAINT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY ds_bsd
    ADD CONSTRAINT ds_bsd_contractor_id_fkey FOREIGN KEY (contractor_id) REFERENCES ref_contractor(id);


--
-- Name: ds_bsd ds_bsd_developer_id_fkey; Type: FK CONSTRAINT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY ds_bsd
    ADD CONSTRAINT ds_bsd_developer_id_fkey FOREIGN KEY (developer_id) REFERENCES ref_developer(id);


--
-- Name: ds_bsd ds_bsd_docset_id_fkey; Type: FK CONSTRAINT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY ds_bsd
    ADD CONSTRAINT ds_bsd_docset_id_fkey FOREIGN KEY (docset_id) REFERENCES docset(id);


--
-- Name: ds_bsd ds_bsd_mark_id_fkey; Type: FK CONSTRAINT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY ds_bsd
    ADD CONSTRAINT ds_bsd_mark_id_fkey FOREIGN KEY (mark_id) REFERENCES ref_mark(id);


--
-- Name: ds_bsd ds_bsd_oipks_id_fkey; Type: FK CONSTRAINT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY ds_bsd
    ADD CONSTRAINT ds_bsd_oipks_id_fkey FOREIGN KEY (oipks_id) REFERENCES construction(id);


--
-- Name: ds_bsd ds_bsd_phase_id_fkey; Type: FK CONSTRAINT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY ds_bsd
    ADD CONSTRAINT ds_bsd_phase_id_fkey FOREIGN KEY (phase_id) REFERENCES ref_phase(id);


--
-- Name: ref_building ref_building_group_id_fkey; Type: FK CONSTRAINT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY ref_building
    ADD CONSTRAINT ref_building_group_id_fkey FOREIGN KEY (group_id) REFERENCES ref_building_group(id);


--
-- Name: ref_chaptercode ref_chaptercode_chaptercodetype_id_fkey; Type: FK CONSTRAINT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY ref_chaptercode
    ADD CONSTRAINT ref_chaptercode_chaptercodetype_id_fkey FOREIGN KEY (chaptercodetype_id) REFERENCES ref_chaptercode_type(id);


--
-- Name: ref_constrpart ref_constrpart_group_id_fkey; Type: FK CONSTRAINT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY ref_constrpart
    ADD CONSTRAINT ref_constrpart_group_id_fkey FOREIGN KEY (group_id) REFERENCES ref_constrpart_group(id);


--
-- Name: waybill_link waybill_link_docset_id_fkey; Type: FK CONSTRAINT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY waybill_link
    ADD CONSTRAINT waybill_link_docset_id_fkey FOREIGN KEY (docset_id) REFERENCES docset(id);


--
-- Name: waybill_link waybill_link_waybill_id_fkey; Type: FK CONSTRAINT; Schema: core; Owner: svcm
--

ALTER TABLE ONLY waybill_link
    ADD CONSTRAINT waybill_link_waybill_id_fkey FOREIGN KEY (waybill_id) REFERENCES waybill(id);


SET search_path = public, pg_catalog;

--
-- Name: cost_group cost_group_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY cost_group
    ADD CONSTRAINT cost_group_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES cost_group(id);


--
-- Name: cost_kind cost_kind_cost_assign_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY cost_kind
    ADD CONSTRAINT cost_kind_cost_assign_id_fkey FOREIGN KEY (cost_assign_id) REFERENCES cost_assign(id);


--
-- Name: cost_kind cost_kind_cost_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY cost_kind
    ADD CONSTRAINT cost_kind_cost_group_id_fkey FOREIGN KEY (cost_group_id) REFERENCES cost_group(id);


--
-- Name: cost_kind cost_kind_iusi_plan_form_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY cost_kind
    ADD CONSTRAINT cost_kind_iusi_plan_form_id_fkey FOREIGN KEY (iusi_plan_form_id) REFERENCES iusi_plan_form(id);


--
-- Name: estimate estimate_cobject_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY estimate
    ADD CONSTRAINT estimate_cobject_id_fkey FOREIGN KEY (cobject_id) REFERENCES core.cobject(id);


--
-- Name: estimate estimate_contract_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY estimate
    ADD CONSTRAINT estimate_contract_id_fkey FOREIGN KEY (contract_id) REFERENCES core.contract(id);


--
-- Name: estimate estimate_cost_code_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY estimate
    ADD CONSTRAINT estimate_cost_code_id_fkey FOREIGN KEY (cost_code_id) REFERENCES cost_kind(id);


--
-- Name: estimate estimate_developer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY estimate
    ADD CONSTRAINT estimate_developer_id_fkey FOREIGN KEY (developer_id) REFERENCES core.ref_developer(id);


--
-- Name: estimate_fission estimate_fission_cost_code_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY estimate_fission
    ADD CONSTRAINT estimate_fission_cost_code_id_fkey FOREIGN KEY (cost_code_id) REFERENCES cost_kind(id);


--
-- Name: estimate_fission estimate_fission_estimate_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY estimate_fission
    ADD CONSTRAINT estimate_fission_estimate_id_fkey FOREIGN KEY (estimate_id) REFERENCES estimate(id);


--
-- Name: estimate_link estimate_link_estimate_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY estimate_link
    ADD CONSTRAINT estimate_link_estimate_id_fkey FOREIGN KEY (estimate_id) REFERENCES estimate(id);


--
-- Name: estimate estimate_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY estimate
    ADD CONSTRAINT estimate_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES estimate(id);


--
-- Name: estimate estimate_phase_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY estimate
    ADD CONSTRAINT estimate_phase_id_fkey FOREIGN KEY (phase_id) REFERENCES core.ref_phase(id);


--
-- Name: estimate estimate_phase_id_num_fkey; Type: FK CONSTRAINT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY estimate
    ADD CONSTRAINT estimate_phase_id_num_fkey FOREIGN KEY (phase_id_num) REFERENCES core.ref_phase(id);


--
-- Name: estimate estimate_replaces_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY estimate
    ADD CONSTRAINT estimate_replaces_id_fkey FOREIGN KEY (replaces_id) REFERENCES estimate(id);


--
-- Name: estimate estimate_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY estimate
    ADD CONSTRAINT estimate_type_id_fkey FOREIGN KEY (type_id) REFERENCES estimate_type(id);


--
-- Name: mrd_object mrd_object_construction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY mrd_object
    ADD CONSTRAINT mrd_object_construction_id_fkey FOREIGN KEY (construction_id) REFERENCES core.construction(id);


--
-- Name: mrd_object_link mrd_object_link_cobject_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY mrd_object_link
    ADD CONSTRAINT mrd_object_link_cobject_id_fkey FOREIGN KEY (cobject_id) REFERENCES core.cobject(id);


--
-- Name: mrd_object_link mrd_object_link_mrd_object_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY mrd_object_link
    ADD CONSTRAINT mrd_object_link_mrd_object_id_fkey FOREIGN KEY (mrd_object_id) REFERENCES mrd_object(id);


--
-- Name: mrd_object mrd_object_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY mrd_object
    ADD CONSTRAINT mrd_object_type_fkey FOREIGN KEY (type) REFERENCES mrd_objecttype(id);


--
-- Name: mrd_oksref mrd_oksref_oksgroup_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY mrd_oksref
    ADD CONSTRAINT mrd_oksref_oksgroup_id_fkey FOREIGN KEY (oksgroup_id) REFERENCES mrd_oksgroup(id);


--
-- Name: mrd_ossrref mrd_ossrref_ossrgroup_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: svcm
--

ALTER TABLE ONLY mrd_ossrref
    ADD CONSTRAINT mrd_ossrref_ossrgroup_id_fkey FOREIGN KEY (ossrgroup_id) REFERENCES mrd_ossrgroup(id);


SET search_path = sys, pg_catalog;

--
-- Name: acl_account_role acl_account_role_account_id_fkey; Type: FK CONSTRAINT; Schema: sys; Owner: svcm
--

ALTER TABLE ONLY acl_account_role
    ADD CONSTRAINT acl_account_role_account_id_fkey FOREIGN KEY (account_id) REFERENCES acl_account(id);


--
-- Name: acl_account_role acl_account_role_role_id_fkey; Type: FK CONSTRAINT; Schema: sys; Owner: svcm
--

ALTER TABLE ONLY acl_account_role
    ADD CONSTRAINT acl_account_role_role_id_fkey FOREIGN KEY (role_id) REFERENCES acl_role(id);


--
-- Name: acl_role_function acl_role_function_function_id_fkey; Type: FK CONSTRAINT; Schema: sys; Owner: svcm
--

ALTER TABLE ONLY acl_role_function
    ADD CONSTRAINT acl_role_function_function_id_fkey FOREIGN KEY (function_id) REFERENCES acl_function(id);


--
-- Name: acl_role_function acl_role_function_role_id_fkey; Type: FK CONSTRAINT; Schema: sys; Owner: svcm
--

ALTER TABLE ONLY acl_role_function
    ADD CONSTRAINT acl_role_function_role_id_fkey FOREIGN KEY (role_id) REFERENCES acl_role(id);


--
-- Name: logevent logevent_account_id_fkey; Type: FK CONSTRAINT; Schema: sys; Owner: svcm
--

ALTER TABLE ONLY logevent
    ADD CONSTRAINT logevent_account_id_fkey FOREIGN KEY (account_id) REFERENCES acl_account(id);


--
-- Name: logevent logevent_eventtype_id_fkey; Type: FK CONSTRAINT; Schema: sys; Owner: svcm
--

ALTER TABLE ONLY logevent
    ADD CONSTRAINT logevent_eventtype_id_fkey FOREIGN KEY (eventtype_id) REFERENCES ref_logeventtype(id);


SET search_path = core, pg_catalog;

--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: core; Owner: svcm
--

ALTER DEFAULT PRIVILEGES FOR ROLE svcm IN SCHEMA core REVOKE ALL ON SEQUENCES  FROM svcm;
ALTER DEFAULT PRIVILEGES FOR ROLE svcm IN SCHEMA core GRANT SELECT,USAGE ON SEQUENCES  TO svcm;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: core; Owner: svcm
--

ALTER DEFAULT PRIVILEGES FOR ROLE svcm IN SCHEMA core REVOKE ALL ON TABLES  FROM svcm;
ALTER DEFAULT PRIVILEGES FOR ROLE svcm IN SCHEMA core GRANT SELECT,INSERT,DELETE,UPDATE ON TABLES  TO svcm;


SET search_path = public, pg_catalog;

--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: svcm
--

ALTER DEFAULT PRIVILEGES FOR ROLE svcm IN SCHEMA public REVOKE ALL ON SEQUENCES  FROM svcm;
ALTER DEFAULT PRIVILEGES FOR ROLE svcm IN SCHEMA public GRANT SELECT,USAGE ON SEQUENCES  TO svcm;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: svcm
--

ALTER DEFAULT PRIVILEGES FOR ROLE svcm IN SCHEMA public REVOKE ALL ON TABLES  FROM svcm;
ALTER DEFAULT PRIVILEGES FOR ROLE svcm IN SCHEMA public GRANT SELECT,INSERT,DELETE,UPDATE ON TABLES  TO svcm;


SET search_path = stream, pg_catalog;

--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: stream; Owner: svcm
--

ALTER DEFAULT PRIVILEGES FOR ROLE svcm IN SCHEMA stream REVOKE ALL ON SEQUENCES  FROM svcm;
ALTER DEFAULT PRIVILEGES FOR ROLE svcm IN SCHEMA stream GRANT SELECT,USAGE ON SEQUENCES  TO svcm;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: stream; Owner: svcm
--

ALTER DEFAULT PRIVILEGES FOR ROLE svcm IN SCHEMA stream REVOKE ALL ON TABLES  FROM svcm;
ALTER DEFAULT PRIVILEGES FOR ROLE svcm IN SCHEMA stream GRANT SELECT,INSERT,DELETE,UPDATE ON TABLES  TO svcm;


SET search_path = sys, pg_catalog;

--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: sys; Owner: svcm
--

ALTER DEFAULT PRIVILEGES FOR ROLE svcm IN SCHEMA sys REVOKE ALL ON SEQUENCES  FROM svcm;
ALTER DEFAULT PRIVILEGES FOR ROLE svcm IN SCHEMA sys GRANT SELECT,USAGE ON SEQUENCES  TO svcm;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: sys; Owner: svcm
--

ALTER DEFAULT PRIVILEGES FOR ROLE svcm IN SCHEMA sys REVOKE ALL ON TABLES  FROM svcm;
ALTER DEFAULT PRIVILEGES FOR ROLE svcm IN SCHEMA sys GRANT SELECT,INSERT,DELETE,UPDATE ON TABLES  TO svcm;


SET search_path = core, pg_catalog;

--
-- Name: summary_construction; Type: MATERIALIZED VIEW DATA; Schema: core; Owner: svcm
--

REFRESH MATERIALIZED VIEW summary_construction;


--
-- PostgreSQL database dump complete
--


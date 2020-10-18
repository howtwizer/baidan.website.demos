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
-- Name: artists_search_tsvector_update(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.artists_search_tsvector_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    new.search := setweight(to_tsvector('pg_catalog.simple', coalesce(new.display_name,'')), 'A') ||
                         setweight(to_tsvector('pg_catalog.simple', coalesce(new.nationality,'')), 'B');
    RETURN NEW;
END;
$$;


--
-- Name: artworks_search_tsvector_update(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.artworks_search_tsvector_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    new.search := to_tsvector('pg_catalog.simple', coalesce(new.title,'')) ||
                         to_tsvector('pg_catalog.simple', coalesce(new.accession_number,''));
    RETURN NEW;
END;
$$;


--
-- Name: classifications_search_tsvector_update(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.classifications_search_tsvector_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    new.search := to_tsvector('pg_catalog.simple', coalesce(new.title,''));
    RETURN NEW;
END;
$$;


--
-- Name: departments_search_tsvector_update(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.departments_search_tsvector_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    new.search := to_tsvector('pg_catalog.simple', coalesce(new.title,''));
    RETURN NEW;
END;
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: active_admin_comments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.active_admin_comments (
    id bigint NOT NULL,
    namespace character varying,
    body text,
    resource_type character varying,
    resource_id bigint,
    author_type character varying,
    author_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: active_admin_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.active_admin_comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: active_admin_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.active_admin_comments_id_seq OWNED BY public.active_admin_comments.id;


--
-- Name: admin_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_users (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: admin_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_users_id_seq OWNED BY public.admin_users.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: artists; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.artists (
    id bigint NOT NULL,
    display_name character varying,
    artist_bio text,
    nationality character varying,
    gender character varying,
    begin_date integer,
    end_date integer,
    wiki character varying,
    ulan character varying,
    constituent_id integer,
    search tsvector,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: artists_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.artists_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: artists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.artists_id_seq OWNED BY public.artists.id;


--
-- Name: artworks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.artworks (
    id bigint NOT NULL,
    constituent_id bigint,
    classification_id bigint,
    department_id bigint,
    title character varying,
    date character varying,
    medium character varying,
    dimensions character varying,
    credit_line character varying,
    accession_number character varying,
    date_acquired character varying,
    cataloged boolean,
    url character varying,
    thumbnail_url character varying,
    circumference double precision,
    depth double precision,
    diameter double precision,
    height double precision,
    length double precision,
    weight double precision,
    width double precision,
    seat_height double precision,
    duration integer,
    search tsvector,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: artworks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.artworks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: artworks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.artworks_id_seq OWNED BY public.artworks.id;


--
-- Name: classifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.classifications (
    id bigint NOT NULL,
    title character varying,
    search tsvector,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: classifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.classifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: classifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.classifications_id_seq OWNED BY public.classifications.id;


--
-- Name: departments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.departments (
    id bigint NOT NULL,
    title character varying,
    search tsvector,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: departments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.departments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: departments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.departments_id_seq OWNED BY public.departments.id;


--
-- Name: pg_search_documents; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pg_search_documents (
    id bigint NOT NULL,
    title character varying,
    search tsvector,
    searchable_type character varying,
    searchable_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: pg_search_documents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pg_search_documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pg_search_documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pg_search_documents_id_seq OWNED BY public.pg_search_documents.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: active_admin_comments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_admin_comments ALTER COLUMN id SET DEFAULT nextval('public.active_admin_comments_id_seq'::regclass);


--
-- Name: admin_users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_users ALTER COLUMN id SET DEFAULT nextval('public.admin_users_id_seq'::regclass);


--
-- Name: artists id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.artists ALTER COLUMN id SET DEFAULT nextval('public.artists_id_seq'::regclass);


--
-- Name: artworks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.artworks ALTER COLUMN id SET DEFAULT nextval('public.artworks_id_seq'::regclass);


--
-- Name: classifications id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.classifications ALTER COLUMN id SET DEFAULT nextval('public.classifications_id_seq'::regclass);


--
-- Name: departments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.departments ALTER COLUMN id SET DEFAULT nextval('public.departments_id_seq'::regclass);


--
-- Name: pg_search_documents id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pg_search_documents ALTER COLUMN id SET DEFAULT nextval('public.pg_search_documents_id_seq'::regclass);


--
-- Name: active_admin_comments active_admin_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_admin_comments
    ADD CONSTRAINT active_admin_comments_pkey PRIMARY KEY (id);


--
-- Name: admin_users admin_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: artists artists_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.artists
    ADD CONSTRAINT artists_pkey PRIMARY KEY (id);


--
-- Name: artworks artworks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.artworks
    ADD CONSTRAINT artworks_pkey PRIMARY KEY (id);


--
-- Name: classifications classifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.classifications
    ADD CONSTRAINT classifications_pkey PRIMARY KEY (id);


--
-- Name: departments departments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT departments_pkey PRIMARY KEY (id);


--
-- Name: pg_search_documents pg_search_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pg_search_documents
    ADD CONSTRAINT pg_search_documents_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: index_active_admin_comments_on_author_type_and_author_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_active_admin_comments_on_author_type_and_author_id ON public.active_admin_comments USING btree (author_type, author_id);


--
-- Name: index_active_admin_comments_on_namespace; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_active_admin_comments_on_namespace ON public.active_admin_comments USING btree (namespace);


--
-- Name: index_active_admin_comments_on_resource_type_and_resource_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_active_admin_comments_on_resource_type_and_resource_id ON public.active_admin_comments USING btree (resource_type, resource_id);


--
-- Name: index_admin_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_admin_users_on_email ON public.admin_users USING btree (email);


--
-- Name: index_admin_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_admin_users_on_reset_password_token ON public.admin_users USING btree (reset_password_token);


--
-- Name: index_artists_on_constituent_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_artists_on_constituent_id ON public.artists USING btree (constituent_id);


--
-- Name: index_artists_on_search; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_artists_on_search ON public.artists USING gin (search);


--
-- Name: index_artworks_on_classification_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_artworks_on_classification_id ON public.artworks USING btree (classification_id);


--
-- Name: index_artworks_on_constituent_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_artworks_on_constituent_id ON public.artworks USING btree (constituent_id);


--
-- Name: index_artworks_on_department_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_artworks_on_department_id ON public.artworks USING btree (department_id);


--
-- Name: index_artworks_on_search; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_artworks_on_search ON public.artworks USING gin (search);


--
-- Name: index_artworks_on_title; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_artworks_on_title ON public.artworks USING btree (title);


--
-- Name: index_classifications_on_search; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_classifications_on_search ON public.classifications USING gin (search);


--
-- Name: index_classifications_on_title; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_classifications_on_title ON public.classifications USING btree (title);


--
-- Name: index_departments_on_search; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_departments_on_search ON public.departments USING gin (search);


--
-- Name: index_departments_on_title; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_departments_on_title ON public.departments USING btree (title);


--
-- Name: index_pg_search_documents_on_search; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pg_search_documents_on_search ON public.pg_search_documents USING gin (search);


--
-- Name: index_pg_search_documents_on_searchable_type_and_searchable_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pg_search_documents_on_searchable_type_and_searchable_id ON public.pg_search_documents USING btree (searchable_type, searchable_id);


--
-- Name: artists artists_search_tsvector_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER artists_search_tsvector_update BEFORE INSERT OR UPDATE ON public.artists FOR EACH ROW EXECUTE FUNCTION public.artists_search_tsvector_update();


--
-- Name: artworks artworks_search_tsvector_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER artworks_search_tsvector_update BEFORE INSERT OR UPDATE ON public.artworks FOR EACH ROW EXECUTE FUNCTION public.artworks_search_tsvector_update();


--
-- Name: classifications classifications_search_tsvector_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER classifications_search_tsvector_update BEFORE INSERT OR UPDATE ON public.classifications FOR EACH ROW EXECUTE FUNCTION public.classifications_search_tsvector_update();


--
-- Name: departments departments_search_tsvector_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER departments_search_tsvector_update BEFORE INSERT OR UPDATE ON public.departments FOR EACH ROW EXECUTE FUNCTION public.departments_search_tsvector_update();


--
-- Name: artworks fk_rails_489a862e7f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.artworks
    ADD CONSTRAINT fk_rails_489a862e7f FOREIGN KEY (constituent_id) REFERENCES public.artists(constituent_id) ON DELETE CASCADE;


--
-- Name: artworks fk_rails_89e9875f75; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.artworks
    ADD CONSTRAINT fk_rails_89e9875f75 FOREIGN KEY (department_id) REFERENCES public.departments(id);


--
-- Name: artworks fk_rails_bc50208cd4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.artworks
    ADD CONSTRAINT fk_rails_bc50208cd4 FOREIGN KEY (classification_id) REFERENCES public.classifications(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20180924120555'),
('20180924130841'),
('20180924130842'),
('20180924130844'),
('20180924132345'),
('20180926074232'),
('20180926074323'),
('20180926074510'),
('20181016112044'),
('20181016112045');



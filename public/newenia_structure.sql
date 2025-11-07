--
-- PostgreSQL database dump
--

\restrict qsvkFHctfg9fNRul0hxubaEe8fO3IFKQQt5J0qYBJzjIccP0k3oNKIUvh2IZoa1

-- Dumped from database version 14.19 (Ubuntu 14.19-1.pgdg22.04+1)
-- Dumped by pg_dump version 14.19 (Ubuntu 14.19-1.pgdg22.04+1)

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
-- Name: newenia_ai_universal; Type: SCHEMA; Schema: -; Owner: newenia
--

CREATE SCHEMA newenia_ai_universal;


ALTER SCHEMA newenia_ai_universal OWNER TO newenia;

--
-- Name: newenia_analytics_global; Type: SCHEMA; Schema: -; Owner: newenia
--

CREATE SCHEMA newenia_analytics_global;


ALTER SCHEMA newenia_analytics_global OWNER TO newenia;

--
-- Name: newenia_automation_engine; Type: SCHEMA; Schema: -; Owner: newenia
--

CREATE SCHEMA newenia_automation_engine;


ALTER SCHEMA newenia_automation_engine OWNER TO newenia;

--
-- Name: newenia_document_processing; Type: SCHEMA; Schema: -; Owner: newenia
--

CREATE SCHEMA newenia_document_processing;


ALTER SCHEMA newenia_document_processing OWNER TO newenia;

--
-- Name: newenia_global_core; Type: SCHEMA; Schema: -; Owner: newenia
--

CREATE SCHEMA newenia_global_core;


ALTER SCHEMA newenia_global_core OWNER TO newenia;

--
-- Name: newenia_revenue_core; Type: SCHEMA; Schema: -; Owner: newenia
--

CREATE SCHEMA newenia_revenue_core;


ALTER SCHEMA newenia_revenue_core OWNER TO newenia;

--
-- Name: newenia_security_audit; Type: SCHEMA; Schema: -; Owner: newenia
--

CREATE SCHEMA newenia_security_audit;


ALTER SCHEMA newenia_security_audit OWNER TO newenia;

--
-- Name: newenia_vector_storage; Type: SCHEMA; Schema: -; Owner: newenia
--

CREATE SCHEMA newenia_vector_storage;


ALTER SCHEMA newenia_vector_storage OWNER TO newenia;

--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA public;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: vector; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS vector WITH SCHEMA public;


--
-- Name: EXTENSION vector; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION vector IS 'vector data type and ivfflat and hnsw access methods';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ai_providers; Type: TABLE; Schema: newenia_ai_universal; Owner: postgres
--

CREATE TABLE newenia_ai_universal.ai_providers (
    id bigint NOT NULL,
    tenant_id bigint NOT NULL,
    provider text NOT NULL,
    model text NOT NULL,
    purpose text NOT NULL,
    base_url text,
    api_key_ref text,
    is_enabled boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE newenia_ai_universal.ai_providers OWNER TO postgres;

--
-- Name: ai_providers_id_seq; Type: SEQUENCE; Schema: newenia_ai_universal; Owner: postgres
--

CREATE SEQUENCE newenia_ai_universal.ai_providers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE newenia_ai_universal.ai_providers_id_seq OWNER TO postgres;

--
-- Name: ai_providers_id_seq; Type: SEQUENCE OWNED BY; Schema: newenia_ai_universal; Owner: postgres
--

ALTER SEQUENCE newenia_ai_universal.ai_providers_id_seq OWNED BY newenia_ai_universal.ai_providers.id;


--
-- Name: learning_events; Type: TABLE; Schema: newenia_ai_universal; Owner: postgres
--

CREATE TABLE newenia_ai_universal.learning_events (
    id bigint NOT NULL,
    tenant_id bigint NOT NULL,
    subject_type text NOT NULL,
    subject_id bigint,
    signal text NOT NULL,
    weight numeric(6,3) DEFAULT 1.0 NOT NULL,
    payload jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_by bigint,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE newenia_ai_universal.learning_events OWNER TO postgres;

--
-- Name: learning_events_id_seq; Type: SEQUENCE; Schema: newenia_ai_universal; Owner: postgres
--

CREATE SEQUENCE newenia_ai_universal.learning_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE newenia_ai_universal.learning_events_id_seq OWNER TO postgres;

--
-- Name: learning_events_id_seq; Type: SEQUENCE OWNED BY; Schema: newenia_ai_universal; Owner: postgres
--

ALTER SEQUENCE newenia_ai_universal.learning_events_id_seq OWNED BY newenia_ai_universal.learning_events.id;


--
-- Name: automation_credentials; Type: TABLE; Schema: newenia_automation_engine; Owner: newenia
--

CREATE TABLE newenia_automation_engine.automation_credentials (
    id integer NOT NULL,
    tenant_id bigint NOT NULL,
    automation_code character varying(100) NOT NULL,
    credential_key character varying(100) NOT NULL,
    credential_value_encrypted text NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE newenia_automation_engine.automation_credentials OWNER TO newenia;

--
-- Name: automation_credentials_id_seq; Type: SEQUENCE; Schema: newenia_automation_engine; Owner: newenia
--

CREATE SEQUENCE newenia_automation_engine.automation_credentials_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE newenia_automation_engine.automation_credentials_id_seq OWNER TO newenia;

--
-- Name: automation_credentials_id_seq; Type: SEQUENCE OWNED BY; Schema: newenia_automation_engine; Owner: newenia
--

ALTER SEQUENCE newenia_automation_engine.automation_credentials_id_seq OWNED BY newenia_automation_engine.automation_credentials.id;


--
-- Name: automation_executions; Type: TABLE; Schema: newenia_automation_engine; Owner: newenia
--

CREATE TABLE newenia_automation_engine.automation_executions (
    id bigint NOT NULL,
    job_id bigint NOT NULL,
    execution_id character varying(100),
    status character varying(50),
    input_data jsonb,
    output_data jsonb,
    error_message text,
    execution_time_ms integer,
    cost numeric(10,2),
    started_at timestamp without time zone,
    completed_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE newenia_automation_engine.automation_executions OWNER TO newenia;

--
-- Name: automation_executions_id_seq; Type: SEQUENCE; Schema: newenia_automation_engine; Owner: newenia
--

CREATE SEQUENCE newenia_automation_engine.automation_executions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE newenia_automation_engine.automation_executions_id_seq OWNER TO newenia;

--
-- Name: automation_executions_id_seq; Type: SEQUENCE OWNED BY; Schema: newenia_automation_engine; Owner: newenia
--

ALTER SEQUENCE newenia_automation_engine.automation_executions_id_seq OWNED BY newenia_automation_engine.automation_executions.id;


--
-- Name: automation_templates; Type: TABLE; Schema: newenia_automation_engine; Owner: newenia
--

CREATE TABLE newenia_automation_engine.automation_templates (
    code character varying(100) NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    category character varying(100),
    icon character varying(50),
    pricing_model character varying(50),
    base_price numeric(10,2) DEFAULT 0,
    per_execution_price numeric(10,2) DEFAULT 0,
    required_credentials jsonb,
    config_schema jsonb,
    n8n_template text,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE newenia_automation_engine.automation_templates OWNER TO newenia;

--
-- Name: jobs; Type: TABLE; Schema: newenia_automation_engine; Owner: postgres
--

CREATE TABLE newenia_automation_engine.jobs (
    id bigint NOT NULL,
    tenant_id bigint NOT NULL,
    name text NOT NULL,
    schedule_cron text,
    task_type text NOT NULL,
    config jsonb DEFAULT '{}'::jsonb NOT NULL,
    last_run_at timestamp with time zone,
    next_run_at timestamp with time zone,
    status text DEFAULT 'idle'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    template_code character varying(100),
    pricing_info jsonb DEFAULT '{}'::jsonb,
    total_executions integer DEFAULT 0,
    total_cost numeric(10,2) DEFAULT 0,
    n8n_workflow_id character varying(100)
);


ALTER TABLE newenia_automation_engine.jobs OWNER TO postgres;

--
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: newenia_automation_engine; Owner: postgres
--

CREATE SEQUENCE newenia_automation_engine.jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE newenia_automation_engine.jobs_id_seq OWNER TO postgres;

--
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: newenia_automation_engine; Owner: postgres
--

ALTER SEQUENCE newenia_automation_engine.jobs_id_seq OWNED BY newenia_automation_engine.jobs.id;


--
-- Name: documents; Type: TABLE; Schema: newenia_document_processing; Owner: postgres
--

CREATE TABLE newenia_document_processing.documents (
    id bigint NOT NULL,
    tenant_id bigint NOT NULL,
    external_id text,
    mime_type text,
    title text,
    storage_uri text NOT NULL,
    status text DEFAULT 'ingested'::text NOT NULL,
    meta jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE newenia_document_processing.documents OWNER TO postgres;

--
-- Name: documents_id_seq; Type: SEQUENCE; Schema: newenia_document_processing; Owner: postgres
--

CREATE SEQUENCE newenia_document_processing.documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE newenia_document_processing.documents_id_seq OWNER TO postgres;

--
-- Name: documents_id_seq; Type: SEQUENCE OWNED BY; Schema: newenia_document_processing; Owner: postgres
--

ALTER SEQUENCE newenia_document_processing.documents_id_seq OWNED BY newenia_document_processing.documents.id;


--
-- Name: sectors; Type: TABLE; Schema: newenia_document_processing; Owner: postgres
--

CREATE TABLE newenia_document_processing.sectors (
    id bigint NOT NULL,
    tenant_id bigint NOT NULL,
    document_id bigint NOT NULL,
    sector_key text NOT NULL,
    canonical_text text NOT NULL,
    meta jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE newenia_document_processing.sectors OWNER TO postgres;

--
-- Name: sectors_id_seq; Type: SEQUENCE; Schema: newenia_document_processing; Owner: postgres
--

CREATE SEQUENCE newenia_document_processing.sectors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE newenia_document_processing.sectors_id_seq OWNER TO postgres;

--
-- Name: sectors_id_seq; Type: SEQUENCE OWNED BY; Schema: newenia_document_processing; Owner: postgres
--

ALTER SEQUENCE newenia_document_processing.sectors_id_seq OWNED BY newenia_document_processing.sectors.id;


--
-- Name: tenants; Type: TABLE; Schema: newenia_global_core; Owner: postgres
--

CREATE TABLE newenia_global_core.tenants (
    id bigint NOT NULL,
    code text NOT NULL,
    name text NOT NULL,
    status text DEFAULT 'active'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE newenia_global_core.tenants OWNER TO postgres;

--
-- Name: tenants_id_seq; Type: SEQUENCE; Schema: newenia_global_core; Owner: postgres
--

CREATE SEQUENCE newenia_global_core.tenants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE newenia_global_core.tenants_id_seq OWNER TO postgres;

--
-- Name: tenants_id_seq; Type: SEQUENCE OWNED BY; Schema: newenia_global_core; Owner: postgres
--

ALTER SEQUENCE newenia_global_core.tenants_id_seq OWNED BY newenia_global_core.tenants.id;


--
-- Name: users; Type: TABLE; Schema: newenia_global_core; Owner: postgres
--

CREATE TABLE newenia_global_core.users (
    id bigint NOT NULL,
    tenant_id bigint NOT NULL,
    email text NOT NULL,
    name text NOT NULL,
    password text NOT NULL,
    role text DEFAULT 'user'::text NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    remember_token character varying(100)
);


ALTER TABLE newenia_global_core.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: newenia_global_core; Owner: postgres
--

CREATE SEQUENCE newenia_global_core.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE newenia_global_core.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: newenia_global_core; Owner: postgres
--

ALTER SEQUENCE newenia_global_core.users_id_seq OWNED BY newenia_global_core.users.id;


--
-- Name: usage_counters; Type: TABLE; Schema: newenia_revenue_core; Owner: postgres
--

CREATE TABLE newenia_revenue_core.usage_counters (
    id bigint NOT NULL,
    tenant_id bigint NOT NULL,
    counter_date date NOT NULL,
    metric text NOT NULL,
    amount bigint DEFAULT 0 NOT NULL,
    meta jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE newenia_revenue_core.usage_counters OWNER TO postgres;

--
-- Name: usage_counters_id_seq; Type: SEQUENCE; Schema: newenia_revenue_core; Owner: postgres
--

CREATE SEQUENCE newenia_revenue_core.usage_counters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE newenia_revenue_core.usage_counters_id_seq OWNER TO postgres;

--
-- Name: usage_counters_id_seq; Type: SEQUENCE OWNED BY; Schema: newenia_revenue_core; Owner: postgres
--

ALTER SEQUENCE newenia_revenue_core.usage_counters_id_seq OWNED BY newenia_revenue_core.usage_counters.id;


--
-- Name: audit_logs; Type: TABLE; Schema: newenia_security_audit; Owner: postgres
--

CREATE TABLE newenia_security_audit.audit_logs (
    id bigint NOT NULL,
    tenant_id bigint,
    actor_user_id bigint,
    event text NOT NULL,
    ref_table text,
    ref_id text,
    meta jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE newenia_security_audit.audit_logs OWNER TO postgres;

--
-- Name: audit_logs_id_seq; Type: SEQUENCE; Schema: newenia_security_audit; Owner: postgres
--

CREATE SEQUENCE newenia_security_audit.audit_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE newenia_security_audit.audit_logs_id_seq OWNER TO postgres;

--
-- Name: audit_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: newenia_security_audit; Owner: postgres
--

ALTER SEQUENCE newenia_security_audit.audit_logs_id_seq OWNED BY newenia_security_audit.audit_logs.id;


--
-- Name: audit_requests; Type: TABLE; Schema: newenia_security_audit; Owner: postgres
--

CREATE TABLE newenia_security_audit.audit_requests (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    tenant_id integer,
    ip text,
    method text,
    path text,
    duration_ms numeric,
    user_email text,
    request_id uuid,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE newenia_security_audit.audit_requests OWNER TO postgres;

--
-- Name: universal_embeddings; Type: TABLE; Schema: newenia_vector_storage; Owner: postgres
--

CREATE TABLE newenia_vector_storage.universal_embeddings (
    id bigint NOT NULL,
    tenant_id bigint NOT NULL,
    sector_id bigint NOT NULL,
    provider text NOT NULL,
    model text NOT NULL,
    dims integer DEFAULT 1536 NOT NULL,
    vector public.vector(1536),
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE newenia_vector_storage.universal_embeddings OWNER TO postgres;

--
-- Name: universal_embeddings_id_seq; Type: SEQUENCE; Schema: newenia_vector_storage; Owner: postgres
--

CREATE SEQUENCE newenia_vector_storage.universal_embeddings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE newenia_vector_storage.universal_embeddings_id_seq OWNER TO postgres;

--
-- Name: universal_embeddings_id_seq; Type: SEQUENCE OWNED BY; Schema: newenia_vector_storage; Owner: postgres
--

ALTER SEQUENCE newenia_vector_storage.universal_embeddings_id_seq OWNED BY newenia_vector_storage.universal_embeddings.id;


--
-- Name: cache; Type: TABLE; Schema: public; Owner: newenia
--

CREATE TABLE public.cache (
    key character varying(255) NOT NULL,
    value text NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache OWNER TO newenia;

--
-- Name: cache_locks; Type: TABLE; Schema: public; Owner: newenia
--

CREATE TABLE public.cache_locks (
    key character varying(255) NOT NULL,
    owner character varying(255) NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache_locks OWNER TO newenia;

--
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: newenia
--

CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    uuid character varying(255) NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.failed_jobs OWNER TO newenia;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: newenia
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.failed_jobs_id_seq OWNER TO newenia;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: newenia
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- Name: job_batches; Type: TABLE; Schema: public; Owner: newenia
--

CREATE TABLE public.job_batches (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    total_jobs integer NOT NULL,
    pending_jobs integer NOT NULL,
    failed_jobs integer NOT NULL,
    failed_job_ids text NOT NULL,
    options text,
    cancelled_at integer,
    created_at integer NOT NULL,
    finished_at integer
);


ALTER TABLE public.job_batches OWNER TO newenia;

--
-- Name: jobs; Type: TABLE; Schema: public; Owner: newenia
--

CREATE TABLE public.jobs (
    id bigint NOT NULL,
    queue character varying(255) NOT NULL,
    payload text NOT NULL,
    attempts smallint NOT NULL,
    reserved_at integer,
    available_at integer NOT NULL,
    created_at integer NOT NULL
);


ALTER TABLE public.jobs OWNER TO newenia;

--
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: newenia
--

CREATE SEQUENCE public.jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.jobs_id_seq OWNER TO newenia;

--
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: newenia
--

ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: newenia
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE public.migrations OWNER TO newenia;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: newenia
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.migrations_id_seq OWNER TO newenia;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: newenia
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: newenia
--

CREATE TABLE public.password_reset_tokens (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


ALTER TABLE public.password_reset_tokens OWNER TO newenia;

--
-- Name: sessions; Type: TABLE; Schema: public; Owner: newenia
--

CREATE TABLE public.sessions (
    id character varying(255) NOT NULL,
    user_id bigint,
    ip_address character varying(45),
    user_agent text,
    payload text NOT NULL,
    last_activity integer NOT NULL
);


ALTER TABLE public.sessions OWNER TO newenia;

--
-- Name: users; Type: TABLE; Schema: public; Owner: newenia
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    email_verified_at timestamp(0) without time zone,
    password character varying(255) NOT NULL,
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.users OWNER TO newenia;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: newenia
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO newenia;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: newenia
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: ai_providers id; Type: DEFAULT; Schema: newenia_ai_universal; Owner: postgres
--

ALTER TABLE ONLY newenia_ai_universal.ai_providers ALTER COLUMN id SET DEFAULT nextval('newenia_ai_universal.ai_providers_id_seq'::regclass);


--
-- Name: learning_events id; Type: DEFAULT; Schema: newenia_ai_universal; Owner: postgres
--

ALTER TABLE ONLY newenia_ai_universal.learning_events ALTER COLUMN id SET DEFAULT nextval('newenia_ai_universal.learning_events_id_seq'::regclass);


--
-- Name: automation_credentials id; Type: DEFAULT; Schema: newenia_automation_engine; Owner: newenia
--

ALTER TABLE ONLY newenia_automation_engine.automation_credentials ALTER COLUMN id SET DEFAULT nextval('newenia_automation_engine.automation_credentials_id_seq'::regclass);


--
-- Name: automation_executions id; Type: DEFAULT; Schema: newenia_automation_engine; Owner: newenia
--

ALTER TABLE ONLY newenia_automation_engine.automation_executions ALTER COLUMN id SET DEFAULT nextval('newenia_automation_engine.automation_executions_id_seq'::regclass);


--
-- Name: jobs id; Type: DEFAULT; Schema: newenia_automation_engine; Owner: postgres
--

ALTER TABLE ONLY newenia_automation_engine.jobs ALTER COLUMN id SET DEFAULT nextval('newenia_automation_engine.jobs_id_seq'::regclass);


--
-- Name: documents id; Type: DEFAULT; Schema: newenia_document_processing; Owner: postgres
--

ALTER TABLE ONLY newenia_document_processing.documents ALTER COLUMN id SET DEFAULT nextval('newenia_document_processing.documents_id_seq'::regclass);


--
-- Name: sectors id; Type: DEFAULT; Schema: newenia_document_processing; Owner: postgres
--

ALTER TABLE ONLY newenia_document_processing.sectors ALTER COLUMN id SET DEFAULT nextval('newenia_document_processing.sectors_id_seq'::regclass);


--
-- Name: tenants id; Type: DEFAULT; Schema: newenia_global_core; Owner: postgres
--

ALTER TABLE ONLY newenia_global_core.tenants ALTER COLUMN id SET DEFAULT nextval('newenia_global_core.tenants_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: newenia_global_core; Owner: postgres
--

ALTER TABLE ONLY newenia_global_core.users ALTER COLUMN id SET DEFAULT nextval('newenia_global_core.users_id_seq'::regclass);


--
-- Name: usage_counters id; Type: DEFAULT; Schema: newenia_revenue_core; Owner: postgres
--

ALTER TABLE ONLY newenia_revenue_core.usage_counters ALTER COLUMN id SET DEFAULT nextval('newenia_revenue_core.usage_counters_id_seq'::regclass);


--
-- Name: audit_logs id; Type: DEFAULT; Schema: newenia_security_audit; Owner: postgres
--

ALTER TABLE ONLY newenia_security_audit.audit_logs ALTER COLUMN id SET DEFAULT nextval('newenia_security_audit.audit_logs_id_seq'::regclass);


--
-- Name: universal_embeddings id; Type: DEFAULT; Schema: newenia_vector_storage; Owner: postgres
--

ALTER TABLE ONLY newenia_vector_storage.universal_embeddings ALTER COLUMN id SET DEFAULT nextval('newenia_vector_storage.universal_embeddings_id_seq'::regclass);


--
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: newenia
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: newenia
--

ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: newenia
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: newenia
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: ai_providers ai_providers_pkey; Type: CONSTRAINT; Schema: newenia_ai_universal; Owner: postgres
--

ALTER TABLE ONLY newenia_ai_universal.ai_providers
    ADD CONSTRAINT ai_providers_pkey PRIMARY KEY (id);


--
-- Name: ai_providers ai_providers_tenant_id_provider_model_purpose_key; Type: CONSTRAINT; Schema: newenia_ai_universal; Owner: postgres
--

ALTER TABLE ONLY newenia_ai_universal.ai_providers
    ADD CONSTRAINT ai_providers_tenant_id_provider_model_purpose_key UNIQUE (tenant_id, provider, model, purpose);


--
-- Name: learning_events learning_events_pkey; Type: CONSTRAINT; Schema: newenia_ai_universal; Owner: postgres
--

ALTER TABLE ONLY newenia_ai_universal.learning_events
    ADD CONSTRAINT learning_events_pkey PRIMARY KEY (id);


--
-- Name: automation_credentials automation_credentials_pkey; Type: CONSTRAINT; Schema: newenia_automation_engine; Owner: newenia
--

ALTER TABLE ONLY newenia_automation_engine.automation_credentials
    ADD CONSTRAINT automation_credentials_pkey PRIMARY KEY (id);


--
-- Name: automation_credentials automation_credentials_tenant_id_automation_code_credential_key; Type: CONSTRAINT; Schema: newenia_automation_engine; Owner: newenia
--

ALTER TABLE ONLY newenia_automation_engine.automation_credentials
    ADD CONSTRAINT automation_credentials_tenant_id_automation_code_credential_key UNIQUE (tenant_id, automation_code, credential_key);


--
-- Name: automation_executions automation_executions_pkey; Type: CONSTRAINT; Schema: newenia_automation_engine; Owner: newenia
--

ALTER TABLE ONLY newenia_automation_engine.automation_executions
    ADD CONSTRAINT automation_executions_pkey PRIMARY KEY (id);


--
-- Name: automation_templates automation_templates_pkey; Type: CONSTRAINT; Schema: newenia_automation_engine; Owner: newenia
--

ALTER TABLE ONLY newenia_automation_engine.automation_templates
    ADD CONSTRAINT automation_templates_pkey PRIMARY KEY (code);


--
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: newenia_automation_engine; Owner: postgres
--

ALTER TABLE ONLY newenia_automation_engine.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- Name: documents documents_pkey; Type: CONSTRAINT; Schema: newenia_document_processing; Owner: postgres
--

ALTER TABLE ONLY newenia_document_processing.documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (id);


--
-- Name: sectors sectors_pkey; Type: CONSTRAINT; Schema: newenia_document_processing; Owner: postgres
--

ALTER TABLE ONLY newenia_document_processing.sectors
    ADD CONSTRAINT sectors_pkey PRIMARY KEY (id);


--
-- Name: sectors sectors_tenant_id_document_id_sector_key_key; Type: CONSTRAINT; Schema: newenia_document_processing; Owner: postgres
--

ALTER TABLE ONLY newenia_document_processing.sectors
    ADD CONSTRAINT sectors_tenant_id_document_id_sector_key_key UNIQUE (tenant_id, document_id, sector_key);


--
-- Name: tenants tenants_code_key; Type: CONSTRAINT; Schema: newenia_global_core; Owner: postgres
--

ALTER TABLE ONLY newenia_global_core.tenants
    ADD CONSTRAINT tenants_code_key UNIQUE (code);


--
-- Name: tenants tenants_pkey; Type: CONSTRAINT; Schema: newenia_global_core; Owner: postgres
--

ALTER TABLE ONLY newenia_global_core.tenants
    ADD CONSTRAINT tenants_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: newenia_global_core; Owner: postgres
--

ALTER TABLE ONLY newenia_global_core.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: newenia_global_core; Owner: postgres
--

ALTER TABLE ONLY newenia_global_core.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: usage_counters usage_counters_pkey; Type: CONSTRAINT; Schema: newenia_revenue_core; Owner: postgres
--

ALTER TABLE ONLY newenia_revenue_core.usage_counters
    ADD CONSTRAINT usage_counters_pkey PRIMARY KEY (id);


--
-- Name: usage_counters usage_counters_tenant_id_counter_date_metric_key; Type: CONSTRAINT; Schema: newenia_revenue_core; Owner: postgres
--

ALTER TABLE ONLY newenia_revenue_core.usage_counters
    ADD CONSTRAINT usage_counters_tenant_id_counter_date_metric_key UNIQUE (tenant_id, counter_date, metric);


--
-- Name: audit_logs audit_logs_pkey; Type: CONSTRAINT; Schema: newenia_security_audit; Owner: postgres
--

ALTER TABLE ONLY newenia_security_audit.audit_logs
    ADD CONSTRAINT audit_logs_pkey PRIMARY KEY (id);


--
-- Name: audit_requests audit_requests_pkey; Type: CONSTRAINT; Schema: newenia_security_audit; Owner: postgres
--

ALTER TABLE ONLY newenia_security_audit.audit_requests
    ADD CONSTRAINT audit_requests_pkey PRIMARY KEY (id);


--
-- Name: universal_embeddings universal_embeddings_pkey; Type: CONSTRAINT; Schema: newenia_vector_storage; Owner: postgres
--

ALTER TABLE ONLY newenia_vector_storage.universal_embeddings
    ADD CONSTRAINT universal_embeddings_pkey PRIMARY KEY (id);


--
-- Name: universal_embeddings universal_embeddings_tenant_id_sector_id_provider_model_key; Type: CONSTRAINT; Schema: newenia_vector_storage; Owner: postgres
--

ALTER TABLE ONLY newenia_vector_storage.universal_embeddings
    ADD CONSTRAINT universal_embeddings_tenant_id_sector_id_provider_model_key UNIQUE (tenant_id, sector_id, provider, model);


--
-- Name: cache_locks cache_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: newenia
--

ALTER TABLE ONLY public.cache_locks
    ADD CONSTRAINT cache_locks_pkey PRIMARY KEY (key);


--
-- Name: cache cache_pkey; Type: CONSTRAINT; Schema: public; Owner: newenia
--

ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (key);


--
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: newenia
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: newenia
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);


--
-- Name: job_batches job_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: newenia
--

ALTER TABLE ONLY public.job_batches
    ADD CONSTRAINT job_batches_pkey PRIMARY KEY (id);


--
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: newenia
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: newenia
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: newenia
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (email);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: newenia
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: newenia
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: newenia
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: idx_learning_events_tenant; Type: INDEX; Schema: newenia_ai_universal; Owner: postgres
--

CREATE INDEX idx_learning_events_tenant ON newenia_ai_universal.learning_events USING btree (tenant_id);


--
-- Name: idx_credentials_tenant; Type: INDEX; Schema: newenia_automation_engine; Owner: newenia
--

CREATE INDEX idx_credentials_tenant ON newenia_automation_engine.automation_credentials USING btree (tenant_id);


--
-- Name: idx_executions_job; Type: INDEX; Schema: newenia_automation_engine; Owner: newenia
--

CREATE INDEX idx_executions_job ON newenia_automation_engine.automation_executions USING btree (job_id);


--
-- Name: idx_jobs_template; Type: INDEX; Schema: newenia_automation_engine; Owner: postgres
--

CREATE INDEX idx_jobs_template ON newenia_automation_engine.jobs USING btree (template_code);


--
-- Name: idx_jobs_tenant; Type: INDEX; Schema: newenia_automation_engine; Owner: postgres
--

CREATE INDEX idx_jobs_tenant ON newenia_automation_engine.jobs USING btree (tenant_id);


--
-- Name: idx_docs_created_at; Type: INDEX; Schema: newenia_document_processing; Owner: postgres
--

CREATE INDEX idx_docs_created_at ON newenia_document_processing.documents USING btree (created_at);


--
-- Name: idx_documents_tenant; Type: INDEX; Schema: newenia_document_processing; Owner: postgres
--

CREATE INDEX idx_documents_tenant ON newenia_document_processing.documents USING btree (tenant_id);


--
-- Name: idx_sectors_tenant; Type: INDEX; Schema: newenia_document_processing; Owner: postgres
--

CREATE INDEX idx_sectors_tenant ON newenia_document_processing.sectors USING btree (tenant_id);


--
-- Name: idx_users_tenant; Type: INDEX; Schema: newenia_global_core; Owner: postgres
--

CREATE INDEX idx_users_tenant ON newenia_global_core.users USING btree (tenant_id);


--
-- Name: idx_audit_created; Type: INDEX; Schema: newenia_security_audit; Owner: postgres
--

CREATE INDEX idx_audit_created ON newenia_security_audit.audit_requests USING btree (created_at DESC);


--
-- Name: idx_audit_method; Type: INDEX; Schema: newenia_security_audit; Owner: postgres
--

CREATE INDEX idx_audit_method ON newenia_security_audit.audit_requests USING btree (method);


--
-- Name: idx_audit_method_created; Type: INDEX; Schema: newenia_security_audit; Owner: postgres
--

CREATE INDEX idx_audit_method_created ON newenia_security_audit.audit_requests USING btree (method, created_at DESC);


--
-- Name: idx_audit_path_like; Type: INDEX; Schema: newenia_security_audit; Owner: postgres
--

CREATE INDEX idx_audit_path_like ON newenia_security_audit.audit_requests USING btree (path);


--
-- Name: idx_audit_path_trgm; Type: INDEX; Schema: newenia_security_audit; Owner: postgres
--

CREATE INDEX idx_audit_path_trgm ON newenia_security_audit.audit_requests USING gin (path public.gin_trgm_ops);


--
-- Name: idx_audit_tenant; Type: INDEX; Schema: newenia_security_audit; Owner: postgres
--

CREATE INDEX idx_audit_tenant ON newenia_security_audit.audit_logs USING btree (tenant_id);


--
-- Name: idx_audit_tenant_created; Type: INDEX; Schema: newenia_security_audit; Owner: postgres
--

CREATE INDEX idx_audit_tenant_created ON newenia_security_audit.audit_requests USING btree (tenant_id, created_at DESC);


--
-- Name: idx_logs_created_at; Type: INDEX; Schema: newenia_security_audit; Owner: postgres
--

CREATE INDEX idx_logs_created_at ON newenia_security_audit.audit_logs USING btree (created_at);


--
-- Name: idx_embeddings_tenant; Type: INDEX; Schema: newenia_vector_storage; Owner: postgres
--

CREATE INDEX idx_embeddings_tenant ON newenia_vector_storage.universal_embeddings USING btree (tenant_id);


--
-- Name: universal_embeddings_vec_idx; Type: INDEX; Schema: newenia_vector_storage; Owner: postgres
--

CREATE INDEX universal_embeddings_vec_idx ON newenia_vector_storage.universal_embeddings USING ivfflat (vector public.vector_cosine_ops) WITH (lists='100');


--
-- Name: jobs_queue_index; Type: INDEX; Schema: public; Owner: newenia
--

CREATE INDEX jobs_queue_index ON public.jobs USING btree (queue);


--
-- Name: sessions_last_activity_idx; Type: INDEX; Schema: public; Owner: newenia
--

CREATE INDEX sessions_last_activity_idx ON public.sessions USING btree (last_activity);


--
-- Name: sessions_last_activity_index; Type: INDEX; Schema: public; Owner: newenia
--

CREATE INDEX sessions_last_activity_index ON public.sessions USING btree (last_activity);


--
-- Name: sessions_user_id_idx; Type: INDEX; Schema: public; Owner: newenia
--

CREATE INDEX sessions_user_id_idx ON public.sessions USING btree (user_id);


--
-- Name: sessions_user_id_index; Type: INDEX; Schema: public; Owner: newenia
--

CREATE INDEX sessions_user_id_index ON public.sessions USING btree (user_id);


--
-- Name: ai_providers ai_providers_tenant_id_fkey; Type: FK CONSTRAINT; Schema: newenia_ai_universal; Owner: postgres
--

ALTER TABLE ONLY newenia_ai_universal.ai_providers
    ADD CONSTRAINT ai_providers_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES newenia_global_core.tenants(id);


--
-- Name: learning_events learning_events_tenant_id_fkey; Type: FK CONSTRAINT; Schema: newenia_ai_universal; Owner: postgres
--

ALTER TABLE ONLY newenia_ai_universal.learning_events
    ADD CONSTRAINT learning_events_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES newenia_global_core.tenants(id);


--
-- Name: automation_credentials automation_credentials_tenant_id_fkey; Type: FK CONSTRAINT; Schema: newenia_automation_engine; Owner: newenia
--

ALTER TABLE ONLY newenia_automation_engine.automation_credentials
    ADD CONSTRAINT automation_credentials_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES newenia_global_core.tenants(id);


--
-- Name: automation_executions automation_executions_job_id_fkey; Type: FK CONSTRAINT; Schema: newenia_automation_engine; Owner: newenia
--

ALTER TABLE ONLY newenia_automation_engine.automation_executions
    ADD CONSTRAINT automation_executions_job_id_fkey FOREIGN KEY (job_id) REFERENCES newenia_automation_engine.jobs(id);


--
-- Name: jobs jobs_tenant_id_fkey; Type: FK CONSTRAINT; Schema: newenia_automation_engine; Owner: postgres
--

ALTER TABLE ONLY newenia_automation_engine.jobs
    ADD CONSTRAINT jobs_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES newenia_global_core.tenants(id);


--
-- Name: documents documents_tenant_id_fkey; Type: FK CONSTRAINT; Schema: newenia_document_processing; Owner: postgres
--

ALTER TABLE ONLY newenia_document_processing.documents
    ADD CONSTRAINT documents_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES newenia_global_core.tenants(id);


--
-- Name: sectors sectors_document_id_fkey; Type: FK CONSTRAINT; Schema: newenia_document_processing; Owner: postgres
--

ALTER TABLE ONLY newenia_document_processing.sectors
    ADD CONSTRAINT sectors_document_id_fkey FOREIGN KEY (document_id) REFERENCES newenia_document_processing.documents(id) ON DELETE CASCADE;


--
-- Name: sectors sectors_tenant_id_fkey; Type: FK CONSTRAINT; Schema: newenia_document_processing; Owner: postgres
--

ALTER TABLE ONLY newenia_document_processing.sectors
    ADD CONSTRAINT sectors_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES newenia_global_core.tenants(id);


--
-- Name: users users_tenant_id_fkey; Type: FK CONSTRAINT; Schema: newenia_global_core; Owner: postgres
--

ALTER TABLE ONLY newenia_global_core.users
    ADD CONSTRAINT users_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES newenia_global_core.tenants(id);


--
-- Name: usage_counters usage_counters_tenant_id_fkey; Type: FK CONSTRAINT; Schema: newenia_revenue_core; Owner: postgres
--

ALTER TABLE ONLY newenia_revenue_core.usage_counters
    ADD CONSTRAINT usage_counters_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES newenia_global_core.tenants(id);


--
-- Name: universal_embeddings universal_embeddings_sector_id_fkey; Type: FK CONSTRAINT; Schema: newenia_vector_storage; Owner: postgres
--

ALTER TABLE ONLY newenia_vector_storage.universal_embeddings
    ADD CONSTRAINT universal_embeddings_sector_id_fkey FOREIGN KEY (sector_id) REFERENCES newenia_document_processing.sectors(id) ON DELETE CASCADE;


--
-- Name: universal_embeddings universal_embeddings_tenant_id_fkey; Type: FK CONSTRAINT; Schema: newenia_vector_storage; Owner: postgres
--

ALTER TABLE ONLY newenia_vector_storage.universal_embeddings
    ADD CONSTRAINT universal_embeddings_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES newenia_global_core.tenants(id);


--
-- Name: ai_providers; Type: ROW SECURITY; Schema: newenia_ai_universal; Owner: postgres
--

ALTER TABLE newenia_ai_universal.ai_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: learning_events; Type: ROW SECURITY; Schema: newenia_ai_universal; Owner: postgres
--

ALTER TABLE newenia_ai_universal.learning_events ENABLE ROW LEVEL SECURITY;

--
-- Name: ai_providers p_all; Type: POLICY; Schema: newenia_ai_universal; Owner: postgres
--

CREATE POLICY p_all ON newenia_ai_universal.ai_providers USING ((tenant_id = COALESCE((current_setting('app.tenant_id'::text, true))::bigint, ('-1'::integer)::bigint))) WITH CHECK ((tenant_id = COALESCE((current_setting('app.tenant_id'::text, true))::bigint, ('-1'::integer)::bigint)));


--
-- Name: learning_events p_all; Type: POLICY; Schema: newenia_ai_universal; Owner: postgres
--

CREATE POLICY p_all ON newenia_ai_universal.learning_events USING ((tenant_id = COALESCE((current_setting('app.tenant_id'::text, true))::bigint, ('-1'::integer)::bigint))) WITH CHECK ((tenant_id = COALESCE((current_setting('app.tenant_id'::text, true))::bigint, ('-1'::integer)::bigint)));


--
-- Name: ai_providers p_select; Type: POLICY; Schema: newenia_ai_universal; Owner: postgres
--

CREATE POLICY p_select ON newenia_ai_universal.ai_providers FOR SELECT USING ((tenant_id = COALESCE((current_setting('app.tenant_id'::text, true))::bigint, ('-1'::integer)::bigint)));


--
-- Name: learning_events p_select; Type: POLICY; Schema: newenia_ai_universal; Owner: postgres
--

CREATE POLICY p_select ON newenia_ai_universal.learning_events FOR SELECT USING ((tenant_id = COALESCE((current_setting('app.tenant_id'::text, true))::bigint, ('-1'::integer)::bigint)));


--
-- Name: jobs; Type: ROW SECURITY; Schema: newenia_automation_engine; Owner: postgres
--

ALTER TABLE newenia_automation_engine.jobs ENABLE ROW LEVEL SECURITY;

--
-- Name: jobs p_all; Type: POLICY; Schema: newenia_automation_engine; Owner: postgres
--

CREATE POLICY p_all ON newenia_automation_engine.jobs USING ((tenant_id = COALESCE((current_setting('app.tenant_id'::text, true))::bigint, ('-1'::integer)::bigint))) WITH CHECK ((tenant_id = COALESCE((current_setting('app.tenant_id'::text, true))::bigint, ('-1'::integer)::bigint)));


--
-- Name: jobs p_select; Type: POLICY; Schema: newenia_automation_engine; Owner: postgres
--

CREATE POLICY p_select ON newenia_automation_engine.jobs FOR SELECT USING ((tenant_id = COALESCE((current_setting('app.tenant_id'::text, true))::bigint, ('-1'::integer)::bigint)));


--
-- Name: documents; Type: ROW SECURITY; Schema: newenia_document_processing; Owner: postgres
--

ALTER TABLE newenia_document_processing.documents ENABLE ROW LEVEL SECURITY;

--
-- Name: documents p_all; Type: POLICY; Schema: newenia_document_processing; Owner: postgres
--

CREATE POLICY p_all ON newenia_document_processing.documents USING ((tenant_id = COALESCE((current_setting('app.tenant_id'::text, true))::bigint, ('-1'::integer)::bigint))) WITH CHECK ((tenant_id = COALESCE((current_setting('app.tenant_id'::text, true))::bigint, ('-1'::integer)::bigint)));


--
-- Name: sectors p_all; Type: POLICY; Schema: newenia_document_processing; Owner: postgres
--

CREATE POLICY p_all ON newenia_document_processing.sectors USING ((tenant_id = COALESCE((current_setting('app.tenant_id'::text, true))::bigint, ('-1'::integer)::bigint))) WITH CHECK ((tenant_id = COALESCE((current_setting('app.tenant_id'::text, true))::bigint, ('-1'::integer)::bigint)));


--
-- Name: documents p_select; Type: POLICY; Schema: newenia_document_processing; Owner: postgres
--

CREATE POLICY p_select ON newenia_document_processing.documents FOR SELECT USING ((tenant_id = COALESCE((current_setting('app.tenant_id'::text, true))::bigint, ('-1'::integer)::bigint)));


--
-- Name: sectors p_select; Type: POLICY; Schema: newenia_document_processing; Owner: postgres
--

CREATE POLICY p_select ON newenia_document_processing.sectors FOR SELECT USING ((tenant_id = COALESCE((current_setting('app.tenant_id'::text, true))::bigint, ('-1'::integer)::bigint)));


--
-- Name: sectors; Type: ROW SECURITY; Schema: newenia_document_processing; Owner: postgres
--

ALTER TABLE newenia_document_processing.sectors ENABLE ROW LEVEL SECURITY;

--
-- Name: usage_counters p_all; Type: POLICY; Schema: newenia_revenue_core; Owner: postgres
--

CREATE POLICY p_all ON newenia_revenue_core.usage_counters USING ((tenant_id = COALESCE((current_setting('app.tenant_id'::text, true))::bigint, ('-1'::integer)::bigint))) WITH CHECK ((tenant_id = COALESCE((current_setting('app.tenant_id'::text, true))::bigint, ('-1'::integer)::bigint)));


--
-- Name: usage_counters p_select; Type: POLICY; Schema: newenia_revenue_core; Owner: postgres
--

CREATE POLICY p_select ON newenia_revenue_core.usage_counters FOR SELECT USING ((tenant_id = COALESCE((current_setting('app.tenant_id'::text, true))::bigint, ('-1'::integer)::bigint)));


--
-- Name: usage_counters; Type: ROW SECURITY; Schema: newenia_revenue_core; Owner: postgres
--

ALTER TABLE newenia_revenue_core.usage_counters ENABLE ROW LEVEL SECURITY;

--
-- Name: audit_logs; Type: ROW SECURITY; Schema: newenia_security_audit; Owner: postgres
--

ALTER TABLE newenia_security_audit.audit_logs ENABLE ROW LEVEL SECURITY;

--
-- Name: audit_logs p_all; Type: POLICY; Schema: newenia_security_audit; Owner: postgres
--

CREATE POLICY p_all ON newenia_security_audit.audit_logs USING ((tenant_id = COALESCE((current_setting('app.tenant_id'::text, true))::bigint, ('-1'::integer)::bigint))) WITH CHECK ((tenant_id = COALESCE((current_setting('app.tenant_id'::text, true))::bigint, ('-1'::integer)::bigint)));


--
-- Name: audit_logs p_select; Type: POLICY; Schema: newenia_security_audit; Owner: postgres
--

CREATE POLICY p_select ON newenia_security_audit.audit_logs FOR SELECT USING ((tenant_id = COALESCE((current_setting('app.tenant_id'::text, true))::bigint, ('-1'::integer)::bigint)));


--
-- Name: universal_embeddings p_all; Type: POLICY; Schema: newenia_vector_storage; Owner: postgres
--

CREATE POLICY p_all ON newenia_vector_storage.universal_embeddings USING ((tenant_id = COALESCE((current_setting('app.tenant_id'::text, true))::bigint, ('-1'::integer)::bigint))) WITH CHECK ((tenant_id = COALESCE((current_setting('app.tenant_id'::text, true))::bigint, ('-1'::integer)::bigint)));


--
-- Name: universal_embeddings p_select; Type: POLICY; Schema: newenia_vector_storage; Owner: postgres
--

CREATE POLICY p_select ON newenia_vector_storage.universal_embeddings FOR SELECT USING ((tenant_id = COALESCE((current_setting('app.tenant_id'::text, true))::bigint, ('-1'::integer)::bigint)));


--
-- Name: universal_embeddings; Type: ROW SECURITY; Schema: newenia_vector_storage; Owner: postgres
--

ALTER TABLE newenia_vector_storage.universal_embeddings ENABLE ROW LEVEL SECURITY;

--
-- Name: SCHEMA newenia_ai_universal; Type: ACL; Schema: -; Owner: newenia
--

GRANT USAGE ON SCHEMA newenia_ai_universal TO app_runtime;


--
-- Name: SCHEMA newenia_analytics_global; Type: ACL; Schema: -; Owner: newenia
--

GRANT USAGE ON SCHEMA newenia_analytics_global TO app_runtime;


--
-- Name: SCHEMA newenia_automation_engine; Type: ACL; Schema: -; Owner: newenia
--

GRANT USAGE ON SCHEMA newenia_automation_engine TO app_runtime;


--
-- Name: SCHEMA newenia_document_processing; Type: ACL; Schema: -; Owner: newenia
--

GRANT USAGE ON SCHEMA newenia_document_processing TO app_runtime;


--
-- Name: SCHEMA newenia_global_core; Type: ACL; Schema: -; Owner: newenia
--

GRANT USAGE ON SCHEMA newenia_global_core TO app_runtime;
GRANT USAGE ON SCHEMA newenia_global_core TO nielay_login;


--
-- Name: SCHEMA newenia_revenue_core; Type: ACL; Schema: -; Owner: newenia
--

GRANT USAGE ON SCHEMA newenia_revenue_core TO app_runtime;


--
-- Name: SCHEMA newenia_security_audit; Type: ACL; Schema: -; Owner: newenia
--

GRANT USAGE ON SCHEMA newenia_security_audit TO app_runtime;


--
-- Name: SCHEMA newenia_vector_storage; Type: ACL; Schema: -; Owner: newenia
--

GRANT USAGE ON SCHEMA newenia_vector_storage TO app_runtime;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA public TO app_nielay_portal;
GRANT USAGE ON SCHEMA public TO nielay_login;


--
-- Name: TABLE ai_providers; Type: ACL; Schema: newenia_ai_universal; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE newenia_ai_universal.ai_providers TO app_runtime;


--
-- Name: TABLE learning_events; Type: ACL; Schema: newenia_ai_universal; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE newenia_ai_universal.learning_events TO app_runtime;


--
-- Name: TABLE automation_credentials; Type: ACL; Schema: newenia_automation_engine; Owner: newenia
--

GRANT ALL ON TABLE newenia_automation_engine.automation_credentials TO app_runtime;


--
-- Name: SEQUENCE automation_credentials_id_seq; Type: ACL; Schema: newenia_automation_engine; Owner: newenia
--

GRANT ALL ON SEQUENCE newenia_automation_engine.automation_credentials_id_seq TO app_runtime;


--
-- Name: TABLE automation_executions; Type: ACL; Schema: newenia_automation_engine; Owner: newenia
--

GRANT ALL ON TABLE newenia_automation_engine.automation_executions TO app_runtime;


--
-- Name: SEQUENCE automation_executions_id_seq; Type: ACL; Schema: newenia_automation_engine; Owner: newenia
--

GRANT ALL ON SEQUENCE newenia_automation_engine.automation_executions_id_seq TO app_runtime;


--
-- Name: TABLE automation_templates; Type: ACL; Schema: newenia_automation_engine; Owner: newenia
--

GRANT ALL ON TABLE newenia_automation_engine.automation_templates TO app_runtime;


--
-- Name: TABLE jobs; Type: ACL; Schema: newenia_automation_engine; Owner: postgres
--

GRANT ALL ON TABLE newenia_automation_engine.jobs TO app_runtime;
GRANT ALL ON TABLE newenia_automation_engine.jobs TO newenia;


--
-- Name: SEQUENCE jobs_id_seq; Type: ACL; Schema: newenia_automation_engine; Owner: postgres
--

GRANT ALL ON SEQUENCE newenia_automation_engine.jobs_id_seq TO newenia;
GRANT ALL ON SEQUENCE newenia_automation_engine.jobs_id_seq TO app_runtime;


--
-- Name: TABLE documents; Type: ACL; Schema: newenia_document_processing; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE newenia_document_processing.documents TO app_runtime;


--
-- Name: TABLE sectors; Type: ACL; Schema: newenia_document_processing; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE newenia_document_processing.sectors TO app_runtime;


--
-- Name: TABLE tenants; Type: ACL; Schema: newenia_global_core; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE newenia_global_core.tenants TO app_runtime;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE newenia_global_core.tenants TO nielay_login;


--
-- Name: SEQUENCE tenants_id_seq; Type: ACL; Schema: newenia_global_core; Owner: postgres
--

GRANT ALL ON SEQUENCE newenia_global_core.tenants_id_seq TO nielay_login;


--
-- Name: TABLE users; Type: ACL; Schema: newenia_global_core; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE newenia_global_core.users TO app_runtime;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE newenia_global_core.users TO nielay_login;


--
-- Name: SEQUENCE users_id_seq; Type: ACL; Schema: newenia_global_core; Owner: postgres
--

GRANT ALL ON SEQUENCE newenia_global_core.users_id_seq TO nielay_login;


--
-- Name: TABLE usage_counters; Type: ACL; Schema: newenia_revenue_core; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE newenia_revenue_core.usage_counters TO app_runtime;


--
-- Name: TABLE audit_logs; Type: ACL; Schema: newenia_security_audit; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE newenia_security_audit.audit_logs TO app_runtime;


--
-- Name: TABLE audit_requests; Type: ACL; Schema: newenia_security_audit; Owner: postgres
--

GRANT SELECT,INSERT ON TABLE newenia_security_audit.audit_requests TO app_runtime;


--
-- Name: TABLE universal_embeddings; Type: ACL; Schema: newenia_vector_storage; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE newenia_vector_storage.universal_embeddings TO app_runtime;


--
-- Name: TABLE cache; Type: ACL; Schema: public; Owner: newenia
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cache TO app_nielay_portal;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cache TO nielay_login;


--
-- Name: TABLE cache_locks; Type: ACL; Schema: public; Owner: newenia
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cache_locks TO app_nielay_portal;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cache_locks TO nielay_login;


--
-- Name: TABLE failed_jobs; Type: ACL; Schema: public; Owner: newenia
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.failed_jobs TO app_nielay_portal;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.failed_jobs TO nielay_login;


--
-- Name: SEQUENCE failed_jobs_id_seq; Type: ACL; Schema: public; Owner: newenia
--

GRANT ALL ON SEQUENCE public.failed_jobs_id_seq TO app_nielay_portal;
GRANT ALL ON SEQUENCE public.failed_jobs_id_seq TO nielay_login;


--
-- Name: TABLE job_batches; Type: ACL; Schema: public; Owner: newenia
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.job_batches TO app_nielay_portal;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.job_batches TO nielay_login;


--
-- Name: TABLE jobs; Type: ACL; Schema: public; Owner: newenia
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.jobs TO app_nielay_portal;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.jobs TO nielay_login;


--
-- Name: SEQUENCE jobs_id_seq; Type: ACL; Schema: public; Owner: newenia
--

GRANT ALL ON SEQUENCE public.jobs_id_seq TO app_nielay_portal;
GRANT ALL ON SEQUENCE public.jobs_id_seq TO nielay_login;


--
-- Name: TABLE migrations; Type: ACL; Schema: public; Owner: newenia
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.migrations TO app_nielay_portal;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.migrations TO nielay_login;


--
-- Name: SEQUENCE migrations_id_seq; Type: ACL; Schema: public; Owner: newenia
--

GRANT ALL ON SEQUENCE public.migrations_id_seq TO app_nielay_portal;
GRANT ALL ON SEQUENCE public.migrations_id_seq TO nielay_login;


--
-- Name: TABLE password_reset_tokens; Type: ACL; Schema: public; Owner: newenia
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.password_reset_tokens TO app_nielay_portal;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.password_reset_tokens TO nielay_login;


--
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pg_stat_statements TO app_nielay_portal;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pg_stat_statements TO nielay_login;


--
-- Name: TABLE pg_stat_statements_info; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pg_stat_statements_info TO app_nielay_portal;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pg_stat_statements_info TO nielay_login;


--
-- Name: TABLE sessions; Type: ACL; Schema: public; Owner: newenia
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sessions TO app_nielay_portal;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sessions TO nielay_login;


--
-- Name: TABLE users; Type: ACL; Schema: public; Owner: newenia
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.users TO app_nielay_portal;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.users TO nielay_login;


--
-- Name: SEQUENCE users_id_seq; Type: ACL; Schema: public; Owner: newenia
--

GRANT ALL ON SEQUENCE public.users_id_seq TO app_nielay_portal;
GRANT ALL ON SEQUENCE public.users_id_seq TO nielay_login;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: newenia_global_core; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA newenia_global_core GRANT ALL ON SEQUENCES  TO nielay_login;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: newenia_global_core; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA newenia_global_core GRANT SELECT ON TABLES  TO app_runtime;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA newenia_global_core GRANT SELECT,INSERT,DELETE,UPDATE ON TABLES  TO nielay_login;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES  TO app_nielay_portal;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES  TO nielay_login;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT SELECT,INSERT,DELETE,UPDATE ON TABLES  TO app_nielay_portal;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT SELECT,INSERT,DELETE,UPDATE ON TABLES  TO nielay_login;


--
-- PostgreSQL database dump complete
--

\unrestrict qsvkFHctfg9fNRul0hxubaEe8fO3IFKQQt5J0qYBJzjIccP0k3oNKIUvh2IZoa1


--
-- PostgreSQL database dump
--

-- Dumped from database version 16.9
-- Dumped by pg_dump version 16.9

-- Started on 2025-06-25 19:30:35 UTC

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
-- TOC entry 261 (class 1259 OID 17084)
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64),
    details_json text
);


--
-- TOC entry 288 (class 1259 OID 17527)
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


--
-- TOC entry 264 (class 1259 OID 17099)
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


--
-- TOC entry 263 (class 1259 OID 17094)
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


--
-- TOC entry 262 (class 1259 OID 17089)
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


--
-- TOC entry 265 (class 1259 OID 17104)
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- TOC entry 289 (class 1259 OID 17542)
-- Name: broker_link; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


--
-- TOC entry 229 (class 1259 OID 16465)
-- Name: client; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


--
-- TOC entry 248 (class 1259 OID 16823)
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


--
-- TOC entry 300 (class 1259 OID 17791)
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


--
-- TOC entry 299 (class 1259 OID 17666)
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


--
-- TOC entry 249 (class 1259 OID 16833)
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


--
-- TOC entry 277 (class 1259 OID 17332)
-- Name: client_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


--
-- TOC entry 278 (class 1259 OID 17346)
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


--
-- TOC entry 301 (class 1259 OID 17832)
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


--
-- TOC entry 279 (class 1259 OID 17351)
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


--
-- TOC entry 297 (class 1259 OID 17587)
-- Name: component; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


--
-- TOC entry 296 (class 1259 OID 17582)
-- Name: component_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


--
-- TOC entry 230 (class 1259 OID 16484)
-- Name: composite_role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


--
-- TOC entry 231 (class 1259 OID 16487)
-- Name: credential; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer,
    version integer DEFAULT 0
);


--
-- TOC entry 228 (class 1259 OID 16457)
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


--
-- TOC entry 227 (class 1259 OID 16452)
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


--
-- TOC entry 302 (class 1259 OID 17848)
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


--
-- TOC entry 232 (class 1259 OID 16492)
-- Name: event_entity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255),
    details_json_long_value text
);


--
-- TOC entry 290 (class 1259 OID 17547)
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024),
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


--
-- TOC entry 291 (class 1259 OID 17552)
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


--
-- TOC entry 304 (class 1259 OID 17874)
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


--
-- TOC entry 292 (class 1259 OID 17561)
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


--
-- TOC entry 293 (class 1259 OID 17570)
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


--
-- TOC entry 294 (class 1259 OID 17573)
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


--
-- TOC entry 295 (class 1259 OID 17579)
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


--
-- TOC entry 252 (class 1259 OID 16869)
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


--
-- TOC entry 298 (class 1259 OID 17644)
-- Name: federated_user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


--
-- TOC entry 274 (class 1259 OID 17271)
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


--
-- TOC entry 273 (class 1259 OID 17268)
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


--
-- TOC entry 253 (class 1259 OID 16874)
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL,
    organization_id character varying(255),
    hide_on_login boolean DEFAULT false
);


--
-- TOC entry 254 (class 1259 OID 16883)
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- TOC entry 258 (class 1259 OID 16987)
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


--
-- TOC entry 259 (class 1259 OID 16992)
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- TOC entry 313 (class 1259 OID 18073)
-- Name: jgroups_ping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.jgroups_ping (
    address character varying(200) NOT NULL,
    name character varying(200),
    cluster_name character varying(200) NOT NULL,
    ip character varying(200) NOT NULL,
    coord boolean
);


--
-- TOC entry 272 (class 1259 OID 17265)
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36),
    type integer DEFAULT 0 NOT NULL
);


--
-- TOC entry 233 (class 1259 OID 16500)
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


--
-- TOC entry 257 (class 1259 OID 16984)
-- Name: migration_model; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


--
-- TOC entry 271 (class 1259 OID 17256)
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL,
    version integer DEFAULT 0
);


--
-- TOC entry 270 (class 1259 OID 17251)
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL,
    broker_session_id character varying(1024),
    version integer DEFAULT 0
);


--
-- TOC entry 310 (class 1259 OID 18036)
-- Name: org; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.org (
    id character varying(255) NOT NULL,
    enabled boolean NOT NULL,
    realm_id character varying(255) NOT NULL,
    group_id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(4000),
    alias character varying(255) NOT NULL,
    redirect_url character varying(2048)
);


--
-- TOC entry 311 (class 1259 OID 18047)
-- Name: org_domain; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.org_domain (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    verified boolean NOT NULL,
    org_id character varying(255) NOT NULL
);


--
-- TOC entry 284 (class 1259 OID 17470)
-- Name: policy_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


--
-- TOC entry 250 (class 1259 OID 16858)
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


--
-- TOC entry 251 (class 1259 OID 16864)
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- TOC entry 234 (class 1259 OID 16506)
-- Name: realm; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


--
-- TOC entry 235 (class 1259 OID 16523)
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


--
-- TOC entry 276 (class 1259 OID 17280)
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


--
-- TOC entry 256 (class 1259 OID 16976)
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- TOC entry 236 (class 1259 OID 16531)
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- TOC entry 309 (class 1259 OID 17982)
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


--
-- TOC entry 237 (class 1259 OID 16534)
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


--
-- TOC entry 238 (class 1259 OID 16541)
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


--
-- TOC entry 255 (class 1259 OID 16892)
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- TOC entry 239 (class 1259 OID 16551)
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- TOC entry 269 (class 1259 OID 17215)
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- TOC entry 268 (class 1259 OID 17208)
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


--
-- TOC entry 306 (class 1259 OID 17913)
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


--
-- TOC entry 286 (class 1259 OID 17497)
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


--
-- TOC entry 285 (class 1259 OID 17482)
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


--
-- TOC entry 280 (class 1259 OID 17420)
-- Name: resource_server; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


--
-- TOC entry 305 (class 1259 OID 17889)
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


--
-- TOC entry 283 (class 1259 OID 17456)
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


--
-- TOC entry 281 (class 1259 OID 17428)
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


--
-- TOC entry 282 (class 1259 OID 17442)
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


--
-- TOC entry 307 (class 1259 OID 17931)
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- TOC entry 312 (class 1259 OID 18064)
-- Name: revoked_token; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.revoked_token (
    id character varying(255) NOT NULL,
    expire bigint NOT NULL
);


--
-- TOC entry 308 (class 1259 OID 17941)
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


--
-- TOC entry 240 (class 1259 OID 16554)
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


--
-- TOC entry 287 (class 1259 OID 17512)
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


--
-- TOC entry 314 (class 1259 OID 18080)
-- Name: server_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.server_config (
    server_config_key character varying(255) NOT NULL,
    value text NOT NULL,
    version integer DEFAULT 0
);


--
-- TOC entry 241 (class 1259 OID 16560)
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


--
-- TOC entry 260 (class 1259 OID 16997)
-- Name: user_consent; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


--
-- TOC entry 303 (class 1259 OID 17864)
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


--
-- TOC entry 242 (class 1259 OID 16565)
-- Name: user_entity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


--
-- TOC entry 243 (class 1259 OID 16573)
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


--
-- TOC entry 266 (class 1259 OID 17109)
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


--
-- TOC entry 267 (class 1259 OID 17114)
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


--
-- TOC entry 244 (class 1259 OID 16578)
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


--
-- TOC entry 275 (class 1259 OID 17277)
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL,
    membership_type character varying(255) NOT NULL
);


--
-- TOC entry 245 (class 1259 OID 16583)
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


--
-- TOC entry 246 (class 1259 OID 16586)
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


--
-- TOC entry 247 (class 1259 OID 16600)
-- Name: web_origins; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- TOC entry 4175 (class 0 OID 17084)
-- Dependencies: 261
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4202 (class 0 OID 17527)
-- Dependencies: 288
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4178 (class 0 OID 17099)
-- Dependencies: 264
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.authentication_execution VALUES ('b119364b-64f4-4a7f-8cea-082bf6e0a3f0', NULL, 'auth-cookie', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'de0e9104-6094-439a-b3dc-c90eebf4c477', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('3421e283-5d06-45c8-9c8a-d35c99f58147', NULL, 'auth-spnego', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'de0e9104-6094-439a-b3dc-c90eebf4c477', 3, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('65e626c5-8c6e-4d5c-b35c-d9ce95ab16d9', NULL, 'identity-provider-redirector', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'de0e9104-6094-439a-b3dc-c90eebf4c477', 2, 25, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('42ee98fa-4b3f-47b0-a59e-de22234762a2', NULL, NULL, 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'de0e9104-6094-439a-b3dc-c90eebf4c477', 2, 30, true, 'ccfbebba-e32b-43a3-b7b2-e387c5115ad1', NULL);
INSERT INTO public.authentication_execution VALUES ('b25d11de-3423-489a-875e-5fb1ec470de9', NULL, 'auth-username-password-form', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'ccfbebba-e32b-43a3-b7b2-e387c5115ad1', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('6af87e56-ea6c-429d-9b18-f568f86de8cb', NULL, NULL, 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'ccfbebba-e32b-43a3-b7b2-e387c5115ad1', 1, 20, true, '44d06937-27e7-468d-be92-9fa4653869a5', NULL);
INSERT INTO public.authentication_execution VALUES ('2ec4b5c8-0e1a-4575-bd34-8c5a2a9fe5c2', NULL, 'conditional-user-configured', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', '44d06937-27e7-468d-be92-9fa4653869a5', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('0d74c23e-b6d9-451a-919e-638a788a0172', NULL, 'auth-otp-form', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', '44d06937-27e7-468d-be92-9fa4653869a5', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('9f07535c-7181-4b94-92e2-32074cd68974', NULL, 'direct-grant-validate-username', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', '2ecd7150-ae1b-44b5-a166-d0d73a76b64d', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('300c8a24-518a-4b8d-83b8-76b96ec3c224', NULL, 'direct-grant-validate-password', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', '2ecd7150-ae1b-44b5-a166-d0d73a76b64d', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('d28824c8-7725-4370-b446-c5e182cab667', NULL, NULL, 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', '2ecd7150-ae1b-44b5-a166-d0d73a76b64d', 1, 30, true, '79dbabf2-8759-4423-9530-c148c156dc38', NULL);
INSERT INTO public.authentication_execution VALUES ('4a46270d-0349-42f5-b2e8-8615e36fdf4a', NULL, 'conditional-user-configured', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', '79dbabf2-8759-4423-9530-c148c156dc38', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('cf809bdb-0326-4cd5-b7b7-4a06b257185a', NULL, 'direct-grant-validate-otp', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', '79dbabf2-8759-4423-9530-c148c156dc38', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('18acc74f-827e-4a75-8336-db7ffb926491', NULL, 'registration-page-form', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', '2defe1c7-8639-4f73-8d2f-76df83b333fb', 0, 10, true, 'f408d87b-d131-4266-aed8-fdfd6947f025', NULL);
INSERT INTO public.authentication_execution VALUES ('b3578e91-6e04-479b-b2ad-150099986162', NULL, 'registration-user-creation', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'f408d87b-d131-4266-aed8-fdfd6947f025', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('5a8e8583-2885-45df-b182-16ac6fbf4927', NULL, 'registration-password-action', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'f408d87b-d131-4266-aed8-fdfd6947f025', 0, 50, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('772db1ec-f0aa-4fb4-9006-13ae6af1b8af', NULL, 'registration-recaptcha-action', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'f408d87b-d131-4266-aed8-fdfd6947f025', 3, 60, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('35765b3d-ec36-4296-ab2f-bc58198d47cd', NULL, 'registration-terms-and-conditions', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'f408d87b-d131-4266-aed8-fdfd6947f025', 3, 70, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('342c601e-2761-4508-bf4a-8125a6db7c39', NULL, 'reset-credentials-choose-user', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'b83ee41f-7327-487b-a544-81e692ca44f5', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('9f253492-3481-487a-a73a-37f441581c63', NULL, 'reset-credential-email', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'b83ee41f-7327-487b-a544-81e692ca44f5', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('75d11b63-11d9-4d48-8164-f1e8b794731f', NULL, 'reset-password', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'b83ee41f-7327-487b-a544-81e692ca44f5', 0, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('157bc734-4fc7-4bdf-b07d-b73b0ae692c0', NULL, NULL, 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'b83ee41f-7327-487b-a544-81e692ca44f5', 1, 40, true, '222d018f-f1c2-4cc5-8eca-7317f2e157e4', NULL);
INSERT INTO public.authentication_execution VALUES ('996ca3bf-9f9e-4d8a-80c2-f27ffab0ed33', NULL, 'conditional-user-configured', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', '222d018f-f1c2-4cc5-8eca-7317f2e157e4', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('26cb19b5-406b-4170-9d57-df71dcef2079', NULL, 'reset-otp', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', '222d018f-f1c2-4cc5-8eca-7317f2e157e4', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('f83a5b13-3916-4024-8d51-f401883d339d', NULL, 'client-secret', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'd447ebb7-bbd3-4ba0-9a0d-8f4024afcea8', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('12495b04-1280-48f2-bae2-0034b082690f', NULL, 'client-jwt', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'd447ebb7-bbd3-4ba0-9a0d-8f4024afcea8', 2, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('840491d5-b5ae-459e-a45b-5cb285c180e8', NULL, 'client-secret-jwt', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'd447ebb7-bbd3-4ba0-9a0d-8f4024afcea8', 2, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('ee6c073c-92c6-4ea9-8880-bf9989c53ac5', NULL, 'client-x509', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'd447ebb7-bbd3-4ba0-9a0d-8f4024afcea8', 2, 40, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('1f81a96d-9067-4194-8fdf-9d6f023f5c58', NULL, 'idp-review-profile', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'f4735eca-dfe9-4da7-b86b-d2d5ed5d7674', 0, 10, false, NULL, 'dacac176-54c6-4b3e-9324-cace723342e8');
INSERT INTO public.authentication_execution VALUES ('67dd3213-31a6-42b6-a721-41756c598d1f', NULL, NULL, 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'f4735eca-dfe9-4da7-b86b-d2d5ed5d7674', 0, 20, true, 'b7783efd-af6e-4d96-9530-c71a1ce4e25a', NULL);
INSERT INTO public.authentication_execution VALUES ('65c7d066-f3e5-4e5f-b2f6-fe9a4cedc3a4', NULL, 'idp-create-user-if-unique', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'b7783efd-af6e-4d96-9530-c71a1ce4e25a', 2, 10, false, NULL, '87afbe03-3ad0-49fa-ad7c-732a57dd3815');
INSERT INTO public.authentication_execution VALUES ('d3e0c966-ab1a-4102-b1e2-5ff3bd00aadf', NULL, NULL, 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'b7783efd-af6e-4d96-9530-c71a1ce4e25a', 2, 20, true, '327953a8-5d27-4f26-a3a0-73039c8cfe26', NULL);
INSERT INTO public.authentication_execution VALUES ('824607a3-9255-432d-a621-c96cc42f94bb', NULL, 'idp-confirm-link', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', '327953a8-5d27-4f26-a3a0-73039c8cfe26', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('65f6798a-84bd-4034-847a-ffcfff407573', NULL, NULL, 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', '327953a8-5d27-4f26-a3a0-73039c8cfe26', 0, 20, true, '34d39a08-6e67-4f2a-9d79-4709557cfc51', NULL);
INSERT INTO public.authentication_execution VALUES ('95d6ecf4-0d74-491a-8f99-2ebb071fd3e8', NULL, 'idp-email-verification', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', '34d39a08-6e67-4f2a-9d79-4709557cfc51', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('1f94b9d2-38b1-4edf-b02f-dfbd68549a9f', NULL, NULL, 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', '34d39a08-6e67-4f2a-9d79-4709557cfc51', 2, 20, true, 'e6c3200a-1fb8-44bd-9d9f-4dc0bf90f73b', NULL);
INSERT INTO public.authentication_execution VALUES ('98eca1a6-35b4-4a0e-ac99-9eedace9e262', NULL, 'idp-username-password-form', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'e6c3200a-1fb8-44bd-9d9f-4dc0bf90f73b', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('c98fe48b-6d12-4ba1-8754-28ada0f769d2', NULL, NULL, 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'e6c3200a-1fb8-44bd-9d9f-4dc0bf90f73b', 1, 20, true, '4b946263-7c9b-4524-b2bd-cb1198ef30f3', NULL);
INSERT INTO public.authentication_execution VALUES ('5fd4123a-e19d-42e5-8eb2-6812c7a26492', NULL, 'conditional-user-configured', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', '4b946263-7c9b-4524-b2bd-cb1198ef30f3', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('e1914748-9234-4abf-a537-87c8b6d777f2', NULL, 'auth-otp-form', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', '4b946263-7c9b-4524-b2bd-cb1198ef30f3', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('3fb96d5f-6042-42cd-baaf-f72b336f880c', NULL, 'http-basic-authenticator', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', '154b0bef-1d5f-4d5e-bbcf-151e5a9fa867', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('19703e4d-fbc7-4d30-a84b-58b6f4dbeaf7', NULL, 'docker-http-basic-authenticator', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', '7fc9c0f0-5c43-4254-aa6f-fdeef2105b24', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('6ab34c5b-a0de-4297-a7e9-e85f084e8372', NULL, 'auth-cookie', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '1f75a619-c496-48bd-baaa-bcf6bd52f808', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('2afd84dd-ea37-4fc2-84d9-320d15c55606', NULL, 'auth-spnego', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '1f75a619-c496-48bd-baaa-bcf6bd52f808', 3, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('ca4be949-4038-4e3c-a96b-cfa714227681', NULL, 'identity-provider-redirector', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '1f75a619-c496-48bd-baaa-bcf6bd52f808', 2, 25, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('06f88028-d1b8-40ce-963e-cd25f8e36f41', NULL, NULL, '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '1f75a619-c496-48bd-baaa-bcf6bd52f808', 2, 30, true, '6da33d83-5588-4901-b60a-be780eb3dc2b', NULL);
INSERT INTO public.authentication_execution VALUES ('6e2144bb-d9cb-4f32-8a1e-cc16612d6781', NULL, 'auth-username-password-form', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '6da33d83-5588-4901-b60a-be780eb3dc2b', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('c6d9cbcb-2d62-4f19-b89c-8015f6170069', NULL, NULL, '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '6da33d83-5588-4901-b60a-be780eb3dc2b', 1, 20, true, '95162205-ddf5-4c05-ae35-592e7640249d', NULL);
INSERT INTO public.authentication_execution VALUES ('e0b3e953-f8f9-4609-bfb4-48ed3133a044', NULL, 'conditional-user-configured', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '95162205-ddf5-4c05-ae35-592e7640249d', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('3fa228dd-00aa-4760-9849-ce1ab835a29d', NULL, 'auth-otp-form', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '95162205-ddf5-4c05-ae35-592e7640249d', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('b73ffb5e-e922-4f66-bf32-0661879547b8', NULL, NULL, '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '1f75a619-c496-48bd-baaa-bcf6bd52f808', 2, 26, true, '5352521b-879e-4725-ab5b-617e7f261266', NULL);
INSERT INTO public.authentication_execution VALUES ('72e4d5a3-d130-4952-9b06-9a08b41a3a3a', NULL, NULL, '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '5352521b-879e-4725-ab5b-617e7f261266', 1, 10, true, '6495a6d4-35eb-43d5-af2f-e94cca3b80a3', NULL);
INSERT INTO public.authentication_execution VALUES ('c8c51de1-6fda-4106-b455-6e9a8c70d1c6', NULL, 'conditional-user-configured', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '6495a6d4-35eb-43d5-af2f-e94cca3b80a3', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('837924b9-e7b6-4bbf-80c9-6430f6635d03', NULL, 'organization', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '6495a6d4-35eb-43d5-af2f-e94cca3b80a3', 2, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('48e01572-9459-4abe-abc1-bb5ac0085340', NULL, 'direct-grant-validate-username', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'c90163ac-08f5-4bdb-a306-ad25df4e12a2', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('1a1478ce-b494-408f-9137-a78c8c8e9d56', NULL, 'direct-grant-validate-password', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'c90163ac-08f5-4bdb-a306-ad25df4e12a2', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('e5eac097-8693-4dd6-86d9-38ec393d8f8c', NULL, NULL, '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'c90163ac-08f5-4bdb-a306-ad25df4e12a2', 1, 30, true, 'eec4d384-13f2-497b-a7be-943027f8072b', NULL);
INSERT INTO public.authentication_execution VALUES ('7571f79c-b59b-4bb0-aeb3-57ed9f6de309', NULL, 'conditional-user-configured', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'eec4d384-13f2-497b-a7be-943027f8072b', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('560267c4-e438-4f22-a90d-d0bc4e8a14c8', NULL, 'direct-grant-validate-otp', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'eec4d384-13f2-497b-a7be-943027f8072b', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('29462415-dfda-40c1-a9e4-272c885c94ac', NULL, 'registration-page-form', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'cb4c3586-d6ab-44b5-83b3-3e1d27a4a009', 0, 10, true, '0d3bf78d-679b-4fb5-857c-a293b2b0a66e', NULL);
INSERT INTO public.authentication_execution VALUES ('579db617-b800-4f0c-b9fe-f182e7c3a9a5', NULL, 'registration-user-creation', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '0d3bf78d-679b-4fb5-857c-a293b2b0a66e', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('625c7cf9-56e0-438f-9908-d7e7a84a7336', NULL, 'registration-password-action', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '0d3bf78d-679b-4fb5-857c-a293b2b0a66e', 0, 50, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('3aa1695b-e916-411d-8d4c-db63830d6752', NULL, 'registration-recaptcha-action', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '0d3bf78d-679b-4fb5-857c-a293b2b0a66e', 3, 60, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('6ef30b7e-ab37-43fa-a095-d117cb488626', NULL, 'registration-terms-and-conditions', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '0d3bf78d-679b-4fb5-857c-a293b2b0a66e', 3, 70, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('b9295970-ec58-4b29-8879-404b9ec00031', NULL, 'reset-credentials-choose-user', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '984da793-7b39-417f-bb68-4046c898270f', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('b8630a06-862b-4bae-9876-a43c7dd065f1', NULL, 'reset-credential-email', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '984da793-7b39-417f-bb68-4046c898270f', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('b67768cf-c381-4566-b434-3d64cc770797', NULL, 'reset-password', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '984da793-7b39-417f-bb68-4046c898270f', 0, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('4332a662-0dac-4447-9dbe-5b901bd6c581', NULL, NULL, '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '984da793-7b39-417f-bb68-4046c898270f', 1, 40, true, 'b02c031a-1a0b-4bfd-84da-3fea44b90b44', NULL);
INSERT INTO public.authentication_execution VALUES ('aeb95364-d5d4-4ae4-a4b1-b09b4eef8ee2', NULL, 'conditional-user-configured', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'b02c031a-1a0b-4bfd-84da-3fea44b90b44', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('18faecaa-47a3-4adb-a523-8319f6e2eb92', NULL, 'reset-otp', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'b02c031a-1a0b-4bfd-84da-3fea44b90b44', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('2876d9f5-3b53-4b5f-bd33-b44de39f0295', NULL, 'client-secret', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'fc8f38f2-89f7-4e8b-88af-26abbc03cf0e', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('33fc24dd-e021-4769-a963-997cda0e0df1', NULL, 'client-jwt', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'fc8f38f2-89f7-4e8b-88af-26abbc03cf0e', 2, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('5763f0ff-ff8b-49ad-9c5c-0fcb3e2f40f7', NULL, 'client-secret-jwt', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'fc8f38f2-89f7-4e8b-88af-26abbc03cf0e', 2, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('fbfd5f20-d326-46af-b2c9-958b56f567d3', NULL, 'client-x509', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'fc8f38f2-89f7-4e8b-88af-26abbc03cf0e', 2, 40, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('76e2dc7c-a654-4e5f-af99-01eedcf78cfa', NULL, 'idp-review-profile', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'bbdc02d6-b1da-4058-b2b4-6ad6e04496bb', 0, 10, false, NULL, '9abf6975-deab-4ce6-8221-3f2ee13c9f63');
INSERT INTO public.authentication_execution VALUES ('9df27586-8417-427a-b883-c3f47ddddb4d', NULL, NULL, '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'bbdc02d6-b1da-4058-b2b4-6ad6e04496bb', 0, 20, true, 'ada42fe9-24ee-4c6f-bda8-a183d9a7b655', NULL);
INSERT INTO public.authentication_execution VALUES ('7b78bd3f-444e-40b5-b79d-e5e7867ed240', NULL, 'idp-create-user-if-unique', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'ada42fe9-24ee-4c6f-bda8-a183d9a7b655', 2, 10, false, NULL, 'd1e29f4e-6c41-48a9-84be-f17e881c5f4a');
INSERT INTO public.authentication_execution VALUES ('84d2d59e-bbe5-42bf-be2b-8b550666e725', NULL, NULL, '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'ada42fe9-24ee-4c6f-bda8-a183d9a7b655', 2, 20, true, '890e4d3c-bb5e-4551-a401-d3c1735b422f', NULL);
INSERT INTO public.authentication_execution VALUES ('195096c2-0b0d-42c7-bf19-bed91b125264', NULL, 'idp-confirm-link', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '890e4d3c-bb5e-4551-a401-d3c1735b422f', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('80e24e04-ab0d-4f1c-9eef-c1990b4883a5', NULL, NULL, '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '890e4d3c-bb5e-4551-a401-d3c1735b422f', 0, 20, true, '6f07e7c0-21dd-4911-83d3-868f14bc54eb', NULL);
INSERT INTO public.authentication_execution VALUES ('811ae317-9594-422d-ab71-6e126674ed79', NULL, 'idp-email-verification', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '6f07e7c0-21dd-4911-83d3-868f14bc54eb', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('6f8d0258-694e-4555-826f-983e9f489a0c', NULL, NULL, '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '6f07e7c0-21dd-4911-83d3-868f14bc54eb', 2, 20, true, 'f301bc9b-66d4-434e-ae39-4b565788c1ec', NULL);
INSERT INTO public.authentication_execution VALUES ('678cc3cf-9f9e-4f1e-a537-23a71cb60abe', NULL, 'idp-username-password-form', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'f301bc9b-66d4-434e-ae39-4b565788c1ec', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('2ab63df0-2e0d-4607-b660-064e84d7869e', NULL, NULL, '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'f301bc9b-66d4-434e-ae39-4b565788c1ec', 1, 20, true, 'd5a765be-ee30-468a-9069-61f97c51eac3', NULL);
INSERT INTO public.authentication_execution VALUES ('feb9e7a9-f523-40e0-b081-f3f94d01c499', NULL, 'conditional-user-configured', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'd5a765be-ee30-468a-9069-61f97c51eac3', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('744cc442-411f-4ddf-b0d0-cc5cead17170', NULL, 'auth-otp-form', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'd5a765be-ee30-468a-9069-61f97c51eac3', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('51dd2b81-1f5f-47fa-b79d-4340754e5f4f', NULL, NULL, '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'bbdc02d6-b1da-4058-b2b4-6ad6e04496bb', 1, 50, true, '6bcc9034-3e7f-4c28-b2df-e6eb49503ca7', NULL);
INSERT INTO public.authentication_execution VALUES ('bc09388a-e6e4-4aad-9aea-9aa1ee58b962', NULL, 'conditional-user-configured', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '6bcc9034-3e7f-4c28-b2df-e6eb49503ca7', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('2519c7ed-50a8-47b2-84cc-341e5ca31c7f', NULL, 'idp-add-organization-member', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '6bcc9034-3e7f-4c28-b2df-e6eb49503ca7', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('bbacabd0-f631-48b1-a4c3-c21d38e7e32f', NULL, 'http-basic-authenticator', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '278c4d74-c268-4966-9883-f794ee35ad40', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('28db78a5-872c-441f-8bed-fca1f804f3a4', NULL, 'docker-http-basic-authenticator', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'c3afb01b-377c-4d5d-8db2-58686713dce2', 0, 10, false, NULL, NULL);


--
-- TOC entry 4177 (class 0 OID 17094)
-- Dependencies: 263
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.authentication_flow VALUES ('de0e9104-6094-439a-b3dc-c90eebf4c477', 'browser', 'Browser based authentication', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('ccfbebba-e32b-43a3-b7b2-e387c5115ad1', 'forms', 'Username, password, otp and other auth forms.', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('44d06937-27e7-468d-be92-9fa4653869a5', 'Browser - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('2ecd7150-ae1b-44b5-a166-d0d73a76b64d', 'direct grant', 'OpenID Connect Resource Owner Grant', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('79dbabf2-8759-4423-9530-c148c156dc38', 'Direct Grant - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('2defe1c7-8639-4f73-8d2f-76df83b333fb', 'registration', 'Registration flow', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('f408d87b-d131-4266-aed8-fdfd6947f025', 'registration form', 'Registration form', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'form-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('b83ee41f-7327-487b-a544-81e692ca44f5', 'reset credentials', 'Reset credentials for a user if they forgot their password or something', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('222d018f-f1c2-4cc5-8eca-7317f2e157e4', 'Reset - Conditional OTP', 'Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('d447ebb7-bbd3-4ba0-9a0d-8f4024afcea8', 'clients', 'Base authentication for clients', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'client-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('f4735eca-dfe9-4da7-b86b-d2d5ed5d7674', 'first broker login', 'Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('b7783efd-af6e-4d96-9530-c71a1ce4e25a', 'User creation or linking', 'Flow for the existing/non-existing user alternatives', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('327953a8-5d27-4f26-a3a0-73039c8cfe26', 'Handle Existing Account', 'Handle what to do if there is existing account with same email/username like authenticated identity provider', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('34d39a08-6e67-4f2a-9d79-4709557cfc51', 'Account verification options', 'Method with which to verity the existing account', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('e6c3200a-1fb8-44bd-9d9f-4dc0bf90f73b', 'Verify Existing Account by Re-authentication', 'Reauthentication of existing account', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('4b946263-7c9b-4524-b2bd-cb1198ef30f3', 'First broker login - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('154b0bef-1d5f-4d5e-bbcf-151e5a9fa867', 'saml ecp', 'SAML ECP Profile Authentication Flow', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('7fc9c0f0-5c43-4254-aa6f-fdeef2105b24', 'docker auth', 'Used by Docker clients to authenticate against the IDP', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('1f75a619-c496-48bd-baaa-bcf6bd52f808', 'browser', 'Browser based authentication', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('6da33d83-5588-4901-b60a-be780eb3dc2b', 'forms', 'Username, password, otp and other auth forms.', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('95162205-ddf5-4c05-ae35-592e7640249d', 'Browser - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('5352521b-879e-4725-ab5b-617e7f261266', 'Organization', NULL, '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('6495a6d4-35eb-43d5-af2f-e94cca3b80a3', 'Browser - Conditional Organization', 'Flow to determine if the organization identity-first login is to be used', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('c90163ac-08f5-4bdb-a306-ad25df4e12a2', 'direct grant', 'OpenID Connect Resource Owner Grant', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('eec4d384-13f2-497b-a7be-943027f8072b', 'Direct Grant - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('cb4c3586-d6ab-44b5-83b3-3e1d27a4a009', 'registration', 'Registration flow', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('0d3bf78d-679b-4fb5-857c-a293b2b0a66e', 'registration form', 'Registration form', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'form-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('984da793-7b39-417f-bb68-4046c898270f', 'reset credentials', 'Reset credentials for a user if they forgot their password or something', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('b02c031a-1a0b-4bfd-84da-3fea44b90b44', 'Reset - Conditional OTP', 'Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('fc8f38f2-89f7-4e8b-88af-26abbc03cf0e', 'clients', 'Base authentication for clients', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'client-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('bbdc02d6-b1da-4058-b2b4-6ad6e04496bb', 'first broker login', 'Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('ada42fe9-24ee-4c6f-bda8-a183d9a7b655', 'User creation or linking', 'Flow for the existing/non-existing user alternatives', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('890e4d3c-bb5e-4551-a401-d3c1735b422f', 'Handle Existing Account', 'Handle what to do if there is existing account with same email/username like authenticated identity provider', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('6f07e7c0-21dd-4911-83d3-868f14bc54eb', 'Account verification options', 'Method with which to verity the existing account', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('f301bc9b-66d4-434e-ae39-4b565788c1ec', 'Verify Existing Account by Re-authentication', 'Reauthentication of existing account', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('d5a765be-ee30-468a-9069-61f97c51eac3', 'First broker login - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('6bcc9034-3e7f-4c28-b2df-e6eb49503ca7', 'First Broker Login - Conditional Organization', 'Flow to determine if the authenticator that adds organization members is to be used', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('278c4d74-c268-4966-9883-f794ee35ad40', 'saml ecp', 'SAML ECP Profile Authentication Flow', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('c3afb01b-377c-4d5d-8db2-58686713dce2', 'docker auth', 'Used by Docker clients to authenticate against the IDP', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'basic-flow', true, true);


--
-- TOC entry 4176 (class 0 OID 17089)
-- Dependencies: 262
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.authenticator_config VALUES ('dacac176-54c6-4b3e-9324-cace723342e8', 'review profile config', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e');
INSERT INTO public.authenticator_config VALUES ('87afbe03-3ad0-49fa-ad7c-732a57dd3815', 'create unique user config', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e');
INSERT INTO public.authenticator_config VALUES ('9abf6975-deab-4ce6-8221-3f2ee13c9f63', 'review profile config', '69cd0ddd-5526-4bfb-a3ae-e06de409092f');
INSERT INTO public.authenticator_config VALUES ('d1e29f4e-6c41-48a9-84be-f17e881c5f4a', 'create unique user config', '69cd0ddd-5526-4bfb-a3ae-e06de409092f');


--
-- TOC entry 4179 (class 0 OID 17104)
-- Dependencies: 265
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.authenticator_config_entry VALUES ('87afbe03-3ad0-49fa-ad7c-732a57dd3815', 'false', 'require.password.update.after.registration');
INSERT INTO public.authenticator_config_entry VALUES ('dacac176-54c6-4b3e-9324-cace723342e8', 'missing', 'update.profile.on.first.login');
INSERT INTO public.authenticator_config_entry VALUES ('9abf6975-deab-4ce6-8221-3f2ee13c9f63', 'missing', 'update.profile.on.first.login');
INSERT INTO public.authenticator_config_entry VALUES ('d1e29f4e-6c41-48a9-84be-f17e881c5f4a', 'false', 'require.password.update.after.registration');


--
-- TOC entry 4203 (class 0 OID 17542)
-- Dependencies: 289
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4143 (class 0 OID 16465)
-- Dependencies: 229
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.client VALUES ('179c4036-632c-4607-9dbe-ad5f232b7055', true, false, 'master-realm', 0, false, NULL, NULL, true, NULL, false, 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', NULL, 0, false, false, 'master Realm', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO public.client VALUES ('e4e8820d-84e9-4071-97ae-c32d108fa736', true, false, 'account', 0, true, NULL, '/realms/master/account/', false, NULL, false, 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'openid-connect', 0, false, false, '${client_account}', false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client VALUES ('37841806-a6d9-4b1d-a09b-93346087acb8', true, false, 'account-console', 0, true, NULL, '/realms/master/account/', false, NULL, false, 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'openid-connect', 0, false, false, '${client_account-console}', false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client VALUES ('cc52728e-30ff-4d7c-9439-d39e48d61982', true, false, 'broker', 0, false, NULL, NULL, true, NULL, false, 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'openid-connect', 0, false, false, '${client_broker}', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO public.client VALUES ('ac970ba9-a5aa-422d-8207-55d4ab698d1c', true, true, 'security-admin-console', 0, true, NULL, '/admin/master/console/', false, NULL, false, 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'openid-connect', 0, false, false, '${client_security-admin-console}', false, 'client-secret', '${authAdminUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client VALUES ('e67652de-4cbf-40a8-b007-9236d962db12', true, true, 'admin-cli', 0, true, NULL, NULL, false, NULL, false, 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'openid-connect', 0, false, false, '${client_admin-cli}', false, 'client-secret', NULL, NULL, NULL, false, false, true, false);
INSERT INTO public.client VALUES ('da3bb693-3bb8-4d95-97e4-cdf0427cdf45', true, false, 'dev-realm', 0, false, NULL, NULL, true, NULL, false, 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', NULL, 0, false, false, 'dev Realm', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO public.client VALUES ('98fbe1e0-e05c-4b1d-9657-655d6bbcff11', true, false, 'realm-management', 0, false, NULL, NULL, true, NULL, false, '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'openid-connect', 0, false, false, '${client_realm-management}', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO public.client VALUES ('a0701c28-b02f-4983-92b4-3f236ac1892c', true, false, 'account', 0, true, NULL, '/realms/dev/account/', false, NULL, false, '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'openid-connect', 0, false, false, '${client_account}', false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client VALUES ('48067444-f02b-4a4e-ae0e-709789381883', true, false, 'account-console', 0, true, NULL, '/realms/dev/account/', false, NULL, false, '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'openid-connect', 0, false, false, '${client_account-console}', false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client VALUES ('f49cc655-5b50-48b4-8ab7-aed5b0da236d', true, false, 'broker', 0, false, NULL, NULL, true, NULL, false, '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'openid-connect', 0, false, false, '${client_broker}', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO public.client VALUES ('369a0d1d-886a-40ee-b1af-dcd66219c391', true, true, 'security-admin-console', 0, true, NULL, '/admin/dev/console/', false, NULL, false, '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'openid-connect', 0, false, false, '${client_security-admin-console}', false, 'client-secret', '${authAdminUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client VALUES ('86560256-e24f-44a8-b7a8-8f7e53f42a5a', true, true, 'admin-cli', 0, true, NULL, NULL, false, NULL, false, '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'openid-connect', 0, false, false, '${client_admin-cli}', false, 'client-secret', NULL, NULL, NULL, false, false, true, false);
INSERT INTO public.client VALUES ('e2e94889-cf64-4b4c-aea4-1f85993cfde1', true, true, 'app', 0, false, 'qE4xp1Uhy60iwO8syd33EbaAF9rivXpJ', '', false, '', false, '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'openid-connect', -1, true, false, '', false, 'client-secret', '', '', NULL, true, false, false, false);


--
-- TOC entry 4162 (class 0 OID 16823)
-- Dependencies: 248
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.client_attributes VALUES ('e4e8820d-84e9-4071-97ae-c32d108fa736', 'post.logout.redirect.uris', '+');
INSERT INTO public.client_attributes VALUES ('37841806-a6d9-4b1d-a09b-93346087acb8', 'post.logout.redirect.uris', '+');
INSERT INTO public.client_attributes VALUES ('37841806-a6d9-4b1d-a09b-93346087acb8', 'pkce.code.challenge.method', 'S256');
INSERT INTO public.client_attributes VALUES ('ac970ba9-a5aa-422d-8207-55d4ab698d1c', 'post.logout.redirect.uris', '+');
INSERT INTO public.client_attributes VALUES ('ac970ba9-a5aa-422d-8207-55d4ab698d1c', 'pkce.code.challenge.method', 'S256');
INSERT INTO public.client_attributes VALUES ('ac970ba9-a5aa-422d-8207-55d4ab698d1c', 'client.use.lightweight.access.token.enabled', 'true');
INSERT INTO public.client_attributes VALUES ('e67652de-4cbf-40a8-b007-9236d962db12', 'client.use.lightweight.access.token.enabled', 'true');
INSERT INTO public.client_attributes VALUES ('a0701c28-b02f-4983-92b4-3f236ac1892c', 'post.logout.redirect.uris', '+');
INSERT INTO public.client_attributes VALUES ('48067444-f02b-4a4e-ae0e-709789381883', 'post.logout.redirect.uris', '+');
INSERT INTO public.client_attributes VALUES ('48067444-f02b-4a4e-ae0e-709789381883', 'pkce.code.challenge.method', 'S256');
INSERT INTO public.client_attributes VALUES ('369a0d1d-886a-40ee-b1af-dcd66219c391', 'post.logout.redirect.uris', '+');
INSERT INTO public.client_attributes VALUES ('369a0d1d-886a-40ee-b1af-dcd66219c391', 'pkce.code.challenge.method', 'S256');
INSERT INTO public.client_attributes VALUES ('369a0d1d-886a-40ee-b1af-dcd66219c391', 'client.use.lightweight.access.token.enabled', 'true');
INSERT INTO public.client_attributes VALUES ('86560256-e24f-44a8-b7a8-8f7e53f42a5a', 'client.use.lightweight.access.token.enabled', 'true');
INSERT INTO public.client_attributes VALUES ('e2e94889-cf64-4b4c-aea4-1f85993cfde1', 'client.secret.creation.time', '1750802818');
INSERT INTO public.client_attributes VALUES ('e2e94889-cf64-4b4c-aea4-1f85993cfde1', 'standard.token.exchange.enabled', 'false');
INSERT INTO public.client_attributes VALUES ('e2e94889-cf64-4b4c-aea4-1f85993cfde1', 'oauth2.device.authorization.grant.enabled', 'false');
INSERT INTO public.client_attributes VALUES ('e2e94889-cf64-4b4c-aea4-1f85993cfde1', 'oidc.ciba.grant.enabled', 'false');
INSERT INTO public.client_attributes VALUES ('e2e94889-cf64-4b4c-aea4-1f85993cfde1', 'backchannel.logout.session.required', 'true');
INSERT INTO public.client_attributes VALUES ('e2e94889-cf64-4b4c-aea4-1f85993cfde1', 'backchannel.logout.revoke.offline.tokens', 'false');
INSERT INTO public.client_attributes VALUES ('e2e94889-cf64-4b4c-aea4-1f85993cfde1', 'realm_client', 'false');
INSERT INTO public.client_attributes VALUES ('e2e94889-cf64-4b4c-aea4-1f85993cfde1', 'display.on.consent.screen', 'false');
INSERT INTO public.client_attributes VALUES ('e2e94889-cf64-4b4c-aea4-1f85993cfde1', 'frontchannel.logout.session.required', 'true');


--
-- TOC entry 4214 (class 0 OID 17791)
-- Dependencies: 300
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4213 (class 0 OID 17666)
-- Dependencies: 299
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4163 (class 0 OID 16833)
-- Dependencies: 249
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4191 (class 0 OID 17332)
-- Dependencies: 277
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.client_scope VALUES ('87aca32d-a3ee-4c42-836c-f49aefb46a67', 'offline_access', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'OpenID Connect built-in scope: offline_access', 'openid-connect');
INSERT INTO public.client_scope VALUES ('8c10808e-ded5-496d-ac25-02c270bd48d2', 'role_list', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'SAML role list', 'saml');
INSERT INTO public.client_scope VALUES ('b2616195-e18b-4c39-b8fa-f4086b5c2465', 'saml_organization', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'Organization Membership', 'saml');
INSERT INTO public.client_scope VALUES ('f2e21020-9113-4c7b-b5ec-75ad0901f583', 'profile', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'OpenID Connect built-in scope: profile', 'openid-connect');
INSERT INTO public.client_scope VALUES ('e4ded42f-cc10-46ab-b7cb-42305209f3e5', 'email', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'OpenID Connect built-in scope: email', 'openid-connect');
INSERT INTO public.client_scope VALUES ('f5f6b973-9f91-451c-8c91-159d5fc1e3f0', 'address', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'OpenID Connect built-in scope: address', 'openid-connect');
INSERT INTO public.client_scope VALUES ('3e0086dd-e3c2-46a0-9890-1c74fec6746f', 'phone', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'OpenID Connect built-in scope: phone', 'openid-connect');
INSERT INTO public.client_scope VALUES ('7270e881-a9b1-4e8e-b05f-6965d159420c', 'roles', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'OpenID Connect scope for add user roles to the access token', 'openid-connect');
INSERT INTO public.client_scope VALUES ('9eac3e21-f7cd-4963-b31d-08c936294e75', 'web-origins', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'OpenID Connect scope for add allowed web origins to the access token', 'openid-connect');
INSERT INTO public.client_scope VALUES ('9e449c32-17c2-4361-be3c-6489cb6fbaae', 'microprofile-jwt', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'Microprofile - JWT built-in scope', 'openid-connect');
INSERT INTO public.client_scope VALUES ('7555b05b-cdb5-4d18-bca5-14cb14fc54c4', 'acr', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'OpenID Connect scope for add acr (authentication context class reference) to the token', 'openid-connect');
INSERT INTO public.client_scope VALUES ('aa5be95f-8ac4-44fd-a6b1-91ce9dd00ddd', 'basic', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'OpenID Connect scope for add all basic claims to the token', 'openid-connect');
INSERT INTO public.client_scope VALUES ('2d78c4c5-cb4c-4c71-a5b4-539261af54b3', 'service_account', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'Specific scope for a client enabled for service accounts', 'openid-connect');
INSERT INTO public.client_scope VALUES ('a36b360e-22a9-4e2b-b414-f35f074bebb4', 'organization', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'Additional claims about the organization a subject belongs to', 'openid-connect');
INSERT INTO public.client_scope VALUES ('bad27911-d297-43c4-a6e3-1cfbafe21873', 'offline_access', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'OpenID Connect built-in scope: offline_access', 'openid-connect');
INSERT INTO public.client_scope VALUES ('1e0c365e-024c-449d-8b6b-99c45bb9a2e9', 'role_list', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'SAML role list', 'saml');
INSERT INTO public.client_scope VALUES ('9a3b06f7-6e59-425c-8f07-59063f01c31d', 'saml_organization', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'Organization Membership', 'saml');
INSERT INTO public.client_scope VALUES ('5af83cdc-79b9-4dff-8058-be30f7d9fe0b', 'profile', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'OpenID Connect built-in scope: profile', 'openid-connect');
INSERT INTO public.client_scope VALUES ('42f6a492-06ac-4d5f-baad-20a4277513fd', 'email', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'OpenID Connect built-in scope: email', 'openid-connect');
INSERT INTO public.client_scope VALUES ('45d8af74-2522-4235-937a-36ea8f116ca9', 'address', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'OpenID Connect built-in scope: address', 'openid-connect');
INSERT INTO public.client_scope VALUES ('73dec430-d7e6-4f6b-a545-77d6c36477a4', 'phone', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'OpenID Connect built-in scope: phone', 'openid-connect');
INSERT INTO public.client_scope VALUES ('76ca96ef-c1f1-4391-bf0f-7d517bc93493', 'roles', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'OpenID Connect scope for add user roles to the access token', 'openid-connect');
INSERT INTO public.client_scope VALUES ('88c5b77f-4dc5-4d59-8c4a-8d566a341731', 'web-origins', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'OpenID Connect scope for add allowed web origins to the access token', 'openid-connect');
INSERT INTO public.client_scope VALUES ('8cd41824-2347-429a-9835-6f7114b4de95', 'microprofile-jwt', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'Microprofile - JWT built-in scope', 'openid-connect');
INSERT INTO public.client_scope VALUES ('bb97193c-f940-4f56-a919-bb92b5c3494e', 'acr', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'OpenID Connect scope for add acr (authentication context class reference) to the token', 'openid-connect');
INSERT INTO public.client_scope VALUES ('74a6ef1b-e14f-4daa-8ff6-78fb96fb0dd3', 'basic', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'OpenID Connect scope for add all basic claims to the token', 'openid-connect');
INSERT INTO public.client_scope VALUES ('3fea0a17-f0e4-47bb-87ae-2afe092304da', 'service_account', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'Specific scope for a client enabled for service accounts', 'openid-connect');
INSERT INTO public.client_scope VALUES ('ce1df5dc-d996-4b71-8804-aa542da33570', 'organization', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'Additional claims about the organization a subject belongs to', 'openid-connect');


--
-- TOC entry 4192 (class 0 OID 17346)
-- Dependencies: 278
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.client_scope_attributes VALUES ('87aca32d-a3ee-4c42-836c-f49aefb46a67', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('87aca32d-a3ee-4c42-836c-f49aefb46a67', '${offlineAccessScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('8c10808e-ded5-496d-ac25-02c270bd48d2', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('8c10808e-ded5-496d-ac25-02c270bd48d2', '${samlRoleListScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('b2616195-e18b-4c39-b8fa-f4086b5c2465', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('f2e21020-9113-4c7b-b5ec-75ad0901f583', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('f2e21020-9113-4c7b-b5ec-75ad0901f583', '${profileScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('f2e21020-9113-4c7b-b5ec-75ad0901f583', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('e4ded42f-cc10-46ab-b7cb-42305209f3e5', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('e4ded42f-cc10-46ab-b7cb-42305209f3e5', '${emailScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('e4ded42f-cc10-46ab-b7cb-42305209f3e5', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('f5f6b973-9f91-451c-8c91-159d5fc1e3f0', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('f5f6b973-9f91-451c-8c91-159d5fc1e3f0', '${addressScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('f5f6b973-9f91-451c-8c91-159d5fc1e3f0', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('3e0086dd-e3c2-46a0-9890-1c74fec6746f', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('3e0086dd-e3c2-46a0-9890-1c74fec6746f', '${phoneScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('3e0086dd-e3c2-46a0-9890-1c74fec6746f', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('7270e881-a9b1-4e8e-b05f-6965d159420c', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('7270e881-a9b1-4e8e-b05f-6965d159420c', '${rolesScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('7270e881-a9b1-4e8e-b05f-6965d159420c', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('9eac3e21-f7cd-4963-b31d-08c936294e75', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('9eac3e21-f7cd-4963-b31d-08c936294e75', '', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('9eac3e21-f7cd-4963-b31d-08c936294e75', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('9e449c32-17c2-4361-be3c-6489cb6fbaae', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('9e449c32-17c2-4361-be3c-6489cb6fbaae', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('7555b05b-cdb5-4d18-bca5-14cb14fc54c4', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('7555b05b-cdb5-4d18-bca5-14cb14fc54c4', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('aa5be95f-8ac4-44fd-a6b1-91ce9dd00ddd', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('aa5be95f-8ac4-44fd-a6b1-91ce9dd00ddd', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('2d78c4c5-cb4c-4c71-a5b4-539261af54b3', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('2d78c4c5-cb4c-4c71-a5b4-539261af54b3', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('a36b360e-22a9-4e2b-b414-f35f074bebb4', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('a36b360e-22a9-4e2b-b414-f35f074bebb4', '${organizationScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('a36b360e-22a9-4e2b-b414-f35f074bebb4', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('bad27911-d297-43c4-a6e3-1cfbafe21873', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('bad27911-d297-43c4-a6e3-1cfbafe21873', '${offlineAccessScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('1e0c365e-024c-449d-8b6b-99c45bb9a2e9', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('1e0c365e-024c-449d-8b6b-99c45bb9a2e9', '${samlRoleListScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('9a3b06f7-6e59-425c-8f07-59063f01c31d', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('5af83cdc-79b9-4dff-8058-be30f7d9fe0b', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('5af83cdc-79b9-4dff-8058-be30f7d9fe0b', '${profileScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('5af83cdc-79b9-4dff-8058-be30f7d9fe0b', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('42f6a492-06ac-4d5f-baad-20a4277513fd', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('42f6a492-06ac-4d5f-baad-20a4277513fd', '${emailScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('42f6a492-06ac-4d5f-baad-20a4277513fd', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('45d8af74-2522-4235-937a-36ea8f116ca9', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('45d8af74-2522-4235-937a-36ea8f116ca9', '${addressScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('45d8af74-2522-4235-937a-36ea8f116ca9', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('73dec430-d7e6-4f6b-a545-77d6c36477a4', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('73dec430-d7e6-4f6b-a545-77d6c36477a4', '${phoneScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('73dec430-d7e6-4f6b-a545-77d6c36477a4', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('76ca96ef-c1f1-4391-bf0f-7d517bc93493', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('76ca96ef-c1f1-4391-bf0f-7d517bc93493', '${rolesScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('76ca96ef-c1f1-4391-bf0f-7d517bc93493', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('88c5b77f-4dc5-4d59-8c4a-8d566a341731', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('88c5b77f-4dc5-4d59-8c4a-8d566a341731', '', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('88c5b77f-4dc5-4d59-8c4a-8d566a341731', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('8cd41824-2347-429a-9835-6f7114b4de95', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('8cd41824-2347-429a-9835-6f7114b4de95', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('bb97193c-f940-4f56-a919-bb92b5c3494e', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('bb97193c-f940-4f56-a919-bb92b5c3494e', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('74a6ef1b-e14f-4daa-8ff6-78fb96fb0dd3', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('74a6ef1b-e14f-4daa-8ff6-78fb96fb0dd3', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('3fea0a17-f0e4-47bb-87ae-2afe092304da', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('3fea0a17-f0e4-47bb-87ae-2afe092304da', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('ce1df5dc-d996-4b71-8804-aa542da33570', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('ce1df5dc-d996-4b71-8804-aa542da33570', '${organizationScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('ce1df5dc-d996-4b71-8804-aa542da33570', 'true', 'include.in.token.scope');


--
-- TOC entry 4215 (class 0 OID 17832)
-- Dependencies: 301
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.client_scope_client VALUES ('e4e8820d-84e9-4071-97ae-c32d108fa736', '7270e881-a9b1-4e8e-b05f-6965d159420c', true);
INSERT INTO public.client_scope_client VALUES ('e4e8820d-84e9-4071-97ae-c32d108fa736', '9eac3e21-f7cd-4963-b31d-08c936294e75', true);
INSERT INTO public.client_scope_client VALUES ('e4e8820d-84e9-4071-97ae-c32d108fa736', '7555b05b-cdb5-4d18-bca5-14cb14fc54c4', true);
INSERT INTO public.client_scope_client VALUES ('e4e8820d-84e9-4071-97ae-c32d108fa736', 'aa5be95f-8ac4-44fd-a6b1-91ce9dd00ddd', true);
INSERT INTO public.client_scope_client VALUES ('e4e8820d-84e9-4071-97ae-c32d108fa736', 'e4ded42f-cc10-46ab-b7cb-42305209f3e5', true);
INSERT INTO public.client_scope_client VALUES ('e4e8820d-84e9-4071-97ae-c32d108fa736', 'f2e21020-9113-4c7b-b5ec-75ad0901f583', true);
INSERT INTO public.client_scope_client VALUES ('e4e8820d-84e9-4071-97ae-c32d108fa736', '9e449c32-17c2-4361-be3c-6489cb6fbaae', false);
INSERT INTO public.client_scope_client VALUES ('e4e8820d-84e9-4071-97ae-c32d108fa736', '87aca32d-a3ee-4c42-836c-f49aefb46a67', false);
INSERT INTO public.client_scope_client VALUES ('e4e8820d-84e9-4071-97ae-c32d108fa736', 'f5f6b973-9f91-451c-8c91-159d5fc1e3f0', false);
INSERT INTO public.client_scope_client VALUES ('e4e8820d-84e9-4071-97ae-c32d108fa736', 'a36b360e-22a9-4e2b-b414-f35f074bebb4', false);
INSERT INTO public.client_scope_client VALUES ('e4e8820d-84e9-4071-97ae-c32d108fa736', '3e0086dd-e3c2-46a0-9890-1c74fec6746f', false);
INSERT INTO public.client_scope_client VALUES ('37841806-a6d9-4b1d-a09b-93346087acb8', '7270e881-a9b1-4e8e-b05f-6965d159420c', true);
INSERT INTO public.client_scope_client VALUES ('37841806-a6d9-4b1d-a09b-93346087acb8', '9eac3e21-f7cd-4963-b31d-08c936294e75', true);
INSERT INTO public.client_scope_client VALUES ('37841806-a6d9-4b1d-a09b-93346087acb8', '7555b05b-cdb5-4d18-bca5-14cb14fc54c4', true);
INSERT INTO public.client_scope_client VALUES ('37841806-a6d9-4b1d-a09b-93346087acb8', 'aa5be95f-8ac4-44fd-a6b1-91ce9dd00ddd', true);
INSERT INTO public.client_scope_client VALUES ('37841806-a6d9-4b1d-a09b-93346087acb8', 'e4ded42f-cc10-46ab-b7cb-42305209f3e5', true);
INSERT INTO public.client_scope_client VALUES ('37841806-a6d9-4b1d-a09b-93346087acb8', 'f2e21020-9113-4c7b-b5ec-75ad0901f583', true);
INSERT INTO public.client_scope_client VALUES ('37841806-a6d9-4b1d-a09b-93346087acb8', '9e449c32-17c2-4361-be3c-6489cb6fbaae', false);
INSERT INTO public.client_scope_client VALUES ('37841806-a6d9-4b1d-a09b-93346087acb8', '87aca32d-a3ee-4c42-836c-f49aefb46a67', false);
INSERT INTO public.client_scope_client VALUES ('37841806-a6d9-4b1d-a09b-93346087acb8', 'f5f6b973-9f91-451c-8c91-159d5fc1e3f0', false);
INSERT INTO public.client_scope_client VALUES ('37841806-a6d9-4b1d-a09b-93346087acb8', 'a36b360e-22a9-4e2b-b414-f35f074bebb4', false);
INSERT INTO public.client_scope_client VALUES ('37841806-a6d9-4b1d-a09b-93346087acb8', '3e0086dd-e3c2-46a0-9890-1c74fec6746f', false);
INSERT INTO public.client_scope_client VALUES ('e67652de-4cbf-40a8-b007-9236d962db12', '7270e881-a9b1-4e8e-b05f-6965d159420c', true);
INSERT INTO public.client_scope_client VALUES ('e67652de-4cbf-40a8-b007-9236d962db12', '9eac3e21-f7cd-4963-b31d-08c936294e75', true);
INSERT INTO public.client_scope_client VALUES ('e67652de-4cbf-40a8-b007-9236d962db12', '7555b05b-cdb5-4d18-bca5-14cb14fc54c4', true);
INSERT INTO public.client_scope_client VALUES ('e67652de-4cbf-40a8-b007-9236d962db12', 'aa5be95f-8ac4-44fd-a6b1-91ce9dd00ddd', true);
INSERT INTO public.client_scope_client VALUES ('e67652de-4cbf-40a8-b007-9236d962db12', 'e4ded42f-cc10-46ab-b7cb-42305209f3e5', true);
INSERT INTO public.client_scope_client VALUES ('e67652de-4cbf-40a8-b007-9236d962db12', 'f2e21020-9113-4c7b-b5ec-75ad0901f583', true);
INSERT INTO public.client_scope_client VALUES ('e67652de-4cbf-40a8-b007-9236d962db12', '9e449c32-17c2-4361-be3c-6489cb6fbaae', false);
INSERT INTO public.client_scope_client VALUES ('e67652de-4cbf-40a8-b007-9236d962db12', '87aca32d-a3ee-4c42-836c-f49aefb46a67', false);
INSERT INTO public.client_scope_client VALUES ('e67652de-4cbf-40a8-b007-9236d962db12', 'f5f6b973-9f91-451c-8c91-159d5fc1e3f0', false);
INSERT INTO public.client_scope_client VALUES ('e67652de-4cbf-40a8-b007-9236d962db12', 'a36b360e-22a9-4e2b-b414-f35f074bebb4', false);
INSERT INTO public.client_scope_client VALUES ('e67652de-4cbf-40a8-b007-9236d962db12', '3e0086dd-e3c2-46a0-9890-1c74fec6746f', false);
INSERT INTO public.client_scope_client VALUES ('cc52728e-30ff-4d7c-9439-d39e48d61982', '7270e881-a9b1-4e8e-b05f-6965d159420c', true);
INSERT INTO public.client_scope_client VALUES ('cc52728e-30ff-4d7c-9439-d39e48d61982', '9eac3e21-f7cd-4963-b31d-08c936294e75', true);
INSERT INTO public.client_scope_client VALUES ('cc52728e-30ff-4d7c-9439-d39e48d61982', '7555b05b-cdb5-4d18-bca5-14cb14fc54c4', true);
INSERT INTO public.client_scope_client VALUES ('cc52728e-30ff-4d7c-9439-d39e48d61982', 'aa5be95f-8ac4-44fd-a6b1-91ce9dd00ddd', true);
INSERT INTO public.client_scope_client VALUES ('cc52728e-30ff-4d7c-9439-d39e48d61982', 'e4ded42f-cc10-46ab-b7cb-42305209f3e5', true);
INSERT INTO public.client_scope_client VALUES ('cc52728e-30ff-4d7c-9439-d39e48d61982', 'f2e21020-9113-4c7b-b5ec-75ad0901f583', true);
INSERT INTO public.client_scope_client VALUES ('cc52728e-30ff-4d7c-9439-d39e48d61982', '9e449c32-17c2-4361-be3c-6489cb6fbaae', false);
INSERT INTO public.client_scope_client VALUES ('cc52728e-30ff-4d7c-9439-d39e48d61982', '87aca32d-a3ee-4c42-836c-f49aefb46a67', false);
INSERT INTO public.client_scope_client VALUES ('cc52728e-30ff-4d7c-9439-d39e48d61982', 'f5f6b973-9f91-451c-8c91-159d5fc1e3f0', false);
INSERT INTO public.client_scope_client VALUES ('cc52728e-30ff-4d7c-9439-d39e48d61982', 'a36b360e-22a9-4e2b-b414-f35f074bebb4', false);
INSERT INTO public.client_scope_client VALUES ('cc52728e-30ff-4d7c-9439-d39e48d61982', '3e0086dd-e3c2-46a0-9890-1c74fec6746f', false);
INSERT INTO public.client_scope_client VALUES ('179c4036-632c-4607-9dbe-ad5f232b7055', '7270e881-a9b1-4e8e-b05f-6965d159420c', true);
INSERT INTO public.client_scope_client VALUES ('179c4036-632c-4607-9dbe-ad5f232b7055', '9eac3e21-f7cd-4963-b31d-08c936294e75', true);
INSERT INTO public.client_scope_client VALUES ('179c4036-632c-4607-9dbe-ad5f232b7055', '7555b05b-cdb5-4d18-bca5-14cb14fc54c4', true);
INSERT INTO public.client_scope_client VALUES ('179c4036-632c-4607-9dbe-ad5f232b7055', 'aa5be95f-8ac4-44fd-a6b1-91ce9dd00ddd', true);
INSERT INTO public.client_scope_client VALUES ('179c4036-632c-4607-9dbe-ad5f232b7055', 'e4ded42f-cc10-46ab-b7cb-42305209f3e5', true);
INSERT INTO public.client_scope_client VALUES ('179c4036-632c-4607-9dbe-ad5f232b7055', 'f2e21020-9113-4c7b-b5ec-75ad0901f583', true);
INSERT INTO public.client_scope_client VALUES ('179c4036-632c-4607-9dbe-ad5f232b7055', '9e449c32-17c2-4361-be3c-6489cb6fbaae', false);
INSERT INTO public.client_scope_client VALUES ('179c4036-632c-4607-9dbe-ad5f232b7055', '87aca32d-a3ee-4c42-836c-f49aefb46a67', false);
INSERT INTO public.client_scope_client VALUES ('179c4036-632c-4607-9dbe-ad5f232b7055', 'f5f6b973-9f91-451c-8c91-159d5fc1e3f0', false);
INSERT INTO public.client_scope_client VALUES ('179c4036-632c-4607-9dbe-ad5f232b7055', 'a36b360e-22a9-4e2b-b414-f35f074bebb4', false);
INSERT INTO public.client_scope_client VALUES ('179c4036-632c-4607-9dbe-ad5f232b7055', '3e0086dd-e3c2-46a0-9890-1c74fec6746f', false);
INSERT INTO public.client_scope_client VALUES ('ac970ba9-a5aa-422d-8207-55d4ab698d1c', '7270e881-a9b1-4e8e-b05f-6965d159420c', true);
INSERT INTO public.client_scope_client VALUES ('ac970ba9-a5aa-422d-8207-55d4ab698d1c', '9eac3e21-f7cd-4963-b31d-08c936294e75', true);
INSERT INTO public.client_scope_client VALUES ('ac970ba9-a5aa-422d-8207-55d4ab698d1c', '7555b05b-cdb5-4d18-bca5-14cb14fc54c4', true);
INSERT INTO public.client_scope_client VALUES ('ac970ba9-a5aa-422d-8207-55d4ab698d1c', 'aa5be95f-8ac4-44fd-a6b1-91ce9dd00ddd', true);
INSERT INTO public.client_scope_client VALUES ('ac970ba9-a5aa-422d-8207-55d4ab698d1c', 'e4ded42f-cc10-46ab-b7cb-42305209f3e5', true);
INSERT INTO public.client_scope_client VALUES ('ac970ba9-a5aa-422d-8207-55d4ab698d1c', 'f2e21020-9113-4c7b-b5ec-75ad0901f583', true);
INSERT INTO public.client_scope_client VALUES ('ac970ba9-a5aa-422d-8207-55d4ab698d1c', '9e449c32-17c2-4361-be3c-6489cb6fbaae', false);
INSERT INTO public.client_scope_client VALUES ('ac970ba9-a5aa-422d-8207-55d4ab698d1c', '87aca32d-a3ee-4c42-836c-f49aefb46a67', false);
INSERT INTO public.client_scope_client VALUES ('ac970ba9-a5aa-422d-8207-55d4ab698d1c', 'f5f6b973-9f91-451c-8c91-159d5fc1e3f0', false);
INSERT INTO public.client_scope_client VALUES ('ac970ba9-a5aa-422d-8207-55d4ab698d1c', 'a36b360e-22a9-4e2b-b414-f35f074bebb4', false);
INSERT INTO public.client_scope_client VALUES ('ac970ba9-a5aa-422d-8207-55d4ab698d1c', '3e0086dd-e3c2-46a0-9890-1c74fec6746f', false);
INSERT INTO public.client_scope_client VALUES ('a0701c28-b02f-4983-92b4-3f236ac1892c', '88c5b77f-4dc5-4d59-8c4a-8d566a341731', true);
INSERT INTO public.client_scope_client VALUES ('a0701c28-b02f-4983-92b4-3f236ac1892c', '42f6a492-06ac-4d5f-baad-20a4277513fd', true);
INSERT INTO public.client_scope_client VALUES ('a0701c28-b02f-4983-92b4-3f236ac1892c', '74a6ef1b-e14f-4daa-8ff6-78fb96fb0dd3', true);
INSERT INTO public.client_scope_client VALUES ('a0701c28-b02f-4983-92b4-3f236ac1892c', '5af83cdc-79b9-4dff-8058-be30f7d9fe0b', true);
INSERT INTO public.client_scope_client VALUES ('a0701c28-b02f-4983-92b4-3f236ac1892c', '76ca96ef-c1f1-4391-bf0f-7d517bc93493', true);
INSERT INTO public.client_scope_client VALUES ('a0701c28-b02f-4983-92b4-3f236ac1892c', 'bb97193c-f940-4f56-a919-bb92b5c3494e', true);
INSERT INTO public.client_scope_client VALUES ('a0701c28-b02f-4983-92b4-3f236ac1892c', '8cd41824-2347-429a-9835-6f7114b4de95', false);
INSERT INTO public.client_scope_client VALUES ('a0701c28-b02f-4983-92b4-3f236ac1892c', 'ce1df5dc-d996-4b71-8804-aa542da33570', false);
INSERT INTO public.client_scope_client VALUES ('a0701c28-b02f-4983-92b4-3f236ac1892c', 'bad27911-d297-43c4-a6e3-1cfbafe21873', false);
INSERT INTO public.client_scope_client VALUES ('a0701c28-b02f-4983-92b4-3f236ac1892c', '45d8af74-2522-4235-937a-36ea8f116ca9', false);
INSERT INTO public.client_scope_client VALUES ('a0701c28-b02f-4983-92b4-3f236ac1892c', '73dec430-d7e6-4f6b-a545-77d6c36477a4', false);
INSERT INTO public.client_scope_client VALUES ('48067444-f02b-4a4e-ae0e-709789381883', '88c5b77f-4dc5-4d59-8c4a-8d566a341731', true);
INSERT INTO public.client_scope_client VALUES ('48067444-f02b-4a4e-ae0e-709789381883', '42f6a492-06ac-4d5f-baad-20a4277513fd', true);
INSERT INTO public.client_scope_client VALUES ('48067444-f02b-4a4e-ae0e-709789381883', '74a6ef1b-e14f-4daa-8ff6-78fb96fb0dd3', true);
INSERT INTO public.client_scope_client VALUES ('48067444-f02b-4a4e-ae0e-709789381883', '5af83cdc-79b9-4dff-8058-be30f7d9fe0b', true);
INSERT INTO public.client_scope_client VALUES ('48067444-f02b-4a4e-ae0e-709789381883', '76ca96ef-c1f1-4391-bf0f-7d517bc93493', true);
INSERT INTO public.client_scope_client VALUES ('48067444-f02b-4a4e-ae0e-709789381883', 'bb97193c-f940-4f56-a919-bb92b5c3494e', true);
INSERT INTO public.client_scope_client VALUES ('48067444-f02b-4a4e-ae0e-709789381883', '8cd41824-2347-429a-9835-6f7114b4de95', false);
INSERT INTO public.client_scope_client VALUES ('48067444-f02b-4a4e-ae0e-709789381883', 'ce1df5dc-d996-4b71-8804-aa542da33570', false);
INSERT INTO public.client_scope_client VALUES ('48067444-f02b-4a4e-ae0e-709789381883', 'bad27911-d297-43c4-a6e3-1cfbafe21873', false);
INSERT INTO public.client_scope_client VALUES ('48067444-f02b-4a4e-ae0e-709789381883', '45d8af74-2522-4235-937a-36ea8f116ca9', false);
INSERT INTO public.client_scope_client VALUES ('48067444-f02b-4a4e-ae0e-709789381883', '73dec430-d7e6-4f6b-a545-77d6c36477a4', false);
INSERT INTO public.client_scope_client VALUES ('86560256-e24f-44a8-b7a8-8f7e53f42a5a', '88c5b77f-4dc5-4d59-8c4a-8d566a341731', true);
INSERT INTO public.client_scope_client VALUES ('86560256-e24f-44a8-b7a8-8f7e53f42a5a', '42f6a492-06ac-4d5f-baad-20a4277513fd', true);
INSERT INTO public.client_scope_client VALUES ('86560256-e24f-44a8-b7a8-8f7e53f42a5a', '74a6ef1b-e14f-4daa-8ff6-78fb96fb0dd3', true);
INSERT INTO public.client_scope_client VALUES ('86560256-e24f-44a8-b7a8-8f7e53f42a5a', '5af83cdc-79b9-4dff-8058-be30f7d9fe0b', true);
INSERT INTO public.client_scope_client VALUES ('86560256-e24f-44a8-b7a8-8f7e53f42a5a', '76ca96ef-c1f1-4391-bf0f-7d517bc93493', true);
INSERT INTO public.client_scope_client VALUES ('86560256-e24f-44a8-b7a8-8f7e53f42a5a', 'bb97193c-f940-4f56-a919-bb92b5c3494e', true);
INSERT INTO public.client_scope_client VALUES ('86560256-e24f-44a8-b7a8-8f7e53f42a5a', '8cd41824-2347-429a-9835-6f7114b4de95', false);
INSERT INTO public.client_scope_client VALUES ('86560256-e24f-44a8-b7a8-8f7e53f42a5a', 'ce1df5dc-d996-4b71-8804-aa542da33570', false);
INSERT INTO public.client_scope_client VALUES ('86560256-e24f-44a8-b7a8-8f7e53f42a5a', 'bad27911-d297-43c4-a6e3-1cfbafe21873', false);
INSERT INTO public.client_scope_client VALUES ('86560256-e24f-44a8-b7a8-8f7e53f42a5a', '45d8af74-2522-4235-937a-36ea8f116ca9', false);
INSERT INTO public.client_scope_client VALUES ('86560256-e24f-44a8-b7a8-8f7e53f42a5a', '73dec430-d7e6-4f6b-a545-77d6c36477a4', false);
INSERT INTO public.client_scope_client VALUES ('f49cc655-5b50-48b4-8ab7-aed5b0da236d', '88c5b77f-4dc5-4d59-8c4a-8d566a341731', true);
INSERT INTO public.client_scope_client VALUES ('f49cc655-5b50-48b4-8ab7-aed5b0da236d', '42f6a492-06ac-4d5f-baad-20a4277513fd', true);
INSERT INTO public.client_scope_client VALUES ('f49cc655-5b50-48b4-8ab7-aed5b0da236d', '74a6ef1b-e14f-4daa-8ff6-78fb96fb0dd3', true);
INSERT INTO public.client_scope_client VALUES ('f49cc655-5b50-48b4-8ab7-aed5b0da236d', '5af83cdc-79b9-4dff-8058-be30f7d9fe0b', true);
INSERT INTO public.client_scope_client VALUES ('f49cc655-5b50-48b4-8ab7-aed5b0da236d', '76ca96ef-c1f1-4391-bf0f-7d517bc93493', true);
INSERT INTO public.client_scope_client VALUES ('f49cc655-5b50-48b4-8ab7-aed5b0da236d', 'bb97193c-f940-4f56-a919-bb92b5c3494e', true);
INSERT INTO public.client_scope_client VALUES ('f49cc655-5b50-48b4-8ab7-aed5b0da236d', '8cd41824-2347-429a-9835-6f7114b4de95', false);
INSERT INTO public.client_scope_client VALUES ('f49cc655-5b50-48b4-8ab7-aed5b0da236d', 'ce1df5dc-d996-4b71-8804-aa542da33570', false);
INSERT INTO public.client_scope_client VALUES ('f49cc655-5b50-48b4-8ab7-aed5b0da236d', 'bad27911-d297-43c4-a6e3-1cfbafe21873', false);
INSERT INTO public.client_scope_client VALUES ('f49cc655-5b50-48b4-8ab7-aed5b0da236d', '45d8af74-2522-4235-937a-36ea8f116ca9', false);
INSERT INTO public.client_scope_client VALUES ('f49cc655-5b50-48b4-8ab7-aed5b0da236d', '73dec430-d7e6-4f6b-a545-77d6c36477a4', false);
INSERT INTO public.client_scope_client VALUES ('98fbe1e0-e05c-4b1d-9657-655d6bbcff11', '88c5b77f-4dc5-4d59-8c4a-8d566a341731', true);
INSERT INTO public.client_scope_client VALUES ('98fbe1e0-e05c-4b1d-9657-655d6bbcff11', '42f6a492-06ac-4d5f-baad-20a4277513fd', true);
INSERT INTO public.client_scope_client VALUES ('98fbe1e0-e05c-4b1d-9657-655d6bbcff11', '74a6ef1b-e14f-4daa-8ff6-78fb96fb0dd3', true);
INSERT INTO public.client_scope_client VALUES ('98fbe1e0-e05c-4b1d-9657-655d6bbcff11', '5af83cdc-79b9-4dff-8058-be30f7d9fe0b', true);
INSERT INTO public.client_scope_client VALUES ('98fbe1e0-e05c-4b1d-9657-655d6bbcff11', '76ca96ef-c1f1-4391-bf0f-7d517bc93493', true);
INSERT INTO public.client_scope_client VALUES ('98fbe1e0-e05c-4b1d-9657-655d6bbcff11', 'bb97193c-f940-4f56-a919-bb92b5c3494e', true);
INSERT INTO public.client_scope_client VALUES ('98fbe1e0-e05c-4b1d-9657-655d6bbcff11', '8cd41824-2347-429a-9835-6f7114b4de95', false);
INSERT INTO public.client_scope_client VALUES ('98fbe1e0-e05c-4b1d-9657-655d6bbcff11', 'ce1df5dc-d996-4b71-8804-aa542da33570', false);
INSERT INTO public.client_scope_client VALUES ('98fbe1e0-e05c-4b1d-9657-655d6bbcff11', 'bad27911-d297-43c4-a6e3-1cfbafe21873', false);
INSERT INTO public.client_scope_client VALUES ('98fbe1e0-e05c-4b1d-9657-655d6bbcff11', '45d8af74-2522-4235-937a-36ea8f116ca9', false);
INSERT INTO public.client_scope_client VALUES ('98fbe1e0-e05c-4b1d-9657-655d6bbcff11', '73dec430-d7e6-4f6b-a545-77d6c36477a4', false);
INSERT INTO public.client_scope_client VALUES ('369a0d1d-886a-40ee-b1af-dcd66219c391', '88c5b77f-4dc5-4d59-8c4a-8d566a341731', true);
INSERT INTO public.client_scope_client VALUES ('369a0d1d-886a-40ee-b1af-dcd66219c391', '42f6a492-06ac-4d5f-baad-20a4277513fd', true);
INSERT INTO public.client_scope_client VALUES ('369a0d1d-886a-40ee-b1af-dcd66219c391', '74a6ef1b-e14f-4daa-8ff6-78fb96fb0dd3', true);
INSERT INTO public.client_scope_client VALUES ('369a0d1d-886a-40ee-b1af-dcd66219c391', '5af83cdc-79b9-4dff-8058-be30f7d9fe0b', true);
INSERT INTO public.client_scope_client VALUES ('369a0d1d-886a-40ee-b1af-dcd66219c391', '76ca96ef-c1f1-4391-bf0f-7d517bc93493', true);
INSERT INTO public.client_scope_client VALUES ('369a0d1d-886a-40ee-b1af-dcd66219c391', 'bb97193c-f940-4f56-a919-bb92b5c3494e', true);
INSERT INTO public.client_scope_client VALUES ('369a0d1d-886a-40ee-b1af-dcd66219c391', '8cd41824-2347-429a-9835-6f7114b4de95', false);
INSERT INTO public.client_scope_client VALUES ('369a0d1d-886a-40ee-b1af-dcd66219c391', 'ce1df5dc-d996-4b71-8804-aa542da33570', false);
INSERT INTO public.client_scope_client VALUES ('369a0d1d-886a-40ee-b1af-dcd66219c391', 'bad27911-d297-43c4-a6e3-1cfbafe21873', false);
INSERT INTO public.client_scope_client VALUES ('369a0d1d-886a-40ee-b1af-dcd66219c391', '45d8af74-2522-4235-937a-36ea8f116ca9', false);
INSERT INTO public.client_scope_client VALUES ('369a0d1d-886a-40ee-b1af-dcd66219c391', '73dec430-d7e6-4f6b-a545-77d6c36477a4', false);
INSERT INTO public.client_scope_client VALUES ('e2e94889-cf64-4b4c-aea4-1f85993cfde1', '88c5b77f-4dc5-4d59-8c4a-8d566a341731', true);
INSERT INTO public.client_scope_client VALUES ('e2e94889-cf64-4b4c-aea4-1f85993cfde1', '42f6a492-06ac-4d5f-baad-20a4277513fd', true);
INSERT INTO public.client_scope_client VALUES ('e2e94889-cf64-4b4c-aea4-1f85993cfde1', '74a6ef1b-e14f-4daa-8ff6-78fb96fb0dd3', true);
INSERT INTO public.client_scope_client VALUES ('e2e94889-cf64-4b4c-aea4-1f85993cfde1', '5af83cdc-79b9-4dff-8058-be30f7d9fe0b', true);
INSERT INTO public.client_scope_client VALUES ('e2e94889-cf64-4b4c-aea4-1f85993cfde1', '76ca96ef-c1f1-4391-bf0f-7d517bc93493', true);
INSERT INTO public.client_scope_client VALUES ('e2e94889-cf64-4b4c-aea4-1f85993cfde1', 'bb97193c-f940-4f56-a919-bb92b5c3494e', true);
INSERT INTO public.client_scope_client VALUES ('e2e94889-cf64-4b4c-aea4-1f85993cfde1', '8cd41824-2347-429a-9835-6f7114b4de95', false);
INSERT INTO public.client_scope_client VALUES ('e2e94889-cf64-4b4c-aea4-1f85993cfde1', 'ce1df5dc-d996-4b71-8804-aa542da33570', false);
INSERT INTO public.client_scope_client VALUES ('e2e94889-cf64-4b4c-aea4-1f85993cfde1', 'bad27911-d297-43c4-a6e3-1cfbafe21873', false);
INSERT INTO public.client_scope_client VALUES ('e2e94889-cf64-4b4c-aea4-1f85993cfde1', '45d8af74-2522-4235-937a-36ea8f116ca9', false);
INSERT INTO public.client_scope_client VALUES ('e2e94889-cf64-4b4c-aea4-1f85993cfde1', '73dec430-d7e6-4f6b-a545-77d6c36477a4', false);


--
-- TOC entry 4193 (class 0 OID 17351)
-- Dependencies: 279
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.client_scope_role_mapping VALUES ('87aca32d-a3ee-4c42-836c-f49aefb46a67', 'f06a2fc4-1bfd-45d9-b477-3a5394250b8b');
INSERT INTO public.client_scope_role_mapping VALUES ('bad27911-d297-43c4-a6e3-1cfbafe21873', '18088f05-b3a0-4ffe-8616-5d7613ebc772');


--
-- TOC entry 4211 (class 0 OID 17587)
-- Dependencies: 297
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.component VALUES ('e0c1d22e-e8bf-4490-a921-7e2687204161', 'Trusted Hosts', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'trusted-hosts', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'anonymous');
INSERT INTO public.component VALUES ('cc86b289-4560-414f-82f4-19b1baa85355', 'Consent Required', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'consent-required', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'anonymous');
INSERT INTO public.component VALUES ('1edb2bdb-62aa-4fea-b545-8c5dda6530cb', 'Full Scope Disabled', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'scope', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'anonymous');
INSERT INTO public.component VALUES ('6b8752ba-f527-43da-84cf-48518d4cc53e', 'Max Clients Limit', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'max-clients', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'anonymous');
INSERT INTO public.component VALUES ('95a15034-070c-4581-bc6e-7c2b1a1e87c6', 'Allowed Protocol Mapper Types', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'anonymous');
INSERT INTO public.component VALUES ('1b60992c-cbef-47b1-b1fb-d822799c74b4', 'Allowed Client Scopes', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'anonymous');
INSERT INTO public.component VALUES ('22b845cd-c170-4994-851e-6fc71c808753', 'Allowed Protocol Mapper Types', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'authenticated');
INSERT INTO public.component VALUES ('378e7ca5-f6e1-4a87-8bab-fd53b571946c', 'Allowed Client Scopes', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'authenticated');
INSERT INTO public.component VALUES ('46de3aca-c110-4389-b421-a8fa3ec20ec7', 'rsa-generated', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'rsa-generated', 'org.keycloak.keys.KeyProvider', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', NULL);
INSERT INTO public.component VALUES ('f2b8a405-8019-4e9f-b695-c95cd75c36a6', 'rsa-enc-generated', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'rsa-enc-generated', 'org.keycloak.keys.KeyProvider', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', NULL);
INSERT INTO public.component VALUES ('f38eeddf-4313-4ede-b875-869077ae35ee', 'hmac-generated-hs512', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'hmac-generated', 'org.keycloak.keys.KeyProvider', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', NULL);
INSERT INTO public.component VALUES ('9901ce24-fa89-4c0c-9525-e9cbc204c038', 'aes-generated', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'aes-generated', 'org.keycloak.keys.KeyProvider', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', NULL);
INSERT INTO public.component VALUES ('df7f6bf4-4406-4776-be2d-efe514575a0f', NULL, 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'declarative-user-profile', 'org.keycloak.userprofile.UserProfileProvider', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', NULL);
INSERT INTO public.component VALUES ('814cc8f5-039a-40ad-9cb1-acc61f005a39', 'rsa-generated', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'rsa-generated', 'org.keycloak.keys.KeyProvider', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', NULL);
INSERT INTO public.component VALUES ('d50e1dc6-9492-40f0-b1b0-de2fec832f38', 'rsa-enc-generated', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'rsa-enc-generated', 'org.keycloak.keys.KeyProvider', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', NULL);
INSERT INTO public.component VALUES ('4f9b5450-e63c-40c9-860a-4be1a483731c', 'hmac-generated-hs512', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'hmac-generated', 'org.keycloak.keys.KeyProvider', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', NULL);
INSERT INTO public.component VALUES ('36afaa0d-b6cb-420f-ba7d-01b5a9db99c7', 'aes-generated', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'aes-generated', 'org.keycloak.keys.KeyProvider', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', NULL);
INSERT INTO public.component VALUES ('c05c8e63-9132-4457-be84-c348720048c0', 'Trusted Hosts', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'trusted-hosts', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'anonymous');
INSERT INTO public.component VALUES ('46059c55-7668-4df5-8cd2-983f2f26fe6a', 'Consent Required', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'consent-required', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'anonymous');
INSERT INTO public.component VALUES ('6674cb0d-dec6-45b4-b09d-fcbca1bb32d1', 'Full Scope Disabled', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'scope', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'anonymous');
INSERT INTO public.component VALUES ('e620cf95-7da1-4795-af25-3725c16c7a43', 'Max Clients Limit', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'max-clients', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'anonymous');
INSERT INTO public.component VALUES ('ea9fb46f-1d49-4771-ad85-57a385891373', 'Allowed Protocol Mapper Types', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'anonymous');
INSERT INTO public.component VALUES ('c56b21b2-36a0-4627-be92-9d2943aa0efa', 'Allowed Client Scopes', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'anonymous');
INSERT INTO public.component VALUES ('dfe95ad3-cc2b-4699-84e8-2f1ae3544190', 'Allowed Protocol Mapper Types', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'authenticated');
INSERT INTO public.component VALUES ('a7f780e4-8ebf-440a-a118-626443c243d6', 'Allowed Client Scopes', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'authenticated');


--
-- TOC entry 4210 (class 0 OID 17582)
-- Dependencies: 296
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.component_config VALUES ('e6047064-b825-43f6-8e7b-0cd149096a21', '22b845cd-c170-4994-851e-6fc71c808753', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO public.component_config VALUES ('0289b563-fb6c-449e-a729-1de6cd5b6c0b', '22b845cd-c170-4994-851e-6fc71c808753', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO public.component_config VALUES ('53fe1b2d-cd56-4de5-817f-ed3e442cc566', '22b845cd-c170-4994-851e-6fc71c808753', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO public.component_config VALUES ('d8d84a50-a1ee-4044-923b-97c912bd268d', '22b845cd-c170-4994-851e-6fc71c808753', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO public.component_config VALUES ('3341d2b7-75ea-4f0b-8b8b-e0170a50edac', '22b845cd-c170-4994-851e-6fc71c808753', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO public.component_config VALUES ('42db2eaf-5bd1-4d1f-959a-5e2c821c3a00', '22b845cd-c170-4994-851e-6fc71c808753', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO public.component_config VALUES ('d568c1ac-d01b-4806-9996-ffd62348378c', '22b845cd-c170-4994-851e-6fc71c808753', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO public.component_config VALUES ('3ff6f049-db78-4b60-81e5-5d77630b33d9', '22b845cd-c170-4994-851e-6fc71c808753', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO public.component_config VALUES ('0b31a4b6-2185-4a4c-b635-feddc0ac6eff', '95a15034-070c-4581-bc6e-7c2b1a1e87c6', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO public.component_config VALUES ('a97a70ba-6be1-4210-ac3f-63cbfae8f680', '95a15034-070c-4581-bc6e-7c2b1a1e87c6', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO public.component_config VALUES ('7f3d7556-44a4-4d75-84c6-46ab6853acc5', '95a15034-070c-4581-bc6e-7c2b1a1e87c6', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO public.component_config VALUES ('564e06c2-c320-4d82-8ba7-c9c78b9d5fe4', '95a15034-070c-4581-bc6e-7c2b1a1e87c6', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO public.component_config VALUES ('6141e452-f12c-47bc-aa78-602bfccef293', '95a15034-070c-4581-bc6e-7c2b1a1e87c6', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO public.component_config VALUES ('dc450dc6-97a9-47c6-a77a-08126da99ac3', '95a15034-070c-4581-bc6e-7c2b1a1e87c6', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO public.component_config VALUES ('05243003-9758-4b40-a08b-923214bd87b4', '95a15034-070c-4581-bc6e-7c2b1a1e87c6', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO public.component_config VALUES ('9deaef07-21d2-4091-a048-d63fb8e29d6b', '95a15034-070c-4581-bc6e-7c2b1a1e87c6', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO public.component_config VALUES ('ef9756f3-6641-4c19-a84a-dc2d09a154b2', 'e0c1d22e-e8bf-4490-a921-7e2687204161', 'host-sending-registration-request-must-match', 'true');
INSERT INTO public.component_config VALUES ('e189be0a-5b3b-44a2-8603-9feebf617a6a', 'e0c1d22e-e8bf-4490-a921-7e2687204161', 'client-uris-must-match', 'true');
INSERT INTO public.component_config VALUES ('26d0b57f-0b9c-400b-91b0-cee0df66bbc2', '1b60992c-cbef-47b1-b1fb-d822799c74b4', 'allow-default-scopes', 'true');
INSERT INTO public.component_config VALUES ('1104ec96-0eb4-47cf-98de-b23e0d8cb0e6', '6b8752ba-f527-43da-84cf-48518d4cc53e', 'max-clients', '200');
INSERT INTO public.component_config VALUES ('6873b02b-9b83-4c35-b183-b0e45d8b3280', '378e7ca5-f6e1-4a87-8bab-fd53b571946c', 'allow-default-scopes', 'true');
INSERT INTO public.component_config VALUES ('335f52ff-b2eb-4efe-a2ee-2e654c7e1594', 'f2b8a405-8019-4e9f-b695-c95cd75c36a6', 'keyUse', 'ENC');
INSERT INTO public.component_config VALUES ('a2a7f014-c137-4347-8e8c-86cb6189478d', 'f2b8a405-8019-4e9f-b695-c95cd75c36a6', 'algorithm', 'RSA-OAEP');
INSERT INTO public.component_config VALUES ('d2d1bf8c-7083-426a-9709-e8b798339578', 'f2b8a405-8019-4e9f-b695-c95cd75c36a6', 'certificate', 'MIICmzCCAYMCBgGXo/QfwzANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUwNjI0MjE1NzU0WhcNMzUwNjI0MjE1OTM0WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCUqRL2zQWdijTafCR3+akVvtsKV2ihm+OT9tcbLNEigZXj8dCisEQ42BfUaXpcs4T9Zm0yHcITnirRcQzYB9TUzT+/cCL2x55BcaCZ3AUHDYwBK0nPEj5NkSK/spLuMrq13SuEAMpzNmR0lf3YdpWx0IEvvYveJqQMi7ZfMEnQHb/YS+X6MWvgtWHsOF1A/+EGxahT4ZywNkkdqs3cZ5ISG5KXk45dPpZJ9QcX7MPUna/uawFIImpWj5b9Z0gjoTHKDcX3hIyHkzsjLc3iPepnu9aguakUC8MgAG+3xzgRZ/dq6d8NjqIhbp5bFoveW/Byn00hAe7l8eKH54VnjuWVAgMBAAEwDQYJKoZIhvcNAQELBQADggEBABqUESMFSTA3O8+9QeEL3dzN8CH+EgsCddbPSLQYtFMv96YgsV3HFLAsnG0U5Ac52R7A5SkwQNFVzTXl6oW0IWuAuuKxD0ALxu+RUs2/AMMSXDJo0ioPOuh6NrLLBhhtoZgheDU0CpwDp530942af9rCEAyfzjrg1wko019Rn76A6uMVkDaew5NFEGIPJKmF3Qq6i0jveF8gGfY2jqQESODo2vEhHyx6NxvpIfV1zpWihRNW6iVaiDAZJpNFjJEOIy3/zChafhcapWS8wl0LOfK5Fbnb+Hro+A7PgKxxxPqD1JkwbzFkYUS+9Q5j4P7Sh48u17yAb0VwAtEU4ZhJWo8=');
INSERT INTO public.component_config VALUES ('d24271ad-c809-45ce-a555-49955c399132', 'f2b8a405-8019-4e9f-b695-c95cd75c36a6', 'privateKey', 'MIIEowIBAAKCAQEAlKkS9s0FnYo02nwkd/mpFb7bCldooZvjk/bXGyzRIoGV4/HQorBEONgX1Gl6XLOE/WZtMh3CE54q0XEM2AfU1M0/v3Ai9seeQXGgmdwFBw2MAStJzxI+TZEiv7KS7jK6td0rhADKczZkdJX92HaVsdCBL72L3iakDIu2XzBJ0B2/2Evl+jFr4LVh7DhdQP/hBsWoU+GcsDZJHarN3GeSEhuSl5OOXT6WSfUHF+zD1J2v7msBSCJqVo+W/WdII6Exyg3F94SMh5M7Iy3N4j3qZ7vWoLmpFAvDIABvt8c4EWf3aunfDY6iIW6eWxaL3lvwcp9NIQHu5fHih+eFZ47llQIDAQABAoIBAAHAtkwZywa6WgIKCqybdfjDzuNYwVijBy/BAJkibW1mTFCP3AzjlSgN2es4OpXTOcDoQYtXlZ+BTlaCIScRM//snCyFhc9xEs2blzlQC4MhWQusMo+Wm+gEy1jOazQ4olRdLspO74HbZQlAAupXvwYYH2b1aZl7FkvLknx5Hkf3KvDO8GdKmMkOpHtoKLHy0eVYWTUaZwi8lkHpMdt6d01JRqgkEbr7LR5fFXtk3B5EdNcNjLv/mfz6O95RQRm9a6bQP8wU8I9czNy3FO1PkhN0HjAlUsGxSWh1wLdPaYUk7SXB8blPbGemduMhKOmIdinWGxkRKMzKGTkZBjxQpPUCgYEAyzlqj02uCJaFjSFx1zi1Ser1GmnFbLzdhnVHOehjctL1IDMWSjXwSbIRDJpo94S7XTeljuz49KfZZZXjKoQc2Yh1zue3HbAT9/6K0AfSPcQnjNu4+0rmDESipcWoDsb6yw3wOmUXLg8V2nqPqe5xDIsQe1Ilwq12PZguW5IpH38CgYEAu0Qw+Dl1HdTcEgTTFEQuPqTwaac43siLl9mOM/wMqqn38RhJV5a/hfafWnTJrLOmy6iuIwqLe0PFMymFunjFh0VFUQSsO3wg3LIGjCJ6pN58gYejMKTU/F8rnBBGW7NZDoJJeAmhbvusHzayUPocfxc5IR7m6b2y95oGJrEvBOsCgYAZfU4cQ0X81cRSe0toDzjN2KZ9dZ7JkLbIUpVocflnQYZ1T3MQQ8ursqXoysU3pnJJst0VHCvto8/kqfQgNQnZTwBXv0B8fMVEaazHgvOfw6aiSDzfZ/mKuGEeIbh+gf6a0Vi8Okm6ATJggNbcHYgYZqjejuMlk9QszZWi7qYxyQKBgQC1yejPztdGclCAnXZbAiTyYyOPLOokOwJoEqXdCR0yv3UV8sGf6ZNa9KKVKTJuGKgepE0Hb0EgFBXnKLPM5Vi7jB9SGvsnc8Ri+d8pQn9UdTbgd0+P9TNdGvY2tgXXFy+oygmQIak5F89rLanEukfXiC/JWzpGRgTqH/dAsFg4qQKBgHR8M54uX+EpjaoodNZ7hT/Ue/aSURxKzFvluX87nYhtni7yRH9yAR5xvtoQWduTPNbF7AlNpM0fgMF3ytLAtLiCZIHHOQC6Kjq8sriUmc2T40txI5PpCy4Vib8gUKe7Ay7oCG/ztBuW1giWBD2/OqyHHhel3btGzyyVjwxJwktv');
INSERT INTO public.component_config VALUES ('71ae9885-e45b-4fac-9ff1-c67ccb7a63c2', 'f2b8a405-8019-4e9f-b695-c95cd75c36a6', 'priority', '100');
INSERT INTO public.component_config VALUES ('cba8734f-62dd-47e7-9174-7f6f9cd03ebb', '9901ce24-fa89-4c0c-9525-e9cbc204c038', 'secret', 'oO5-dLYMRO-mtz-9ZZHySA');
INSERT INTO public.component_config VALUES ('902482f2-e81d-4861-a17f-79616a7e8dc4', '9901ce24-fa89-4c0c-9525-e9cbc204c038', 'kid', 'c44fef07-0778-43dc-bf1d-3f2909f90775');
INSERT INTO public.component_config VALUES ('d8b98be4-eae0-4c8e-a253-705ba73428e2', '9901ce24-fa89-4c0c-9525-e9cbc204c038', 'priority', '100');
INSERT INTO public.component_config VALUES ('62cacc93-13c7-4d7d-bb99-e973d59d2a54', '46de3aca-c110-4389-b421-a8fa3ec20ec7', 'privateKey', 'MIIEpAIBAAKCAQEAvUWTPLfXxm51gtZha3STCMLcRj2v4y9vOtIxfqE12EWHdH005Q5z5Za5UpNuI4FkOO7Gm8OTTJuwL0K/CAhwYBYStKig7tkCoCMQSj6CGLs6sf9tEMS32iMCr8G42eOm4Viwcf5ZYgGZ+A1Il5ufF6jygj1rRFdW9S80+jP+uvegv2IMOypli3ZgxVl5NETrPrnFmDCEqdFYXMMYc33sBMeAexVZgohhN3gGwe3dUJcv78jUsJe2sD40tTiu+9LfaVFT3tDpHOw0wvineNCzBXui2mbW7IYCPU++TiooUfVFPKPwxBfds90uawwJLd75WhaFM7IG/xJMjJkcND/suQIDAQABAoIBAAkigX+ts8lM7Xj6FcuU3b/Pf8gYFBQX5vtkx6S/7RRaDraNkG75qphLFPiqSueFyCuDQqyj3MkWvoMZapTdq2bHyfFULig46wqFhrS+nZLJ/oQ2urHTfLgXdnq7E8vYU+aOXD20M+YqA59YLMe8aApBSisFAddTi8vbkmf8+G9XjO6356Lwp7w5GnzfiGb+l0wq0ZtBtqGI/2FcatQfDCSYbHBEYruBMOd3d2FSkNvHbEhfZmpRgbHopd2kfvQw50aT0qcyIoW8q5otnX+tdXG8Md9sPyru/Ua9s1J3z7B7uDugwZClaPrABbFKh1o8WccNYDK7o+SjinjeV1iTpz0CgYEA6Xg0y3u2HF0pVBmVh3ysKw2bTffKfGGXQ0xZlgEgt1ikTvNEKiDOQBZlv8oDHEABIVkUCGGxKQW4zc6GdBGwU/CavCiP7etvWoUR/4GBUdicpRuYEc/XRbR5FWjKw3wib9/M25CxnvCnQ9mFpLLv+mB6Mz5kjMm1spHRLJ6cPucCgYEAz4l584wywQ6Bmam9hym3e5PupwyAwBE4eGydSwsE4iWTh5cg03KRYrcD9scysQL3VjvCkwdHWf7UFv52ShMuUtvFTeWeUrH/iVF4SSqgd6jk2a3NLzRNmLOnyvTSETRniRfNhEsI4CK2+RyOB4EHHSGpVJ7Lmwu5v+fGtFidI18CgYEAlEnvbpdDEjzx9SLS4N2FFUttK1aJ2/q4ctxZwncw6oN4yVSmJQP1PKt9MRYEZ7sXfLDxkmlKdz3VJZNZvvtFPeuCvKQe1wVFEv+WcO020F9/Dze5nQagOvvoNHr83rFHxjsmCQecadF8zBGrWvL0jdkdhNLKVsn/iE4px+duYl0CgYEApKJlWLvOA3JTgyexDwkb4e+PcXsso7DFgFqBSOeb3x558yUDSFnpVUrj3R9Wai91MDZF+0bZ5l2NuBPymH6wz9BBq7LMrsM/eJpldn1XQLV9neUPETRHnixenlUqU7WjsJBuW1T+3HcNeX6aeP91OjnazyMNV5isqLzf1284cLcCgYBE1WftI+4msSPNZgAVsmxjnAbbEZ6avNuMe7USN2sGy7q2e9/fsf7YesJmSaDSzLPgmhgq4bgxTJuAMdwaMwwOXqAz0+N51dMqj/z7AWW2PwBzHtPCbBs9YjLhOPpPnFVALDYD7xTuNreRQdBsSiHYYwD0TuiqElgBP6QQw0an7g==');
INSERT INTO public.component_config VALUES ('313a6ba5-1305-4418-93ae-c3e790a451a7', '46de3aca-c110-4389-b421-a8fa3ec20ec7', 'priority', '100');
INSERT INTO public.component_config VALUES ('8b5d086e-0d05-45b2-8e3c-c7591bb4dfd7', '46de3aca-c110-4389-b421-a8fa3ec20ec7', 'keyUse', 'SIG');
INSERT INTO public.component_config VALUES ('7e058442-0cf8-42b2-b58a-b13715dc8813', '46de3aca-c110-4389-b421-a8fa3ec20ec7', 'certificate', 'MIICmzCCAYMCBgGXo/QfFDANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUwNjI0MjE1NzU0WhcNMzUwNjI0MjE1OTM0WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC9RZM8t9fGbnWC1mFrdJMIwtxGPa/jL2860jF+oTXYRYd0fTTlDnPllrlSk24jgWQ47sabw5NMm7AvQr8ICHBgFhK0qKDu2QKgIxBKPoIYuzqx/20QxLfaIwKvwbjZ46bhWLBx/lliAZn4DUiXm58XqPKCPWtEV1b1LzT6M/6696C/Ygw7KmWLdmDFWXk0ROs+ucWYMISp0VhcwxhzfewEx4B7FVmCiGE3eAbB7d1Qly/vyNSwl7awPjS1OK770t9pUVPe0Okc7DTC+Kd40LMFe6LaZtbshgI9T75OKihR9UU8o/DEF92z3S5rDAkt3vlaFoUzsgb/EkyMmRw0P+y5AgMBAAEwDQYJKoZIhvcNAQELBQADggEBAJbv4tzObZfB9iYgFgXQV1hQABxcmojT+Y1FiYeSv1nQvTyISr2nt93Rt75o1QjSKI6rM9WwY8BB+8+WhnkgOmXQrQvo/4NWzcIlN+SMNIqLBlr9OmZTT0RTuzlwoXHR8sMsrmkVrxupKalFkGfDAVAUgKzxozG+d0FrXFxfu2VVLqUb7/anbEusK2GnxkZYCihBpSNSL36hg+lG9mUgKHVlm0kdbkWJHLqf2dNgVJfCC6XypxAiIzyW5ZAFvag4RvGaPPphQMbSYr4o3x1uwM5JBHN9D+KpZzGwx9LBQ1/1FTlJLQj8L+V3Q3Ya7Bwsc4wAPp6v6qm2vB/mdL7ZNuM=');
INSERT INTO public.component_config VALUES ('0abcae91-346b-49ae-8de8-1bb373b1ccd3', 'f38eeddf-4313-4ede-b875-869077ae35ee', 'secret', 'yS8WbBFaGj82WKq1f8fnSUzd_FyJimcie57x0X49lysL2pQHsY5Q7oTTBdbyhBQdH5j2x2g1XA_FJf8lHDA8NCjQFb1N20H06hFhOlyz4BgQt7wmQkJwECxR5uEQ_hpDJkG4m4lkLNDoe82dZPS7S4ivsCDXC_-o3l1ebbL8E3s');
INSERT INTO public.component_config VALUES ('8919319a-290d-4366-bafc-f54dda0b6b0a', 'f38eeddf-4313-4ede-b875-869077ae35ee', 'priority', '100');
INSERT INTO public.component_config VALUES ('b44ebb9b-c804-4036-b313-8fce98b1338c', 'f38eeddf-4313-4ede-b875-869077ae35ee', 'algorithm', 'HS512');
INSERT INTO public.component_config VALUES ('d4eb6c3e-c9bf-4914-92b4-0990b82651d5', 'f38eeddf-4313-4ede-b875-869077ae35ee', 'kid', '59d77610-b0c0-4243-a94a-30bd316f3a61');
INSERT INTO public.component_config VALUES ('84465f75-d054-4b90-a858-a1cfff5417ae', 'df7f6bf4-4406-4776-be2d-efe514575a0f', 'kc.user.profile.config', '{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}]}');
INSERT INTO public.component_config VALUES ('a02c0f85-4c82-476c-9dc4-53b2d293c942', '814cc8f5-039a-40ad-9cb1-acc61f005a39', 'priority', '100');
INSERT INTO public.component_config VALUES ('b485469a-b5f0-41f1-ab16-bbf5a51c9f26', '814cc8f5-039a-40ad-9cb1-acc61f005a39', 'keyUse', 'SIG');
INSERT INTO public.component_config VALUES ('94813733-9e9e-411b-8dc1-cf9a7fd3feee', '814cc8f5-039a-40ad-9cb1-acc61f005a39', 'certificate', 'MIIClTCCAX0CBgGXo/neFDANBgkqhkiG9w0BAQsFADAOMQwwCgYDVQQDDANkZXYwHhcNMjUwNjI0MjIwNDEwWhcNMzUwNjI0MjIwNTUwWjAOMQwwCgYDVQQDDANkZXYwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDY1m9plj9skAjK1TGD4v92xgi8Dkjj9zncxJhc8Jv4MzcamKfQfym6WoFDZnUCCd0D/Pb5NGNGVBOMvZVJl/RpFYG2UKby31xDfkRev1oJMtrS30S7p51aH5nE/KWAJ3TYUQkMvIxJf9+K9ypNBVGl10XCo0MuGq4kBTioe/p0PDV9I1KV8o2EviSTnrwPJdft6HqBwShxv+PWSGrQESJGZQkoZuCAQxzqdulA2BzbVPk8BSpPTU/N5Gk3SbNqucO+ofEpSHiWQE4BNOG1N11wqJbCn1waHh5yd7r9iYVz1TrWhArInHm91n2cQGHgirF6Q/qlkUnqn56JGWPM+4HXAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAFr1BSyFEiX9yI33RpqNlDQNvOb+gVMzLOmKLKon/1lMMSqRs/5LGLIgTRoKK1m7FZMYL3does5drE8z/1LPooOP16T2u1y6I3AoPdhIlfJZPuz6pAgc5ljnW93PVqgLM6WT8bhfoeqQtfpxe6VbR24i/Z469fZtkw8nDPVm8TkD9ZvPsNEBtBXoHuJdqY/liad0CaBLdLBwh0OJdHrpdOfn7VLc7dEb3agSMet6GROBgcBDGNPSyHMs5xPxDzJV5qUoY63+Rl88zlV+oz8TE9zaJCoU7NFVBtGOw6mCFDGKetB2cyKjv1k70e6fmu7WruzpnhMza9BSyUU0ULnDI2o=');
INSERT INTO public.component_config VALUES ('3de1e923-96fb-4db5-94a2-c9e9fb8e1334', '814cc8f5-039a-40ad-9cb1-acc61f005a39', 'privateKey', 'MIIEpQIBAAKCAQEA2NZvaZY/bJAIytUxg+L/dsYIvA5I4/c53MSYXPCb+DM3Gpin0H8pulqBQ2Z1AgndA/z2+TRjRlQTjL2VSZf0aRWBtlCm8t9cQ35EXr9aCTLa0t9Eu6edWh+ZxPylgCd02FEJDLyMSX/fivcqTQVRpddFwqNDLhquJAU4qHv6dDw1fSNSlfKNhL4kk568DyXX7eh6gcEocb/j1khq0BEiRmUJKGbggEMc6nbpQNgc21T5PAUqT01PzeRpN0mzarnDvqHxKUh4lkBOATThtTddcKiWwp9cGh4ecne6/YmFc9U61oQKyJx5vdZ9nEBh4IqxekP6pZFJ6p+eiRljzPuB1wIDAQABAoIBABEwNlatVUu6wyeo7KritJNqsUiO7VI8x7ZrUxSS8hojnSubjDnnypv+Dp8UIRRPSdjGFaG9eF0bzwzp/kp+JB6sWMLl88Xu1LZ47NyB2JZAFL6AekdRyxRYyuylhkz5U7bN/aSn0YsF+udeHllKoaU+wkXigTHHZaRvUYVxhnHuKoPoJejfn1eavDYw5bQdhgTsChlBkgVtWg7/J5LCzexIzq2og0qRuzgHK6qU/N0DH3PHCVVVqVPHxQNahGTq6iWYrtVC+V5aKShAGg41krN6KSDMZQ1jXzeA6+oJNNYYyvKnayL1SSCv4KAsokOuTa5/C4lub0YN9+Pvjr3X0qkCgYEA82YTcNG+i8dpopfelrxhsu9CcmOox2YgFQgEG5NFODrHZTyRF2o3NFhkufu4xr3M857xJlTXQTikYo34FzAWWOxJk9F4/fval/B2J5+CdryCNP6n3EkaVfLXmGiC84c9sw1WQx8vx1WmOuLm480zb6+TNkTGUS/aGQKNR2ks9SMCgYEA5BBT2HOoC9SV6K7F0Wbo5j3emh05evdBBaKYjA0HA6pnPTPezk449YroER+8whVzTV4TnaicQ6JBOAgzzzXkdhTHz4XxvtZXvYkRy3bzY+rBxn33Tz0oz4COFCVOX+RU2tjILb9hwL+O9TT5xc8cpbzbV3/KS9Z0NyD2hLElTb0CgYEAiOyvmxQjYXb5EiLlcV7gh0zZ0IgH9sSY37v2s5yRoCRQ77620LlL/QKNB6N4OzWjCporhyjLP0GiGF9NZZ4DtFqYubNpoVgBjOAVWAz/09QQW8e2ntHxItDOQErrABzgtM2X7YKp2jVwokfrI9PYT8gxxKHD/wAwbUlmOPoN9IkCgYEAoJr+8MdB6FLk3t91X2nhSYL4Z/98oyPMHnPKiZYDAonV+ju1BAQCCKixlJ2NCACjGjDOD5DVuqtg0ly0X4/MO3uW2oWxIHtBfrAwX+B8tjh0DZxXtO2U98vIQlejQdRCDXvsPIsyA9LikbukybB4tB6zOIM9qvpzDP+hmwBFDOECgYEAmIsIOOnqkI1l7B20iYaoxQLklrAqi0YRFedmdDXJGkSojSp1/RtpHspVqOcLHbkQy2KoNWgipD5vEmt7MtGMCKFWPmSd1NmUnckZhkczqEzm86gStLJm0w9kxZN1fWytdg0TL2v2c877zKKUBEXh3y6yTauzQ/c39fvffLDe5+c=');
INSERT INTO public.component_config VALUES ('cd699fcb-2a85-498c-adbd-d29c5f81e293', '36afaa0d-b6cb-420f-ba7d-01b5a9db99c7', 'secret', '630NicTp8sxNi4Qfui5_sQ');
INSERT INTO public.component_config VALUES ('6b6513ad-4df0-41a2-ab3f-42d1f587b5f6', '36afaa0d-b6cb-420f-ba7d-01b5a9db99c7', 'priority', '100');
INSERT INTO public.component_config VALUES ('e6e55b7e-0342-43b4-b4f2-6ebb9c09665d', '36afaa0d-b6cb-420f-ba7d-01b5a9db99c7', 'kid', '60e74e6a-667b-4549-b0e7-9668369dabfd');
INSERT INTO public.component_config VALUES ('d8e2f523-09e8-436d-8274-d172670dc128', 'd50e1dc6-9492-40f0-b1b0-de2fec832f38', 'privateKey', 'MIIEoAIBAAKCAQEAu5dWUjJfe8goSiO/IlMlgWzPwVX7tniKEyStoqlMz1QeXQd+MKx8AQqgOn2OHxNqtU3szFG/2qlzOQWjz7P+2fAXLRIMd/kS9sf9g/nocj6vpBYlUzjHMnMRypRZQpBREqf+JNdSM9xPXEwip+5lRTqztNWB8StiNMZoytX8Y0CCEZyQm4U8jcPqvNS/BIblYHdAlMIN+e+U4svPxo4uPc/IZjiMFac/JwMJyWRh8ddPfQKyq8/Y1zQrxFJDxOKTnTdLqVqQtpIqlr5Ja/doUumFbq0Ob1nT50djgFPAURQ0G2lg/hkP6q2xt5ZiieKWu9WnmCZpyicwWfh9QrK2WQIDAQABAoH/IqUhTaJGFX9vnB0fgGmm7L68mckJAZlpF355T+suc5v+pCaeHPSBHQuOrYfhKd8kiEhCFoxd+U753tKwZqcuWV3kJtHRkQd82SANObisWGDvNvKQ3NJqTOh2mRZcCmd1PFCiuSH46X+dkCad/NyeO/64X3gVNskHz3dheIJGmQeZ02FVatGV2MFf/FdY6r+Rv8vnrr78djEYB6NJVKlCHkk2tnacwGqlvIfRdUEQQhJuQIM1Q74DI3/Hxs5pnhqru3Adn6hdGGSZum1ybC8oA9qjTfpYxKZWTesbS+wdzRdsY4k0PVPdenNQUayRCE8WNBzFSsq/8KeMyutVKboxAoGBAOFF/LLl1Oa+k6SsqNnzDDdWQiviYXgAxfqf+Atz8E7qmUL5aIWbwf4g+KSXIXOXq5uJScms2tir1oO1Cxz30Lzr7kFIx/y4dryMBm6ZMzK0JduJIr75m7rpcc2MUHkA9PZVOevtmGnQeM1OwtXgNvGt61OnXOV0uJfh2lYzAZ0RAoGBANUtk3cG42e0I+PPoz4jjsz+ZX4i6TphRIDrz0AX/AyLeMrawZEXmYucv/BkwqMgW7v+2+byhxS7b16x03yOpZjLk2mB/zp5k0NbsDwQ3y1rJAo9/u+IlWbREdqIwcaSAHBR9bbuv3IBreFOfwSyFHRqqF1J0hawYwPB/lcW2CTJAoGAM+9Tq9bKt4u2NB/OKbkb1uIfDUj6mZTsD7Szlchb3YW+Ya9oRm07UyA80o05HBIacRg8l68vIQa0xNaHQl1rlTJ7Uje6S2wni55omTTeldDsbWl3Rjn7iiLppq6zmsH6t5O8b8Tt/28deo+u4Wn4oM0s1LNf+lJngDSEhpzpwVECgYA7sfeJbTRg5eDm+k4MKIjkfpiNKdmFr5cvQtlWaWD7YlMA+yEZMDKfFdXpy011wKnviv6pPWD2PUaCjelbB9b3Yop1ESIXjdPfGN3Q9CiK32XIOHQbP3QWxpTpTUJ2CIx253yXLWQO2MmIPiLzfaqcrwFWnkVmdR5E/x3p5UvBgQKBgEAvK8TnSVHT58lxL1W7Q5EDYMImidxgrJoVrmI1lhBNjypNnfaV56ITsvBIrN0XWKvCO8zfpYqp7dyyuskhYwseQNytnJ6iOe/q82SjMf0QZ/KyBUdF29OVfT98cB8eKLB8HwxBfG30az3Dq/IY+5PhH+8u4u+hs/GUSI68PPAQ');
INSERT INTO public.component_config VALUES ('a21f2cff-e2fa-4d59-b85a-d69828b5e679', 'd50e1dc6-9492-40f0-b1b0-de2fec832f38', 'priority', '100');
INSERT INTO public.component_config VALUES ('517acf6e-8482-4421-9853-828bd612c753', 'd50e1dc6-9492-40f0-b1b0-de2fec832f38', 'keyUse', 'ENC');
INSERT INTO public.component_config VALUES ('8996c87a-6415-4019-be7d-084024079300', 'd50e1dc6-9492-40f0-b1b0-de2fec832f38', 'algorithm', 'RSA-OAEP');
INSERT INTO public.component_config VALUES ('720599b0-71f7-4796-be73-c15a90646979', 'd50e1dc6-9492-40f0-b1b0-de2fec832f38', 'certificate', 'MIIClTCCAX0CBgGXo/ne9TANBgkqhkiG9w0BAQsFADAOMQwwCgYDVQQDDANkZXYwHhcNMjUwNjI0MjIwNDExWhcNMzUwNjI0MjIwNTUxWjAOMQwwCgYDVQQDDANkZXYwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC7l1ZSMl97yChKI78iUyWBbM/BVfu2eIoTJK2iqUzPVB5dB34wrHwBCqA6fY4fE2q1TezMUb/aqXM5BaPPs/7Z8BctEgx3+RL2x/2D+ehyPq+kFiVTOMcycxHKlFlCkFESp/4k11Iz3E9cTCKn7mVFOrO01YHxK2I0xmjK1fxjQIIRnJCbhTyNw+q81L8EhuVgd0CUwg3575Tiy8/Gji49z8hmOIwVpz8nAwnJZGHx1099ArKrz9jXNCvEUkPE4pOdN0upWpC2kiqWvklr92hS6YVurQ5vWdPnR2OAU8BRFDQbaWD+GQ/qrbG3lmKJ4pa71aeYJmnKJzBZ+H1CsrZZAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAHctCKAwT7ATLFUZ18FIF9jD3Z/y8EckAWJ4NytapoNH/O1O6BhlJnHYm+MAiDaj3ILUAU+E322VwBv8ia2hK27qkgLht0nqt5Ye+rKaeDv+S+5Bkil8gwHSvm/lNuSOlCXESLqpuXyFY1Z0a+nNj+BumlANqokrFLAt3WMWo8+jzrm1g0624wWcBzGasYW8w8lY8aSvsaU6fpDTFrHajEIrWvfRij5msaHpN5ZTqawNtf4kv5v1OEBPedN7XE1Wkmw780w8S841/BldOPeI4rDsFDorBqx63675B14msCbHdeaBPw+LGcyuVIMEgRU9oqfIQr/ec/c+qGdyi0BVl5Y=');
INSERT INTO public.component_config VALUES ('24eba069-7a0f-4108-966a-9900c25ae419', '4f9b5450-e63c-40c9-860a-4be1a483731c', 'kid', 'cc55d433-1bc6-4261-990b-0dbed84cd017');
INSERT INTO public.component_config VALUES ('22bb59c7-d575-40e8-b92f-d99c6f32085e', '4f9b5450-e63c-40c9-860a-4be1a483731c', 'algorithm', 'HS512');
INSERT INTO public.component_config VALUES ('a6e5d46d-9e1e-4def-84dd-1a427825310e', '4f9b5450-e63c-40c9-860a-4be1a483731c', 'priority', '100');
INSERT INTO public.component_config VALUES ('f61ccc6a-404b-49c7-8639-ca390a21d7ef', '4f9b5450-e63c-40c9-860a-4be1a483731c', 'secret', 'dV6_guNhwKy3W0ohZLWUPOo_tRTECw8JWxz0JIPRkxfbvSeiWBu1nWxvdeD6_I1nBs1WFuGOcqbkSJUjF5P5T5h1GyyM-8vfTlodyGW12ZngeE9fKwBgVhmoUBfgiBu1ldPaNQ8ULAzX-IyzZaeQDe8x7l76Zz4r9OfCEcA5wMw');
INSERT INTO public.component_config VALUES ('41fc575b-c6fc-491e-b5f1-e4af01ab9eb0', 'dfe95ad3-cc2b-4699-84e8-2f1ae3544190', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO public.component_config VALUES ('793124eb-9303-464d-87ab-6559e3749770', 'dfe95ad3-cc2b-4699-84e8-2f1ae3544190', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO public.component_config VALUES ('919c5b8a-98df-454f-a7de-79955d69aa40', 'dfe95ad3-cc2b-4699-84e8-2f1ae3544190', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO public.component_config VALUES ('0f807136-5a72-4e79-95e9-75fb3627b42a', 'dfe95ad3-cc2b-4699-84e8-2f1ae3544190', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO public.component_config VALUES ('74b9a4c5-7879-4993-8efc-9a15803bce27', 'dfe95ad3-cc2b-4699-84e8-2f1ae3544190', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO public.component_config VALUES ('eb548253-5c58-4bb8-8409-9c52190b4a8b', 'dfe95ad3-cc2b-4699-84e8-2f1ae3544190', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO public.component_config VALUES ('a3c843db-0e46-4830-914e-85b0593a3555', 'dfe95ad3-cc2b-4699-84e8-2f1ae3544190', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO public.component_config VALUES ('c1d956da-1f7b-4394-9744-074b0385f394', 'dfe95ad3-cc2b-4699-84e8-2f1ae3544190', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO public.component_config VALUES ('fa295e29-af06-4d3e-aaeb-53a874ba135b', 'c05c8e63-9132-4457-be84-c348720048c0', 'host-sending-registration-request-must-match', 'true');
INSERT INTO public.component_config VALUES ('7f045e1d-72d8-48e2-b9f3-f015b3fa01d0', 'c05c8e63-9132-4457-be84-c348720048c0', 'client-uris-must-match', 'true');
INSERT INTO public.component_config VALUES ('d9b620c7-8ef1-4905-9e4c-28b9e18faf40', 'c56b21b2-36a0-4627-be92-9d2943aa0efa', 'allow-default-scopes', 'true');
INSERT INTO public.component_config VALUES ('7f563f51-1628-40c0-b4fc-cc6866b8ad15', 'a7f780e4-8ebf-440a-a118-626443c243d6', 'allow-default-scopes', 'true');
INSERT INTO public.component_config VALUES ('482a8e2b-78da-41ca-b8ec-2628d6f023cf', 'e620cf95-7da1-4795-af25-3725c16c7a43', 'max-clients', '200');
INSERT INTO public.component_config VALUES ('2899507a-f2d9-4c57-b87c-e97db1470ce7', 'ea9fb46f-1d49-4771-ad85-57a385891373', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO public.component_config VALUES ('f20e5a5c-6feb-4c38-a740-1a1246d93401', 'ea9fb46f-1d49-4771-ad85-57a385891373', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO public.component_config VALUES ('bf542d29-dd06-43c1-9f65-1833ed8b3d6c', 'ea9fb46f-1d49-4771-ad85-57a385891373', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO public.component_config VALUES ('2a8fd077-a1ed-43ec-9ad5-cef1ab129b6e', 'ea9fb46f-1d49-4771-ad85-57a385891373', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO public.component_config VALUES ('077c728b-4d94-41ca-a593-148dc60d5db3', 'ea9fb46f-1d49-4771-ad85-57a385891373', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO public.component_config VALUES ('f1c0294a-5f9d-4be0-92f3-3b912f874026', 'ea9fb46f-1d49-4771-ad85-57a385891373', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO public.component_config VALUES ('e76308ea-bd54-43db-862b-233da993d8e8', 'ea9fb46f-1d49-4771-ad85-57a385891373', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO public.component_config VALUES ('134cb9c5-8542-4229-8cd6-6b9678f9e80f', 'ea9fb46f-1d49-4771-ad85-57a385891373', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');


--
-- TOC entry 4144 (class 0 OID 16484)
-- Dependencies: 230
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.composite_role VALUES ('5e5646e2-8bd2-4dd8-9c80-33b2c87873c0', 'f057685e-676d-49dc-83e7-5b6ccd283906');
INSERT INTO public.composite_role VALUES ('5e5646e2-8bd2-4dd8-9c80-33b2c87873c0', '3afab410-5d09-4c8e-90ee-f2831cf46386');
INSERT INTO public.composite_role VALUES ('5e5646e2-8bd2-4dd8-9c80-33b2c87873c0', '58f032cf-ecfb-4c86-bf9b-95606504ec87');
INSERT INTO public.composite_role VALUES ('5e5646e2-8bd2-4dd8-9c80-33b2c87873c0', 'ce3c05e7-1d5d-47fd-85bd-4d9b00a6d56c');
INSERT INTO public.composite_role VALUES ('5e5646e2-8bd2-4dd8-9c80-33b2c87873c0', 'bde0a063-b43e-4a8f-b197-2a3e0fa22c4d');
INSERT INTO public.composite_role VALUES ('5e5646e2-8bd2-4dd8-9c80-33b2c87873c0', 'cd958424-8805-4438-ba4f-425b5b67d880');
INSERT INTO public.composite_role VALUES ('5e5646e2-8bd2-4dd8-9c80-33b2c87873c0', '28734bba-4a07-456d-b052-6ae4ddf2a6ef');
INSERT INTO public.composite_role VALUES ('5e5646e2-8bd2-4dd8-9c80-33b2c87873c0', '3b98f35e-195a-495b-b82d-5cea5254f0f6');
INSERT INTO public.composite_role VALUES ('5e5646e2-8bd2-4dd8-9c80-33b2c87873c0', '746d529f-0a77-4d07-ae69-0422ba08edfb');
INSERT INTO public.composite_role VALUES ('5e5646e2-8bd2-4dd8-9c80-33b2c87873c0', '0a2d1446-0b07-47cb-bbfe-567988375304');
INSERT INTO public.composite_role VALUES ('5e5646e2-8bd2-4dd8-9c80-33b2c87873c0', 'fc32d7d9-673b-42d8-bc8c-056fd73e3ecc');
INSERT INTO public.composite_role VALUES ('5e5646e2-8bd2-4dd8-9c80-33b2c87873c0', '5c6c4458-de89-40c3-9986-7c6e839f8aa4');
INSERT INTO public.composite_role VALUES ('5e5646e2-8bd2-4dd8-9c80-33b2c87873c0', '8203286f-22a7-4dbf-9d73-8bcfc449a0ec');
INSERT INTO public.composite_role VALUES ('5e5646e2-8bd2-4dd8-9c80-33b2c87873c0', '7ea982a8-f4b6-4f0a-8004-7b5d1eef874d');
INSERT INTO public.composite_role VALUES ('5e5646e2-8bd2-4dd8-9c80-33b2c87873c0', 'aa50a49b-0af7-45dd-9abf-aa39882712c7');
INSERT INTO public.composite_role VALUES ('5e5646e2-8bd2-4dd8-9c80-33b2c87873c0', '60ae4b21-e2a7-4691-9736-e330a6872585');
INSERT INTO public.composite_role VALUES ('5e5646e2-8bd2-4dd8-9c80-33b2c87873c0', 'c8d17b34-eb12-4ca3-a856-96eab2e658bc');
INSERT INTO public.composite_role VALUES ('5e5646e2-8bd2-4dd8-9c80-33b2c87873c0', '4ed2376d-2b87-4bcf-b1c0-1b6da4a077c9');
INSERT INTO public.composite_role VALUES ('3f35f02e-f5ac-41f3-85a0-521590599c9b', '78f4d7bd-4968-4f37-8e86-8ec1d7cd35a2');
INSERT INTO public.composite_role VALUES ('bde0a063-b43e-4a8f-b197-2a3e0fa22c4d', '60ae4b21-e2a7-4691-9736-e330a6872585');
INSERT INTO public.composite_role VALUES ('ce3c05e7-1d5d-47fd-85bd-4d9b00a6d56c', 'aa50a49b-0af7-45dd-9abf-aa39882712c7');
INSERT INTO public.composite_role VALUES ('ce3c05e7-1d5d-47fd-85bd-4d9b00a6d56c', '4ed2376d-2b87-4bcf-b1c0-1b6da4a077c9');
INSERT INTO public.composite_role VALUES ('3f35f02e-f5ac-41f3-85a0-521590599c9b', '4a442c8f-2d67-4b33-b2c6-792140846e5e');
INSERT INTO public.composite_role VALUES ('4a442c8f-2d67-4b33-b2c6-792140846e5e', 'a1cb113a-e788-4151-80c0-1be1edc7daad');
INSERT INTO public.composite_role VALUES ('2827c386-eff9-4397-bb80-3f52bfcaa07e', '07f7183b-4b9f-446d-b154-fd0a0fcda6f0');
INSERT INTO public.composite_role VALUES ('5e5646e2-8bd2-4dd8-9c80-33b2c87873c0', '570adb53-0062-4b2c-bd83-fed56b0c0e71');
INSERT INTO public.composite_role VALUES ('3f35f02e-f5ac-41f3-85a0-521590599c9b', 'f06a2fc4-1bfd-45d9-b477-3a5394250b8b');
INSERT INTO public.composite_role VALUES ('3f35f02e-f5ac-41f3-85a0-521590599c9b', 'd179f32b-2338-4ea2-916a-2d3dd436652a');
INSERT INTO public.composite_role VALUES ('5e5646e2-8bd2-4dd8-9c80-33b2c87873c0', '708a75dd-c9d2-4a6d-b17c-17db1eb36396');
INSERT INTO public.composite_role VALUES ('5e5646e2-8bd2-4dd8-9c80-33b2c87873c0', '08c24826-8f0c-42fb-b09b-09660c1877aa');
INSERT INTO public.composite_role VALUES ('5e5646e2-8bd2-4dd8-9c80-33b2c87873c0', '806a8a32-3b87-42d6-a0e0-fbcd260ac77e');
INSERT INTO public.composite_role VALUES ('5e5646e2-8bd2-4dd8-9c80-33b2c87873c0', '5afb354f-b2a2-4fad-8e85-aa3b8a8f1782');
INSERT INTO public.composite_role VALUES ('5e5646e2-8bd2-4dd8-9c80-33b2c87873c0', 'a7512452-5bd3-4aa2-8d01-41f7057c1cd2');
INSERT INTO public.composite_role VALUES ('5e5646e2-8bd2-4dd8-9c80-33b2c87873c0', 'f57c68fa-c19d-4745-8e0e-4c90abc270ee');
INSERT INTO public.composite_role VALUES ('5e5646e2-8bd2-4dd8-9c80-33b2c87873c0', 'e9233b01-1713-4635-a632-5603fd306148');
INSERT INTO public.composite_role VALUES ('5e5646e2-8bd2-4dd8-9c80-33b2c87873c0', '156b2241-9593-4dca-8249-a361c7690123');
INSERT INTO public.composite_role VALUES ('5e5646e2-8bd2-4dd8-9c80-33b2c87873c0', '27d19ad8-1b7d-4b37-adff-f0ab7ce19065');
INSERT INTO public.composite_role VALUES ('5e5646e2-8bd2-4dd8-9c80-33b2c87873c0', '8f1df5db-35b6-4989-a439-63929338df4b');
INSERT INTO public.composite_role VALUES ('5e5646e2-8bd2-4dd8-9c80-33b2c87873c0', 'ee4ad49c-5051-4ee6-806d-e0f7fd127cf8');
INSERT INTO public.composite_role VALUES ('5e5646e2-8bd2-4dd8-9c80-33b2c87873c0', 'cbf8f1c8-891b-4083-a83f-92e7467e41f5');
INSERT INTO public.composite_role VALUES ('5e5646e2-8bd2-4dd8-9c80-33b2c87873c0', '64403fe4-5cae-4bc2-8ba4-c143c4e08b69');
INSERT INTO public.composite_role VALUES ('5e5646e2-8bd2-4dd8-9c80-33b2c87873c0', '182c3af9-161a-43f1-8a4a-7e891c467d0c');
INSERT INTO public.composite_role VALUES ('5e5646e2-8bd2-4dd8-9c80-33b2c87873c0', 'e9e414f0-8717-4fbe-abd8-d0babf870b86');
INSERT INTO public.composite_role VALUES ('5e5646e2-8bd2-4dd8-9c80-33b2c87873c0', 'e35edf70-84fc-4c4c-8666-eb915c33d01e');
INSERT INTO public.composite_role VALUES ('5e5646e2-8bd2-4dd8-9c80-33b2c87873c0', 'c0ef4478-e233-491c-8cd1-8fbd810d62f0');
INSERT INTO public.composite_role VALUES ('5afb354f-b2a2-4fad-8e85-aa3b8a8f1782', 'e9e414f0-8717-4fbe-abd8-d0babf870b86');
INSERT INTO public.composite_role VALUES ('806a8a32-3b87-42d6-a0e0-fbcd260ac77e', '182c3af9-161a-43f1-8a4a-7e891c467d0c');
INSERT INTO public.composite_role VALUES ('806a8a32-3b87-42d6-a0e0-fbcd260ac77e', 'c0ef4478-e233-491c-8cd1-8fbd810d62f0');
INSERT INTO public.composite_role VALUES ('b7dd5bdf-7a4e-4b59-a060-73a726aa264a', 'd7ca089b-f7ed-4964-883f-4d5689e6dc53');
INSERT INTO public.composite_role VALUES ('b7dd5bdf-7a4e-4b59-a060-73a726aa264a', '35fe3a33-f75b-4ca4-88bf-8cf6d25fe286');
INSERT INTO public.composite_role VALUES ('b7dd5bdf-7a4e-4b59-a060-73a726aa264a', 'ed44c94b-5cc7-4ac2-88ff-d27b089f62da');
INSERT INTO public.composite_role VALUES ('b7dd5bdf-7a4e-4b59-a060-73a726aa264a', '55e40f50-f325-4920-ba91-e997aab1049b');
INSERT INTO public.composite_role VALUES ('b7dd5bdf-7a4e-4b59-a060-73a726aa264a', '3e0f6973-46f6-430d-9722-56a0ee19c7b6');
INSERT INTO public.composite_role VALUES ('b7dd5bdf-7a4e-4b59-a060-73a726aa264a', '931b2489-e157-4b02-8c5e-f70566734485');
INSERT INTO public.composite_role VALUES ('b7dd5bdf-7a4e-4b59-a060-73a726aa264a', '8cb135ad-25dd-43ca-876c-7a8960416b69');
INSERT INTO public.composite_role VALUES ('b7dd5bdf-7a4e-4b59-a060-73a726aa264a', 'c71f143a-3dd1-4994-8239-9e2b3140bbc3');
INSERT INTO public.composite_role VALUES ('b7dd5bdf-7a4e-4b59-a060-73a726aa264a', 'a5397d90-5c59-43c9-99bb-a201601b33db');
INSERT INTO public.composite_role VALUES ('b7dd5bdf-7a4e-4b59-a060-73a726aa264a', '29cda7fb-9fd9-4e5a-befb-69388fb511f8');
INSERT INTO public.composite_role VALUES ('b7dd5bdf-7a4e-4b59-a060-73a726aa264a', '19b5f18e-861a-42f2-9ce7-71c2b7c2a5ba');
INSERT INTO public.composite_role VALUES ('b7dd5bdf-7a4e-4b59-a060-73a726aa264a', '8a773344-4fda-4e1b-b0a3-88fdf02c84b2');
INSERT INTO public.composite_role VALUES ('b7dd5bdf-7a4e-4b59-a060-73a726aa264a', 'ba2498fd-60e5-4b0e-b3a9-2cf834ddd2ae');
INSERT INTO public.composite_role VALUES ('b7dd5bdf-7a4e-4b59-a060-73a726aa264a', 'e82321ed-5b76-410b-bc25-ab524a00187c');
INSERT INTO public.composite_role VALUES ('b7dd5bdf-7a4e-4b59-a060-73a726aa264a', 'fc8cb9e6-95cb-4c77-b7bc-0832035cf616');
INSERT INTO public.composite_role VALUES ('b7dd5bdf-7a4e-4b59-a060-73a726aa264a', '91c7e8f4-67ed-4637-b5e8-f6a5d019252c');
INSERT INTO public.composite_role VALUES ('b7dd5bdf-7a4e-4b59-a060-73a726aa264a', '43c4e912-8465-44c8-b18c-667898ba97ec');
INSERT INTO public.composite_role VALUES ('133c74bd-6684-4acb-93cf-38d4e10194b8', 'e328c05d-8bb3-4e22-9025-d45e499922dc');
INSERT INTO public.composite_role VALUES ('55e40f50-f325-4920-ba91-e997aab1049b', 'fc8cb9e6-95cb-4c77-b7bc-0832035cf616');
INSERT INTO public.composite_role VALUES ('ed44c94b-5cc7-4ac2-88ff-d27b089f62da', 'e82321ed-5b76-410b-bc25-ab524a00187c');
INSERT INTO public.composite_role VALUES ('ed44c94b-5cc7-4ac2-88ff-d27b089f62da', '43c4e912-8465-44c8-b18c-667898ba97ec');
INSERT INTO public.composite_role VALUES ('133c74bd-6684-4acb-93cf-38d4e10194b8', 'f6c5e85a-2400-4dae-96f5-a6647b62ae29');
INSERT INTO public.composite_role VALUES ('f6c5e85a-2400-4dae-96f5-a6647b62ae29', '97038469-e755-4549-80a3-e593dc917d67');
INSERT INTO public.composite_role VALUES ('13bfc48d-8450-43b3-8d0d-cb449ff9fe38', '5cd16e45-e60d-4992-8dce-788511daf645');
INSERT INTO public.composite_role VALUES ('5e5646e2-8bd2-4dd8-9c80-33b2c87873c0', '526a9910-a769-43bb-a19a-c4c570c96574');
INSERT INTO public.composite_role VALUES ('b7dd5bdf-7a4e-4b59-a060-73a726aa264a', 'cef9a373-4a02-403b-9775-8b2d5305f44e');
INSERT INTO public.composite_role VALUES ('133c74bd-6684-4acb-93cf-38d4e10194b8', '18088f05-b3a0-4ffe-8616-5d7613ebc772');
INSERT INTO public.composite_role VALUES ('133c74bd-6684-4acb-93cf-38d4e10194b8', 'dfdb7a56-d535-4124-b416-a0c603404a18');


--
-- TOC entry 4145 (class 0 OID 16487)
-- Dependencies: 231
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.credential VALUES ('daf5a0f3-eea5-40bc-afeb-027d693ae0bf', NULL, 'password', '8efbd700-329b-4874-a87f-1eeb52ca2637', 1750802374735, NULL, '{"value":"hwB1H3Vnhk+gooK3Wtcwd2YhqDjXdyy17zdxjSP95lU=","salt":"o4H+Kb1ux4Trlo2mSr4g0g==","additionalParameters":{}}', '{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}', 10, 0);
INSERT INTO public.credential VALUES ('44f9aa0d-c1fb-4d2b-b51e-51f72445b226', NULL, 'password', 'd07916df-b022-4f2a-b652-94aa14209064', 1750803009724, 'My password', '{"value":"WbVeO+BtPtwSK3+d9l9u37O7sbpN8OThpXKU7r9U6rM=","salt":"Zb8Efh4lRkK64ibF0/i1OQ==","additionalParameters":{}}', '{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}', 10, 1);


--
-- TOC entry 4142 (class 0 OID 16457)
-- Dependencies: 228
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.databasechangelog VALUES ('1.0.0.Final-KEYCLOAK-5461', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.0.0.Final.xml', '2025-06-24 21:59:28.403614', 1, 'EXECUTED', '9:6f1016664e21e16d26517a4418f5e3df', 'createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('1.0.0.Final-KEYCLOAK-5461', 'sthorger@redhat.com', 'META-INF/db2-jpa-changelog-1.0.0.Final.xml', '2025-06-24 21:59:28.413779', 2, 'MARK_RAN', '9:828775b1596a07d1200ba1d49e5e3941', 'createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('1.1.0.Beta1', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.1.0.Beta1.xml', '2025-06-24 21:59:28.45377', 3, 'EXECUTED', '9:5f090e44a7d595883c1fb61f4b41fd38', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('1.1.0.Final', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.1.0.Final.xml', '2025-06-24 21:59:28.456806', 4, 'EXECUTED', '9:c07e577387a3d2c04d1adc9aaad8730e', 'renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('1.2.0.Beta1', 'psilva@redhat.com', 'META-INF/jpa-changelog-1.2.0.Beta1.xml', '2025-06-24 21:59:28.554602', 5, 'EXECUTED', '9:b68ce996c655922dbcd2fe6b6ae72686', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('1.2.0.Beta1', 'psilva@redhat.com', 'META-INF/db2-jpa-changelog-1.2.0.Beta1.xml', '2025-06-24 21:59:28.558762', 6, 'MARK_RAN', '9:543b5c9989f024fe35c6f6c5a97de88e', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('1.2.0.RC1', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.2.0.CR1.xml', '2025-06-24 21:59:28.642289', 7, 'EXECUTED', '9:765afebbe21cf5bbca048e632df38336', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('1.2.0.RC1', 'bburke@redhat.com', 'META-INF/db2-jpa-changelog-1.2.0.CR1.xml', '2025-06-24 21:59:28.64576', 8, 'MARK_RAN', '9:db4a145ba11a6fdaefb397f6dbf829a1', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('1.2.0.Final', 'keycloak', 'META-INF/jpa-changelog-1.2.0.Final.xml', '2025-06-24 21:59:28.650074', 9, 'EXECUTED', '9:9d05c7be10cdb873f8bcb41bc3a8ab23', 'update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('1.3.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.3.0.xml', '2025-06-24 21:59:28.746046', 10, 'EXECUTED', '9:18593702353128d53111f9b1ff0b82b8', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('1.4.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.4.0.xml', '2025-06-24 21:59:28.795289', 11, 'EXECUTED', '9:6122efe5f090e41a85c0f1c9e52cbb62', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('1.4.0', 'bburke@redhat.com', 'META-INF/db2-jpa-changelog-1.4.0.xml', '2025-06-24 21:59:28.797911', 12, 'MARK_RAN', '9:e1ff28bf7568451453f844c5d54bb0b5', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('1.5.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.5.0.xml', '2025-06-24 21:59:28.813292', 13, 'EXECUTED', '9:7af32cd8957fbc069f796b61217483fd', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('1.6.1_from15', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2025-06-24 21:59:28.835718', 14, 'EXECUTED', '9:6005e15e84714cd83226bf7879f54190', 'addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('1.6.1_from16-pre', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2025-06-24 21:59:28.837039', 15, 'MARK_RAN', '9:bf656f5a2b055d07f314431cae76f06c', 'delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('1.6.1_from16', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2025-06-24 21:59:28.839427', 16, 'MARK_RAN', '9:f8dadc9284440469dcf71e25ca6ab99b', 'dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('1.6.1', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2025-06-24 21:59:28.841545', 17, 'EXECUTED', '9:d41d8cd98f00b204e9800998ecf8427e', 'empty', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('1.7.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.7.0.xml', '2025-06-24 21:59:28.883439', 18, 'EXECUTED', '9:3368ff0be4c2855ee2dd9ca813b38d8e', 'createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('1.8.0', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.8.0.xml', '2025-06-24 21:59:28.9243', 19, 'EXECUTED', '9:8ac2fb5dd030b24c0570a763ed75ed20', 'addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('1.8.0-2', 'keycloak', 'META-INF/jpa-changelog-1.8.0.xml', '2025-06-24 21:59:28.928272', 20, 'EXECUTED', '9:f91ddca9b19743db60e3057679810e6c', 'dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('1.8.0', 'mposolda@redhat.com', 'META-INF/db2-jpa-changelog-1.8.0.xml', '2025-06-24 21:59:28.930766', 21, 'MARK_RAN', '9:831e82914316dc8a57dc09d755f23c51', 'addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('1.8.0-2', 'keycloak', 'META-INF/db2-jpa-changelog-1.8.0.xml', '2025-06-24 21:59:28.932994', 22, 'MARK_RAN', '9:f91ddca9b19743db60e3057679810e6c', 'dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('1.9.0', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.9.0.xml', '2025-06-24 21:59:28.988151', 23, 'EXECUTED', '9:bc3d0f9e823a69dc21e23e94c7a94bb1', 'update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('1.9.1', 'keycloak', 'META-INF/jpa-changelog-1.9.1.xml', '2025-06-24 21:59:28.994223', 24, 'EXECUTED', '9:c9999da42f543575ab790e76439a2679', 'modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('1.9.1', 'keycloak', 'META-INF/db2-jpa-changelog-1.9.1.xml', '2025-06-24 21:59:28.995512', 25, 'MARK_RAN', '9:0d6c65c6f58732d81569e77b10ba301d', 'modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('1.9.2', 'keycloak', 'META-INF/jpa-changelog-1.9.2.xml', '2025-06-24 21:59:29.2744', 26, 'EXECUTED', '9:fc576660fc016ae53d2d4778d84d86d0', 'createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('authz-2.0.0', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-2.0.0.xml', '2025-06-24 21:59:29.353901', 27, 'EXECUTED', '9:43ed6b0da89ff77206289e87eaa9c024', 'createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('authz-2.5.1', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-2.5.1.xml', '2025-06-24 21:59:29.356241', 28, 'EXECUTED', '9:44bae577f551b3738740281eceb4ea70', 'update tableName=RESOURCE_SERVER_POLICY', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('2.1.0-KEYCLOAK-5461', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.1.0.xml', '2025-06-24 21:59:29.426102', 29, 'EXECUTED', '9:bd88e1f833df0420b01e114533aee5e8', 'createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('2.2.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.2.0.xml', '2025-06-24 21:59:29.439848', 30, 'EXECUTED', '9:a7022af5267f019d020edfe316ef4371', 'addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('2.3.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.3.0.xml', '2025-06-24 21:59:29.457181', 31, 'EXECUTED', '9:fc155c394040654d6a79227e56f5e25a', 'createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('2.4.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.4.0.xml', '2025-06-24 21:59:29.460302', 32, 'EXECUTED', '9:eac4ffb2a14795e5dc7b426063e54d88', 'customChange', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('2.5.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2025-06-24 21:59:29.464217', 33, 'EXECUTED', '9:54937c05672568c4c64fc9524c1e9462', 'customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('2.5.0-unicode-oracle', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2025-06-24 21:59:29.466075', 34, 'MARK_RAN', '9:f9753208029f582525ed12011a19d054', 'modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('2.5.0-unicode-other-dbs', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2025-06-24 21:59:29.491497', 35, 'EXECUTED', '9:33d72168746f81f98ae3a1e8e0ca3554', 'modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('2.5.0-duplicate-email-support', 'slawomir@dabek.name', 'META-INF/jpa-changelog-2.5.0.xml', '2025-06-24 21:59:29.497073', 36, 'EXECUTED', '9:61b6d3d7a4c0e0024b0c839da283da0c', 'addColumn tableName=REALM', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('2.5.0-unique-group-names', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2025-06-24 21:59:29.503418', 37, 'EXECUTED', '9:8dcac7bdf7378e7d823cdfddebf72fda', 'addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('2.5.1', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.5.1.xml', '2025-06-24 21:59:29.507209', 38, 'EXECUTED', '9:a2b870802540cb3faa72098db5388af3', 'addColumn tableName=FED_USER_CONSENT', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('3.0.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-3.0.0.xml', '2025-06-24 21:59:29.510582', 39, 'EXECUTED', '9:132a67499ba24bcc54fb5cbdcfe7e4c0', 'addColumn tableName=IDENTITY_PROVIDER', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('3.2.0-fix', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2025-06-24 21:59:29.511952', 40, 'MARK_RAN', '9:938f894c032f5430f2b0fafb1a243462', 'addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('3.2.0-fix-with-keycloak-5416', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2025-06-24 21:59:29.514355', 41, 'MARK_RAN', '9:845c332ff1874dc5d35974b0babf3006', 'dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('3.2.0-fix-offline-sessions', 'hmlnarik', 'META-INF/jpa-changelog-3.2.0.xml', '2025-06-24 21:59:29.518334', 42, 'EXECUTED', '9:fc86359c079781adc577c5a217e4d04c', 'customChange', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('3.2.0-fixed', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2025-06-24 21:59:30.462322', 43, 'EXECUTED', '9:59a64800e3c0d09b825f8a3b444fa8f4', 'addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('3.3.0', 'keycloak', 'META-INF/jpa-changelog-3.3.0.xml', '2025-06-24 21:59:30.465958', 44, 'EXECUTED', '9:d48d6da5c6ccf667807f633fe489ce88', 'addColumn tableName=USER_ENTITY', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part1', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2025-06-24 21:59:30.469228', 45, 'EXECUTED', '9:dde36f7973e80d71fceee683bc5d2951', 'addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2025-06-24 21:59:30.472122', 46, 'EXECUTED', '9:b855e9b0a406b34fa323235a0cf4f640', 'customChange', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2025-06-24 21:59:30.473239', 47, 'MARK_RAN', '9:51abbacd7b416c50c4421a8cabf7927e', 'dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2025-06-24 21:59:30.556624', 48, 'EXECUTED', '9:bdc99e567b3398bac83263d375aad143', 'addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('authn-3.4.0.CR1-refresh-token-max-reuse', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2025-06-24 21:59:30.560397', 49, 'EXECUTED', '9:d198654156881c46bfba39abd7769e69', 'addColumn tableName=REALM', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('3.4.0', 'keycloak', 'META-INF/jpa-changelog-3.4.0.xml', '2025-06-24 21:59:30.601031', 50, 'EXECUTED', '9:cfdd8736332ccdd72c5256ccb42335db', 'addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('3.4.0-KEYCLOAK-5230', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-3.4.0.xml', '2025-06-24 21:59:30.816992', 51, 'EXECUTED', '9:7c84de3d9bd84d7f077607c1a4dcb714', 'createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('3.4.1', 'psilva@redhat.com', 'META-INF/jpa-changelog-3.4.1.xml', '2025-06-24 21:59:30.819709', 52, 'EXECUTED', '9:5a6bb36cbefb6a9d6928452c0852af2d', 'modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('3.4.2', 'keycloak', 'META-INF/jpa-changelog-3.4.2.xml', '2025-06-24 21:59:30.821467', 53, 'EXECUTED', '9:8f23e334dbc59f82e0a328373ca6ced0', 'update tableName=REALM', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('3.4.2-KEYCLOAK-5172', 'mkanis@redhat.com', 'META-INF/jpa-changelog-3.4.2.xml', '2025-06-24 21:59:30.823003', 54, 'EXECUTED', '9:9156214268f09d970cdf0e1564d866af', 'update tableName=CLIENT', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('4.0.0-KEYCLOAK-6335', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2025-06-24 21:59:30.828261', 55, 'EXECUTED', '9:db806613b1ed154826c02610b7dbdf74', 'createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('4.0.0-CLEANUP-UNUSED-TABLE', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2025-06-24 21:59:30.833987', 56, 'EXECUTED', '9:229a041fb72d5beac76bb94a5fa709de', 'dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('4.0.0-KEYCLOAK-6228', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2025-06-24 21:59:30.869106', 57, 'EXECUTED', '9:079899dade9c1e683f26b2aa9ca6ff04', 'dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('4.0.0-KEYCLOAK-5579-fixed', 'mposolda@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2025-06-24 21:59:31.122526', 58, 'EXECUTED', '9:139b79bcbbfe903bb1c2d2a4dbf001d9', 'dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('authz-4.0.0.CR1', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-4.0.0.CR1.xml', '2025-06-24 21:59:31.14436', 59, 'EXECUTED', '9:b55738ad889860c625ba2bf483495a04', 'createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('authz-4.0.0.Beta3', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-4.0.0.Beta3.xml', '2025-06-24 21:59:31.148817', 60, 'EXECUTED', '9:e0057eac39aa8fc8e09ac6cfa4ae15fe', 'addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('authz-4.2.0.Final', 'mhajas@redhat.com', 'META-INF/jpa-changelog-authz-4.2.0.Final.xml', '2025-06-24 21:59:31.154445', 61, 'EXECUTED', '9:42a33806f3a0443fe0e7feeec821326c', 'createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('authz-4.2.0.Final-KEYCLOAK-9944', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-authz-4.2.0.Final.xml', '2025-06-24 21:59:31.159373', 62, 'EXECUTED', '9:9968206fca46eecc1f51db9c024bfe56', 'addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('4.2.0-KEYCLOAK-6313', 'wadahiro@gmail.com', 'META-INF/jpa-changelog-4.2.0.xml', '2025-06-24 21:59:31.161961', 63, 'EXECUTED', '9:92143a6daea0a3f3b8f598c97ce55c3d', 'addColumn tableName=REQUIRED_ACTION_PROVIDER', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('4.3.0-KEYCLOAK-7984', 'wadahiro@gmail.com', 'META-INF/jpa-changelog-4.3.0.xml', '2025-06-24 21:59:31.167882', 64, 'EXECUTED', '9:82bab26a27195d889fb0429003b18f40', 'update tableName=REQUIRED_ACTION_PROVIDER', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('4.6.0-KEYCLOAK-7950', 'psilva@redhat.com', 'META-INF/jpa-changelog-4.6.0.xml', '2025-06-24 21:59:31.17344', 65, 'EXECUTED', '9:e590c88ddc0b38b0ae4249bbfcb5abc3', 'update tableName=RESOURCE_SERVER_RESOURCE', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('4.6.0-KEYCLOAK-8377', 'keycloak', 'META-INF/jpa-changelog-4.6.0.xml', '2025-06-24 21:59:31.208505', 66, 'EXECUTED', '9:5c1f475536118dbdc38d5d7977950cc0', 'createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('4.6.0-KEYCLOAK-8555', 'gideonray@gmail.com', 'META-INF/jpa-changelog-4.6.0.xml', '2025-06-24 21:59:31.230004', 67, 'EXECUTED', '9:e7c9f5f9c4d67ccbbcc215440c718a17', 'createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('4.7.0-KEYCLOAK-1267', 'sguilhen@redhat.com', 'META-INF/jpa-changelog-4.7.0.xml', '2025-06-24 21:59:31.233804', 68, 'EXECUTED', '9:88e0bfdda924690d6f4e430c53447dd5', 'addColumn tableName=REALM', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('4.7.0-KEYCLOAK-7275', 'keycloak', 'META-INF/jpa-changelog-4.7.0.xml', '2025-06-24 21:59:31.258312', 69, 'EXECUTED', '9:f53177f137e1c46b6a88c59ec1cb5218', 'renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('4.8.0-KEYCLOAK-8835', 'sguilhen@redhat.com', 'META-INF/jpa-changelog-4.8.0.xml', '2025-06-24 21:59:31.261834', 70, 'EXECUTED', '9:a74d33da4dc42a37ec27121580d1459f', 'addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('authz-7.0.0-KEYCLOAK-10443', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-7.0.0.xml', '2025-06-24 21:59:31.264719', 71, 'EXECUTED', '9:fd4ade7b90c3b67fae0bfcfcb42dfb5f', 'addColumn tableName=RESOURCE_SERVER', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('8.0.0-adding-credential-columns', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2025-06-24 21:59:31.269096', 72, 'EXECUTED', '9:aa072ad090bbba210d8f18781b8cebf4', 'addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('8.0.0-updating-credential-data-not-oracle-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2025-06-24 21:59:31.273338', 73, 'EXECUTED', '9:1ae6be29bab7c2aa376f6983b932be37', 'update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('8.0.0-updating-credential-data-oracle-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2025-06-24 21:59:31.274758', 74, 'MARK_RAN', '9:14706f286953fc9a25286dbd8fb30d97', 'update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('8.0.0-credential-cleanup-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2025-06-24 21:59:31.289669', 75, 'EXECUTED', '9:2b9cc12779be32c5b40e2e67711a218b', 'dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('8.0.0-resource-tag-support', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2025-06-24 21:59:31.31314', 76, 'EXECUTED', '9:91fa186ce7a5af127a2d7a91ee083cc5', 'addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('9.0.0-always-display-client', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2025-06-24 21:59:31.316636', 77, 'EXECUTED', '9:6335e5c94e83a2639ccd68dd24e2e5ad', 'addColumn tableName=CLIENT', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('9.0.0-drop-constraints-for-column-increase', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2025-06-24 21:59:31.317741', 78, 'MARK_RAN', '9:6bdb5658951e028bfe16fa0a8228b530', 'dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('9.0.0-increase-column-size-federated-fk', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2025-06-24 21:59:31.335238', 79, 'EXECUTED', '9:d5bc15a64117ccad481ce8792d4c608f', 'modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('9.0.0-recreate-constraints-after-column-increase', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2025-06-24 21:59:31.336656', 80, 'MARK_RAN', '9:077cba51999515f4d3e7ad5619ab592c', 'addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('9.0.1-add-index-to-client.client_id', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2025-06-24 21:59:31.358656', 81, 'EXECUTED', '9:be969f08a163bf47c6b9e9ead8ac2afb', 'createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('9.0.1-KEYCLOAK-12579-drop-constraints', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2025-06-24 21:59:31.359799', 82, 'MARK_RAN', '9:6d3bb4408ba5a72f39bd8a0b301ec6e3', 'dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('9.0.1-KEYCLOAK-12579-add-not-null-constraint', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2025-06-24 21:59:31.362953', 83, 'EXECUTED', '9:966bda61e46bebf3cc39518fbed52fa7', 'addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('9.0.1-KEYCLOAK-12579-recreate-constraints', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2025-06-24 21:59:31.364083', 84, 'MARK_RAN', '9:8dcac7bdf7378e7d823cdfddebf72fda', 'addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('9.0.1-add-index-to-events', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2025-06-24 21:59:31.385858', 85, 'EXECUTED', '9:7d93d602352a30c0c317e6a609b56599', 'createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('map-remove-ri', 'keycloak', 'META-INF/jpa-changelog-11.0.0.xml', '2025-06-24 21:59:31.390528', 86, 'EXECUTED', '9:71c5969e6cdd8d7b6f47cebc86d37627', 'dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('map-remove-ri', 'keycloak', 'META-INF/jpa-changelog-12.0.0.xml', '2025-06-24 21:59:31.398785', 87, 'EXECUTED', '9:a9ba7d47f065f041b7da856a81762021', 'dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('12.1.0-add-realm-localization-table', 'keycloak', 'META-INF/jpa-changelog-12.0.0.xml', '2025-06-24 21:59:31.406539', 88, 'EXECUTED', '9:fffabce2bc01e1a8f5110d5278500065', 'createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('default-roles', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2025-06-24 21:59:31.410562', 89, 'EXECUTED', '9:fa8a5b5445e3857f4b010bafb5009957', 'addColumn tableName=REALM; customChange', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('default-roles-cleanup', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2025-06-24 21:59:31.417474', 90, 'EXECUTED', '9:67ac3241df9a8582d591c5ed87125f39', 'dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('13.0.0-KEYCLOAK-16844', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2025-06-24 21:59:31.439907', 91, 'EXECUTED', '9:ad1194d66c937e3ffc82386c050ba089', 'createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('map-remove-ri-13.0.0', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2025-06-24 21:59:31.449472', 92, 'EXECUTED', '9:d9be619d94af5a2f5d07b9f003543b91', 'dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('13.0.0-KEYCLOAK-17992-drop-constraints', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2025-06-24 21:59:31.450676', 93, 'MARK_RAN', '9:544d201116a0fcc5a5da0925fbbc3bde', 'dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('13.0.0-increase-column-size-federated', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2025-06-24 21:59:31.459505', 94, 'EXECUTED', '9:43c0c1055b6761b4b3e89de76d612ccf', 'modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('13.0.0-KEYCLOAK-17992-recreate-constraints', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2025-06-24 21:59:31.460868', 95, 'MARK_RAN', '9:8bd711fd0330f4fe980494ca43ab1139', 'addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('json-string-accomodation-fixed', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2025-06-24 21:59:31.464669', 96, 'EXECUTED', '9:e07d2bc0970c348bb06fb63b1f82ddbf', 'addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('14.0.0-KEYCLOAK-11019', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2025-06-24 21:59:31.524285', 97, 'EXECUTED', '9:24fb8611e97f29989bea412aa38d12b7', 'createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('14.0.0-KEYCLOAK-18286', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2025-06-24 21:59:31.525551', 98, 'MARK_RAN', '9:259f89014ce2506ee84740cbf7163aa7', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('14.0.0-KEYCLOAK-18286-revert', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2025-06-24 21:59:31.533244', 99, 'MARK_RAN', '9:04baaf56c116ed19951cbc2cca584022', 'dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('14.0.0-KEYCLOAK-18286-supported-dbs', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2025-06-24 21:59:31.557011', 100, 'EXECUTED', '9:60ca84a0f8c94ec8c3504a5a3bc88ee8', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('14.0.0-KEYCLOAK-18286-unsupported-dbs', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2025-06-24 21:59:31.558409', 101, 'MARK_RAN', '9:d3d977031d431db16e2c181ce49d73e9', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('KEYCLOAK-17267-add-index-to-user-attributes', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2025-06-24 21:59:31.581454', 102, 'EXECUTED', '9:0b305d8d1277f3a89a0a53a659ad274c', 'createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('KEYCLOAK-18146-add-saml-art-binding-identifier', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2025-06-24 21:59:31.584333', 103, 'EXECUTED', '9:2c374ad2cdfe20e2905a84c8fac48460', 'customChange', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('15.0.0-KEYCLOAK-18467', 'keycloak', 'META-INF/jpa-changelog-15.0.0.xml', '2025-06-24 21:59:31.587907', 104, 'EXECUTED', '9:47a760639ac597360a8219f5b768b4de', 'addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('17.0.0-9562', 'keycloak', 'META-INF/jpa-changelog-17.0.0.xml', '2025-06-24 21:59:31.61088', 105, 'EXECUTED', '9:a6272f0576727dd8cad2522335f5d99e', 'createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('18.0.0-10625-IDX_ADMIN_EVENT_TIME', 'keycloak', 'META-INF/jpa-changelog-18.0.0.xml', '2025-06-24 21:59:31.634129', 106, 'EXECUTED', '9:015479dbd691d9cc8669282f4828c41d', 'createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('18.0.15-30992-index-consent', 'keycloak', 'META-INF/jpa-changelog-18.0.15.xml', '2025-06-24 21:59:31.661228', 107, 'EXECUTED', '9:80071ede7a05604b1f4906f3bf3b00f0', 'createIndex indexName=IDX_USCONSENT_SCOPE_ID, tableName=USER_CONSENT_CLIENT_SCOPE', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('19.0.0-10135', 'keycloak', 'META-INF/jpa-changelog-19.0.0.xml', '2025-06-24 21:59:31.66426', 108, 'EXECUTED', '9:9518e495fdd22f78ad6425cc30630221', 'customChange', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('20.0.0-12964-supported-dbs', 'keycloak', 'META-INF/jpa-changelog-20.0.0.xml', '2025-06-24 21:59:31.697584', 109, 'EXECUTED', '9:e5f243877199fd96bcc842f27a1656ac', 'createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('20.0.0-12964-unsupported-dbs', 'keycloak', 'META-INF/jpa-changelog-20.0.0.xml', '2025-06-24 21:59:31.699074', 110, 'MARK_RAN', '9:1a6fcaa85e20bdeae0a9ce49b41946a5', 'createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('client-attributes-string-accomodation-fixed', 'keycloak', 'META-INF/jpa-changelog-20.0.0.xml', '2025-06-24 21:59:31.703831', 111, 'EXECUTED', '9:3f332e13e90739ed0c35b0b25b7822ca', 'addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('21.0.2-17277', 'keycloak', 'META-INF/jpa-changelog-21.0.2.xml', '2025-06-24 21:59:31.706607', 112, 'EXECUTED', '9:7ee1f7a3fb8f5588f171fb9a6ab623c0', 'customChange', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('21.1.0-19404', 'keycloak', 'META-INF/jpa-changelog-21.1.0.xml', '2025-06-24 21:59:31.733686', 113, 'EXECUTED', '9:3d7e830b52f33676b9d64f7f2b2ea634', 'modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('21.1.0-19404-2', 'keycloak', 'META-INF/jpa-changelog-21.1.0.xml', '2025-06-24 21:59:31.735718', 114, 'MARK_RAN', '9:627d032e3ef2c06c0e1f73d2ae25c26c', 'addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('22.0.0-17484-updated', 'keycloak', 'META-INF/jpa-changelog-22.0.0.xml', '2025-06-24 21:59:31.738751', 115, 'EXECUTED', '9:90af0bfd30cafc17b9f4d6eccd92b8b3', 'customChange', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('22.0.5-24031', 'keycloak', 'META-INF/jpa-changelog-22.0.0.xml', '2025-06-24 21:59:31.739836', 116, 'MARK_RAN', '9:a60d2d7b315ec2d3eba9e2f145f9df28', 'customChange', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('23.0.0-12062', 'keycloak', 'META-INF/jpa-changelog-23.0.0.xml', '2025-06-24 21:59:31.743478', 117, 'EXECUTED', '9:2168fbe728fec46ae9baf15bf80927b8', 'addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('23.0.0-17258', 'keycloak', 'META-INF/jpa-changelog-23.0.0.xml', '2025-06-24 21:59:31.745702', 118, 'EXECUTED', '9:36506d679a83bbfda85a27ea1864dca8', 'addColumn tableName=EVENT_ENTITY', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('24.0.0-9758', 'keycloak', 'META-INF/jpa-changelog-24.0.0.xml', '2025-06-24 21:59:31.826818', 119, 'EXECUTED', '9:502c557a5189f600f0f445a9b49ebbce', 'addColumn tableName=USER_ATTRIBUTE; addColumn tableName=FED_USER_ATTRIBUTE; createIndex indexName=USER_ATTR_LONG_VALUES, tableName=USER_ATTRIBUTE; createIndex indexName=FED_USER_ATTR_LONG_VALUES, tableName=FED_USER_ATTRIBUTE; createIndex indexName...', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('24.0.0-9758-2', 'keycloak', 'META-INF/jpa-changelog-24.0.0.xml', '2025-06-24 21:59:31.829278', 120, 'EXECUTED', '9:bf0fdee10afdf597a987adbf291db7b2', 'customChange', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('24.0.0-26618-drop-index-if-present', 'keycloak', 'META-INF/jpa-changelog-24.0.0.xml', '2025-06-24 21:59:31.832709', 121, 'MARK_RAN', '9:04baaf56c116ed19951cbc2cca584022', 'dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('24.0.0-26618-reindex', 'keycloak', 'META-INF/jpa-changelog-24.0.0.xml', '2025-06-24 21:59:31.853923', 122, 'EXECUTED', '9:08707c0f0db1cef6b352db03a60edc7f', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('24.0.2-27228', 'keycloak', 'META-INF/jpa-changelog-24.0.2.xml', '2025-06-24 21:59:31.856715', 123, 'EXECUTED', '9:eaee11f6b8aa25d2cc6a84fb86fc6238', 'customChange', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('24.0.2-27967-drop-index-if-present', 'keycloak', 'META-INF/jpa-changelog-24.0.2.xml', '2025-06-24 21:59:31.85782', 124, 'MARK_RAN', '9:04baaf56c116ed19951cbc2cca584022', 'dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('24.0.2-27967-reindex', 'keycloak', 'META-INF/jpa-changelog-24.0.2.xml', '2025-06-24 21:59:31.859119', 125, 'MARK_RAN', '9:d3d977031d431db16e2c181ce49d73e9', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('25.0.0-28265-tables', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-06-24 21:59:31.862924', 126, 'EXECUTED', '9:deda2df035df23388af95bbd36c17cef', 'addColumn tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_CLIENT_SESSION', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('25.0.0-28265-index-creation', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-06-24 21:59:31.884579', 127, 'EXECUTED', '9:3e96709818458ae49f3c679ae58d263a', 'createIndex indexName=IDX_OFFLINE_USS_BY_LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('25.0.0-28265-index-cleanup-uss-createdon', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-06-24 21:59:32.021313', 128, 'EXECUTED', '9:78ab4fc129ed5e8265dbcc3485fba92f', 'dropIndex indexName=IDX_OFFLINE_USS_CREATEDON, tableName=OFFLINE_USER_SESSION', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('25.0.0-28265-index-cleanup-uss-preload', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-06-24 21:59:32.146677', 129, 'EXECUTED', '9:de5f7c1f7e10994ed8b62e621d20eaab', 'dropIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('25.0.0-28265-index-cleanup-uss-by-usersess', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-06-24 21:59:32.271538', 130, 'EXECUTED', '9:6eee220d024e38e89c799417ec33667f', 'dropIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('25.0.0-28265-index-cleanup-css-preload', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-06-24 21:59:32.394824', 131, 'EXECUTED', '9:5411d2fb2891d3e8d63ddb55dfa3c0c9', 'dropIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('25.0.0-28265-index-2-mysql', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-06-24 21:59:32.396096', 132, 'MARK_RAN', '9:b7ef76036d3126bb83c2423bf4d449d6', 'createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('25.0.0-28265-index-2-not-mysql', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-06-24 21:59:32.420706', 133, 'EXECUTED', '9:23396cf51ab8bc1ae6f0cac7f9f6fcf7', 'createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('25.0.0-org', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-06-24 21:59:32.439479', 134, 'EXECUTED', '9:5c859965c2c9b9c72136c360649af157', 'createTable tableName=ORG; addUniqueConstraint constraintName=UK_ORG_NAME, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_GROUP, tableName=ORG; createTable tableName=ORG_DOMAIN', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('unique-consentuser', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-06-24 21:59:32.449515', 135, 'EXECUTED', '9:5857626a2ea8767e9a6c66bf3a2cb32f', 'customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('unique-consentuser-mysql', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-06-24 21:59:32.45077', 136, 'MARK_RAN', '9:b79478aad5adaa1bc428e31563f55e8e', 'customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('25.0.0-28861-index-creation', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-06-24 21:59:32.495505', 137, 'EXECUTED', '9:b9acb58ac958d9ada0fe12a5d4794ab1', 'createIndex indexName=IDX_PERM_TICKET_REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; createIndex indexName=IDX_PERM_TICKET_OWNER, tableName=RESOURCE_SERVER_PERM_TICKET', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('26.0.0-org-alias', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2025-06-24 21:59:32.501325', 138, 'EXECUTED', '9:6ef7d63e4412b3c2d66ed179159886a4', 'addColumn tableName=ORG; update tableName=ORG; addNotNullConstraint columnName=ALIAS, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_ALIAS, tableName=ORG', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('26.0.0-org-group', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2025-06-24 21:59:32.506231', 139, 'EXECUTED', '9:da8e8087d80ef2ace4f89d8c5b9ca223', 'addColumn tableName=KEYCLOAK_GROUP; update tableName=KEYCLOAK_GROUP; addNotNullConstraint columnName=TYPE, tableName=KEYCLOAK_GROUP; customChange', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('26.0.0-org-indexes', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2025-06-24 21:59:32.528532', 140, 'EXECUTED', '9:79b05dcd610a8c7f25ec05135eec0857', 'createIndex indexName=IDX_ORG_DOMAIN_ORG_ID, tableName=ORG_DOMAIN', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('26.0.0-org-group-membership', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2025-06-24 21:59:32.532171', 141, 'EXECUTED', '9:a6ace2ce583a421d89b01ba2a28dc2d4', 'addColumn tableName=USER_GROUP_MEMBERSHIP; update tableName=USER_GROUP_MEMBERSHIP; addNotNullConstraint columnName=MEMBERSHIP_TYPE, tableName=USER_GROUP_MEMBERSHIP', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('31296-persist-revoked-access-tokens', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2025-06-24 21:59:32.537396', 142, 'EXECUTED', '9:64ef94489d42a358e8304b0e245f0ed4', 'createTable tableName=REVOKED_TOKEN; addPrimaryKey constraintName=CONSTRAINT_RT, tableName=REVOKED_TOKEN', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('31725-index-persist-revoked-access-tokens', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2025-06-24 21:59:32.561167', 143, 'EXECUTED', '9:b994246ec2bf7c94da881e1d28782c7b', 'createIndex indexName=IDX_REV_TOKEN_ON_EXPIRE, tableName=REVOKED_TOKEN', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('26.0.0-idps-for-login', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2025-06-24 21:59:32.60974', 144, 'EXECUTED', '9:51f5fffadf986983d4bd59582c6c1604', 'addColumn tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_REALM_ORG, tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_FOR_LOGIN, tableName=IDENTITY_PROVIDER; customChange', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('26.0.0-32583-drop-redundant-index-on-client-session', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2025-06-24 21:59:32.731688', 145, 'EXECUTED', '9:24972d83bf27317a055d234187bb4af9', 'dropIndex indexName=IDX_US_SESS_ID_ON_CL_SESS, tableName=OFFLINE_CLIENT_SESSION', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('26.0.0.32582-remove-tables-user-session-user-session-note-and-client-session', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2025-06-24 21:59:32.748695', 146, 'EXECUTED', '9:febdc0f47f2ed241c59e60f58c3ceea5', 'dropTable tableName=CLIENT_SESSION_ROLE; dropTable tableName=CLIENT_SESSION_NOTE; dropTable tableName=CLIENT_SESSION_PROT_MAPPER; dropTable tableName=CLIENT_SESSION_AUTH_STATUS; dropTable tableName=CLIENT_USER_SESSION_NOTE; dropTable tableName=CLI...', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('26.0.0-33201-org-redirect-url', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2025-06-24 21:59:32.751159', 147, 'EXECUTED', '9:4d0e22b0ac68ebe9794fa9cb752ea660', 'addColumn tableName=ORG', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('29399-jdbc-ping-default', 'keycloak', 'META-INF/jpa-changelog-26.1.0.xml', '2025-06-24 21:59:32.761076', 148, 'EXECUTED', '9:007dbe99d7203fca403b89d4edfdf21e', 'createTable tableName=JGROUPS_PING; addPrimaryKey constraintName=CONSTRAINT_JGROUPS_PING, tableName=JGROUPS_PING', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('26.1.0-34013', 'keycloak', 'META-INF/jpa-changelog-26.1.0.xml', '2025-06-24 21:59:32.766499', 149, 'EXECUTED', '9:e6b686a15759aef99a6d758a5c4c6a26', 'addColumn tableName=ADMIN_EVENT_ENTITY', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('26.1.0-34380', 'keycloak', 'META-INF/jpa-changelog-26.1.0.xml', '2025-06-24 21:59:32.770242', 150, 'EXECUTED', '9:ac8b9edb7c2b6c17a1c7a11fcf5ccf01', 'dropTable tableName=USERNAME_LOGIN_FAILURE', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('26.2.0-36750', 'keycloak', 'META-INF/jpa-changelog-26.2.0.xml', '2025-06-24 21:59:32.777809', 151, 'EXECUTED', '9:b49ce951c22f7eb16480ff085640a33a', 'createTable tableName=SERVER_CONFIG', '', NULL, '4.29.1', NULL, NULL, '0802367997');
INSERT INTO public.databasechangelog VALUES ('26.2.0-26106', 'keycloak', 'META-INF/jpa-changelog-26.2.0.xml', '2025-06-24 21:59:32.780438', 152, 'EXECUTED', '9:b5877d5dab7d10ff3a9d209d7beb6680', 'addColumn tableName=CREDENTIAL', '', NULL, '4.29.1', NULL, NULL, '0802367997');


--
-- TOC entry 4141 (class 0 OID 16452)
-- Dependencies: 227
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.databasechangeloglock VALUES (1, false, NULL, NULL);
INSERT INTO public.databasechangeloglock VALUES (1000, false, NULL, NULL);


--
-- TOC entry 4216 (class 0 OID 17848)
-- Dependencies: 302
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.default_client_scope VALUES ('daad7bd4-4102-4d74-9ab2-5299b9560d6e', '87aca32d-a3ee-4c42-836c-f49aefb46a67', false);
INSERT INTO public.default_client_scope VALUES ('daad7bd4-4102-4d74-9ab2-5299b9560d6e', '8c10808e-ded5-496d-ac25-02c270bd48d2', true);
INSERT INTO public.default_client_scope VALUES ('daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'b2616195-e18b-4c39-b8fa-f4086b5c2465', true);
INSERT INTO public.default_client_scope VALUES ('daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'f2e21020-9113-4c7b-b5ec-75ad0901f583', true);
INSERT INTO public.default_client_scope VALUES ('daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'e4ded42f-cc10-46ab-b7cb-42305209f3e5', true);
INSERT INTO public.default_client_scope VALUES ('daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'f5f6b973-9f91-451c-8c91-159d5fc1e3f0', false);
INSERT INTO public.default_client_scope VALUES ('daad7bd4-4102-4d74-9ab2-5299b9560d6e', '3e0086dd-e3c2-46a0-9890-1c74fec6746f', false);
INSERT INTO public.default_client_scope VALUES ('daad7bd4-4102-4d74-9ab2-5299b9560d6e', '7270e881-a9b1-4e8e-b05f-6965d159420c', true);
INSERT INTO public.default_client_scope VALUES ('daad7bd4-4102-4d74-9ab2-5299b9560d6e', '9eac3e21-f7cd-4963-b31d-08c936294e75', true);
INSERT INTO public.default_client_scope VALUES ('daad7bd4-4102-4d74-9ab2-5299b9560d6e', '9e449c32-17c2-4361-be3c-6489cb6fbaae', false);
INSERT INTO public.default_client_scope VALUES ('daad7bd4-4102-4d74-9ab2-5299b9560d6e', '7555b05b-cdb5-4d18-bca5-14cb14fc54c4', true);
INSERT INTO public.default_client_scope VALUES ('daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'aa5be95f-8ac4-44fd-a6b1-91ce9dd00ddd', true);
INSERT INTO public.default_client_scope VALUES ('daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'a36b360e-22a9-4e2b-b414-f35f074bebb4', false);
INSERT INTO public.default_client_scope VALUES ('69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'bad27911-d297-43c4-a6e3-1cfbafe21873', false);
INSERT INTO public.default_client_scope VALUES ('69cd0ddd-5526-4bfb-a3ae-e06de409092f', '1e0c365e-024c-449d-8b6b-99c45bb9a2e9', true);
INSERT INTO public.default_client_scope VALUES ('69cd0ddd-5526-4bfb-a3ae-e06de409092f', '9a3b06f7-6e59-425c-8f07-59063f01c31d', true);
INSERT INTO public.default_client_scope VALUES ('69cd0ddd-5526-4bfb-a3ae-e06de409092f', '5af83cdc-79b9-4dff-8058-be30f7d9fe0b', true);
INSERT INTO public.default_client_scope VALUES ('69cd0ddd-5526-4bfb-a3ae-e06de409092f', '42f6a492-06ac-4d5f-baad-20a4277513fd', true);
INSERT INTO public.default_client_scope VALUES ('69cd0ddd-5526-4bfb-a3ae-e06de409092f', '45d8af74-2522-4235-937a-36ea8f116ca9', false);
INSERT INTO public.default_client_scope VALUES ('69cd0ddd-5526-4bfb-a3ae-e06de409092f', '73dec430-d7e6-4f6b-a545-77d6c36477a4', false);
INSERT INTO public.default_client_scope VALUES ('69cd0ddd-5526-4bfb-a3ae-e06de409092f', '76ca96ef-c1f1-4391-bf0f-7d517bc93493', true);
INSERT INTO public.default_client_scope VALUES ('69cd0ddd-5526-4bfb-a3ae-e06de409092f', '88c5b77f-4dc5-4d59-8c4a-8d566a341731', true);
INSERT INTO public.default_client_scope VALUES ('69cd0ddd-5526-4bfb-a3ae-e06de409092f', '8cd41824-2347-429a-9835-6f7114b4de95', false);
INSERT INTO public.default_client_scope VALUES ('69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'bb97193c-f940-4f56-a919-bb92b5c3494e', true);
INSERT INTO public.default_client_scope VALUES ('69cd0ddd-5526-4bfb-a3ae-e06de409092f', '74a6ef1b-e14f-4daa-8ff6-78fb96fb0dd3', true);
INSERT INTO public.default_client_scope VALUES ('69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'ce1df5dc-d996-4b71-8804-aa542da33570', false);


--
-- TOC entry 4146 (class 0 OID 16492)
-- Dependencies: 232
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4204 (class 0 OID 17547)
-- Dependencies: 290
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4205 (class 0 OID 17552)
-- Dependencies: 291
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4218 (class 0 OID 17874)
-- Dependencies: 304
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4206 (class 0 OID 17561)
-- Dependencies: 292
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4207 (class 0 OID 17570)
-- Dependencies: 293
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4208 (class 0 OID 17573)
-- Dependencies: 294
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4209 (class 0 OID 17579)
-- Dependencies: 295
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4166 (class 0 OID 16869)
-- Dependencies: 252
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4212 (class 0 OID 17644)
-- Dependencies: 298
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4188 (class 0 OID 17271)
-- Dependencies: 274
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4187 (class 0 OID 17268)
-- Dependencies: 273
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4167 (class 0 OID 16874)
-- Dependencies: 253
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4168 (class 0 OID 16883)
-- Dependencies: 254
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4172 (class 0 OID 16987)
-- Dependencies: 258
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4173 (class 0 OID 16992)
-- Dependencies: 259
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4227 (class 0 OID 18073)
-- Dependencies: 313
-- Data for Name: jgroups_ping; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4186 (class 0 OID 17265)
-- Dependencies: 272
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4147 (class 0 OID 16500)
-- Dependencies: 233
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.keycloak_role VALUES ('3f35f02e-f5ac-41f3-85a0-521590599c9b', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', false, '${role_default-roles}', 'default-roles-master', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', NULL, NULL);
INSERT INTO public.keycloak_role VALUES ('5e5646e2-8bd2-4dd8-9c80-33b2c87873c0', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', false, '${role_admin}', 'admin', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', NULL, NULL);
INSERT INTO public.keycloak_role VALUES ('f057685e-676d-49dc-83e7-5b6ccd283906', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', false, '${role_create-realm}', 'create-realm', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', NULL, NULL);
INSERT INTO public.keycloak_role VALUES ('3afab410-5d09-4c8e-90ee-f2831cf46386', '179c4036-632c-4607-9dbe-ad5f232b7055', true, '${role_create-client}', 'create-client', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', '179c4036-632c-4607-9dbe-ad5f232b7055', NULL);
INSERT INTO public.keycloak_role VALUES ('58f032cf-ecfb-4c86-bf9b-95606504ec87', '179c4036-632c-4607-9dbe-ad5f232b7055', true, '${role_view-realm}', 'view-realm', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', '179c4036-632c-4607-9dbe-ad5f232b7055', NULL);
INSERT INTO public.keycloak_role VALUES ('ce3c05e7-1d5d-47fd-85bd-4d9b00a6d56c', '179c4036-632c-4607-9dbe-ad5f232b7055', true, '${role_view-users}', 'view-users', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', '179c4036-632c-4607-9dbe-ad5f232b7055', NULL);
INSERT INTO public.keycloak_role VALUES ('bde0a063-b43e-4a8f-b197-2a3e0fa22c4d', '179c4036-632c-4607-9dbe-ad5f232b7055', true, '${role_view-clients}', 'view-clients', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', '179c4036-632c-4607-9dbe-ad5f232b7055', NULL);
INSERT INTO public.keycloak_role VALUES ('cd958424-8805-4438-ba4f-425b5b67d880', '179c4036-632c-4607-9dbe-ad5f232b7055', true, '${role_view-events}', 'view-events', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', '179c4036-632c-4607-9dbe-ad5f232b7055', NULL);
INSERT INTO public.keycloak_role VALUES ('28734bba-4a07-456d-b052-6ae4ddf2a6ef', '179c4036-632c-4607-9dbe-ad5f232b7055', true, '${role_view-identity-providers}', 'view-identity-providers', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', '179c4036-632c-4607-9dbe-ad5f232b7055', NULL);
INSERT INTO public.keycloak_role VALUES ('3b98f35e-195a-495b-b82d-5cea5254f0f6', '179c4036-632c-4607-9dbe-ad5f232b7055', true, '${role_view-authorization}', 'view-authorization', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', '179c4036-632c-4607-9dbe-ad5f232b7055', NULL);
INSERT INTO public.keycloak_role VALUES ('746d529f-0a77-4d07-ae69-0422ba08edfb', '179c4036-632c-4607-9dbe-ad5f232b7055', true, '${role_manage-realm}', 'manage-realm', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', '179c4036-632c-4607-9dbe-ad5f232b7055', NULL);
INSERT INTO public.keycloak_role VALUES ('0a2d1446-0b07-47cb-bbfe-567988375304', '179c4036-632c-4607-9dbe-ad5f232b7055', true, '${role_manage-users}', 'manage-users', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', '179c4036-632c-4607-9dbe-ad5f232b7055', NULL);
INSERT INTO public.keycloak_role VALUES ('fc32d7d9-673b-42d8-bc8c-056fd73e3ecc', '179c4036-632c-4607-9dbe-ad5f232b7055', true, '${role_manage-clients}', 'manage-clients', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', '179c4036-632c-4607-9dbe-ad5f232b7055', NULL);
INSERT INTO public.keycloak_role VALUES ('5c6c4458-de89-40c3-9986-7c6e839f8aa4', '179c4036-632c-4607-9dbe-ad5f232b7055', true, '${role_manage-events}', 'manage-events', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', '179c4036-632c-4607-9dbe-ad5f232b7055', NULL);
INSERT INTO public.keycloak_role VALUES ('8203286f-22a7-4dbf-9d73-8bcfc449a0ec', '179c4036-632c-4607-9dbe-ad5f232b7055', true, '${role_manage-identity-providers}', 'manage-identity-providers', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', '179c4036-632c-4607-9dbe-ad5f232b7055', NULL);
INSERT INTO public.keycloak_role VALUES ('7ea982a8-f4b6-4f0a-8004-7b5d1eef874d', '179c4036-632c-4607-9dbe-ad5f232b7055', true, '${role_manage-authorization}', 'manage-authorization', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', '179c4036-632c-4607-9dbe-ad5f232b7055', NULL);
INSERT INTO public.keycloak_role VALUES ('aa50a49b-0af7-45dd-9abf-aa39882712c7', '179c4036-632c-4607-9dbe-ad5f232b7055', true, '${role_query-users}', 'query-users', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', '179c4036-632c-4607-9dbe-ad5f232b7055', NULL);
INSERT INTO public.keycloak_role VALUES ('60ae4b21-e2a7-4691-9736-e330a6872585', '179c4036-632c-4607-9dbe-ad5f232b7055', true, '${role_query-clients}', 'query-clients', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', '179c4036-632c-4607-9dbe-ad5f232b7055', NULL);
INSERT INTO public.keycloak_role VALUES ('c8d17b34-eb12-4ca3-a856-96eab2e658bc', '179c4036-632c-4607-9dbe-ad5f232b7055', true, '${role_query-realms}', 'query-realms', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', '179c4036-632c-4607-9dbe-ad5f232b7055', NULL);
INSERT INTO public.keycloak_role VALUES ('4ed2376d-2b87-4bcf-b1c0-1b6da4a077c9', '179c4036-632c-4607-9dbe-ad5f232b7055', true, '${role_query-groups}', 'query-groups', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', '179c4036-632c-4607-9dbe-ad5f232b7055', NULL);
INSERT INTO public.keycloak_role VALUES ('78f4d7bd-4968-4f37-8e86-8ec1d7cd35a2', 'e4e8820d-84e9-4071-97ae-c32d108fa736', true, '${role_view-profile}', 'view-profile', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'e4e8820d-84e9-4071-97ae-c32d108fa736', NULL);
INSERT INTO public.keycloak_role VALUES ('4a442c8f-2d67-4b33-b2c6-792140846e5e', 'e4e8820d-84e9-4071-97ae-c32d108fa736', true, '${role_manage-account}', 'manage-account', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'e4e8820d-84e9-4071-97ae-c32d108fa736', NULL);
INSERT INTO public.keycloak_role VALUES ('a1cb113a-e788-4151-80c0-1be1edc7daad', 'e4e8820d-84e9-4071-97ae-c32d108fa736', true, '${role_manage-account-links}', 'manage-account-links', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'e4e8820d-84e9-4071-97ae-c32d108fa736', NULL);
INSERT INTO public.keycloak_role VALUES ('dbe0da10-bd25-4b69-9b2a-87a5518b27f2', 'e4e8820d-84e9-4071-97ae-c32d108fa736', true, '${role_view-applications}', 'view-applications', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'e4e8820d-84e9-4071-97ae-c32d108fa736', NULL);
INSERT INTO public.keycloak_role VALUES ('07f7183b-4b9f-446d-b154-fd0a0fcda6f0', 'e4e8820d-84e9-4071-97ae-c32d108fa736', true, '${role_view-consent}', 'view-consent', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'e4e8820d-84e9-4071-97ae-c32d108fa736', NULL);
INSERT INTO public.keycloak_role VALUES ('2827c386-eff9-4397-bb80-3f52bfcaa07e', 'e4e8820d-84e9-4071-97ae-c32d108fa736', true, '${role_manage-consent}', 'manage-consent', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'e4e8820d-84e9-4071-97ae-c32d108fa736', NULL);
INSERT INTO public.keycloak_role VALUES ('1e15280b-458b-473e-8cb3-c6673eeadcb1', 'e4e8820d-84e9-4071-97ae-c32d108fa736', true, '${role_view-groups}', 'view-groups', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'e4e8820d-84e9-4071-97ae-c32d108fa736', NULL);
INSERT INTO public.keycloak_role VALUES ('2ed168f7-ce35-457a-9413-473dc3d59d05', 'e4e8820d-84e9-4071-97ae-c32d108fa736', true, '${role_delete-account}', 'delete-account', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'e4e8820d-84e9-4071-97ae-c32d108fa736', NULL);
INSERT INTO public.keycloak_role VALUES ('bb4d9683-31d2-4c5d-92a3-496b785f74cf', 'cc52728e-30ff-4d7c-9439-d39e48d61982', true, '${role_read-token}', 'read-token', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'cc52728e-30ff-4d7c-9439-d39e48d61982', NULL);
INSERT INTO public.keycloak_role VALUES ('570adb53-0062-4b2c-bd83-fed56b0c0e71', '179c4036-632c-4607-9dbe-ad5f232b7055', true, '${role_impersonation}', 'impersonation', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', '179c4036-632c-4607-9dbe-ad5f232b7055', NULL);
INSERT INTO public.keycloak_role VALUES ('f06a2fc4-1bfd-45d9-b477-3a5394250b8b', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', false, '${role_offline-access}', 'offline_access', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', NULL, NULL);
INSERT INTO public.keycloak_role VALUES ('d179f32b-2338-4ea2-916a-2d3dd436652a', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', false, '${role_uma_authorization}', 'uma_authorization', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', NULL, NULL);
INSERT INTO public.keycloak_role VALUES ('133c74bd-6684-4acb-93cf-38d4e10194b8', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', false, '${role_default-roles}', 'default-roles-dev', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', NULL, NULL);
INSERT INTO public.keycloak_role VALUES ('708a75dd-c9d2-4a6d-b17c-17db1eb36396', 'da3bb693-3bb8-4d95-97e4-cdf0427cdf45', true, '${role_create-client}', 'create-client', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'da3bb693-3bb8-4d95-97e4-cdf0427cdf45', NULL);
INSERT INTO public.keycloak_role VALUES ('08c24826-8f0c-42fb-b09b-09660c1877aa', 'da3bb693-3bb8-4d95-97e4-cdf0427cdf45', true, '${role_view-realm}', 'view-realm', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'da3bb693-3bb8-4d95-97e4-cdf0427cdf45', NULL);
INSERT INTO public.keycloak_role VALUES ('806a8a32-3b87-42d6-a0e0-fbcd260ac77e', 'da3bb693-3bb8-4d95-97e4-cdf0427cdf45', true, '${role_view-users}', 'view-users', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'da3bb693-3bb8-4d95-97e4-cdf0427cdf45', NULL);
INSERT INTO public.keycloak_role VALUES ('5afb354f-b2a2-4fad-8e85-aa3b8a8f1782', 'da3bb693-3bb8-4d95-97e4-cdf0427cdf45', true, '${role_view-clients}', 'view-clients', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'da3bb693-3bb8-4d95-97e4-cdf0427cdf45', NULL);
INSERT INTO public.keycloak_role VALUES ('a7512452-5bd3-4aa2-8d01-41f7057c1cd2', 'da3bb693-3bb8-4d95-97e4-cdf0427cdf45', true, '${role_view-events}', 'view-events', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'da3bb693-3bb8-4d95-97e4-cdf0427cdf45', NULL);
INSERT INTO public.keycloak_role VALUES ('f57c68fa-c19d-4745-8e0e-4c90abc270ee', 'da3bb693-3bb8-4d95-97e4-cdf0427cdf45', true, '${role_view-identity-providers}', 'view-identity-providers', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'da3bb693-3bb8-4d95-97e4-cdf0427cdf45', NULL);
INSERT INTO public.keycloak_role VALUES ('e9233b01-1713-4635-a632-5603fd306148', 'da3bb693-3bb8-4d95-97e4-cdf0427cdf45', true, '${role_view-authorization}', 'view-authorization', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'da3bb693-3bb8-4d95-97e4-cdf0427cdf45', NULL);
INSERT INTO public.keycloak_role VALUES ('156b2241-9593-4dca-8249-a361c7690123', 'da3bb693-3bb8-4d95-97e4-cdf0427cdf45', true, '${role_manage-realm}', 'manage-realm', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'da3bb693-3bb8-4d95-97e4-cdf0427cdf45', NULL);
INSERT INTO public.keycloak_role VALUES ('27d19ad8-1b7d-4b37-adff-f0ab7ce19065', 'da3bb693-3bb8-4d95-97e4-cdf0427cdf45', true, '${role_manage-users}', 'manage-users', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'da3bb693-3bb8-4d95-97e4-cdf0427cdf45', NULL);
INSERT INTO public.keycloak_role VALUES ('8f1df5db-35b6-4989-a439-63929338df4b', 'da3bb693-3bb8-4d95-97e4-cdf0427cdf45', true, '${role_manage-clients}', 'manage-clients', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'da3bb693-3bb8-4d95-97e4-cdf0427cdf45', NULL);
INSERT INTO public.keycloak_role VALUES ('ee4ad49c-5051-4ee6-806d-e0f7fd127cf8', 'da3bb693-3bb8-4d95-97e4-cdf0427cdf45', true, '${role_manage-events}', 'manage-events', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'da3bb693-3bb8-4d95-97e4-cdf0427cdf45', NULL);
INSERT INTO public.keycloak_role VALUES ('cbf8f1c8-891b-4083-a83f-92e7467e41f5', 'da3bb693-3bb8-4d95-97e4-cdf0427cdf45', true, '${role_manage-identity-providers}', 'manage-identity-providers', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'da3bb693-3bb8-4d95-97e4-cdf0427cdf45', NULL);
INSERT INTO public.keycloak_role VALUES ('64403fe4-5cae-4bc2-8ba4-c143c4e08b69', 'da3bb693-3bb8-4d95-97e4-cdf0427cdf45', true, '${role_manage-authorization}', 'manage-authorization', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'da3bb693-3bb8-4d95-97e4-cdf0427cdf45', NULL);
INSERT INTO public.keycloak_role VALUES ('182c3af9-161a-43f1-8a4a-7e891c467d0c', 'da3bb693-3bb8-4d95-97e4-cdf0427cdf45', true, '${role_query-users}', 'query-users', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'da3bb693-3bb8-4d95-97e4-cdf0427cdf45', NULL);
INSERT INTO public.keycloak_role VALUES ('e9e414f0-8717-4fbe-abd8-d0babf870b86', 'da3bb693-3bb8-4d95-97e4-cdf0427cdf45', true, '${role_query-clients}', 'query-clients', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'da3bb693-3bb8-4d95-97e4-cdf0427cdf45', NULL);
INSERT INTO public.keycloak_role VALUES ('e35edf70-84fc-4c4c-8666-eb915c33d01e', 'da3bb693-3bb8-4d95-97e4-cdf0427cdf45', true, '${role_query-realms}', 'query-realms', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'da3bb693-3bb8-4d95-97e4-cdf0427cdf45', NULL);
INSERT INTO public.keycloak_role VALUES ('c0ef4478-e233-491c-8cd1-8fbd810d62f0', 'da3bb693-3bb8-4d95-97e4-cdf0427cdf45', true, '${role_query-groups}', 'query-groups', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'da3bb693-3bb8-4d95-97e4-cdf0427cdf45', NULL);
INSERT INTO public.keycloak_role VALUES ('b7dd5bdf-7a4e-4b59-a060-73a726aa264a', '98fbe1e0-e05c-4b1d-9657-655d6bbcff11', true, '${role_realm-admin}', 'realm-admin', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '98fbe1e0-e05c-4b1d-9657-655d6bbcff11', NULL);
INSERT INTO public.keycloak_role VALUES ('d7ca089b-f7ed-4964-883f-4d5689e6dc53', '98fbe1e0-e05c-4b1d-9657-655d6bbcff11', true, '${role_create-client}', 'create-client', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '98fbe1e0-e05c-4b1d-9657-655d6bbcff11', NULL);
INSERT INTO public.keycloak_role VALUES ('35fe3a33-f75b-4ca4-88bf-8cf6d25fe286', '98fbe1e0-e05c-4b1d-9657-655d6bbcff11', true, '${role_view-realm}', 'view-realm', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '98fbe1e0-e05c-4b1d-9657-655d6bbcff11', NULL);
INSERT INTO public.keycloak_role VALUES ('ed44c94b-5cc7-4ac2-88ff-d27b089f62da', '98fbe1e0-e05c-4b1d-9657-655d6bbcff11', true, '${role_view-users}', 'view-users', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '98fbe1e0-e05c-4b1d-9657-655d6bbcff11', NULL);
INSERT INTO public.keycloak_role VALUES ('55e40f50-f325-4920-ba91-e997aab1049b', '98fbe1e0-e05c-4b1d-9657-655d6bbcff11', true, '${role_view-clients}', 'view-clients', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '98fbe1e0-e05c-4b1d-9657-655d6bbcff11', NULL);
INSERT INTO public.keycloak_role VALUES ('3e0f6973-46f6-430d-9722-56a0ee19c7b6', '98fbe1e0-e05c-4b1d-9657-655d6bbcff11', true, '${role_view-events}', 'view-events', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '98fbe1e0-e05c-4b1d-9657-655d6bbcff11', NULL);
INSERT INTO public.keycloak_role VALUES ('931b2489-e157-4b02-8c5e-f70566734485', '98fbe1e0-e05c-4b1d-9657-655d6bbcff11', true, '${role_view-identity-providers}', 'view-identity-providers', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '98fbe1e0-e05c-4b1d-9657-655d6bbcff11', NULL);
INSERT INTO public.keycloak_role VALUES ('8cb135ad-25dd-43ca-876c-7a8960416b69', '98fbe1e0-e05c-4b1d-9657-655d6bbcff11', true, '${role_view-authorization}', 'view-authorization', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '98fbe1e0-e05c-4b1d-9657-655d6bbcff11', NULL);
INSERT INTO public.keycloak_role VALUES ('c71f143a-3dd1-4994-8239-9e2b3140bbc3', '98fbe1e0-e05c-4b1d-9657-655d6bbcff11', true, '${role_manage-realm}', 'manage-realm', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '98fbe1e0-e05c-4b1d-9657-655d6bbcff11', NULL);
INSERT INTO public.keycloak_role VALUES ('a5397d90-5c59-43c9-99bb-a201601b33db', '98fbe1e0-e05c-4b1d-9657-655d6bbcff11', true, '${role_manage-users}', 'manage-users', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '98fbe1e0-e05c-4b1d-9657-655d6bbcff11', NULL);
INSERT INTO public.keycloak_role VALUES ('29cda7fb-9fd9-4e5a-befb-69388fb511f8', '98fbe1e0-e05c-4b1d-9657-655d6bbcff11', true, '${role_manage-clients}', 'manage-clients', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '98fbe1e0-e05c-4b1d-9657-655d6bbcff11', NULL);
INSERT INTO public.keycloak_role VALUES ('19b5f18e-861a-42f2-9ce7-71c2b7c2a5ba', '98fbe1e0-e05c-4b1d-9657-655d6bbcff11', true, '${role_manage-events}', 'manage-events', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '98fbe1e0-e05c-4b1d-9657-655d6bbcff11', NULL);
INSERT INTO public.keycloak_role VALUES ('8a773344-4fda-4e1b-b0a3-88fdf02c84b2', '98fbe1e0-e05c-4b1d-9657-655d6bbcff11', true, '${role_manage-identity-providers}', 'manage-identity-providers', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '98fbe1e0-e05c-4b1d-9657-655d6bbcff11', NULL);
INSERT INTO public.keycloak_role VALUES ('ba2498fd-60e5-4b0e-b3a9-2cf834ddd2ae', '98fbe1e0-e05c-4b1d-9657-655d6bbcff11', true, '${role_manage-authorization}', 'manage-authorization', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '98fbe1e0-e05c-4b1d-9657-655d6bbcff11', NULL);
INSERT INTO public.keycloak_role VALUES ('e82321ed-5b76-410b-bc25-ab524a00187c', '98fbe1e0-e05c-4b1d-9657-655d6bbcff11', true, '${role_query-users}', 'query-users', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '98fbe1e0-e05c-4b1d-9657-655d6bbcff11', NULL);
INSERT INTO public.keycloak_role VALUES ('fc8cb9e6-95cb-4c77-b7bc-0832035cf616', '98fbe1e0-e05c-4b1d-9657-655d6bbcff11', true, '${role_query-clients}', 'query-clients', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '98fbe1e0-e05c-4b1d-9657-655d6bbcff11', NULL);
INSERT INTO public.keycloak_role VALUES ('91c7e8f4-67ed-4637-b5e8-f6a5d019252c', '98fbe1e0-e05c-4b1d-9657-655d6bbcff11', true, '${role_query-realms}', 'query-realms', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '98fbe1e0-e05c-4b1d-9657-655d6bbcff11', NULL);
INSERT INTO public.keycloak_role VALUES ('43c4e912-8465-44c8-b18c-667898ba97ec', '98fbe1e0-e05c-4b1d-9657-655d6bbcff11', true, '${role_query-groups}', 'query-groups', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '98fbe1e0-e05c-4b1d-9657-655d6bbcff11', NULL);
INSERT INTO public.keycloak_role VALUES ('e328c05d-8bb3-4e22-9025-d45e499922dc', 'a0701c28-b02f-4983-92b4-3f236ac1892c', true, '${role_view-profile}', 'view-profile', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'a0701c28-b02f-4983-92b4-3f236ac1892c', NULL);
INSERT INTO public.keycloak_role VALUES ('f6c5e85a-2400-4dae-96f5-a6647b62ae29', 'a0701c28-b02f-4983-92b4-3f236ac1892c', true, '${role_manage-account}', 'manage-account', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'a0701c28-b02f-4983-92b4-3f236ac1892c', NULL);
INSERT INTO public.keycloak_role VALUES ('97038469-e755-4549-80a3-e593dc917d67', 'a0701c28-b02f-4983-92b4-3f236ac1892c', true, '${role_manage-account-links}', 'manage-account-links', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'a0701c28-b02f-4983-92b4-3f236ac1892c', NULL);
INSERT INTO public.keycloak_role VALUES ('fa727681-4b83-4032-adc9-9bc50fb10f99', 'a0701c28-b02f-4983-92b4-3f236ac1892c', true, '${role_view-applications}', 'view-applications', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'a0701c28-b02f-4983-92b4-3f236ac1892c', NULL);
INSERT INTO public.keycloak_role VALUES ('5cd16e45-e60d-4992-8dce-788511daf645', 'a0701c28-b02f-4983-92b4-3f236ac1892c', true, '${role_view-consent}', 'view-consent', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'a0701c28-b02f-4983-92b4-3f236ac1892c', NULL);
INSERT INTO public.keycloak_role VALUES ('13bfc48d-8450-43b3-8d0d-cb449ff9fe38', 'a0701c28-b02f-4983-92b4-3f236ac1892c', true, '${role_manage-consent}', 'manage-consent', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'a0701c28-b02f-4983-92b4-3f236ac1892c', NULL);
INSERT INTO public.keycloak_role VALUES ('3b4b4e7b-ca12-4b76-9b0e-0d7d343c6bf2', 'a0701c28-b02f-4983-92b4-3f236ac1892c', true, '${role_view-groups}', 'view-groups', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'a0701c28-b02f-4983-92b4-3f236ac1892c', NULL);
INSERT INTO public.keycloak_role VALUES ('8d17ac0c-8470-40b9-87c8-e62d0b4b3900', 'a0701c28-b02f-4983-92b4-3f236ac1892c', true, '${role_delete-account}', 'delete-account', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'a0701c28-b02f-4983-92b4-3f236ac1892c', NULL);
INSERT INTO public.keycloak_role VALUES ('526a9910-a769-43bb-a19a-c4c570c96574', 'da3bb693-3bb8-4d95-97e4-cdf0427cdf45', true, '${role_impersonation}', 'impersonation', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'da3bb693-3bb8-4d95-97e4-cdf0427cdf45', NULL);
INSERT INTO public.keycloak_role VALUES ('cef9a373-4a02-403b-9775-8b2d5305f44e', '98fbe1e0-e05c-4b1d-9657-655d6bbcff11', true, '${role_impersonation}', 'impersonation', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '98fbe1e0-e05c-4b1d-9657-655d6bbcff11', NULL);
INSERT INTO public.keycloak_role VALUES ('0124ea33-5087-4c5c-acf1-b07f1aae3771', 'f49cc655-5b50-48b4-8ab7-aed5b0da236d', true, '${role_read-token}', 'read-token', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'f49cc655-5b50-48b4-8ab7-aed5b0da236d', NULL);
INSERT INTO public.keycloak_role VALUES ('18088f05-b3a0-4ffe-8616-5d7613ebc772', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', false, '${role_offline-access}', 'offline_access', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', NULL, NULL);
INSERT INTO public.keycloak_role VALUES ('dfdb7a56-d535-4124-b416-a0c603404a18', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', false, '${role_uma_authorization}', 'uma_authorization', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', NULL, NULL);


--
-- TOC entry 4171 (class 0 OID 16984)
-- Dependencies: 257
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.migration_model VALUES ('wmso1', '26.2.5', 1750802373);


--
-- TOC entry 4185 (class 0 OID 17256)
-- Dependencies: 271
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.offline_client_session VALUES ('f6a4abce-1da7-4ce8-a3b6-eaf89a7a84d1', 'e2e94889-cf64-4b4c-aea4-1f85993cfde1', '0', 1750879119, '{"authMethod":"openid-connect","redirectUri":"http://localhost:3001/auth/keycloak/callback","notes":{"clientId":"e2e94889-cf64-4b4c-aea4-1f85993cfde1","iss":"http://localhost:8081/realms/dev","startedAt":"1750879119","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"uOMqvw3TSsSy4LGh-xF8t5u0zBy7M9RKRrw-3OQAsJDkOGdF","response_mode":"form_post","scope":"openid","userSessionStartedAt":"1750879119","redirect_uri":"http://localhost:3001/auth/keycloak/callback","code_challenge":"9DPjDmCaYVb7Jyhgf2fjMJvBsruGh3UwYgsLoBo2KNY"}}', 'local', 'local', 0);


--
-- TOC entry 4184 (class 0 OID 17251)
-- Dependencies: 270
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.offline_user_session VALUES ('f6a4abce-1da7-4ce8-a3b6-eaf89a7a84d1', 'd07916df-b022-4f2a-b652-94aa14209064', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 1750879119, '0', '{"ipAddress":"172.19.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTkuMC4xIiwib3MiOiJMaW51eCIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiRmlyZWZveC8xNDAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1750879119","authenticators-completed":"{\"6e2144bb-d9cb-4f32-8a1e-cc16612d6781\":1750879119}"},"state":"LOGGED_IN"}', 1750879119, NULL, 0);


--
-- TOC entry 4224 (class 0 OID 18036)
-- Dependencies: 310
-- Data for Name: org; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4225 (class 0 OID 18047)
-- Dependencies: 311
-- Data for Name: org_domain; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4198 (class 0 OID 17470)
-- Dependencies: 284
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4164 (class 0 OID 16858)
-- Dependencies: 250
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.protocol_mapper VALUES ('a4304293-0a81-46a2-8354-455ff5fdf8c0', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', '37841806-a6d9-4b1d-a09b-93346087acb8', NULL);
INSERT INTO public.protocol_mapper VALUES ('f55c7c6f-c9be-4e87-b902-2b37081d9816', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', 'ac970ba9-a5aa-422d-8207-55d4ab698d1c', NULL);
INSERT INTO public.protocol_mapper VALUES ('c992efa3-77ed-4664-a8c2-90e49e5e88f4', 'role list', 'saml', 'saml-role-list-mapper', NULL, '8c10808e-ded5-496d-ac25-02c270bd48d2');
INSERT INTO public.protocol_mapper VALUES ('ce544360-86cd-4288-a102-ba9d693ac5fa', 'organization', 'saml', 'saml-organization-membership-mapper', NULL, 'b2616195-e18b-4c39-b8fa-f4086b5c2465');
INSERT INTO public.protocol_mapper VALUES ('cc8fb72c-60c7-4fcd-9b6e-57effdcc3a17', 'full name', 'openid-connect', 'oidc-full-name-mapper', NULL, 'f2e21020-9113-4c7b-b5ec-75ad0901f583');
INSERT INTO public.protocol_mapper VALUES ('d794e120-f1dc-4d13-922e-dd90dcbcd7ee', 'family name', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'f2e21020-9113-4c7b-b5ec-75ad0901f583');
INSERT INTO public.protocol_mapper VALUES ('24324a08-60be-4ad2-8053-8fd7342d2749', 'given name', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'f2e21020-9113-4c7b-b5ec-75ad0901f583');
INSERT INTO public.protocol_mapper VALUES ('3395f0f9-3f0e-4a89-9aaf-cbe32e1691a5', 'middle name', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'f2e21020-9113-4c7b-b5ec-75ad0901f583');
INSERT INTO public.protocol_mapper VALUES ('9730941e-c09a-4961-b056-9a25fcc38bcb', 'nickname', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'f2e21020-9113-4c7b-b5ec-75ad0901f583');
INSERT INTO public.protocol_mapper VALUES ('ec60e863-abc7-4e0d-88a1-b2d23b553596', 'username', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'f2e21020-9113-4c7b-b5ec-75ad0901f583');
INSERT INTO public.protocol_mapper VALUES ('d4e8e4cf-52b2-4314-96a2-6b2c7f6a3da4', 'profile', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'f2e21020-9113-4c7b-b5ec-75ad0901f583');
INSERT INTO public.protocol_mapper VALUES ('68840007-f604-46a4-9af7-56d8074ab456', 'picture', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'f2e21020-9113-4c7b-b5ec-75ad0901f583');
INSERT INTO public.protocol_mapper VALUES ('1b4efaf6-2b1c-412a-a0d2-2ee47baefa5c', 'website', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'f2e21020-9113-4c7b-b5ec-75ad0901f583');
INSERT INTO public.protocol_mapper VALUES ('4f98f1f8-e0ca-4d73-9a96-a6a41559da1f', 'gender', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'f2e21020-9113-4c7b-b5ec-75ad0901f583');
INSERT INTO public.protocol_mapper VALUES ('fddda3b2-2309-49ee-b17a-1f4ba3281736', 'birthdate', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'f2e21020-9113-4c7b-b5ec-75ad0901f583');
INSERT INTO public.protocol_mapper VALUES ('5b4c8ddc-3510-497e-9fac-f3e48dc229d4', 'zoneinfo', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'f2e21020-9113-4c7b-b5ec-75ad0901f583');
INSERT INTO public.protocol_mapper VALUES ('e4da859a-d52d-4fc2-9b2c-ea53b76bd0e8', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'f2e21020-9113-4c7b-b5ec-75ad0901f583');
INSERT INTO public.protocol_mapper VALUES ('c710fd73-7929-4f33-bdca-be89e370f635', 'updated at', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'f2e21020-9113-4c7b-b5ec-75ad0901f583');
INSERT INTO public.protocol_mapper VALUES ('df913294-64aa-492b-94af-fd86f592205c', 'email', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'e4ded42f-cc10-46ab-b7cb-42305209f3e5');
INSERT INTO public.protocol_mapper VALUES ('f9542294-2a1a-4db4-9759-63f58c0c9c51', 'email verified', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, 'e4ded42f-cc10-46ab-b7cb-42305209f3e5');
INSERT INTO public.protocol_mapper VALUES ('b3176e3d-a160-4d8c-b936-da9bf4198de3', 'address', 'openid-connect', 'oidc-address-mapper', NULL, 'f5f6b973-9f91-451c-8c91-159d5fc1e3f0');
INSERT INTO public.protocol_mapper VALUES ('c9a307ff-e9e6-4c71-943d-a9d710bb88e4', 'phone number', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '3e0086dd-e3c2-46a0-9890-1c74fec6746f');
INSERT INTO public.protocol_mapper VALUES ('4eb99f32-5b5e-42ba-ad31-5a94a8f156c0', 'phone number verified', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '3e0086dd-e3c2-46a0-9890-1c74fec6746f');
INSERT INTO public.protocol_mapper VALUES ('9cafe4d6-4128-4fba-9901-6789b9e175e1', 'realm roles', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, '7270e881-a9b1-4e8e-b05f-6965d159420c');
INSERT INTO public.protocol_mapper VALUES ('2fa083e4-5489-4203-8105-dc10de4e4029', 'client roles', 'openid-connect', 'oidc-usermodel-client-role-mapper', NULL, '7270e881-a9b1-4e8e-b05f-6965d159420c');
INSERT INTO public.protocol_mapper VALUES ('cb943c17-69b2-419f-90e3-f5e23ce015b6', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', NULL, '7270e881-a9b1-4e8e-b05f-6965d159420c');
INSERT INTO public.protocol_mapper VALUES ('202a1106-26a0-4b15-811e-302ac846c673', 'allowed web origins', 'openid-connect', 'oidc-allowed-origins-mapper', NULL, '9eac3e21-f7cd-4963-b31d-08c936294e75');
INSERT INTO public.protocol_mapper VALUES ('f1b28079-82b4-41a3-acb5-8103143b5000', 'upn', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '9e449c32-17c2-4361-be3c-6489cb6fbaae');
INSERT INTO public.protocol_mapper VALUES ('af0e44c2-5391-4ed3-886a-a63695000be1', 'groups', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, '9e449c32-17c2-4361-be3c-6489cb6fbaae');
INSERT INTO public.protocol_mapper VALUES ('9d55e137-c0e9-4030-9369-2dd419637382', 'acr loa level', 'openid-connect', 'oidc-acr-mapper', NULL, '7555b05b-cdb5-4d18-bca5-14cb14fc54c4');
INSERT INTO public.protocol_mapper VALUES ('1f2be02f-59fe-468d-a080-2f18b31a3b75', 'auth_time', 'openid-connect', 'oidc-usersessionmodel-note-mapper', NULL, 'aa5be95f-8ac4-44fd-a6b1-91ce9dd00ddd');
INSERT INTO public.protocol_mapper VALUES ('18b5a003-dd07-4ba5-829a-5b5877785416', 'sub', 'openid-connect', 'oidc-sub-mapper', NULL, 'aa5be95f-8ac4-44fd-a6b1-91ce9dd00ddd');
INSERT INTO public.protocol_mapper VALUES ('2c10a999-9d96-4558-b224-bf1b93a9132d', 'Client ID', 'openid-connect', 'oidc-usersessionmodel-note-mapper', NULL, '2d78c4c5-cb4c-4c71-a5b4-539261af54b3');
INSERT INTO public.protocol_mapper VALUES ('fe0a36e0-f18e-4561-be81-8459be2d514a', 'Client Host', 'openid-connect', 'oidc-usersessionmodel-note-mapper', NULL, '2d78c4c5-cb4c-4c71-a5b4-539261af54b3');
INSERT INTO public.protocol_mapper VALUES ('c3a75b84-8cd0-46ae-81c2-417455fa4c5e', 'Client IP Address', 'openid-connect', 'oidc-usersessionmodel-note-mapper', NULL, '2d78c4c5-cb4c-4c71-a5b4-539261af54b3');
INSERT INTO public.protocol_mapper VALUES ('b585e4fb-550d-4074-aecd-5d919d90b993', 'organization', 'openid-connect', 'oidc-organization-membership-mapper', NULL, 'a36b360e-22a9-4e2b-b414-f35f074bebb4');
INSERT INTO public.protocol_mapper VALUES ('63268325-24a9-4bbc-92ea-c001b3b97c63', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', '48067444-f02b-4a4e-ae0e-709789381883', NULL);
INSERT INTO public.protocol_mapper VALUES ('ab048b26-f178-4ff9-b177-999cba923d7d', 'role list', 'saml', 'saml-role-list-mapper', NULL, '1e0c365e-024c-449d-8b6b-99c45bb9a2e9');
INSERT INTO public.protocol_mapper VALUES ('0d690366-0fcc-41a9-9c2d-6aa2b10161da', 'organization', 'saml', 'saml-organization-membership-mapper', NULL, '9a3b06f7-6e59-425c-8f07-59063f01c31d');
INSERT INTO public.protocol_mapper VALUES ('7cbf0ec8-cdb1-434d-bf7c-0c74d77702e0', 'full name', 'openid-connect', 'oidc-full-name-mapper', NULL, '5af83cdc-79b9-4dff-8058-be30f7d9fe0b');
INSERT INTO public.protocol_mapper VALUES ('83cf1098-bb2b-4af6-846f-55507477819d', 'family name', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '5af83cdc-79b9-4dff-8058-be30f7d9fe0b');
INSERT INTO public.protocol_mapper VALUES ('232b51c5-bee2-4c9a-89e5-3bb2796582f8', 'given name', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '5af83cdc-79b9-4dff-8058-be30f7d9fe0b');
INSERT INTO public.protocol_mapper VALUES ('068020f1-895d-447a-8c9d-9c640375d7c6', 'middle name', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '5af83cdc-79b9-4dff-8058-be30f7d9fe0b');
INSERT INTO public.protocol_mapper VALUES ('81015dc4-1b73-4ffe-b6e3-43f551cfae55', 'nickname', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '5af83cdc-79b9-4dff-8058-be30f7d9fe0b');
INSERT INTO public.protocol_mapper VALUES ('3c54034d-7669-4eb0-9de9-ef5aaa61d9e3', 'username', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '5af83cdc-79b9-4dff-8058-be30f7d9fe0b');
INSERT INTO public.protocol_mapper VALUES ('a827fa64-5cca-4fc1-88a7-89423970fad5', 'profile', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '5af83cdc-79b9-4dff-8058-be30f7d9fe0b');
INSERT INTO public.protocol_mapper VALUES ('1f722abe-4899-4228-b5a2-ded40af3a23c', 'picture', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '5af83cdc-79b9-4dff-8058-be30f7d9fe0b');
INSERT INTO public.protocol_mapper VALUES ('a7b33990-14ad-44f2-aac7-14ed6ebe5b1c', 'website', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '5af83cdc-79b9-4dff-8058-be30f7d9fe0b');
INSERT INTO public.protocol_mapper VALUES ('b77dd162-fdf1-4ecb-86fc-475b6b045878', 'gender', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '5af83cdc-79b9-4dff-8058-be30f7d9fe0b');
INSERT INTO public.protocol_mapper VALUES ('71878ecd-1241-436a-8c3c-24b120b2dbf0', 'birthdate', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '5af83cdc-79b9-4dff-8058-be30f7d9fe0b');
INSERT INTO public.protocol_mapper VALUES ('06bda55b-7d30-4609-818b-cdfff2d11744', 'zoneinfo', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '5af83cdc-79b9-4dff-8058-be30f7d9fe0b');
INSERT INTO public.protocol_mapper VALUES ('d1360c0a-b021-4e2c-b478-87a9250cb967', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '5af83cdc-79b9-4dff-8058-be30f7d9fe0b');
INSERT INTO public.protocol_mapper VALUES ('a100ac3f-8a64-4825-bfa4-54416efb5499', 'updated at', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '5af83cdc-79b9-4dff-8058-be30f7d9fe0b');
INSERT INTO public.protocol_mapper VALUES ('094718e8-59ae-4e20-8c96-091894375ac9', 'email', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '42f6a492-06ac-4d5f-baad-20a4277513fd');
INSERT INTO public.protocol_mapper VALUES ('89f10c0b-18fe-4a1b-9866-3a6833c27235', 'email verified', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '42f6a492-06ac-4d5f-baad-20a4277513fd');
INSERT INTO public.protocol_mapper VALUES ('feff34a9-8eb0-4e5e-93a6-fd783c9f9e91', 'address', 'openid-connect', 'oidc-address-mapper', NULL, '45d8af74-2522-4235-937a-36ea8f116ca9');
INSERT INTO public.protocol_mapper VALUES ('c21582eb-005c-4aef-84e5-56d0e09ede4f', 'phone number', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '73dec430-d7e6-4f6b-a545-77d6c36477a4');
INSERT INTO public.protocol_mapper VALUES ('88010306-c900-4f4c-a1aa-5386c5d2d3ce', 'phone number verified', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '73dec430-d7e6-4f6b-a545-77d6c36477a4');
INSERT INTO public.protocol_mapper VALUES ('c831e0be-1720-4f9c-a16c-8cb6d83e856a', 'realm roles', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, '76ca96ef-c1f1-4391-bf0f-7d517bc93493');
INSERT INTO public.protocol_mapper VALUES ('0727e341-74b7-493b-8f4f-ccccf182a81a', 'client roles', 'openid-connect', 'oidc-usermodel-client-role-mapper', NULL, '76ca96ef-c1f1-4391-bf0f-7d517bc93493');
INSERT INTO public.protocol_mapper VALUES ('e30c2a26-465e-46ed-96de-6db277f5d6c0', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', NULL, '76ca96ef-c1f1-4391-bf0f-7d517bc93493');
INSERT INTO public.protocol_mapper VALUES ('8ab0b551-dc4c-4880-b372-7155e3e9f777', 'allowed web origins', 'openid-connect', 'oidc-allowed-origins-mapper', NULL, '88c5b77f-4dc5-4d59-8c4a-8d566a341731');
INSERT INTO public.protocol_mapper VALUES ('6a3ae63b-872b-476d-be6e-55d4e862102c', 'upn', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '8cd41824-2347-429a-9835-6f7114b4de95');
INSERT INTO public.protocol_mapper VALUES ('919aa59e-ff95-4afe-ada5-a86804c67dfc', 'groups', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, '8cd41824-2347-429a-9835-6f7114b4de95');
INSERT INTO public.protocol_mapper VALUES ('de417a82-092c-4dfc-8b13-c02f6c145aff', 'acr loa level', 'openid-connect', 'oidc-acr-mapper', NULL, 'bb97193c-f940-4f56-a919-bb92b5c3494e');
INSERT INTO public.protocol_mapper VALUES ('49725540-4e01-4dd1-bbdf-854b63564999', 'auth_time', 'openid-connect', 'oidc-usersessionmodel-note-mapper', NULL, '74a6ef1b-e14f-4daa-8ff6-78fb96fb0dd3');
INSERT INTO public.protocol_mapper VALUES ('872dcf87-0e77-457d-a368-e6d52d6bd278', 'sub', 'openid-connect', 'oidc-sub-mapper', NULL, '74a6ef1b-e14f-4daa-8ff6-78fb96fb0dd3');
INSERT INTO public.protocol_mapper VALUES ('02602bb7-b385-43c0-9ef8-c23e92edd508', 'Client ID', 'openid-connect', 'oidc-usersessionmodel-note-mapper', NULL, '3fea0a17-f0e4-47bb-87ae-2afe092304da');
INSERT INTO public.protocol_mapper VALUES ('f5395625-961d-45cc-a4a6-24a2ad52d5ec', 'Client Host', 'openid-connect', 'oidc-usersessionmodel-note-mapper', NULL, '3fea0a17-f0e4-47bb-87ae-2afe092304da');
INSERT INTO public.protocol_mapper VALUES ('4be83064-5df2-4a2b-99e0-bc7a09660519', 'Client IP Address', 'openid-connect', 'oidc-usersessionmodel-note-mapper', NULL, '3fea0a17-f0e4-47bb-87ae-2afe092304da');
INSERT INTO public.protocol_mapper VALUES ('24d07752-b665-4c38-b928-a210500c140e', 'organization', 'openid-connect', 'oidc-organization-membership-mapper', NULL, 'ce1df5dc-d996-4b71-8804-aa542da33570');
INSERT INTO public.protocol_mapper VALUES ('8f4d9e3d-4dd3-4a72-b4ec-cfefee0a0075', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', '369a0d1d-886a-40ee-b1af-dcd66219c391', NULL);


--
-- TOC entry 4165 (class 0 OID 16864)
-- Dependencies: 251
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.protocol_mapper_config VALUES ('f55c7c6f-c9be-4e87-b902-2b37081d9816', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('f55c7c6f-c9be-4e87-b902-2b37081d9816', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('f55c7c6f-c9be-4e87-b902-2b37081d9816', 'locale', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('f55c7c6f-c9be-4e87-b902-2b37081d9816', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('f55c7c6f-c9be-4e87-b902-2b37081d9816', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('f55c7c6f-c9be-4e87-b902-2b37081d9816', 'locale', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('f55c7c6f-c9be-4e87-b902-2b37081d9816', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('c992efa3-77ed-4664-a8c2-90e49e5e88f4', 'false', 'single');
INSERT INTO public.protocol_mapper_config VALUES ('c992efa3-77ed-4664-a8c2-90e49e5e88f4', 'Basic', 'attribute.nameformat');
INSERT INTO public.protocol_mapper_config VALUES ('c992efa3-77ed-4664-a8c2-90e49e5e88f4', 'Role', 'attribute.name');
INSERT INTO public.protocol_mapper_config VALUES ('1b4efaf6-2b1c-412a-a0d2-2ee47baefa5c', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('1b4efaf6-2b1c-412a-a0d2-2ee47baefa5c', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('1b4efaf6-2b1c-412a-a0d2-2ee47baefa5c', 'website', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('1b4efaf6-2b1c-412a-a0d2-2ee47baefa5c', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('1b4efaf6-2b1c-412a-a0d2-2ee47baefa5c', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('1b4efaf6-2b1c-412a-a0d2-2ee47baefa5c', 'website', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('1b4efaf6-2b1c-412a-a0d2-2ee47baefa5c', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('24324a08-60be-4ad2-8053-8fd7342d2749', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('24324a08-60be-4ad2-8053-8fd7342d2749', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('24324a08-60be-4ad2-8053-8fd7342d2749', 'firstName', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('24324a08-60be-4ad2-8053-8fd7342d2749', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('24324a08-60be-4ad2-8053-8fd7342d2749', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('24324a08-60be-4ad2-8053-8fd7342d2749', 'given_name', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('24324a08-60be-4ad2-8053-8fd7342d2749', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('3395f0f9-3f0e-4a89-9aaf-cbe32e1691a5', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('3395f0f9-3f0e-4a89-9aaf-cbe32e1691a5', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('3395f0f9-3f0e-4a89-9aaf-cbe32e1691a5', 'middleName', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('3395f0f9-3f0e-4a89-9aaf-cbe32e1691a5', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('3395f0f9-3f0e-4a89-9aaf-cbe32e1691a5', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('3395f0f9-3f0e-4a89-9aaf-cbe32e1691a5', 'middle_name', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('3395f0f9-3f0e-4a89-9aaf-cbe32e1691a5', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('4f98f1f8-e0ca-4d73-9a96-a6a41559da1f', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('4f98f1f8-e0ca-4d73-9a96-a6a41559da1f', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('4f98f1f8-e0ca-4d73-9a96-a6a41559da1f', 'gender', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('4f98f1f8-e0ca-4d73-9a96-a6a41559da1f', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('4f98f1f8-e0ca-4d73-9a96-a6a41559da1f', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('4f98f1f8-e0ca-4d73-9a96-a6a41559da1f', 'gender', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('4f98f1f8-e0ca-4d73-9a96-a6a41559da1f', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('5b4c8ddc-3510-497e-9fac-f3e48dc229d4', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('5b4c8ddc-3510-497e-9fac-f3e48dc229d4', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('5b4c8ddc-3510-497e-9fac-f3e48dc229d4', 'zoneinfo', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('5b4c8ddc-3510-497e-9fac-f3e48dc229d4', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('5b4c8ddc-3510-497e-9fac-f3e48dc229d4', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('5b4c8ddc-3510-497e-9fac-f3e48dc229d4', 'zoneinfo', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('5b4c8ddc-3510-497e-9fac-f3e48dc229d4', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('68840007-f604-46a4-9af7-56d8074ab456', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('68840007-f604-46a4-9af7-56d8074ab456', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('68840007-f604-46a4-9af7-56d8074ab456', 'picture', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('68840007-f604-46a4-9af7-56d8074ab456', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('68840007-f604-46a4-9af7-56d8074ab456', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('68840007-f604-46a4-9af7-56d8074ab456', 'picture', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('68840007-f604-46a4-9af7-56d8074ab456', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('9730941e-c09a-4961-b056-9a25fcc38bcb', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('9730941e-c09a-4961-b056-9a25fcc38bcb', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('9730941e-c09a-4961-b056-9a25fcc38bcb', 'nickname', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('9730941e-c09a-4961-b056-9a25fcc38bcb', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('9730941e-c09a-4961-b056-9a25fcc38bcb', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('9730941e-c09a-4961-b056-9a25fcc38bcb', 'nickname', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('9730941e-c09a-4961-b056-9a25fcc38bcb', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('c710fd73-7929-4f33-bdca-be89e370f635', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('c710fd73-7929-4f33-bdca-be89e370f635', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('c710fd73-7929-4f33-bdca-be89e370f635', 'updatedAt', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('c710fd73-7929-4f33-bdca-be89e370f635', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('c710fd73-7929-4f33-bdca-be89e370f635', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('c710fd73-7929-4f33-bdca-be89e370f635', 'updated_at', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('c710fd73-7929-4f33-bdca-be89e370f635', 'long', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('cc8fb72c-60c7-4fcd-9b6e-57effdcc3a17', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('cc8fb72c-60c7-4fcd-9b6e-57effdcc3a17', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('cc8fb72c-60c7-4fcd-9b6e-57effdcc3a17', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('cc8fb72c-60c7-4fcd-9b6e-57effdcc3a17', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('d4e8e4cf-52b2-4314-96a2-6b2c7f6a3da4', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('d4e8e4cf-52b2-4314-96a2-6b2c7f6a3da4', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('d4e8e4cf-52b2-4314-96a2-6b2c7f6a3da4', 'profile', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('d4e8e4cf-52b2-4314-96a2-6b2c7f6a3da4', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('d4e8e4cf-52b2-4314-96a2-6b2c7f6a3da4', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('d4e8e4cf-52b2-4314-96a2-6b2c7f6a3da4', 'profile', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('d4e8e4cf-52b2-4314-96a2-6b2c7f6a3da4', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('d794e120-f1dc-4d13-922e-dd90dcbcd7ee', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('d794e120-f1dc-4d13-922e-dd90dcbcd7ee', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('d794e120-f1dc-4d13-922e-dd90dcbcd7ee', 'lastName', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('d794e120-f1dc-4d13-922e-dd90dcbcd7ee', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('d794e120-f1dc-4d13-922e-dd90dcbcd7ee', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('d794e120-f1dc-4d13-922e-dd90dcbcd7ee', 'family_name', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('d794e120-f1dc-4d13-922e-dd90dcbcd7ee', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('e4da859a-d52d-4fc2-9b2c-ea53b76bd0e8', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('e4da859a-d52d-4fc2-9b2c-ea53b76bd0e8', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('e4da859a-d52d-4fc2-9b2c-ea53b76bd0e8', 'locale', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('e4da859a-d52d-4fc2-9b2c-ea53b76bd0e8', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('e4da859a-d52d-4fc2-9b2c-ea53b76bd0e8', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('e4da859a-d52d-4fc2-9b2c-ea53b76bd0e8', 'locale', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('e4da859a-d52d-4fc2-9b2c-ea53b76bd0e8', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('ec60e863-abc7-4e0d-88a1-b2d23b553596', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('ec60e863-abc7-4e0d-88a1-b2d23b553596', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('ec60e863-abc7-4e0d-88a1-b2d23b553596', 'username', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('ec60e863-abc7-4e0d-88a1-b2d23b553596', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('ec60e863-abc7-4e0d-88a1-b2d23b553596', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('ec60e863-abc7-4e0d-88a1-b2d23b553596', 'preferred_username', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('ec60e863-abc7-4e0d-88a1-b2d23b553596', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('fddda3b2-2309-49ee-b17a-1f4ba3281736', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('fddda3b2-2309-49ee-b17a-1f4ba3281736', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('fddda3b2-2309-49ee-b17a-1f4ba3281736', 'birthdate', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('fddda3b2-2309-49ee-b17a-1f4ba3281736', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('fddda3b2-2309-49ee-b17a-1f4ba3281736', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('fddda3b2-2309-49ee-b17a-1f4ba3281736', 'birthdate', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('fddda3b2-2309-49ee-b17a-1f4ba3281736', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('df913294-64aa-492b-94af-fd86f592205c', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('df913294-64aa-492b-94af-fd86f592205c', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('df913294-64aa-492b-94af-fd86f592205c', 'email', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('df913294-64aa-492b-94af-fd86f592205c', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('df913294-64aa-492b-94af-fd86f592205c', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('df913294-64aa-492b-94af-fd86f592205c', 'email', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('df913294-64aa-492b-94af-fd86f592205c', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('f9542294-2a1a-4db4-9759-63f58c0c9c51', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('f9542294-2a1a-4db4-9759-63f58c0c9c51', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('f9542294-2a1a-4db4-9759-63f58c0c9c51', 'emailVerified', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('f9542294-2a1a-4db4-9759-63f58c0c9c51', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('f9542294-2a1a-4db4-9759-63f58c0c9c51', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('f9542294-2a1a-4db4-9759-63f58c0c9c51', 'email_verified', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('f9542294-2a1a-4db4-9759-63f58c0c9c51', 'boolean', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('b3176e3d-a160-4d8c-b936-da9bf4198de3', 'formatted', 'user.attribute.formatted');
INSERT INTO public.protocol_mapper_config VALUES ('b3176e3d-a160-4d8c-b936-da9bf4198de3', 'country', 'user.attribute.country');
INSERT INTO public.protocol_mapper_config VALUES ('b3176e3d-a160-4d8c-b936-da9bf4198de3', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('b3176e3d-a160-4d8c-b936-da9bf4198de3', 'postal_code', 'user.attribute.postal_code');
INSERT INTO public.protocol_mapper_config VALUES ('b3176e3d-a160-4d8c-b936-da9bf4198de3', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('b3176e3d-a160-4d8c-b936-da9bf4198de3', 'street', 'user.attribute.street');
INSERT INTO public.protocol_mapper_config VALUES ('b3176e3d-a160-4d8c-b936-da9bf4198de3', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('b3176e3d-a160-4d8c-b936-da9bf4198de3', 'region', 'user.attribute.region');
INSERT INTO public.protocol_mapper_config VALUES ('b3176e3d-a160-4d8c-b936-da9bf4198de3', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('b3176e3d-a160-4d8c-b936-da9bf4198de3', 'locality', 'user.attribute.locality');
INSERT INTO public.protocol_mapper_config VALUES ('4eb99f32-5b5e-42ba-ad31-5a94a8f156c0', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('4eb99f32-5b5e-42ba-ad31-5a94a8f156c0', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('4eb99f32-5b5e-42ba-ad31-5a94a8f156c0', 'phoneNumberVerified', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('4eb99f32-5b5e-42ba-ad31-5a94a8f156c0', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('4eb99f32-5b5e-42ba-ad31-5a94a8f156c0', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('4eb99f32-5b5e-42ba-ad31-5a94a8f156c0', 'phone_number_verified', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('4eb99f32-5b5e-42ba-ad31-5a94a8f156c0', 'boolean', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('c9a307ff-e9e6-4c71-943d-a9d710bb88e4', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('c9a307ff-e9e6-4c71-943d-a9d710bb88e4', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('c9a307ff-e9e6-4c71-943d-a9d710bb88e4', 'phoneNumber', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('c9a307ff-e9e6-4c71-943d-a9d710bb88e4', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('c9a307ff-e9e6-4c71-943d-a9d710bb88e4', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('c9a307ff-e9e6-4c71-943d-a9d710bb88e4', 'phone_number', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('c9a307ff-e9e6-4c71-943d-a9d710bb88e4', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('2fa083e4-5489-4203-8105-dc10de4e4029', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('2fa083e4-5489-4203-8105-dc10de4e4029', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config VALUES ('2fa083e4-5489-4203-8105-dc10de4e4029', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('2fa083e4-5489-4203-8105-dc10de4e4029', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('2fa083e4-5489-4203-8105-dc10de4e4029', 'resource_access.${client_id}.roles', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('2fa083e4-5489-4203-8105-dc10de4e4029', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('9cafe4d6-4128-4fba-9901-6789b9e175e1', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('9cafe4d6-4128-4fba-9901-6789b9e175e1', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config VALUES ('9cafe4d6-4128-4fba-9901-6789b9e175e1', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('9cafe4d6-4128-4fba-9901-6789b9e175e1', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('9cafe4d6-4128-4fba-9901-6789b9e175e1', 'realm_access.roles', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('9cafe4d6-4128-4fba-9901-6789b9e175e1', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('cb943c17-69b2-419f-90e3-f5e23ce015b6', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('cb943c17-69b2-419f-90e3-f5e23ce015b6', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('202a1106-26a0-4b15-811e-302ac846c673', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('202a1106-26a0-4b15-811e-302ac846c673', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('af0e44c2-5391-4ed3-886a-a63695000be1', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('af0e44c2-5391-4ed3-886a-a63695000be1', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config VALUES ('af0e44c2-5391-4ed3-886a-a63695000be1', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('af0e44c2-5391-4ed3-886a-a63695000be1', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('af0e44c2-5391-4ed3-886a-a63695000be1', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('af0e44c2-5391-4ed3-886a-a63695000be1', 'groups', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('af0e44c2-5391-4ed3-886a-a63695000be1', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('f1b28079-82b4-41a3-acb5-8103143b5000', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('f1b28079-82b4-41a3-acb5-8103143b5000', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('f1b28079-82b4-41a3-acb5-8103143b5000', 'username', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('f1b28079-82b4-41a3-acb5-8103143b5000', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('f1b28079-82b4-41a3-acb5-8103143b5000', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('f1b28079-82b4-41a3-acb5-8103143b5000', 'upn', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('f1b28079-82b4-41a3-acb5-8103143b5000', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('9d55e137-c0e9-4030-9369-2dd419637382', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('9d55e137-c0e9-4030-9369-2dd419637382', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('9d55e137-c0e9-4030-9369-2dd419637382', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('18b5a003-dd07-4ba5-829a-5b5877785416', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('18b5a003-dd07-4ba5-829a-5b5877785416', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('1f2be02f-59fe-468d-a080-2f18b31a3b75', 'AUTH_TIME', 'user.session.note');
INSERT INTO public.protocol_mapper_config VALUES ('1f2be02f-59fe-468d-a080-2f18b31a3b75', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('1f2be02f-59fe-468d-a080-2f18b31a3b75', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('1f2be02f-59fe-468d-a080-2f18b31a3b75', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('1f2be02f-59fe-468d-a080-2f18b31a3b75', 'auth_time', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('1f2be02f-59fe-468d-a080-2f18b31a3b75', 'long', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('2c10a999-9d96-4558-b224-bf1b93a9132d', 'client_id', 'user.session.note');
INSERT INTO public.protocol_mapper_config VALUES ('2c10a999-9d96-4558-b224-bf1b93a9132d', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('2c10a999-9d96-4558-b224-bf1b93a9132d', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('2c10a999-9d96-4558-b224-bf1b93a9132d', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('2c10a999-9d96-4558-b224-bf1b93a9132d', 'client_id', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('2c10a999-9d96-4558-b224-bf1b93a9132d', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('c3a75b84-8cd0-46ae-81c2-417455fa4c5e', 'clientAddress', 'user.session.note');
INSERT INTO public.protocol_mapper_config VALUES ('c3a75b84-8cd0-46ae-81c2-417455fa4c5e', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('c3a75b84-8cd0-46ae-81c2-417455fa4c5e', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('c3a75b84-8cd0-46ae-81c2-417455fa4c5e', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('c3a75b84-8cd0-46ae-81c2-417455fa4c5e', 'clientAddress', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('c3a75b84-8cd0-46ae-81c2-417455fa4c5e', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('fe0a36e0-f18e-4561-be81-8459be2d514a', 'clientHost', 'user.session.note');
INSERT INTO public.protocol_mapper_config VALUES ('fe0a36e0-f18e-4561-be81-8459be2d514a', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('fe0a36e0-f18e-4561-be81-8459be2d514a', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('fe0a36e0-f18e-4561-be81-8459be2d514a', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('fe0a36e0-f18e-4561-be81-8459be2d514a', 'clientHost', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('fe0a36e0-f18e-4561-be81-8459be2d514a', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('b585e4fb-550d-4074-aecd-5d919d90b993', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('b585e4fb-550d-4074-aecd-5d919d90b993', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config VALUES ('b585e4fb-550d-4074-aecd-5d919d90b993', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('b585e4fb-550d-4074-aecd-5d919d90b993', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('b585e4fb-550d-4074-aecd-5d919d90b993', 'organization', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('b585e4fb-550d-4074-aecd-5d919d90b993', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('ab048b26-f178-4ff9-b177-999cba923d7d', 'false', 'single');
INSERT INTO public.protocol_mapper_config VALUES ('ab048b26-f178-4ff9-b177-999cba923d7d', 'Basic', 'attribute.nameformat');
INSERT INTO public.protocol_mapper_config VALUES ('ab048b26-f178-4ff9-b177-999cba923d7d', 'Role', 'attribute.name');
INSERT INTO public.protocol_mapper_config VALUES ('068020f1-895d-447a-8c9d-9c640375d7c6', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('068020f1-895d-447a-8c9d-9c640375d7c6', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('068020f1-895d-447a-8c9d-9c640375d7c6', 'middleName', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('068020f1-895d-447a-8c9d-9c640375d7c6', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('068020f1-895d-447a-8c9d-9c640375d7c6', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('068020f1-895d-447a-8c9d-9c640375d7c6', 'middle_name', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('068020f1-895d-447a-8c9d-9c640375d7c6', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('06bda55b-7d30-4609-818b-cdfff2d11744', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('06bda55b-7d30-4609-818b-cdfff2d11744', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('06bda55b-7d30-4609-818b-cdfff2d11744', 'zoneinfo', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('06bda55b-7d30-4609-818b-cdfff2d11744', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('06bda55b-7d30-4609-818b-cdfff2d11744', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('06bda55b-7d30-4609-818b-cdfff2d11744', 'zoneinfo', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('06bda55b-7d30-4609-818b-cdfff2d11744', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('1f722abe-4899-4228-b5a2-ded40af3a23c', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('1f722abe-4899-4228-b5a2-ded40af3a23c', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('1f722abe-4899-4228-b5a2-ded40af3a23c', 'picture', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('1f722abe-4899-4228-b5a2-ded40af3a23c', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('1f722abe-4899-4228-b5a2-ded40af3a23c', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('1f722abe-4899-4228-b5a2-ded40af3a23c', 'picture', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('1f722abe-4899-4228-b5a2-ded40af3a23c', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('232b51c5-bee2-4c9a-89e5-3bb2796582f8', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('232b51c5-bee2-4c9a-89e5-3bb2796582f8', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('232b51c5-bee2-4c9a-89e5-3bb2796582f8', 'firstName', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('232b51c5-bee2-4c9a-89e5-3bb2796582f8', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('232b51c5-bee2-4c9a-89e5-3bb2796582f8', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('232b51c5-bee2-4c9a-89e5-3bb2796582f8', 'given_name', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('232b51c5-bee2-4c9a-89e5-3bb2796582f8', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('3c54034d-7669-4eb0-9de9-ef5aaa61d9e3', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('3c54034d-7669-4eb0-9de9-ef5aaa61d9e3', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('3c54034d-7669-4eb0-9de9-ef5aaa61d9e3', 'username', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('3c54034d-7669-4eb0-9de9-ef5aaa61d9e3', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('3c54034d-7669-4eb0-9de9-ef5aaa61d9e3', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('3c54034d-7669-4eb0-9de9-ef5aaa61d9e3', 'preferred_username', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('3c54034d-7669-4eb0-9de9-ef5aaa61d9e3', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('71878ecd-1241-436a-8c3c-24b120b2dbf0', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('71878ecd-1241-436a-8c3c-24b120b2dbf0', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('71878ecd-1241-436a-8c3c-24b120b2dbf0', 'birthdate', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('71878ecd-1241-436a-8c3c-24b120b2dbf0', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('71878ecd-1241-436a-8c3c-24b120b2dbf0', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('71878ecd-1241-436a-8c3c-24b120b2dbf0', 'birthdate', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('71878ecd-1241-436a-8c3c-24b120b2dbf0', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('7cbf0ec8-cdb1-434d-bf7c-0c74d77702e0', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('7cbf0ec8-cdb1-434d-bf7c-0c74d77702e0', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('7cbf0ec8-cdb1-434d-bf7c-0c74d77702e0', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('7cbf0ec8-cdb1-434d-bf7c-0c74d77702e0', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('81015dc4-1b73-4ffe-b6e3-43f551cfae55', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('81015dc4-1b73-4ffe-b6e3-43f551cfae55', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('81015dc4-1b73-4ffe-b6e3-43f551cfae55', 'nickname', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('81015dc4-1b73-4ffe-b6e3-43f551cfae55', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('81015dc4-1b73-4ffe-b6e3-43f551cfae55', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('81015dc4-1b73-4ffe-b6e3-43f551cfae55', 'nickname', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('81015dc4-1b73-4ffe-b6e3-43f551cfae55', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('83cf1098-bb2b-4af6-846f-55507477819d', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('83cf1098-bb2b-4af6-846f-55507477819d', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('83cf1098-bb2b-4af6-846f-55507477819d', 'lastName', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('83cf1098-bb2b-4af6-846f-55507477819d', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('83cf1098-bb2b-4af6-846f-55507477819d', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('83cf1098-bb2b-4af6-846f-55507477819d', 'family_name', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('83cf1098-bb2b-4af6-846f-55507477819d', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('a100ac3f-8a64-4825-bfa4-54416efb5499', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a100ac3f-8a64-4825-bfa4-54416efb5499', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a100ac3f-8a64-4825-bfa4-54416efb5499', 'updatedAt', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('a100ac3f-8a64-4825-bfa4-54416efb5499', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a100ac3f-8a64-4825-bfa4-54416efb5499', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a100ac3f-8a64-4825-bfa4-54416efb5499', 'updated_at', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('a100ac3f-8a64-4825-bfa4-54416efb5499', 'long', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('a7b33990-14ad-44f2-aac7-14ed6ebe5b1c', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a7b33990-14ad-44f2-aac7-14ed6ebe5b1c', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a7b33990-14ad-44f2-aac7-14ed6ebe5b1c', 'website', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('a7b33990-14ad-44f2-aac7-14ed6ebe5b1c', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a7b33990-14ad-44f2-aac7-14ed6ebe5b1c', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a7b33990-14ad-44f2-aac7-14ed6ebe5b1c', 'website', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('a7b33990-14ad-44f2-aac7-14ed6ebe5b1c', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('a827fa64-5cca-4fc1-88a7-89423970fad5', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a827fa64-5cca-4fc1-88a7-89423970fad5', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a827fa64-5cca-4fc1-88a7-89423970fad5', 'profile', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('a827fa64-5cca-4fc1-88a7-89423970fad5', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a827fa64-5cca-4fc1-88a7-89423970fad5', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a827fa64-5cca-4fc1-88a7-89423970fad5', 'profile', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('a827fa64-5cca-4fc1-88a7-89423970fad5', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('b77dd162-fdf1-4ecb-86fc-475b6b045878', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('b77dd162-fdf1-4ecb-86fc-475b6b045878', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('b77dd162-fdf1-4ecb-86fc-475b6b045878', 'gender', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('b77dd162-fdf1-4ecb-86fc-475b6b045878', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('b77dd162-fdf1-4ecb-86fc-475b6b045878', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('b77dd162-fdf1-4ecb-86fc-475b6b045878', 'gender', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('b77dd162-fdf1-4ecb-86fc-475b6b045878', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('d1360c0a-b021-4e2c-b478-87a9250cb967', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('d1360c0a-b021-4e2c-b478-87a9250cb967', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('d1360c0a-b021-4e2c-b478-87a9250cb967', 'locale', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('d1360c0a-b021-4e2c-b478-87a9250cb967', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('d1360c0a-b021-4e2c-b478-87a9250cb967', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('d1360c0a-b021-4e2c-b478-87a9250cb967', 'locale', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('d1360c0a-b021-4e2c-b478-87a9250cb967', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('094718e8-59ae-4e20-8c96-091894375ac9', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('094718e8-59ae-4e20-8c96-091894375ac9', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('094718e8-59ae-4e20-8c96-091894375ac9', 'email', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('094718e8-59ae-4e20-8c96-091894375ac9', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('094718e8-59ae-4e20-8c96-091894375ac9', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('094718e8-59ae-4e20-8c96-091894375ac9', 'email', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('094718e8-59ae-4e20-8c96-091894375ac9', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('89f10c0b-18fe-4a1b-9866-3a6833c27235', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('89f10c0b-18fe-4a1b-9866-3a6833c27235', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('89f10c0b-18fe-4a1b-9866-3a6833c27235', 'emailVerified', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('89f10c0b-18fe-4a1b-9866-3a6833c27235', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('89f10c0b-18fe-4a1b-9866-3a6833c27235', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('89f10c0b-18fe-4a1b-9866-3a6833c27235', 'email_verified', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('89f10c0b-18fe-4a1b-9866-3a6833c27235', 'boolean', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('feff34a9-8eb0-4e5e-93a6-fd783c9f9e91', 'formatted', 'user.attribute.formatted');
INSERT INTO public.protocol_mapper_config VALUES ('feff34a9-8eb0-4e5e-93a6-fd783c9f9e91', 'country', 'user.attribute.country');
INSERT INTO public.protocol_mapper_config VALUES ('feff34a9-8eb0-4e5e-93a6-fd783c9f9e91', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('feff34a9-8eb0-4e5e-93a6-fd783c9f9e91', 'postal_code', 'user.attribute.postal_code');
INSERT INTO public.protocol_mapper_config VALUES ('feff34a9-8eb0-4e5e-93a6-fd783c9f9e91', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('feff34a9-8eb0-4e5e-93a6-fd783c9f9e91', 'street', 'user.attribute.street');
INSERT INTO public.protocol_mapper_config VALUES ('feff34a9-8eb0-4e5e-93a6-fd783c9f9e91', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('feff34a9-8eb0-4e5e-93a6-fd783c9f9e91', 'region', 'user.attribute.region');
INSERT INTO public.protocol_mapper_config VALUES ('feff34a9-8eb0-4e5e-93a6-fd783c9f9e91', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('feff34a9-8eb0-4e5e-93a6-fd783c9f9e91', 'locality', 'user.attribute.locality');
INSERT INTO public.protocol_mapper_config VALUES ('88010306-c900-4f4c-a1aa-5386c5d2d3ce', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('88010306-c900-4f4c-a1aa-5386c5d2d3ce', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('88010306-c900-4f4c-a1aa-5386c5d2d3ce', 'phoneNumberVerified', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('88010306-c900-4f4c-a1aa-5386c5d2d3ce', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('88010306-c900-4f4c-a1aa-5386c5d2d3ce', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('88010306-c900-4f4c-a1aa-5386c5d2d3ce', 'phone_number_verified', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('88010306-c900-4f4c-a1aa-5386c5d2d3ce', 'boolean', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('c21582eb-005c-4aef-84e5-56d0e09ede4f', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('c21582eb-005c-4aef-84e5-56d0e09ede4f', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('c21582eb-005c-4aef-84e5-56d0e09ede4f', 'phoneNumber', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('c21582eb-005c-4aef-84e5-56d0e09ede4f', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('c21582eb-005c-4aef-84e5-56d0e09ede4f', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('c21582eb-005c-4aef-84e5-56d0e09ede4f', 'phone_number', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('c21582eb-005c-4aef-84e5-56d0e09ede4f', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('0727e341-74b7-493b-8f4f-ccccf182a81a', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('0727e341-74b7-493b-8f4f-ccccf182a81a', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config VALUES ('0727e341-74b7-493b-8f4f-ccccf182a81a', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('0727e341-74b7-493b-8f4f-ccccf182a81a', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('0727e341-74b7-493b-8f4f-ccccf182a81a', 'resource_access.${client_id}.roles', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('0727e341-74b7-493b-8f4f-ccccf182a81a', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('c831e0be-1720-4f9c-a16c-8cb6d83e856a', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('c831e0be-1720-4f9c-a16c-8cb6d83e856a', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config VALUES ('c831e0be-1720-4f9c-a16c-8cb6d83e856a', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('c831e0be-1720-4f9c-a16c-8cb6d83e856a', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('c831e0be-1720-4f9c-a16c-8cb6d83e856a', 'realm_access.roles', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('c831e0be-1720-4f9c-a16c-8cb6d83e856a', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('e30c2a26-465e-46ed-96de-6db277f5d6c0', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('e30c2a26-465e-46ed-96de-6db277f5d6c0', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('8ab0b551-dc4c-4880-b372-7155e3e9f777', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('8ab0b551-dc4c-4880-b372-7155e3e9f777', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('6a3ae63b-872b-476d-be6e-55d4e862102c', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('6a3ae63b-872b-476d-be6e-55d4e862102c', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('6a3ae63b-872b-476d-be6e-55d4e862102c', 'username', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('6a3ae63b-872b-476d-be6e-55d4e862102c', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('6a3ae63b-872b-476d-be6e-55d4e862102c', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('6a3ae63b-872b-476d-be6e-55d4e862102c', 'upn', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('6a3ae63b-872b-476d-be6e-55d4e862102c', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('919aa59e-ff95-4afe-ada5-a86804c67dfc', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('919aa59e-ff95-4afe-ada5-a86804c67dfc', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config VALUES ('919aa59e-ff95-4afe-ada5-a86804c67dfc', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('919aa59e-ff95-4afe-ada5-a86804c67dfc', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('919aa59e-ff95-4afe-ada5-a86804c67dfc', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('919aa59e-ff95-4afe-ada5-a86804c67dfc', 'groups', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('919aa59e-ff95-4afe-ada5-a86804c67dfc', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('de417a82-092c-4dfc-8b13-c02f6c145aff', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('de417a82-092c-4dfc-8b13-c02f6c145aff', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('de417a82-092c-4dfc-8b13-c02f6c145aff', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('49725540-4e01-4dd1-bbdf-854b63564999', 'AUTH_TIME', 'user.session.note');
INSERT INTO public.protocol_mapper_config VALUES ('49725540-4e01-4dd1-bbdf-854b63564999', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('49725540-4e01-4dd1-bbdf-854b63564999', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('49725540-4e01-4dd1-bbdf-854b63564999', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('49725540-4e01-4dd1-bbdf-854b63564999', 'auth_time', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('49725540-4e01-4dd1-bbdf-854b63564999', 'long', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('872dcf87-0e77-457d-a368-e6d52d6bd278', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('872dcf87-0e77-457d-a368-e6d52d6bd278', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('02602bb7-b385-43c0-9ef8-c23e92edd508', 'client_id', 'user.session.note');
INSERT INTO public.protocol_mapper_config VALUES ('02602bb7-b385-43c0-9ef8-c23e92edd508', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('02602bb7-b385-43c0-9ef8-c23e92edd508', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('02602bb7-b385-43c0-9ef8-c23e92edd508', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('02602bb7-b385-43c0-9ef8-c23e92edd508', 'client_id', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('02602bb7-b385-43c0-9ef8-c23e92edd508', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('4be83064-5df2-4a2b-99e0-bc7a09660519', 'clientAddress', 'user.session.note');
INSERT INTO public.protocol_mapper_config VALUES ('4be83064-5df2-4a2b-99e0-bc7a09660519', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('4be83064-5df2-4a2b-99e0-bc7a09660519', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('4be83064-5df2-4a2b-99e0-bc7a09660519', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('4be83064-5df2-4a2b-99e0-bc7a09660519', 'clientAddress', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('4be83064-5df2-4a2b-99e0-bc7a09660519', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('f5395625-961d-45cc-a4a6-24a2ad52d5ec', 'clientHost', 'user.session.note');
INSERT INTO public.protocol_mapper_config VALUES ('f5395625-961d-45cc-a4a6-24a2ad52d5ec', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('f5395625-961d-45cc-a4a6-24a2ad52d5ec', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('f5395625-961d-45cc-a4a6-24a2ad52d5ec', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('f5395625-961d-45cc-a4a6-24a2ad52d5ec', 'clientHost', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('f5395625-961d-45cc-a4a6-24a2ad52d5ec', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('24d07752-b665-4c38-b928-a210500c140e', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('24d07752-b665-4c38-b928-a210500c140e', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config VALUES ('24d07752-b665-4c38-b928-a210500c140e', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('24d07752-b665-4c38-b928-a210500c140e', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('24d07752-b665-4c38-b928-a210500c140e', 'organization', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('24d07752-b665-4c38-b928-a210500c140e', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('8f4d9e3d-4dd3-4a72-b4ec-cfefee0a0075', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('8f4d9e3d-4dd3-4a72-b4ec-cfefee0a0075', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('8f4d9e3d-4dd3-4a72-b4ec-cfefee0a0075', 'locale', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('8f4d9e3d-4dd3-4a72-b4ec-cfefee0a0075', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('8f4d9e3d-4dd3-4a72-b4ec-cfefee0a0075', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('8f4d9e3d-4dd3-4a72-b4ec-cfefee0a0075', 'locale', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('8f4d9e3d-4dd3-4a72-b4ec-cfefee0a0075', 'String', 'jsonType.label');


--
-- TOC entry 4148 (class 0 OID 16506)
-- Dependencies: 234
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.realm VALUES ('daad7bd4-4102-4d74-9ab2-5299b9560d6e', 60, 300, 60, NULL, NULL, NULL, true, false, 0, NULL, 'master', 0, NULL, false, false, false, false, 'EXTERNAL', 1800, 36000, false, false, '179c4036-632c-4607-9dbe-ad5f232b7055', 1800, false, NULL, false, false, false, false, 0, 1, 30, 6, 'HmacSHA1', 'totp', 'de0e9104-6094-439a-b3dc-c90eebf4c477', '2defe1c7-8639-4f73-8d2f-76df83b333fb', '2ecd7150-ae1b-44b5-a166-d0d73a76b64d', 'b83ee41f-7327-487b-a544-81e692ca44f5', 'd447ebb7-bbd3-4ba0-9a0d-8f4024afcea8', 2592000, false, 900, true, false, '7fc9c0f0-5c43-4254-aa6f-fdeef2105b24', 0, false, 0, 0, '3f35f02e-f5ac-41f3-85a0-521590599c9b');
INSERT INTO public.realm VALUES ('69cd0ddd-5526-4bfb-a3ae-e06de409092f', 60, 300, 300, NULL, NULL, NULL, true, false, 0, NULL, 'dev', 0, NULL, false, false, false, false, 'EXTERNAL', 1800, 36000, false, false, 'da3bb693-3bb8-4d95-97e4-cdf0427cdf45', 1800, false, NULL, false, false, false, false, 0, 1, 30, 6, 'HmacSHA1', 'totp', '1f75a619-c496-48bd-baaa-bcf6bd52f808', 'cb4c3586-d6ab-44b5-83b3-3e1d27a4a009', 'c90163ac-08f5-4bdb-a306-ad25df4e12a2', '984da793-7b39-417f-bb68-4046c898270f', 'fc8f38f2-89f7-4e8b-88af-26abbc03cf0e', 2592000, false, 900, true, false, 'c3afb01b-377c-4d5d-8db2-58686713dce2', 0, false, 0, 0, '133c74bd-6684-4acb-93cf-38d4e10194b8');


--
-- TOC entry 4149 (class 0 OID 16523)
-- Dependencies: 235
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.realm_attribute VALUES ('_browser_header.contentSecurityPolicyReportOnly', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', '');
INSERT INTO public.realm_attribute VALUES ('_browser_header.xContentTypeOptions', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'nosniff');
INSERT INTO public.realm_attribute VALUES ('_browser_header.referrerPolicy', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'no-referrer');
INSERT INTO public.realm_attribute VALUES ('_browser_header.xRobotsTag', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'none');
INSERT INTO public.realm_attribute VALUES ('_browser_header.xFrameOptions', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'SAMEORIGIN');
INSERT INTO public.realm_attribute VALUES ('_browser_header.contentSecurityPolicy', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'frame-src ''self''; frame-ancestors ''self''; object-src ''none'';');
INSERT INTO public.realm_attribute VALUES ('_browser_header.strictTransportSecurity', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'max-age=31536000; includeSubDomains');
INSERT INTO public.realm_attribute VALUES ('bruteForceProtected', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'false');
INSERT INTO public.realm_attribute VALUES ('permanentLockout', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'false');
INSERT INTO public.realm_attribute VALUES ('maxTemporaryLockouts', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', '0');
INSERT INTO public.realm_attribute VALUES ('bruteForceStrategy', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'MULTIPLE');
INSERT INTO public.realm_attribute VALUES ('maxFailureWaitSeconds', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', '900');
INSERT INTO public.realm_attribute VALUES ('minimumQuickLoginWaitSeconds', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', '60');
INSERT INTO public.realm_attribute VALUES ('waitIncrementSeconds', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', '60');
INSERT INTO public.realm_attribute VALUES ('quickLoginCheckMilliSeconds', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', '1000');
INSERT INTO public.realm_attribute VALUES ('maxDeltaTimeSeconds', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', '43200');
INSERT INTO public.realm_attribute VALUES ('failureFactor', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', '30');
INSERT INTO public.realm_attribute VALUES ('realmReusableOtpCode', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'false');
INSERT INTO public.realm_attribute VALUES ('firstBrokerLoginFlowId', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'f4735eca-dfe9-4da7-b86b-d2d5ed5d7674');
INSERT INTO public.realm_attribute VALUES ('displayName', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'Keycloak');
INSERT INTO public.realm_attribute VALUES ('displayNameHtml', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', '<div class="kc-logo-text"><span>Keycloak</span></div>');
INSERT INTO public.realm_attribute VALUES ('defaultSignatureAlgorithm', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'RS256');
INSERT INTO public.realm_attribute VALUES ('offlineSessionMaxLifespanEnabled', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'false');
INSERT INTO public.realm_attribute VALUES ('offlineSessionMaxLifespan', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', '5184000');
INSERT INTO public.realm_attribute VALUES ('_browser_header.contentSecurityPolicyReportOnly', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '');
INSERT INTO public.realm_attribute VALUES ('_browser_header.xContentTypeOptions', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'nosniff');
INSERT INTO public.realm_attribute VALUES ('_browser_header.referrerPolicy', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'no-referrer');
INSERT INTO public.realm_attribute VALUES ('_browser_header.xRobotsTag', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'none');
INSERT INTO public.realm_attribute VALUES ('_browser_header.xFrameOptions', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'SAMEORIGIN');
INSERT INTO public.realm_attribute VALUES ('_browser_header.contentSecurityPolicy', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'frame-src ''self''; frame-ancestors ''self''; object-src ''none'';');
INSERT INTO public.realm_attribute VALUES ('_browser_header.strictTransportSecurity', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'max-age=31536000; includeSubDomains');
INSERT INTO public.realm_attribute VALUES ('bruteForceProtected', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'false');
INSERT INTO public.realm_attribute VALUES ('permanentLockout', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'false');
INSERT INTO public.realm_attribute VALUES ('maxTemporaryLockouts', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '0');
INSERT INTO public.realm_attribute VALUES ('bruteForceStrategy', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'MULTIPLE');
INSERT INTO public.realm_attribute VALUES ('maxFailureWaitSeconds', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '900');
INSERT INTO public.realm_attribute VALUES ('minimumQuickLoginWaitSeconds', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '60');
INSERT INTO public.realm_attribute VALUES ('waitIncrementSeconds', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '60');
INSERT INTO public.realm_attribute VALUES ('quickLoginCheckMilliSeconds', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '1000');
INSERT INTO public.realm_attribute VALUES ('maxDeltaTimeSeconds', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '43200');
INSERT INTO public.realm_attribute VALUES ('failureFactor', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '30');
INSERT INTO public.realm_attribute VALUES ('realmReusableOtpCode', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'false');
INSERT INTO public.realm_attribute VALUES ('defaultSignatureAlgorithm', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'RS256');
INSERT INTO public.realm_attribute VALUES ('offlineSessionMaxLifespanEnabled', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'false');
INSERT INTO public.realm_attribute VALUES ('offlineSessionMaxLifespan', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '5184000');
INSERT INTO public.realm_attribute VALUES ('actionTokenGeneratedByAdminLifespan', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '43200');
INSERT INTO public.realm_attribute VALUES ('actionTokenGeneratedByUserLifespan', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '300');
INSERT INTO public.realm_attribute VALUES ('oauth2DeviceCodeLifespan', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '600');
INSERT INTO public.realm_attribute VALUES ('oauth2DevicePollingInterval', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '5');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyRpEntityName', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'keycloak');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicySignatureAlgorithms', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'ES256,RS256');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyRpId', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyAttestationConveyancePreference', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'not specified');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyAuthenticatorAttachment', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'not specified');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyRequireResidentKey', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'not specified');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyUserVerificationRequirement', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'not specified');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyCreateTimeout', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '0');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyAvoidSameAuthenticatorRegister', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'false');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyRpEntityNamePasswordless', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'keycloak');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicySignatureAlgorithmsPasswordless', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'ES256,RS256');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyRpIdPasswordless', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyAttestationConveyancePreferencePasswordless', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'not specified');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyAuthenticatorAttachmentPasswordless', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'not specified');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyRequireResidentKeyPasswordless', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'not specified');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyUserVerificationRequirementPasswordless', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'not specified');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyCreateTimeoutPasswordless', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '0');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'false');
INSERT INTO public.realm_attribute VALUES ('cibaBackchannelTokenDeliveryMode', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'poll');
INSERT INTO public.realm_attribute VALUES ('cibaExpiresIn', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '120');
INSERT INTO public.realm_attribute VALUES ('cibaInterval', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '5');
INSERT INTO public.realm_attribute VALUES ('cibaAuthRequestedUserHint', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'login_hint');
INSERT INTO public.realm_attribute VALUES ('parRequestUriLifespan', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', '60');
INSERT INTO public.realm_attribute VALUES ('firstBrokerLoginFlowId', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'bbdc02d6-b1da-4058-b2b4-6ad6e04496bb');


--
-- TOC entry 4190 (class 0 OID 17280)
-- Dependencies: 276
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4170 (class 0 OID 16976)
-- Dependencies: 256
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4150 (class 0 OID 16531)
-- Dependencies: 236
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.realm_events_listeners VALUES ('daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'jboss-logging');
INSERT INTO public.realm_events_listeners VALUES ('69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'jboss-logging');


--
-- TOC entry 4223 (class 0 OID 17982)
-- Dependencies: 309
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4151 (class 0 OID 16534)
-- Dependencies: 237
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.realm_required_credential VALUES ('password', 'password', true, true, 'daad7bd4-4102-4d74-9ab2-5299b9560d6e');
INSERT INTO public.realm_required_credential VALUES ('password', 'password', true, true, '69cd0ddd-5526-4bfb-a3ae-e06de409092f');


--
-- TOC entry 4152 (class 0 OID 16541)
-- Dependencies: 238
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4169 (class 0 OID 16892)
-- Dependencies: 255
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4153 (class 0 OID 16551)
-- Dependencies: 239
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.redirect_uris VALUES ('e4e8820d-84e9-4071-97ae-c32d108fa736', '/realms/master/account/*');
INSERT INTO public.redirect_uris VALUES ('37841806-a6d9-4b1d-a09b-93346087acb8', '/realms/master/account/*');
INSERT INTO public.redirect_uris VALUES ('ac970ba9-a5aa-422d-8207-55d4ab698d1c', '/admin/master/console/*');
INSERT INTO public.redirect_uris VALUES ('a0701c28-b02f-4983-92b4-3f236ac1892c', '/realms/dev/account/*');
INSERT INTO public.redirect_uris VALUES ('48067444-f02b-4a4e-ae0e-709789381883', '/realms/dev/account/*');
INSERT INTO public.redirect_uris VALUES ('369a0d1d-886a-40ee-b1af-dcd66219c391', '/admin/dev/console/*');
INSERT INTO public.redirect_uris VALUES ('e2e94889-cf64-4b4c-aea4-1f85993cfde1', 'http://localhost:3001/*');


--
-- TOC entry 4183 (class 0 OID 17215)
-- Dependencies: 269
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4182 (class 0 OID 17208)
-- Dependencies: 268
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.required_action_provider VALUES ('9b43e2c3-5aad-44a7-a133-3434e40c99d1', 'VERIFY_EMAIL', 'Verify Email', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', true, false, 'VERIFY_EMAIL', 50);
INSERT INTO public.required_action_provider VALUES ('a1643ce9-0959-4aec-9d36-ea0754bbe3e3', 'UPDATE_PROFILE', 'Update Profile', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', true, false, 'UPDATE_PROFILE', 40);
INSERT INTO public.required_action_provider VALUES ('207650b8-5816-49ab-bfe9-b57a24f97cc7', 'CONFIGURE_TOTP', 'Configure OTP', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', true, false, 'CONFIGURE_TOTP', 10);
INSERT INTO public.required_action_provider VALUES ('436ae3c4-6c85-4ee2-aab5-60193ce57a98', 'UPDATE_PASSWORD', 'Update Password', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', true, false, 'UPDATE_PASSWORD', 30);
INSERT INTO public.required_action_provider VALUES ('b0fb9961-bdf9-4481-b52d-0e6605f57058', 'TERMS_AND_CONDITIONS', 'Terms and Conditions', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', false, false, 'TERMS_AND_CONDITIONS', 20);
INSERT INTO public.required_action_provider VALUES ('ba20ecdc-5426-483e-84f5-7cd778b80ae1', 'delete_account', 'Delete Account', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', false, false, 'delete_account', 60);
INSERT INTO public.required_action_provider VALUES ('e55c4ce5-9054-46ef-b37b-3ac4fbfc0a0e', 'delete_credential', 'Delete Credential', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', true, false, 'delete_credential', 100);
INSERT INTO public.required_action_provider VALUES ('bf966bf8-e8f9-4b5f-a934-7abe89300209', 'update_user_locale', 'Update User Locale', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', true, false, 'update_user_locale', 1000);
INSERT INTO public.required_action_provider VALUES ('9b62b9d4-d3d1-4422-b6cc-ed6181fc2b18', 'webauthn-register', 'Webauthn Register', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', true, false, 'webauthn-register', 70);
INSERT INTO public.required_action_provider VALUES ('761daf79-2890-4217-a954-fef64c611a5f', 'webauthn-register-passwordless', 'Webauthn Register Passwordless', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', true, false, 'webauthn-register-passwordless', 80);
INSERT INTO public.required_action_provider VALUES ('d5f4680e-9c59-4b7a-a132-c63f95bd34b1', 'VERIFY_PROFILE', 'Verify Profile', 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', true, false, 'VERIFY_PROFILE', 90);
INSERT INTO public.required_action_provider VALUES ('6701ad3c-3974-45fb-b539-c53ef25979f5', 'VERIFY_EMAIL', 'Verify Email', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', true, false, 'VERIFY_EMAIL', 50);
INSERT INTO public.required_action_provider VALUES ('3c01697c-d3e7-4b9d-9ab5-fc247d3910ed', 'UPDATE_PROFILE', 'Update Profile', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', true, false, 'UPDATE_PROFILE', 40);
INSERT INTO public.required_action_provider VALUES ('1c9549af-9e94-440e-abdb-a3d6a2853490', 'CONFIGURE_TOTP', 'Configure OTP', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', true, false, 'CONFIGURE_TOTP', 10);
INSERT INTO public.required_action_provider VALUES ('e076d000-19fa-4c10-a52d-2e2757737720', 'UPDATE_PASSWORD', 'Update Password', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', true, false, 'UPDATE_PASSWORD', 30);
INSERT INTO public.required_action_provider VALUES ('6d11c926-11df-4394-8ce6-b21acbe2fbfd', 'TERMS_AND_CONDITIONS', 'Terms and Conditions', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', false, false, 'TERMS_AND_CONDITIONS', 20);
INSERT INTO public.required_action_provider VALUES ('ff0abdbd-ce9a-44cf-8096-ff2cd6303185', 'delete_account', 'Delete Account', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', false, false, 'delete_account', 60);
INSERT INTO public.required_action_provider VALUES ('73f34662-d6d7-49b0-98f9-f9e3aec868c2', 'delete_credential', 'Delete Credential', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', true, false, 'delete_credential', 100);
INSERT INTO public.required_action_provider VALUES ('9e931c11-03c4-4841-979a-79263a5ad397', 'update_user_locale', 'Update User Locale', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', true, false, 'update_user_locale', 1000);
INSERT INTO public.required_action_provider VALUES ('a27bbcb0-a6c6-4176-993b-136b12c08aa1', 'webauthn-register', 'Webauthn Register', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', true, false, 'webauthn-register', 70);
INSERT INTO public.required_action_provider VALUES ('4d0167f4-6f13-4c20-bff4-be3654141e40', 'webauthn-register-passwordless', 'Webauthn Register Passwordless', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', true, false, 'webauthn-register-passwordless', 80);
INSERT INTO public.required_action_provider VALUES ('36ad5387-fdb4-4167-b618-ef4891c80027', 'VERIFY_PROFILE', 'Verify Profile', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', true, false, 'VERIFY_PROFILE', 90);


--
-- TOC entry 4220 (class 0 OID 17913)
-- Dependencies: 306
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4200 (class 0 OID 17497)
-- Dependencies: 286
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4199 (class 0 OID 17482)
-- Dependencies: 285
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4194 (class 0 OID 17420)
-- Dependencies: 280
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4219 (class 0 OID 17889)
-- Dependencies: 305
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4197 (class 0 OID 17456)
-- Dependencies: 283
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4195 (class 0 OID 17428)
-- Dependencies: 281
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4196 (class 0 OID 17442)
-- Dependencies: 282
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4221 (class 0 OID 17931)
-- Dependencies: 307
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4226 (class 0 OID 18064)
-- Dependencies: 312
-- Data for Name: revoked_token; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4222 (class 0 OID 17941)
-- Dependencies: 308
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4154 (class 0 OID 16554)
-- Dependencies: 240
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.scope_mapping VALUES ('37841806-a6d9-4b1d-a09b-93346087acb8', '1e15280b-458b-473e-8cb3-c6673eeadcb1');
INSERT INTO public.scope_mapping VALUES ('37841806-a6d9-4b1d-a09b-93346087acb8', '4a442c8f-2d67-4b33-b2c6-792140846e5e');
INSERT INTO public.scope_mapping VALUES ('48067444-f02b-4a4e-ae0e-709789381883', 'f6c5e85a-2400-4dae-96f5-a6647b62ae29');
INSERT INTO public.scope_mapping VALUES ('48067444-f02b-4a4e-ae0e-709789381883', '3b4b4e7b-ca12-4b76-9b0e-0d7d343c6bf2');


--
-- TOC entry 4201 (class 0 OID 17512)
-- Dependencies: 287
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4228 (class 0 OID 18080)
-- Dependencies: 314
-- Data for Name: server_config; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4155 (class 0 OID 16560)
-- Dependencies: 241
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.user_attribute VALUES ('is_temporary_admin', 'true', '8efbd700-329b-4874-a87f-1eeb52ca2637', '8b10d34d-8c6a-4fca-a36f-ed7ddc617b5c', NULL, NULL, NULL);


--
-- TOC entry 4174 (class 0 OID 16997)
-- Dependencies: 260
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4217 (class 0 OID 17864)
-- Dependencies: 303
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4156 (class 0 OID 16565)
-- Dependencies: 242
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.user_entity VALUES ('8efbd700-329b-4874-a87f-1eeb52ca2637', NULL, '90558c6c-06cf-4415-869d-6d1e959626d1', false, true, NULL, NULL, NULL, 'daad7bd4-4102-4d74-9ab2-5299b9560d6e', 'admin', 1750802374654, NULL, 0);
INSERT INTO public.user_entity VALUES ('d07916df-b022-4f2a-b652-94aa14209064', 'admin@app', 'admin@app', true, true, NULL, 'admin', 'admin', '69cd0ddd-5526-4bfb-a3ae-e06de409092f', 'admin', 1750802998700, NULL, 0);


--
-- TOC entry 4157 (class 0 OID 16573)
-- Dependencies: 243
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4180 (class 0 OID 17109)
-- Dependencies: 266
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4181 (class 0 OID 17114)
-- Dependencies: 267
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4158 (class 0 OID 16578)
-- Dependencies: 244
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4189 (class 0 OID 17277)
-- Dependencies: 275
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4159 (class 0 OID 16583)
-- Dependencies: 245
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4160 (class 0 OID 16586)
-- Dependencies: 246
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.user_role_mapping VALUES ('3f35f02e-f5ac-41f3-85a0-521590599c9b', '8efbd700-329b-4874-a87f-1eeb52ca2637');
INSERT INTO public.user_role_mapping VALUES ('5e5646e2-8bd2-4dd8-9c80-33b2c87873c0', '8efbd700-329b-4874-a87f-1eeb52ca2637');
INSERT INTO public.user_role_mapping VALUES ('133c74bd-6684-4acb-93cf-38d4e10194b8', 'd07916df-b022-4f2a-b652-94aa14209064');


--
-- TOC entry 4161 (class 0 OID 16600)
-- Dependencies: 247
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.web_origins VALUES ('ac970ba9-a5aa-422d-8207-55d4ab698d1c', '+');
INSERT INTO public.web_origins VALUES ('369a0d1d-886a-40ee-b1af-dcd66219c391', '+');
INSERT INTO public.web_origins VALUES ('e2e94889-cf64-4b4c-aea4-1f85993cfde1', 'http://localhost:3001/');


--
-- TOC entry 3920 (class 2606 OID 18053)
-- Name: org_domain ORG_DOMAIN_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.org_domain
    ADD CONSTRAINT "ORG_DOMAIN_pkey" PRIMARY KEY (id, name);


--
-- TOC entry 3912 (class 2606 OID 18042)
-- Name: org ORG_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT "ORG_pkey" PRIMARY KEY (id);


--
-- TOC entry 3928 (class 2606 OID 18087)
-- Name: server_config SERVER_CONFIG_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.server_config
    ADD CONSTRAINT "SERVER_CONFIG_pkey" PRIMARY KEY (server_config_key);


--
-- TOC entry 3646 (class 2606 OID 17965)
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- TOC entry 3881 (class 2606 OID 17795)
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- TOC entry 3883 (class 2606 OID 17994)
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- TOC entry 3878 (class 2606 OID 17670)
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- TOC entry 3793 (class 2606 OID 17318)
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- TOC entry 3841 (class 2606 OID 17593)
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- TOC entry 3869 (class 2606 OID 17613)
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- TOC entry 3872 (class 2606 OID 17611)
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- TOC entry 3861 (class 2606 OID 17609)
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- TOC entry 3843 (class 2606 OID 17595)
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- TOC entry 3848 (class 2606 OID 17597)
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- TOC entry 3853 (class 2606 OID 17603)
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- TOC entry 3857 (class 2606 OID 17605)
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- TOC entry 3865 (class 2606 OID 17607)
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- TOC entry 3876 (class 2606 OID 17650)
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- TOC entry 3795 (class 2606 OID 17754)
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- TOC entry 3728 (class 2606 OID 17771)
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- TOC entry 3660 (class 2606 OID 17773)
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- TOC entry 3725 (class 2606 OID 17775)
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- TOC entry 3716 (class 2606 OID 16904)
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- TOC entry 3701 (class 2606 OID 16838)
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- TOC entry 3643 (class 2606 OID 16612)
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- TOC entry 3712 (class 2606 OID 16906)
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- TOC entry 3652 (class 2606 OID 16614)
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- TOC entry 3689 (class 2606 OID 16620)
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- TOC entry 3631 (class 2606 OID 16624)
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- TOC entry 3670 (class 2606 OID 16628)
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- TOC entry 3704 (class 2606 OID 16842)
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- TOC entry 3657 (class 2606 OID 16630)
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- TOC entry 3663 (class 2606 OID 16632)
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- TOC entry 3648 (class 2606 OID 16634)
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- TOC entry 3746 (class 2606 OID 17758)
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- TOC entry 3759 (class 2606 OID 17135)
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- TOC entry 3755 (class 2606 OID 17133)
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- TOC entry 3752 (class 2606 OID 17131)
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- TOC entry 3749 (class 2606 OID 17129)
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- TOC entry 3695 (class 2606 OID 16636)
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- TOC entry 3636 (class 2606 OID 17752)
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- TOC entry 3723 (class 2606 OID 16908)
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- TOC entry 3827 (class 2606 OID 17476)
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- TOC entry 3665 (class 2606 OID 16638)
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- TOC entry 3640 (class 2606 OID 16640)
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- TOC entry 3687 (class 2606 OID 16642)
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- TOC entry 3897 (class 2606 OID 17893)
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- TOC entry 3812 (class 2606 OID 17434)
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- TOC entry 3822 (class 2606 OID 17462)
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- TOC entry 3838 (class 2606 OID 17531)
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- TOC entry 3832 (class 2606 OID 17501)
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- TOC entry 3817 (class 2606 OID 17448)
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- TOC entry 3829 (class 2606 OID 17486)
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- TOC entry 3835 (class 2606 OID 17516)
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- TOC entry 3679 (class 2606 OID 16644)
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- TOC entry 3765 (class 2606 OID 17143)
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- TOC entry 3761 (class 2606 OID 17141)
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- TOC entry 3895 (class 2606 OID 17878)
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- TOC entry 3891 (class 2606 OID 17868)
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- TOC entry 3739 (class 2606 OID 17016)
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- TOC entry 3779 (class 2606 OID 17285)
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- TOC entry 3786 (class 2606 OID 17292)
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3783 (class 2606 OID 17306)
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- TOC entry 3734 (class 2606 OID 17012)
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- TOC entry 3737 (class 2606 OID 17192)
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- TOC entry 3926 (class 2606 OID 18079)
-- Name: jgroups_ping constraint_jgroups_ping; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jgroups_ping
    ADD CONSTRAINT constraint_jgroups_ping PRIMARY KEY (address);


--
-- TOC entry 3731 (class 2606 OID 17010)
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- TOC entry 3777 (class 2606 OID 17971)
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- TOC entry 3772 (class 2606 OID 17262)
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- TOC entry 3706 (class 2606 OID 16902)
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- TOC entry 3710 (class 2606 OID 17185)
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- TOC entry 3667 (class 2606 OID 17777)
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- TOC entry 3770 (class 2606 OID 17225)
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- TOC entry 3767 (class 2606 OID 17223)
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- TOC entry 3692 (class 2606 OID 17137)
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- TOC entry 3905 (class 2606 OID 17940)
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- TOC entry 3907 (class 2606 OID 17947)
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3923 (class 2606 OID 18068)
-- Name: revoked_token constraint_rt; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.revoked_token
    ADD CONSTRAINT constraint_rt PRIMARY KEY (id);


--
-- TOC entry 3673 (class 2606 OID 17221)
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3790 (class 2606 OID 17299)
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- TOC entry 3698 (class 2606 OID 17779)
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- TOC entry 3629 (class 2606 OID 16456)
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- TOC entry 3804 (class 2606 OID 17402)
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- TOC entry 3799 (class 2606 OID 17361)
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- TOC entry 3810 (class 2606 OID 17732)
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- TOC entry 3808 (class 2606 OID 17390)
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- TOC entry 3889 (class 2606 OID 17853)
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- TOC entry 3910 (class 2606 OID 17988)
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- TOC entry 3903 (class 2606 OID 17920)
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- TOC entry 3781 (class 2606 OID 17662)
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- TOC entry 3721 (class 2606 OID 16959)
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- TOC entry 3634 (class 2606 OID 16648)
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- TOC entry 3801 (class 2606 OID 17806)
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- TOC entry 3683 (class 2606 OID 16652)
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- TOC entry 3742 (class 2606 OID 18057)
-- Name: user_consent uk_external_consent; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_external_consent UNIQUE (client_storage_provider, external_client_id, user_id);


--
-- TOC entry 3815 (class 2606 OID 17979)
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- TOC entry 3901 (class 2606 OID 17975)
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- TOC entry 3825 (class 2606 OID 17723)
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- TOC entry 3820 (class 2606 OID 17727)
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- TOC entry 3744 (class 2606 OID 18055)
-- Name: user_consent uk_local_consent; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_local_consent UNIQUE (client_id, user_id);


--
-- TOC entry 3914 (class 2606 OID 18061)
-- Name: org uk_org_alias; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_alias UNIQUE (realm_id, alias);


--
-- TOC entry 3916 (class 2606 OID 18046)
-- Name: org uk_org_group; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_group UNIQUE (group_id);


--
-- TOC entry 3918 (class 2606 OID 18044)
-- Name: org uk_org_name; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_name UNIQUE (realm_id, name);


--
-- TOC entry 3655 (class 2606 OID 16660)
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- TOC entry 3685 (class 2606 OID 17652)
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- TOC entry 3844 (class 1259 OID 18028)
-- Name: fed_user_attr_long_values; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fed_user_attr_long_values ON public.fed_user_attribute USING btree (long_value_hash, name);


--
-- TOC entry 3845 (class 1259 OID 18030)
-- Name: fed_user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fed_user_attr_long_values_lower_case ON public.fed_user_attribute USING btree (long_value_hash_lower_case, name);


--
-- TOC entry 3747 (class 1259 OID 18004)
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- TOC entry 3839 (class 1259 OID 17676)
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- TOC entry 3750 (class 1259 OID 17680)
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- TOC entry 3756 (class 1259 OID 17678)
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- TOC entry 3757 (class 1259 OID 17677)
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- TOC entry 3753 (class 1259 OID 17679)
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- TOC entry 3884 (class 1259 OID 17995)
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- TOC entry 3702 (class 1259 OID 18031)
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, substr(value, 1, 255));


--
-- TOC entry 3632 (class 1259 OID 17980)
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- TOC entry 3879 (class 1259 OID 17720)
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- TOC entry 3802 (class 1259 OID 17883)
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- TOC entry 3885 (class 1259 OID 17992)
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- TOC entry 3707 (class 1259 OID 17880)
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- TOC entry 3805 (class 1259 OID 17881)
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- TOC entry 3870 (class 1259 OID 17686)
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- TOC entry 3873 (class 1259 OID 17954)
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- TOC entry 3874 (class 1259 OID 17685)
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- TOC entry 3637 (class 1259 OID 17687)
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- TOC entry 3638 (class 1259 OID 17688)
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- TOC entry 3886 (class 1259 OID 17886)
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- TOC entry 3887 (class 1259 OID 17887)
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- TOC entry 3644 (class 1259 OID 17981)
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- TOC entry 3713 (class 1259 OID 17419)
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- TOC entry 3714 (class 1259 OID 17418)
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- TOC entry 3846 (class 1259 OID 17780)
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- TOC entry 3849 (class 1259 OID 17800)
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- TOC entry 3850 (class 1259 OID 17963)
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- TOC entry 3851 (class 1259 OID 17782)
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- TOC entry 3854 (class 1259 OID 17783)
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- TOC entry 3855 (class 1259 OID 17784)
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- TOC entry 3858 (class 1259 OID 17785)
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- TOC entry 3859 (class 1259 OID 17786)
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- TOC entry 3862 (class 1259 OID 17787)
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- TOC entry 3863 (class 1259 OID 17788)
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- TOC entry 3866 (class 1259 OID 17789)
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- TOC entry 3867 (class 1259 OID 17790)
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- TOC entry 3787 (class 1259 OID 18006)
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- TOC entry 3788 (class 1259 OID 17691)
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- TOC entry 3784 (class 1259 OID 17692)
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- TOC entry 3735 (class 1259 OID 17694)
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- TOC entry 3717 (class 1259 OID 17693)
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- TOC entry 3718 (class 1259 OID 18072)
-- Name: idx_idp_for_login; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_idp_for_login ON public.identity_provider USING btree (realm_id, enabled, link_only, hide_on_login, organization_id);


--
-- TOC entry 3719 (class 1259 OID 18071)
-- Name: idx_idp_realm_org; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_idp_realm_org ON public.identity_provider USING btree (realm_id, organization_id);


--
-- TOC entry 3649 (class 1259 OID 17695)
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- TOC entry 3650 (class 1259 OID 17696)
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- TOC entry 3773 (class 1259 OID 18035)
-- Name: idx_offline_uss_by_broker_session_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_offline_uss_by_broker_session_id ON public.offline_user_session USING btree (broker_session_id, realm_id);


--
-- TOC entry 3774 (class 1259 OID 18034)
-- Name: idx_offline_uss_by_last_session_refresh; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_offline_uss_by_last_session_refresh ON public.offline_user_session USING btree (realm_id, offline_flag, last_session_refresh);


--
-- TOC entry 3775 (class 1259 OID 17999)
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- TOC entry 3921 (class 1259 OID 18063)
-- Name: idx_org_domain_org_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_org_domain_org_id ON public.org_domain USING btree (org_id);


--
-- TOC entry 3898 (class 1259 OID 18059)
-- Name: idx_perm_ticket_owner; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_perm_ticket_owner ON public.resource_server_perm_ticket USING btree (owner);


--
-- TOC entry 3899 (class 1259 OID 18058)
-- Name: idx_perm_ticket_requester; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_perm_ticket_requester ON public.resource_server_perm_ticket USING btree (requester);


--
-- TOC entry 3708 (class 1259 OID 17697)
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- TOC entry 3658 (class 1259 OID 17700)
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- TOC entry 3797 (class 1259 OID 17879)
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- TOC entry 3796 (class 1259 OID 17701)
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- TOC entry 3661 (class 1259 OID 17704)
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- TOC entry 3729 (class 1259 OID 17703)
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- TOC entry 3653 (class 1259 OID 17699)
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- TOC entry 3726 (class 1259 OID 17705)
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- TOC entry 3668 (class 1259 OID 17706)
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- TOC entry 3768 (class 1259 OID 17707)
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- TOC entry 3833 (class 1259 OID 17708)
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- TOC entry 3830 (class 1259 OID 17709)
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- TOC entry 3823 (class 1259 OID 17728)
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- TOC entry 3813 (class 1259 OID 17729)
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- TOC entry 3818 (class 1259 OID 17730)
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- TOC entry 3924 (class 1259 OID 18069)
-- Name: idx_rev_token_on_expire; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_rev_token_on_expire ON public.revoked_token USING btree (expire);


--
-- TOC entry 3908 (class 1259 OID 17953)
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- TOC entry 3806 (class 1259 OID 17882)
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- TOC entry 3671 (class 1259 OID 17713)
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- TOC entry 3836 (class 1259 OID 17714)
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- TOC entry 3732 (class 1259 OID 17961)
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- TOC entry 3892 (class 1259 OID 17888)
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- TOC entry 3893 (class 1259 OID 18005)
-- Name: idx_usconsent_scope_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usconsent_scope_id ON public.user_consent_client_scope USING btree (scope_id);


--
-- TOC entry 3674 (class 1259 OID 17415)
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- TOC entry 3675 (class 1259 OID 18002)
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- TOC entry 3740 (class 1259 OID 17412)
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- TOC entry 3641 (class 1259 OID 17416)
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- TOC entry 3680 (class 1259 OID 17409)
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- TOC entry 3791 (class 1259 OID 17411)
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- TOC entry 3693 (class 1259 OID 17417)
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- TOC entry 3696 (class 1259 OID 17410)
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- TOC entry 3681 (class 1259 OID 18003)
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- TOC entry 3762 (class 1259 OID 17716)
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- TOC entry 3763 (class 1259 OID 17717)
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- TOC entry 3690 (class 1259 OID 17718)
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- TOC entry 3699 (class 1259 OID 17719)
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- TOC entry 3676 (class 1259 OID 18027)
-- Name: user_attr_long_values; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_attr_long_values ON public.user_attribute USING btree (long_value_hash, name);


--
-- TOC entry 3677 (class 1259 OID 18029)
-- Name: user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_attr_long_values_lower_case ON public.user_attribute USING btree (long_value_hash_lower_case, name);


--
-- TOC entry 3951 (class 2606 OID 16913)
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3945 (class 2606 OID 16843)
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3950 (class 2606 OID 16923)
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3946 (class 2606 OID 17070)
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3937 (class 2606 OID 16668)
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3941 (class 2606 OID 16673)
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3935 (class 2606 OID 16683)
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3993 (class 2606 OID 17921)
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3939 (class 2606 OID 16688)
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3942 (class 2606 OID 16698)
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3932 (class 2606 OID 16703)
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- TOC entry 3936 (class 2606 OID 16708)
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3933 (class 2606 OID 16723)
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3929 (class 2606 OID 16728)
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- TOC entry 3960 (class 2606 OID 17164)
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- TOC entry 3961 (class 2606 OID 17159)
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3959 (class 2606 OID 17154)
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3958 (class 2606 OID 17149)
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3943 (class 2606 OID 16738)
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3970 (class 2606 OID 17827)
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- TOC entry 3971 (class 2606 OID 17817)
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- TOC entry 3947 (class 2606 OID 17812)
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- TOC entry 3986 (class 2606 OID 17671)
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3984 (class 2606 OID 17619)
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- TOC entry 3985 (class 2606 OID 17614)
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3969 (class 2606 OID 17319)
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3964 (class 2606 OID 17179)
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- TOC entry 3962 (class 2606 OID 17174)
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- TOC entry 3963 (class 2606 OID 17169)
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3982 (class 2606 OID 17537)
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3980 (class 2606 OID 17522)
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3989 (class 2606 OID 17894)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 3972 (class 2606 OID 17738)
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 3990 (class 2606 OID 17899)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3991 (class 2606 OID 17904)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- TOC entry 3983 (class 2606 OID 17532)
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3981 (class 2606 OID 17517)
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- TOC entry 3992 (class 2606 OID 17926)
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3974 (class 2606 OID 17733)
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 3976 (class 2606 OID 17487)
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3978 (class 2606 OID 17502)
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3979 (class 2606 OID 17507)
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3977 (class 2606 OID 17492)
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- TOC entry 3973 (class 2606 OID 17743)
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 3930 (class 2606 OID 16753)
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- TOC entry 3988 (class 2606 OID 17869)
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- TOC entry 3957 (class 2606 OID 17033)
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3967 (class 2606 OID 17293)
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- TOC entry 3966 (class 2606 OID 17307)
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- TOC entry 3954 (class 2606 OID 16979)
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3934 (class 2606 OID 16763)
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3955 (class 2606 OID 17023)
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3956 (class 2606 OID 17193)
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- TOC entry 3944 (class 2606 OID 16773)
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3938 (class 2606 OID 16783)
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3948 (class 2606 OID 16918)
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3931 (class 2606 OID 16798)
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3949 (class 2606 OID 17186)
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- TOC entry 3987 (class 2606 OID 17854)
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3965 (class 2606 OID 17228)
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3994 (class 2606 OID 17934)
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3995 (class 2606 OID 17948)
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- TOC entry 3953 (class 2606 OID 16948)
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3940 (class 2606 OID 16818)
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- TOC entry 3968 (class 2606 OID 17300)
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3975 (class 2606 OID 17477)
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3952 (class 2606 OID 16928)
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


-- Completed on 2025-06-25 19:30:35 UTC

--
-- PostgreSQL database dump complete
--


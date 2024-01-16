\connect oauth_nowhere;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;
COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';

SET default_tablespace = '';

SET default_table_access_method = heap;

CREATE TABLE public.auth_user (
                                  id uuid NOT NULL,
                                  username character varying(255),
                                  password character varying(255),
                                  enabled boolean,
                                  account_non_expired boolean,
                                  account_non_locked boolean,
                                  credentials_non_expired boolean
);


ALTER TABLE public.auth_user OWNER TO postgres;

CREATE TABLE public.oauth2_registered_client (
                                                 id varchar(100) NOT NULL,
                                                 client_id varchar(100) NOT NULL,
                                                 client_id_issued_at timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
                                                 client_secret varchar(200) DEFAULT NULL,
                                                 client_secret_expires_at timestamp DEFAULT NULL,
                                                 client_name varchar(200) NOT NULL,
                                                 client_authentication_methods varchar(1000) NOT NULL,
                                                 authorization_grant_types varchar(1000) NOT NULL,
                                                 redirect_uris varchar(1000) DEFAULT NULL,
                                                 post_logout_redirect_uris varchar(1000) DEFAULT NULL,
                                                 scopes varchar(1000) NOT NULL,
                                                 client_settings varchar(2000) NOT NULL,
                                                 token_settings varchar(2000) NOT NULL
);

ALTER TABLE public.oauth2_registered_client OWNER TO postgres;

CREATE TABLE public.oauth2_authorization_consent (
                                                     registered_client_id varchar(100) NOT NULL,
                                                     principal_name varchar(200) NOT NULL,
                                                     authorities varchar(1000) NOT NULL
);

ALTER TABLE public.oauth2_authorization_consent OWNER TO postgres;

CREATE TABLE public.oauth2_authorization (
                                             id varchar(100) NOT NULL,
                                             registered_client_id varchar(100) NOT NULL,
                                             principal_name varchar(200) NOT NULL,
                                             authorization_grant_type varchar(100) NOT NULL,
                                             authorized_scopes varchar(1000) DEFAULT NULL,
                                             attributes character varying(4000) DEFAULT NULL,
                                             state varchar(500) DEFAULT NULL,
                                             authorization_code_value character varying(4000) DEFAULT NULL,
                                             authorization_code_issued_at timestamp DEFAULT NULL,
                                             authorization_code_expires_at timestamp DEFAULT NULL,
                                             authorization_code_metadata character varying(255) DEFAULT NULL,
                                             access_token_value character varying(4000) DEFAULT NULL,
                                             access_token_issued_at timestamp DEFAULT NULL,
                                             access_token_expires_at timestamp DEFAULT NULL,
                                             access_token_metadata character varying(2000) DEFAULT NULL,
                                             access_token_type varchar(100) DEFAULT NULL,
                                             access_token_scopes varchar(1000) DEFAULT NULL,
                                             oidc_id_token_value character varying(4000) DEFAULT NULL,
                                             oidc_id_token_issued_at timestamp DEFAULT NULL,
                                             oidc_id_token_expires_at timestamp DEFAULT NULL,
                                             oidc_id_token_metadata character varying(4000) DEFAULT NULL,
                                             refresh_token_value character varying(4000) DEFAULT NULL,
                                             refresh_token_issued_at timestamp DEFAULT NULL,
                                             refresh_token_expires_at timestamp DEFAULT NULL,
                                             refresh_token_metadata character varying(4000) DEFAULT NULL,
                                             user_code_value character varying(4000) DEFAULT NULL,
                                             user_code_issued_at timestamp DEFAULT NULL,
                                             user_code_expires_at timestamp DEFAULT NULL,
                                             user_code_metadata character varying(4000) DEFAULT NULL,
                                             device_code_value character varying(4000) DEFAULT NULL,
                                             device_code_issued_at timestamp DEFAULT NULL,
                                             device_code_expires_at timestamp DEFAULT NULL,
                                             device_code_metadata character varying(4000) DEFAULT NULL
);

ALTER TABLE public.oauth2_authorization OWNER TO postgres;

INSERT INTO public.auth_user VALUES ('0c7313d3-58ed-4039-bffa-7282c965db3f', 'user@user.com', '{bcrypt}$2a$12$6fUbK5fCxakRgLy1E5.vqOQk93J3oH8Vc3v2nLN7t9jmnKub0JrdS', true, true, true, true);

INSERT INTO public.oauth2_registered_client VALUES ('0deba273-eca6-4793-91f9-f24ffffe634d', 'nowhere-client', '2023-08-13 16:26:33.788646+01', '{bcrypt}$2a$12$FpUwRzVr.eYFYGg5k1/YAO5G.DJMeRyiy4Yb22lD2rcWg1cS5D/3y', NULL, 'nowhere-client', 'client_secret_basic', 'refresh_token,client_credentials,authorization_code', 'https://oidcdebugger.com/debug,https://oauthdebugger.com/debug', 'http://127.0.0.1:9000/', 'openid,profile,message.read,message.write,client.create,client.read', '{"@class":"java.util.Collections$UnmodifiableMap","settings.client.require-proof-key":true,"settings.client.require-authorization-consent":true}', '{"@class":"java.util.Collections$UnmodifiableMap","settings.token.reuse-refresh-tokens":true,"settings.token.id-token-signature-algorithm":["org.springframework.security.oauth2.jose.jws.SignatureAlgorithm","RS256"],"settings.token.access-token-time-to-live":["java.time.Duration",86400.000000000],"settings.token.access-token-format":{"@class":"org.springframework.security.oauth2.server.authorization.settings.OAuth2TokenFormat","value":"self-contained"},"settings.token.refresh-token-time-to-live":["java.time.Duration",2592000.000000000],"settings.token.authorization-code-time-to-live":["java.time.Duration",86400.000000000],"settings.token.device-code-time-to-live":["java.time.Duration",86400.000000000]}');

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_unique_username UNIQUE (username);


--
-- Name: oauth2_authorization_consent oauth2_authorization_consent_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth2_authorization_consent
    ADD CONSTRAINT oauth2_authorization_consent_pkey PRIMARY KEY (registered_client_id, principal_name);


--
-- Name: oauth2_authorization oauth2_authorization_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth2_authorization
    ADD CONSTRAINT oauth2_authorization_pkey PRIMARY KEY (id);


--
-- Name: oauth2_registered_client oauth2_registered_client_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth2_registered_client
    ADD CONSTRAINT oauth2_registered_client_pkey PRIMARY KEY (id);



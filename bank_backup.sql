--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2

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
-- Name: get_current_amount(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_current_amount(a_id integer) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
DECLARE
  current_amount NUMERIC;
BEGIN
  SELECT current_balance INTO current_amount FROM accounts WHERE account_id = a_id;
  RETURN current_amount;
END;
$$;


ALTER FUNCTION public.get_current_amount(a_id integer) OWNER TO postgres;

--
-- Name: insert_into_accounts(character varying, character varying); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.insert_into_accounts(IN cid character varying, IN cur_bal character varying)
    LANGUAGE sql
    AS $$
INSERT INTO ACCOUNTS 
(account_id, customer_id, date_opened,current_balance)
VALUES
(NEXTVAL('a_id_sequence'), cast(cid as integer),CURRENT_DATE,cast(cur_bal as float(20)));
$$;


ALTER PROCEDURE public.insert_into_accounts(IN cid character varying, IN cur_bal character varying) OWNER TO postgres;

--
-- Name: insert_into_branch(character varying, character varying, character varying, character varying); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.insert_into_branch(IN nm character varying, IN hn character varying, IN cy character varying, IN zc character varying)
    LANGUAGE sql
    AS $$
INSERT INTO BRANCH VALUES (NEXTVAL('b_id_sequence'),nm,hn,cy,zc);
$$;


ALTER PROCEDURE public.insert_into_branch(IN nm character varying, IN hn character varying, IN cy character varying, IN zc character varying) OWNER TO postgres;

--
-- Name: insert_into_customer(character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.insert_into_customer(IN nm character varying, IN ph character varying, IN em character varying, IN hn character varying, IN city character varying, IN zp character varying, IN un character varying, IN pwd character varying)
    LANGUAGE sql
    AS $$
INSERT INTO CUSTOMER 
(customer_id,name,phone,email,house_no,city,zipcode,username,password)
VALUES
(NEXTVAL('c_id_sequence'),nm,ph,em,hn,city,zp,un,pwd);
$$;


ALTER PROCEDURE public.insert_into_customer(IN nm character varying, IN ph character varying, IN em character varying, IN hn character varying, IN city character varying, IN zp character varying, IN un character varying, IN pwd character varying) OWNER TO postgres;

--
-- Name: insert_into_emp_login(character varying, character varying); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.insert_into_emp_login(IN un character varying, IN up character varying)
    LANGUAGE sql
    AS $$
insert into EMP_LOGIN(username,user_password) values(un,up);
$$;


ALTER PROCEDURE public.insert_into_emp_login(IN un character varying, IN up character varying) OWNER TO postgres;

--
-- Name: insert_into_transaction(character varying, character varying, character varying, character varying); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.insert_into_transaction(IN aid character varying, IN bid character varying, IN amt character varying, IN acn character varying)
    LANGUAGE sql
    AS $$
INSERT INTO TRANSACTION VALUES (NEXTVAL('t_id_sequence'),cast(aid as integer),cast(bid as integer),CURRENT_DATE, cast(amt as float(20)),acn);
UPDATE accounts
SET current_balance=current_balance+cast(amt as float)
WHERE account_id = cast(aid as integer);
$$;


ALTER PROCEDURE public.insert_into_transaction(IN aid character varying, IN bid character varying, IN amt character varying, IN acn character varying) OWNER TO postgres;

--
-- Name: a_id_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.a_id_sequence
    START WITH 100011
    INCREMENT BY 1
    MINVALUE 100011
    MAXVALUE 9999999
    CACHE 20;


ALTER SEQUENCE public.a_id_sequence OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: accounts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts (
    account_id integer NOT NULL,
    customer_id integer NOT NULL,
    date_opened date NOT NULL,
    current_balance double precision
);


ALTER TABLE public.accounts OWNER TO postgres;

--
-- Name: b_id_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.b_id_sequence
    START WITH 101
    INCREMENT BY 1
    MINVALUE 101
    MAXVALUE 9999999999
    CACHE 20;


ALTER SEQUENCE public.b_id_sequence OWNER TO postgres;

--
-- Name: branch; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.branch (
    branch_id integer NOT NULL,
    name character varying(50) NOT NULL,
    house_no character varying(50) NOT NULL,
    city character varying(50) NOT NULL,
    zip_code character varying(50) NOT NULL
);


ALTER TABLE public.branch OWNER TO postgres;

--
-- Name: c_id_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.c_id_sequence
    START WITH 10001
    INCREMENT BY 1
    MINVALUE 10001
    MAXVALUE 99999999
    CACHE 20;


ALTER SEQUENCE public.c_id_sequence OWNER TO postgres;

--
-- Name: customer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer (
    customer_id integer NOT NULL,
    name character varying(50) NOT NULL,
    phone character varying(50) NOT NULL,
    email character varying(50) NOT NULL,
    house_no character varying(50) NOT NULL,
    city character varying(50) NOT NULL,
    zipcode character varying(50) NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(50) NOT NULL
);


ALTER TABLE public.customer OWNER TO postgres;

--
-- Name: emp_login; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.emp_login (
    username character varying(100),
    user_password character varying(100)
);


ALTER TABLE public.emp_login OWNER TO postgres;

--
-- Name: t_id_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.t_id_sequence
    START WITH 1001
    INCREMENT BY 1
    MINVALUE 1001
    MAXVALUE 9999999999
    CACHE 20;


ALTER SEQUENCE public.t_id_sequence OWNER TO postgres;

--
-- Name: transaction; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transaction (
    transaction_id integer NOT NULL,
    account_id integer NOT NULL,
    branch_id integer NOT NULL,
    date_of_transaction date NOT NULL,
    amount real NOT NULL,
    action character varying(20)
);


ALTER TABLE public.transaction OWNER TO postgres;

--
-- Data for Name: accounts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts (account_id, customer_id, date_opened, current_balance) FROM stdin;
\.


--
-- Data for Name: branch; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.branch (branch_id, name, house_no, city, zip_code) FROM stdin;
101	Malibagh	M502	Dhaka	1217
102	Mohammadpur	M555	Dhaka	1207
\.


--
-- Data for Name: customer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customer (customer_id, name, phone, email, house_no, city, zipcode, username, password) FROM stdin;
101	John Doe	9876543210	john@example.com	12A	New York	10001	john123	securepass
\.


--
-- Data for Name: emp_login; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.emp_login (username, user_password) FROM stdin;
\.


--
-- Data for Name: transaction; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transaction (transaction_id, account_id, branch_id, date_of_transaction, amount, action) FROM stdin;
\.


--
-- Name: a_id_sequence; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.a_id_sequence', 100030, true);


--
-- Name: b_id_sequence; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.b_id_sequence', 120, true);


--
-- Name: c_id_sequence; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.c_id_sequence', 10020, true);


--
-- Name: t_id_sequence; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.t_id_sequence', 1020, true);


--
-- Name: accounts accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (account_id);


--
-- Name: branch branch_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.branch
    ADD CONSTRAINT branch_pkey PRIMARY KEY (branch_id);


--
-- Name: customer customer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (customer_id);


--
-- Name: customer customer_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_username_key UNIQUE (username);


--
-- Name: transaction transaction_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT transaction_pkey PRIMARY KEY (transaction_id);


--
-- Name: accounts accounts_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customer(customer_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: transaction transaction_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT transaction_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.accounts(account_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: transaction transaction_branch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT transaction_branch_id_fkey FOREIGN KEY (branch_id) REFERENCES public.branch(branch_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--


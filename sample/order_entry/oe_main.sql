rem
rem Header: oe_main.sql 09-jan-01
rem
rem Copyright (c) 2001, 2004, Oracle. All rights reserved.  
rem
rem Owner  : ahunold
rem
rem NAME
rem   oe_main.sql - Main script for OE schema, including OC subschema 
rem
rem DESCRIPTON
rem   Creates and populated the Order Entry (OE) and Online
rem   Catalog (OC) Sample Schema
rem
rem NOTES
rem   Run as SYS or SYSTEM
rem   Prerequisites:
rem     Tablespaces present
rem     Database enabled for Spatial and XML
rem
rem MODIFIED   (MM/DD/YY)
rem   pthornto  07/29/04 - 
rem   pthornto  07/16/04 - obsolete 'connect' role 
rem   ahunold   11/21/02 - bug 2635796
rem   ahunold   10/07/02 - passing more parameters to coe*.sql
rem   hyeh      08/29/02 - hyeh_mv_comschema_to_rdbms
rem   ahunold   08/15/02 - coe, loe,
rem   ahunold   07/29/02 - versioning comments
rem   ahunold   07/22/02 - typo
rem   ahunold   07/15/02 - versions
rem   ahunold   08/28/01 - roles
rem   ahunold   07/13/01 - NLS Territory.
rem   ahunold   04/13/01 - spool, additional parameter
rem   ahunold   03/29/01 - spool
rem   ahunold   03/12/01 - prompts
rem   ahunold   03/02/01 - NLS_LANGUAGE
rem   ahunold   01/09/01 - checkin ADE

SET ECHO OFF

PROMPT 
PROMPT specify password for OE as parameter 1:
DEFINE pass     = &1
PROMPT 
PROMPT specify default tablespeace for OE as parameter 2:
DEFINE tbs      = &2
PROMPT 
PROMPT specify temporary tablespace for OE as parameter 3:
DEFINE ttbs     = &3
PROMPT 
PROMPT specify password for HR as parameter 4:
DEFINE passhr   = &4
PROMPT 
PROMPT specify password for SYS as parameter 5:
DEFINE pass_sys = &5
PROMPT 
PROMPT specify directory path for the data files as parameter 6:
DEFINE data_path = &6
PROMPT
PROMPT writeable directory path for the log files as parameter 7:
DEFINE log_path = &7
PROMPT
PROMPT specify version as parameter 8:
DEFINE vrs = &8
PROMPT

-- The first dot in the spool command below is 
-- the SQL*Plus concatenation character

DEFINE spool_file = &log_path.oe_oc_&vrs..log
SPOOL &spool_file

-- Dropping the user with all its objects

DROP USER oe CASCADE;

REM =======================================================
REM create user
REM 
REM The user is assigned tablespaces and quota in separate
REM ALTER USER statements so that the CREATE USER statement
REM will succeed even if the demo and temp tablespaces do
REM not exist.
REM =======================================================

CREATE USER oe IDENTIFIED BY &pass;

ALTER USER oe DEFAULT TABLESPACE &tbs QUOTA UNLIMITED ON &tbs;

ALTER USER oe TEMPORARY TABLESPACE &ttbs;

GRANT CREATE SESSION, CREATE SYNONYM, CREATE VIEW TO oe;
GRANT CREATE DATABASE LINK, ALTER SESSION TO oe;
GRANT RESOURCE TO oe;
GRANT CREATE MATERIALIZED VIEW  TO oe;
GRANT QUERY REWRITE             TO oe;

REM =======================================================
REM grants from sys schema
REM =======================================================

CONNECT sys/&pass_sys AS SYSDBA;  
GRANT execute ON sys.dbms_stats TO oe;

REM =======================================================
REM grants from hr schema
REM =======================================================

CONNECT hr/&passhr;
GRANT REFERENCES, SELECT ON employees TO oe;
GRANT REFERENCES, SELECT ON countries TO oe;
GRANT REFERENCES, SELECT ON locations TO oe;
GRANT SELECT ON jobs TO oe;
GRANT SELECT ON job_history TO oe;
GRANT SELECT ON departments TO oe;


REM =======================================================
REM create oe schema (order entry)
REM =======================================================

CONNECT oe/&pass
ALTER SESSION SET NLS_LANGUAGE=American;
ALTER SESSION SET NLS_TERRITORY=America;

--
-- call script to create OE objects
--

DEFINE vscript = ?/demo/schema/order_entry/coe_&vrs
@&vscript &vrs &pass &pass_sys

--
-- call script to load OE objects
--

DEFINE vscript = ?/demo/schema/order_entry/loe_&vrs
@&vscript &vrs &data_path &log_path &pass

--
-- call script for post-load operations on OE
--

DEFINE vscript = ?/demo/schema/order_entry/poe_&vrs
@&vscript &vrs 

--
-- OC subschema
--

@?/demo/schema/order_entry/oc_main

--
-- statistics
--

@?/demo/schema/order_entry/oe_analz

spool off

Rem $Header: bi_main.sql 23-feb-2005.17:01:55 cbauwens Exp $
Rem
Rem Copyright (c) 2002, 2005, Oracle. All rights reserved.  
Rem
Rem    NAME
Rem      bi_main.sql - Main script for BI user and supporting structures to 
Rem                    create the VPD using application context.
Rem
Rem    DESCRIPTION
Rem      tbd
Rem
Rem    MODIFIED     (MM/DD/YY)
Rem      cbauwens    02/23/05 - deprocating connect role 
Rem      ahunold     05/07/03 - no COMPANY_ID
Rem      hyeh        11/19/02 - fix 'set echo'
Rem      ahunold     09/17/02 - eliminate delta scripts
Rem	 ahunold     08/07/02 - run in $OH
Rem      ahunold     06/17/02 - no VPD
Rem      ahunold     05/30/02 - parameter passing
Rem      ahunold     05/16/02 - ahunold_bi_main
Rem      ngreenberg  05/14/02 - created 
Rem

SET ECHO OFF
SET FEEDBACK 1
SET NUMWIDTH 10
SET LINESIZE 80
SET TRIMSPOOL ON
SET TAB OFF
SET PAGESIZE 100
SET CONCAT '.'

PROMPT 
PROMPT specify password for BI as parameter 1:
DEFINE pwd_bi   = &1
PROMPT 
PROMPT specify default tablespeace for BI as parameter 2:
DEFINE tbs      = &2
PROMPT 
PROMPT specify temporary tablespace for BI as parameter 3:
DEFINE ttbs     = &3
PROMPT 
PROMPT specify password for SYS as parameter 4:
DEFINE pwd_sys  = &4
PROMPT 
PROMPT specify password for OE as parameter 5:
DEFINE pwd_oe   = &5
PROMPT
PROMPT specify password for SH as parameter 6:
DEFINE pwd_sh   = &6
PROMPT
PROMPT specify log path as parameter 7:
DEFINE log_path = &7
PROMPT
PROMPT specify version as parameter 8:
DEFINE vrs = &8
PROMPT

-- The first dot in the spool command below is 
-- the SQL*Plus concatenation character

DEFINE spool_file = &log_path.bi_&vrs..log
SPOOL &spool_file

CONNECT sys/&pwd_sys AS SYSDBA;

REM =======================================================
REM cleanup section
REM =======================================================

DROP USER bi CASCADE;

REM =======================================================
REM create user
REM three separate commands, so the create user command 
REM will succeed regardless of the existence of the 
REM DEMO and TEMP tablespaces 
REM =======================================================

CREATE USER bi IDENTIFIED BY &pwd_bi;

ALTER USER bi DEFAULT TABLESPACE &tbs
              QUOTA UNLIMITED ON &tbs;

ALTER USER bi TEMPORARY TABLESPACE &ttbs;


GRANT CREATE SESSION       TO bi;
GRANT CREATE SYNONYM       TO bi;
GRANT CREATE TABLE         TO bi;
GRANT CREATE VIEW          TO bi;
GRANT CREATE SEQUENCE      TO bi;
GRANT CREATE CLUSTER       TO bi;
GRANT CREATE DATABASE LINK TO bi;
GRANT ALTER SESSION        TO bi;
GRANT RESOURCE             TO bi;

REM =======================================================
REM  Changes made as OE
REM     Grant object privileges to BI
REM =======================================================

@?/demo/schema/bus_intelligence/bi_oe_pr.sql &pwd_oe

REM =======================================================
REM  Changes made as SH 
REM     Grant object privileges to BI
REM =======================================================

@?/demo/schema/bus_intelligence/bi_sh_pr.sql &pwd_sh

REM =======================================================
REM  Views and synonyms in the 10i BI schema
REM =======================================================

@?/demo/schema/bus_intelligence/bi_views.sql &pwd_bi

REM =======================================================
REM  Verification
REM =======================================================

SET ECHO ON
COLUMN TABLE_NAME FORMAT A25
COLUMN COLUMN_NAME FORMAT A30

CONNECT bi/&pwd_bi;

SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM products;
SELECT COUNT(*) FROM promotions;
SELECT COUNT(*) FROM sales;
SELECT COUNT(*) FROM costs;

SELECT COUNT(*) FROM sh.cal_month_sales_mv;
SELECT COUNT(*) FROM sh.fweek_pscat_sales_mv;

SELECT COUNT(*) FROM channels;
SELECT COUNT(*) FROM countries;
SELECT COUNT(*) FROM times;

SET ECHO OFF

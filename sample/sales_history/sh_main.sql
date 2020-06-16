Rem
Rem $Header: sh_main.sql 28-jun-2007.19:10:02 glyon Exp $
Rem
Rem sh_main.sql
Rem
Rem Copyright (c) 2001, 2005, Oracle. All rights reserved.  
Rem
Rem    NAME
Rem      sh_main.sql - Main schema creation and load script 
Rem
Rem    DESCRIPTION
Rem      SH is the Sales History schema of the Oracle Sample
Rem	   Schemas
Rem
Rem    NOTES
Rem     CAUTION: use absolute pathnames as parameters 5 and 6.
Rem     Example (UNIX) echo $ORACLE_HOME/demo/schema/sales_history      
Rem     Please make sure that parameters 5 and 6 are specified
Rem     INCLUDING the trailing directory delimiter, since the
Rem     directory parameters and the filenames are concatenated 
Rem     without adding any delimiters.
Rem     Run this as SYS or SYSTEM
Rem
Rem    MODIFIED   (MM/DD/YY)
Rem     glyon      06/28/07 - grant CWM_USER role, if it exists
Rem     cbauwens   02/23/05 - depricating connect role 
Rem     ahunold    10/14/02 - 
Rem     hyeh       08/29/02 - hyeh_mv_comschema_to_rdbms
Rem     ahunold    08/20/02 - path > dir
Rem     ahunold    08/15/02 - versioning
Rem     ahunold    04/30/02 - Reduced DIRECTORY privileges
Rem     ahunold    08/28/01 - roles
Rem     ahunold    07/13/01 - NLS Territory
Rem     ahunold    04/13/01 - spool, notes
Rem     ahunold    04/10/01 - flexible log and data paths
Rem     ahunold    03/28/01 - spool
Rem     ahunold    03/23/01 - absolute path names
Rem     ahunold    03/14/01 - prompts
Rem     ahunold    03/09/01 - privileges
Rem     hbaer      03/01/01 - changed loading from COSTS table from
Rem			      SQL*Loader to external table with GROUP BY
Rem			      Added also CREATE DIRECTORY privilege
Rem

SET ECHO OFF

PROMPT 
PROMPT specify password for SH as parameter 1:
DEFINE pass     = &1
PROMPT 
PROMPT specify default tablespace for SH as parameter 2:
DEFINE tbs      = &2
PROMPT 
PROMPT specify temporary tablespace for SH as parameter 3:
DEFINE ttbs     = &3
PROMPT 
PROMPT specify password for SYS as parameter 4:
DEFINE pass_sys = &4
PROMPT
PROMPT specify directory path for the data files as parameter 5:
DEFINE data_dir = &5
PROMPT
PROMPT writeable directory path for the log files as parameter 6:
DEFINE log_dir = &6
PROMPT
PROMPT specify version as parameter 7:
DEFINE vrs = &7
PROMPT

DEFINE spool_file = &log_dir.sh_&vrs..log
SPOOL &spool_file 

ALTER SESSION SET NLS_LANGUAGE='American';

--
-- Dropping the user with all its objects
--

DROP USER sh CASCADE;

REM =======================================================
REM create user
REM THIS WILL ONLY WORK IF APPROPRIATE TS ARE PRESENT
REM =======================================================

CREATE USER sh IDENTIFIED BY &pass;

ALTER USER sh DEFAULT TABLESPACE &tbs
 QUOTA UNLIMITED ON &tbs;
ALTER USER sh TEMPORARY TABLESPACE &ttbs;

GRANT CREATE DIMENSION         TO sh;
GRANT QUERY REWRITE            TO sh;
GRANT CREATE MATERIALIZED VIEW TO sh;


GRANT CREATE SESSION           TO sh;
GRANT CREATE SYNONYM           TO sh;
GRANT CREATE TABLE             TO sh;
GRANT CREATE VIEW              TO sh;
GRANT CREATE SEQUENCE          TO sh;
GRANT CREATE CLUSTER           TO sh;
GRANT CREATE DATABASE LINK     TO sh;
GRANT ALTER SESSION            TO sh;


GRANT RESOURCE              TO sh;
GRANT select_catalog_role   TO sh;

Rem grant cwm_user role if it exists
declare
  cursor cwmuserrole is select role from dba_roles where role = 'CWM_USER';
  cwmuserrolename varchar2(30);
begin
  if not  cwmuserrole%isopen then 
    open cwmuserrole;
    fetch cwmuserrole into cwmuserrolename;
    if cwmuserrole%found then
      execute immediate 'GRANT cwm_user TO sh';
    end if;
    close cwmuserrole;
  end if;
end;
/

rem   ALTER USER sh GRANT CONNECT THROUGH olapsvr;

REM =======================================================
REM grants for sys schema
REM =======================================================

CONNECT sys/&pass_sys AS SYSDBA;
GRANT execute ON sys.dbms_stats TO sh;

REM =======================================================
REM DIRECTORY objects are always owned by SYS
REM    for security reasons, SH does not have 
REM    CREATE ANY DIRECTORY system privilege
REM =======================================================

CREATE OR REPLACE DIRECTORY data_file_dir AS '&data_dir';
CREATE OR REPLACE DIRECTORY log_file_dir AS '&log_dir';

GRANT READ ON DIRECTORY data_file_dir TO sh;
GRANT READ ON DIRECTORY log_file_dir  TO sh;
GRANT WRITE ON DIRECTORY log_file_dir TO sh;
 
REM =======================================================
REM create sh schema objects (sales history - star schema)
REM =======================================================

CONNECT sh/&pass

ALTER SESSION SET NLS_LANGUAGE=American;
ALTER SESSION SET NLS_TERRITORY=America;

REM =======================================================
REM Create tables
REM =======================================================

CONNECT sh/&pass

DEFINE vscript = ?/demo/schema/sales_history/csh_&vrs
@&vscript

REM =======================================================
REM Populate tables
REM =======================================================

DEFINE vscript = ?/demo/schema/sales_history/lsh_&vrs 
@&vscript &pass &data_dir &log_dir &vrs

REM =======================================================
REM Post load operations
REM =======================================================

DEFINE vscript = ?/demo/schema/sales_history/psh_&vrs 
@&vscript


spool off

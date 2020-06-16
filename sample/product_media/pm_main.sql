Rem
Rem $Header: pm_main.sql 19-nov-2002.13:58:58 hyeh Exp $
Rem
Rem pm_main.sql
Rem
Rem Copyright (c) 2001, 2002, Oracle Corporation.  All rights reserved.  
Rem
Rem    NAME
Rem      pm_main.sql - Main schema creation and load script
Rem
Rem    DESCRIPTION
Rem      PM is the Product Media schema of the Oracle 9i Sample
Rem        Schemas
Rem
Rem    NOTES
Rem     1) use absolute pathnames as parameters 6.
Rem        UNIX: echo $ORACLE_HOME/demo/schema/product_media     
Rem     2) there are hard-coded file names in the
Rem        data file pm_p_lob.dat. Should you want to create
Rem        and populate the PM Sample Schema from a location
Rem        other than the one chosen during installation, you
Rem        will have to edit this data file.
Rem     3) Run this as SYS or SYSTEM
Rem
Rem    MODIFIED   (MM/DD/YY)
Rem     hyeh       11/19/02 - standardize path of pm scripts
Rem     hyeh       08/29/02 - hyeh_mv_comschema_to_rdbms
Rem     ahunold    04/30/02 - Reduced DIRECTORY privileges
Rem     ahunold    08/28/01 - roles
Rem     ahunold    07/13/01 - NLS Territory
Rem     ahunold    04/23/01 - typo
Rem     ahunold    04/13/01 - concatenation, no @@
Rem     ahunold    04/10/01 - added parameters 7 and 8
Rem     ahunold    03/29/01 - notes, spool
Rem     ahunold    03/20/01 - no ALTER USER
Rem     ahunold    03/12/01 - prompts & directory
Rem     ahunold    03/07/01 - pm_analz.sql.
Rem     ahunold    02/20/01 - removing pm_p_ini and pm_code
Rem     ahunold    02/09/01 - password passing for pm_p_lob
Rem     ahunold    02/05/01 - Created
Rem  

SET ECHO OFF

PROMPT 
PROMPT specify password for PM as parameter 1:
DEFINE pass     = &1
PROMPT 
PROMPT specify default tablespeace for PM as parameter 2:
DEFINE tbs      = &2
PROMPT 
PROMPT specify temporary tablespace for PM as parameter 3:
DEFINE ttbs     = &3
PROMPT 
PROMPT specify password for OE as parameter 4:
DEFINE passoe   = &4
PROMPT 
PROMPT specify password for SYS as parameter 5:
DEFINE pass_sys = &5
PROMPT
PROMPT specify directory path for the PM data files as parameter 6:
DEFINE data_path = &6
PROMPT
PROMPT specify directory path for the PM load log files as parameter 7:
DEFINE log_path = &7
PROMPT
PROMPT specify work directory path as parameter 8:
DEFINE work_path = &8
PROMPT

-- The first dot in the spool command below is 
-- the SQL*Plus concatenation character

DEFINE spool_file = &log_path.pm_main.log
SPOOL &spool_file

-- Dropping the user with all its objects

DROP USER pm CASCADE;

CREATE USER pm IDENTIFIED BY &pass;
ALTER USER pm DEFAULT TABLESPACE &tbs QUOTA UNLIMITED ON &tbs; 
ALTER USER pm TEMPORARY TABLESPACE &ttbs;

GRANT CONNECT TO pm;
GRANT RESOURCE TO pm;

REM =======================================================
REM grants from oe schema
REM =======================================================

CONNECT oe/&passoe

GRANT REFERENCES, SELECT ON product_information TO pm;
GRANT SELECT ON order_items TO pm;
GRANT SELECT ON orders TO pm;
GRANT SELECT ON product_descriptions TO pm;
GRANT SELECT ON inventories TO pm;
GRANT SELECT ON customers TO pm;
GRANT SELECT ON warehouses TO pm;


REM =======================================================
REM grants from sys schema
REM =======================================================

CONNECT sys/&pass_sys AS SYSDBA;

GRANT execute ON sys.dbms_stats TO pm;

CREATE OR REPLACE DIRECTORY media_dir AS '&data_path';

GRANT READ ON DIRECTORY media_dir TO pm;

REM =======================================================
REM create pm schema (product media)
REM =======================================================

CONNECT pm/&pass

ALTER SESSION SET NLS_LANGUAGE=American;
ALTER SESSION SET NLS_TERRITORY=America;

@?/demo/schema/product_media/pm_cre.sql   -- create objects
@?/demo/schema/product_media/pm_p_ord.sql -- load ORDSYS types

REM =======================================================
REM use sqlldr to populate PRINT_MEDIA and its nested table
REM =======================================================
 
@?/demo/schema/product_media/pm_p_lob &pass &data_path &log_path &work_path

REM =======================================================
REM finish
REM =======================================================

@?/demo/schema/product_media/pm_analz -- gather statistics 

spool off

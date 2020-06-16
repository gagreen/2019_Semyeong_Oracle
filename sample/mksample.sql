Rem
Rem $Header: mksample.sql.sbs 05-mar-2007.11:19:17 cbauwens Exp $
Rem
Rem mksample.sql
Rem
Rem Copyright (c) 2001, 2007, Oracle. All rights reserved.  
Rem
Rem    NAME
Rem      mksample.sql - creates all 5 Sample Schemas
Rem
Rem    DESCRIPTION
Rem      This script rees and creates all Schemas belonging
Rem      to the Oracle10i Sample Schemas.
Rem      If you are unsure about the prerequisites for the Sample Schemas,
Rem      please use the Database Configuration Assistant DBCA to
Rem      configure the Sample Schemas.
Rem
Rem    NOTES
Rem      - OUI instantiates this script during install and saves it
Rem        as mksample.sql. The instantiated scripts matches
Rem        the directory structure on your system
Rem      - Tablespace EXAMPLE created with:
Rem		CREATE TABLESPACE example 
Rem		    NOLOGGING 
Rem		    DATAFILE '<filename>' SIZE 150M REUSE 
Rem		    AUTOEXTEND ON NEXT 640k
Rem                 MAXSIZE UNLIMITED
Rem		    EXTENT MANAGEMENT LOCAL
Rem                 SEGMENT SPACE MANAGEMENT AUTO;
Rem                 
Rem      - CAUTION: This script will erase the following schemas:
Rem        - HR
Rem        - OE
Rem        - PM
Rem        - SH
Rem        - IX
Rem	   - BI
Rem      - CAUTION: Never use the above mentioned Sample Schemas for
Rem        anything other than demos and examples
Rem      - USAGE: To return the Sample Schemas to their initial 
Rem        state, you can call this script and pass the passwords
Rem        for SYS, SYSTEM and the schemas as parameters.
Rem        Example: @?/demo/schema/mksample mgr secure h1 o2 p3 q4 s5
Rem        (please choose your own passwords for security purposes)
Rem
Rem    MODIFIED   (MM/DD/YY)
Rem      cbauwens  03/05/07 - remove exit statement
Rem      ahunold   04/02/03 - bug-2884943
Rem      ahunold   02/20/03 - notes changes
Rem      ahunold   01/14/03 - no compression on TS level
Rem      ahunold   11/05/02 - parameters 9,10 and 11
Rem      ahunold   10/25/02 - SHOWMODE OFF
Rem      ahunold   09/25/02 - creating mkverify.sql
Rem      hyeh      08/29/02 - hyeh_mv_comschema_to_rdbms
Rem      ahunold   08/15/02 - versioning, new oe_main parameters, ix
Rem      ahunold   12/05/01 - added parameters
Rem      ahunold   05/03/01 - dupl lines
Rem      ahunold   04/23/01 - Verification, parameters for pm_main.
Rem      ahunold   04/13/01 - aaditional parameter (HR,OE,QS)
Rem      ahunold   04/04/01 - Installer variables
Rem      ahunold   04/03/01 - Merged ahunold_mkdir_log
Rem      ahunold   03/28/01 - Created
Rem

SET FEEDBACK 1
SET NUMWIDTH 10
SET LINESIZE 80
SET TRIMSPOOL ON
SET TAB OFF
SET PAGESIZE 999
SET ECHO OFF
SET CONCAT '.'
SET SHOWMODE OFF

PROMPT 
PROMPT specify password for SYSTEM as parameter 1:
DEFINE password_system     = &1
PROMPT 
PROMPT specify password for SYS as parameter 2:
DEFINE password_sys        = &2
PROMPT 
PROMPT specify password for HR as parameter 3:
DEFINE password_hr         = &3
PROMPT
PROMPT specify password for OE as parameter 4:
DEFINE password_oe         = &4
PROMPT
PROMPT specify password for PM as parameter 5:
DEFINE password_pm         = &5
PROMPT
PROMPT specify password for IX as parameter 6:
DEFINE password_ix         = &6
PROMPT
PROMPT specify password for  SH as parameter 7:
DEFINE password_sh         = &7
PROMPT 
PROMPT specify password for  BI as parameter 8:
DEFINE password_bi         = &8
PROMPT 
PROMPT specify default tablespace as parameter 9:
DEFINE default_ts          = &9
PROMPT
PROMPT specify temporary tablespace as parameter 10:
DEFINE temp_ts             = &10
PROMPT 
PROMPT specify log file directory (including trailing delimiter) as parameter 11:
DEFINE logfile_dir         = &11
PROMPT 
PROMPT Sample Schemas are being created ...
PROMPT
DEFINE vrs = v3

CONNECT system/&&password_system

DROP USER hr CASCADE;
DROP USER oe CASCADE;
DROP USER pm CASCADE;
DROP USER ix CASCADE;
DROP USER sh CASCADE;
DROP USER bi CASCADE;

CONNECT system/&&password_system

SET SHOWMODE OFF

@?/demo/schema/human_resources/hr_main.sql &&password_hr &&default_ts &&temp_ts &&password_sys &&logfile_dir

CONNECT system/&&password_system
SET SHOWMODE OFF

@?/demo/schema/order_entry/oe_main.sql &&password_oe &&default_ts &&temp_ts &&password_hr &&password_sys C:\oracle\product\11.1.0\db_2\demo\schema\order_entry\ &&logfile_dir &vrs

CONNECT system/&&password_system
SET SHOWMODE OFF

@?/demo/schema/product_media/pm_main.sql &&password_pm &&default_ts &&temp_ts &&password_oe &&password_sys C:\oracle\product\11.1.0\db_2\demo\schema\product_media\ &&logfile_dir C:\oracle\product\11.1.0\db_2\demo\schema\product_media\

CONNECT system/&&password_system
SET SHOWMODE OFF

@?/demo/schema/info_exchange/ix_main.sql &&password_ix &&default_ts &&temp_ts &&password_sys &&logfile_dir &vrs

CONNECT system/&&password_system
SET SHOWMODE OFF

@?/demo/schema/sales_history/sh_main &&password_sh &&default_ts &&temp_ts &&password_sys C:\oracle\product\11.1.0\db_2\demo\schema\sales_history\ &&logfile_dir &vrs

CONNECT system/&&password_system
SET SHOWMODE OFF

@?/demo/schema/bus_intelligence/bi_main &&password_bi &&default_ts &&temp_ts &&password_sys &&password_oe &&password_sh &&logfile_dir &vrs

CONNECT system/&&password_system

SPOOL OFF

DEFINE veri_spool = &&logfile_dir.mkverify_&vrs..log

@?/demo/schema/mkverify &&password_system &veri_spool 


Rem
Rem $Header: pm_drop.sql 29-aug-2002.11:48:14 hyeh Exp $
Rem
Rem sh_drop.sql
Rem
Rem Copyright (c) 2001, 2002, Oracle Corporation.  All rights reserved.  
Rem
Rem    NAME
Rem      sh_drop.sql - Drop database objects
Rem
Rem    DESCRIPTION
Rem      SH is the Sales History schema of the Oracle 9i Sample
Rem        Schemas
Rem
Rem    NOTES
Rem      
Rem
Rem    MODIFIED   (MM/DD/YY)
Rem     hyeh       08/29/02 - hyeh_mv_comschema_to_rdbms
Rem     ahunold    05/29/02 - directory objects owned by sys
Rem     ahunold    04/09/02 - drop directory
Rem     ahunold    02/01/02 - bug 2205497
Rem     ahunold    09/14/00 - Created
Rem

REM drop all tables of schema

DROP TABLE online_media  CASCADE CONSTRAINTS;
DROP TABLE print_media   CASCADE CONSTRAINTS;

DROP TYPE textdoc_tab;

DROP TYPE adheader_typ;
DROP TYPE textdoc_typ;

COMMIT; 

Rem
Rem $Header: long2lob.sql 13-dec-2002.09:41:18 ahunold Exp $
Rem
Rem long2lob.sql
Rem
Rem Copyright (c) 2002, Oracle Corporation.  All rights reserved.  
Rem
Rem    NAME
Rem      long2lob.sql - <one-line expansion of the name>
Rem
Rem    DESCRIPTION
Rem      <short description of component this file declares/defines>
Rem
Rem    NOTES
Rem      <other useful comments, qualifications, etc.>
Rem
Rem    MODIFIED   (MM/DD/YY)
Rem    ahunold     12/13/02 - ahunold_long2lob
Rem    ahunold     12/12/02 - Created
Rem

SET ECHO ON
SET FEEDBACK 1
SET NUMWIDTH 10
SET LINESIZE 80
SET TRIMSPOOL ON
SET TAB OFF
SET PAGESIZE 100

SPOOL long2lob.log

DEFINE pm_pass     = &1

DEFINE ctl_file = $ORACLE_HOME/demo/schema/product_media/long2lob.ctl
DEFINE dat_file = $ORACLE_HOME/demo/schema/product_media/long2lob.dat
DEFINE log_file = $ORACLE_HOME/demo/schema/log/longload.log

CONNECT pm/&pm_pass;

DROP TABLE long2lob;

CREATE TABLE long2lob
    ( product_id        NUMBER(6)
    , press_release     LONG
    );

CREATE UNIQUE INDEX long2lob_pk
    ON long2lob (product_id);

HOST sqlldr pm/&pm_pass -
  control=&ctl_file data=&dat_file log=&log_file

DESCRIBE long2lob
SELECT * FROM long2lob;

ALTER TABLE long2lob MODIFY ( press_release CLOB );

DESCRIBE long2lob
SELECT * FROM long2lob; 

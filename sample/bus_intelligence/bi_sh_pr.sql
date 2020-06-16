Rem $Header: bi_sh_pr.sql 18-sep-2002.10:15:02 ahunold Exp $
Rem
Rem Copyright (c) 2002, Oracle Corporation.  All rights reserved.  
Rem
Rem    NAME
Rem      bi_views.sql - Object privileges for user BI
Rem
Rem    DESCRIPTION
Rem      tbd
Rem
Rem    MODIFIED     (MM/DD/YY)
Rem      ahunold     09/18/02 - ahunold_sep17_02
Rem      ahunold     09/17/02 - created
Rem

SET FEEDBACK 1
SET NUMWIDTH 10
SET LINESIZE 80
SET TRIMSPOOL ON
SET TAB OFF
SET PAGESIZE 100

PROMPT
PROMPT specify password for SH as parameter 1:
DEFINE sh_pass             = &1
PROMPT

CONNECT sh/&sh_pass;

GRANT SELECT ON channels		TO bi;
GRANT SELECT ON countries		TO bi;
GRANT SELECT ON times			TO bi;
GRANT SELECT ON costs			TO bi;
GRANT SELECT ON customers		TO bi;
GRANT SELECT ON products		TO bi;
GRANT SELECT ON promotions		TO bi;
GRANT SELECT ON sales			TO bi;
GRANT SELECT ON times			TO bi;
GRANT SELECT ON cal_month_sales_mv	TO bi;
GRANT SELECT ON sh.fweek_pscat_sales_mv	TO bi;

COMMIT;

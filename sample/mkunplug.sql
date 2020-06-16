Rem
Rem $Header: mkunplug.sql 02-may-2005.16:34:32 cbauwens Exp $
Rem
Rem mkunplug.sql
Rem
Rem Copyright (c) 2001, 2005, Oracle. All rights reserved.  
Rem
Rem    NAME
Rem      mkunplug.sql - Unplug transportable tablespace EXAMPLE
Rem
Rem    DESCRIPTION
Rem      Once the Sample Schemas are initially created using mksample.sql,
Rem      this script creates a set of tranportable files containing
Rem      metadata and data from the EXAMPLE tablespace.
Rem
Rem    NOTES
Rem      The EXAMPLE tablespace only contains the Sample Schemas
Rem      - CAUTION: Never use the Sample Schemas for
Rem        anything other than demos and examples
Rem      - USAGE: tbd
Rem      - LOG FILES: The log files are written
Rem        to the equivalent of $ORACLE_HOME/demo/schema/log
Rem        If you edit the log file location further down in this
Rem        script, use absolute pathnames
Rem
Rem    MODIFIED   (MM/DD/YY)
Rem      cbauwens  05/02/05 - bug4054905 Date & Time format 
Rem      cbauwens  08/01/03 - rman compress
Rem      cbauwens  07/31/03 - rman compress
Rem      cbauwens  07/24/03 - rman compress
Rem      ahunold   03/28/03 - oc_drop.sql
Rem      ahunold   04/02/03 - bug-2884943
Rem      ahunold   02/27/03 - bug 2824141 (workaround)
Rem      ahunold   03/01/03 - Bug 2828348
Rem      ahunold   01/27/03 - RMAN backup finalized
Rem      ahunold   01/14/03 - Invalid View workaround, comments
Rem      ahunold   09/25/02 - exp logfile 
Rem      ahunold   09/18/02 - Created
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
PROMPT specify password for SYS as parameter 1:
DEFINE password_sys        = &1
PROMPT 
PROMPT specify OUTPUT export file name, including path, as parameter 2:
DEFINE exp_file            = &2
PROMPT
PROMPT specify OUTPUT tablespace backup file name, including path, as parameter 3:
DEFINE backup_file         = &3
PROMPT 
PROMPT specify LOG directory, open for write, as parameter 4:
DEFINE log_path            = &4
PROMPT 
DEFINE vrs = v3

SPOOL &log_path.mkunplug_&vrs._@.log 

CONNECT sys/&&password_sys AS SYSDBA;

--
-- Eliminate violations of TTS restrictions
-- (The MV will be recreated in mkplug.sql. The 
-- data is transported in prebuilt tables - 
-- we are not really deleting data here)
--

DROP MATERIALIZED VIEW sh.cal_month_sales_mv;

DROP MATERIALIZED VIEW sh.fweek_pscat_sales_mv;

--
-- Procedures are not part of the TTS set, triggers are
--

DROP TRIGGER hr.secure_employees;
DROP TRIGGER hr.update_job_history;

--
-- temporary fix
--

ALTER USER oe identified by eo;

CONNECT oe/eo;

@?/demo/schema/order_entry/doe_xml.sql

SET ECHO OFF

@?/demo/schema/order_entry/oc_drop.sql

SELECT table_name FROM user_tables ORDER BY 1;

CONNECT sys/&&password_sys AS SYSDBA;

-
-- Check for violations of TTS prerequisites
--

EXECUTE dbms_tts.transport_set_check('EXAMPLE',TRUE);

SELECT * FROM TRANSPORT_SET_VIOLATIONS;

--
-- Begin unplugging
--

ALTER TABLESPACE example READ ONLY;

DEFINE exp_logfile = &log_path.tts_example_exp.log

host exp "'sys/&&password_sys AS SYSDBA'" file=&exp_file log=&exp_logfile tablespaces=EXAMPLE transport_tablespace=TRUE grants=Y

SET PAGESIZE 0

SELECT 'Backing up tablespace file '||file_name
 FROM  dba_data_files
 WHERE tablespace_name='EXAMPLE';

set serveroutput on;

SELECT TO_CHAR(systimestamp, 'YYYYMMDD HH:MI:SS')  FROM dual;

variable devicename varchar2(255);
variable set_stamp number;
variable devicename varchar2(255);
variable set_stamp number;
variable set_count number;
variable data_file_id number;

declare
    done boolean;
    concur boolean;
    pieceno binary_integer;
    handle varchar2(255);
    comment varchar2(255);
    media varchar2(255);
    params varchar2(255);
    archlog_failover boolean;
    recid number;
    stamp number;
    tag varchar2(32);
    
    
begin
    dbms_output.put_line(' ');
    dbms_output.put_line(' BACKUP: Allocating device... ');
      :devicename := dbms_backup_restore.deviceAllocate;
    dbms_output.put_line(' BACKUP: Specifing datafiles... ');
    dbms_backup_restore.backupSetDataFile(:set_stamp, :set_count);
    SELECT file_id INTO :data_file_id FROM dba_data_files WHERE tablespace_name='EXAMPLE';
    dbms_backup_restore.backupDataFile(:data_file_id);
    dbms_output.put_line(' BACKUP: Create piece ');
    dbms_backup_restore.backupPieceCreate('&backup_file',pieceno,done,handle,comment,media,concur,params,reuse=>true,archlog_failover=>archlog_failover,deffmt=>0,recid=>recid,stamp=>stamp,tag=>tag,docompress=>true);
    IF done then
        dbms_output.put_line(' BACKUP: Unplugged example tablespace backed up.');
    else
        dbms_output.put_line(' BACKUP: Backup of example tablespace failed');
    end if;
  end;
/

SELECT TO_CHAR(systimestamp, 'YYYYMMDD HH:MI:SS')  FROM dual;

PROMPT
PROMPT Ready to transport export file &exp_file
PROMPT Ready to transport tablespace backup file &backup_file
PROMPT
PROMPT Please copy both, the tablespace backup and export file, to the target database location 

EXIT


Rem
Rem $Header: dix_v3.sql 29-aug-2002.11:44:20 hyeh Exp $
Rem
Rem dix_v3.sql
Rem
Rem Copyright (c) 2002, Oracle Corporation.  All rights reserved.  
Rem
Rem    NAME
Rem      dix_v3.sql - Drop IX objects
Rem
Rem    DESCRIPTION
Rem      .
Rem
Rem    NOTES
Rem      Assumes connection as user IX
Rem
Rem    MODIFIED   (MM/DD/YY)
Rem    hyeh        08/29/02 - hyeh_mv_comschema_to_rdbms
Rem    ahunold     07/31/02 - Created
Rem

REM =======================================================
REM cleanup section - Remove subscribers
REM =======================================================

execute dbms_aqadm.remove_subscriber ( -
	  queue_name => 'orders_queue', -
	  subscriber => sys.aq$_agent('SHIPPING',null,null)-
);

execute dbms_aqadm.remove_subscriber ( -
	  queue_name => 'orders_queue', -
	  subscriber => sys.aq$_agent('BILLING',null,null)-
);

execute dbms_aqadm.remove_subscriber ( -
	  queue_name => 'orders_queue', -
	  subscriber => sys.aq$_agent('RUSH_ORDER',null,null)-
);


REM =======================================================
REM cleanup section - drop queues
REM =======================================================
BEGIN
  dbms_aqadm.stop_queue(queue_name => 'orders_queue');
  dbms_aqadm.drop_queue (
        queue_name              => 'orders_queue');
  dbms_aqadm.drop_queue_table (
        queue_table => 'orders_queuetable');
END;
/

REM =======================================================
REM cleanup section - delete message type
REM =======================================================

DROP TYPE order_message_typ;

COMMIT;


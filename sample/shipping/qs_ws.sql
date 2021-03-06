Rem
Rem $Header: qs_ws.sql 29-aug-2002.11:59:53 hyeh Exp $
Rem
Rem qs_ws.sql
Rem
Rem Copyright (c) 2001, 2002, Oracle Corporation.  All rights reserved.  
Rem
Rem    NAME
Rem      qs_ws.sql - Creates Western Shipping schema
Rem
Rem    DESCRIPTION
Rem      The QS_WS schema belongs to the Queued Shipping
Rem      (QS) schema group of the Oracle9i Sample Schemas
Rem
Rem    NOTES
Rem
Rem    MODIFIED   (MM/DD/YY)
Rem    hyeh        08/29/02 - hyeh_mv_comschema_to_rdbms
Rem    ahunold     02/26/01 - Merged ahunold_qs_filenames
Rem    ahunold     02/26/01 - Created from qs_ws_cre.sql 
Rem

REM =======================================================
REM Create a priority queue table for QS_WS shipping
REM =======================================================
BEGIN
  dbms_aqadm.create_queue_table(
        queue_table => 'QS_WS_orders_pr_mqtab',
        sort_list =>'priority,enq_time',
        comment => 'West Shipping Priority MultiConsumer Orders queue table',
        multiple_consumers => TRUE,
        queue_payload_type => 'QS_ADM.order_typ',
        compatible => '8.1');
END;
/

REM =======================================================
REM Create a FIFO queue tables for QS_WS shipping
REM =======================================================
BEGIN
  dbms_aqadm.create_queue_table(
        queue_table => 'QS_WS_orders_mqtab',
        comment => 'West Shipping Multi Consumer Orders queue table',
        multiple_consumers => TRUE,
        queue_payload_type => 'QS_ADM.order_typ',
        compatible => '8.1');
END;
/

REM =======================================================
REM Booked orders are stored in the priority queue table
REM =======================================================
BEGIN
  dbms_aqadm.create_queue (
        queue_name              => 'QS_WS_bookedorders_que',
        queue_table             => 'QS_WS_orders_pr_mqtab');
END;
/

REM =======================================================
REM Shipped orders and back orders are stored in the FIFO 
REM queue table
REM =======================================================
BEGIN
  dbms_aqadm.create_queue (
        queue_name              => 'QS_WS_shippedorders_que',
        queue_table             => 'QS_WS_orders_mqtab');
END;
/

BEGIN
dbms_aqadm.create_queue (
        queue_name              => 'QS_WS_backorders_que',
        queue_table             => 'QS_WS_orders_mqtab');
END;
/

REM =======================================================
REM In order to test history, set retention to 1 DAY for
REM the queues in QS_WS
REM =======================================================

BEGIN
  dbms_aqadm.alter_queue(
         queue_name => 'QS_WS_bookedorders_que',
         retention_time => 86400);
END;
/

BEGIN
  dbms_aqadm.alter_queue(
         queue_name => 'QS_WS_shippedorders_que',
         retention_time => 86400);
END;
/

BEGIN
  dbms_aqadm.alter_queue(
         queue_name => 'QS_WS_backorders_que',
         retention_time => 86400);
END;
/

REM =======================================================
REM Create the queue subscribers
REM =======================================================
DECLARE
  subscriber     sys.aq$_agent;
BEGIN
  /* Subscribe to the QS_WS back orders queue */
  subscriber := sys.aq$_agent(
         'BACK_ORDER',
         'QS_CS.QS_CS_backorders_que',
         null);
  dbms_aqadm.add_subscriber(
         queue_name => 'QS_WS.QS_WS_backorders_que',
         subscriber => subscriber);
END;
/

DECLARE
  subscriber     sys.aq$_agent;
BEGIN
  /* Subscribe to the QS_WS shipped orders queue */
  subscriber := sys.aq$_agent(
         'SHIPPED_ORDER',
         'QS_CS.QS_CS_shippedorders_que',
         null);
  dbms_aqadm.add_subscriber(
         queue_name => 'QS_WS.QS_WS_shippedorders_que',
         subscriber => subscriber);
END;
/

COMMIT;


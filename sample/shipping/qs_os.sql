Rem
Rem $Header: qs_os.sql 29-aug-2002.11:59:50 hyeh Exp $
Rem
Rem qs_os.sql
Rem
Rem Copyright (c) 2001, 2002, Oracle Corporation.  All rights reserved.  
Rem
Rem    NAME
Rem      qs_os.sql - Creates Overseas Shipping schema
Rem
Rem    DESCRIPTION
Rem      The QS_OS schema belongs to the Queued Shipping
Rem      (QS) schema group of the Oracle9i Sample Schemas
Rem
Rem    NOTES
Rem
Rem    MODIFIED   (MM/DD/YY)
Rem    hyeh        08/29/02 - hyeh_mv_comschema_to_rdbms
Rem    ahunold     02/26/01 - Merged ahunold_qs_filenames
Rem    ahunold     02/26/01 - Created from qs_os_cre.sql
Rem

REM =======================================================
REM Create a priority queue table for QS_OS shipping
REM =======================================================
BEGIN
  dbms_aqadm.create_queue_table(
        queue_table => 'QS_OS_orders_pr_mqtab',
        sort_list =>'priority,enq_time',
        comment => 
          'Overseas Shipping Priority MultiConsumer Orders queue table',
        multiple_consumers => TRUE,
        queue_payload_type => 'QS_ADM.order_typ',
        compatible => '8.1');
END;
/

REM =======================================================
REM Create a FIFO queue tables for QS_OS shipping
REM =======================================================
BEGIN
  dbms_aqadm.create_queue_table(
        queue_table => 'QS_OS_orders_mqtab',
        comment =>
          'Overseas Shipping Multi Consumer Orders queue table',
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
        queue_name              => 'QS_OS_bookedorders_que',
        queue_table             => 'QS_OS_orders_pr_mqtab');
END;
/

REM =======================================================
REM Shipped orders and back orders are stored in the FIFO queue table
REM =======================================================
BEGIN
  dbms_aqadm.create_queue (
        queue_name              => 'QS_OS_shippedorders_que',
        queue_table             => 'QS_OS_orders_mqtab');
END;
/

BEGIN
  dbms_aqadm.create_queue (
        queue_name              => 'QS_OS_backorders_que',
        queue_table             => 'QS_OS_orders_mqtab');
END;
/

COMMIT;


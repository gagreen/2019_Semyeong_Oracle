Rem
Rem $Header: qs_cre.sql 29-aug-2002.11:59:44 hyeh Exp $
Rem
Rem qs_cre.sql
Rem
Rem Copyright (c) 2001, 2002, Oracle Corporation.  All rights reserved.  
Rem
Rem    NAME
Rem      qs_cre.sql - Schema creation
Rem
Rem    DESCRIPTION
Rem      QS is the Queued Shipping schema of the Oracle 9i Sample
Rem        Schemas
Rem
Rem    NOTES
Rem
Rem
Rem    MODIFIED   (MM/DD/YY)
Rem    hyeh        08/29/02 - hyeh_mv_comschema_to_rdbms
Rem    ahunold     02/05/01 - Created
Rem

REM =======================================================
REM Create queue tables, queues for QS
REM =======================================================
BEGIN
  dbms_aqadm.create_queue_table(
        queue_table => 'QS_orders_sqtab',
        comment => 'Order Entry Single Consumer Orders queue table',
        queue_payload_type => 'QS_ADM.order_typ',
        message_grouping => DBMS_AQADM.TRANSACTIONAL,
        compatible => '8.1',
        primary_instance => 1,
        secondary_instance => 2);
END;
/

REM =======================================================
REM Create a priority queue table for QS
REM =======================================================
BEGIN
dbms_aqadm.create_queue_table(
        queue_table => 'QS_orders_pr_mqtab',
        sort_list =>'priority,enq_time',
        comment => 'Order Entry Priority MultiConsumer Orders queue table',
        multiple_consumers => TRUE,
        queue_payload_type => 'QS_ADM.order_typ',
        compatible => '8.1',
        primary_instance => 2,
        secondary_instance => 1);
END;
/
REM =======================================================
REM Create a queue for New Orders for QS
REM =======================================================
BEGIN
dbms_aqadm.create_queue (
        queue_name              => 'QS_neworders_que',
        queue_table             => 'QS_orders_sqtab');
END;
/

REM =======================================================
REM Create a queue for booked orders for QS
REM =======================================================
BEGIN
dbms_aqadm.create_queue (
        queue_name              => 'QS_bookedorders_que',
        queue_table             => 'QS_orders_pr_mqtab');
END;
/

REM =======================================================
REM   Create the multiconsumer nonpersistent queue in QS schema
REM   This queue is used by the conenction dispatcher to count
REM   the number of user connections to the QS application
REM =======================================================
BEGIN
dbms_aqadm.create_np_queue(queue_name => 'LOGON_LOGOFF', multiple_consumers => TRUE);
END;
/


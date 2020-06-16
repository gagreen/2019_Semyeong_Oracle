Rem
Rem $Header: qs_drop.sql 29-aug-2002.11:59:46 hyeh Exp $
Rem
Rem qs_drop.sql
Rem
Rem Copyright (c) 2001, 2002, Oracle Corporation.  All rights reserved.  
Rem
Rem    NAME
Rem      qs_drop.sql - Cleanup and drop all QS related schemas
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

set echo on;
set serveroutput on;

CONNECT QS_ADM/&password_QS_ADM
execute dbms_aqadm.stop_queue(queue_name => 'QS.QS_neworders_que');
execute dbms_aqadm.stop_queue(queue_name => 'QS.QS_bookedorders_que');
execute dbms_aqadm.stop_queue(queue_name => 'QS.logon_logoff');
execute dbms_aqadm.stop_queue(queue_name => 'QS_WS.QS_WS_bookedorders_que');
execute dbms_aqadm.stop_queue(queue_name => 'QS_WS.QS_WS_shippedorders_que');
execute dbms_aqadm.stop_queue(queue_name => 'QS_WS.QS_WS_backorders_que');
execute dbms_aqadm.stop_queue(queue_name => 'QS_ES.QS_ES_bookedorders_que');
execute dbms_aqadm.stop_queue(queue_name => 'QS_ES.QS_ES_shippedorders_que');
execute dbms_aqadm.stop_queue(queue_name => 'QS_ES.QS_ES_backorders_que');
execute dbms_aqadm.stop_queue(queue_name => 'QS_OS.QS_OS_bookedorders_que');
execute dbms_aqadm.stop_queue(queue_name => 'QS_OS.QS_OS_shippedorders_que');
execute dbms_aqadm.stop_queue(queue_name => 'QS_OS.QS_OS_backorders_que');
execute dbms_aqadm.stop_queue(queue_name => 'QS_CS.QS_CS_bookedorders_que');
execute dbms_aqadm.stop_queue(queue_name => 'QS_CS.QS_CS_backorders_que');
execute dbms_aqadm.stop_queue(queue_name => 'QS_CS.QS_CS_shippedorders_que');
execute dbms_aqadm.stop_queue(queue_name => 'QS_CS.QS_CS_billedorders_que');

Rem Drop queue tables, queues for QS
Rem
CONNECT QS/&password_QS
begin
dbms_aqadm.drop_queue (
        queue_name              => 'QS_neworders_que');
end;
/

begin
dbms_aqadm.drop_queue (
        queue_name              => 'QS_bookedorders_que');
end;
/

begin
dbms_aqadm.drop_queue_table(
        queue_table => 'QS_orders_sqtab');
end;
/

Rem Create a priority queue table for QS
begin
dbms_aqadm.drop_queue_table(
        queue_table => 'QS_orders_pr_mqtab');
end;
/

CONNECT QS/&password_QS

Rem
Rem   Drop the multiconsumer nonpersistent queue in QS schema
Rem   This queue is used by the conenction dispatcher to count
Rem   the number of user connections to the QS application

execute dbms_aqadm.drop_queue(queue_name => 'LOGON_LOGOFF');

Rem Drop queue tables, queues for QS_WS Shipping
CONNECT QS_WS/&password_QS_WS

Rem Booked orders are stored in the priority queue table
begin
dbms_aqadm.drop_queue (
        queue_name              => 'QS_WS_bookedorders_que');
end;
/

Rem Shipped orders and back orders are stored in the FIFO queue table
begin
dbms_aqadm.drop_queue (
        queue_name              => 'QS_WS_shippedorders_que');
end;
/

begin
dbms_aqadm.drop_queue (
        queue_name              => 'QS_WS_backorders_que');
end;
/

Rem Drop queue table for QS_WS shipping
begin
dbms_aqadm.drop_queue_table(
        queue_table => 'QS_WS_orders_pr_mqtab');
end;
/

Rem Drop queue tables for QS_WS shipping
begin
dbms_aqadm.drop_queue_table(
        queue_table => 'QS_WS_orders_mqtab');
end;
/

Rem Drop queue tables, queues for QS_ES Shipping
CONNECT QS_ES/&password_QS_ES

Rem Booked orders are stored in the priority queue table
begin
dbms_aqadm.drop_queue (
        queue_name              => 'QS_ES_bookedorders_que');
end;
/

Rem Shipped orders and back orders are stored in the FIFO queue table
begin
dbms_aqadm.drop_queue (
        queue_name              => 'QS_ES_shippedorders_que');
end;
/

begin
dbms_aqadm.drop_queue (
        queue_name              => 'QS_ES_backorders_que');
end;
/

Rem Drop queue table for QS_ES shipping
begin
dbms_aqadm.drop_queue_table(
        queue_table => 'QS_ES_orders_mqtab');
end;
/

Rem Drop FIFO queue tables for QS_ES shipping
begin
dbms_aqadm.drop_queue_table(
        queue_table => 'QS_ES_orders_pr_mqtab');
end;
/


Rem Drop queue tables, queues for Overseas Shipping
CONNECT QS_OS/&password_QS_OS


Rem Booked orders are stored in the priority queue table
begin
dbms_aqadm.drop_queue (
        queue_name              => 'QS_OS_bookedorders_que');
end;
/

Rem Shipped orders and back orders are stored in the FIFO queue table
begin
dbms_aqadm.drop_queue (
        queue_name              => 'QS_OS_shippedorders_que');
end;
/

begin
dbms_aqadm.drop_queue (
        queue_name              => 'QS_OS_backorders_que');
end;
/

Rem Create a priority queue table for QS_OS shipping
begin
dbms_aqadm.drop_queue_table(
        queue_table => 'QS_OS_orders_pr_mqtab');
end;
/

Rem Create a FIFO queue tables for QS_OS shipping
begin
dbms_aqadm.drop_queue_table(
        queue_table => 'QS_OS_orders_mqtab');
end;
/

Rem Create queue tables, queues for Customer Billing
CONNECT QS_CBADM/&password_QS_CBADM

begin
dbms_aqadm.drop_queue (
        queue_name              => 'QS_CBADM_shippedorders_q');

end;
/

begin
dbms_aqadm.drop_queue (
        queue_name              => 'QS_CBADM_billedorders_q');
end;
/

begin
dbms_aqadm.drop_queue_table(
        queue_table => 'QS_CBADM_orders_sqtab', force => true);

dbms_aqadm.drop_queue_table(
        queue_table => 'QS_CBADM_orders_mqtab', force => true);

end;
/

CONNECT QS_CS/&password_QS_CS

DROP TABLE Order_Status_Table;

Rem Drop queue tables, queues for Customer Service

begin
dbms_aqadm.drop_queue (
        queue_name              => 'QS_CS_bookedorders_que');

dbms_aqadm.drop_queue (
        queue_name              => 'QS_CS_backorders_que');

dbms_aqadm.drop_queue (
        queue_name              => 'QS_CS_shippedorders_que');

dbms_aqadm.drop_queue (
        queue_name              => 'QS_CS_billedorders_que');

end;
/

begin
dbms_aqadm.drop_queue_table(
        queue_table => 'QS_CS_order_status_qt', force => true);
end;
/

CONNECT QS_ADM/&password_QS_ADM

Rem drop objects types 

drop type order_typ;
drop type orderitemlist_vartyp;
drop type orderitem_typ;
drop type customer_typ;


Rem drop queue admin account and individual accounts for each application
Rem
CONNECT system/&password_SYSTEM
set serveroutput on;
set echo on;

drop user QS_ADM cascade;
drop user QS cascade;
drop user QS_WS cascade;
drop user QS_ES cascade;
drop user QS_OS cascade;
drop user QS_CBADM cascade;
drop user QS_CB cascade;
drop user QS_CS cascade;

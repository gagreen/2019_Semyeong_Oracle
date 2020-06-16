Rem
Rem $Header: qs_cs.sql 29-aug-2002.11:59:45 hyeh Exp $
Rem
Rem qs_cs.sql
Rem
Rem Copyright (c) 2001, 2002, Oracle Corporation.  All rights reserved.  
Rem
Rem    NAME
Rem      qs_cs.sql - Creates Customer Service Shipping schema
Rem
Rem    DESCRIPTION
Rem      The QS_CS schema belongs to the Queued Shipping
Rem      (QS) schema group of the Oracle9i Sample Schemas
Rem
Rem    NOTES
Rem     Customer support tracks the state of the customer request
Rem     in the system.
Rem     At any point, customer request can be in one of the following states
Rem     A. BOOKED  B. SHIPPED  C. BACKED   D. BILLED
Rem     Given the order number the customer support will return the state
Rem     the order is in. This state is maintained in the order_status_table
Rem
Rem    MODIFIED   (MM/DD/YY)
Rem    hyeh        08/29/02 - hyeh_mv_comschema_to_rdbms
Rem    ahunold     02/26/01 - Merged ahunold_qs_filenames
Rem    ahunold     02/26/01 - Created from qs_cs_cre.sql
Rem

CREATE TABLE Order_Status_Table(customer_order       qs_adm.order_typ,
                                status               varchar2(30));

Rem Create queue tables, queues for Customer Service

begin
dbms_aqadm.create_queue_table(
        queue_table => 'QS_CS_order_status_qt',
        comment => 'Customer Status multi consumer queue table',
        multiple_consumers => TRUE,
        queue_payload_type => 'QS_ADM.order_typ',
        compatible => '8.1');

dbms_aqadm.create_queue (
        queue_name              => 'QS_CS_bookedorders_que',
        queue_table             => 'QS_CS_order_status_qt');

dbms_aqadm.create_queue (
        queue_name              => 'QS_CS_backorders_que',
        queue_table             => 'QS_CS_order_status_qt');

dbms_aqadm.create_queue (
        queue_name              => 'QS_CS_shippedorders_que',
        queue_table             => 'QS_CS_order_status_qt');

dbms_aqadm.create_queue (
        queue_name              => 'QS_CS_billedorders_que',
        queue_table             => 'QS_CS_order_status_qt');

end;
/


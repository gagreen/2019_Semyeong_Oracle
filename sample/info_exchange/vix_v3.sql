Rem
Rem $Header: vix_v3.sql 08-jul-2004.11:06:36 huzhao Exp $
Rem
Rem vix_v3.sql
Rem
Rem Copyright (c) 2002, 2004, Oracle. All rights reserved.  
Rem
Rem    NAME
Rem      vix_v3.sql - IX Sample Schema verification script
Rem
Rem    DESCRIPTION
Rem      Add subscriber, enqueue, dequeue, query data dictionary
Rem
Rem    NOTES
Rem      assumes active connection as IX
Rem
Rem    MODIFIED   (MM/DD/YY)
Rem    huzhao      06/18/04 - add to_date to the date values 
Rem    rsahani     05/24/04 - fix/add order by clause
Rem    cbauwens    01/28/04 - NLS date 64 bit 
Rem    ahunold     10/25/02 - gather_schema_stats
Rem    hyeh        08/29/02 - hyeh_mv_comschema_to_rdbms
Rem    ahunold     07/31/02 - Created
Rem

SET PAGESIZE 999
SET LINESIZE 200

COLUMN object_name 	FORMAT A30
COLUMN object_type 	FORMAT A20
COLUMN queue            FORMAT A15
COLUMN msg_state        FORMAT A15
COLUMN consumer_name    FORMAT A15
COLUMN user_data        FORMAT A60

ALTER SESSION SET NLS_LANGUAGE=AMERICAN;
ALTER SESSION SET NLS_TERRITORY=AMERICA;

REM =======================================================
REM Add subscriber 'SHIPPING'and 'BILLING' to orders_queue
REM =======================================================

EXECUTE dbms_aqadm.add_subscriber ( -
	  queue_name => 'orders_queue', -
	  subscriber => sys.aq$_agent('SHIPPING',null,null)-
);


EXECUTE dbms_aqadm.add_subscriber ( -
	  queue_name => 'orders_queue', -
	  subscriber => sys.aq$_agent('BILLING',null,null)-
);


REM====================================================================
REM Enqueue with a recipient list
REM====================================================================

DECLARE
	enqopt	dbms_aq.enqueue_options_t;
	mprop		dbms_aq.message_properties_t;
	enq_msgid	RAW(16);
	rcpt_list 	dbms_aq.aq$_recipient_list_t;
BEGIN
	rcpt_list(0) := sys.aq$_agent('Billing', null, null);
	rcpt_list(1) := sys.aq$_agent('Shipping', null, null);
	mprop.recipient_list := rcpt_list;
	dbms_aq.enqueue(
		queue_name => 'orders_queue',
		enqueue_options => enqopt,
		message_properties => mprop,
		payload => order_event_typ(2458, 3117, 101, 'Constantin', 'Welles', 0, to_date('12-DEC-2002',
		'dd-mon-yyyy')),
		msgid => enq_msgid);
	COMMIT;
END;
/

SELECT	queue, msg_state, consumer_name,  
	order_event_typ(a.user_data.order_id, a.user_data.product_id, a.user_data.customer_id,
			a.user_data.cust_first_name, a.user_data.cust_last_name, a.user_data.order_status,
			to_date(a.user_data.delivery_date, 'dd-mon-yyyy')) user_data
 FROM		AQ$orders_queuetable a
 ORDER BY       consumer_name;

REM====================================================================
REM Blocking dequeue
REM====================================================================

DECLARE
	deqopt	dbms_aq.dequeue_options_t;
	mprop	dbms_aq.message_properties_t;
	msgid	RAW(16);
	payload order_event_typ;
BEGIN
	deqopt.consumer_name := 'SHIPPING';
	deqopt.navigation := DBMS_AQ.FIRST_MESSAGE;
	deqopt.wait := 60; -- wait for 60 seconds
	dbms_aq.dequeue(
		queue_name => 'orders_queue',
		dequeue_options => deqopt,
		message_properties => mprop,
		payload => payload,
		msgid => msgid);
	COMMIT;
END;
/

SELECT	queue, msg_state, consumer_name,  
	order_event_typ(a.user_data.order_id, a.user_data.product_id, a.user_data.customer_id,
			a.user_data.cust_first_name, a.user_data.cust_last_name, a.user_data.order_status,
			to_date(a.user_data.delivery_date, 'dd-mon-yyyy')) user_data
 FROM 	AQ$orders_queuetable a
 ORDER BY       consumer_name;

REM====================================================================
REM Non-blocking dequeue
REM====================================================================

DECLARE
	deqopt	dbms_aq.dequeue_options_t;
	mprop		dbms_aq.message_properties_t;
	msgid		RAW(16);
	payload 	order_event_typ;
BEGIN
	deqopt.consumer_name := 'BILLING';
	deqopt.navigation := DBMS_AQ.FIRST_MESSAGE;
	deqopt.wait := 0;	
	dbms_aq.dequeue(
		queue_name => 'orders_queue',
		dequeue_options => deqopt,
		message_properties => mprop,
		payload => payload,
		msgid => msgid);
	COMMIT;
END;
/

SELECT	queue, msg_state, consumer_name,  
	order_event_typ(a.user_data.order_id, a.user_data.product_id, a.user_data.customer_id,
			a.user_data.cust_first_name, a.user_data.cust_last_name, a.user_data.order_status,
			to_date(a.user_data.delivery_date, 'dd-mon-yyyy')) user_data
 FROM 	AQ$orders_queuetable a
  ORDER BY       consumer_name;

REM====================================================================
REM Data Dictionary
REM====================================================================

EXECUTE dbms_stats.gather_schema_stats( -
        'IX'                            ,       -
        granularity => 'ALL'            ,       -
        cascade => TRUE                 ,       -
        block_sample => TRUE            );

SELECT
	object_type, 
	object_name, 
	status
 FROM 
	user_objects
ORDER BY  
	1,2;

SELECT
	object_type, 
	status, 
	count(*)
FROM
	user_objects
GROUP BY
	object_type, status
ORDER BY
	object_type;


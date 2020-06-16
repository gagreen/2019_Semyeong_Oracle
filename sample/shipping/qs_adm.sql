Rem
Rem $Header: qs_adm.sql 29-aug-2002.11:59:41 hyeh Exp $
Rem
Rem qs_adm.sql
Rem
Rem Copyright (c) 2001, 2002, Oracle Corporation.  All rights reserved.  
Rem
Rem    NAME
Rem      qs_adm.sql - Administration schema for QS schema group
Rem
Rem    DESCRIPTION
Rem      All object types are created in the qs_adm schema. All
Rem      application schemas that host any propagation source
Rem      queues are given the ENQUEUE_ANY system level privilege
Rem      allowing the application schemas to enqueue to the
Rem      destination queue.
Rem
Rem    NOTES
Rem
Rem    MODIFIED   (MM/DD/YY)
Rem    hyeh        08/29/02 - hyeh_mv_comschema_to_rdbms
Rem    ahunold     02/26/01 - Merged ahunold_qs_filenames
Rem    ahunold     02/26/01 - Created
Rem

CREATE OR REPLACE TYPE customer_typ AS OBJECT (
        customer_id     NUMBER,
        name            VARCHAR2(100),
        street          VARCHAR2(100),
        city            VARCHAR2(30),
        state           VARCHAR2(2),
        zip             NUMBER,
        country         VARCHAR2(100));
/


CREATE OR REPLACE TYPE orderitem_typ AS OBJECT (
	line_item_id	NUMBER,
        quantity        NUMBER,
	unit_price	NUMBER,
	product_id	NUMBER,
        subtotal        NUMBER);
/

CREATE OR REPLACE TYPE orderitemlist_vartyp AS VARRAY (20) OF ORDERITEM_TYP;
/

CREATE OR REPLACE TYPE order_typ AS OBJECT (
        orderno         NUMBER,
        status          VARCHAR2(30),
        ordertype       VARCHAR2(30),
        orderregion     VARCHAR2(30),
        customer        customer_typ,
        paymentmethod   VARCHAR2(30),
        items           orderitemlist_vartyp,
        total           NUMBER);
/

GRANT EXECUTE ON order_typ to QS;
GRANT EXECUTE ON orderitemlist_vartyp to QS;
GRANT EXECUTE ON orderitem_typ to QS;
GRANT EXECUTE ON customer_typ to QS;
execute dbms_aqadm.grant_system_privilege('ENQUEUE_ANY','QS',FALSE);

GRANT EXECUTE ON order_typ to QS_WS;
GRANT EXECUTE ON orderitemlist_vartyp to QS_WS;
GRANT EXECUTE ON orderitem_typ to QS_WS;
GRANT EXECUTE ON customer_typ to QS_WS;
execute dbms_aqadm.grant_system_privilege('ENQUEUE_ANY','QS_WS',FALSE);

GRANT EXECUTE ON order_typ to QS_ES;
GRANT EXECUTE ON orderitemlist_vartyp to QS_ES;
GRANT EXECUTE ON orderitem_typ to QS_ES;
GRANT EXECUTE ON customer_typ to QS_ES;
execute dbms_aqadm.grant_system_privilege('ENQUEUE_ANY','QS_ES',FALSE);

GRANT EXECUTE ON order_typ to QS_OS;
GRANT EXECUTE ON orderitemlist_vartyp to QS_OS;
GRANT EXECUTE ON orderitem_typ to QS_OS;
GRANT EXECUTE ON customer_typ to QS_OS;
execute dbms_aqadm.grant_system_privilege('ENQUEUE_ANY','QS_OS',FALSE);

GRANT EXECUTE ON order_typ to qs_cbadm;
GRANT EXECUTE ON orderitemlist_vartyp to qs_cbadm;
GRANT EXECUTE ON orderitem_typ to qs_cbadm;
GRANT EXECUTE ON customer_typ to qs_cbadm;

GRANT EXECUTE ON order_typ to QS_CB;
GRANT EXECUTE ON orderitemlist_vartyp to QS_CB;
GRANT EXECUTE ON orderitem_typ to QS_CB;
GRANT EXECUTE ON customer_typ to QS_CB;

GRANT EXECUTE ON order_typ to QS_CS;
GRANT EXECUTE ON orderitemlist_vartyp to QS_CS;
GRANT EXECUTE ON orderitem_typ to QS_CS;
GRANT EXECUTE ON customer_typ to QS_CS;

COMMIT;

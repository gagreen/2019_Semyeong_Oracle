rem
rem Header: oe_drop.sql 09-jan-01
rem
rem Copyright (c) 2001, 2002, Oracle Corporation.  All rights reserved.  
rem
rem Owner  : ahunold
rem
rem NAME
rem   oe_drop.sql - drop OE Common Schema
rem
rem DESCRIPTON
rem   Deletes database objects. 
rem
rem MODIFIED   (MM/DD/YY)
rem   hyeh      08/29/02 - hyeh_mv_comschema_to_rdbms
rem   ahunold   02/01/02 - bug2205388
rem   ahunold   01/30/01 - OE script headers
rem   ahunold   01/09/01 - checkin ADE

rem
rem  First drop the Online Catalog (OC) subschema objects
rem

@?/demo/schema/order_entry/oc_drop.sql

DROP TABLE        customers             CASCADE CONSTRAINTS;
DROP TABLE        inventories           CASCADE CONSTRAINTS;
DROP TABLE        order_items           CASCADE CONSTRAINTS;
DROP TABLE        orders                CASCADE CONSTRAINTS;
DROP TABLE        product_descriptions  CASCADE CONSTRAINTS;
DROP TABLE        product_information   CASCADE CONSTRAINTS;
DROP TABLE        warehouses            CASCADE CONSTRAINTS;

DROP TYPE         cust_address_typ;
DROP TYPE         phone_list_typ;

DROP SEQUENCE     orders_seq;

DROP SYNONYM      countries;
DROP SYNONYM      departments;
DROP SYNONYM      employees;
DROP SYNONYM      job_history;
DROP SYNONYM      jobs;
DROP SYNONYM      locations;

DROP VIEW         bombay_inventory;
DROP VIEW         product_prices;
DROP VIEW         products;
DROP VIEW         sydney_inventory;
DROP VIEW         toronto_inventory;

COMMIT;



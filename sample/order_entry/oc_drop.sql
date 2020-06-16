rem
rem $Header: oc_drop.sql 29-aug-2002.11:45:06 hyeh Exp $  
rem
rem Copyright (c) 2001, 2002, Oracle Corporation.  All rights reserved.  
rem
rem Owner  : ahunold
rem
rem NAME
rem   oc_drop.sql - drop OC subschema of OE Common Schema
rem
rem DESCRIPTON
rem   Drop all database objects
rem
rem MODIFIED   (MM/DD/YY)
rem   hyeh      08/29/02 - hyeh_mv_comschema_to_rdbms
rem   ahunold   02/01/02 - bug2205388
rem   gxlee     03/05/01 - substituteable object table
rem   ahunold   01/29/01 - typo
rem   ahunold   01/09/01 - checkin ADE

drop table categories_tab                       cascade constraints ;

drop view oc_customers;
drop view oc_corporate_customers;
drop view oc_orders;
drop view oc_inventories;
drop view oc_product_information;

drop type order_list_typ force;
drop type product_ref_list_typ force;
drop type subcategory_ref_list_typ force;
drop type leaf_category_typ force;
drop type composite_category_typ force;
drop type catalog_typ force;
drop type category_typ force;

drop type customer_typ force;
drop type corporate_customer_typ force;
drop type warehouse_typ force;
drop type order_item_typ force;
drop type order_item_list_typ force;
drop type order_typ force;
drop type inventory_typ force;
drop type inventory_list_typ force;
drop type product_information_typ force;

commit;


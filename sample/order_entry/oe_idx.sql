rem
rem Header: oe_idx.sql 09-jan-01
rem
rem Copyright (c) 2001, 2002, Oracle Corporation.  All rights reserved.  
rem
rem Owner  : ahunold
rem
rem NAME
rem   oe_idx.sql - create indexes for OE Common Schema
rem
rem DESCRIPTON
rem   Re-Creates indexes
rem
rem MODIFIED   (MM/DD/YY)
rem   hyeh      08/29/02 - hyeh_mv_comschema_to_rdbms
rem   ahunold   03/02/01 - eliminating DROP INDEX
rem   ahunold   01/30/01 - OE script headers
rem   ahunold   01/09/01 - checkin ADE

CREATE INDEX whs_location_ix
ON warehouses (location_id);

CREATE INDEX inv_product_ix
ON inventories (product_id);

CREATE INDEX inv_warehouse_ix
ON inventories (warehouse_id);

CREATE INDEX item_order_ix
ON order_items (order_id);

CREATE INDEX item_product_ix
ON order_items (product_id);

CREATE INDEX ord_sales_rep_ix
ON orders (sales_rep_id);

CREATE INDEX ord_customer_ix
ON orders (customer_id);

CREATE INDEX ord_order_date_ix
ON orders (order_date);

CREATE INDEX cust_account_manager_ix
ON customers (account_mgr_id);

CREATE INDEX cust_lname_ix
ON customers (cust_last_name);

CREATE INDEX cust_email_ix
ON customers (cust_email);

CREATE INDEX prod_name_ix
ON product_descriptions (translated_name);

CREATE INDEX prod_supplier_ix
ON product_information (supplier_id);

CREATE INDEX cust_upper_name_ix
ON customers (UPPER(cust_last_name), UPPER(cust_first_name));

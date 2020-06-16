Rem
Rem $Header: sh_cons.sql 29-aug-2002.11:56:34 hyeh Exp $
Rem
Rem sh_cons.sql
Rem
Rem Copyright (c) 2001, 2002, Oracle Corporation.  All rights reserved.  
Rem
Rem    NAME
Rem      sh_cons.sql - Define constraints
Rem
Rem    DESCRIPTION
Rem      SH is the Sales History schema of the Oracle 9i Sample
Rem	   Schemas
Rem
Rem    NOTES
Rem      
Rem
Rem    MODIFIED   (MM/DD/YY)
Rem    hyeh       08/29/02 - hyeh_mv_comschema_to_rdbms
Rem    hbaer      01/29/01 - Created
Rem

ALTER TABLE sales MODIFY CONSTRAINT sales_product_fk  ENABLE NOVALIDATE;
ALTER TABLE sales MODIFY CONSTRAINT sales_customer_fk ENABLE NOVALIDATE;
ALTER TABLE sales MODIFY CONSTRAINT sales_time_fk     ENABLE NOVALIDATE;
ALTER TABLE sales MODIFY CONSTRAINT sales_channel_fk  ENABLE NOVALIDATE;
ALTER TABLE sales MODIFY CONSTRAINT sales_promo_fk    ENABLE NOVALIDATE;
ALTER TABLE costs MODIFY CONSTRAINT costs_time_fk     ENABLE NOVALIDATE;
ALTER TABLE costs MODIFY CONSTRAINT costs_product_fk  ENABLE NOVALIDATE;


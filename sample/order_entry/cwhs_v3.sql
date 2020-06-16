Rem
Rem $Header: cwhs_v3.sql 29-aug-2002.11:44:58 hyeh Exp $
Rem
Rem cwhs_v3.sql
Rem
Rem Copyright (c) 2002, Oracle Corporation.  All rights reserved.  
Rem
Rem    NAME
Rem      cwhs_v3.sql - <one-line expansion of the name>
Rem
Rem    DESCRIPTION
Rem      <short description of component this file declares/defines>
Rem
Rem    NOTES
Rem      <other useful comments, qualifications, etc.>
Rem
Rem    MODIFIED   (MM/DD/YY)
Rem    hyeh        08/29/02 - hyeh_mv_comschema_to_rdbms
Rem    ahunold     07/22/02 - echo
Rem    ahunold     07/15/02 - ahunold_versions01
Rem    ahunold     07/15/02 - Created
Rem

CREATE TABLE warehouses
    ( warehouse_id       NUMBER(3) 
    , warehouse_spec     SYS.XMLTYPE
    , warehouse_name     VARCHAR2(35)
    , location_id        NUMBER(4)
    , wh_geo_location    MDSYS.SDO_GEOMETRY
    ) ;

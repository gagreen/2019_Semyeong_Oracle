rem
Rem $Header: oe_analz.sql 29-aug-2002.11:45:09 hyeh Exp $  
rem
rem Copyright (c) 2001, 2002, Oracle Corporation.  All rights reserved.  
rem
rem Owner  : ahunold
rem
rem NAME
rem   oe_analz.sql - Gather statistics for OE Common Schema
rem
rem DESCRIPTON
rem   
rem
rem MODIFIED   (MM/DD/YY)
rem   hyeh      08/29/02 - hyeh_mv_comschema_to_rdbms
rem   ahunold   08/15/02 - include OC
rem   ahunold   01/29/01 - typos
rem   ahunold   01/09/01 - checkin ADE

EXECUTE dbms_stats.gather_schema_stats( -
        'OE'                            ,       -
        granularity => 'ALL'            ,       -
        cascade => TRUE                 ,       -
        block_sample => TRUE            ); 


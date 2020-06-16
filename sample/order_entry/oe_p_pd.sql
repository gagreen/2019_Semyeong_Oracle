rem
rem Header: oe_p_pd.sql 09-jan-01
rem
rem Copyright (c) 2001, 2002, Oracle Corporation.  All rights reserved.  
rem
rem Owner  : ahunold
rem
rem NAME
rem   oe_p_pd.sql - populate OE Common Schema
rem
rem DESCRIPTON
rem   Table product_descriptions
rem
rem MODIFIED   (MM/DD/YY)
rem   hyeh      08/29/02 - hyeh_mv_comschema_to_rdbms
rem   ahunold   05/03/01 - Catalan language.
rem   ahunold   02/08/01 - Globalization
rem   ttanaka   02/07/01 - call one SQL script per language
rem   ahunold   01/09/01 - checkin ADE

REM =======================================================
REM insert translated contents into product_descriptions
REM =======================================================

REM
REM American English
REM
@@oe_p_us
REM
REM Other languages
REM
@@oe_p_ar
@@oe_p_ca
@@oe_p_cs
@@oe_p_d
@@oe_p_dk
@@oe_p_e
@@oe_p_el
@@oe_p_esa
@@oe_p_f
@@oe_p_frc
@@oe_p_hu
@@oe_p_i
@@oe_p_iw
@@oe_p_ja
@@oe_p_ko
@@oe_p_n
@@oe_p_nl
@@oe_p_pl
@@oe_p_pt
@@oe_p_ptb
@@oe_p_ro
@@oe_p_ru
@@oe_p_s
@@oe_p_sf
@@oe_p_sk
@@oe_p_th
@@oe_p_tr
@@oe_p_zhs
@@oe_p_zht

commit;
set define on

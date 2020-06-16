Rem
Rem $Header: pm_cre.sql 13-dec-2002.10:01:50 ahunold Exp $
Rem
Rem pm_cre.sql
Rem
Rem Copyright (c) 2001, 2002, Oracle Corporation.  All rights reserved.  
Rem
Rem    NAME
Rem      pm_cre.sql - Table creation scripts
Rem
Rem    DESCRIPTION
Rem      PM is the Product Media schema of the Oracle 9i Sample
Rem        Schemas
Rem
Rem    NOTES
Rem      The OIDs assigned for the object types are used to 
Rem      simplify the setup of Replication demos and are not needed
Rem      in most unreplicated environments.
Rem
Rem    MODIFIED   (MM/DD/YY)
Rem      ahunold   12/13/02 - removing LONG column PRESS_RELEASE
Rem      hyeh      08/29/02 - hyeh_mv_comschema_to_rdbms
Rem      ahunold   04/25/01 - OID
Rem      ahunold   02/09/01 - new load method
Rem      ahunold   02/05/01 - Created
Rem 

REM ====================================================================
REM Create TYPE adheader_typ to hold different headers used in
REM advertisements, the header name, date of creation, header text, and
REM logo used. pm.print_media ad_header column has type adheader_typ.

CREATE TYPE adheader_typ 
  OID '82A4AF6A4CCE656DE034080020E0EE3D'
  AS OBJECT
    ( header_name        VARCHAR2(256)
    , creation_date      DATE
    , header_text        VARCHAR2(1024)
    , logo               BLOB
    );
/

REM =======================================================================
REM Create TYPE textdoc_tab as a nested table for
REM advertisements stored in different formats. Document type can be pdf,
REM html,Word,Frame, ...
REM pm.print_media ad_textdocs_ntab column has type textdoc_tab.

CREATE TYPE textdoc_typ
  OID '82A4AF6A4CCF656DE034080020E0EE3D'
  AS OBJECT
    ( document_typ      VARCHAR2(32)
    , formatted_doc     BLOB
    ) ;
/
CREATE TYPE textdoc_tab
  OID '82A4AF6A4CD0656DE034080020E0EE3D'
  AS TABLE OF textdoc_typ;
/
REM ======================================================================
REM Create table online_media to hold media for the online catalog
REM or other marketing/training needs.
REM pm.online_media has a foreign key on product_id that references the
REM oe.product_information table. pm.online_media has a primary key on
REM product_id.

CREATE TABLE online_media 
   ( product_id         	NUMBER(6) 
   , product_photo      	ORDSYS.ORDImage 
   , product_photo_signature  ORDSYS.ORDImageSignature 
   , product_thumbnail  	ORDSYS.ORDImage 
   , product_video      	ORDSYS.ORDVideo 
   , product_audio      	ORDSYS.ORDAudio 
   , product_text       	CLOB 
   , product_testimonials	ORDSYS.ORDDoc 
   ) ; 

CREATE UNIQUE INDEX onlinemedia_pk
    ON online_media (product_id);

ALTER TABLE online_media
ADD ( CONSTRAINT onlinemedia__pk
      PRIMARY KEY (product_id)
    , CONSTRAINT loc_c_id_fk
                FOREIGN KEY (product_id)
                REFERENCES oe.product_information(product_id)
    ) ;

REM ========================================================================
REM Create table print_media to hold print advertising information.
REM pm.print_media has a foreign key on product_id that references the
REM oe.product_information table. pm.print_media has a primary key on
REM ad_id and product. pm.print_media references a nested table, ad_textdoc_ntab, and
REM column object of type adheader_typ.
REM ========================================================================
REM NOTE: Earlier releases of the Sample Schemas contained a LONG column
REM ***** press_release in this table.
REM       For LONG column data and demo, please use long2lob.sql
REM ========================================================================

CREATE TABLE print_media
    ( product_id        NUMBER(6)
    , ad_id             NUMBER(6)
    , ad_composite      BLOB
    , ad_sourcetext     CLOB
    , ad_finaltext      CLOB
    , ad_fltextn        NCLOB
    , ad_textdocs_ntab  textdoc_tab
    , ad_photo          BLOB
    , ad_graphic        BFILE
    , ad_header         adheader_typ
    ) NESTED TABLE ad_textdocs_ntab STORE AS textdocs_nestedtab;

CREATE UNIQUE INDEX printmedia_pk
    ON print_media (product_id, ad_id);

ALTER TABLE print_media
ADD ( CONSTRAINT printmedia__pk
      PRIMARY KEY (product_id, ad_id)
    , CONSTRAINT printmedia_fk
                 FOREIGN KEY (product_id)
                 REFERENCES oe.product_information(product_id)
    ) ;

COMMIT;

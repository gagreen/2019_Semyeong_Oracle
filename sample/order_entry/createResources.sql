Rem
Rem $Header: createResources.sql 23-sep-2004.13:45:32 cbauwens Exp $
Rem
Rem createResources.sql
Rem
Rem Copyright (c) 2002, 2004, Oracle. All rights reserved.  
Rem
Rem    NAME
Rem      createResources.sql - Load example documents into the XDB repository
Rem
Rem    DESCRIPTION
Rem      .
Rem
Rem    NOTES
Rem      .
Rem
Rem    MODIFIED   (MM/DD/YY)
Rem    cbauwens    09/23/04 - cbauwens_bug3031915
Rem    cbauwens    03/16/04 - add empdept 
Rem    cbauwens    03/14/04 - Created 


DECLARE
  res BOOLEAN;
BEGIN
  res := DBMS_XDB.createResource('/home/OE/purchaseOrder.xsd',
                                 bfilename('XMLDIR', 'purchaseOrder.xsd'),
                                 nls_charset_id('AL32UTF8'));
  res := DBMS_XDB.createResource('/home/OE/purchaseOrder.xsl',
                                 bfilename('XMLDIR', 'purchaseOrder.xsl'),
                                 nls_charset_id('AL32UTF8'));
                                 
                               
  res := DBMS_XDB.createResource('/home/OE/xsl/empdept.xsl',
                                 bfilename('XMLDIR', 'empdept.xsl'),
                                 nls_charset_id('AL32UTF8'));

END;
/

Rem
Rem $Header: xdb03usg.sql 25-may-2005.16:42:54 cbauwens Exp $
Rem
Rem coe_xml.sql
Rem
Rem Copyright (c) 2002, 2005, Oracle. All rights reserved.  
Rem
Rem    NAME
Rem      xdb03usg.sql - Create XML DB data for user OE
Rem
Rem    DESCRIPTION
Rem      .
Rem
Rem    NOTES
Rem      .
Rem
Rem    MODIFIED   (MM/DD/YY)
Rem    cbauwens    05/25/05 - rename nested tables 
Rem    cbauwens    09/23/04 - cbauwens_bug3031915
Rem    cbauwens    03/16/04 - Created

--
--
-- Create Repository Folder Hierarchy
--
@?/demo/schema/order_entry/createFolders.sql


--
-- Load example documents into the XDB repository
--
@?/demo/schema/order_entry/createResources.sql


--
--Register schema
--
BEGIN
  DBMS_XMLSCHEMA.registerSchema('http://localhost:8080/source/schemas/poSource/xsd/purchaseOrder.xsd',
                                XDBURIType('/home/OE/purchaseOrder.xsd').getClob(),
                                TRUE, 
                                TRUE, 
                                FALSE, 
                                TRUE);
END;
/

--
--Rename the cryptic nested tables
--
call xdb_utilities.renameCollectionTable ('PURCHASEORDER','"XMLDATA"."LINEITEMS"."LINEITEM"','LINEITEM_TABLE')
/
call xdb_utilities.renameCollectionTable ('PURCHASEORDER','"XMLDATA"."ACTIONS"."ACTION"','ACTION_TABLE')
/

--
-- Upload the Directory containing the sample documents
--
BEGIN
 XDB_UTILITIES.uploadFiles('filelist.xml', 
                               'XMLDIR', 
                               '/home/OE/PurchaseOrders');
END;
/

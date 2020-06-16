Rem
Rem $Header: createUser.sql.sbs 23-sep-2004.13:45:32 cbauwens Exp $
Rem
Rem coe_xml.sql.sbs
Rem
Rem Copyright (c) 2002, 2004, Oracle. All rights reserved.  
Rem
Rem    NAME
Rem      createUser.sql.sbs - Create a user, directory, and XDB folder
Rem
Rem    DESCRIPTION
Rem      .
Rem
Rem    NOTES
Rem      Instantiates createUser.sql. Sets s_oePath
Rem
Rem    MODIFIED   (MM/DD/YY)
Rem    cbauwens    09/23/04 - cbauwens_bug3031915
Rem    cbauwens    03/16/04 - Created
            


DECLARE
  targetFolder VARCHAR2(256) := '/home';
  result boolean;
BEGIN
  IF (DBMS_XDB.existsResource(targetFolder)) THEN
    DBMS_XDB.deleteResource(targetFolder, DBMS_XDB.DELETE_RECURSIVE);
  END IF;
  
  result := DBMS_XDB.createFolder(targetFolder);
  targetFolder := targetFolder || '/OE';
  result := DBMS_XDB.createFolder(targetFolder);
  DBMS_XDB.setAcl(targetFolder, '/sys/acls/all_all_acl.xml');
  xdb_utilities.createHomeFolder('OE');
END;
/

CONNECT OE/&pass_oe

--Create Oracle directory object
CREATE OR REPLACE DIRECTORY XMLDIR as 'C:\oracle\product\11.1.0\db_2\demo\schema\order_entry\'
/

COMMIT
/



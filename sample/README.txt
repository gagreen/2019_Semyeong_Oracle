-----------------------------------------------------------------------------------

Sample Schemas README.txt

Version 10.1.0.2

Created 25-NOV-2003


-----------------------------------------------------------------------------------



This document describes the structure of the Schema directory, and instructions for 
creating the Sample Schemas.



==============================================

1.  Structure of the Schemas directory

==============================================



The Schema directory contains the following files and sub-folders:



schema

   mksample.sql         -- script that erases and recreates all Sample Schemas
			   CAUTION: This script contains directory paths that might
                           only suit one specific installation. 

   mk_dir.sql           -- script that sets the DIRECTORY objects. This script is
                           invoked during database creation by the Database
                           Configuration Assistant (DBCA)
                           CAUTION: This script contains directory paths that might
                           only suit one specific installation. 
   
   README.txt           -- explains the process of creating the Sample Schemas


The following folders contain scripts to drop and create database objects, load 
data.

   human_resources	-- hr_main.sql creates or recreates the HR schema
			-- hr_drop.sql drops all objects, but not the HR user

   order_entry      	-- oe_main.sql creates or recreates the whole OE schema
                        -- oe_drop.sql drops all relational objects, but not the
			   HR user   
			-- oc_main.sql creates the OC subschema and is called by 
			   oe_main.sql (OC stands for Online Catalog)
			-- oc_drop.sql drops all the object-relational parts of
			   the OC subschema 

   product_media	-- pm_main.sql creates or recreates the PM schema
                        -- pm_drop.sql drops all objects, but not the PM user

   
   info_exchange	-- ix_main.sql creates or recreates the IX schema
                        -- dix_v3.sql drops all objects, but not the IX user
                               

   sales_history	-- sh_main.sql creates or recreates the SH schema
                        -- sh_drop.sql drops all objects, but not the SH user 

   bus_intelligence     -- bi_main.sql creates user BI and grants SELECT 
                           privileges on specific OE and SH objects
===================================================

2.  Instructions to create the schemas:

===================================================

1)	Decide on passwords for the Sample Schemas. For illustration purposes,
	let's assume the user passwords are:
		SYSTEM: TWEETY
                SYS:    TAHITI
		HR:	H19
		OE:	O34
		PM:	P94
		IX:	I12
		SH:	S87
		BI:     B52
2)      Verify the value for the default tablespace, the temporary tablespace,
        and the log file directory.  For illustration purposes, let's assume 
        the values are: 	
		default tablespace: EXAMPLE
		temporary tablespace: TEMP
		log file directory: /oracle/rdbms/demo/schema/log_dir
	NOTE: Please make sure to use your own, secret passwords

3)	Invoke the Sample Schema creation script. Using the values listed above
        the command would look like:
	SQL> @?/demo/schema/mksample TWEETY TAHITI H19 O34 P94 I12 S87
	B52 EXAMPLE TEMP /oracle/rdbms/demo/schema/log_dir/

4)	The HR, OE, PM, and IX schemas take little time to create. The
	SH schema takes about 30 to 45 minutes to complete.

5)	At the end of the mksample script, the data dictionary is queried to
	list all objects created.

=================================================== 

3.  Schema dependencies and requirements: 

=================================================== 

The HR schema does not require any other schema other than SYS and SYSTEM to
be present. Nor does the HR schema use datatypes or objects more recent than
Oracle8i

The OE schema requires the database to be enabled for spatial data.

The PM schema requires the database to be enabled for Intermedia, which in
turn requires a java-enabled database.

The SH schema uses Partitioning.

Please refer to the Oracle10g documentation for more detailed information 
about the Sample Schemas.


===================================================

4.  Known bugs 

===================================================


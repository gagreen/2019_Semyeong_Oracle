Rem
Rem $Header: sh_pop1.sql 29-aug-2002.11:56:58 hyeh Exp $
Rem
Rem sh_pop1.sql
Rem
Rem Copyright (c) 2001, 2002, Oracle Corporation.  All rights reserved.  
Rem
Rem    NAME
Rem      sh_pop1.sql - Populates the countries and channel table 
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

INSERT INTO countries VALUES('US','United States of America'
                                 ,'Northern America','Americas');
INSERT INTO countries VALUES('DE','Germany'
                                 ,'Western Europe',  'Europe');
INSERT INTO countries VALUES('UK','United Kingdom'
                                 ,'Western Europe',  'Europe');    
INSERT INTO countries VALUES('NL','The Netherlands'
                                 ,'Western Europe',  'Europe');       
INSERT INTO countries VALUES('IE','Ireland'
                                 ,'Western Europe',  'Europe');           
INSERT INTO countries VALUES('DK','Denmark'
                                 ,'Western Europe',  'Europe');           
INSERT INTO countries VALUES('FR','France'
                                 ,'Western Europe',  'Europe');            
INSERT INTO countries VALUES('ES','Spain'
                                 ,'Western Europe',  'Europe');             
INSERT INTO countries VALUES('TR','Turkey'
                                 ,'Western Europe',  'Europe');           
INSERT INTO countries VALUES('PL','Poland'
                                 ,'Eastern Europe',  'Europe');            
INSERT INTO countries VALUES('BR','Brazil'
                                 ,'Southern America','Americas');        
INSERT INTO countries VALUES('AR','Argentina'
                                 ,'Southern America','Americas');     
INSERT INTO countries VALUES('MY','Malaysia'
                                 ,'Asia',            'Asia');                      
INSERT INTO countries VALUES('JP','Japan'
                                 ,'Asia',            'Asia');                         
INSERT INTO countries VALUES('IN','India'
                                 ,'Asia',            'Asia');                         
INSERT INTO countries VALUES('AU','Australia'
                                 ,'Australia',       'Oceania');           
INSERT INTO countries VALUES('NZ','New Zealand'
                                 ,'Australia',       'Oceania');
INSERT INTO countries VALUES('ZA','South Africa'
                                 ,'Africa',  'Africa');           
INSERT INTO countries VALUES('SA','Saudi Arabia'
                                 ,'Middle East',  'Middle East');           

INSERT INTO channels VALUES('S','Direct Sales'  ,'Direct'  );
INSERT INTO channels VALUES('T','Tele Sales'    ,'Direct'  );
INSERT INTO channels VALUES('C','Catalog'       ,'Indirect');
INSERT INTO channels VALUES('I','Internet'      ,'Indirect');
INSERT INTO channels VALUES('P','Partners'      ,'Others'  );

COMMIT;




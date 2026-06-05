/*
========================================
Create Database and schemas
========================================

Script Purpose:
This script create a new database 'DataWareHouse' and check if an already created or exists.
If exsits it will drop the table and create a new one.
We have introduced three schemas as bronze, silver and gold in the database which will be used for the future reference

*/
use master;
GO

----Drop table if exist and recrate the 'DataWareHouse' database

IF EXISTS (SELECT 1 FROM sys.databases where name='DataWareHouse')
BEGIN
     ALTER DATABASE DataWareHouse set SINGLE_USER WITH ROLLBACK IMMEDIATE;
	 DROP DATABASE DataWareHouse;
END;
GO

----Create the 'DataWareHouse' database

create database DataWareHouse;
GO

USE DataWareHouse;
GO

----Create Schemas
CREATE SCHEMA bronze;
go

CREATE SCHEMA silver;
go

CREATE SCHEMA gold;
go

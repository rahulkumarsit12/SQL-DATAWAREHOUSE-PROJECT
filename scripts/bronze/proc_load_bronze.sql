/*
================================================================================
Stored Procedure: Load Bronze Layer (Brought data from source to Load)
================================================================================
In order to excute the SP use :- EXEC bronze.load_bronze

Here we have tracked the time taken for each table as well as the entire table
Used Bulk insert to insert the data from CSV File into the bronze table

*/


CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
DECLARE @start_time DATETIME ,@end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
BEGIN TRY
SET @batch_start_time=GETDATE();
PRINT '===================================';
PRINT 'Loading Bronze Layer';
PRINT '===================================';

PRINT '-----------------------------------';
PRINT 'Loading CRM tables';
PRINT '-----------------------------------';

SET @start_time=GETDATE();
TRUNCATE TABLE bronze.crm_cust_info
PRINT '>>Truncating Table:bronze.crm_cust_info';

PRINT '>>Inserting Data Into:bronze.crm_cust_info';
BULK INSERT bronze.crm_cust_info
from 'C:\SQL\DATAWAREHOUSE_PROJECT\DATASETS\source_crm\cust_info.csv'
WITH (
   FIRSTROW=2,
   FIELDTERMINATOR= ',',
   TABLOCK
);
SET @end_time=GETDATE();
PRINT '>>Load Duration:' + CAST(DATEDIFF(second, @start_time , @end_time) AS NVARCHAR) + 'seconds';
PRINT '>>------------------------------';


SET @start_time=GETDATE();
TRUNCATE TABLE bronze.crm_prd_info
PRINT '>>Truncating Table:bronze.crm_prd_info';

PRINT '>>Inserting Data Into:bronze.crm_prd_info';
BULK INSERT bronze.crm_prd_info
from 'C:\SQL\DATAWAREHOUSE_PROJECT\DATASETS\source_crm\prd_info.csv'
WITH (
   FIRSTROW=2,
   FIELDTERMINATOR= ',',
   TABLOCK
);
SET @end_time=GETDATE();
PRINT '>>Load Duration:' + CAST(DATEDIFF(second, @start_time , @end_time) AS NVARCHAR) + 'seconds';
PRINT '>>------------------------------';


SET @start_time=GETDATE();
TRUNCATE TABLE bronze.crm_sale_details
PRINT '>>Truncating Table:bronze.crm_sale_details';

PRINT '>>Inserting Data Into:bronze.crm_sales_details';
BULK INSERT bronze.crm_sale_details
from 'C:\SQL\DATAWAREHOUSE_PROJECT\DATASETS\source_crm\sales_details.csv'
WITH (
   FIRSTROW=2,
   FIELDTERMINATOR= ',',
   TABLOCK
);

SET @end_time=GETDATE();
PRINT '>>Load Duration:' + CAST(DATEDIFF(second, @start_time , @end_time) AS NVARCHAR) + 'seconds';
PRINT '>>------------------------------';


PRINT '-----------------------------------';
PRINT 'Loading ERP tables';
PRINT '-----------------------------------';

SET @start_time=GETDATE();
PRINT '>>Truncating Table:bronze.erp_cust_az12';
TRUNCATE TABLE bronze.erp_cust_az12;

PRINT '>>Inserting Data Into:bronze.erp_cust_az12';
BULK INSERT bronze.erp_cust_az12
from 'C:\SQL\DATAWAREHOUSE_PROJECT\DATASETS\source_erp\cust_az12.csv'
WITH (
   FIRSTROW=2,
   FIELDTERMINATOR= ',',
   TABLOCK
);
SET @end_time=GETDATE();
PRINT '>>Load Duration:' + CAST(DATEDIFF(second, @start_time , @end_time) AS NVARCHAR) + 'seconds';
PRINT '>>------------------------------';


SET @start_time=GETDATE();
TRUNCATE TABLE bronze.erp_loc_a101
PRINT '>>Truncating Table:bronze.erp_loc_a101';

PRINT '>>Inserting Data Into:bronze.erp_loc_a101';
BULK INSERT bronze.erp_loc_a101
from 'C:\SQL\DATAWAREHOUSE_PROJECT\DATASETS\source_erp\loc_a101.csv'
WITH (
   FIRSTROW=2,
   FIELDTERMINATOR= ',',
   TABLOCK
);
SET @end_time=GETDATE();
PRINT '>>Load Duration:' + CAST(DATEDIFF(second, @start_time , @end_time) AS NVARCHAR) + 'seconds';
PRINT '>>------------------------------';


SET @start_time=GETDATE();
TRUNCATE TABLE bronze.erp_px_cat_g1v2
PRINT '>>Truncating Table:bronze.erp_px_cat_g1v2';

PRINT '>>Inserting Data Into:bronze.erp_px_cat_g1v2';
BULK INSERT bronze.erp_px_cat_g1v2
from 'C:\SQL\DATAWAREHOUSE_PROJECT\DATASETS\source_erp\px_cat_g1v2.csv'
WITH (
   FIRSTROW=2,
   FIELDTERMINATOR= ',',
   TABLOCK
);
SET @end_time=GETDATE();
PRINT '>>Load Duration:' + CAST(DATEDIFF(second, @start_time , @end_time) AS NVARCHAR) + 'seconds';
PRINT '>>------------------------------';

SET @batch_end_time=GETDATE();

PRINT '==========================================='
PRINT 'Load Bronze Layer is completed'
PRINT '- Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + 'seconds';
PRINT '==========================================='

END TRY
BEGIN CATCH
PRINT '=========================='
PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
PRINT 'Error Message'+ ERROR_MESSAGE();
PRINT 'Error Message'+ CAST(ERROR_NUMBER() AS NVARCHAR);
PRINT 'Error Message'+ CAST(ERROR_STATE() AS NVARCHAR);
PRINT '=========================='
END CATCH
END



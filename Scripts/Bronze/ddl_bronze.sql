-- ================================================
Script Purpose:
This script creates tables in the 'bronze' schema, dropping existing tables
if they already exist.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER  PROCEDURE  bronze.[Main query]
AS
BEGIN
	BEGIN TRY
		-------- Create data warehouse database and shema
		--create database DateWarehouse;
		--GO

		--USE DataWarehouse
		--GO

		----create schema
		--create schema bronze
		--GO
		--create schema silver
		--GO
		--create schema Gold

		----Create TABLES
		IF OBJECT_ID ('bronze.crm_cust_info ','U') IS NOT NULL
		DROP TABLE bronze.crm_cust_info ;

		CREATE TABLE bronze.crm_cust_info (
		t_id INT,
		t_key NVARCHAR(50), 
		t_firstname NVARCHAR(50), 
		t_lastname NVARCHAR(50), 
		t_material_status NVARCHAR(50),
		t_gndr NVARCHAR(59),
		t_create_date DATE
		)

		IF OBJECT_ID ('bronze.crm_prd_info ','U') IS NOT NULL
		DROP TABLE bronze.crm_prd_info ;

		CREATE TABLE bronze.crm_prd_info (
		prd_id INT,
		prd_key NVARCHAR(50),
		prd_nm NVARCHAR(50),
		prd_cost INT,
		prd_line NVARCHAR(50),
		prd_start_dt DATETIME,
		prd_end_dt DATETIME
		);

		IF OBJECT_ID ('bronze.crm_sales_details ','U') IS NOT NULL
		DROP TABLE bronze.crm_sales_details ;

		CREATE TABLE bronze.crm_sales_details (
		sls_ord_num NVARCHAR (50),
		sls_prd_key NVARCHAR(50),
		sls_cust_id INT,
		sls_order_dt INT,
		sls_ship_dt INT,
		sls_due_dt INT,
		sls_sales INT, 
		sls_quantity INT,
		sls_price INT
		)

		IF OBJECT_ID ('bronze.erp_loc_a101 ','U') IS NOT NULL
		DROP TABLE bronze.erp_loc_a101 ;

		CREATE TABLE bronze.erp_loc_a101 (
		cid NVARCHAR(50),
		cntry NVARCHAR(59)
		);

		IF OBJECT_ID ('bronze.erp_cust_az12 ','U') IS NOT NULL
		DROP TABLE bronze.erp_cust_az12 ;

		CREATE TABLE bronze.erp_cust_az12 (
		cid NVARCHAR(50),
		cid_date DATE,
		gen NVARCHAR(50),
		);

		IF OBJECT_ID ('bronze.erp_px_cat_g1v2 ','U') IS NOT NULL
		DROP TABLE bronze.erp_px_cat_g1v2 ;

		CREATE TABLE Bronze.erp_px_cat_g1v2 (
		id NVARCHAR(50),
		cat NVARCHAR(50),
		subcat NVARCHAR(50),
		maintenance NVARCHAR(50)
		);
		-----------------------------------
		----Insert data in bulk
		BEGIN
			PRINT '=========================================='
			PRINT 'Loading Bronze Layer'
			PRINT '=========================================='

		TRUNCATE TABLE bronze.crm_cust_info;

		BULK INSERT bronze.crm_cust_info
		FRoM 'C:\Users\user\Downloads\Datasets\crm_cust_info.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SELECT COUNT (*) FROM bronze.crm_cust_info


		TRUNCATE TABLE bronze.crm_prd_info;

		BULK INSERT bronze.crm_prd_info
		FRoM 'C:\Users\user\Downloads\Datasets\crm_prd_info.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SELECT COUNT (*) FROM bronze.crm_prd_info


		TRUNCATE TABLE bronze.crm_sales_details;

		BULK INSERT bronze.crm_sales_details
		FRoM 'C:\Users\user\Downloads\Datasets\crm_sales_details.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SELECT COUNT (*) FROM bronze.crm_sales_details


		TRUNCATE TABLE bronze.erp_loc_a101;

		BULK INSERT bronze.erp_loc_a101
		FRoM 'C:\Users\user\Downloads\Datasets\erp_loc_a101.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SELECT COUNT (*) FROM bronze.erp_loc_a101


		TRUNCATE TABLE bronze.erp_cust_az12;

		BULK INSERT bronze.erp_cust_az12
		FRoM 'C:\Users\user\Downloads\Datasets\erp_cust_az12.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SELECT COUNT (*) FROM bronze.erp_cust_az12


		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		BULK INSERT bronze.erp_px_cat_g1v2
		FRoM 'C:\Users\user\Downloads\Datasets\erp_px_cat_g1v2.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SELECT COUNT (*) FROM bronze.erp_px_cat_g1v2
	END TRY
	
	BEGIN CATCH
		PRINT '===================='
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR)
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '===================='
	END CATCH

END
GO

/*
===============================================================================
Stored Procedure: Load Retail Market Data (CSV -> SQL Server)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'dbo' tables from external CSV
    files.

    It performs the following actions:
    - Truncates the tables before loading data.
    - Uses BULK INSERT to load CSV files into SQL Server tables.
    - Prints the load duration for each table.
    - Handles errors using TRY...CATCH.

Parameters:
    None.

Usage Example:
    EXEC dbo.load_retail_market;
===============================================================================
*/
USE retail_demand_forecasting;
GO


-- ============================================================
-- 1. CUSTOMERS
-- ============================================================

TRUNCATE TABLE dbo.Customers;
GO

BULK INSERT dbo.Customers
FROM 'D:\All ML Projects\Retail_Demand_Forecasting\data\raw\customers.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
GO


-- ============================================================
-- 2. PRODUCTS
-- ============================================================

TRUNCATE TABLE dbo.Products;
GO

BULK INSERT dbo.Products
FROM 'D:\All ML Projects\Retail_Demand_Forecasting\data\raw\products.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
GO


-- ============================================================
-- 3. PURCHASES
-- ============================================================

TRUNCATE TABLE dbo.Purchases;
GO

BULK INSERT dbo.Purchases
FROM 'D:\All ML Projects\Retail_Demand_Forecasting\data\raw\purchases.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
GO


-- ============================================================
-- 4. INVOICE ITEMS
-- ============================================================

TRUNCATE TABLE dbo.Invoice_Items;
GO

BULK INSERT dbo.Invoice_Items
FROM 'D:\All ML Projects\Retail_Demand_Forecasting\data\raw\invoice_items.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
GO


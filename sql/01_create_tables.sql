--USE retail_demand_forecasting;
--GO


/*
===============================================================================
DDL Script: Create Retail Market Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'dbo' schema, dropping existing tables
    if they already exist.

    Run this script to re-define the DDL structure of the tables.
===============================================================================
*/

-- ============================================================
-- Customers
-- ============================================================

IF OBJECT_ID('dbo.Customers', 'U') IS NOT NULL
    DROP TABLE dbo.Customers;
GO

CREATE TABLE dbo.Customers (
    CustomerID      INT,
    customer_type   VARCHAR(50)
);
GO


-- ============================================================
-- Products
-- ============================================================

IF OBJECT_ID('dbo.Products', 'U') IS NOT NULL
    DROP TABLE dbo.Products;
GO

CREATE TABLE dbo.Products (
    product_id      INT,
    item            VARCHAR(255),
    category        VARCHAR(100),
    price           DECIMAL(10,2)
);
GO


-- ============================================================
-- Purchases
-- ============================================================

IF OBJECT_ID('dbo.Purchases', 'U') IS NOT NULL
    DROP TABLE dbo.Purchases;
GO

CREATE TABLE dbo.Purchases (
    InvoiceID       INT,
    date            DATE,
    CustomerID      INT,
    product_id      INT,
    quantity        INT
);
GO


-- ============================================================
-- Invoice_Items
-- ============================================================

IF OBJECT_ID('dbo.Invoice_Items', 'U') IS NOT NULL
    DROP TABLE dbo.Invoice_Items;
GO

CREATE TABLE dbo.Invoice_Items (
    InvoiceID       INT,
    product_id      INT,
    quantity        INT,
    price            DECIMAL(10,2),
    line_total      DECIMAL(12,2)
);
GO

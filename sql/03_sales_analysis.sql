-- USE retail_demand_forecasting;
-- GO


-- ============================================================
-- 4. ROW COUNT VALIDATION
-- ============================================================
SELECT 'Customers' AS Table_Name, COUNT(*) AS Row_Count
FROM Customers

UNION ALL

SELECT 'Products', COUNT(*)
FROM Products

UNION ALL

SELECT 'Purchases', COUNT(*)
FROM Purchases

UNION ALL

SELECT 'Invoice_Items', COUNT(*)
FROM Invoice_Items;




-- ============================================
-- BASIC BUSINESS METRICS
-- ============================================

SELECT
    (SELECT COUNT(*) FROM Customers) AS total_customers,
    (SELECT COUNT(*) FROM Products) AS total_products,
    (SELECT COUNT(DISTINCT InvoiceID) FROM Purchases) AS total_invoices,
    (SELECT SUM(quantity) FROM Purchases) AS total_quantity_sold,
    (SELECT SUM(line_total) FROM Invoice_Items) AS total_sales;



-- ============================================
-- DATE / TIME ANALYSIS
-- ============================================

SELECT
    MIN(date) AS first_date,
    MAX(date) AS last_date,
    COUNT(DISTINCT date) AS unique_dates
FROM Purchases;



-- ============================================
-- DAILY DEMAND
-- ============================================

SELECT
    date,
    SUM(quantity) AS daily_demand
FROM Purchases
GROUP BY date
ORDER BY date;




-- ============================================
-- MONTHLY DEMAND
-- ============================================

SELECT
    YEAR(date) AS year,
    MONTH(date) AS month,
    SUM(quantity) AS monthly_demand
FROM Purchases
GROUP BY
    YEAR(date),
    MONTH(date)
ORDER BY
    year,
    month;



-- ============================================
-- TOP PRODUCTS BY QUANTITY SOLD
-- ============================================

SELECT TOP 10
    product_id,
    SUM(quantity) AS total_quantity_sold
FROM Purchases
GROUP BY product_id
ORDER BY total_quantity_sold DESC;



-- ============================================
-- TOP PRODUCTS BY REVENUE
-- ============================================

SELECT TOP 10
    product_id,
    SUM(line_total) AS total_revenue
FROM Invoice_Items
GROUP BY product_id
ORDER BY total_revenue DESC;



-- ============================================
-- CATEGORY ANALYSIS
-- ============================================

SELECT
    p.category,
    SUM(i.quantity) AS total_quantity_sold,
    SUM(i.line_total) AS total_revenue
FROM Invoice_Items i
JOIN Products p
    ON i.product_id = p.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;



-- ============================================
-- CUSTOMER TYPE ANALYSIS
-- ============================================

SELECT
    c.customer_type,
    COUNT(DISTINCT c.CustomerID) AS total_customers,
    COUNT(DISTINCT p.InvoiceID) AS total_invoices,
    SUM(p.quantity) AS total_quantity_sold
FROM Customers c
JOIN Purchases p
    ON c.CustomerID = p.CustomerID
GROUP BY c.customer_type
ORDER BY total_quantity_sold DESC;



-- ============================================
-- TOP CUSTOMERS BY QUANTITY
-- ============================================

SELECT TOP 10
    CustomerID,
    COUNT(DISTINCT InvoiceID) AS total_invoices,
    SUM(quantity) AS total_quantity
FROM Purchases
GROUP BY CustomerID
ORDER BY total_quantity DESC;



-- ============================================
-- AVERAGE ORDER VALUE
-- ============================================

SELECT
    AVG(invoice_total) AS average_order_value
FROM (
    SELECT
        InvoiceID,
        SUM(line_total) AS invoice_total
    FROM Invoice_Items
    GROUP BY InvoiceID
) AS invoice_sales;



-- ============================================
-- PRODUCT + CATEGORY ANALYSIS
-- ============================================

SELECT TOP 20
    p.product_id,
    p.item,
    p.category,
    SUM(i.quantity) AS quantity_sold,
    SUM(i.line_total) AS revenue
FROM Products p
JOIN Invoice_Items i
    ON p.product_id = i.product_id
GROUP BY
    p.product_id,
    p.item,
    p.category
ORDER BY revenue DESC;



-- ============================================
-- DUPLICATE / REPEATED INVOICE-PRODUCT ANALYSIS
-- ============================================

SELECT
    COUNT(*) AS repeated_invoice_product_groups
FROM (
    SELECT
        InvoiceID,
        product_id
    FROM Purchases
    GROUP BY
        InvoiceID,
        product_id
    HAVING COUNT(*) > 1
) AS duplicates;

--AND
SELECT
    COUNT(*) AS repeated_invoice_product_groups
FROM (
    SELECT
        InvoiceID,
        product_id
    FROM Invoice_Items
    GROUP BY
        InvoiceID,
        product_id
    HAVING COUNT(*) > 1
) AS duplicates;



-- ============================================
-- TOTAL SALES
-- ============================================
SELECT
    product_id,
    SUM(quantity * price) AS total_sales
FROM invoice_items
GROUP BY product_id
ORDER BY total_sales DESC;
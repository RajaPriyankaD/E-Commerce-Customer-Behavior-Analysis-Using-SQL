-- 1. Top 10 Customers by Spending (CTE + RANK)
-- SQL
WITH CustomerSpending AS
(
    SELECT
        c.CustomerID,
        c.CustomerName,
        SUM(od.Amount) AS TotalSpent
    FROM Customers c
    JOIN Orders o
        ON c.CustomerID = o.CustomerID
    JOIN OrderDetails od
        ON o.OrderID = od.OrderID
    GROUP BY
        c.CustomerID,
        c.CustomerName
)

SELECT
    CustomerID,
    CustomerName,
    TotalSpent,
    RANK() OVER(ORDER BY TotalSpent DESC) AS SpendingRank
FROM CustomerSpending;
-- Result (Top 5)
-- Insight
-- Customer_3192 generated the highest revenue.
-- 2. Revenue by Membership Tier
-- SQL
SELECT
    c.MembershipTier,
    SUM(od.Amount) AS Revenue
FROM Customers c
JOIN Orders o
ON c.CustomerID=o.CustomerID
JOIN OrderDetails od
ON o.OrderID=od.OrderID
GROUP BY c.MembershipTier
ORDER BY Revenue DESC;
-- Result
-- Insight
-- Silver members contribute the highest revenue because they form the largest customer group.
-- 3. Churn Rate by Tier
-- SQL
SELECT
    MembershipTier,
    COUNT(CASE WHEN ChurnFlag=1 THEN 1 END) * 100.0 /
    COUNT(*) AS ChurnRate
FROM Customers
GROUP BY MembershipTier;
-- Result
-- Insight
-- Silver members show the highest churn.
-- 4. Coupon vs Non-Coupon Revenue
-- SQL
SELECT
    CouponUsed,
    SUM(od.Amount) Revenue
FROM Orders o
JOIN OrderDetails od
ON o.OrderID=od.OrderID
GROUP BY CouponUsed;
-- Result
-- Insight
-- Most revenue came from orders without coupons.
-- 5. Online vs Offline Sales
-- SQL
SELECT
    Channel,
    COUNT(DISTINCT o.OrderID) Orders,
    SUM(od.Amount) Revenue
FROM Orders o
JOIN OrderDetails od
ON o.OrderID=od.OrderID
GROUP BY Channel;
-- Result
-- Insight
-- Online sales slightly outperform offline sales.
-- 6. Seasonal Product Analysis
-- SQL
SELECT
    p.Season,
    SUM(od.Amount) Revenue
FROM Products p
JOIN OrderDetails od
ON p.ProductID=od.ProductID
GROUP BY p.Season
ORDER BY Revenue DESC;
-- Result
-- Insight
-- Festival products generate the highest revenue.
-- 7. Product Rating Analysis
-- SQL
SELECT
    p.ProductName,
    AVG(r.Rating) AvgRating
FROM Products p
JOIN Reviews r
ON p.ProductID=r.ProductID
GROUP BY p.ProductName
ORDER BY AvgRating DESC;
-- Top Rated Products
-- Insight
-- Product_177 has the highest average rating.
-- 8. Return & Refund Analysis
-- SQL
SELECT
    ReturnReason,
    COUNT(*) ReturnCount,
    SUM(RefundAmount) TotalRefund
FROM ReturnsRefunds
GROUP BY ReturnReason
ORDER BY ReturnCount DESC;
-- Result
-- Insight
-- Wrong Item is the most common return reason.
-- 9. Customer Lifetime Value (CLV)
-- SQL
SELECT
    c.CustomerID,
    c.CustomerName,
    SUM(od.Amount) AS LifetimeValue
FROM Customers c
JOIN Orders o
ON c.CustomerID=o.CustomerID
JOIN OrderDetails od
ON o.OrderID=od.OrderID
GROUP BY c.CustomerID,c.CustomerName
ORDER BY LifetimeValue DESC;
-- Top CLV Customers
-- Insight
-- These customers should be targeted with loyalty programs.
10. Stored Procedure
Create
CREATE PROCEDURE GetCustomerPurchaseHistory
    @CustomerID INT
AS
BEGIN

    SELECT
        o.OrderID,
        o.OrderDate,
        o.Channel,
        SUM(od.Amount) AS OrderValue
    FROM Orders o
    JOIN OrderDetails od
    ON o.OrderID = od.OrderID
    WHERE o.CustomerID = @CustomerID
    GROUP BY
        o.OrderID,
        o.OrderDate,
        o.Channel;

END;
-- Usage
-- EXEC GetCustomerPurchaseHistory 3192
-- 11. Audit New Orders (Trigger)
-- Audit Table
CREATE TABLE OrderAudit
(
    AuditID INT IDENTITY(1,1),
    OrderID INT,
    CustomerID INT,
    AuditDate DATETIME
);
-- Trigger
CREATE TRIGGER trg_AuditNewOrders
ON Orders
AFTER INSERT
AS
BEGIN

INSERT INTO OrderAudit
(
    OrderID,
    CustomerID,
    AuditDate
)
SELECT
    OrderID,
    CustomerID,
    GETDATE()
FROM inserted;

END;
-- Test
INSERT INTO Orders
VALUES
(
120001,
3192,
GETDATE(),
'UPI',
'Online',
1,
'SAVE10',
'Completed'
);
-- 12. Transaction Example (Safe Order Insert)
BEGIN TRY

    BEGIN TRANSACTION;

    INSERT INTO Orders
    (
        OrderID,
        CustomerID,
        OrderDate,
        PaymentMethod,
        Channel,
        CouponUsed,
        CouponCode,
        OrderStatus
    )
    VALUES
    (
        120002,
        3192,
        GETDATE(),
        'UPI',
        'Online',
        1,
        'SAVE20',
        'Completed'
    );

    INSERT INTO OrderDetails
    (
        OrderDetailID,
        OrderID,
        ProductID,
        Quantity,
        UnitPrice,
        Amount
    )
    VALUES
    (
        25001,
        120002,
        177,
        2,
        25000,
        50000
    );

    COMMIT TRANSACTION;

END TRY

BEGIN CATCH

    ROLLBACK TRANSACTION;

END CATCH;
-- Conclusion
-- Revenue generated: ~2.40 Billion 
-- Best customer: Customer_3192 
-- Best season: Festival 
-- Best-rated product: Product_177 
-- Highest churn tier: Silver 
-- Top return reason: Wrong Item 
-- Online channel slightly outperformed offline channel 
-- Coupon orders contributed ~854 Million revenue
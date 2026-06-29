# E-Commerce Customer Behavior Analysis Using SQL

## Project Overview

This project analyzes customer purchasing behavior using SQL on an e-commerce dataset containing 5,000 customers, 20,000 orders, product reviews, membership tiers, coupon usage, returns, and refunds.

The objective is to identify high-value customers, evaluate membership performance, analyze churn, measure coupon effectiveness, compare online and offline sales, and understand product and seasonal trends.

---

## Dataset Information

### Tables Used

1. Customers
2. Categories
3. Products
4. Orders
5. OrderDetails
6. Reviews
7. ReturnsRefunds

### Key Features

* Customer churn flags
* Membership tiers (Silver, Gold, Platinum)
* Product ratings and reviews
* Online vs Offline channels
* Coupon usage tracking
* Return and refund records
* Seasonal product classifications

---

## SQL Concepts Implemented

* Joins
* Aggregate Functions
* Subqueries
* Common Table Expressions (CTEs)
* Window Functions (RANK)
* Views
* Indexes
* Stored Procedures
* Triggers
* Transactions
* Customer Lifetime Value (CLV)
* Churn Analysis
* Revenue Analysis

---

## Business Questions Solved

### Customer Analytics

* Top 10 Customers by Spending
* Customer Lifetime Value (CLV)
* Customer Purchase History
* Churn Rate Analysis

### Revenue Analytics

* Revenue by Membership Tier
* Coupon vs Non-Coupon Revenue
* Online vs Offline Sales Performance

### Product Analytics

* Top Rated Products
* Best Performing Product Seasons
* Product Category Revenue

### Return Analytics

* Return Reasons Analysis
* Refund Impact Analysis

---

## Key Findings

### Revenue Performance

* Total Revenue Generated: ~2.40 Billion
* Online channel slightly outperformed Offline channel

### Customer Insights

* Customer_3192 generated the highest lifetime value
* Silver members contributed the highest revenue
* Silver tier also showed the highest churn rate

### Product Insights

* Festival season products generated the highest revenue
* Product_177 received the highest customer rating

### Returns & Refunds

* Wrong Item was the most common return reason
* Returns significantly impacted refund expenses

---

## Advanced SQL Features

### CTE + Window Function

Used to rank customers based on spending.

### Stored Procedure

Created GetCustomerPurchaseHistory to retrieve purchase history for any customer.

### Trigger

Implemented an audit trigger to track newly inserted orders.

### Transactions

Used COMMIT and ROLLBACK mechanisms for safe order creation.

---

## Skills Demonstrated

* SQL Server / MySQL
* Data Analysis
* Business Intelligence
* Customer Segmentation
* Revenue Analytics
* Database Design
* Query Optimization
* Analytical Problem Solving

---

## Future Enhancements

* Power BI Dashboard
* Customer Segmentation using RFM
* Cohort Analysis
* Predictive Churn Modeling
* Sales Forecasting

---

## Author

Rajapriyanka D
Aspiring Data Analyst | SQL | Power BI | Python

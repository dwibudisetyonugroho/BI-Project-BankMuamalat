/*
 * PROJECT: Digital User Churn & Sales Performance Dashboard
 * TASK: Question 3 - Create Master Sales Table
 * AUTHOR: Dwi Budi Setyonugroho
 * 
 * DESCRIPTION:
 * This query joins four normalized tables (Orders, Customers, Products, ProductCategory)
 * to create a master table for visualization in Looker Studio.
 * It calculates dynamic total sales and sorts chronologically.
 */

SELECT
  c.CustomerEmail AS cust_email,
  c.CustomerCity AS cust_city,
  o.Date AS order_date,
  o.Quantity AS order_qty,
  p.ProdName AS product_name,
  p.Price AS product_price,
  pc.CategoryName AS category_name,
  (o.Quantity * p.Price) AS total_sales
FROM
  `rakamin-bank-muamalat-1.bank_muamalat.Orders` AS o
JOIN
  `rakamin-bank-muamalat-1.bank_muamalat.Customers` AS c
  ON o.CustomerID = c.CustomerID
JOIN
  `rakamin-bank-muamalat-1.bank_muamalat.Products` AS p
  ON o.ProdNumber = p.ProdNumber
JOIN
  `rakamin-bank-muamalat-1.bank_muamalat.ProductCategory` AS pc
  ON p.Category = pc.CategoryID
ORDER BY
  order_date ASC;
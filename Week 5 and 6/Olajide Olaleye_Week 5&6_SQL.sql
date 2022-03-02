

/**
1. Who are our top 10 customers and how much have they spent and ordered? 
**/

With s AS (
  SELECT 
    OrderID,
    SUM((UnitPrice * Quantity) - Discount) AS spend
  FROM OrderDetails AS od
  GROUP BY OrderID
)

SELECT
  o.CustomerID,
  c.CompanyName AS customer_name,
  COUNT(DISTINCT o.OrderId) AS times_ordered,
  s.spend AS total_spend
FROM Orders AS o
  INNER JOIN Customers AS c
    USING(CustomerID)
  INNER JOIN s
    ON o.OrderId = s.OrderID
GROUP BY CustomerID
ORDER BY times_ordered DESC, total_spend DESC
LIMIT 10;

/**
2. What are our top customers’ favorite products? 
**/

With s AS (
  SELECT 
    OrderID,
    SUM((UnitPrice * Quantity) - Discount) AS spend
  FROM OrderDetails AS od
  GROUP BY OrderID
),

t AS (
  SELECT
    o.CustomerID,
    COUNT(DISTINCT o.OrderId) AS times_ordered1,
    s.spend AS total_spend
  FROM Orders AS o
    INNER JOIN s
      ON o.OrderId = s.OrderID
  GROUP BY o.CustomerID
  ORDER BY times_ordered1 DESC, total_spend DESC
  LIMIT 10
)

SELECT 
  od.OrderID,
  o.CustomerID,
  c.CompanyName AS customer_name,
  od.ProductID,
  p.ProductName,
  COUNT(DISTINCT od.OrderID) AS times_ordered
FROM OrderDetails AS od
  INNER JOIN Orders AS o          --to obtain Customer ID
    ON od.OrderID = o.OrderId
  INNER JOIN Products AS p        --to obtain product name
    ON od.ProductID = p.ProductID
  INNER JOIN Customers AS c       --to obtain customer name
    USING (CustomerID)
  INNER JOIN t                    --to filter for top 10 customers, based on times ordered & cumulative spend
    USING (CustomerID)
GROUP BY od.ProductID, o.CustomerID
HAVING times_ordered > 1          --a customer's favorite products = products that they have ordered more than once 
ORDER BY o.CustomerID, times_ordered DESC;

/**
3. Where are our customers mostly located, and how much is the total spend per country? 
**/

With s AS (
  SELECT 
    OrderID,
    ProductID,
    SUM((UnitPrice * Quantity) - Discount) AS spend
  FROM OrderDetails AS od
  GROUP BY OrderID
  ORDER BY OrderID
)

SELECT 
  c.Country, 
  COUNT(DISTINCT c.CustomerID) AS num_customers,
  ROUND(s.spend,1) AS country_spend
FROM Customers AS c
  INNER JOIN Orders as o
    USING(CustomerID)
  INNER JOIN s
    ON o.OrderId = s.OrderID
GROUP BY Country
ORDER BY num_customers DESC, country_spend DESC;

/**
4. What are our top 10 most popular products? 
**/

WITH s AS (	
  SELECT
	od.ProductID,
	COUNT (DISTINCT o.CustomerID) AS popularity
  FROM OrderDetails AS od
	INNER JOIN Orders AS o 
      ON od.OrderID = o.OrderId
  GROUP BY ProductID
  ORDER BY popularity DESC
  LIMIT 10
)

SELECT 
  s.ProductID, 
  s.popularity, 
  p.ProductName
FROM s
 INNER JOIN Products AS p
   ON p.ProductID = s.ProductID
ORDER BY s.popularity DESC;

/**
5. Who are the suppliers for our most popular products? 
**/

WITH s AS (	
  SELECT
	od.ProductID,
	COUNT(DISTINCT o.CustomerID) AS popularity
  FROM OrderDetails AS od
	INNER JOIN Orders AS o 
      ON od.OrderID = o.OrderId
  GROUP BY ProductID
  ORDER BY popularity DESC
  LIMIT 10
)

SELECT 
  s.ProductID, 
  s.popularity, 
  p.ProductName,
  p.SupplierID,
  sp.CompanyName AS supplier
FROM s
  INNER JOIN Products AS p
    USING(ProductID)
  INNER JOIN Suppliers AS sp
    ON p.SupplierID = sp.SupplierID --or USING(SupplierID)
ORDER BY s.popularity DESC;
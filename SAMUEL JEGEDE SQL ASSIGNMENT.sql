
										--SAMUEL JEGEDE
								--samuel.jegededsfe@tech4dev.com
								--SQL ASSIGNMENT

-- QUESTION 1
SELECT CompanyName, Customers.CustomerID, UnitPrice*Quantity AS TOTAL_SALES
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
JOIN OrderDetails ON Orders.OrderId = OrderDetails.OrderID
GROUP BY Customers.CustomerID
ORDER BY TOTAL_SALES DESC
LIMIT 10

-- QUESTION 2
SELECT CompanyName, Customers.CustomerID, OrderDetails.UnitPrice*Quantity AS TOTAL_SALES, OrderDetails.ProductID, ProductName AS FAV_PRODUCT
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
JOIN OrderDetails ON Orders.OrderId = OrderDetails.OrderID
JOIN Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY Customers.CustomerID
ORDER BY TOTAL_SALES DESC
LIMIT 10

--QUESTION 3
SELECT Country, count(COUNTRY) AS CUSTOMER_COUNT, OrderDetails.UnitPrice*Quantity AS TOTAL_SALES
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
JOIN OrderDetails ON Orders.OrderId = OrderDetails.OrderID
GROUP BY Country
ORDER BY CUSTOMER_COUNT DESC

--QUESTION 4
SELECT OrderDetails.ProductID, ProductName, COUNT(ORDERDETAILS.PRODUCTID) AS NUMBER_SOLD
FROM OrderDetails
JOIN Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY OrderDetails.ProductID
ORDER BY NUMBER_SOLD DESC
LIMIT 10


--QUESTION 5
SELECT OrderDetails.ProductID, ProductName, COUNT(ORDERDETAILS.PRODUCTID) AS NUMBER_SOLD, CompanyName AS SUPPLIER
FROM OrderDetails
JOIN Products ON OrderDetails.ProductID = Products.ProductID
JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID
GROUP BY OrderDetails.ProductID
ORDER BY NUMBER_SOLD DESC


--QUESTION 6
SELECT Employees.EmployeeID, FirstName, LastName, OrderDetails.UnitPrice*Quantity AS TOTAL_SALES
FROM Employees
JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
JOIN OrderDetails ON Orders.OrderId = OrderDetails.OrderId
GROUP BY Employees.EmployeeID
ORDER BY TOTAL_SALES DESC
LIMIT 15

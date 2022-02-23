--summary of Products
 
 SELECT * 
 FROM Products;
 SELECT MAX(UnitPrice) AS maxUnitPrice 
 FROM Products;
 SELECT MIN(UnitPrice) AS minUnitPrice
 FROM Products;
SELECT AVG(UnitPrice) AS AveragePrice FROM Products;
SELECT COUNT(ProductID) From Products;
SELECT SUM(UnitsInStock) AS StockCount FROM Products;
SELECT COUNT(DISTINCT(SupplierID)) As uniqueSuppliers FROM Products;
SELECT ProductName,UnitPrice,UnitsInStock FROM Products ORDER BY UnitPrice DESC LIMIT 10;


--QUESTION 1
--TOP 10 CUSTOMERS 
SELECT Customers.CompanyName AS Name, SUM((OrderDetails.UnitPrice*Quantity)-Discount) As TotalSpend, COUNT (Orders.CustomerID) AS NumOrders
FROM Customers JOIN Orders on Customers.CustomerID = Orders.CustomerID 
JOIN OrderDetails on Orders.OrderId = OrderDetails.OrderID
GROUP BY Customers.CustomerID
ORDER BY TotalSpend 
DESC 
LIMIT 10;

--QUESTION 2
--TOP CUSTOMERS FAVORITE Product
SELECT Customers.CompanyName ,SUM((OrderDetails.UnitPrice*Quantity)-Discount) AS TotalSpend , Products.ProductName
FROM Customers JOIN Orders on Customers.CustomerID = Orders.CustomerID 
JOIN OrderDetails on Orders.OrderId = OrderDetails.OrderID
JOIN Products on OrderDetails.ProductID=Products.ProductID
GROUP BY Customers.CustomerID
ORDER BY TotalSpend 
DESC;


--QUESTION 3
--LOCATION OF OUR CUSTOMERS 
SELECT Customers.Country AS Country, SUM((OrderDetails.UnitPrice*Quantity)-Discount) AS TotalSpend
FROM Customers JOIN Orders on Customers.CustomerID = Orders.CustomerID 
JOIN OrderDetails on Orders.OrderId = OrderDetails.OrderID
GROUP BY Customers.CustomerID
ORDER BY TotalSpend;


--QUESTION 4
--TOP 10 MOST POPULAR Products
SELECT Products.ProductName AS Name , SUM((OrderDetails.UnitPrice*Quantity)-Discount) AS TotalSpend
FROM Products JOIN OrderDetails on Products.ProductID=OrderDetails.ProductID
GROUP BY Products.ProductID
ORDER BY TotalSpend
DESC
LIMIT 10;


--QUESTION 5
--SUPPLIERS FOR TOP PRODUCTS
SELECT Products.ProductName AS Name , SUM((OrderDetails.UnitPrice*Quantity)-Discount) AS TotalSpend,Suppliers.CompanyName AS Supplier
FROM Products JOIN OrderDetails on Products.ProductID=OrderDetails.ProductID
JOIN Suppliers on Suppliers.SupplierID=Products.SupplierID
GROUP BY Products.SupplierID
ORDER BY TotalSpend
DESC
LIMIT 10;


--QUESTION 6
--TOP 15 BEST PERFORMED EMPLOYEES
SELECT Employees.FirstName, Employees.LastName, COUNT(Orders.EmployeeID) AS NumSales
FROM Employees JOIN Orders on Orders.EmployeeID=Employees.EmployeeID
GROUP BY Employees.EmployeeID
ORDER BY NumSales
DESC
LIMIT 15;



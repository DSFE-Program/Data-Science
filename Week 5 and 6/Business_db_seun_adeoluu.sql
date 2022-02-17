SELECT COUNT (CustomerID), country, City
FROM Customers
GROUP BY Country
ORDER BY CustomerID;


-- QUESTION 1

SELECT 

	  CustomerID, od.OrderId, ProductID, Quantity, UnitPrice,

	  quantity*unitprice AS TotalSpend	

FROM  OrderDetails od

JOIN  Orders o 

ON    od.orderid = o.orderid 

ORDER BY TotalSpend DESC

LIMIT 10;



-- QUESTION 2



SELECT o.OrderId, o.CustomerID, p.ProductID, QuantityPerUnit, p.UnitPrice, 

	  QuantityPerUnit*p.UnitPrice AS TotalSpend

FROM  Orders o

JOIN  OrderDetails od

ON    o.orderid=od.OrderId

JOIN  Products p 

ON    p.ProductID=od.ProductID

ORDER BY TotalSpend DESC

LIMIT 10;



-- QUESTION 3

SELECT COUNT (c.CustomerID) AS NumCustomers, 

			 c.Country, o.OrderId, 

			 c.CustomerID, UnitPrice, Quantity,

			 UnitPrice*Quantity AS TotalSpendPerCountry	

FROM Customers c

JOIN Orders o

ON o.CustomerID = c.CustomerID

JOIN OrderDetails od

ON o.OrderId = od.OrderId

GROUP BY Country 

Order BY NumCustomers  DESC;

 

-- QUESTION 4

SELECT p.ProductID, p.UnitPrice, Quantity

FROM Products p

JOIN OrderDetails od

ON   p.ProductID=od.ProductID

ORDER BY Quantity DESC

LIMIT 10;



-- QUESTION 5 

SELECT p.ProductID, p.UnitPrice, Quantity, SupplierID

FROM Products p

JOIN OrderDetails od

ON p.ProductID=od.ProductID

ORDER BY Quantity DESC

LIMIT 10;



-- QUESTION 6

SELECT e.EmployeeID, 

	   e.FirstName, 

	   e.LastName,

	   o.OrderId, 

	   od.UnitPrice, 

	   od.quantity,  

	UnitPrice*Quantity AS TotalSales

FROM Orders o 

JOIN employees e 

ON o.EmployeeID=e.EmployeeID

JOIN OrderDetails od

ON od.OrderId=o.OrderId

ORDER BY TotalSales DESC

LIMIT 15;





 





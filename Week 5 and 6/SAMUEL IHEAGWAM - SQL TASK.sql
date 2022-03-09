--Q1: Who are our top 10 customers and how much have they spent and ordered?
select SUM(UnitPrice * Quantity) AS OrderPrice, SUM(Quantity) AS OrderQuantity, od.OrderId, o.CustomerID, c.CompanyName
from OrderDetails od
left join Orders o
on od.OrderId = o.OrderId
left join Customers c
on  o.CustomerID = c.CustomerID
group by od.OrderId
order by OrderPrice desc
limit 10;

--Q2: What are our top customers’ favorite products?
with top_customers as (select  q1.OrderId from
(select  od.OrderId, SUM(UnitPrice * Quantity) AS OrderPrice, SUM(Quantity) AS OrderQuantity, o.CustomerID
from OrderDetails od
left join Orders o
on od.OrderId = o.OrderId

group by od.OrderId
order by OrderPrice desc
limit 10) q1 )
select od2.OrderId, od2.ProductID, od2.Quantity, od2.OrderId, p.ProductName from OrderDetails od2
join top_customers  tc
on od2.OrderId = tc.OrderId
join products p
on p.ProductID = od2.ProductID
order by Quantity desc;

--Q3: Where are our customers mostly located, and how much is the total spend per country?
Select c.Country As Country, count(c.CustomerID) As NumberOfCustomers, sum(od.UnitPrice*Quantity) As TotalSpend
from Customers c join Orders o on c.CustomerID = o.CustomerID
join OrderDetails od on o.OrderId = od.OrderID
group by c.Country
order by NumberOfCustomers desc;

--Q4: What are our top 10 most popular products?
select od.ProductID, p.ProductName As Product, count(o.OrderID) As NumberOfOrders
from Products p join OrderDetails od On p.ProductID = od.ProductID
join Orders o On od.OrderId = o.OrderId
group by p.ProductName
order by NumberOfOrders desc
limit 10;

--Q5: Who are the suppliers for our most popular products?
select od.ProductID, p.ProductName As Product, count(o.OrderID) As NumberOfOrders, s.CompanyName As Supplier
from Products p join OrderDetails od On p.ProductID = od.ProductID
join Orders o On od.OrderId = o.OrderId
join Suppliers s On p.SupplierID = s.SupplierID
group by p.ProductName
order by NumberOfOrders desc
limit 10;

--Q6: Who are our top 15 best performed Employees? 
select Employees.EmployeeID, Employees.FirstName, Employees.LastName, count( Orders.EmployeeID) As NumberOfSales
from Employees join Orders On Employees.EmployeeID = Orders.EmployeeID
group by Employees.EmployeeID
order by NumberOfSales desc;


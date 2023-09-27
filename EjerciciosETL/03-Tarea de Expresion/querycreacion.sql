use NORTHWND

use datamat1
select * 
into datamat1.dbo.DCustomer
from NORTHWND.dbo.Customers
where 1 = 0;

select * from datamat1.dbo.DCustomer

select * 
into datamat1.dbo.DShippers
from NORTHWND.dbo.Shippers
where 1 = 0;

select * from datamat1.dbo.DShippers

select * 
into datamat1.dbo.DOrders
from NORTHWND.dbo.Orders
where 1 = 0;

select * from datamat1.dbo.DOrders


select * from DCustomer

--Agregar la restriccion de primary key a la tabla Dcustomers

alter table datamat1.dbo.DCustomer
add constraint pk_DCustomer
primary key (customerId)

--Agregar la restriccion de primary key de la tabla shipper

alter table datamat1.dbo.DShippers
add constraint pk_DShippers
primary key (shipperId)

--Agregar la restriccion de primary key de la tabla Orders

alter table datamat1.dbo.DOrders
add constraint pk_DOrders
primary key (OrderId)


-- Agregar la restriccion de foreign key de la tabla dorders
alter table datamat1.dbo.DOrders
add constraint fk_DOrders
foreign key (ShipVia) 
REFERENCES datamat1.dbo.DShippers (shipperId)

-- Agregar la restriccion de foreign key de la tabla dorders
alter table datamat1.dbo.DCustomer
add constraint fk_DOrders_DCustomer
foreign key (CustomerID) 
references datamat1.dbo.DCustomer (customerId)

--De esta manera se elimina una restriccion (constraint)
alter table datamat1.dbo.DCustomer
drop constraint fk_DOrders_DCustomer


alter table datamat1.dbo.DOrders
add constraint fk_DOrders_dcustomers
foreign key (customerId)
references datamat1.dbo.dcustomer (customerId)


--Subconsulta de tabla y reporte de vista 

create view ReporteVentas
as
select o.OrderID, o.OrderDate,
o.EmployeeID, e.FullName, c.CompanyName, 
c.City, c.Country, od.Quantity, od.UnitPrice, od.Discount,
od.Mount, p.ProductName
from Orders as o
inner join(
select employeeid, 
CONCAT(FirstName,' ',LastName) 
as FullName
from Employees
)as e
on o.EmployeeID = e.EmployeeID
inner join(select CompanyName, City, Country, CustomerID 
from customers 
)as c
on o.CustomerID=c.CustomerID
inner join (
select UnitPrice, Quantity, Discount, 
(UnitPrice*Quantity)as
Mount, OrderID,ProductID
from [Order Details] 
) as od
on o.OrderID = od.OrderID
inner join(
select ProductID, ProductName from Products
)as p
on od.ProductID = p.ProductID


select * from ReporteVentas
where ProductName = 'Queso Cabrales'













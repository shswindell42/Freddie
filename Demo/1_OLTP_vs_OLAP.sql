-----------------------------------------------------------------------
-- OLTP vs OLAP
-- Showcase the simplicty of quering an OLAP system vs and OLTP system
-- Built to run against both WideWorldImportersDW and WideWorldImporters 
------------------------------------------------------------------------
USE WideWorldImportersDW
GO


--- DW Query 
select c.[Sales Territory]
	,SUM([Total Excluding Tax]) as TotalSales
from [Fact].[Order] f
	inner join [Dimension].City c
		on f.[City Key] = c.[City Key]
	inner join Dimension.Date d
		on f.[Order Date Key] = d.Date
where d.[Fiscal Year Label] = 'FY2016'
group by c.[Sales Territory]
order by TotalSales desc

-- Application Query
select s.SalesTerritory
	,sum(ol.UnitPrice * ol.Quantity) as TotalSale
from WideWorldImporters.Sales.Orders o
	inner join WideWorldImporters.Sales.OrderLines ol
		on o.OrderID = ol.OrderID
	inner join WideWorldImporters.Sales.Customers cust
		on cust.CustomerID = o.CustomerID
	inner join WideWorldImporters.Application.Cities c
		on cust.DeliveryCityID = c.CityID
	inner join WideWorldImporters.Application.StateProvinces s
		on c.StateProvinceID = s.StateProvinceID
where o.OrderDate BETWEEN '2015-07-01' and '2016-06-30'
group by s.SalesTerritory
order by TotalSale desc



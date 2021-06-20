/* 1.	������� ������, ������� ���������� ������� ���������� ����������� ����� � ������ ���������� ����������� ����� �� ������� ����-������������ ��������. ������� HumanResources.Employee. ����������� ���������� ������� AVG() � SUM().*/

SELECT AVG(SickLeaveHours) AS AVG_SickLeaveHours
	,SUM(SickLeaveHours) AS SUM_SickLeaveHours
	FROM HumanResources.Employee
WHERE JobTitle LIKE 'vice%';

/* 2.	������� ������, ������� ������������ ���������� ����������. ������� HumanResources.Employee. ����������� ���������� ������� COUNT().*/

SELECT COUNT(BusinessEntityID) 
FROM HumanResources.Employee;

/* 3.	�������� ������ � ������� Person.Address, �������������� ����� ���������� �����������, � ������� ���� AddressLine2 ����� �������� NULL. ����������� ���������� ������� COUNT() � ISNULL().*/

SELECT COUNT(ISNULL(AddressLine2, '0')) AS address_not_null
FROM Person.Address
WHERE AddressLine2 != '0';

/* 4.	�������� ������ ��� ����, ����� ��������� �������� NULL. ������� ������, ������� ���������� ����� �� ��������, ��� � ���������� ������, ��, �� �������� �� �������� �������� NULL. ����������� ���������� ������� COUNT(). �������, ��� ������� ����� ������������ �������� NULL.*/

SELECT COUNT(AddressLine2) AS address_not_null
FROM Person.Address

/* 1.	������� � ��������� ������ ��� �������� �������� ����� ���� �� ������������ ������ (DaysToManufacture). ������ ������ ���������� ProductID � ������� ���������� ���� �� ������� Production.Product. ����������� ���������� ������� AVG().*/

SELECT AVG(DaysToManufacture) AS AVGDays, ProductID FROM Production.Product
GROUP BY ProductID

/* 2.	������� � ��������� ������, ������������ ��������� ����� (Color) � ������� �������� ���� (ListPrice) ���������� ��������. ����������� �������� GROUP BY � �������� WHERE ��� ������ ������� �������� (ProductNumber = �FR-R72R-58�) (������� Production.Product).*/

SELECT AVG(ListPrice) AS avgList
	,Color
FROM Production.Product
WHERE ProductNumber = 'FR-R72R-58'
GROUP BY Color

/* 3.	������� ������, ������������ ProductID, ������� ���������� ������� (OrderQty) � ����� ����� ����� (LineTotal) ��� ������� ��������, ��� ����� ����� ����� ����������� 1000000$ � ������� ���������� ������� ������ 3. ����������� �������� GROUP BY ��� ����������� �������� �������� �������� � �������� HAVING ��� ����������� �������� ������ (������� Sales.SalesOrderDetail).*/

SELECT SUM(LineTotal) AS sumLine, AVG(OrderQty) AS avgOrder, ProductID 
FROM Sales.SalesOrderDetail 
GROUP BY ProductID 
HAVING SUM(LineTotal) > 1000000 AND AVG(OrderQty) < 3


/* 4.	������� � ��������� ������, �������������� ����� ���������� ������ (Quantity) �� ������ ����� (Shelf) ��� ������� �������� (ProductID). ����������� �������� GROUP BY ������ � ���������� ROLLUP (������� Production.ProductInventory).*/

SELECT Shelf
	,ProductID
	,SUM(Quantity) AS sumQuantity
FROM Production.ProductInventory
GROUP BY ROLLUP (Shelf, ProductID)


/* 5.	������� � ��������� ������, ������������ �������� ������: ������� ������, ������� ��������� ���������� �� ����� ������� (OrderQty) �� ������� Sales.SalesOrderDetail, ��������� �������� CUBE;*/

SELECT ProductID, SUM(OrderQty) AS sum_order
FROM Sales.SalesOrderDetail
GROUP BY CUBE (ProductID)


/* 6.	�������� ������, ��������� � ������� ���������� ������� �� ����� �� ����������� �������:
a.	������� ������, ������� ���������� ����� ������ (SalesQuota) � ���������������� ������� (SalesYTD) �� ������� Sales.SalesPerson, ��������� �������� CUBE;
*/


SELECT SalesQuota,
	SUM(SalesYTD) AS sum_Quota
	FROM Sales.SalesPerson
GROUP BY CUBE (SalesQuota)

/* b.	����������� �������� GROUPING ������ � ���������� CUBE, ����� �������� �������, � ������� �� ����������� ���������� �������.*/

SELECT BusinessEntityID ,SalesQuota,
	SUM(SalesYTD) AS sum_Quota
	FROM Sales.SalesPerson
GROUP BY GROUPING SETS (CUBE (BusinessEntityID), SalesQuota)

/* 7.	������� ����� �������� �������� � �������������� ������� GROUPING:
a.	������� ������, ������� ��������� ���������� (������� Quantity) �� ������� Production.ProductInventory � �������������� ���������� CUBE � GROUPING;
b.	�������� CUBE ������ ���� ����������� �� ���������� ��������, �������� GROUPING ������������ � ����� �� ������������ ��������.
*/

SELECT SUM(Quantity) AS sumQuantity 
	,ProductID 
	,LocationID 
FROM Production.ProductInventory 
GROUP BY GROUPING SETS (CUBE (ProductID, LocationID), LocationID)

/* 1.	������������� ������ �� ������� �������� � ������� �������� ������ (SalesYTD). �������� ������� SalesYTD � BusinessEntityID. ��� ���������� ������� ���������� ��������� ��������� ����:
a)	�������� ������, ������������ ��������������� ������ �� ������� Sales.SalesPerson.
b)	����������� ������� ROW_NUMBER, ����������� ������� ����������;
c)	������������� ��������� ��� �������� ��������� � ������� ������������ (TerritoryID) � �������� ��������� (SalesYTD).
*/

SELECT ROW_NUMBER() OVER (ORDER BY SalesYTD DESC) AS N
	,SalesYTD
	,BusinessEntityID
FROM Sales.SalesPerson
WHERE TerritoryID IS NOT NULL AND SalesYTD > 0

/* 2.	������� � ��������� ������ ������, ������������ ������� RANK. ��� ���������� ������� ���������� ��������� ��������� ����:
a)	�������� ������, ������������ �� ������� ProductInventory ��������������� ������ � ������� ���������� ���������� (Quantity) ��� ������� ������������ (LocationID) ��������;
b)	����������� ������� RANK, ������������ ������� ����������. �������� ������� ProductID, LocationID � Quantity.
*/

SELECT RANK() OVER (PARTITION BY Quantity ORDER BY LocationID) AS N 
,ProductID 
,LocationID 
,Quantity 
FROM Production.ProductInventory


/* 3.	������� � ��������� ������ ������, ������������ ������� DENSE_RANK (��������� ���������� �����).*/

SELECT DENSE_RANK() OVER (PARTITION BY Quantity ORDER BY LocationID) AS N 
,ProductID 
,LocationID 
,Quantity 
FROM Production.ProductInventory

/*4.	������� �����, ���������� ��������� ���������� � ��������� (BusinessEntityID) �� ������ ������� ������ (SalesYTD), ��������������� � ������� ��������, � ����� ��������������� �� ������� ����������. ��� ���������� ������� ���������� ��������� ��������� ����:
a)	�������� ������, ������������ ��������������� ������ �� ������� Sales.SalesPerson;
b)	��� ������������� �� ��������� ����������� ������� NTILE, ��������� ����������� � ������� �������� ������� ������ (SalesYTD);
c)	������������ ���������, ������ ��������� � ������� ������������ � �������� ���������.

*/

SELECT NTILE(5) OVER (ORDER BY SalesYTD) AS N
	,SalesYTD 
	,TerritoryID 
	,SalesQuota 
	FROM Sales.SalesPerson 
WHERE TerritoryID IS NOT NULL AND SalesQuota IS NOT NULL


/* 1.	�������� ����������� ��������������� ��������� (PlannedCost)*/

SELECT MAX(PlannedCost) AS maxCost
FROM Production.WorkOrderRouting

/* 2.	�������� ������������ ������� ����� ��������������� � ���������� ���������� (ActualCost), ������� ����.*/

SELECT (MAX(PlannedCost) - MIN(ActualCost))  AS maxPlannedCost
FROM Production.WorkOrderRouting

/* 3.	�������� ����� ��������� ���������� ��������������� ����� (ActualResourceHrs) ��� ������ ��������� (LocationID).*/

SELECT LocationID
	,SUM(ActualResourceHrs) AS sumActual
FROM Production.WorkOrderRouting
GROUP BY LocationID

/* 4.	�������� ���������� ������ � ������������ ��������������� � ���������� ����������.*/

SELECT COUNT(ProductID) AS countPr FROM Production.WorkOrderRouting
WHERE PlannedCost != ActualCost

/* 5.	��� ������ ��������� ����� ��������� ���������� ��������������� ���� (������� � ���� SheduledStartDate � SheduledEndDate) �� ������ � �������.*/

SELECT 
	ProductID
	,SUM(DATEDIFF(DAY, ScheduledStartDate, ScheduledEndDate)) AS days
FROM Production.WorkOrderRouting
GROUP BY ProductID

/* 6.	��� ������� ������ ����� ��������� ���������� ��������������� � ���������� ���� (ActualStartDate � ActualEndDate) �� ������ � �������.*/

SELECT
	ProductID
	,SUM(DATEDIFF(DAY, ScheduledStartDate, ScheduledEndDate)) AS daysSch
	,SUM(DATEDIFF(DAY, ActualStartDate, ActualEndDate)) AS daysActual
FROM Production.WorkOrderRouting
GROUP BY ProductID

/* 7.	�������� ������ (ProductID), ��� ������� ��������� ���������� ��������������� ���� ������, ��� ���������� ���������� ����.*/

SELECT
	ProductID
	,SUM(DATEDIFF(DAY, ScheduledStartDate, ScheduledEndDate)) AS daysSch
	,SUM(DATEDIFF(DAY, ActualStartDate, ActualEndDate)) AS daysActual
FROM Production.WorkOrderRouting
GROUP BY ProductID
HAVING SUM(DATEDIFF(DAY, ScheduledStartDate, ScheduledEndDate)) < SUM(DATEDIFF(DAY,ActualStartDate, ActualEndDate))


/* 8.	�������� ������, ��� ������� ��������� ���������� ��������������� ���� ������, ��� ���������� ���������� ����, ��� �������, ��� ���������� ��������������� ����� �� ������ 4.*/

SELECT
	ProductID
	,SUM(DATEDIFF(DAY, ScheduledStartDate, ScheduledEndDate)) AS daysSch
	,SUM(DATEDIFF(DAY, ActualStartDate, ActualEndDate)) AS daysActual
FROM Production.WorkOrderRouting
WHERE DATEDIFF(HOUR, ScheduledEndDate, ScheduledEndDate) >= 4
GROUP BY ProductID
HAVING SUM(DATEDIFF(DAY, ScheduledStartDate, ScheduledEndDate)) < SUM(DATEDIFF(DAY,ActualStartDate, ActualEndDate))

/* 9.	�������� ���������� ������ (ProductID), ��� �������� ��������� ���������� ��������������� �����.
������ � �������� Purshasing.ProductVendor

*/
SELECT
	AverageLeadTime
	,COUNT(ProductID) AS countProduct
FROM Purchasing.ProductVendor
GROUP BY AverageLeadTime

/* 10.	��� ������� �������� (BusinessEntityID) ����� ��������� ����� (AverageLeadTime), ��� �������, ��� ����������� ���� (StandartPrice) � ��������� (LastReceiptCost) �� ���������� ����� ��� �� 20%.*/

SELECT 
	BusinessEntityID 
	,SUM(AverageLeadTime) AS sumAver
FROM Purchasing.ProductVendor
WHERE (100 - StandardPrice * 100 / LastReceiptCost) <= 20
GROUP BY BusinessEntityID

/* 11.	�������� ����� (ProductID), � �������� ������������ ������� � ����������� ���� (StandartPrice) � ��������� (LastReceiptCost) ���������� ����� ��� �� 10%.*/

SELECT 
	ProductID 
	--,SUM(AverageLeadTime) AS sumAver
FROM Purchasing.ProductVendor
WHERE (100 - StandardPrice * 100 / LastReceiptCost)  > 10
GROUP BY ProductID

/* 12.	��� ������� ������ (ProductID) �������� ������������ ������� ���� (StandartPrice) � ��������� (LastReceiptCost).*/

SELECT 
	ProductID
	,MAX(StandardPrice) - MIN(LastReceiptCost) AS diff
FROM Purchasing.ProductVendor
GROUP BY ProductID

/* 13.	�������� �������� (BusinessEntityID), ������������ ����� 3 ��������� (ProductID).*/

SELECT 
	BusinessEntityID
FROM Purchasing.ProductVendor
WHERE ProductID > 3

/* 14.	��� ������� ������ (ProductID) �������� ������������ ������� ������������ (MinOrderQty)  � ������������� ���������� (MaxOrderQty) ������, ���� ��� ���������� ������ 100 � ����� (AverageLeadTime) ������ 17.
*/
SELECT 
	ProductID
	,MAX(MaxOrderQty-MinOrderQty) AS maxDiff
FROM Purchasing.ProductVendor
WHERE AverageLeadTime > 17
GROUP BY ProductID
HAVING MAX(MaxOrderQty-MinOrderQty) > 100


/* 15.	�������� ��������� ���������� ����������� ������ (OnOrderQty) ������ ��������� �� ������� 25 �������� 2004 (LastReceiptDate).*/

SELECT 
	ProductID
	,SUM(OnOrderQty) AS sumOrder
FROM Purchasing.ProductVendor
WHERE LastReceiptDate > '20040925'
GROUP BY ProductID
HAVING SUM(OnOrderQty) IS NOT NULL




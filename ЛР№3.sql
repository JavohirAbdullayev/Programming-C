--������� ������, ������� ������ ������� 
--LoginID �� ������� HumanResources.Employee, ��������� �� �������� BusinessEntityID 
--(INNER JOIN ������ HumanResources.Employee � Sales.SalesPerson �� ������� BusinessEntityID).

SELECT Em.LoginID
FROM HumanResources.Employee Em
INNER JOIN Sales.SalesPerson Pr
ON Em.BusinessEntityID = Pr.BusinessEntityID

--������� LEFT OUTER JOIN, ������� ���������� ������� Product � ProductReview, �� ������� ProductID;

SELECT P.ProductID ,P.[Name] ,P.Color ,Pr.ReviewerName
FROM Production.Product P
LEFT OUTER JOIN Production.ProductReview Pr
ON P.ProductID = Pr.ProductID

--������� RIGHT OUTER JOIN, ������� ���������� ������� SalesTerritory � SalesPerson, �� ������� TerritoryID.

SELECT Sl1.TerritoryID ,Sl1.[Name] ,Sl2.BusinessEntityID
FROM Sales.SalesTerritory Sl1
RIGHT JOIN Sales.SalesPerson Sl2
ON Sl1.TerritoryID = S2.TerritoryID


--1. ������� � ��������� ������, ��������� SELF JOIN.
--������� ������, ������� ���������� ������ ���� ��������� �� ������� Purchsing.ProductVendor, ������� ������������ ����������.
--����������� SELF JOIN � ����������� ���������� � ������� ProductID.
--������� ���������, ��������� �������� DISTINCT.

SELECT DISTINCT Pr1.ProductID ,Pr1.[BusinessEntityID] ,V.[Name] ,P1.[Name]
FROM Purchasing.ProductVendor Pr1
INNER JOIN Purchasing.ProductVendor Pr2
ON Pr1.ProductID = Pr2.ProductID
INNER JOIN Production.Product P1
ON Pr1.ProductID = P1.ProductID
INNER JOIN Purchasing.Vendor V
ON Pr1.BusinessEntityID = V.BusinessEntityID
WHERE Pr1.BusinessEntityID <> Pr2.BusinessEntityID
ORDER BY Pr1.ProductID

--2. ������� � ��������� ������, ��������� SELF JOIN.
--�������� ������ ������, ������� ������� ���� � ���������� � ������������.

SELECT DISTINCT Pr1.ProductID
	,Pr1.[BusinessEntityID]	
	,V.[Name]
	,P1.[Name]
FROM Purchasing.ProductVendor Pr1
INNER JOIN Purchasing.ProductVendor Pr2
ON Pr1.ProductID <> Pr2.ProductID
INNER JOIN Production.Product P1
ON Pr1.ProductID <> P1.ProductID
INNER JOIN Purchasing.Vendor V
ON Pr1.BusinessEntityID <> V.BusinessEntityID
WHERE Pr1.BusinessEntityID = Pr2.BusinessEntityID
ORDER BY Pr1.ProductID

--3. ������� � ��������� ������ �� ����-����������, ������������ ��������� ��������� � �����������.
--�������� ������, ������� ���������� ������ ���� ��������� ���������, ������� �� ������ ���� ��������� ���, ������� 15$.
--����������� INNER JOIN, ����� ��������� Production.Product ���� � ����� � �������� ��� ����� �� ������� ListPrice, ����� ������� ��� ��������� ����.

SELECT DISTINCT P1.ProductID
	,P1.ProductSubcategoryID
	,P1.ListPrice
FROM Production.Product P1
INNER JOIN Production.Product P2
ON P1.ProductSubcategoryID = P2.ProductSubcategoryID
WHERE P1.ListPrice < 15
AND P1.ListPrice <> P2.ListPrice

--1. ���������� �������������� ������ ������ ���� ��������, ��������� �������� UNION ALL.
--�������� ������, ������������ ����������� ������ ���� �������� �� ������ TableA � TableB. �� ������������� ���������� ������� �������� �����������.

SELECT * FROM TableA
UNION ALL
SELECT * FROM TableB


--2. ���������� �������������� ������ ������, ��������� �������� EXCEPT.
--�������� ������, ��������� �������� EXCEPT, ����� ������� ������ ��� ������� �� ������� Production.Product, ������� ��� � ������� Production.WorkOrder.

SELECT Pr1.ProductID, Pr1.[Name] FROM Production.Product Pr1
EXCEPT
SELECT Pr2.ProductID, '1' AS One FROM Production.WorkOrder Pr2


--3. ���������� �������������� ������ ������, ��������� �������� INTERSECT � ��������� SELECT.
--������ ���������� ������ 2, �� � ����������� ��������� INTERSECT.

SELECT P.ProductID, P.[Name] FROM Production.Product P
INTERSECT
SELECT Pr.ProductID, '1' AS One FROM Production.WorkOrder Pr


--4. ���������� ��������������� ������ ������, ��������� ��������� TOP � TABLESAMPLE.
--�������� ������, ������������ ������ 15% ������ ��������� �� ������� Production.Product, ���������� �� ������� ProductID.

SELECT * FROM Production.Product
TABLESAMPLE (15 PERCENT)
ORDER BY ProductID


--�������� ������, ������� ���������� ������ � ��������� ������� 10% ����� �� ������� Person.Person, ���������� ��� � �������.

SELECT FirstName, LastName
FROM Person.Person
TABLESAMPLE (10 PERCENT)
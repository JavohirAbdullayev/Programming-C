SELECT p1.[Name], p1.StandardCost FROM Production.Product AS p1
WHERE p1.StandardCost = 
	(
		SELECT MIN(StandardCost) AS minCost FROM Production.Product AS p2
		WHERE p2.StandardCost > 0
	)


	SELECT p1.[Name], p1.Size, SafetyStockLevel FROM Production.Product AS  p1
WHERE p1.SafetyStockLevel = (
SELECT MAX(SafetyStockLevel) FROM Production.Product AS p2)


--3.	�������� ������, ��� ������� ���������� ������ ���� ����� � ����� ����� (����� � ���� ���������) (������� Production.Product). �������� ���� [Name], Style � Color.

SELECT Color, COUNT(DISTINCT Style) CountStle FROM Production.Product
WHERE Color IS NOT NULL
GROUP BY Color
HAVING COUNT(DISTINCT Style) = 1

SELECT p1.[Name], p1.Style, p1.Color FROM Production.Product AS p1
WHERE p1.Color IS NOT NULL AND p1.Style IS NOT NULL
AND (SELECT COUNT(DISTINCT p2.Style) AS CountStle FROM Production.Product AS p2
WHERE p1.Style = p2.Style) = 1


--4.	�������� ������, ���� ������� ����� ����������� (������ ����) ���� ������ ���� �� ������� (������ ���������) (������� Production.Product). �������� ���� [Name], ListPrice � Size.

--SELECT MIN(ListPrice) FROM Production.Product AS p2
--WHERE p2.ListPrice > 0 AND p2.Size IS NOT NULL

SELECT p1.[Name], p1.ListPrice, p1.Size FROM Production.Product AS p1
WHERE p1.Size IS NOT NULL AND  p1.ListPrice = (
SELECT MIN(ListPrice) FROM Production.Product AS p2
WHERE p2.ListPrice > 0 AND p2.Size IS NOT NULL)


-- 5. �������� ������, ���� ������� ������ ������� ���� � ����� ������� ��������� (������� ��������� ����������) (������� Production.Product). �������� ���� [Name], ListPrice � ProductLine.
SELECT [Name], ListPrice, ProductLine FROM Production.Product
WHERE ListPrice > ALL (SELECT AVG(ListPrice) FROM Production.Product
GROUP BY ProductLine)


/*
1)	�������� ��� ������ �� ������� Person.Person.*/
SELECT * FROM Person.Person

/*
 �������� ��� ������ �� ������� Person.Person. �������� ������ ���� FirstName, LastName � MiddleName.*/

 SELECT FirstName, LastName, MiddleName FROM Person.Person


 /*
 �������� �������, ��������� �������� ���������. �������� ��� ������, ���� (ListPrice) ������� ������ $100 �� ������� Production.Product, �������� ������ ���� ProductNumber, Name, ListPrice, Color, Size � Weight.*/

 SELECT ProductNumber
	   ,Name
	   ,ListPrice
	   , Color
	   ,Size
	   ,Weight
FROM Production.Product
WHERE ListPrice < 100

/* 2)	�������� �������, ������������� ��������� AND � LIKE. �������� � ��������� ����������� ������� ����������� �� ������� ProductNumber. �������� ������ �� ������, ������� ���������� �� SO.*/

SELECT ProductNumber
	   ,Name
	   ,ListPrice
	   ,Color
	   ,Size
	   ,Weight
FROM Production.Product
WHERE ListPrice < 100 AND ProductNumber LIKE 'SO%'

/* 3)	�������� ������� � ���������� OR. �������� ���������� ������, ������� � ���������� ������, ������� TG ��� SO � ���� ProductNumber.*/

SELECT ProductNumber
	   ,Name
	   ,ListPrice
	   ,Color
	   ,Size
	   ,Weight
FROM Production.Product
WHERE ListPrice < 100 AND (ProductNumber LIKE 'SO%' OR ProductNumber LIKE 'TG%')

/* �������� ������� � ���������� BETWEEN. �������� ������, ������� SO � ���� ProductNumber ��� ������ ������ tights (TG) � ����� �� $50 �� $180.*/

SELECT ProductNumber
	   ,Name
	   ,ListPrice
	   ,Color
	   ,Size
	   ,Weight
FROM Production.Product
WHERE (ProductNumber LIKE 'SO%' OR ProductNumber LIKE 'TG%')
		AND ListPrice BETWEEN 50 AND 180

		/* �������� ������� � �������������� ��������� IN. � ����� ������� �������� ������� �� ����� ������ �������� (tights (TG)) � ��������� �������� M � L. */

		SELECT ProductNumber
	   ,Name
	   ,ListPrice
	   ,Color
	   ,Size
	   ,Weight
FROM Production.Product
WHERE   ProductNumber LIKE 'TG%'
		AND ListPrice BETWEEN 50 AND 180
		AND Size IN ('M', 'L')

		/* �������� ������� � ������� Production.Product, ������������ ������� ������ �� ����� ProductNumber, Name � Weight, � ������� ProductLine �������� (NOT NULL).*/

		SELECT ProductNumber, Name, Weight FROM Production.Product
WHERE ProductLine IS NOT NULL

/* ) �������� ���������� ������, ������� ������ � ������������ ���������� (NULL).*/

SELECT ProductNumber, Name, Weight FROM Production.Product
WHERE ProductLine IS NULL

/* ������� ������, ��������� ��������� SELECT � �������� ISNULL ��� �������������� ��������. ����������� ������� ISNULL, ����� ��� ����������� �������� � ������� ProductLine ���������� �������� �NA�.*/

SELECT ProductNumber, ISNULL(ProductLine, 'NA')
	,Name
	,Weight
FROM Production.Product
WHERE ProductLine IS NULL

/* 4)	�������� ���������� ������ ���, ����� ���� ������ ���������� �Product Line� (��� ����� � ��������).*/

1)	SELECT ProductNumber, ISNULL(ProductLine, 'NA') AS 'Product Line'
	,Name
	,Weight
FROM Production.Product
WHERE ProductLine IS NULL

/* �������� ������ � �������������� ������� COALESCE() � ����������� ������ ���� Measurement ���, �����: 
� ���� �������� �������� � ���� Weight, �� �������� ��� ��������;
� ���� �������� � ���� Weight ����������, �� �������� �������� � ���� Size, �� ���������� ��� ��������;
� � ��������� �������� �������� �������� �NA�. 
*/

SELECT ProductNumber, ISNULL(ProductLine, 'NA') AS 'Product Line'
	,Name
	,Weight
	, COALESCE(CAST([Weight] AS VARCHAR(10)), Size, 'NA') AS Measurement
FROM Production.Product

/* 1)	������� ������ � ������� Production.Product � ������ ProductNumber, Name � Class. �������� ���������� �� ��������� � ���� Class.*/

SELECT ProductNumber
	,Name
	,Class
FROM Production.Product
ORDER BY Class

/* 2)	�������� ���������� ������, ����������� ���� ListPrice. �������� ���������� �� ������ ���� � ������� �������� ����*/


SELECT ProductNumber
	,Name
	,Class
	,ListPrice
FROM Production.Product
ORDER BY ListPrice DESC

/* 3)	������� ������ � ������� Production.Product, ������������ ��� ��������� ����� �������. �������� ������ ���� ������ ��� ������� �����. */

SELECT DISTINCT Color
FROM Production.Product

/* 4)	������� ������ � ������� Person.Person. ������� ����, ������������ �� �������� LastName � FirstName, ����������� ������� � ��������.*/

SELECT CONCAT_WS(', ', FirstName, LastName) AS FullName FROM Person.Person

/* 5)	�������� ���������� ������, ���, ����� ��������� ���� ���������� Contact.*/

SELECT CONCAT_WS(', ', FirstName, LastName) AS Contact FROM Person.Person

/* 6)	���������� ������ ����� �������, ����� ����� �������� �� ���� ������� LastName, ������������ �� �Mac� � �������������� ������� SUBSTRING().*/

SELECT CONCAT_WS(', ', FirstName, LastName) AS Contact 
FROM Person.Person
WHERE SUBSTRING(LastName, 1, 3) = 'Mac'





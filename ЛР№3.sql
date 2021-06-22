--Создать запрос, который выдаст столбец 
--LoginID из таблицы HumanResources.Employee, связанный со столбцом BusinessEntityID 
--(INNER JOIN таблиц HumanResources.Employee и Sales.SalesPerson по столбцу BusinessEntityID).

SELECT Em.LoginID
FROM HumanResources.Employee Em
INNER JOIN Sales.SalesPerson Pr
ON Em.BusinessEntityID = Pr.BusinessEntityID

--Создать LEFT OUTER JOIN, который использует таблицы Product и ProductReview, по столбцу ProductID;

SELECT P.ProductID ,P.[Name] ,P.Color ,Pr.ReviewerName
FROM Production.Product P
LEFT OUTER JOIN Production.ProductReview Pr
ON P.ProductID = Pr.ProductID

--Создать RIGHT OUTER JOIN, который использует таблицы SalesTerritory и SalesPerson, по столбцу TerritoryID.

SELECT Sl1.TerritoryID ,Sl1.[Name] ,Sl2.BusinessEntityID
FROM Sales.SalesTerritory Sl1
RIGHT JOIN Sales.SalesPerson Sl2
ON Sl1.TerritoryID = S2.TerritoryID


--1. Создать и запустить запрос, используя SELF JOIN.
--Создать запрос, который возвращает список всех продуктов из таблицы Purchsing.ProductVendor, которые производятся продавцами.
--Используйте SELF JOIN и расположите результаты в порядке ProductID.
--Удалите дубликаты, используя оператор DISTINCT.

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

--2. Создать и запустить запрос, используя SELF JOIN.
--Измените первую задачу, поменяв местами поля с равенством и неравенством.

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

--3. Создать и запустить запрос на экви-соединение, использующий операторы равенства и неравенства.
--Создайте запрос, который возвращает список всех категорий продуктов, имеющих не меньше двух различных цен, меньших 15$.
--Используйте INNER JOIN, чтобы соединить Production.Product саму с собой и оператор «не равно» на столбце ListPrice, чтобы выбрать две различные цены.

SELECT DISTINCT P1.ProductID
	,P1.ProductSubcategoryID
	,P1.ListPrice
FROM Production.Product P1
INNER JOIN Production.Product P2
ON P1.ProductSubcategoryID = P2.ProductSubcategoryID
WHERE P1.ListPrice < 15
AND P1.ListPrice <> P2.ListPrice

--1. Объединить результирующие наборы данных двух запросов, используя оператор UNION ALL.
--Создайте запрос, возвращающий соединенный список всех столбцов из таблиц TableA и TableB. Не ограничивайте результаты запроса никакими операторами.

SELECT * FROM TableA
UNION ALL
SELECT * FROM TableB


--2. Ограничить результирующие наборы данных, используя оператор EXCEPT.
--Создайте запрос, используя оператор EXCEPT, чтобы вывести список тех товаров из таблицы Production.Product, которых нет в таблице Production.WorkOrder.

SELECT Pr1.ProductID, Pr1.[Name] FROM Production.Product Pr1
EXCEPT
SELECT Pr2.ProductID, '1' AS One FROM Production.WorkOrder Pr2


--3. Ограничить результирующие наборы данных, используя оператор INTERSECT в выражении SELECT.
--Задача идентичная задаче 2, но с применением оператора INTERSECT.

SELECT P.ProductID, P.[Name] FROM Production.Product P
INTERSECT
SELECT Pr.ProductID, '1' AS One FROM Production.WorkOrder Pr


--4. Ограничить результирующего набора данных, используя операторы TOP и TABLESAMPLE.
--Создайте запрос, показывающий первые 15% списка продуктов из таблицы Production.Product, записанных по порядку ProductID.

SELECT * FROM Production.Product
TABLESAMPLE (15 PERCENT)
ORDER BY ProductID


--Создайте запрос, который генерирует список в случайном порядке 10% людей из таблицы Person.Person, включающий имя и фамилию.

SELECT FirstName, LastName
FROM Person.Person
TABLESAMPLE (10 PERCENT)
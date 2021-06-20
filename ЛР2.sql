/* 1.	Создать запрос, который возвращает среднее количество пропущенных часов и полное количество пропущенных часов по болезни вице-президентами компании. Таблица HumanResources.Employee. Используйте агрегатные функции AVG() и SUM().*/

SELECT AVG(SickLeaveHours) AS AVG_SickLeaveHours
	,SUM(SickLeaveHours) AS SUM_SickLeaveHours
	FROM HumanResources.Employee
WHERE JobTitle LIKE 'vice%';

/* 2.	Создать запрос, который рассчитывает количество работников. Таблица HumanResources.Employee. Используйте агрегатную функцию COUNT().*/

SELECT COUNT(BusinessEntityID) 
FROM HumanResources.Employee;

/* 3.	Написать запрос к таблице Person.Address, подсчитывающий общее количество сотрудников, у которых поле AddressLine2 имеет значение NULL. Используйте агрегатные функции COUNT() и ISNULL().*/

SELECT COUNT(ISNULL(AddressLine2, '0')) AS address_not_null
FROM Person.Address
WHERE AddressLine2 != '0';

/* 4.	Изменить запрос для того, чтобы исключить значения NULL. Создать запрос, которые возвращает такие же значения, что и предыдущий запрос, но, не принимая во внимание значения NULL. Используйте агрегатную функцию COUNT(). Помните, что функция будет игнорировать значения NULL.*/

SELECT COUNT(AddressLine2) AS address_not_null
FROM Person.Address

/* 1.	Создать и запустить запрос для подсчета среднего числа дней на производство товара (DaysToManufacture). Запрос должен возвращать ProductID и среднее количество дней из таблицы Production.Product. Используйте агрегатную функцию AVG().*/

SELECT AVG(DaysToManufacture) AS AVGDays, ProductID FROM Production.Product
GROUP BY ProductID

/* 2.	Создать и запустить запрос, показывающий имеющиеся цвета (Color) и среднее значение цены (ListPrice) отдельного продукта. Используйте оператор GROUP BY и оператор WHERE для выбора данного продукта (ProductNumber = ‘FR-R72R-58’) (таблица Production.Product).*/

SELECT AVG(ListPrice) AS avgList
	,Color
FROM Production.Product
WHERE ProductNumber = 'FR-R72R-58'
GROUP BY Color

/* 3.	Создать список, показывающий ProductID, среднее количество заказов (OrderQty) и сумму общей линии (LineTotal) для каждого продукта, где сумма общей линии превосходит 1000000$ и среднее количество заказов меньше 3. Используйте оператор GROUP BY для возможности подсчета среднего значения и оператор HAVING для ограничения итоговых данных (таблица Sales.SalesOrderDetail).*/

SELECT SUM(LineTotal) AS sumLine, AVG(OrderQty) AS avgOrder, ProductID 
FROM Sales.SalesOrderDetail 
GROUP BY ProductID 
HAVING SUM(LineTotal) > 1000000 AND AVG(OrderQty) < 3


/* 4.	Создать и запустить запрос, подсчитывающий сумму количества товара (Quantity) на каждой полке (Shelf) для каждого продукта (ProductID). Используйте оператор GROUP BY вместе с оператором ROLLUP (таблица Production.ProductInventory).*/

SELECT Shelf
	,ProductID
	,SUM(Quantity) AS sumQuantity
FROM Production.ProductInventory
GROUP BY ROLLUP (Shelf, ProductID)


/* 5.	Создать и запустить запрос, генерирующий итоговый запрос: создать запрос, который суммирует информацию по числу заказов (OrderQty) из таблицы Sales.SalesOrderDetail, используя оператор CUBE;*/

SELECT ProductID, SUM(OrderQty) AS sum_order
FROM Sales.SalesOrderDetail
GROUP BY CUBE (ProductID)


/* 6.	Отделить строки, созданные с помощью агрегатных функций от строк из фактической таблицы:
a.	создать запрос, который показывает квоты продаж (SalesQuota) и просуммированные продажи (SalesYTD) из таблицы Sales.SalesPerson, используя оператор CUBE;
*/


SELECT SalesQuota,
	SUM(SalesYTD) AS sum_Quota
	FROM Sales.SalesPerson
GROUP BY CUBE (SalesQuota)

/* b.	используйте оператор GROUPING вместе с оператором CUBE, чтобы показать столбцы, к которым не применялась агрегатная функция.*/

SELECT BusinessEntityID ,SalesQuota,
	SUM(SalesYTD) AS sum_Quota
	FROM Sales.SalesPerson
GROUP BY GROUPING SETS (CUBE (BusinessEntityID), SalesQuota)

/* 7.	Создать отчет итоговых столбцов с использованием функции GROUPING:
a.	создать запрос, который суммирует информацию (столбец Quantity) из таблицы Production.ProductInventory с использованием операторов CUBE и GROUPING;
b.	оператор CUBE должен быть использован со множеством столбцов, оператор GROUPING используется с одним из используемых столбцов.
*/

SELECT SUM(Quantity) AS sumQuantity 
	,ProductID 
	,LocationID 
FROM Production.ProductInventory 
GROUP BY GROUPING SETS (CUBE (ProductID, LocationID), LocationID)

/* 1.	Пронумеровать строки по годовым продажам в порядке убывания продаж (SalesYTD). Показать столбцы SalesYTD и BusinessEntityID. Для выполнения задания необходимо проделать следующие шаги:
a)	создайте запрос, возвращающий пронумерованные строки из таблицы Sales.SalesPerson.
b)	используйте функцию ROW_NUMBER, указывающую порядок следования;
c)	профильтруйте результат для удаления продавцов с пустыми территориями (TerritoryID) и нулевыми продажами (SalesYTD).
*/

SELECT ROW_NUMBER() OVER (ORDER BY SalesYTD DESC) AS N
	,SalesYTD
	,BusinessEntityID
FROM Sales.SalesPerson
WHERE TerritoryID IS NOT NULL AND SalesYTD > 0

/* 2.	Создать и выполнить второй запрос, использующий функцию RANK. Для выполнения задания необходимо проделать следующие шаги:
a)	создайте запрос, возвращающий из таблицы ProductInventory пронумерованные строки в порядке увеличения количества (Quantity) для каждого расположения (LocationID) отдельно;
b)	используйте функцию RANK, определяющую порядок следования. Покажите столбцы ProductID, LocationID и Quantity.
*/

SELECT RANK() OVER (PARTITION BY Quantity ORDER BY LocationID) AS N 
,ProductID 
,LocationID 
,Quantity 
FROM Production.ProductInventory


/* 3.	Создать и выполнить третий запрос, использующий функцию DENSE_RANK (повторить предыдущий пункт).*/

SELECT DENSE_RANK() OVER (PARTITION BY Quantity ORDER BY LocationID) AS N 
,ProductID 
,LocationID 
,Quantity 
FROM Production.ProductInventory

/*4.	Создать отчет, содержащий подробную информацию о продавцах (BusinessEntityID) на основе годовых продаж (SalesYTD), отсортированных в порядке убывания, и затем сгруппированных по четырем категориям. Для выполнения задания необходимо проделать следующие шаги:
a)	создайте запрос, возвращающий пронумерованные строки из таблицы Sales.SalesPerson;
b)	для распределения на категории используйте функцию NTILE, категории заполняются в порядке убывания годовых продаж (SalesYTD);
c)	отфильтруйте результат, удалив продавцов с пустыми территориями и нулевыми продажами.

*/

SELECT NTILE(5) OVER (ORDER BY SalesYTD) AS N
	,SalesYTD 
	,TerritoryID 
	,SalesQuota 
	FROM Sales.SalesPerson 
WHERE TerritoryID IS NOT NULL AND SalesQuota IS NOT NULL


/* 1.	Показать максимально запланированную стоимость (PlannedCost)*/

SELECT MAX(PlannedCost) AS maxCost
FROM Production.WorkOrderRouting

/* 2.	Показать максимальную разницу между запланированной и актуальной стоимостью (ActualCost), большей нуля.*/

SELECT (MAX(PlannedCost) - MIN(ActualCost))  AS maxPlannedCost
FROM Production.WorkOrderRouting

/* 3.	Показать общее суммарное количество запланированных часов (ActualResourceHrs) для каждой местности (LocationID).*/

SELECT LocationID
	,SUM(ActualResourceHrs) AS sumActual
FROM Production.WorkOrderRouting
GROUP BY LocationID

/* 4.	Показать количество товара с отличающейся запланированной и актуальной стоимостью.*/

SELECT COUNT(ProductID) AS countPr FROM Production.WorkOrderRouting
WHERE PlannedCost != ActualCost

/* 5.	Для каждой местности найти суммарное количество запланированных дней (разница в днях SheduledStartDate и SheduledEndDate) на работу с товаром.*/

SELECT 
	ProductID
	,SUM(DATEDIFF(DAY, ScheduledStartDate, ScheduledEndDate)) AS days
FROM Production.WorkOrderRouting
GROUP BY ProductID

/* 6.	Для каждого товара найти суммарное количество запланированных и актуальных дней (ActualStartDate и ActualEndDate) на работу с товаром.*/

SELECT
	ProductID
	,SUM(DATEDIFF(DAY, ScheduledStartDate, ScheduledEndDate)) AS daysSch
	,SUM(DATEDIFF(DAY, ActualStartDate, ActualEndDate)) AS daysActual
FROM Production.WorkOrderRouting
GROUP BY ProductID

/* 7.	Показать товары (ProductID), для которых суммарное количество запланированных дней меньше, чем количество актуальных дней.*/

SELECT
	ProductID
	,SUM(DATEDIFF(DAY, ScheduledStartDate, ScheduledEndDate)) AS daysSch
	,SUM(DATEDIFF(DAY, ActualStartDate, ActualEndDate)) AS daysActual
FROM Production.WorkOrderRouting
GROUP BY ProductID
HAVING SUM(DATEDIFF(DAY, ScheduledStartDate, ScheduledEndDate)) < SUM(DATEDIFF(DAY,ActualStartDate, ActualEndDate))


/* 8.	Показать товары, для которых суммарное количество запланированных дней меньше, чем количество актуальных дней, при условии, что количество запланированных часов не меньше 4.*/

SELECT
	ProductID
	,SUM(DATEDIFF(DAY, ScheduledStartDate, ScheduledEndDate)) AS daysSch
	,SUM(DATEDIFF(DAY, ActualStartDate, ActualEndDate)) AS daysActual
FROM Production.WorkOrderRouting
WHERE DATEDIFF(HOUR, ScheduledEndDate, ScheduledEndDate) >= 4
GROUP BY ProductID
HAVING SUM(DATEDIFF(DAY, ScheduledStartDate, ScheduledEndDate)) < SUM(DATEDIFF(DAY,ActualStartDate, ActualEndDate))

/* 9.	Показать количество товара (ProductID), для которого одинаково количество запланированных часов.
Работа с таблицей Purshasing.ProductVendor

*/
SELECT
	AverageLeadTime
	,COUNT(ProductID) AS countProduct
FROM Purchasing.ProductVendor
GROUP BY AverageLeadTime

/* 10.	Для каждого продавца (BusinessEntityID) найти суммарное время (AverageLeadTime), при условии, что стандартная цена (StandartPrice) и стоимость (LastReceiptCost) не отличаются более чем на 20%.*/

SELECT 
	BusinessEntityID 
	,SUM(AverageLeadTime) AS sumAver
FROM Purchasing.ProductVendor
WHERE (100 - StandardPrice * 100 / LastReceiptCost) <= 20
GROUP BY BusinessEntityID

/* 11.	Показать товар (ProductID), у которого максимальная разница в стандартной цене (StandartPrice) и стоимости (LastReceiptCost) отличается более чем на 10%.*/

SELECT 
	ProductID 
	--,SUM(AverageLeadTime) AS sumAver
FROM Purchasing.ProductVendor
WHERE (100 - StandardPrice * 100 / LastReceiptCost)  > 10
GROUP BY ProductID

/* 12.	Для каждого товара (ProductID) показать максимальную разницу цены (StandartPrice) и стоимости (LastReceiptCost).*/

SELECT 
	ProductID
	,MAX(StandardPrice) - MIN(LastReceiptCost) AS diff
FROM Purchasing.ProductVendor
GROUP BY ProductID

/* 13.	Показать продавца (BusinessEntityID), реализующего более 3 продуктов (ProductID).*/

SELECT 
	BusinessEntityID
FROM Purchasing.ProductVendor
WHERE ProductID > 3

/* 14.	Для каждого товара (ProductID) показать максимальную разницу минимального (MinOrderQty)  и максимального количества (MaxOrderQty) товара, если это количество больше 100 и время (AverageLeadTime) больше 17.
*/
SELECT 
	ProductID
	,MAX(MaxOrderQty-MinOrderQty) AS maxDiff
FROM Purchasing.ProductVendor
WHERE AverageLeadTime > 17
GROUP BY ProductID
HAVING MAX(MaxOrderQty-MinOrderQty) > 100


/* 15.	Показать суммарное количество заказанного товара (OnOrderQty) каждым продавцом не позднее 25 сентября 2004 (LastReceiptDate).*/

SELECT 
	ProductID
	,SUM(OnOrderQty) AS sumOrder
FROM Purchasing.ProductVendor
WHERE LastReceiptDate > '20040925'
GROUP BY ProductID
HAVING SUM(OnOrderQty) IS NOT NULL




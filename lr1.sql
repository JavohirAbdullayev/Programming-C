/*
1)	Показать все записи из таблицы Person.Person.*/
SELECT * FROM Person.Person

/*
 Показать все записи из таблицы Person.Person. Включить только поля FirstName, LastName и MiddleName.*/

 SELECT FirstName, LastName, MiddleName FROM Person.Person


 /*
 Создание запроса, используя предикат сравнения. Показать все записи, цена (ListPrice) которых меньше $100 из таблицы Production.Product, включить только поля ProductNumber, Name, ListPrice, Color, Size и Weight.*/

 SELECT ProductNumber
	   ,Name
	   ,ListPrice
	   , Color
	   ,Size
	   ,Weight
FROM Production.Product
WHERE ListPrice < 100

/* 2)	Создание запроса, использующего предикаты AND и LIKE. Добавить в выражение предыдущего запроса ограничение на столбец ProductNumber. Показать только те записи, которые начинаются на SO.*/

SELECT ProductNumber
	   ,Name
	   ,ListPrice
	   ,Color
	   ,Size
	   ,Weight
FROM Production.Product
WHERE ListPrice < 100 AND ProductNumber LIKE 'SO%'

/* 3)	Создание запроса с предикатом OR. Изменить предыдущий запрос, включив в результаты строки, имеющие TG или SO в поле ProductNumber.*/

SELECT ProductNumber
	   ,Name
	   ,ListPrice
	   ,Color
	   ,Size
	   ,Weight
FROM Production.Product
WHERE ListPrice < 100 AND (ProductNumber LIKE 'SO%' OR ProductNumber LIKE 'TG%')

/* Создание запроса с предикатом BETWEEN. Показать строки, имеющие SO в поле ProductNumber или строки товара tights (TG) с ценой от $50 до $180.*/

SELECT ProductNumber
	   ,Name
	   ,ListPrice
	   ,Color
	   ,Size
	   ,Weight
FROM Production.Product
WHERE (ProductNumber LIKE 'SO%' OR ProductNumber LIKE 'TG%')
		AND ListPrice BETWEEN 50 AND 180

		/* Создание запроса с использованием предиката IN. В текст скрипта добавить условие на поиск товара колготки (tights (TG)) в диапазоне размеров M и L. */

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

		/* Создание запроса к таблице Production.Product, позволяющего извлечь данные из полей ProductNumber, Name и Weight, в которых ProductLine известно (NOT NULL).*/

		SELECT ProductNumber, Name, Weight FROM Production.Product
WHERE ProductLine IS NOT NULL

/* ) Изменить предыдущий запрос, показав строки с неизвестными значениями (NULL).*/

SELECT ProductNumber, Name, Weight FROM Production.Product
WHERE ProductLine IS NULL

/* Создать запрос, используя выражение SELECT с функцией ISNULL для переименования значений. Используйте функцию ISNULL, чтобы при неизвестном значении в столбце ProductLine выводилось значение ‘NA’.*/

SELECT ProductNumber, ISNULL(ProductLine, 'NA')
	,Name
	,Weight
FROM Production.Product
WHERE ProductLine IS NULL

/* 4)	Изменить предыдущий запрос так, чтобы поле вывода называлось “Product Line” (два слова с пробелом).*/

1)	SELECT ProductNumber, ISNULL(ProductLine, 'NA') AS 'Product Line'
	,Name
	,Weight
FROM Production.Product
WHERE ProductLine IS NULL

/* Изменить запрос с использованием функции COALESCE() и заполнением нового поля Measurement так, чтобы: 
• если известно значение в поле Weight, то показать это значение;
• если значение в поле Weight неизвестно, но известно значение в поле Size, то показывать его значение;
• в противном варианте значение написать “NA”. 
*/

SELECT ProductNumber, ISNULL(ProductLine, 'NA') AS 'Product Line'
	,Name
	,Weight
	, COALESCE(CAST([Weight] AS VARCHAR(10)), Size, 'NA') AS Measurement
FROM Production.Product

/* 1)	Создать запрос к таблице Production.Product с полями ProductNumber, Name и Class. Провести сортировку по значениям в поле Class.*/

SELECT ProductNumber
	,Name
	,Class
FROM Production.Product
ORDER BY Class

/* 2)	Изменить предыдущий запрос, добавлением поля ListPrice. Провести сортировку по новому полю в порядке убывания цены*/


SELECT ProductNumber
	,Name
	,Class
	,ListPrice
FROM Production.Product
ORDER BY ListPrice DESC

/* 3)	Создать запрос к таблице Production.Product, показывающий все имеющиеся цвета товаров. Показать только одну строку для каждого цвета. */

SELECT DISTINCT Color
FROM Production.Product

/* 4)	Создать запрос к таблице Person.Person. Создать поле, составленное из столбцов LastName и FirstName, разделенных запятой и пробелом.*/

SELECT CONCAT_WS(', ', FirstName, LastName) AS FullName FROM Person.Person

/* 5)	Изменить предыдущий запрос, так, чтобы составное поле называлось Contact.*/

SELECT CONCAT_WS(', ', FirstName, LastName) AS Contact FROM Person.Person

/* 6)	Переписать запрос таким образом, чтобы поиск проходил по всем строкам LastName, начинающимся на ‘Mac’ с использованием функции SUBSTRING().*/

SELECT CONCAT_WS(', ', FirstName, LastName) AS Contact 
FROM Person.Person
WHERE SUBSTRING(LastName, 1, 3) = 'Mac'





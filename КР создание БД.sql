/* Разработка скриптов на создание базы данных и таблиц. 1. School*/

CREATE TABLE [dbo].[school](
[id] [int] IDENTITY(1,1) NOT NULL,
[school_name] [char](30) NOT NULL,
CONSTRAINT [PK_school] PRIMARY KEY CLUSTERED
(
[id] ASC))


/* 2. Class*/

CREATE TABLE [dbo].[class](
[id] [int] IDENTITY(1,1) NOT NULL,
[id_class] [int] NOT NULL,
[how_many] [nchar](1) NOT NULL,
CONSTRAINT [PK_class] PRIMARY KEY CLUSTERED
(
[id] ASC))


/* 3. Studnet*/

CREATE TABLE [dbo].[student](
[id] [int] IDENTITY(1,1) NOT NULL,
[First name] [int] NOT NULL,
[Last name] [int] NOT NULL,
[birthday] [date] NOT NULL,
[Doccment] [int] NOT NULL,
[adress] [int] NOT NULL,
CONSTRAINT [PK_student] PRIMARY KEY CLUSTERED
(
[id] ASC))


/* 4. Teacher*/

CREATE TABLE [dbo].[teacher](
[id] [int] IDENTITY(1,1) NOT NULL,
[First name] [int] NOT NULL,
[Last name] [int] NOT NULL,
CONSTRAINT [PK_teacher] PRIMARY KEY CLUSTERED
(
[id] ASC))

/* 5. Headteacher*/

CREATE TABLE [dbo].[headteacher](
[id] [int] IDENTITY(1,1) NOT NULL,
[First name] [int] NOT NULL,
[Last name] [int] NOT NULL,
[class] [int] NOT NULL,
CONSTRAINT [PK_headteacher] PRIMARY KEY CLUSTERED
(
[id] ASC))


/* добавление записей */

INSERT INTO [dbo].[student]
([First name]
,[Last name]
,[birthday_date]
VALUES
('Tom'
,'1996-09-07'
,'00000000'
,'true')


/* Удаление записей*/

UPDATE [dbo].[Patients]
SET[first name]='Tom
изменений'
where[id] = 12

 
/* Удаление записей: На примере ранее измененной записи в таблице Patients */

DELETE FROM [bdo].[student]
WHERE id = 12




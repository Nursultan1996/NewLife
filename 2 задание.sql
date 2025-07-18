# Создаем таблицу с продажами
CREATE TABLE t_tab1
(ID INT,
Goods_type VARCHAR(15),
Quantity INT,
Amount INT,
Seller_name varchar(10));


# # Создаем таблицу с данными продавцов
CREATE TABLE t_tab2
(ID INT,
Name VARCHAR(10),
Salary INT,
Age INT);


# Вставляем значения для таблицы с продажами
INSERT INTO t_tab1
VALUES (1,"Mobile_Phone", 2, 400000, "Mike" ),
(2, "Keyboard", 1, 10000, "Mike"),
(3, "Mobile_phone", 1, 50000, "Jane"),
(4, "Monitor", 1, 110000, "Joe"),
(5, "Monitor", 2, 80000, "Jane"),
(6, "Mobile_phone", 1, 130000, "Joe"),
(7, "Mobile_phone", 1, 60000, "Anna"),
(8, "Printer", 1, 90000, "Anna"),
(9, "Keyboard", 2, 10000, "Anna"),
(10, "Printer", 1, 80000, "Mike");



# Вставляем значения для таблицы с данными продавцов
INSERT INTO t_tab2
VALUES (1, "Anna", 110000, 27),
(2, "Jane", 80000, 25),
(3, "Mike", 120000, 25),
(4, "Joe", 70000, 24),
(5, "Rita", 120000, 29);


# Напишите запрос, который вернёт список уникальных категорий товаров (GOODS_TYPE). 
# Какое количество уникальных категорий товаров вернёт запрос?
SELECT DISTINCT Goods_type
FROM t_tab1;

SELECT DISTINCT COUNT(DISTINCT Goods_type) AS Unique_categories
FROM t_tab1;


# Напишите запрос, который вернет суммарное количество и суммарную стоимость проданных мобильных телефонов. 
# Какое суммарное количество и суммарную стоимость вернул запрос?
SELECT SUM(Quantity) AS "Суммарное количество Телефонов", SUM(Amount) "Проданная сумма"
FROM t_tab1
WHERE Goods_type = "Mobile_phone";


# Напишите запрос, который вернёт список сотрудников с заработной платой > 100000. 
# Какое кол-во сотрудников вернул запрос

SELECT * 
FROM t_tab2
WHERE salary > 100000;


SELECT COUNT(*) AS "Количество сотрудников с заработной платой > 100000" 
FROM t_tab2
WHERE salary > 100000;


# Напишите запрос, который вернёт минимальный и максимальный возраст сотрудников, 
# а также минимальную и максимальную заработную плату

SELECT MAX(Age), Min(Age), Max(Salary), Min(salary)
FROM t_tab2;


# Напишите запрос, который вернёт среднее количество проданных клавиатур и принтеров

SELECT  AVG(
CASE 
	WHEN Goods_type = "Keyboard"
    THEN Quantity
    ELSE NULL
    END) AS Avg_KB,
AVG(
CASE
	WHEN Goods_type = "Printer"
    Then Quantity
    ELSE NULL
    END) AS Avg_Printer
FROM t_tab1;


# Напишите запрос, который вернёт имя сотрудника и суммарную стоимость проданных им товаров

SELECT t.Seller_name AS "Имя продавца", SUM(Amount) AS "Суммарная стоимость проданных им товаров"
FROM t_tab1 t
JOIN t_tab2 t2
ON t.Seller_name = t2.Name
GROUP BY NAME;



# Напишите запрос, который вернёт имя сотрудника, тип товара, кол-во товара, 
# стоимость товара, заработную плату и возраст сотрудника MIKE

SELECT t2.Name, t.Goods_type, t.Quantity, t.Amount, t2.Salary, t2.Age 
FROM t_tab1 t
JOIN t_tab2 t2
ON t.Seller_name = t2.Name
WHERE Name = "Mike";


# Напишите запрос, который вернёт имя и возраст сотрудника, который ничего не продал. 
# Сколько таких сотрудников?
SELECT t2.Name, t2.Age
FROM t_tab2 t2
WHERE NOT EXISTS(
SELECT Seller_name 
FROM t_tab1 t
WHERE t.Seller_name = t2.Name);


# Напишите запрос, который вернёт имя сотрудника и его заработную плату с возрастом меньше 26 лет? 
# Какое количество строк вернул запрос?
SELECT Name, Salary
FROM t_tab2
WHERE Age < 26;

SELECT COUNT(CONCAT(Name, Salary)) AS "Количество сотрудников с возрастом меньше 26"
FROM t_tab2
WHERE Age < 26;


# Сколько строк вернёт следующий запрос?
SELECT * FROM T_TAB1 t
JOIN T_TAB2 t2 ON t2.name = t.seller_name
WHERE t2.name = 'RITA'


# 0 строк

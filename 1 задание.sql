CREATE DATABASE users_adverts;

SELECT * FROM users;

CREATE TABLE users(
date DATE,
user_id varchar(50),
view_adverts INT); 

# Напишите запрос SQL, выводящий одним числом количество уникальных пользователей в этой таблице в период с 2023-11-07 по 2023-11-15
SELECT COUNT(DISTINCT user_id) AS "Количество уникальных пользователей в период с 2023-11-07 по 2023-11-15"
FROM users
WHERE date BETWEEN  "2023-11-07" AND "2023-11-15";

SELECT view_adverts
FROM users
WHERE user_id = "487377d0-6fd8-11ee-aaa1-7996524389b0";

# Определите пользователя, который за весь период посмотрел наибольшее количество объявлений
SELECT user_id AS "Пользователь, который за весь период посмотрел наибольшее количество объявлений"
FROM users 
ORDER BY view_adverts DESC
LIMIT 1;

# Определите день с наибольшим средним количеством просмотренных рекламных объявлений на пользователя, но учитывайте только дни с более чем 500 уникальными пользователями

SELECT date, AVG(view_adverts)
FROM users
GROUP BY date
HAVING COUNT(user_id)>500
ORDER BY AVG(view_adverts) DESC
LIMIT 1;

# Напишите запрос возвращающий LT (продолжительность присутствия пользователя на сайте) по каждому пользователю
SELECT user_id, COUNT(DISTINCT date)
FROM users
GROUP BY user_id
ORDER BY COUNT(date) DESC;


SELECT user_id, COUNT(*)
FROM (SELECT user_id, COUNT(date)
FROM users
GROUP BY user_id) AS LT
GROUP BY user_id, users.date;

# Для каждого пользователя подсчитайте среднее количество просмотренной рекламы за день, а затем выясните, у кого самый высокий средний показатель среди тех, кто был активен как минимум в 5 разных дней
SELECT user_id, AVG(view_adverts)
FROM(SELECT user_id, date, );



#Найди всех пользователей, у которых общее количество просмотров рекламы выше среднего по всем пользователям
SELECT user_id, AVG(view_adverts)
FROM users
GROUP BY user_id
HAVING AVG(view_adverts)>
(SELECT AVG(view_adverts)
FROM users 
)
ORDER BY AVG(view_adverts) DESC;


# Найди user_id пользователя, у которого дата активности была самой последней в таблице

SELECT user_id, Max(date)
FROM users 
GROUP BY user_id
HAVING Max(date) = (
Select max(date)
FROM users u);

# Для каждого пользователя посчитай среднее количество просмотров рекламы в день.

# Верни только тех пользователей, которые были активны в 5 и более разных датах.

# Среди них найди пользователя с самым высоким средним количеством просмотров за день.

# Выведи user_id и его avg_view_per_day
SELECT user_id, AVG(view_adverts)
FROM (
SELECT user_id, date, count(view_adverts)
FROM users
GROUP BY user_id) AS avg_view_per_day
HAVING date>=5
LIMIT 1;

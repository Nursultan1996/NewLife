# Выведите сколько пользователей добавили книгу 'Coraline', 
#сколько пользователей прослушало больше 10%
SELECT *
FROM audiobooks ab
JOIN audio_cards ac
ON ab.uuid = ac.audiobook_uuid
WHERE ab.title LIKE '%Coraline%'
AND ab.duration>0
AND ac.progress/ab.duration>0.10;


# По каждой операционной системе и названию книги выведите количество пользователей, 
# сумму прослушивания в часах, не учитывая тестовые прослушивания
SELECT COUNT(DISTINCT l.user_id) AS User_sum_by_OS, SUM(ac.progress) AS Progress_sum_by_OS
FROM listenings l
JOIN audio_cards ac
ON l.audiobook_uuid = ac.audiobook_uuid
JOIN audiobooks ab
ON ab.uuid = ac.audiobook_uuid
WHERE l.is_test = 0
GROUP BY l.os_name, ab.title;



# Найдите книгу, которую слушает больше всего людей
SELECT ab.title AS The_most_listened_book, SUM(l.id ) AS Total_number_of_listeners
FROM audiobooks ab
JOIN listenings l
ON ab.uuid  = l.audiobook_uuid
WHERE ab.uuid  = l.audiobook_uuid
GROUP BY ab.title 
ORDER BY SUM(id) DESC
LIMIT 1; 



# Найдите книгу, которую чаще всего дослушивают до конца
SELECT ab.title, COUNT(ac.progress/ab.duration>=0.9) AS Finished
FROM audiobooks ab
JOIN audio_cards ac
ON ab.uuid = ac.audiobook_uuid
WHERE ac.progress/ab.duration>=0.9
GROUP BY ab.title
ORDER BY Finished DESC
LIMIT 1;

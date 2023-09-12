/*
Домашнее задание 4 
Выполнено Павлом Овчинниковым при обучении на курсе Базы данных и SQL (семинары)
Преподаватель Кирилл Иванов
Задание выполнено в DBeaver

Урок 4. SQL – работа с несколькими таблицами
1. Подсчитать количество групп (сообществ), в которые вступил каждый пользователь.
2. Подсчитать количество пользователей в каждом сообществе.
3. Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, который больше всех общался с выбранным пользователем (написал ему сообщений).
4* Подсчитать общее количество лайков, которые получили пользователи младше 18 лет..
5* Определить кто больше поставил лайков (всего): мужчины или женщины.
*/

-- 1. Подсчитать количество групп (сообществ), в которые вступил каждый пользователь.
SELECT id, firstname, lastname, COUNT(user_id) AS count_communities
FROM users
JOIN users_communities ON users.id = users_communities.user_id
GROUP BY id,firstname,lastname
ORDER BY count_communities DESC
;

-- 2. Подсчитать количество пользователей в каждом сообществе.
SELECT communities.name, COUNT(count_communities.user_id)
FROM communities
INNER JOIN users_communities count_communities ON count_communities.community_id=communities.id
GROUP BY communities.name
;

-- 3. Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, 
-- который больше всех общался с выбранным пользователем (написал ему сообщений).
SELECT users.id, users.firstname, users.lastname
FROM messages
INNER JOIN users ON users.id=messages.from_user_id
WHERE messages.to_user_id = '1' # Задаем для какого ползователя ведем поиск
GROUP BY messages.from_user_id
ORDER BY messages.from_user_id DESC 
LIMIT 3# Выводим трех победителей 
;

-- 4* Подсчитать общее количество лайков, которые получили пользователи младше 18 лет.
SELECT COUNT(likes.id) 'Количество лайков'
FROM likes
INNER JOIN media ON media.id=likes.media_id
INNER JOIN profiles ON profiles.user_id=media.user_id
WHERE TIMESTAMPDIFF(YEAR, profiles.birthday, NOW()) < '18'
;

-- 5* Определить кто больше поставил лайков (всего): мужчины или женщины.
SELECT gender, COUNT(likes.id) 'Количество лайков'
FROM likes
INNER JOIN profiles ON profiles.user_id=likes.user_id
GROUP BY gender
;
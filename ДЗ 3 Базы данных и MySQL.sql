/*
Домашнее задание 3 
Выполнено Павлом Овчинниковым при обучении на курсе Базы данных и SQL (семинары)
Преподаватель Кирилл Иванов
Задание выполнено в DBeaver
3. SQL – выборка данных, сортировка, агрегатные функции

Задачи
1. Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке. [ORDER BY]
2. Выведите количество мужчин старше 35 лет [COUNT].
3. Сколько заявок в друзья в каждом статусе? (таблица friend_requests) [GROUP BY]
4.* Выведите номер пользователя, который отправил больше всех заявок в друзья (таблица friend_requests) [LIMIT].
5.* Выведите названия и номера групп, имена которых состоят из 5 символов [LIKE].
*/

-- таблицы БД vk данными по скрипту _vk_db_seed.sql

-- 1. скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке. [ORDER BY]
SELECT firstname FROM users ORDER BY firstname ASC; # 100 значений ASC сортирует от низких значений к высоким. Значение DESC сортирует от высоких значений к низким. 
SELECT DISTINCT firstname FROM users ORDER BY firstname ASC; # без повторов 88 

-- 2. количество мужчин старше 35 лет
SELECT COUNT(*) FROM profiles 
WHERE  TIMESTAMPDIFF(year, birthday, NOW()) > 35
AND gender = 'm'
; 

-- подсчет заявок в друзья в каждом статусе? (таблица friend_requests) [GROUP BY]
SELECT COUNT(*), status 
FROM friend_requests 
GROUP BY status 
; 

-- 4.* Выведите номер пользователя, который отправил больше всех заявок в друзья (таблица friend_requests) [LIMIT].
SELECT initiator_user_id, COUNT(*) count_applications
FROM friend_requests
GROUP BY initiator_user_id
ORDER BY count_applications DESC  #Значение DESC сортирует от высоких значений к низким. 
LIMIT 3; # ограничивает количество строк, возвращаемых запросом. Оператор LIMIT появляется в конце запроса после любых операторов ORDER BY.
# без LIMIT получили результат - только один направил 3 запроса, остальные по 1

-- 5.* Выведите названия и номера групп, имена которых состоят из 5 символов [LIKE].
SELECT id, name
FROM communities
WHERE name LIKE '_____'; # Очень непревычно "_"
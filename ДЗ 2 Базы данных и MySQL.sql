/*
Домашнее задание 1 
Выполнено Павлом Овчинниковым при обучении на курсе Базы данных и SQL (семинары)
Преподаватель Кирилл Иванов
Задание выполнено в DBeaver
Урок 2. SQL – создание объектов, простые запросы выборки

Задачи
1. Создать БД vk, исполнив скрипт _vk_db_creation.sql (в материалах к уроку) (ВЫПОЛНЕНО)
2. Написать скрипт, добавляющий в созданную БД vk 2-3 новые таблицы 
(с перечнем полей, указанием индексов и внешних ключей) (CREATE TABLE)
3. Заполнить 2 таблицы БД vk данными (по 10 записей в каждой таблице) (INSERT)
*/

DROP TABLE IF EXISTS wallet;
CREATE TABLE wallet (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    amount DECIMAL(10,2),
    payment_date DATETIME,	
    
    INDEX payment_date_idx(payment_date)    
    # FOREIGN KEY (id) REFERENCES users(id),
) COMMENT 'кошелек';

INSERT INTO `wallet` 
VALUES ('1','100.22','2023-01-31 23:59:59'),
	('2','120.22','2023-01-11 08:59:59'),
	('3','28.17','2023-04-03 01:01:01'),
	('4','54.80','2023-01-01 00:00:59'),
	('5','11111.33','2023-04-18 23:00:59'),
	('6','77.53','2023-05-22 22:33:44'),
	('7','2340243.22','2023-07-23 13:23:34'),
	('8','365.99','2023-06-12 00:44:23'),
	('9','34564576.00','2023-08-09 09:02:45'),
    ('10','5857.97','2023-03-31 16:34:54');

DROP TABLE IF EXISTS favourites;
CREATE TABLE favourites (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    
	cart BIGINT NOT NULL,
	status VARCHAR(6) check (status in ( 'saved', 'orders', 'sold' )),
    shop VARCHAR(160),
    item_article_idx BIGINT, # артикул товара 
    item_article_name VARCHAR(160),

    INDEX purchases_idx(item_article_idx, item_article_name)
    # FOREIGN KEY (id) REFERENCES users(id),
) COMMENT 'Избранное';

INSERT INTO `favourites` 
VALUES ('1','999888777', 'saved','супер-пупер магазин', '000000001', 'музыка'),
	('2','999888777','saved','супер-пупер магазин', '000000002', 'видео'),
	('3','999888777', 'orders','супер-пупер магазин', '000000003', 'открытка'),
	('4','999888777', 'orders','супер-пупер магазин', '000000004', 'валентинка'),
	('5','999888777', 'sold','супер-пупер магазин', '000000005', 'молоко'),
	('6','999888777','sold','супер-пупер магазин', '000000006', 'сертификат');
 
/*4. Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных (поле is_active = true). 
При необходимости предварительно добавить такое поле в таблицу profiles со значением по умолчанию = false (или 0) 
(ALTER TABLE + UPDATE)*/


ALTER TABLE profiles 
ADD COLUMN is_active BIT NOT NULL DEFAULT false; # IF NOT COLUMN EXISTS !!!

UPDATE profiles
SET is_active = true
WHERE TIMESTAMPDIFF(YEAR, birthday, CURDATE()) >= 18

/*5. Написать скрипт, удаляющий сообщения «из будущего» (дата позже сегодняшней) (DELETE)*/
INSERT INTO `messages`
VALUES ('1', '1','2', 'Тестовое сообщение 1 с будущей датой', '2023-12-01 00:00:59'),
    ('2', '3','4', 'Тестовое сообщение 2 с прошлой датой', '2023-01-01 00:00:59'),
    ('3', '3','4', 'Тестовое сообщение 3 с будущей датой', '2023-08-12 00:00:59');
    # ('3', '4','4', 'Тестовое сообщение 3 текушей датой', CURDATE());


DELETE FROM messages 
WHERE created_at > NOW();

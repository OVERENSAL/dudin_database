CREATE DATABASE TelephoneService
COLLATE Cyrillic_General_CI_AS

CREATE TABLE Payment (
id_payment int NOT NULL,
id_telephone_number_user int NOT NULL,
id_service_on_telephone_number int NOT NULL,
price int NOT NULL,
date date NOT NULL,
PRIMARY KEY (id_payment)
)
GO

CREATE TABLE TelephoneNumberUser (
id_telephone_number_user int NOT NULL,
f_name varchar(50) NOT NULL,
l_name varchar(50) NOT NULL,
gender bit NOT NULL,
date_of_birth datetime NOT NULL,
PRIMARY KEY (id_telephone_number_user)
)
GO

INSERT INTO TelephoneNumberUser VALUES(0, 'Anton', 'Fecalis', 1, '2015-12-25T15:32:06.427');
INSERT INTO TelephoneNumberUser VALUES(9, 'Anton', 'Sergey', 1, '2015-12-25T15:32:06.427');
INSERT INTO TelephoneNumberUser VALUES(1, 'Misha', 'Ducalis', 1, '2014-12-25T15:32:06.427');
INSERT INTO TelephoneNumberUser VALUES(2, 'Anya', 'Kurich', 0, '2013-11-25T15:32:06.427');
INSERT INTO TelephoneNumberUser VALUES(3, 'Omae Va', 'Mu', 1, '2015-10-23T15:32:06.427');
INSERT INTO TelephoneNumberUser VALUES(4, 'Mers', 'BNW', 1, '2005-12-25T15:42:02.427');
INSERT INTO TelephoneNumberUser VALUES(5, 'BNW', 'M5', 1, '1995-12-25T15:32:06.427');
INSERT INTO TelephoneNumberUser VALUES(6, 'Denis', 'Suhachyov', 1, '1985-12-25T14:32:06.427');
INSERT INTO TelephoneNumberUser VALUES(7, 'Sasha', 'Citines', 1, '1923-12-15T15:32:06.427');
INSERT INTO TelephoneNumberUser VALUES(8, 'Sashok', 'Mayonez', 1, '2005-02-31T15:32:06.427');


CREATE TABLE TelephoneNumber (
id_telephone_number int NOT NULL,
id_service_on_telephone_number int NOT NULL,
id_telephone_number_user int NOT NULL,
telephone_number varchar(12) NOT NULL,
tariff varchar(50) NOT NULL,
place_of_registration varchar(50) NOT NULL,
PRIMARY KEY (id_telephone_number)
)
GO

INSERT INTO TelephoneNumber VALUES(0, 0, 0, +79877000000, 'MishaNaKrishe', 'Republic of Mari El');
INSERT INTO TelephoneNumber VALUES(1, 0, 1, +79877000001, 'SeregaVDele', 'Republic of Dagestan');
INSERT INTO TelephoneNumber VALUES(2, 1, 2, +79877000002, 'VasyaNakrasil', 'Nizhegorodsky Region');
INSERT INTO TelephoneNumber VALUES(3, 1, 3, +79877000003, 'KuriniiKrilishek', 'Republic of Dagestan');
INSERT INTO TelephoneNumber VALUES(4, 0, 4, +79877000004, '100Problem', 'Republic of Dagestan');
INSERT INTO TelephoneNumber VALUES(5, 2, 5, +79877000005, 'SamyiLuchshii', 'Republic of Dagestan');
INSERT INTO TelephoneNumber VALUES(6, 0, 6, +79877000006, 'SamyiHudshii', 'Nizhegorodsky Region');
INSERT INTO TelephoneNumber VALUES(7, 3, 7, +79877000007, 'ObozhaiyBD', 'Republic of Mari El');
INSERT INTO TelephoneNumber VALUES(8, 0, 8, +79877000008, 'AecheOOP', 'Republic of Mari El');
INSERT INTO TelephoneNumber VALUES(9, 1, 9, +79877000009, 'IDazheBackend', 'Republic of Mari El');

CREATE TABLE ServiceOnTelephoneNumber (
id_service_on_telephone_number int NOT NULL,
id_type_of_service int NOT NULL,
name_of_service varchar(50) NOT NULL,
price int NOT NULL,
PRIMARY KEY (id_service_on_telephone_number)
)
GO

CREATE TABLE TypeOfService (
id_type_of_service int NOT NULL,
category varchar(50) NOT NULL,
number_of_services int NOT NULL,
PRIMARY KEY (id_type_of_service)
)
GO




-- 1.INSERT
---- 1.1 Без указания списка полей
		INSERT INTO TelephoneNumberUser VALUES(54, 'Anton', 'Fecalis', 1, 28-12-1988-12-00-00);
---- 1.2 С указание списка полей
		INSERT INTO TelephoneNumber (id_telephone_number, id_service_on_telephone_number, id_telephone_number_user, telephone_number, tariff, place_of_registration) VALUES (0, 0, 0, 89871488228, 'SeregaVDele', 'Republic of Dagestan');
---- 1.3 С чтением значений из другой таблицы
		INSERT INTO ServiceOnTelephoneNumber(name_of_service, price) SELECT category, number_of_services FROM TypeOfService;

-- 2.DELETE
---- 2.1 Всех записей
		DELETE TelephoneNumberUser;
---- 2.2 По условию
		DELETE FROM TelephoneNumber WHERE id_telephone_number = 0;
---- 2.3 Очистить таблица
		TRUNCATE TABLE TelephoneNumber;

-- 3.UPDATE
---- 3.1 Всех записей
		UPDATE TelephoneNumber SET tariff = 'BulBulKarasik';
---- 3.2 По условию, обновляя один атрибут
		UPDATE TelephoneNumber SET tariff = 'BulBulKarasik' WHERE telephone_number = 89871488228;
---- 3.3 По условию обновляя несколько атрибутов
		UPDATE TelephoneNumberUser SET f_name = 'Mers', l_name = 'BNW' WHERE id_telephone_number_user = 54;

-- 4.SELECT
---- 4.1 С определенным набором извлекаемых атрибутов (SELECT atr1, atr2 FROM...)
		SELECT telephone_number, tariff, place_of_registration FROM TelephoneNumber;
---- 4.2 Со всеми атрибутами (SELECT * FROM...)
		SELECT * FROM TelephoneNumber;
---- 4.3 С условием по атрибуту (SELECT * FROM ... WHERE atr1 = "")
		SELECT * FROM TelephoneNumber WHERE id_telephone_number = 0;

-- 5. SELECT ORDER BY + TOP (LIMIT)
---- 5.1 С сортировкой по возрастанию ASC + ограничение вывода количества записей
		SELECT TOP 3 * FROM TelephoneNumberUser ORDER BY f_name ASC;
---- 5.2 С сортировкой по убыванию DESC
		SELECT * FROM TelephoneNumberUser ORDER BY f_name DESC;
---- 5.3 С сортировкой по двум атрибутам + ограничение вывода количества записей
		SELECT TOP 3 * FROM TelephoneNumberUser ORDER BY f_name, l_name DESC;
---- 5.4 С сортировкой по первому атрибуту, из списка извлекаемых
		SELECT * FROM TelephoneNumberUser ORDER BY f_name

-- 6. Работа с датами. Необходимо, чтобы одна из таблиц содержала атрибут с типом DATETIME.
---- 6.1 WHERE по дате
		SELECT * FROM TelephoneNumberUser WHERE date_of_birth = '2015-12-25T15:32:06.427';
---- 6.2 Извлечь из таблицы не всю дату, а только год. Например, год рождения автора.
		SELECT YEAR(date_of_birth) AS year_of_birth FROM TelephoneNumberUser;

-- 7. SELECT GROUP BY с функциями агрегации
----7.1 MIN
		SELECT f_name, MIN(id_telephone_number_user) AS min_id_telephone_number_user FROM TelephoneNumberUser GROUP BY f_name;
----7.2 MAX
		SELECT f_name, MAX(id_telephone_number_user) AS max_id_telephone_number_user FROM TelephoneNumberUser GROUP BY f_name;
----7.3 AVG
		SELECT f_name, AVG(id_telephone_number_user) AS avg_id_telephone_number_user FROM TelephoneNumberUser GROUP BY f_name;
----7.4 SUM 
		SELECT f_name, SUM(id_telephone_number_user) AS sum_id_telephone_number_user FROM TelephoneNumberUser GROUP BY f_name;
----7.5 COUNT
		SELECT f_name, COUNT(id_telephone_number_user) AS count_id_telephone_number_user FROM TelephoneNumberUser GROUP BY f_name;

-- 8. SELECT GROUP BY + HAVING
----8.1 Написать 3 разных запроса с использованием GROUP BY + HAVING
		SELECT f_name, MAX(id_telephone_number_user) AS max_id_telephone_number_user FROM TelephoneNumberUser GROUP BY f_name HAVING MAX(id_telephone_number_user) > 30;
		SELECT f_name, SUM(id_telephone_number_user) AS sum_id_telephone_number_user FROM TelephoneNumberUser GROUP BY f_name HAVING SUM(id_telephone_number_user) > 2;
		SELECT f_name, AVG(id_telephone_number_user) AS avg_id_telephone_number_user FROM TelephoneNumberUser GROUP BY f_name HAVING AVG(id_telephone_number_user) >= 27;

-- 9. SELECT JOIN
---- 9.1 LEFT JOIN двух таблиц и WHERE по одному из атрибутов
		SELECT * FROM TelephoneNumberUser LEFT JOIN TelephoneNumber ON TelephoneNumberUser.id_telephone_number_user = TelephoneNumber.id_telephone_number_user WHERE l_name = 'BNW';
---- 9.2 RIGHT JOIN. Получить такую же выборку, как и в 5.1
		SELECT * FROM TelephoneNumber RIGHT JOIN TelephoneNumberUser ON TelephoneNumberUser.id_telephone_number_user = TelephoneNumber.id_telephone_number_user WHERE l_name = 'BNW';
---- 9.3 LEFT JOIN трех таблиц + WHERE по атрибуту из каждой таблицы
		SELECT TelephoneNumberUser.id_telephone_number_user, TelephoneNumberUser.f_name, TelephoneNumberUser.gender, TelephoneNumber.id_telephone_number, TelephoneNumber.tariff, Payment.id_payment, Payment.date
		FROM
				TelephoneNumberUser LEFT JOIN TelephoneNumber ON TelephoneNumberUser.id_telephone_number_user = TelephoneNumber.id_telephone_number_user LEFT JOIN Payment ON TelephoneNumberUser.id_telephone_number_user = TelephoneNumber.id_telephone_number
        WHERE TelephoneNumberUser.id_telephone_number_user >= 0 AND gender = 1 AND id_telephone_number = 0;
---- 9.4 FULL OUTER JOIN двух таблиц
		SELECT * FROM TelephoneNumber FULL OUTER JOIN TelephoneNumberUser ON TelephoneNumber.id_telephone_number = TelephoneNumberUser.id_telephone_number_user

-- 10. Подзапросы
---- 10.1 Написать запрос с WHERE IN (подзапрос)
		SELECT * FROM TelephoneNumberUser WHERE date_of_birth IN ('2005-12-25T15:42:02.427', '2013-11-25T15:32:06.427');
---- 10.2 Написать запрос SELECT atr1, atr2, (подзапрос) FROM ...  
		SELECT id_telephone_number_user, f_name, l_name, (SELECT tariff FROM TelephoneNumber WHERE id_telephone_number_user = id_telephone_number_user) AS tariff FROM TelephoneNumberUser
















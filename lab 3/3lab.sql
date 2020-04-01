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

INSERT INTO TelephoneNumberUser VALUES(0, 'Anton', 'Fecalis', 1, 12-04-2088-12-00-00);
INSERT INTO TelephoneNumberUser VALUES(1, 'Misha', 'Ducalis', 1, 18-12-1988-12-00-00);
INSERT INTO TelephoneNumberUser VALUES(2, 'Anya', 'Kurich', 1, 28-11-1958-12-00-00);
INSERT INTO TelephoneNumberUser VALUES(3, 'Omae Va', 'Mu', 1, 21-12-2020-12-00-00);
INSERT INTO TelephoneNumberUser VALUES(4, 'Mers', 'BNW', 1, 28-12-1989-12-00-00);
INSERT INTO TelephoneNumberUser VALUES(5, 'BNW', 'M5', 1, 28-12-1968-12-00-00);
INSERT INTO TelephoneNumberUser VALUES(6, 'Denis', 'Suhachyov', 1, 12-12-1995-12-00-00);
INSERT INTO TelephoneNumberUser VALUES(7, 'Sasha', 'Citines', 1, 28-04-2188-12-00-00);
INSERT INTO TelephoneNumberUser VALUES(8, 'Sashok', 'Mayonez', 1, 22-08-1488-12-00-00);


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
---- 1.1 ��� �������� ������ �����
		INSERT INTO TelephoneNumberUser VALUES(54, 'Anton', 'Fecalis', 1, 28-12-1988-12-00-00);
---- 1.2 � �������� ������ �����
		INSERT INTO TelephoneNumber (id_telephone_number, id_service_on_telephone_number, id_telephone_number_user, telephone_number, tariff, place_of_registration) VALUES (0, 0, 0, 89871488228, 'SeregaVDele', 'Republic of Dagestan');
---- 1.3 � ������� �������� �� ������ �������
		INSERT INTO ServiceOnTelephoneNumber(name_of_service, price) SELECT category, number_of_services FROM TypeOfService;

-- 2.DELETE
---- 2.1 ���� �������
		DELETE TelephoneNumberUser;
---- 2.2 �� �������
		DELETE FROM TelephoneNumber WHERE id_telephone_number = 0;
---- 2.3 �������� �������
		TRUNCATE TABLE TelephoneNumber;

-- 3.UPDATE
---- 3.1 ���� �������
		UPDATE TelephoneNumber SET tariff = 'BulBulKarasik';
---- 3.2 �� �������, �������� ���� �������
		UPDATE TelephoneNumber SET tariff = 'BulBulKarasik' WHERE telephone_number = 89871488228;
---- 3.3 �� ������� �������� ��������� ���������
		UPDATE TelephoneNumberUser SET f_name = 'Mers', l_name = 'BNW' WHERE id_telephone_number_user = 54;

-- 4.SELECT
---- 4.1 � ������������ ������� ����������� ��������� (SELECT atr1, atr2 FROM...)
		SELECT telephone_number, tariff, place_of_registration FROM TelephoneNumber;
---- 4.2 �� ����� ���������� (SELECT * FROM...)
		SELECT * FROM TelephoneNumber;
---- 4.3 � �������� �� �������� (SELECT * FROM ... WHERE atr1 = "")
		SELECT * FROM TelephoneNumber WHERE id_phone_number = 0;

-- 5. SELECT ORDER BY + TOP (LIMIT)
---- 5.1 � ����������� �� ����������� ASC + ����������� ������ ���������� �������
		SELECT TOP 3 * FROM TelephoneNumberUser ORDER BY f_name ASC;
---- 5.2 � ����������� �� �������� DESC
		SELECT TOP 3 * FROM TelephoneNumberUser ORDER BY f_name DESC;
---- 5.3 � ����������� �� ���� ��������� + ����������� ������ ���������� �������
		SELECT TOP 3 * FROM TelephoneNumberUser ORDER BY f_name, l_name DESC;
---- 5.4 � ����������� �� ������� ��������, �� ������ �����������
		SELECT TOP 3 * FROM TelephoneNumberUser ORDER BY gender;

-- 6. ������ � ������. ����������, ����� ���� �� ������ ��������� ������� � ����� DATETIME.
---- 6.1 WHERE �� ����
		SELECT * FROM TelephoneNumberUser WHERE date_of_birth = '01/05/2020 13:40:54';
---- 6.2 ������� �� ������� �� ��� ����, � ������ ���. ��������, ��� �������� ������.
		SELECT date_of_birth, YEAR(date_of_birth) AS year_of_birth FROM TelephoneNumberUser;

-- 7. SELECT GROUP BY � ��������� ���������
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
----8.1 �������� 3 ������ ������� � �������������� GROUP BY + HAVING
		SELECT f_name FROM TelephoneNumberUser GROUP BY f_name HAVING MAX(id_telephone_number_user) > 30;
		SELECT f_name FROM TelephoneNumberUser GROUP BY f_name HAVING SUM(id_telephone_number_user) > 2;
		SELECT f_name FROM TelephoneNumberUser GROUP BY f_name HAVING AVG(id_telephone_number_user) > 27;

-- 9. SELECT JOIN
---- 9.1 LEFT JOIN ���� ������ � WHERE �� ������ �� ���������
		SELECT * FROM TelephoneNumberUser LEFT JOIN TelephoneNumber ON TelephoneNumberUser.id_telephone_number_user = TelephoneNumber.id_telephone_number_user WHERE l_name = 'BNW';
---- 9.2 RIGHT JOIN. �������� ����� �� �������, ��� � � 5.1
		SELECT * FROM TelephoneNumber RIGHT JOIN TelephoneNumberUser ON TelephoneNumberUser.id_telephone_number_user = TelephoneNumber.id_telephone_number_user WHERE l_name = 'BNW';
---- 9.3 LEFT JOIN ���� ������ + WHERE �� �������� �� ������ �������
		SELECT TelephoneNumberUser.id_telephone_number_user, TelephoneNumberUser.f_name, TelephoneNumber.id_telephone_number, TelephoneNumber.tariff, Payment.id_payment, Payment.date
		FROM
				TelephoneNumberUser LEFT JOIN TelephoneNumber ON TelephoneNumberUser.id_telephone_number_user = TelephoneNumber.id_telephone_number_user LEFT JOIN Payment ON TelephoneNumberUser.id_telephone_number_user = TelephoneNumber.id_telephone_number
        WHERE TelephoneNumberUser.id_telephone_number_user > 3 AND gender = 1 AND id_telephone_number > 0;
---- 9.4 FULL OUTER JOIN ���� ������
		SELECT * FROM TelephoneNumber FULL OUTER JOIN TelephoneNumberUser ON TelephoneNumber.id_telephone_number = TelephoneNumberUser.id_telephone_number_user

-- 10. ����������
---- 10.1 �������� ������ � WHERE IN (���������)
		SELECT * FROM TelephoneNumberUser WHERE date_of_birth IN (22-08-1488-12-00-00, 22-08-2020-12-00-00);
---- 10.2 �������� ������ SELECT atr1, atr2, (���������) FROM ...  
		SELECT id_telephone_number_user, id_service_on_telephone_number, (SELECT id_payment FROM Payment WHERE price > 0) AS id_payment FROM Payment
















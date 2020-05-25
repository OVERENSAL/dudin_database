Use TelephoneService
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
INSERT INTO TelephoneNumberUser VALUES(1, 'Misha', 'Ducalis', 1, '2014-12-25T15:32:06.427');
INSERT INTO TelephoneNumberUser VALUES(2, 'Anya', 'Kurich', 0, '2013-11-25T15:32:06.427');
INSERT INTO TelephoneNumberUser VALUES(3, 'Omae Va', 'Mu', 1, '2015-10-23T15:32:06.427');
INSERT INTO TelephoneNumberUser VALUES(4, 'Mers', 'BNW', 1, '2005-12-25T15:42:02.427');
INSERT INTO TelephoneNumberUser VALUES(5, 'BNW', 'M5', 1, '1995-12-25T15:32:06.427');
INSERT INTO TelephoneNumberUser VALUES(6, 'Denis', 'Suhachyov', 1, '1985-12-25T14:32:06.427');
INSERT INTO TelephoneNumberUser VALUES(7, 'Sasha', 'Citines', 1, '1923-12-15T15:32:06.427');
INSERT INTO TelephoneNumberUser VALUES(8, 'Sashok', 'Mayonez', 1, '2005-02-28T15:32:06.427');
INSERT INTO TelephoneNumberUser VALUES(9, 'Anton', 'Sergey', 1, '2015-12-25T15:32:06.427');

drop table TelephoneNumber

CREATE TABLE TelephoneNumber (
id_telephone_number int NOT NULL,
id_telephone_number_user int NOT NULL,
telephone_number varchar(12) NOT NULL,
tariff varchar(50) NOT NULL,  
place_of_registration varchar(50) NOT NULL,
PRIMARY KEY (id_telephone_number)
)
GO

INSERT INTO TelephoneNumber VALUES(0, 0, +79877000000, 'MishaNaKrishe', 'Republic of Mari El');
INSERT INTO TelephoneNumber VALUES(1, 1, +79877000001, 'SeregaVDele', 'Republic of Dagestan');
INSERT INTO TelephoneNumber VALUES(2, 2, +79877000002, 'VasyaNakrasil', 'Nizhegorodsky Region');
INSERT INTO TelephoneNumber VALUES(3, 3, +79877000003, 'KuriniiKrilishek', 'Republic of Dagestan');
INSERT INTO TelephoneNumber VALUES(4, 4, +79877000004, '100Problem', 'Republic of Dagestan');
INSERT INTO TelephoneNumber VALUES(5, 5, +79877000005, 'SamyiLuchshii', 'Republic of Dagestan');
INSERT INTO TelephoneNumber VALUES(6, 6, +79877000006, 'SamyiHudshii', 'Nizhegorodsky Region');
INSERT INTO TelephoneNumber VALUES(7, 7, +79877000007, 'ObozhaiyBD', 'Republic of Mari El');
INSERT INTO TelephoneNumber VALUES(8, 8, +79877000008, 'AecheOOP', 'Republic of Mari El');
INSERT INTO TelephoneNumber VALUES(9, 9, +79877000009, 'IDazheBackend', 'Republic of Mari El');

CREATE TABLE ServiceOnTelephoneNumber (
id_service_on_telephone_number int NOT NULL,
id_telephone_number int NOT NULL,
id_type_of_service int NOT NULL,
name_of_service varchar(50) NOT NULL,
price int NOT NULL,
PRIMARY KEY (id_service_on_telephone_number)
)
GO

drop table ServiceOnTelephoneNumber
delete ServiceOnTelephoneNumber

INSERT INTO ServiceOnTelephoneNumber VALUES(0, 0, 0, 'A', 100);
INSERT INTO ServiceOnTelephoneNumber VALUES(1, 0, 1, 'B', 130);
INSERT INTO ServiceOnTelephoneNumber VALUES(2, 0, 2, 'C', 140);
INSERT INTO ServiceOnTelephoneNumber VALUES(3, 1, 3, 'D', 120);
INSERT INTO ServiceOnTelephoneNumber VALUES(4, 1, 0, 'A', 130);
INSERT INTO ServiceOnTelephoneNumber VALUES(5, 2, 0, 'A', 110);
INSERT INTO ServiceOnTelephoneNumber VALUES(6, 3, 1, 'B', 120);
INSERT INTO ServiceOnTelephoneNumber VALUES(7, 3, 0, 'A', 130);
INSERT INTO ServiceOnTelephoneNumber VALUES(8, 4, 1, 'B', 110);
INSERT INTO ServiceOnTelephoneNumber VALUES(9, 5, 0, 'A', 90);
INSERT INTO ServiceOnTelephoneNumber VALUES(10, 5, 2, 'C',80);
INSERT INTO ServiceOnTelephoneNumber VALUES(11, 6, 2, 'C', 700);
INSERT INTO ServiceOnTelephoneNumber VALUES(12, 7, 3, 'D', 200);
INSERT INTO ServiceOnTelephoneNumber VALUES(13, 8, 3, 'D', 300);
INSERT INTO ServiceOnTelephoneNumber VALUES(14, 9, 3, 'D', 500);

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
		SELECT * FROM TelephoneNumber WHERE id_telephone_number = 0;

-- 5. SELECT ORDER BY + TOP (LIMIT)
---- 5.1 � ����������� �� ����������� ASC + ����������� ������ ���������� �������
		SELECT TOP 3 * FROM TelephoneNumberUser ORDER BY f_name ASC;
---- 5.2 � ����������� �� �������� DESC
		SELECT * FROM TelephoneNumberUser ORDER BY f_name DESC;
---- 5.3 � ����������� �� ���� ��������� + ����������� ������ ���������� �������
		SELECT TOP 3 * FROM TelephoneNumberUser ORDER BY f_name, l_name DESC;
---- 5.4 � ����������� �� ������� ��������, �� ������ �����������
		SELECT * FROM TelephoneNumberUser ORDER BY f_name

-- 6. ������ � ������. ����������, ����� ���� �� ������ ��������� ������� � ����� DATETIME.
---- 6.1 WHERE �� ����
		SELECT * FROM TelephoneNumberUser WHERE date_of_birth = '2015-12-25T15:32:06.427';
---- 6.2 ������� �� ������� �� ��� ����, � ������ ���. ��������, ��� �������� ������.
		SELECT YEAR(date_of_birth) AS year_of_birth FROM TelephoneNumberUser;

-- 7. SELECT GROUP BY � ��������� ���������
----7.1 MIN
		SELECT name_of_service, MIN(price) AS min_price FROM ServiceOnTelephoneNumber GROUP BY name_of_service;
----7.2 MAX
		SELECT name_of_service, MAX(price) AS max_price FROM ServiceOnTelephoneNumber GROUP BY name_of_service;
----7.3 AVG
		SELECT name_of_service, AVG(price) AS avg_price FROM ServiceOnTelephoneNumber GROUP BY name_of_service;
----7.4 SUM 
		SELECT telephone_number, SUM(price) AS sum_price FROM TelephoneNumber
		LEFT JOIN ServiceOnTelephoneNumber ON ServiceOnTelephoneNumber.id_telephone_number = TelephoneNumber.id_telephone_number
		GROUP BY telephone_number;
----7.5 COUNT
		SELECT telephone_number, COUNT(id_service_on_telephone_number) AS count_of_services FROM TelephoneNumber
		LEFT JOIN ServiceOnTelephoneNumber ON ServiceOnTelephoneNumber.id_telephone_number = TelephoneNumber.id_telephone_number
		GROUP BY telephone_number;

-- 8. SELECT GROUP BY + HAVING
----8.1 �������� 3 ������ ������� � �������������� GROUP BY + HAVING
		SELECT name_of_service, MAX(price) AS max_price FROM 
		ServiceOnTelephoneNumber GROUP BY name_of_service HAVING MAX(price) > 200;

		SELECT telephone_number, SUM(price) AS sum_price FROM TelephoneNumber
		LEFT JOIN ServiceOnTelephoneNumber ON ServiceOnTelephoneNumber.id_telephone_number = TelephoneNumber.id_telephone_number
		GROUP BY telephone_number HAVING SUM(price) < 200;

		SELECT telephone_number, COUNT(id_service_on_telephone_number) AS count_of_services FROM TelephoneNumber
		LEFT JOIN ServiceOnTelephoneNumber ON ServiceOnTelephoneNumber.id_telephone_number = TelephoneNumber.id_telephone_number
		GROUP BY telephone_number HAVING COUNT(id_service_on_telephone_number) >= 2;

-- 9. SELECT JOIN
---- 9.1 LEFT JOIN ���� ������ � WHERE �� ������ �� ���������
		SELECT * FROM TelephoneNumberUser LEFT JOIN TelephoneNumber ON TelephoneNumberUser.id_telephone_number_user = TelephoneNumber.id_telephone_number_user WHERE l_name = 'BNW';
---- 9.2 RIGHT JOIN. �������� ����� �� �������, ��� � � 5.1
		SELECT * FROM TelephoneNumber RIGHT JOIN TelephoneNumberUser ON TelephoneNumberUser.id_telephone_number_user = TelephoneNumber.id_telephone_number_user WHERE l_name = 'BNW';
---- 9.3 LEFT JOIN ���� ������ + WHERE �� �������� �� ������ �������
		SELECT TelephoneNumberUser.id_telephone_number_user, TelephoneNumberUser.f_name, TelephoneNumberUser.gender, TelephoneNumber.id_telephone_number, TelephoneNumber.tariff, Payment.id_payment, Payment.date
		FROM
				TelephoneNumberUser LEFT JOIN TelephoneNumber ON TelephoneNumberUser.id_telephone_number_user = TelephoneNumber.id_telephone_number_user LEFT JOIN Payment ON TelephoneNumberUser.id_telephone_number_user = TelephoneNumber.id_telephone_number
        WHERE TelephoneNumberUser.id_telephone_number_user >= 0 AND gender = 1 AND id_telephone_number = 0;
---- 9.4 FULL OUTER JOIN ���� ������
		SELECT * FROM TelephoneNumber FULL OUTER JOIN TelephoneNumberUser ON TelephoneNumber.id_telephone_number = TelephoneNumberUser.id_telephone_number_user

-- 10. ����������
---- 10.1 �������� ������ � WHERE IN (���������)
		SELECT * FROM TelephoneNumberUser WHERE date_of_birth IN ('2005-12-25T15:42:02.427', '2013-11-25T15:32:06.427');
---- 10.2 �������� ������ SELECT atr1, atr2, (���������) FROM ...  
		SELECT id_telephone_number_user, f_name, l_name, 
		(SELECT tariff FROM TelephoneNumber WHERE TelephoneNumber.id_telephone_number_user = TelephoneNumberUser.id_telephone_number_user) AS tariff FROM 
		TelephoneNumberUser
















use master

ALTER TABLE room ADD FOREIGN KEY (id_hotel) REFERENCES hotel (id_hotel);
ALTER TABLE room_in_booking ADD FOREIGN KEY (id_room) REFERENCES room (id_room);
ALTER TABLE room ADD FOREIGN KEY (id_room_category) REFERENCES room_category (id_room_category);
ALTER TABLE room_in_booking ADD FOREIGN KEY (id_booking) REFERENCES booking (id_booking);
ALTER TABLE booking ADD FOREIGN KEY (id_client) REFERENCES client (id_client);

--Выдать информацию о клиентах гостиницы “Космос”, проживающих в номерах категории “Люкс” на 1 апреля 2019г.

SELECT client.id_client, client.name, client.phone FROM client
LEFT JOIN booking ON client.id_client = booking.id_client
LEFT JOIN room_in_booking ON booking.id_booking = room_in_booking.id_room_in_booking
LEFT JOIN room ON room_in_booking.id_room = room.id_room
LEFT JOIN hotel ON room.id_hotel = hotel.id_hotel
LEFT JOIN room_category ON room.id_room_category = room_category.id_room_category
WHERE hotel.name = N'Космос' AND room_category.name = N'Люкс' AND (room_in_booking.checkin_date <= '2019-04-01' AND room_in_booking.checkout_date > '2019-04-01');

--Дать список свободных номеров всех гостиниц на 22 апреля.

SELECT room.id_hotel, room.id_room FROM room WHERE id_room NOT IN (
	SELECT room.id_room FROM room_in_booking 
	LEFT JOIN room ON room.id_room = room_in_booking.id_room
	WHERE ('2019-04-22' BETWEEN room_in_booking.checkin_date AND room_in_booking.checkout_date))
ORDER BY id_hotel, id_room ASC

--Дать количество проживающих в гостинице “Космос” на 23 марта по каждой категории номеров

SELECT COUNT(room_in_booking.id_room) AS clients,
	(SELECT name FROM room_category AS category WHERE category.id_room_category = room_category.id_room_category) AS
	category
	FROM room_in_booking
	LEFT JOIN room ON room_in_booking.id_room = room.id_room
	LEFT JOIN hotel ON hotel.id_hotel = room.id_hotel
	LEFT JOIN room_category ON room_category.id_room_category = room.id_room_category
	WHERE
		hotel.name = N'Космос' AND ('2019-03-23' BETWEEN room_in_booking.checkin_date AND room_in_booking.checkout_date)
	GROUP BY
	    room_category.id_room_category

--Дать список последних проживавших клиентов по всем комнатам гостиницы “Космос”, выехавшим в апреле с указанием даты выезда

SELECT client.name, client.phone, room_in_booking.checkout_date FROM client
LEFT JOIN booking ON booking.id_client = client.id_client 
LEFT JOIN room_in_booking ON room_in_booking.id_booking = booking.id_booking
LEFT JOIN (SELECT room_in_booking.id_room, MAX(room_in_booking.checkout_date) AS max_checkout_date 
	FROM (SELECT * FROM room_in_booking WHERE room_in_booking.checkout_date BETWEEN '2019-04-01' AND '2019-04-30') AS room_in_booking 
	GROUP BY room_in_booking.id_room) AS booking_room ON booking_room.id_room =  room_in_booking.id_room
INNER JOIN room ON room_in_booking.id_room = room.id_room
WHERE (room_in_booking.id_room = booking_room.id_room AND booking_room.max_checkout_date = room_in_booking.checkout_date AND room.id_hotel = 1)
ORDER BY room.id_room

--Продлить на 2 дня дату проживания в гостинице “Космос” всем клиентам комнат категории “Бизнес”, которые заселились 10 мая.

UPDATE room_in_booking
SET checkout_date = DATEADD(day, 2, checkout_date)
FROM room
	INNER JOIN room_category ON room_category.id_room_category = room.id_room_category
	INNER JOIN hotel ON hotel.id_hotel = room.id_hotel
WHERE hotel.name = N'Космос' AND room_category.name = N'Бизнес' AND room_in_booking.checkin_date = '2019-05-10'

--Найти все "пересекающиеся" варианты проживания.

SELECT * FROM room_in_booking
INNER JOIN room_in_booking AS room_in_booking2 ON room_in_booking.id_room = room_in_booking2.id_room 
WHERE 
	room_in_booking.id_room_in_booking != room_in_booking2.id_room_in_booking AND 
	(room_in_booking.checkin_date <= room_in_booking2.checkin_date AND room_in_booking2.checkin_date < room_in_booking.checkout_date)
ORDER BY room_in_booking.id_room_in_booking

--Создать бронирование в транзакции

BEGIN TRANSACTION
	INSERT INTO client VALUES (N'Дудин Николай Александрович', '3(224)228334')
	INSERT INTO booking VALUES (SCOPE_IDENTITY(), '2020-05-12')
	INSERT INTO room_in_booking VALUES(SCOPE_IDENTITY(), 54, '2020-05-12', '2020-05-13')
COMMIT;

--Индексы

CREATE NONCLUSTERED INDEX [IX_booking_id_client] ON booking (id_client)
CREATE NONCLUSTERED INDEX [IX_client_name] ON client (name)
CREATE NONCLUSTERED INDEX [IX_hotel_name] ON hotel (name)
CREATE NONCLUSTERED INDEX [IX_room_in_booking_id_room] ON room_in_booking (id_room)
CREATE NONCLUSTERED INDEX [IX_room_in_booking_id_booking] ON room_in_booking (id_booking)
CREATE NONCLUSTERED INDEX [IX_room_id_room_category] ON room (id_room_category)
CREATE NONCLUSTERED INDEX [IX_room_id_booking_checkinout_date] ON room_in_booking (checkin_date ASC, checkout_date ASC)
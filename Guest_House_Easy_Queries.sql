---------------------------- Guest House Easy Problems -------------------------------------

--1. Guest 1183. Give the booking_date and the number of nights for guest 1183. -----------
SELECT
	booking_date,
	nights
FROM
	booking
WHERE
	guest_id = 1183;

--2. When do they get here? List the arrival time and the first and last names for all guests due to arrive on 2016-11-05, order the output by time of arrival.---------
SELECT
	booking.arrival_time,
	guest.first_name,
	guest.last_name
FROM
	booking
	JOIN
		guest
		ON (booking.guest_id = guest.id)
WHERE
	YEAR(booking.booking_date) = '2016'
	AND MONTH(booking.booking_date) = '11'
	AND DAY(booking.booking_date) = '05'
ORDER BY
	booking.arrival_time;

--3. Look up daily rates. Give the daily rate that should be paid for bookings with ids 5152, 5165, 5154 and 5295. Include booking id, room type, number of occupants and the amount.--------
SELECT
	booking.booking_id,
	booking.room_type_requested,
	booking.occupants,
	rate.amount
FROM
	booking
	JOIN
		rate
		ON (booking.occupants = rate.occupancy
		AND booking.room_type_requested = rate.room_type)
WHERE
	booking.booking_id = 5152
	OR booking.booking_id = 5154
	OR booking.booking_id = 5295;

--4.Who’s in 101? Find who is staying in room 101 on 2016-12-03, include first name, last name and address. --------------------
SELECT
	guest.first_name,
	guest.last_name,
	guest.address
FROM
	guest
	JOIN
		booking
		ON (booking.guest_id = guest.id)
WHERE
	booking.room_no = 101
	AND booking.booking_date = '2016-12-03';

--5. How many bookings, how many nights? For guests 1185 and 1270 show the number of bookings made and the total number of nights. Your output should include the guest id and the total number of bookings and the total number of nights.-------
SELECT
	guest_id,
	COUNT(nights),
	sum(nights)
FROM
	booking
WHERE
	guest_id = 1185
	OR guest_id = 1270
GROUP BY
	guest_id;


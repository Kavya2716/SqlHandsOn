---------------------------- Guest House Medium Problems -------------------------------------

--1. Ruth Cadbury. Show the total amount payable by guest Ruth Cadbury for her room bookings. You should JOIN to the rate table using room_type_requested and occupants.-----------
SELECT
	SUM(booking.nights * rate.amount)
FROM
	booking
	JOIN
		rate
		ON (booking.occupants = rate.occupancy
		AND booking.room_type_requested = rate.room_type)
	JOIN
		guest
		ON (guest.id = booking.guest_id)
WHERE
	guest.first_name = 'Ruth'
	AND guest.last_name = 'Cadbury';

--2. Including Extras. Calculate the total bill for booking 5346 including extras.-------------
SELECT
	SUM(booking.nights * rate.amount) + SUM(e.amount) AS Total
FROM
	booking
	JOIN
		rate
		ON (booking.occupants = rate.occupancy
		AND booking.room_type_requested = rate.room_type)
	JOIN
		(
			SELECT
				booking_id,
				SUM(amount) as amount
			FROM
				extra
			group by
				booking_id
		)
		AS e
		ON (e.booking_id = booking.booking_id)
WHERE
	booking.booking_id = 5128;

--3. Edinburgh Residents. For every guest who has the word “Edinburgh” in their address show the total number of nights booked. Be sure to include 0 for those guests who have never had a booking. Show last name, first name, address and number of nights. Order by last name then first name.------------
SELECT
	guest.last_name,
	guest.first_name,
	guest.address,
	CASE
		WHEN
			SUM(booking.nights) IS NULL
		THEN
			0
		ELSE
			SUM(booking.nights)
	END
	AS nights
FROM
	booking
	RIGHT JOIN
		guest
		ON (guest.id = booking.guest_id)
WHERE
	guest.address LIKE '%Edinburgh%'
GROUP BY
	guest.last_name, guest.first_name, guest.address
ORDER BY
	guest.last_name, guest.first_name;

--4. How busy are we? For each day of the week beginning 2016-11-25 show the number of bookings starting that day. Be sure to show all the days of the week in the correct order.--------------
SELECT
	booking_date AS i,
	COUNT(booking_id) AS arrivals
FROM
	booking
WHERE
	booking_date BETWEEN '2016-11-25' AND '2016-12-01'
GROUP BY
	booking_date;

--5. How many guests? Show the number of guests in the hotel on the night of 2016-11-21. Include all occupants who checked in that day but not those who checked out.-------
SELECT
	SUM(occupants)
FROM
	booking
WHERE
	booking_date <= '2016-11-21'
	AND DATE_ADD(booking_date, INTERVAL nights DAY) > '2016-11-21';
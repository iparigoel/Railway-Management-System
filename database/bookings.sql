USE railwayreservationsystem;

ALTER TABLE booking
ADD COLUMN pnr_number VARCHAR(10) UNIQUE;

UPDATE booking
SET pnr_number = 'PNR10001'
WHERE booking_id = 1;

UPDATE booking
SET pnr_number = 'PNR10002'
WHERE booking_id = 2;

UPDATE booking
SET pnr_number = 'PNR10003'
WHERE booking_id = 4;

UPDATE booking
SET pnr_number = 'PNR10004'
WHERE booking_id = 6;

UPDATE booking
SET pnr_number = 'PNR10005'
WHERE booking_id = 7;

DROP TABLE IF EXISTS cancellation;

CREATE TABLE cancellation (
cancellation_id INT NOT NULL AUTO_INCREMENT,
booking_id INT NOT NULL,
cancellation_date DATE NOT NULL,
reason VARCHAR(200),
refund_amount DECIMAL(10,2) DEFAULT 0.00,
PRIMARY KEY (cancellation_id),
FOREIGN KEY (booking_id) REFERENCES booking(booking_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

SELECT *
FROM booking;

SELECT *
FROM booking
WHERE booking_status = 'Confirmed';

SELECT *
FROM booking
WHERE booking_status = 'Cancelled';

SELECT *
FROM booking
WHERE booking_id = 1;

SELECT *
FROM booking
WHERE pnr_number = 'PNR10001';

SELECT
b.booking_id,
b.pnr_number,
b.passenger_name,
b.journey_date,
b.booking_status,
s.seat_number,
s.seat_type,
c.coach_number,
c.coach_type,
t.train_number,
t.train_name
FROM booking b
JOIN seat s
ON b.seat_id = s.seat_id
JOIN coach c
ON s.coach_id = c.coach_id
JOIN train t
ON c.train_id = t.train_id;

SELECT
b.pnr_number,
b.passenger_name,
b.journey_date,
b.booking_status,
s.seat_number,
s.seat_type,
c.coach_number,
c.coach_type,
t.train_number,
t.train_name
FROM booking b
JOIN seat s
ON b.seat_id = s.seat_id
JOIN coach c
ON s.coach_id = c.coach_id
JOIN train t
ON c.train_id = t.train_id
WHERE b.pnr_number = 'PNR10001';

SELECT
b.booking_id,
b.pnr_number,
b.passenger_name,
b.journey_date,
b.booking_status
FROM booking b
WHERE b.passenger_name = 'Murtaza Ansari';

INSERT INTO booking
(seat_id, journey_date, passenger_name, booking_status, pnr_number)
VALUES
(1, '2026-09-12', 'Priya Verma', 'Confirmed', 'PNR10006');

UPDATE booking
SET passenger_name = 'Priya Sharma'
WHERE booking_id = 8;

UPDATE booking
SET booking_status = 'Confirmed'
WHERE booking_id = 8;

SELECT
sa.availability_id,
sa.seat_id,
sa.journey_date,
sa.status,
s.seat_number,
s.seat_type
FROM seatavailability sa
JOIN seat s
ON sa.seat_id = s.seat_id
WHERE sa.journey_date = '2026-09-11'
AND sa.status = 'Available';

SELECT
s.seat_id,
s.seat_number,
s.seat_type,
sa.journey_date,
sa.status
FROM seat s
JOIN seatavailability sa
ON s.seat_id = sa.seat_id
WHERE s.coach_id = 1
AND sa.journey_date = '2026-09-11'
AND sa.status = 'Available';

UPDATE booking
SET booking_status = 'Cancelled'
WHERE booking_id = 1;

UPDATE seatavailability
SET status = 'Available'
WHERE seat_id = (
SELECT seat_id
FROM booking
WHERE booking_id = 1
)
AND journey_date = (
SELECT journey_date
FROM booking
WHERE booking_id = 1
);

INSERT INTO cancellation
(booking_id, cancellation_date, reason, refund_amount)
VALUES
(1, '2026-09-08', 'Passenger cancelled the journey', 500.00);

SELECT
c.cancellation_id,
c.booking_id,
b.pnr_number,
b.passenger_name,
b.journey_date,
c.cancellation_date,
c.reason,
c.refund_amount
FROM cancellation c
JOIN booking b
ON c.booking_id = b.booking_id;

SELECT
c.cancellation_id,
b.pnr_number,
b.passenger_name,
b.journey_date,
c.cancellation_date,
c.reason,
c.refund_amount
FROM cancellation c
JOIN booking b
ON c.booking_id = b.booking_id
WHERE b.pnr_number = 'PNR10001';

SELECT
b.passenger_name,
b.pnr_number,
b.journey_date,
c.cancellation_date,
c.reason,
c.refund_amount
FROM cancellation c
JOIN booking b
ON c.booking_id = b.booking_id
WHERE b.passenger_name = 'Murtaza Ansari';

SELECT COUNT(*) AS total_confirmed_bookings
FROM booking
WHERE booking_status = 'Confirmed';

SELECT COUNT(*) AS total_cancelled_bookings
FROM booking
WHERE booking_status = 'Cancelled';

SELECT
SUM(refund_amount) AS total_refund_amount
FROM cancellation;

SELECT
b.booking_id,
b.pnr_number,
b.passenger_name,
b.booking_status,
b.journey_date,
s.seat_number,
c.coach_number,
t.train_name
FROM booking b
JOIN seat s
ON b.seat_id = s.seat_id
JOIN coach c
ON s.coach_id = c.coach_id
JOIN train t
ON c.train_id = c.train_id
WHERE b.journey_date = '2026-09-10';

SELECT
t.train_number,
t.train_name,
COUNT(b.booking_id) AS total_bookings
FROM train t
JOIN coach c
ON t.train_id = c.train_id
JOIN seat s
ON c.coach_id = s.coach_id
JOIN booking b
ON s.seat_id = b.seat_id
GROUP BY t.train_id, t.train_number, t.train_name;

SELECT
s.seat_id,
s.seat_number,
COUNT(b.booking_id) AS total_bookings
FROM seat s
JOIN booking b
ON s.seat_id = b.seat_id
WHERE b.booking_status = 'Confirmed'
GROUP BY s.seat_id, s.seat_number
ORDER BY total_bookings DESC;

SELECT
b.pnr_number,
b.passenger_name,
b.journey_date,
b.booking_status,
t.train_name,
c.coach_number,
s.seat_number
FROM booking b
JOIN seat s
ON b.seat_id = s.seat_id
JOIN coach c
ON s.coach_id = c.coach_id
JOIN train t
ON c.train_id = t.train_id
WHERE b.passenger_name = 'Rahul Sharma'
ORDER BY b.journey_date DESC;

DELETE FROM cancellation
WHERE cancellation_id = 1;

USE railwayreservationsystem;

DROP TABLE IF EXISTS payment;
DROP TABLE IF EXISTS admin;

CREATE TABLE payment (
    payment_id INT NOT NULL AUTO_INCREMENT,
    booking_id INT NOT NULL,
    payment_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(30) NOT NULL,
    payment_status VARCHAR(20) NOT NULL,
    transaction_id VARCHAR(50) UNIQUE,
    PRIMARY KEY (payment_id),
    FOREIGN KEY (booking_id)
        REFERENCES booking(booking_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE admin (
    admin_id INT NOT NULL AUTO_INCREMENT,
    admin_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL DEFAULT 'ADMIN',
    PRIMARY KEY (admin_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO admin
(admin_name, email, password, role)
VALUES
('System Administrator', 'admin@railway.com', 'admin123', 'ADMIN'),
('Railway Manager', 'manager@railway.com', 'manager123', 'MANAGER');

INSERT INTO payment
(booking_id, amount, payment_method, payment_status, transaction_id)
VALUES
(1, 2500.00, 'UPI', 'SUCCESS', 'TXN10001'),
(2, 1800.00, 'CARD', 'SUCCESS', 'TXN10002'),
(3, 3200.00, 'NET BANKING', 'PENDING', 'TXN10003');

SELECT *
FROM admin;

SELECT *
FROM payment;

SELECT
    p.payment_id,
    p.booking_id,
    p.payment_date,
    p.amount,
    p.payment_method,
    p.payment_status,
    p.transaction_id
FROM payment p
ORDER BY p.payment_id;

SELECT
    p.payment_method,
    COUNT(*) AS total_transactions,
    SUM(p.amount) AS total_amount
FROM payment p
WHERE p.payment_status = 'SUCCESS'
GROUP BY p.payment_method;

SELECT
    p.payment_status,
    COUNT(*) AS total_transactions,
    SUM(p.amount) AS total_amount
FROM payment p
GROUP BY p.payment_status;

SELECT
    COUNT(*) AS total_payments,
    SUM(amount) AS total_payment_amount
FROM payment
WHERE payment_status = 'SUCCESS';

CREATE OR REPLACE VIEW booking_report AS
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

CREATE OR REPLACE VIEW payment_report AS
SELECT
    p.payment_id,
    p.booking_id,
    b.pnr_number,
    b.passenger_name,
    b.journey_date,
    p.amount,
    p.payment_method,
    p.payment_status,
    p.transaction_id
FROM payment p
JOIN booking b
    ON p.booking_id = b.booking_id;

CREATE OR REPLACE VIEW train_route_report AS
SELECT
    t.train_number,
    t.train_name,
    r.stop_no,
    s.station_name,
    s.city,
    r.arrival_time,
    r.departure_time,
    r.distance_km
FROM train t
JOIN route r
    ON t.train_id = r.train_id
JOIN station s
    ON r.station_id = s.station_id;

SELECT *
FROM booking_report;

SELECT *
FROM payment_report;

SELECT *
FROM train_route_report;

SELECT
    t.train_number,
    t.train_name,
    COUNT(DISTINCT b.booking_id) AS total_bookings
FROM train t
JOIN coach c
    ON t.train_id = c.train_id
JOIN seat s
    ON c.coach_id = s.coach_id
JOIN booking b
    ON s.seat_id = b.seat_id
GROUP BY
    t.train_id,
    t.train_number,
    t.train_name;

SELECT
    b.booking_status,
    COUNT(*) AS total_bookings
FROM booking b
GROUP BY b.booking_status;

SELECT
    c.coach_type,
    COUNT(s.seat_id) AS total_seats
FROM coach c
JOIN seat s
    ON c.coach_id = s.coach_id
GROUP BY c.coach_type;

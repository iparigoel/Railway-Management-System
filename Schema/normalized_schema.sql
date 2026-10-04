-- Railway Management System
-- Normalized Database Schema (1NF -> 2NF -> 3NF)
-- Based on the uploaded project SQL files.

CREATE DATABASE IF NOT EXISTS railwayreservationsystem;
USE railwayreservationsystem;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS cancellation;
DROP TABLE IF EXISTS payment;
DROP TABLE IF EXISTS booking;
DROP TABLE IF EXISTS seatavailability;
DROP TABLE IF EXISTS seat;
DROP TABLE IF EXISTS coach;
DROP TABLE IF EXISTS route;
DROP TABLE IF EXISTS station;
DROP TABLE IF EXISTS train;
DROP TABLE IF EXISTS passenger;
DROP TABLE IF EXISTS admin;
SET FOREIGN_KEY_CHECKS = 1;

-- =========================
-- 1. PASSENGER
-- =========================
CREATE TABLE passenger (
    passenger_id INT NOT NULL AUTO_INCREMENT,
    passenger_name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    gender VARCHAR(10) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(100) NOT NULL,
    PRIMARY KEY (passenger_id),
    UNIQUE KEY uq_passenger_phone (phone),
    UNIQUE KEY uq_passenger_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =========================
-- 2. TRAIN
-- =========================
CREATE TABLE train (
    train_id INT NOT NULL AUTO_INCREMENT,
    train_number VARCHAR(10) NOT NULL,
    train_name VARCHAR(100) NOT NULL,
    PRIMARY KEY (train_id),
    UNIQUE KEY uq_train_number (train_number)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =========================
-- 3. STATION
-- =========================
CREATE TABLE station (
    station_id INT NOT NULL AUTO_INCREMENT,
    station_name VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    PRIMARY KEY (station_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =========================
-- 4. COACH
-- =========================
CREATE TABLE coach (
    coach_id INT NOT NULL AUTO_INCREMENT,
    train_id INT NOT NULL,
    coach_number VARCHAR(10) NOT NULL,
    coach_type VARCHAR(50) NOT NULL,
    total_seats INT NOT NULL,
    PRIMARY KEY (coach_id),
    KEY idx_coach_train (train_id),
    CONSTRAINT fk_coach_train
        FOREIGN KEY (train_id) REFERENCES train(train_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =========================
-- 5. SEAT
-- =========================
CREATE TABLE seat (
    seat_id INT NOT NULL AUTO_INCREMENT,
    coach_id INT NOT NULL,
    seat_number INT NOT NULL,
    seat_type VARCHAR(20) NOT NULL,
    PRIMARY KEY (seat_id),
    KEY idx_seat_coach (coach_id),
    CONSTRAINT fk_seat_coach
        FOREIGN KEY (coach_id) REFERENCES coach(coach_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =========================
-- 6. ROUTE
-- =========================
CREATE TABLE route (
    route_id INT NOT NULL AUTO_INCREMENT,
    train_id INT NOT NULL,
    station_id INT NOT NULL,
    arrival_time TIME,
    departure_time TIME,
    stop_no INT NOT NULL,
    distance_km DECIMAL(8,2),
    PRIMARY KEY (route_id),
    KEY idx_route_train (train_id),
    KEY idx_route_station (station_id),
    UNIQUE KEY uq_route_train_station (train_id, station_id),
    CONSTRAINT fk_route_train
        FOREIGN KEY (train_id) REFERENCES train(train_id),
    CONSTRAINT fk_route_station
        FOREIGN KEY (station_id) REFERENCES station(station_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =========================
-- 7. BOOKING
-- Normalization change:
-- passenger_name has been removed.
-- passenger_id references PASSENGER.
-- =========================
CREATE TABLE booking (
    booking_id INT NOT NULL AUTO_INCREMENT,
    pnr_number VARCHAR(10) NOT NULL,
    passenger_id INT NOT NULL,
    seat_id INT NOT NULL,
    journey_date DATE NOT NULL,
    booking_status VARCHAR(20) NOT NULL DEFAULT 'Confirmed',
    PRIMARY KEY (booking_id),
    UNIQUE KEY uq_booking_pnr (pnr_number),
    KEY idx_booking_passenger (passenger_id),
    KEY idx_booking_seat (seat_id),
    CONSTRAINT fk_booking_passenger
        FOREIGN KEY (passenger_id) REFERENCES passenger(passenger_id),
    CONSTRAINT fk_booking_seat
        FOREIGN KEY (seat_id) REFERENCES seat(seat_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =========================
-- 8. SEAT AVAILABILITY
-- =========================
CREATE TABLE seatavailability (
    availability_id INT NOT NULL AUTO_INCREMENT,
    seat_id INT NOT NULL,
    journey_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL,
    PRIMARY KEY (availability_id),
    UNIQUE KEY uq_seat_date (seat_id, journey_date),
    CONSTRAINT fk_availability_seat
        FOREIGN KEY (seat_id) REFERENCES seat(seat_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =========================
-- 9. PAYMENT
-- =========================
CREATE TABLE payment (
    payment_id INT NOT NULL AUTO_INCREMENT,
    booking_id INT NOT NULL,
    payment_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(30) NOT NULL,
    payment_status VARCHAR(20) NOT NULL,
    transaction_id VARCHAR(50) UNIQUE,
    PRIMARY KEY (payment_id),
    KEY idx_payment_booking (booking_id),
    CONSTRAINT fk_payment_booking
        FOREIGN KEY (booking_id) REFERENCES booking(booking_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =========================
-- 10. CANCELLATION
-- =========================
CREATE TABLE cancellation (
    cancellation_id INT NOT NULL AUTO_INCREMENT,
    booking_id INT NOT NULL,
    cancellation_date DATE NOT NULL,
    reason VARCHAR(200),
    refund_amount DECIMAL(10,2) DEFAULT 0.00,
    PRIMARY KEY (cancellation_id),
    KEY idx_cancellation_booking (booking_id),
    CONSTRAINT fk_cancellation_booking
        FOREIGN KEY (booking_id) REFERENCES booking(booking_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =========================
-- 11. ADMIN
-- =========================
CREATE TABLE admin (
    admin_id INT NOT NULL AUTO_INCREMENT,
    admin_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL DEFAULT 'ADMIN',
    PRIMARY KEY (admin_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =========================
-- SAMPLE DATA FROM PROJECT
-- =========================

INSERT INTO passenger
(passenger_id, passenger_name, age, gender, phone, email, password)
VALUES
(1,'Murtaza Ansari',21,'Male','9876543210','murtaza@gmail.com','Murtaza@123'),
(2,'Ali Khan',24,'Male','9876543211','ali@gmail.com','Ali@123'),
(3,'Rahul Sharma',25,'Male','9876543212','rahul@gmail.com','Rahul@123'),
(4,'Priya Verma',22,'Female','9876543213','priya@gmail.com','Priya@123'),
(5,'Ahmed Khan',30,'Male','9876543214','ahmed@gmail.com','Ahmed@123'),
(6,'Sameer Khan',27,'Male','9876543215','sameer@gmail.com','Sameer@123');

INSERT INTO train (train_id, train_number, train_name)
VALUES
(1,'12951','Mumbai Rajdhani Express'),
(2,'12301','Kolkata Rajdhani Express'),
(3,'12009','Shatabdi Express');

INSERT INTO station (station_id, station_name, city)
VALUES
(1,'Mumbai Central','Mumbai'),
(2,'New Delhi','Delhi'),
(3,'Kota Junction','Kota'),
(4,'Vadodara Junction','Vadodara'),
(5,'Ahmedabad Junction','Ahmedabad'),
(6,'Kolkata Howrah','Kolkata'),
(7,'Kanpur Central','Kanpur'),
(8,'Bhopal Junction','Bhopal'),
(9,'Agra Cantt','Agra'),
(10,'Chennai Central','Chennai');

INSERT INTO coach (coach_id, train_id, coach_number, coach_type, total_seats)
VALUES
(1,1,'S1','Sleeper',72),
(2,1,'S2','Sleeper',72),
(3,1,'A1','AC',48),
(4,2,'S1','Sleeper',72),
(5,2,'A1','AC',48);

INSERT INTO seat (seat_id, coach_id, seat_number, seat_type)
VALUES
(1,1,1,'Lower'),
(2,1,2,'Middle'),
(3,1,3,'Upper'),
(4,1,4,'Lower'),
(5,1,5,'Middle'),
(6,1,6,'Upper');

INSERT INTO route
(route_id, train_id, station_id, arrival_time, departure_time, stop_no, distance_km)
VALUES
(1,1,1,'00:00:00','17:00:00',1,0.00),
(2,1,4,'20:30:00','20:35:00',2,392.00),
(3,1,5,'22:30:00','22:35:00',3,491.00),
(4,1,2,'08:00:00','08:10:00',4,1384.00),
(5,2,6,'16:00:00','16:30:00',1,0.00),
(6,2,7,'22:30:00','22:35:00',2,440.00),
(7,2,9,'02:30:00','02:35:00',3,800.00),
(8,2,2,'10:00:00','10:10:00',4,1450.00),
(9,3,2,'06:00:00','06:15:00',1,0.00),
(10,3,9,'08:30:00','08:35:00',2,200.00),
(11,3,8,'12:00:00','12:10:00',3,700.00);

INSERT INTO booking
(booking_id, pnr_number, passenger_id, seat_id, journey_date, booking_status)
VALUES
(1,'PNR10001',1,3,'2026-09-10','Cancelled'),
(2,'PNR10002',2,5,'2026-09-10','Cancelled'),
(4,'PNR10003',5,6,'2026-09-10','Confirmed'),
(6,'PNR10004',3,5,'2026-09-10','Confirmed'),
(7,'PNR10005',6,2,'2026-09-11','Confirmed'),
(8,'PNR10006',4,1,'2026-09-12','Confirmed');

INSERT INTO seatavailability
(availability_id, seat_id, journey_date, status)
VALUES
(1,1,'2026-09-10','Booked'),
(2,2,'2026-09-10','Booked'),
(3,3,'2026-09-10','Booked'),
(4,4,'2026-09-10','Booked'),
(5,5,'2026-09-10','Booked'),
(6,6,'2026-09-10','Booked'),
(7,1,'2026-09-11','Available'),
(8,2,'2026-09-11','Booked'),
(9,3,'2026-09-11','Available'),
(10,4,'2026-09-11','Available'),
(11,5,'2026-09-11','Available'),
(12,6,'2026-09-11','Available');

INSERT INTO payment
(payment_id, booking_id, amount, payment_method, payment_status, transaction_id)
VALUES
(1,1,2500.00,'UPI','SUCCESS','TXN10001'),
(2,2,1800.00,'CARD','SUCCESS','TXN10002'),
(3,4,3200.00,'NET BANKING','PENDING','TXN10003');

INSERT INTO cancellation
(cancellation_id, booking_id, cancellation_date, reason, refund_amount)
VALUES
(1,1,'2026-09-08','Passenger cancelled the journey',500.00);

INSERT INTO admin
(admin_id, admin_name, email, password, role)
VALUES
(1,'System Administrator','admin@railway.com','admin123','ADMIN'),
(2,'Railway Manager','manager@railway.com','manager123','MANAGER');

-- =========================
-- NORMALIZED REPORT VIEWS
-- =========================

CREATE OR REPLACE VIEW booking_report AS
SELECT
    b.booking_id,
    b.pnr_number,
    p.passenger_name,
    p.phone,
    p.email,
    b.journey_date,
    b.booking_status,
    s.seat_number,
    s.seat_type,
    c.coach_number,
    c.coach_type,
    t.train_number,
    t.train_name
FROM booking b
JOIN passenger p ON b.passenger_id = p.passenger_id
JOIN seat s ON b.seat_id = s.seat_id
JOIN coach c ON s.coach_id = c.coach_id
JOIN train t ON c.train_id = t.train_id;

CREATE OR REPLACE VIEW payment_report AS
SELECT
    p.payment_id,
    p.booking_id,
    b.pnr_number,
    pass.passenger_name,
    b.journey_date,
    p.amount,
    p.payment_method,
    p.payment_status,
    p.transaction_id
FROM payment p
JOIN booking b ON p.booking_id = b.booking_id
JOIN passenger pass ON b.passenger_id = pass.passenger_id;

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
JOIN route r ON t.train_id = r.train_id
JOIN station s ON r.station_id = s.station_id;

-- =========================
-- NORMALIZATION CHECK QUERIES
-- =========================

SELECT * FROM passenger;
SELECT * FROM train;
SELECT * FROM coach;
SELECT * FROM seat;
SELECT * FROM station;
SELECT * FROM route;
SELECT * FROM booking;
SELECT * FROM seatavailability;
SELECT * FROM payment;
SELECT * FROM cancellation;
SELECT * FROM admin;

SELECT * FROM booking_report;
SELECT * FROM payment_report;
SELECT * FROM train_route_report;

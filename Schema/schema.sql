-- ============================================================
-- Railway Management System — Database Schema
-- Database: railwayreservationsystem
-- Engine: MySQL / InnoDB
-- ============================================================

CREATE DATABASE IF NOT EXISTS railwayreservationsystem;
USE railwayreservationsystem;

-- ------------------------------------------------------------
-- 1. Passenger
-- ------------------------------------------------------------
CREATE TABLE passenger (
    passenger_id INT NOT NULL AUTO_INCREMENT,
    passenger_name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    gender VARCHAR(10) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(100) NOT NULL,
    PRIMARY KEY (passenger_id),
    UNIQUE KEY phone (phone),
    UNIQUE KEY email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------------------
-- 2. Admin
-- ------------------------------------------------------------
CREATE TABLE admin (
    admin_id INT NOT NULL AUTO_INCREMENT,
    admin_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL DEFAULT 'ADMIN',
    PRIMARY KEY (admin_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------------------
-- 3. Train
-- ------------------------------------------------------------
CREATE TABLE train (
    train_id INT NOT NULL AUTO_INCREMENT,
    train_number VARCHAR(10) NOT NULL,
    train_name VARCHAR(100) NOT NULL,
    PRIMARY KEY (train_id),
    UNIQUE KEY train_number (train_number)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------------------
-- 4. Coach
-- ------------------------------------------------------------
CREATE TABLE coach (
    coach_id INT NOT NULL AUTO_INCREMENT,
    train_id INT NOT NULL,
    coach_number VARCHAR(10) NOT NULL,
    coach_type VARCHAR(50) NOT NULL,
    total_seats INT NOT NULL,
    PRIMARY KEY (coach_id),
    FOREIGN KEY (train_id) REFERENCES train(train_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------------------
-- 5. Seat
-- ------------------------------------------------------------
CREATE TABLE seat (
    seat_id INT NOT NULL AUTO_INCREMENT,
    coach_id INT NOT NULL,
    seat_number INT NOT NULL,
    seat_type VARCHAR(20) NOT NULL,
    PRIMARY KEY (seat_id),
    FOREIGN KEY (coach_id) REFERENCES coach(coach_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------------------
-- 6. Seat Availability
-- ------------------------------------------------------------
CREATE TABLE seatavailability (
    availability_id INT NOT NULL AUTO_INCREMENT,
    seat_id INT NOT NULL,
    journey_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL,
    PRIMARY KEY (availability_id),
    UNIQUE KEY unique_seat_date (seat_id, journey_date),
    FOREIGN KEY (seat_id) REFERENCES seat(seat_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------------------
-- 7. Booking
-- ------------------------------------------------------------
CREATE TABLE booking (
    booking_id INT NOT NULL AUTO_INCREMENT,
    seat_id INT NOT NULL,
    journey_date DATE NOT NULL,
    passenger_name VARCHAR(100) NOT NULL,
    booking_status VARCHAR(20) NOT NULL DEFAULT 'Confirmed',
    pnr_number VARCHAR(10) UNIQUE,
    PRIMARY KEY (booking_id),
    FOREIGN KEY (seat_id) REFERENCES seat(seat_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------------------
-- 8. Cancellation
-- ------------------------------------------------------------
CREATE TABLE cancellation (
    cancellation_id INT NOT NULL AUTO_INCREMENT,
    booking_id INT NOT NULL,
    cancellation_date DATE NOT NULL,
    reason VARCHAR(200),
    refund_amount DECIMAL(10,2) DEFAULT 0.00,
    PRIMARY KEY (cancellation_id),
    FOREIGN KEY (booking_id) REFERENCES booking(booking_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------------------
-- 9. Payment
-- ------------------------------------------------------------
CREATE TABLE payment (
    payment_id INT NOT NULL AUTO_INCREMENT,
    booking_id INT NOT NULL,
    payment_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(30) NOT NULL,
    payment_status VARCHAR(20) NOT NULL,
    transaction_id VARCHAR(50) UNIQUE,
    PRIMARY KEY (payment_id),
    FOREIGN KEY (booking_id) REFERENCES booking(booking_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------------------
-- 10. Station
-- ------------------------------------------------------------
CREATE TABLE station (
    station_id INT NOT NULL AUTO_INCREMENT,
    station_name VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    PRIMARY KEY (station_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------------------
-- 11. Route
-- ------------------------------------------------------------
CREATE TABLE route (
    route_id INT NOT NULL AUTO_INCREMENT,
    train_id INT NOT NULL,
    station_id INT NOT NULL,
    arrival_time TIME,
    departure_time TIME,
    stop_no INT NOT NULL,
    distance_km DECIMAL(8,2),
    PRIMARY KEY (route_id),
    FOREIGN KEY (train_id) REFERENCES train(train_id),
    FOREIGN KEY (station_id) REFERENCES station(station_id),
    UNIQUE KEY unique_train_station (train_id, station_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

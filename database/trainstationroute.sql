USE railwayreservationsystem;

DROP TABLE IF EXISTS route;
DROP TABLE IF EXISTS station;

CREATE TABLE station (
    station_id INT NOT NULL AUTO_INCREMENT,
    station_name VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    PRIMARY KEY (station_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO station
(station_name, city)
VALUES
('Mumbai Central', 'Mumbai'),
('New Delhi', 'Delhi'),
('Kota Junction', 'Kota'),
('Vadodara Junction', 'Vadodara'),
('Ahmedabad Junction', 'Ahmedabad'),
('Kolkata Howrah', 'Kolkata'),
('Kanpur Central', 'Kanpur'),
('Bhopal Junction', 'Bhopal'),
('Agra Cantt', 'Agra'),
('Chennai Central', 'Chennai');

CREATE TABLE route (
    route_id INT NOT NULL AUTO_INCREMENT,
    train_id INT NOT NULL,
    station_id INT NOT NULL,
    arrival_time TIME,
    departure_time TIME,
    stop_no INT NOT NULL,
    distance_km DECIMAL(8,2),
    PRIMARY KEY (route_id),

    FOREIGN KEY (train_id)
        REFERENCES train(train_id),

    FOREIGN KEY (station_id)
        REFERENCES station(station_id),

    UNIQUE KEY unique_train_station (train_id, station_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO route
(train_id, station_id, arrival_time, departure_time, stop_no, distance_km)
VALUES
(1, 1, '00:00:00', '17:00:00', 1, 0.00),
(1, 4, '20:30:00', '20:35:00', 2, 392.00),
(1, 5, '22:30:00', '22:35:00', 3, 491.00),
(1, 2, '08:00:00', '08:10:00', 4, 1384.00);

INSERT INTO route
(train_id, station_id, arrival_time, departure_time, stop_no, distance_km)
VALUES
(2, 6, '16:00:00', '16:30:00', 1, 0.00),
(2, 7, '22:30:00', '22:35:00', 2, 440.00),
(2, 9, '02:30:00', '02:35:00', 3, 800.00),
(2, 2, '10:00:00', '10:10:00', 4, 1450.00);

INSERT INTO route
(train_id, station_id, arrival_time, departure_time, stop_no, distance_km)
VALUES
(3, 2, '06:00:00', '06:15:00', 1, 0.00),
(3, 9, '08:30:00', '08:35:00', 2, 200.00),
(3, 8, '12:00:00', '12:10:00', 3, 700.00);

SELECT *
FROM station;

SELECT *
FROM route;

SELECT
    t.train_number,
    t.train_name,
    s.station_name,
    s.city,
    r.stop_no,
    r.arrival_time,
    r.departure_time,
    r.distance_km
FROM route r
JOIN train t
    ON r.train_id = t.train_id
JOIN station s
    ON r.station_id = s.station_id
ORDER BY t.train_id, r.stop_no;

SELECT
    t.train_number,
    t.train_name,
    s.station_name,
    s.city,
    r.stop_no
FROM route r
JOIN train t
    ON r.train_id = t.train_id
JOIN station s
    ON r.station_id = s.station_id
WHERE t.train_id = 1
ORDER BY r.stop_no;

SELECT
    s.station_name,
    t.train_number,
    t.train_name,
    r.arrival_time,
    r.departure_time
FROM route r
JOIN station s
    ON r.station_id = s.station_id
JOIN train t
    ON r.train_id = t.train_id
WHERE s.station_name = 'New Delhi';

SELECT DISTINCT
    s.city,
    t.train_number,
    t.train_name
FROM route r
JOIN station s
    ON r.station_id = s.station_id
JOIN train t
    ON r.train_id = t.train_id
WHERE s.city = 'Mumbai';

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
    ON r.station_id = s.station_id
WHERE t.train_number = '12951'
ORDER BY r.stop_no;

SELECT
    t.train_number,
    t.train_name,
    s.station_name,
    s.city
FROM train t
JOIN route r
    ON t.train_id = r.train_id
JOIN station s
    ON r.station_id = s.station_id
WHERE r.stop_no = (
    SELECT MAX(r2.stop_no)
    FROM route r2
    WHERE r2.train_id = r.train_id
);

SELECT
    t.train_number,
    t.train_name,
    COUNT(r.station_id) AS total_stations
FROM train t
JOIN route r
    ON t.train_id = r.train_id
GROUP BY
    t.train_id,
    t.train_number,
    t.train_name;

SELECT
    t.train_number,
    t.train_name,
    MAX(r.distance_km) AS total_distance_km
FROM train t
JOIN route r
    ON t.train_id = r.train_id
GROUP BY
    t.train_id,
    t.train_number,
    t.train_name;

UPDATE route
SET departure_time = '08:15:00'
WHERE route_id = 4;

SELECT
    t.train_name,
    r.stop_no,
    s.station_name,
    s.city
FROM route r
JOIN train t
    ON r.train_id = t.train_id
JOIN station s
    ON r.station_id = s.station_id
WHERE t.train_id = 1
AND r.stop_no BETWEEN 2 AND 3
ORDER BY r.stop_no;

SELECT
    t.train_number,
    t.train_name,
    COUNT(r.station_id) AS total_stations
FROM train t
JOIN route r
    ON t.train_id = r.train_id
GROUP BY
    t.train_id,
    t.train_number,
    t.train_name
HAVING COUNT(r.station_id) > 2;

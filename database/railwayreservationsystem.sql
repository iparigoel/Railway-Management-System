
DROP TABLE IF EXISTS `booking`;

CREATE TABLE `booking` (
  `booking_id` int NOT NULL AUTO_INCREMENT,
  `seat_id` int NOT NULL,
  `journey_date` date NOT NULL,
  `passenger_name` varchar(100) NOT NULL,
  `booking_status` varchar(20) NOT NULL DEFAULT 'Confirmed',
  PRIMARY KEY (`booking_id`),
  KEY `booking_ibfk_1` (`seat_id`),
  CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`seat_id`) REFERENCES `seat` (`seat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


LOCK TABLES `booking` WRITE;

INSERT INTO `booking` VALUES (1,3,'2026-09-10','Murtaza Ansari','Confirmed'),(2,5,'2026-09-10','Ali Khan','Cancelled'),(4,6,'2026-09-10','Ahmed Khan','Confirmed'),(6,5,'2026-09-10','Rahul Sharma','Confirmed'),(7,2,'2026-09-11','Sameer Khan','Confirmed');

UNLOCK TABLES;



DROP TABLE IF EXISTS `coach`;

CREATE TABLE `coach` (
  `coach_id` int NOT NULL AUTO_INCREMENT,
  `train_id` int NOT NULL,
  `coach_number` varchar(10) NOT NULL,
  `coach_type` varchar(50) NOT NULL,
  `total_seats` int NOT NULL,
  PRIMARY KEY (`coach_id`),
  KEY `train_id` (`train_id`),
  CONSTRAINT `coach_ibfk_1` FOREIGN KEY (`train_id`) REFERENCES `train` (`train_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


LOCK TABLES `coach` WRITE;

INSERT INTO `coach` VALUES (1,1,'S1','Sleeper',72),(2,1,'S2','Sleeper',72),(3,1,'A1','AC',48),(4,2,'S1','Sleeper',72),(5,2,'A1','AC',48);

UNLOCK TABLES;



DROP TABLE IF EXISTS `seat`;

CREATE TABLE `seat` (
  `seat_id` int NOT NULL AUTO_INCREMENT,
  `coach_id` int NOT NULL,
  `seat_number` int NOT NULL,
  `seat_type` varchar(20) NOT NULL,
  PRIMARY KEY (`seat_id`),
  KEY `coach_id` (`coach_id`),
  CONSTRAINT `seat_ibfk_1` FOREIGN KEY (`coach_id`) REFERENCES `coach` (`coach_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


LOCK TABLES `seat` WRITE;

INSERT INTO `seat` VALUES (1,1,1,'Lower'),(2,1,2,'Middle'),(3,1,3,'Upper'),(4,1,4,'Lower'),(5,1,5,'Middle'),(6,1,6,'Upper');

UNLOCK TABLES;


DROP TABLE IF EXISTS `seatavailability`;

CREATE TABLE `seatavailability` (
  `availability_id` int NOT NULL AUTO_INCREMENT,
  `seat_id` int NOT NULL,
  `journey_date` date NOT NULL,
  `status` varchar(20) NOT NULL,
  PRIMARY KEY (`availability_id`),
  UNIQUE KEY `seat_id` (`seat_id`,`journey_date`),
  CONSTRAINT `seatavailability_ibfk_1` FOREIGN KEY (`seat_id`) REFERENCES `seat` (`seat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `seatavailability` WRITE;

INSERT INTO `seatavailability` VALUES (1,1,'2026-09-10','Booked'),(2,2,'2026-09-10','Booked'),(3,3,'2026-09-10','Booked'),(4,4,'2026-09-10','Booked'),(5,5,'2026-09-10','Booked'),(6,6,'2026-09-10','Booked'),(7,1,'2026-09-11','Available'),(8,2,'2026-09-11','Booked'),(9,3,'2026-09-11','Available'),(10,4,'2026-09-11','Available'),(11,5,'2026-09-11','Available'),(12,6,'2026-09-11','Available');

UNLOCK TABLES;



DROP TABLE IF EXISTS `train`;

CREATE TABLE `train` (
  `train_id` int NOT NULL AUTO_INCREMENT,
  `train_number` varchar(10) NOT NULL,
  `train_name` varchar(100) NOT NULL,
  PRIMARY KEY (`train_id`),
  UNIQUE KEY `train_number` (`train_number`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `train` WRITE;

INSERT INTO `train` VALUES (1,'12951','Mumbai Rajdhani Express'),(2,'12301','Kolkata Rajdhani Express'),(3,'12009','Shatabdi Express');

UNLOCK TABLES;

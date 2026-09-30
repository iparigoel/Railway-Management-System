USE railwayreservationsystem;

DROP TABLE IF EXISTS `passenger`;

CREATE TABLE `passenger` (
  `passenger_id` int NOT NULL AUTO_INCREMENT,
  `passenger_name` varchar(100) NOT NULL,
  `age` int NOT NULL,
  `gender` varchar(10) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  PRIMARY KEY (`passenger_id`),
  UNIQUE KEY `phone` (`phone`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `passenger` WRITE;

INSERT INTO `passenger`
VALUES
(1,'Murtaza Ansari',21,'Male','9876543210','murtaza@gmail.com','Murtaza@123'),
(2,'Ali Khan',24,'Male','9876543211','ali@gmail.com','Ali@123'),
(3,'Rahul Sharma',25,'Male','9876543212','rahul@gmail.com','Rahul@123'),
(4,'Priya Verma',22,'Female','9876543213','priya@gmail.com','Priya@123'),
(5,'Ahmed Khan',30,'Male','9876543214','ahmed@gmail.com','Ahmed@123');

UNLOCK TABLES;

INSERT INTO `passenger`
(`passenger_name`,`age`,`gender`,`phone`,`email`,`password`)
VALUES
('Sameer Khan',27,'Male','9876543215','sameer@gmail.com','Sameer@123');

SELECT *
FROM `passenger`;

SELECT *
FROM `passenger`
WHERE `email` = 'murtaza@gmail.com'
AND `password` = 'Murtaza@123';

SELECT *
FROM `passenger`
WHERE `email` = 'rahul@gmail.com'
AND `password` = 'Rahul@123';

SELECT *
FROM `passenger`
WHERE `passenger_id` = 1;

SELECT *
FROM `passenger`
WHERE `passenger_name` LIKE '%Rahul%';

UPDATE `passenger`
SET `phone` = '9999999999'
WHERE `passenger_id` = 1;

DELETE FROM `passenger`
WHERE `passenger_id` = 5;

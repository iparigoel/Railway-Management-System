-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: railwayreservationsystem
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking`
--

LOCK TABLES `booking` WRITE;
/*!40000 ALTER TABLE `booking` DISABLE KEYS */;
INSERT INTO `booking` VALUES (1,3,'2026-09-10','Murtaza Ansari','Confirmed'),(2,5,'2026-09-10','Ali Khan','Cancelled'),(4,6,'2026-09-10','Ahmed Khan','Confirmed'),(6,5,'2026-09-10','Rahul Sharma','Confirmed'),(7,2,'2026-09-11','Sameer Khan','Confirmed');
/*!40000 ALTER TABLE `booking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coach`
--

DROP TABLE IF EXISTS `coach`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coach`
--

LOCK TABLES `coach` WRITE;
/*!40000 ALTER TABLE `coach` DISABLE KEYS */;
INSERT INTO `coach` VALUES (1,1,'S1','Sleeper',72),(2,1,'S2','Sleeper',72),(3,1,'A1','AC',48),(4,2,'S1','Sleeper',72),(5,2,'A1','AC',48);
/*!40000 ALTER TABLE `coach` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seat`
--

DROP TABLE IF EXISTS `seat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seat` (
  `seat_id` int NOT NULL AUTO_INCREMENT,
  `coach_id` int NOT NULL,
  `seat_number` int NOT NULL,
  `seat_type` varchar(20) NOT NULL,
  PRIMARY KEY (`seat_id`),
  KEY `coach_id` (`coach_id`),
  CONSTRAINT `seat_ibfk_1` FOREIGN KEY (`coach_id`) REFERENCES `coach` (`coach_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seat`
--

LOCK TABLES `seat` WRITE;
/*!40000 ALTER TABLE `seat` DISABLE KEYS */;
INSERT INTO `seat` VALUES (1,1,1,'Lower'),(2,1,2,'Middle'),(3,1,3,'Upper'),(4,1,4,'Lower'),(5,1,5,'Middle'),(6,1,6,'Upper');
/*!40000 ALTER TABLE `seat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seatavailability`
--

DROP TABLE IF EXISTS `seatavailability`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seatavailability` (
  `availability_id` int NOT NULL AUTO_INCREMENT,
  `seat_id` int NOT NULL,
  `journey_date` date NOT NULL,
  `status` varchar(20) NOT NULL,
  PRIMARY KEY (`availability_id`),
  UNIQUE KEY `seat_id` (`seat_id`,`journey_date`),
  CONSTRAINT `seatavailability_ibfk_1` FOREIGN KEY (`seat_id`) REFERENCES `seat` (`seat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seatavailability`
--

LOCK TABLES `seatavailability` WRITE;
/*!40000 ALTER TABLE `seatavailability` DISABLE KEYS */;
INSERT INTO `seatavailability` VALUES (1,1,'2026-09-10','Booked'),(2,2,'2026-09-10','Booked'),(3,3,'2026-09-10','Booked'),(4,4,'2026-09-10','Booked'),(5,5,'2026-09-10','Booked'),(6,6,'2026-09-10','Booked'),(7,1,'2026-09-11','Available'),(8,2,'2026-09-11','Booked'),(9,3,'2026-09-11','Available'),(10,4,'2026-09-11','Available'),(11,5,'2026-09-11','Available'),(12,6,'2026-09-11','Available');
/*!40000 ALTER TABLE `seatavailability` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `train`
--

DROP TABLE IF EXISTS `train`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `train` (
  `train_id` int NOT NULL AUTO_INCREMENT,
  `train_number` varchar(10) NOT NULL,
  `train_name` varchar(100) NOT NULL,
  PRIMARY KEY (`train_id`),
  UNIQUE KEY `train_number` (`train_number`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `train`
--

LOCK TABLES `train` WRITE;
/*!40000 ALTER TABLE `train` DISABLE KEYS */;
INSERT INTO `train` VALUES (1,'12951','Mumbai Rajdhani Express'),(2,'12301','Kolkata Rajdhani Express'),(3,'12009','Shatabdi Express');
/*!40000 ALTER TABLE `train` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-06 17:59:39

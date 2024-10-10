-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: addressbook
-- ------------------------------------------------------
-- Server version	8.0.38

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `log_book`
--

DROP TABLE IF EXISTS `log_book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_book` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `title` int NOT NULL,
  `gender` int NOT NULL,
  `firstname` varchar(45) NOT NULL,
  `lastname` varchar(45) NOT NULL,
  `date_of_birth` date NOT NULL,
  `profile` varchar(70) NOT NULL,
  `house_flat` varchar(45) NOT NULL,
  `street` varchar(45) NOT NULL,
  `city` varchar(45) NOT NULL,
  `state` varchar(45) NOT NULL,
  `country` varchar(45) NOT NULL,
  `pincode` varchar(10) NOT NULL,
  `email` varchar(320) NOT NULL,
  `phone` varchar(20) NOT NULL,
  PRIMARY KEY (`log_id`),
  UNIQUE KEY `log_id_UNIQUE` (`log_id`),
  UNIQUE KEY `user` (`user_id`,`email`),
  KEY `user_id_idx` (`user_id`),
  KEY `title_idx` (`title`),
  KEY `gender_idx` (`gender`),
  CONSTRAINT `gender` FOREIGN KEY (`gender`) REFERENCES `gender` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `title` FOREIGN KEY (`title`) REFERENCES `title` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `log_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_book`
--

LOCK TABLES `log_book` WRITE;
/*!40000 ALTER TABLE `log_book` DISABLE KEYS */;
INSERT INTO `log_book` VALUES (29,1,1,1,'Krishna','Renjith','2002-10-31','signup.png','Athippillil House','Tagore Nagar','Muvattupuzha','Kerala','India','686661','krenjith567@gmail.com','9847987434'),(30,1,1,1,'Liju','Mon','2002-03-09','Tony (1)21.jpg','Aikaramattathil House','Udumbannoor','Karimannoor','Kerala','India','685695','lijumon2002@gmail.com','9876543210'),(35,1,1,1,'Anthony Edward','Stark','1970-05-29','Stark10.jpg','Stark Mansion','Stark Street','Malibu','California','United States','90625','tonystark@gmail.com','6543219870'),(47,1,1,1,'Liju','Mon','2002-03-09','Stark11.jpg','Aikaramattathil House','Udumbannoor','Karimannoor','Kerala','India','685695','lijumon20002@gmail.com','9876543210'),(48,1,1,1,'Howard','Stark','1870-05-29','signup.png','Stark Mansion','Stark Street','Malibu','California','United States','90625','howardstark@gmail.com','6543219870');
/*!40000 ALTER TABLE `log_book` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-10 18:20:12

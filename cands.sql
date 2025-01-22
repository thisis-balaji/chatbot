-- MySQL dump 10.13  Distrib 8.0.37, for Win64 (x86_64)
--
-- Host: localhost    Database: cands
-- ------------------------------------------------------
-- Server version	8.0.37

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
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `Order_id` int NOT NULL AUTO_INCREMENT,
  `Product_id` int NOT NULL,
  `Quantity` int NOT NULL,
  `Price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`Order_id`,`Product_id`),
  KEY `Product_id` (`Product_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`Product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,1,50000.00),(1,4,1,160000.00),(2,3,1,90000.00),(2,6,3,9000.00),(3,7,2,20000.00),(4,6,2,6000.00),(5,2,3,28230.00),(6,2,3,28230.00),(7,6,2,6000.00),(8,2,2,18820.00),(8,6,2,6000.00),(9,6,5,15000.00),(10,2,3,28230.00),(10,6,2,6000.00),(11,6,2,6000.00),(12,1,2,100000.00),(13,1,2,100000.00),(14,1,2,100000.00),(15,1,2,100000.00),(15,7,2,20000.00),(16,2,2,18820.00),(17,6,1,3000.00),(18,7,5,50000.00),(19,2,5,47050.00),(19,7,2,20000.00),(20,1,2,100000.00),(21,7,5,50000.00),(22,1,2,100000.00),(23,6,5,15000.00),(23,7,1,10000.00);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordertracking`
--

DROP TABLE IF EXISTS `ordertracking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordertracking` (
  `Order_id` int NOT NULL,
  `tracking_status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Order_id`),
  CONSTRAINT `ordertracking_ibfk_1` FOREIGN KEY (`Order_id`) REFERENCES `orders` (`Order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordertracking`
--

LOCK TABLES `ordertracking` WRITE;
/*!40000 ALTER TABLE `ordertracking` DISABLE KEYS */;
INSERT INTO `ordertracking` VALUES (1,'Delivered'),(2,'In Transit'),(3,'Delivered'),(4,'in progress'),(5,'in progress'),(6,'in progress'),(7,'in progress'),(8,'in progress'),(9,'in progress'),(10,'in progress'),(15,'in progress'),(16,'in progress'),(17,'in progress'),(18,'in progress'),(19,'in progress'),(20,'in progress'),(21,'in progress'),(23,'in progress');
/*!40000 ALTER TABLE `ordertracking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `product_id` int NOT NULL,
  `product_name` varchar(300) DEFAULT NULL,
  `product_price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Air Circuit Breaker',50000.00),(2,'Winmaster 2 Air Circuit Breaker',9410.00),(3,'Triple Pole Air Circuit Breaker, Z Curve',90000.00),(4,'4 Pole ACB',160000.00),(5,'ACB Circuit Breaker',150000.00),(6,'3200A ACB Finger Contact',3000.00),(7,'20A ACB Eaton',10000.00);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-01-22 13:45:27

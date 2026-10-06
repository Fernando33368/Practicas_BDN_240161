-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: db_test
-- ------------------------------------------------------
-- Server version	8.0.36

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
-- Table structure for table `tb_logs`
--

DROP TABLE IF EXISTS `tb_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_logs` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `table_name` varchar(100) NOT NULL,
  `operation` enum('Create','Read','Update','Delete') NOT NULL,
  `db_user` varchar(80) NOT NULL,
  `description` text NOT NULL,
  `operation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `operation_status` bit(1) DEFAULT b'1',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_logs`
--

LOCK TABLES `tb_logs` WRITE;
/*!40000 ALTER TABLE `tb_logs` DISABLE KEYS */;
INSERT INTO `tb_logs` VALUES (9,'tb_products','Create','carlos.cabrera@MSI','Producto insertado. ID=9','2026-10-02 17:43:25',_binary ''),(10,'tb_products','Create','carlos.cabrera@MSI','Producto insertado. ID=10','2026-10-02 17:46:38',_binary ''),(11,'tb_products','Create','carlos.cabrera@MSI','Producto insertado. ID=11','2026-10-02 17:46:38',_binary ''),(12,'tb_products','Create','carlos.cabrera@MSI','Producto insertado. ID=12','2026-10-02 17:46:38',_binary ''),(13,'tb_products','Create','carlos.cabrera@MSI','Producto insertado. ID=13','2026-10-02 17:46:38',_binary ''),(14,'tb_products','Create','carlos.cabrera@MSI','Producto insertado. ID=14','2026-10-02 17:46:38',_binary ''),(15,'tb_products','Create','carlos.cabrera@MSI','Producto insertado. ID=15','2026-10-02 17:46:38',_binary ''),(16,'tb_products','Create','carlos.cabrera@MSI','Producto insertado. ID=16','2026-10-02 17:46:38',_binary ''),(17,'tb_products','Create','carlos.cabrera@MSI','Producto insertado. ID=17','2026-10-02 17:46:38',_binary ''),(18,'tb_products','Create','carlos.cabrera@MSI','Producto insertado. ID=18','2026-10-02 17:46:38',_binary ''),(19,'tb_products','Create','carlos.cabrera@MSI','Producto insertado. ID=19','2026-10-02 17:46:38',_binary ''),(20,'tb_users','Create','carlos.cabrera@MSI','Usuario creado. ID=1, email=angel.nazul@utxicotepec.edu.mx, nickname=angel.nazul','2026-10-02 17:49:30',_binary ''),(21,'tb_users','Create','carlos.cabrera@MSI','Usuario creado. ID=2, email=carlos.cabrera@utxicotepec.edu.mx, nickname=carlos.cabrera','2026-10-02 17:49:30',_binary '');
/*!40000 ALTER TABLE `tb_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_products`
--

DROP TABLE IF EXISTS `tb_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_products` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `SKU` varchar(50) NOT NULL,
  `name` varchar(250) NOT NULL,
  `description` text,
  `current_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `current_stock` int unsigned NOT NULL DEFAULT '0',
  `status` bit(1) DEFAULT b'1',
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SKU` (`SKU`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_products`
--

LOCK TABLES `tb_products` WRITE;
/*!40000 ALTER TABLE `tb_products` DISABLE KEYS */;
INSERT INTO `tb_products` VALUES (9,'LAP-002','Laptop HP 15','Laptop para trabajo y escuela',14500.00,8,_binary '','2026-10-02 17:43:25','2026-10-02 17:43:25'),(10,'LAP-003','Laptop Dell Inspiron 15','Laptop para oficina y estudio, 16GB RAM, 512GB SSD',15999.00,12,_binary '','2026-10-02 17:46:38','2026-10-02 17:46:38'),(11,'LAP-004','MacBook Air M2','Laptop ultraligera Apple, chip M2, 8GB RAM, 256GB SSD',21999.00,5,_binary '','2026-10-02 17:46:38','2026-10-02 17:46:38'),(12,'MON-001','Monitor LG 24\" Full HD','Monitor LED 24 pulgadas, 75Hz, HDMI y VGA',3299.00,20,_binary '','2026-10-02 17:46:38','2026-10-02 17:46:38'),(13,'MON-002','Monitor Samsung 27\" QHD','Monitor curvo QHD 27\", 144Hz, ideal para gaming',7499.00,8,_binary '','2026-10-02 17:46:38','2026-10-02 17:46:38'),(14,'TEC-001','Teclado Mecánico Redragon','Teclado mecánico RGB switches rojos, layout español',1299.00,25,_binary '','2026-10-02 17:46:38','2026-10-02 17:46:38'),(15,'MOU-001','Mouse Logitech MX Master 3S','Mouse inalámbrico ergonómico, 8000 DPI, Bluetooth',2499.00,15,_binary '','2026-10-02 17:46:38','2026-10-02 17:46:38'),(16,'AUD-001','Audífonos Sony WH-1000XM5','Audífonos con cancelación de ruido, 30h batería',8999.00,7,_binary '','2026-10-02 17:46:38','2026-10-02 17:46:38'),(17,'TAB-001','Tablet Samsung Galaxy Tab S9','Tablet Android 11\", 128GB, WiFi, con S-Pen',9499.00,6,_binary '','2026-10-02 17:46:38','2026-10-02 17:46:38'),(18,'IMP-001','Impresora HP LaserJet M110we','Impresora láser monocromática WiFi, 21 ppm',3299.00,10,_binary '','2026-10-02 17:46:38','2026-10-02 17:46:38'),(19,'DIS-001','Disco Duro Externo Seagate 2TB','Disco duro externo USB 3.0, 2TB, portátil',1899.00,18,_binary '','2026-10-02 17:46:38','2026-10-02 17:46:38');
/*!40000 ALTER TABLE `tb_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_users`
--

DROP TABLE IF EXISTS `tb_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_users` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `email` varchar(80) NOT NULL,
  `nickname` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `creation_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `last_login` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `nickname` (`nickname`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_users`
--

LOCK TABLES `tb_users` WRITE;
/*!40000 ALTER TABLE `tb_users` DISABLE KEYS */;
INSERT INTO `tb_users` VALUES (1,'angel.nazul@utxicotepec.edu.mx','angel.nazul','a109e36947ad56de1dca1cc49f0ef8ac9ad9a7b1aa0df41fb3c4cb73c1ff01ea','2026-10-02 17:49:30','2026-10-02 17:49:30'),(2,'carlos.cabrera@utxicotepec.edu.mx','carlos.cabrera','a109e36947ad56de1dca1cc49f0ef8ac9ad9a7b1aa0df41fb3c4cb73c1ff01ea','2026-10-02 17:49:30','2026-10-02 17:49:30');
/*!40000 ALTER TABLE `tb_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbd_products_categories`
--

DROP TABLE IF EXISTS `tbd_products_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbd_products_categories` (
  `category_ID` int unsigned NOT NULL,
  `product_ID` int unsigned NOT NULL,
  `status` bit(1) NOT NULL DEFAULT b'1',
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`category_ID`,`product_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbd_products_categories`
--

LOCK TABLES `tbd_products_categories` WRITE;
/*!40000 ALTER TABLE `tbd_products_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbd_products_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_productos_por_categoria`
--

DROP TABLE IF EXISTS `vw_productos_por_categoria`;
/*!50001 DROP VIEW IF EXISTS `vw_productos_por_categoria`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_productos_por_categoria` AS SELECT 
 1 AS `categoria_id`,
 1 AS `cantidad_productos`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vw_productos_por_categoria`
--

/*!50001 DROP VIEW IF EXISTS `vw_productos_por_categoria`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb3 */;
/*!50001 SET character_set_results     = utf8mb3 */;
/*!50001 SET collation_connection      = utf8mb3_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_productos_por_categoria` AS select `pc`.`category_ID` AS `categoria_id`,count(`pc`.`product_ID`) AS `cantidad_productos` from `tbd_products_categories` `pc` group by `pc`.`category_ID` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-06 11:44:35

-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: db_test_240161
-- ------------------------------------------------------
-- Server version	8.3.0

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
-- Table structure for table `tb_carts`
--

DROP TABLE IF EXISTS `tb_carts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_carts` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `user_ID` int unsigned NOT NULL,
  `status` bit(1) DEFAULT b'1',
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `uk_cart_user` (`user_ID`),
  CONSTRAINT `tb_carts_ibfk_1` FOREIGN KEY (`user_ID`) REFERENCES `tb_users` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_carts`
--

LOCK TABLES `tb_carts` WRITE;
/*!40000 ALTER TABLE `tb_carts` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_carts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_logs`
--

DROP TABLE IF EXISTS `tb_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_logs` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `table_name` varchar(100) NOT NULL,
  `table_operation` enum('Create','Read','Update','Delete') NOT NULL,
  `db_user` varchar(80) NOT NULL,
  `operation_description` text NOT NULL,
  `operation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `operation_status` bit(1) DEFAULT b'1',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=36368 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_logs`
--

LOCK TABLES `tb_logs` WRITE;
/*!40000 ALTER TABLE `tb_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_people`
--

DROP TABLE IF EXISTS `tb_people`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_people` (
  `person_ID` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_ID` int unsigned NOT NULL,
  `courtesy_title_ID` char(3) NOT NULL,
  `given_names` varchar(150) NOT NULL,
  `family_names` varchar(150) NOT NULL,
  `birth_date` date DEFAULT NULL,
  `gender_ID` tinyint unsigned NOT NULL,
  `country_code` char(2) NOT NULL,
  `phone` varchar(25) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`person_ID`),
  UNIQUE KEY `uq_people_user` (`user_ID`),
  KEY `fk_people_courtesy_title` (`courtesy_title_ID`),
  KEY `fk_people_gender` (`gender_ID`),
  KEY `fk_people_country` (`country_code`),
  CONSTRAINT `fk_people_country` FOREIGN KEY (`country_code`) REFERENCES `tbd_countries` (`country_code`),
  CONSTRAINT `fk_people_courtesy_title` FOREIGN KEY (`courtesy_title_ID`) REFERENCES `tbd_courtesy_titles` (`courtesy_title_ID`),
  CONSTRAINT `fk_people_gender` FOREIGN KEY (`gender_ID`) REFERENCES `tbd_genders` (`gender_ID`),
  CONSTRAINT `fk_people_user` FOREIGN KEY (`user_ID`) REFERENCES `tb_users` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_people`
--

LOCK TABLES `tb_people` WRITE;
/*!40000 ALTER TABLE `tb_people` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_people` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=21461 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_products`
--

LOCK TABLES `tb_products` WRITE;
/*!40000 ALTER TABLE `tb_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_user_addresses`
--

DROP TABLE IF EXISTS `tb_user_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_user_addresses` (
  `ID` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_ID` int unsigned NOT NULL,
  `label` varchar(100) DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `status` bit(1) NOT NULL DEFAULT b'1',
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `idx_user_address_user` (`user_ID`),
  CONSTRAINT `fk_user_address_user` FOREIGN KEY (`user_ID`) REFERENCES `tb_users` (`ID`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_user_addresses`
--

LOCK TABLES `tb_user_addresses` WRITE;
/*!40000 ALTER TABLE `tb_user_addresses` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_user_addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_users`
--

DROP TABLE IF EXISTS `tb_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_users` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(80) NOT NULL,
  `nick` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_login` datetime DEFAULT NULL,
  `status` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `nickname` (`nick`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_users`
--

LOCK TABLES `tb_users` WRITE;
/*!40000 ALTER TABLE `tb_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbc_categories`
--

DROP TABLE IF EXISTS `tbc_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbc_categories` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) NOT NULL,
  `description` text,
  `sup_id_category` int unsigned DEFAULT NULL,
  `status` bit(1) NOT NULL DEFAULT b'1',
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `name` (`name`),
  KEY `fk_superior_category` (`sup_id_category`),
  CONSTRAINT `fk_superior_category` FOREIGN KEY (`sup_id_category`) REFERENCES `tbc_categories` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbc_categories`
--

LOCK TABLES `tbc_categories` WRITE;
/*!40000 ALTER TABLE `tbc_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbc_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbc_payment_methods_types`
--

DROP TABLE IF EXISTS `tbc_payment_methods_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbc_payment_methods_types` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(30) NOT NULL,
  `description` text NOT NULL,
  `status` bit(1) NOT NULL DEFAULT b'1',
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `code_UNIQUE` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbc_payment_methods_types`
--

LOCK TABLES `tbc_payment_methods_types` WRITE;
/*!40000 ALTER TABLE `tbc_payment_methods_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbc_payment_methods_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbd_address_components`
--

DROP TABLE IF EXISTS `tbd_address_components`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbd_address_components` (
  `ID` bigint unsigned NOT NULL AUTO_INCREMENT,
  `address_ID` bigint unsigned NOT NULL,
  `value` varchar(255) NOT NULL,
  `component_type` varchar(50) NOT NULL,
  `status` bit(1) NOT NULL DEFAULT b'1',
  `address_sup_ID` bigint unsigned DEFAULT NULL,
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `uk_address_component` (`address_ID`,`ID`),
  KEY `idx_address_parent` (`address_ID`,`address_sup_ID`),
  CONSTRAINT `fk_component_address` FOREIGN KEY (`address_ID`) REFERENCES `tb_user_addresses` (`ID`) ON DELETE RESTRICT,
  CONSTRAINT `fk_component_parent` FOREIGN KEY (`address_ID`, `address_sup_ID`) REFERENCES `tbd_address_components` (`address_ID`, `ID`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbd_address_components`
--

LOCK TABLES `tbd_address_components` WRITE;
/*!40000 ALTER TABLE `tbd_address_components` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbd_address_components` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbd_countries`
--

DROP TABLE IF EXISTS `tbd_countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbd_countries` (
  `country_code` char(2) NOT NULL,
  `name` varchar(100) NOT NULL,
  `phone_code` varchar(8) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`country_code`),
  UNIQUE KEY `uq_country_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbd_countries`
--

LOCK TABLES `tbd_countries` WRITE;
/*!40000 ALTER TABLE `tbd_countries` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbd_countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbd_courtesy_titles`
--

DROP TABLE IF EXISTS `tbd_courtesy_titles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbd_courtesy_titles` (
  `courtesy_title_ID` char(3) NOT NULL,
  `name` varchar(50) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`courtesy_title_ID`),
  UNIQUE KEY `uq_courtesy_title_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbd_courtesy_titles`
--

LOCK TABLES `tbd_courtesy_titles` WRITE;
/*!40000 ALTER TABLE `tbd_courtesy_titles` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbd_courtesy_titles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbd_genders`
--

DROP TABLE IF EXISTS `tbd_genders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbd_genders` (
  `gender_ID` tinyint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`gender_ID`),
  UNIQUE KEY `uq_gender_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbd_genders`
--

LOCK TABLES `tbd_genders` WRITE;
/*!40000 ALTER TABLE `tbd_genders` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbd_genders` ENABLE KEYS */;
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
  PRIMARY KEY (`category_ID`,`product_ID`),
  KEY `fk_product` (`product_ID`),
  CONSTRAINT `fk_category` FOREIGN KEY (`category_ID`) REFERENCES `tbc_categories` (`ID`),
  CONSTRAINT `fk_product` FOREIGN KEY (`product_ID`) REFERENCES `tb_products` (`ID`)
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
-- Table structure for table `tbd_products_users_providers`
--

DROP TABLE IF EXISTS `tbd_products_users_providers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbd_products_users_providers` (
  `user_ID` int unsigned NOT NULL,
  `product_ID` int unsigned NOT NULL,
  `type_ownership` varchar(50) DEFAULT NULL,
  `status` bit(1) NOT NULL DEFAULT b'1',
  `avalaible_date` datetime DEFAULT NULL,
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_ID`,`product_ID`),
  KEY `fk_product_provider` (`product_ID`),
  CONSTRAINT `fk_product_provider` FOREIGN KEY (`product_ID`) REFERENCES `tb_products` (`ID`),
  CONSTRAINT `fk_user_provider` FOREIGN KEY (`user_ID`) REFERENCES `tb_users` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbd_products_users_providers`
--

LOCK TABLES `tbd_products_users_providers` WRITE;
/*!40000 ALTER TABLE `tbd_products_users_providers` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbd_products_users_providers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbd_user_payment_methods`
--

DROP TABLE IF EXISTS `tbd_user_payment_methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbd_user_payment_methods` (
  `ID` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_ID` int unsigned NOT NULL,
  `payment_method_type_ID` int unsigned NOT NULL,
  `provider` varchar(60) NOT NULL,
  `provider_method_ref` varchar(255) NOT NULL,
  `label` varchar(100) DEFAULT NULL,
  `last_four` char(4) DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `status` bit(1) NOT NULL DEFAULT b'1',
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `uk_provider_method` (`provider`,`provider_method_ref`),
  KEY `user_ID` (`user_ID`),
  KEY `payment_method_type_ID` (`payment_method_type_ID`),
  CONSTRAINT `tbd_user_payment_methods_ibfk_1` FOREIGN KEY (`user_ID`) REFERENCES `tb_users` (`ID`),
  CONSTRAINT `tbd_user_payment_methods_ibfk_2` FOREIGN KEY (`payment_method_type_ID`) REFERENCES `tbc_payment_methods_types` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbd_user_payment_methods`
--

LOCK TABLES `tbd_user_payment_methods` WRITE;
/*!40000 ALTER TABLE `tbd_user_payment_methods` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbd_user_payment_methods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbd_users_wishlist_products`
--

DROP TABLE IF EXISTS `tbd_users_wishlist_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbd_users_wishlist_products` (
  `user_ID` int unsigned NOT NULL,
  `product_ID` int unsigned NOT NULL,
  `status` bit(1) NOT NULL DEFAULT b'1',
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_ID`,`product_ID`),
  KEY `fk_products3` (`product_ID`),
  CONSTRAINT `fk_products3` FOREIGN KEY (`product_ID`) REFERENCES `tb_products` (`ID`),
  CONSTRAINT `fk_user2` FOREIGN KEY (`user_ID`) REFERENCES `tb_users` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbd_users_wishlist_products`
--

LOCK TABLES `tbd_users_wishlist_products` WRITE;
/*!40000 ALTER TABLE `tbd_users_wishlist_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbd_users_wishlist_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_total_products_by_category`
--

DROP TABLE IF EXISTS `vw_total_products_by_category`;
/*!50001 DROP VIEW IF EXISTS `vw_total_products_by_category`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_total_products_by_category` AS SELECT 
 1 AS `category_ID`,
 1 AS `category_path`,
 1 AS `category_level`,
 1 AS `total_products`,
 1 AS `total_active_products`,
 1 AS `total_inactive_products`,
 1 AS `total_uncategorized_products`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_categorias`
--

DROP TABLE IF EXISTS `vw_trazabilidad_categorias`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_categorias`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_categorias` AS SELECT 
 1 AS `log_id`,
 1 AS `category_id`,
 1 AS `operation`,
 1 AS `db_user`,
 1 AS `username`,
 1 AS `roles`,
 1 AS `operation_description`,
 1 AS `operation_date`,
 1 AS `operation_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_categorizacion_productos`
--

DROP TABLE IF EXISTS `vw_trazabilidad_categorizacion_productos`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_categorizacion_productos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_categorizacion_productos` AS SELECT 
 1 AS `log_id`,
 1 AS `category_id`,
 1 AS `operation`,
 1 AS `db_user`,
 1 AS `username`,
 1 AS `roles`,
 1 AS `operation_description`,
 1 AS `operation_date`,
 1 AS `operation_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_producto_proveedor`
--

DROP TABLE IF EXISTS `vw_trazabilidad_producto_proveedor`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_producto_proveedor`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_producto_proveedor` AS SELECT 
 1 AS `log_id`,
 1 AS `category_id`,
 1 AS `operation`,
 1 AS `db_user`,
 1 AS `username`,
 1 AS `roles`,
 1 AS `operation_description`,
 1 AS `operation_date`,
 1 AS `operation_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_productos`
--

DROP TABLE IF EXISTS `vw_trazabilidad_productos`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_productos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_productos` AS SELECT 
 1 AS `id`,
 1 AS `name`,
 1 AS `description`,
 1 AS `inserted_by`,
 1 AS `roles`,
 1 AS `operation_description`,
 1 AS `operation_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_trazabilidad_usuarios`
--

DROP TABLE IF EXISTS `vw_trazabilidad_usuarios`;
/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_usuarios`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_trazabilidad_usuarios` AS SELECT 
 1 AS `nick`,
 1 AS `email`,
 1 AS `inserted_by`,
 1 AS `roles`,
 1 AS `operation_description`,
 1 AS `operation_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vw_total_products_by_category`
--

/*!50001 DROP VIEW IF EXISTS `vw_total_products_by_category`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_total_products_by_category` AS with recursive `category_tree` as (select `c`.`ID` AS `ID`,`c`.`name` AS `name`,`c`.`sup_id_category` AS `sup_id_category`,`c`.`status` AS `status`,cast(`c`.`name` as char(1000) charset utf8mb4) AS `category_path`,1 AS `category_level` from `tbc_categories` `c` where (`c`.`sup_id_category` is null) union all select `c`.`ID` AS `ID`,`c`.`name` AS `name`,`c`.`sup_id_category` AS `sup_id_category`,`c`.`status` AS `status`,concat(`ct`.`category_path`,' → ',`c`.`name`) AS `category_path`,(`ct`.`category_level` + 1) AS `ct.category_level + 1` from (`tbc_categories` `c` join `category_tree` `ct` on((`c`.`sup_id_category` = `ct`.`ID`)))), `category_totals` as (select `ct`.`ID` AS `category_ID`,`ct`.`category_path` AS `category_path`,`ct`.`category_level` AS `category_level`,count(distinct `pc`.`product_ID`) AS `total_products`,count(distinct (case when (`p`.`status` = 0x01) then `p`.`ID` end)) AS `total_active_products`,count(distinct (case when (`p`.`status` = 0x00) then `p`.`ID` end)) AS `total_inactive_products` from ((`category_tree` `ct` left join `tbd_products_categories` `pc` on(((`pc`.`category_ID` = `ct`.`ID`) and (`pc`.`status` = 0x01)))) left join `tb_products` `p` on((`p`.`ID` = `pc`.`product_ID`))) group by `ct`.`ID`,`ct`.`category_path`,`ct`.`category_level`), `uncategorized` as (select count(0) AS `total_uncategorized_products`,sum((case when (`p`.`status` = 0x01) then 1 else 0 end)) AS `total_active_products`,sum((case when (`p`.`status` = 0x00) then 1 else 0 end)) AS `total_inactive_products` from `tb_products` `p` where exists(select 1 from `tbd_products_categories` `pc` where ((`pc`.`product_ID` = `p`.`ID`) and (`pc`.`status` = 0x01))) is false) select `category_totals`.`category_ID` AS `category_ID`,`category_totals`.`category_path` AS `category_path`,`category_totals`.`category_level` AS `category_level`,`category_totals`.`total_products` AS `total_products`,`category_totals`.`total_active_products` AS `total_active_products`,`category_totals`.`total_inactive_products` AS `total_inactive_products`,0 AS `total_uncategorized_products` from `category_totals` union all select NULL AS `category_ID`,'Sin categoría' AS `category_path`,0 AS `category_level`,`uncategorized`.`total_uncategorized_products` AS `total_products`,`uncategorized`.`total_active_products` AS `total_active_products`,`uncategorized`.`total_inactive_products` AS `total_inactive_products`,`uncategorized`.`total_uncategorized_products` AS `total_uncategorized_products` from `uncategorized` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_categorias`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_categorias`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_categorias` AS select `l`.`ID` AS `log_id`,cast(substring_index(substring_index(`l`.`operation_description`,'ID=',-(1)),',',1) as unsigned) AS `category_id`,`l`.`table_operation` AS `operation`,`l`.`db_user` AS `db_user`,substring_index(`l`.`db_user`,'@',1) AS `username`,coalesce((select group_concat(distinct `re`.`FROM_USER` order by `re`.`FROM_USER` ASC separator ', ') from `mysql`.`role_edges` `re` where (`re`.`TO_USER` = substring_index(`l`.`db_user`,'@',1))),'Sin rol asignado') AS `roles`,`l`.`operation_description` AS `operation_description`,`l`.`operation_date` AS `operation_date`,`l`.`operation_status` AS `operation_status` from `tb_logs` `l` where (`l`.`table_name` = 'tbc_categories') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_categorizacion_productos`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_categorizacion_productos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_categorizacion_productos` AS select `l`.`ID` AS `log_id`,cast(substring_index(substring_index(`l`.`operation_description`,'ID=',-(1)),',',1) as unsigned) AS `category_id`,`l`.`table_operation` AS `operation`,`l`.`db_user` AS `db_user`,substring_index(`l`.`db_user`,'@',1) AS `username`,coalesce((select group_concat(distinct `re`.`FROM_USER` order by `re`.`FROM_USER` ASC separator ', ') from `mysql`.`role_edges` `re` where (`re`.`TO_USER` = substring_index(`l`.`db_user`,'@',1))),'Sin rol asignado') AS `roles`,`l`.`operation_description` AS `operation_description`,`l`.`operation_date` AS `operation_date`,`l`.`operation_status` AS `operation_status` from `tb_logs` `l` where (`l`.`table_name` = 'tbd_products_categories') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_producto_proveedor`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_producto_proveedor`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_producto_proveedor` AS select `l`.`ID` AS `log_id`,cast(substring_index(substring_index(`l`.`operation_description`,'ID=',-(1)),',',1) as unsigned) AS `category_id`,`l`.`table_operation` AS `operation`,`l`.`db_user` AS `db_user`,substring_index(`l`.`db_user`,'@',1) AS `username`,coalesce((select group_concat(distinct `re`.`FROM_USER` order by `re`.`FROM_USER` ASC separator ', ') from `mysql`.`role_edges` `re` where (`re`.`TO_USER` = substring_index(`l`.`db_user`,'@',1))),'Sin rol asignado') AS `roles`,`l`.`operation_description` AS `operation_description`,`l`.`operation_date` AS `operation_date`,`l`.`operation_status` AS `operation_status` from `tb_logs` `l` where (`l`.`table_name` = 'tbd_products_users_providers') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_productos`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_productos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_productos` AS select `p`.`ID` AS `id`,`p`.`name` AS `name`,`p`.`description` AS `description`,`b`.`db_user` AS `inserted_by`,coalesce(group_concat(distinct `re`.`FROM_USER` order by `re`.`FROM_USER` ASC separator ', '),'Sin rol') AS `roles`,`b`.`operation_description` AS `operation_description`,`b`.`operation_date` AS `operation_date` from ((`tb_products` `p` join `tb_logs` `b` on((`b`.`operation_description` like concat('%ID=',`p`.`ID`,',%')))) left join `mysql`.`role_edges` `re` on((`re`.`TO_USER` = substring_index(`b`.`db_user`,'@',1)))) where ((`b`.`table_operation` = 'Create') and (`b`.`table_name` = 'tb_products')) group by `p`.`ID`,`p`.`name`,`p`.`description`,`b`.`db_user`,`b`.`operation_description`,`b`.`operation_date` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_trazabilidad_usuarios`
--

/*!50001 DROP VIEW IF EXISTS `vw_trazabilidad_usuarios`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_trazabilidad_usuarios` AS select `u`.`nick` AS `nick`,`u`.`email` AS `email`,`b`.`db_user` AS `inserted_by`,group_concat(distinct `re`.`FROM_USER` order by `re`.`FROM_USER` ASC separator ', ') AS `roles`,`b`.`operation_description` AS `operation_description`,`b`.`operation_date` AS `operation_date` from ((`tb_users` `u` join `tb_logs` `b` on(((`b`.`operation_description` like concat('%',`u`.`nick`,'%')) and (`b`.`operation_description` like concat('%',`u`.`email`,'%'))))) left join `mysql`.`role_edges` `re` on((`re`.`TO_USER` = substring_index(`b`.`db_user`,'@',1)))) where ((`b`.`table_operation` = 'Create') and (`b`.`table_name` = 'tb_users')) group by `u`.`nick`,`u`.`email`,`b`.`db_user`,`b`.`operation_description`,`b`.`operation_date` order by `b`.`operation_date` */;
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

-- Dump completed on 2026-10-22  2:43:57

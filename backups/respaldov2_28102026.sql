-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: db_test_240161
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
-- Dumping data for table `tb_carts`
--

LOCK TABLES `tb_carts` WRITE;
/*!40000 ALTER TABLE `tb_carts` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_carts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `tb_logs`
--

LOCK TABLES `tb_logs` WRITE;
/*!40000 ALTER TABLE `tb_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `tb_order_cancellations`
--

LOCK TABLES `tb_order_cancellations` WRITE;
/*!40000 ALTER TABLE `tb_order_cancellations` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_order_cancellations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `tb_orders`
--

LOCK TABLES `tb_orders` WRITE;
/*!40000 ALTER TABLE `tb_orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `tb_payment_transactions`
--

LOCK TABLES `tb_payment_transactions` WRITE;
/*!40000 ALTER TABLE `tb_payment_transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_payment_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `tb_payments`
--

LOCK TABLES `tb_payments` WRITE;
/*!40000 ALTER TABLE `tb_payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `tb_people`
--

LOCK TABLES `tb_people` WRITE;
/*!40000 ALTER TABLE `tb_people` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_people` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `tb_products`
--

LOCK TABLES `tb_products` WRITE;
/*!40000 ALTER TABLE `tb_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `tb_refunds`
--

LOCK TABLES `tb_refunds` WRITE;
/*!40000 ALTER TABLE `tb_refunds` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_refunds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `tb_returns`
--

LOCK TABLES `tb_returns` WRITE;
/*!40000 ALTER TABLE `tb_returns` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_returns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `tb_shipments`
--

LOCK TABLES `tb_shipments` WRITE;
/*!40000 ALTER TABLE `tb_shipments` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_shipments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `tb_user_addresses`
--

LOCK TABLES `tb_user_addresses` WRITE;
/*!40000 ALTER TABLE `tb_user_addresses` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_user_addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `tb_users`
--

LOCK TABLES `tb_users` WRITE;
/*!40000 ALTER TABLE `tb_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `tbc_categories`
--

LOCK TABLES `tbc_categories` WRITE;
/*!40000 ALTER TABLE `tbc_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbc_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `tbc_payment_method_types`
--

LOCK TABLES `tbc_payment_method_types` WRITE;
/*!40000 ALTER TABLE `tbc_payment_method_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbc_payment_method_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `tbd_address_components`
--

LOCK TABLES `tbd_address_components` WRITE;
/*!40000 ALTER TABLE `tbd_address_components` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbd_address_components` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `tbd_cancellation_items`
--

LOCK TABLES `tbd_cancellation_items` WRITE;
/*!40000 ALTER TABLE `tbd_cancellation_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbd_cancellation_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `tbd_cart_items`
--

LOCK TABLES `tbd_cart_items` WRITE;
/*!40000 ALTER TABLE `tbd_cart_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbd_cart_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `tbd_order_items`
--

LOCK TABLES `tbd_order_items` WRITE;
/*!40000 ALTER TABLE `tbd_order_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbd_order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `tbd_products_categories`
--

LOCK TABLES `tbd_products_categories` WRITE;
/*!40000 ALTER TABLE `tbd_products_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbd_products_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `tbd_products_users_providers`
--

LOCK TABLES `tbd_products_users_providers` WRITE;
/*!40000 ALTER TABLE `tbd_products_users_providers` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbd_products_users_providers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `tbd_return_items`
--

LOCK TABLES `tbd_return_items` WRITE;
/*!40000 ALTER TABLE `tbd_return_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbd_return_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `tbd_user_payment_methods`
--

LOCK TABLES `tbd_user_payment_methods` WRITE;
/*!40000 ALTER TABLE `tbd_user_payment_methods` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbd_user_payment_methods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `tbd_users_wishlist_products`
--

LOCK TABLES `tbd_users_wishlist_products` WRITE;
/*!40000 ALTER TABLE `tbd_users_wishlist_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbd_users_wishlist_products` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-28 18:35:52

CREATE DATABASE  IF NOT EXISTS `pizzaordering` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `pizzaordering`;
-- MySQL dump 10.13  Distrib 8.0.16, for Win64 (x86_64)
--
-- Host: localhost    Database: pizzaordering
-- ------------------------------------------------------
-- Server version	8.0.16

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ingredient`
--

DROP TABLE IF EXISTS `ingredient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `ingredient` (
  `ingred_id` int(11) NOT NULL AUTO_INCREMENT,
  `ingred_name` varchar(45) DEFAULT NULL,
  `ingred_type` varchar(45) DEFAULT NULL,
  `ingred_unit_price` float DEFAULT NULL,
  PRIMARY KEY (`ingred_id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingredient`
--

LOCK TABLES `ingredient` WRITE;
/*!40000 ALTER TABLE `ingredient` DISABLE KEYS */;
INSERT INTO `ingredient` VALUES (1,'ORIGINAL','Crust Style',NULL),(2,'THIN','Crust Style',NULL),(3,'GLUTEN-FREE','Crust Style',NULL),(4,'SMALL','Size',NULL),(5,'MEDIUM','Size',NULL),(6,'LARGE','Size',NULL),(7,'EXTRA LARGE','Size',NULL),(8,'BBQ','Sauce',NULL),(9,'ALFREDO SAUCE','Sauce',NULL),(10,'RANCH','Sauce',NULL),(11,'ORIGINAL','Sauce',NULL),(12,'BUFFALO','Sauce',NULL),(13,'NORMAL','Sauce Amount',NULL),(14,'LIGHT','Sauce Amount',NULL),(15,'EXTRA','Sauce Amount',0),(16,'NONE','Sauce Amount',0),(17,'NORMAL','Bake',0),(18,'WELL DONE','Bake',0),(19,'NORMAL','Cut',0),(20,'SQUARE','Cut',0),(21,'NO CUT','Cut',0),(22,'CLEAN','Cut',0),(23,'NORMAL','Cheese Amount',0),(24,'LIGHT','Cheese Amount',0),(25,'NONE','Cheese Amount',0),(26,'Extra Cheese','Additional Cheese',1),(27,'Parmesan Romano','Additional Cheese',1),(28,'3 Cheese Blend','Additional Cheese',1),(29,'Grilled Chicken','MEATS',1),(30,'Pepperoni','MEATS',1),(31,'Beef','MEATS',1),(32,'Meatballs','MEATS',1),(33,'Spicy Italian Sausage','MEATS',1),(34,'Bacon','MEATS',1),(35,'Philly Steak','MEATS',1),(36,'Sausage','MEATS',1),(37,'Anchovies','MEATS',1),(38,'Canadian Bacon','MEATS',1),(39,'Salami','MEATS',1),(40,'Mushrooms','VEGGIES',0.5),(41,'Green Olives','VEGGIES',0.5),(42,'Roma Tomatoes','VEGGIES',0.5),(43,'Pineapples','VEGGIES',0.5),(44,'Onions','VEGGIES',0.5),(45,'Black Olives','VEGGIES',0.5),(46,'Fresh Spinach','VEGGIES',0.5),(47,'Jalapeño Peppers','VEGGIES',0.5),(48,'Banana Peppers','VEGGIES',0.5),(49,'Green Peppers','VEGGIES',0.5);
/*!40000 ALTER TABLE `ingredient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice`
--

DROP TABLE IF EXISTS `invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `invoice` (
  `invoice_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `invoice_date` date DEFAULT NULL,
  PRIMARY KEY (`invoice_id`),
  KEY `FK_user_id_idx` (`user_id`),
  CONSTRAINT `FK_invoice_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice`
--

LOCK TABLES `invoice` WRITE;
/*!40000 ALTER TABLE `invoice` DISABLE KEYS */;
INSERT INTO `invoice` VALUES (12,4,'2019-10-15'),(13,4,'2019-10-15'),(14,4,'2019-10-15'),(15,4,'2019-10-15'),(16,4,'2019-10-15'),(17,1,'2019-10-16'),(18,5,'2019-10-19'),(19,6,'2019-11-18');
/*!40000 ALTER TABLE `invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `item` (
  `item_id` int(11) NOT NULL AUTO_INCREMENT,
  `item_name` varchar(45) DEFAULT NULL,
  `item_description` varchar(250) DEFAULT NULL,
  `item_image` varchar(100) DEFAULT NULL,
  `item_type` varchar(50) DEFAULT NULL,
  `item_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
INSERT INTO `item` VALUES (1,'Cheese Pizza','Real cheese made from mozzarella, pizza sauce and your choice of crust.','images/items/pizza/cheese.jpg','Papa\'s Picks',4),(2,'Meatball Pepperoni','Meatballs, pepperoni, three-cheese blend, and Italian seasoning.','images/items/pizza/meatball pepperoni.jpg','Handcrafted Specialties',NULL),(3,'Pepperoni','Pepperoni, real cheese made from mozzarella, and your choice of crust.','images/items/pizza/pepperoni.jpg','Papa\'s Picks',2),(4,'Sausage','Sausage and real cheese made from mozzarella with your choice of crust.','images/items/pizza/sausage.jpg','Papa\'s Picks',3),(5,'Super Hawaiian','Pineapple, Canadian bacon, bacon, and three-cheese blend.','images/items/pizza/super hawaiian.jpg','Handcrafted Specialties',NULL),(6,'The Meats','Pepperoni, sausage, beef, bacon, and Canadian bacon.','images/items/pizza/the meats.jpg','Handcrafted Specialties',NULL),(7,'The Works','Pepperoni, Canadian bacon, spicy Italian sausage, onions, green peppers, mushrooms, and black olives.','images/items/pizza/the works.jpg','Handcrafted Specialties',NULL),(8,'Ultimate Pepperoni','30% more pepperoni than our traditional pie, Parmesan and Romano cheese blend, sprinkled with Italian seasoning.','images/items/pizza/ultimate pepperoni.jpg','Handcrafted Specialties',NULL),(9,'Create Your Own',NULL,NULL,'Papa\'s Picks',1),(10,'Zesty Italian Trio',NULL,NULL,'Handcrafted Specialties',NULL),(11,'Fiery Buffalo Chicken',NULL,NULL,'Handcrafted Specialties',NULL),(12,'Philly Cheesesteak',NULL,NULL,'Handcrafted Specialties',NULL),(13,'Pepperoni, Sausage & Six Cheese',NULL,NULL,'Handcrafted Specialties',NULL),(14,'BBQ Chicken & Bacon',NULL,NULL,'Handcrafted Specialties',NULL),(15,'Fresh Spinach & Tomato Alfredo',NULL,NULL,'Handcrafted Meatless Specialties',NULL),(16,'Garden Fresh',NULL,NULL,'Handcrafted Meatless Specialties',NULL),(17,'Tuscan Six Cheese',NULL,NULL,'Handcrafted Meatless Specialties',NULL),(18,'Create Your Own Gluten-Free Crust',NULL,NULL,'Gluten-Free Crust With Ancient Grains',NULL),(19,'Hawaiian BBQ Chicken',NULL,NULL,'Local Flavors',NULL),(20,'Foligno Favorite',NULL,NULL,'Local Flavors',NULL),(21,'The Defender',NULL,NULL,'Local Flavors',NULL),(22,'Garlic Knots',NULL,NULL,'Papa\'s Starters',NULL),(23,'Garlic Parmesan Breadsticks',NULL,NULL,'Papa\'s Starters',NULL),(24,'Cheesesticks',NULL,NULL,'Papa\'s Starters',NULL),(25,'Original Breadsticks',NULL,NULL,'Papa\'s Starters',NULL),(26,'Tuscan 6-Cheese Cheesesticks',NULL,NULL,'Papa\'s Starters',NULL),(27,'Bacon Cheesesticks',NULL,NULL,'Papa\'s Starters',NULL),(28,'Unsauced Roasted Wings',NULL,NULL,'Papa\'s Wings',NULL),(29,'Buffalo Wings',NULL,NULL,'Papa\'s Wings',NULL),(30,'BBQ Wings',NULL,NULL,'Papa\'s Wings',NULL),(31,'Honey Chipotle Wings',NULL,NULL,'Papa\'s Wings',NULL),(32,'Garlic Parmesan Wings',NULL,NULL,'Papa\'s Wings',NULL),(33,'Chicken Poppers',NULL,NULL,'Papa\'s Poppers',NULL),(34,'Honey Chipotle Chicken Poppers',NULL,NULL,'Papa\'s Poppers',NULL),(35,'Buffalo Chicken Poppers',NULL,NULL,'Papa\'s Poppers',NULL),(36,'BBQ Chicken Poppers',NULL,NULL,'Papa\'s Poppers',NULL),(37,'Cinnamon Pull Aparts',NULL,NULL,'Desserts',NULL),(38,'Chocolate Chip Cookie',NULL,NULL,'Desserts',NULL),(39,'Double Chocolate Chip Brownie',NULL,NULL,'Desserts',NULL),(40,'Pepsi',NULL,NULL,'Ice Cold Pepsi Beverages',NULL),(41,'Mountain Dew',NULL,NULL,'Ice Cold Pepsi Beverages',NULL),(42,'Diet Pepsi',NULL,NULL,'Ice Cold Pepsi Beverages',NULL),(43,'Aquafina',NULL,NULL,'Ice Cold Pepsi Beverages',NULL),(44,'Sierra Mist',NULL,NULL,'Ice Cold Pepsi Beverages',NULL),(45,'Crush Orange',NULL,NULL,'Ice Cold Pepsi Beverages',NULL),(46,'Dr. Pepper',NULL,NULL,'Ice Cold Pepsi Beverages',NULL),(47,'Special Garlic Sauce',NULL,NULL,'Dipping Sauces',NULL),(48,'Pizza Sauce',NULL,NULL,'Dipping Sauces',NULL),(49,'Ranch Sauce',NULL,NULL,'Dipping Sauces',NULL),(50,'Blue Cheese Sauce',NULL,NULL,'Dipping Sauces',NULL),(51,'Buffalo Sauce',NULL,NULL,'Dipping Sauces',NULL),(52,'BBQ Sauce',NULL,NULL,'Dipping Sauces',NULL),(53,'Honey Mustard Sauce',NULL,NULL,'Dipping Sauces',NULL),(54,'Cheese Sauce',NULL,NULL,'Dipping Sauces',NULL),(55,'Honey Chipotle Sauce',NULL,NULL,'Dipping Sauces',NULL),(56,'Special Seasonings',NULL,NULL,'Seasoning Packets',NULL),(57,'Crushed Red Pepper',NULL,NULL,'Seasoning Packets',NULL),(58,'Parmesan Cheese',NULL,NULL,'Seasoning Packets',NULL),(59,'Pepperoncinis',NULL,NULL,'Extras',NULL),(60,'Jalapeño Peppers',NULL,NULL,'Extras',NULL),(61,'Banana Peppers',NULL,NULL,'Extras',NULL);
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `line`
--

DROP TABLE IF EXISTS `line`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `line` (
  `line_id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_id` int(11) NOT NULL,
  `item_id` int(11) DEFAULT NULL,
  `line_units` int(11) DEFAULT NULL,
  `line_price` float DEFAULT NULL,
  PRIMARY KEY (`line_id`,`invoice_id`),
  UNIQUE KEY `line_id_UNIQUE` (`line_id`),
  KEY `FK_line_item_id_idx` (`item_id`),
  CONSTRAINT `FK_line_item_id` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `line`
--

LOCK TABLES `line` WRITE;
/*!40000 ALTER TABLE `line` DISABLE KEYS */;
INSERT INTO `line` VALUES (10,12,3,1,11.99),(11,12,4,1,11.99),(12,12,1,1,11.99),(13,12,40,1,2.99),(14,13,4,1,11.99),(15,13,3,1,11.99),(16,13,2,1,16.49),(17,13,41,1,2.99),(18,14,3,1,11.99),(19,14,4,1,11.99),(20,14,1,1,11.99),(21,14,41,1,2.99),(22,15,3,1,11.99),(23,15,4,1,11.99),(24,15,1,1,11.99),(25,15,41,1,2.99),(26,16,3,1,11.99),(27,16,4,1,11.99),(28,16,1,1,11.99),(29,16,42,1,2.99),(30,17,3,1,11.99),(31,17,4,1,13.49),(32,18,3,1,11.99),(33,18,4,1,11.99),(34,19,4,1,14.49),(35,19,38,1,6.89),(36,19,41,1,2.99);
/*!40000 ALTER TABLE `line` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `order` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_id` int(11) NOT NULL,
  `order_type` varchar(8) DEFAULT NULL,
  `order_address` varchar(255) DEFAULT NULL,
  `store_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`order_id`,`invoice_id`),
  KEY `FK_order_inv_id_idx` (`invoice_id`),
  CONSTRAINT `FK_order_inv_id` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`invoice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (3,16,'DELIVERY','1777 Schrock Rd APT F, Columbus, OH 43229, USA',NULL),(4,17,'DELIVERY','1777 Schrock Rd APT F, Columbus, OH 43229, USA',NULL),(5,18,'DELIVERY','1777 Schrock Rd APT F, Columbus, OH 43229, USA',NULL),(6,19,'DELIVERY','1777 Schrock Rd APT F, Columbus, OH 43229, USA',NULL);
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `price`
--

DROP TABLE IF EXISTS `price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `price` (
  `price_id` int(11) NOT NULL AUTO_INCREMENT,
  `price_desc` varchar(45) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`price_id`)
) ENGINE=InnoDB AUTO_INCREMENT=174 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `price`
--

LOCK TABLES `price` WRITE;
/*!40000 ALTER TABLE `price` DISABLE KEYS */;
INSERT INTO `price` VALUES (1,'Gluten-Free',9.74,1),(2,'Small',7.99,1),(3,'Medium',9.99,1),(4,'Large',11.99,1),(5,'Thin-Crust',11.99,1),(6,'Extra Large',14.99,1),(7,'Extra Large',14.99,3),(8,'Gluten-Free',9.74,3),(9,'Large',11.99,3),(10,'Medium',9.99,3),(11,'Small',7.99,3),(12,'Thin-Crust',11.99,3),(13,'Extra Large',14.99,4),(14,'Gluten-Free',9.74,4),(15,'Large',11.99,4),(16,'Medium',9.99,4),(17,'Small',7.99,4),(18,'Thin-Crust',11.99,4),(19,'Gluten-Free',11.99,7),(20,'Small Original',10.99,7),(21,'Medium Original',12.99,7),(22,'Large Original',16.49,7),(23,'Thin-Crust',16.49,7),(24,'Extra Large Original',17.99,7),(25,'Gluten-Free',11.99,2),(26,'Small Original',10.99,2),(27,'Medium Original',12.99,2),(28,'Large Original',16.49,2),(29,'Thin-Crust',16.49,2),(30,'Extra Large Original',17.99,2),(31,'Gluten-Free',11.99,5),(32,'Small Original',10.99,5),(33,'Medium Original',12.99,5),(34,'Large Original',16.49,5),(35,'Thin-Crust',16.49,5),(36,'Extra Large Original',17.99,5),(37,'Gluten-Free',11.99,6),(38,'Small Original',10.99,6),(39,'Medium Original',12.99,6),(40,'Large Original',16.49,6),(41,'Thin-Crust',16.49,6),(42,'Extra Large Original',17.99,6),(43,'Gluten-Free',11.99,8),(44,'Small Original',10.99,8),(45,'Medium Original',12.99,8),(46,'Large Original',16.49,8),(47,'Thin-Crust',16.49,8),(48,'Extra Large Original',17.99,8),(49,'Gluten-Free',11.99,10),(50,'Small Original',10.99,10),(51,'Medium Original',12.99,10),(52,'Large Original',16.49,10),(53,'Thin-Crust',16.49,10),(54,'Extra Large Original',17.99,10),(55,'Gluten-Free',11.99,11),(56,'Small Original',10.99,11),(57,'Medium Original',12.99,11),(58,'Large Original',16.49,11),(59,'Thin-Crust',16.49,11),(60,'Extra Large Original',17.99,11),(61,'Gluten-Free',11.99,12),(62,'Small Original',10.99,12),(63,'Medium Original',12.99,12),(64,'Large Original',16.49,12),(65,'Thin-Crust',16.49,12),(66,'Extra Large Original',17.99,12),(67,'Gluten-Free',11.99,13),(68,'Small Original',10.99,13),(69,'Medium Original',12.99,13),(70,'Large Original',16.49,13),(71,'Thin-Crust',16.49,13),(72,'Extra Large Original',17.99,13),(73,'Gluten-Free',11.99,14),(74,'Small Original',10.99,14),(75,'Medium Original',12.99,14),(76,'Large Original',16.49,14),(77,'Thin-Crust',16.49,14),(78,'Extra Large Original',17.99,14),(79,'Gluten-Free',11.99,15),(80,'Small Original',10.99,15),(81,'Medium Original',12.99,15),(82,'Large Original',16.49,15),(83,'Thin-Crust',16.49,15),(84,'Extra Large Original',17.99,15),(85,'Gluten-Free',11.99,16),(86,'Small Original',10.99,16),(87,'Medium Original',12.99,16),(88,'Large Original',16.49,16),(89,'Thin-Crust',16.49,16),(90,'Extra Large Original',17.99,16),(91,'Gluten-Free',11.99,17),(92,'Small Original',10.99,17),(93,'Medium Original',12.99,17),(94,'Large Original',16.49,17),(95,'Thin-Crust',16.49,17),(96,'Extra Large Original',17.99,17),(97,'Gluten-Free',11.99,18),(98,'Small Original',10.99,18),(99,'Medium Original',12.99,18),(100,'Large Original',16.49,18),(101,'Thin-Crust',16.49,18),(102,'Extra Large Original',17.99,18),(103,'Gluten-Free',11.99,19),(104,'Small Original',10.99,19),(105,'Medium Original',12.99,19),(106,'Large Original',16.49,19),(107,'Thin-Crust',16.49,19),(108,'Extra Large Original',17.99,19),(109,'Gluten-Free',11.99,20),(110,'Small Original',10.99,20),(111,'Medium Original',12.99,20),(112,'Large Original',16.49,20),(113,'Thin-Crust',16.49,20),(114,'Extra Large Original',17.99,20),(115,'Gluten-Free',11.99,21),(116,'Small Original',10.99,21),(117,'Medium Original',12.99,21),(118,'Large Original',16.49,21),(119,'Thin-Crust',16.49,21),(120,'Extra Large Original',17.99,21),(121,'8 piece',5.49,22),(122,'Garlic Parm',6.89,23),(123,'10 inch',6.89,24),(124,'Breadstick',6.89,25),(125,'10 inch',6.89,26),(126,'10 inch',6.89,27),(127,'8 piece',7.99,28),(128,'8 piece',7.99,29),(129,'8 piece',7.99,30),(130,'8 piece',7.99,31),(131,'8 piece',7.99,32),(132,'10  piece',7.49,33),(133,'10 piece',7.49,34),(134,'10 piece',7.49,35),(135,'10 piece',7.49,36),(136,'Cinnamon Pull Aparts',6.89,37),(137,'Family CC Cookie',6.89,38),(138,'Dbl Choc Brownie',6.89,39),(139,'20 oz.',1.79,40),(140,'2-Liter Brownie',2.99,40),(141,'20 oz.',1.79,41),(142,'2-Liter Brownie',2.99,41),(143,'20 oz.',1.79,42),(144,'2-Liter Brownie',2.99,42),(145,'20 oz.',1.79,43),(146,'2-Liter Brownie',2.99,43),(147,'20 oz.',1.79,44),(148,'2-Liter Brownie',2.99,44),(149,'20 oz.',1.79,45),(150,'2-Liter Brownie',2.99,45),(151,'20 oz.',1.79,46),(152,'2-Liter Brownie',2.99,46),(153,'Special Garlic',0.49,47),(154,'Pizza',0.49,48),(155,'Ranch',0.49,49),(156,'Blue Cheese',0.49,50),(157,'Buffalo',0.49,51),(158,'Barbeque',0.49,52),(159,'Honey Mustard',0.49,53),(160,'Cheese',0.49,54),(161,'Honey Chipotle',0.49,55),(162,'Seasonings',0.15,56),(163,'Crushed Red Pepper',0.15,57),(164,'Parmesan Cheese',0.15,58),(165,'Pepperoncinis',0.49,59),(166,'Jalapeño Peppers',0.49,60),(167,'Banana Peppers',0.49,61),(168,'Small',7.99,9),(169,'Medium',9.99,9),(170,'Large',11.99,9),(171,'Extra Large',14.99,9),(172,'Gluten-Free',9.74,9),(173,'Thin-Crust',11.99,9);
/*!40000 ALTER TABLE `price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipe`
--

DROP TABLE IF EXISTS `recipe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `recipe` (
  `recipe_id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) DEFAULT NULL,
  `ingred_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`recipe_id`),
  KEY `FK_item_id_idx` (`item_id`),
  KEY `FK_ingred_id_idx` (`ingred_id`),
  CONSTRAINT `FK_recipe_ingred_id` FOREIGN KEY (`ingred_id`) REFERENCES `ingredient` (`ingred_id`),
  CONSTRAINT `FK_recipe_item_id` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipe`
--

LOCK TABLES `recipe` WRITE;
/*!40000 ALTER TABLE `recipe` DISABLE KEYS */;
INSERT INTO `recipe` VALUES (1,7,49),(2,7,40),(3,7,45),(4,7,44),(5,7,38),(6,7,33),(7,7,30),(8,3,30),(9,4,36),(10,6,31),(11,6,38),(12,6,34),(13,6,30),(14,6,36),(15,2,28),(16,2,32),(17,2,30),(18,5,28),(19,5,38),(20,5,34),(21,5,43),(22,8,27),(23,8,30),(24,10,28),(25,10,39),(26,10,33),(27,10,30),(28,10,48),(29,11,29),(30,11,34),(31,11,44),(32,12,28),(33,12,49),(34,12,44),(35,12,35),(36,13,27),(37,13,28),(38,13,30),(39,13,36),(40,14,29),(41,14,34),(42,14,44),(43,15,46),(44,15,42),(45,16,49),(46,16,40),(47,16,44),(48,16,45),(49,16,42),(50,17,27),(51,17,28),(52,19,29),(53,19,34),(54,19,43),(55,19,44),(56,20,28),(57,20,33),(58,20,44),(59,20,30),(60,20,48),(61,21,27),(62,21,30);
/*!40000 ALTER TABLE `recipe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subtype`
--

DROP TABLE IF EXISTS `subtype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `subtype` (
  `subtype_id` int(11) NOT NULL AUTO_INCREMENT,
  `subtype_parent` varchar(45) DEFAULT NULL,
  `subtype_name` varchar(45) DEFAULT NULL,
  `subtype_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`subtype_id`)
) ENGINE=InnoDB AUTO_INCREMENT=177 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subtype`
--

LOCK TABLES `subtype` WRITE;
/*!40000 ALTER TABLE `subtype` DISABLE KEYS */;
INSERT INTO `subtype` VALUES (34,'CUSTOMIZATION','INSTRUCTIONS',1),(35,'CUSTOMIZATION','CHEESES',2),(36,'INSTRUCTIONS','Size',NULL),(37,'INSTRUCTIONS','Crust Style',NULL),(38,'INSTRUCTIONS','Sauce',NULL),(39,'INSTRUCTIONS','Sauce Amount',NULL),(40,'INSTRUCTIONS','Bake',NULL),(41,'INSTRUCTIONS','Cut',NULL),(42,'Size','Small',NULL),(43,'Size','Medium',NULL),(44,'Size','Large',NULL),(45,'Size','Extra Large',NULL),(46,'Crust','Original',NULL),(47,'Crust','Thin',NULL),(48,'Crust','Gluten-Free',NULL),(49,'Sauce','BBQ',NULL),(50,'Sauce','Alfredo',NULL),(51,'Sauce','Ranch',NULL),(52,'Sauce','Original',NULL),(53,'Sauce','Buffalo',NULL),(54,'Sauce Amount','Normal',NULL),(55,'Sauce Amount','Light',NULL),(56,'Sauce Amount','Extra',NULL),(57,'Sauce Amount','None',NULL),(58,'Bake','Normal',NULL),(59,'Bake','Well Done',NULL),(60,'Cut','Normal',NULL),(61,'Cut','Square',NULL),(62,'Cut','No Cut',NULL),(63,'Cut','Clean',NULL),(64,'TOPPINGS','CHEESES',NULL),(65,'TOPPINGS','MEATS',3),(66,'TOPPINGS','VEGGIES',4),(67,'CHEESES','Cheese Amount',NULL),(68,'CHEESES','Additional Cheese',NULL),(69,'Cheese Amount','Normal',NULL),(70,'Cheese Amount','Light',NULL),(71,'Cheese Amount','None',NULL),(72,'Additional','Extra Cheese',NULL),(73,'Additional','Parmesan Romano',NULL),(74,'Additional','3-Cheese Blend',NULL),(75,'MEATS','MEATS',NULL),(86,'VEGGIES','VEGGIES',NULL),(96,'ITEMS','PIZZAS',NULL),(97,'ITEMS','SIDES',NULL),(98,'ITEMS','DESSERTS',NULL),(99,'ITEMS','DRINKS',NULL),(100,'ITEMS','EXTRAS',NULL),(101,'PIZZAS','Papa\'s Picks',1),(102,'PIZZAS','Handcrafted Specialties',2),(103,'PIZZAS','Handcrafted Meatless Specialties',3),(104,'PIZZAS','Gluten-Free Crust With Ancient Grains',4),(105,'PIZZAS','Local Flavors',5),(106,'Papa\'s Picks','Pepperoni',NULL),(107,'Papa\'s Picks','Sausage',NULL),(108,'Papa\'s Picks','Cheese Pizza',NULL),(109,'Handcrafted Specialties','The Works',NULL),(110,'Handcrafted Specialties','The Meats',NULL),(111,'Handcrafted Specialties','Meatball Pepperoni',NULL),(112,'Handcrafted Specialties','Super Hawaiian',NULL),(113,'Handcrafted Specialties','Ultimate Pepperoni',NULL),(114,'Handcrafted Specialties','Zesty Italian Trio',NULL),(115,'Handcrafted Specialties','Fiery Buffalo Chicken',NULL),(116,'Handcrafted Specialties','Philly Cheesesteak',NULL),(117,'Handcrafted Specialties','Pepperoni, Sausage & Six Cheese',NULL),(118,'Handcrafted Specialties','BBQ Chicken & Bacon',NULL),(119,'Handcrafted Meatless Specialties','Fresh Spinach & Tomato Alfredo',NULL),(120,'Handcrafted Meatless Specialties','Garden Fresh',NULL),(121,'Handcrafted Meatless Specialties','Tuscan Six Cheese',NULL),(122,'Gluten-free Crust With Ancient Grains','Create Your Own Gluten-Free Crust',NULL),(123,'Local Flavors','Hawaiian BBQ Chicken',NULL),(124,'Local Flavors','Foligno Favorite',NULL),(125,'Local Flavors','The Defender',NULL),(126,'SIDES','Papa\'s Starters',1),(127,'SIDES','Papa\'s Wings',2),(128,'SIDES','Papa\'s Poppers',3),(129,'Papa\'s Starters','Garlic Knots',NULL),(130,'Papa\'s Starters','Garlic Parmesan Breadsticks',NULL),(131,'Papa\'s Starters','Cheesesticks',NULL),(132,'Papa\'s Starters','Original Breadsticks',NULL),(133,'Papa\'s Starters','Tuscan 6-Cheese Cheesesticks',NULL),(134,'Papa\'s Starters','Bacon Cheesesticks',NULL),(135,'Papa\'s Wings','Unsauced Roasted Wings',NULL),(136,'Papa\'s Wings','Buffalo Wings',NULL),(137,'Papa\'s Wings','BBQ Wings',NULL),(138,'Papa\'s Wings','Honey Chipotle Wings',NULL),(139,'Papa\'s Wings','Garlic Parmesan Wings',NULL),(140,'Papa\'s Poppers','Chicken Poppers',NULL),(141,'Papa\'s Poppers','Honey Chipotle Chicken Poppers',NULL),(142,'Papa\'s Poppers','Buffalo Chicken Poppers',NULL),(143,'Papa\'s Poppers','BBQ Chicken Poppers',NULL),(147,'Ice Cold Pepsi Beverages','Pepsi',NULL),(148,'Ice Cold Pepsi Beverages','Mountain Dew',NULL),(149,'Ice Cold Pepsi Beverages','Diet Pepsi',NULL),(150,'Ice Cold Pepsi Beverages','Aquafina',NULL),(151,'Ice Cold Pepsi Beverages','Sierra Mist',NULL),(152,'Ice Cold Pepsi Beverages','Crush Orange',NULL),(153,'Ice Cold Pepsi Beverages','Dr. Pepper',NULL),(154,'EXTRAS','Dipping Sauces',1),(155,'EXTRAS','Seasoning Packets',2),(156,'EXTRAS','Extras',3),(172,'CUSTOMIZATION','MEATS',3),(173,'CUSTOMIZATION','VEGGIES',4),(175,'DRINKS','Ice Cold Pepsi Beverages',NULL),(176,'DESSERTS','Desserts',NULL);
/*!40000 ALTER TABLE `subtype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `type`
--

DROP TABLE IF EXISTS `type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `type` (
  `type_id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(30) DEFAULT NULL,
  `type_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `type`
--

LOCK TABLES `type` WRITE;
/*!40000 ALTER TABLE `type` DISABLE KEYS */;
INSERT INTO `type` VALUES (1,'PIZZAS',0),(2,'SIDES',1),(3,'DESSERTS',2),(4,'DRINKS',3),(5,'EXTRAS',4);
/*!40000 ALTER TABLE `type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_password` varchar(100) DEFAULT NULL,
  `user_firstName` varchar(10) DEFAULT NULL,
  `user_lastName` varchar(10) DEFAULT NULL,
  `user_email` varchar(50) DEFAULT NULL,
  `user_phone` varchar(20) DEFAULT NULL,
  `user_street` varchar(50) DEFAULT NULL,
  `user_bldType` varchar(10) DEFAULT NULL,
  `user_bldNum` varchar(5) DEFAULT NULL,
  `user_city` varchar(20) DEFAULT NULL,
  `user_state` varchar(20) DEFAULT NULL,
  `user_zipCode` varchar(20) DEFAULT NULL,
  `user_addrType` varchar(45) DEFAULT NULL,
  `user_country` varchar(45) DEFAULT NULL,
  `user_pwd_salt` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'password','Larry','Xu','LarryXu@gmail.com','(614) 333-3333','1777 Schrock Rd','Apt','F','Columbus','OH','43229',NULL,'USA',NULL),(4,'999999999','Larry','Huang','LarryHuang@gmail.com','(614) 444-4444','1893 Oakland Park Ave','NON',NULL,'Columbus','OH','43225','HOME','usa',NULL),(5,'bdfad1a29da7b48d5f2a695b1a8ee5c4f85335797da83fb9a3cee10f590e00d3','Ying','Larry','LarryYing@gmail.com','(614) 444-4444','1893 Oakland Park Ave','APT','C','Columbus','OH','43224','HOME','usa','ML1dJYPsxhCWzx+qHwGz09MQTvHu5UELlsDuEwa+CFV0g7fUA19kpxaxvGPLvfgETD9zuSpt30zDFkcvxP1/014QtvucyX84H/CZfeKP5UbXrG6XX3bRBIVhq1dP/h0ML0v1Ul/0Yg1EQHIw2xZXj0sKd6r3HRjux5kX2rxFN34='),(6,'ddb6dae127e381e5aaebb50d053361846a7034706db9888ac54cac63f79f90fe','Larry','Xu','xuxiaocun2008@gmail.com','(614) 444-4444',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Gg9dzfn0tW8uizTYPCndJBW4NzjIHV4/cge1J2w4k+NeUbBiZOa3F6MLte3nKQ8JWEMYbRGNgS9Yn7I0No1ROkNAMpomStOWm3MnRKjlHZrVklEfwfmUmFv4bB/fglAAwhiaRdhrKaJAD0GLCc93CWxwaHHmkjTp5nahyu1mdOM=');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-11-20 16:29:14

-- MySQL dump 10.13  Distrib 5.5.20, for Win64 (x86)
--
-- Host: localhost    Database: sherlock
-- ------------------------------------------------------
-- Server version	5.5.20-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary table structure for view `client_record_v`
--

DROP TABLE IF EXISTS `client_record_v`;
/*!50001 DROP VIEW IF EXISTS `client_record_v`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `client_record_v` (
  `client_id` int(11),
  `record_id` int(11)
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `client_session`
--

DROP TABLE IF EXISTS `client_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_session` (
  `client_id` int(11) NOT NULL,
  `session_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client_session`
--

LOCK TABLES `client_session` WRITE;
/*!40000 ALTER TABLE `client_session` DISABLE KEYS */;
INSERT INTO `client_session` VALUES (1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),(1,9),(1,10),(1,11),(1,12);
/*!40000 ALTER TABLE `client_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `client_session_t`
--

DROP TABLE IF EXISTS `client_session_t`;
/*!50001 DROP VIEW IF EXISTS `client_session_t`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `client_session_t` (
  `client_id` int(11),
  `session_id` int(11)
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `client_variable`
--

DROP TABLE IF EXISTS `client_variable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_variable` (
  `client_id` int(11) NOT NULL,
  `var_name` char(32) NOT NULL,
  `var_value` varchar(255) NOT NULL,
  UNIQUE KEY `client_id` (`client_id`,`var_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client_variable`
--

LOCK TABLES `client_variable` WRITE;
/*!40000 ALTER TABLE `client_variable` DISABLE KEYS */;
INSERT INTO `client_variable` VALUES (1,'favorite_color','#c6eee5');
/*!40000 ALTER TABLE `client_variable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fp_client`
--

DROP TABLE IF EXISTS `fp_client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fp_client` (
  `client_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fp_client`
--

LOCK TABLES `fp_client` WRITE;
/*!40000 ALTER TABLE `fp_client` DISABLE KEYS */;
INSERT INTO `fp_client` VALUES (1);
/*!40000 ALTER TABLE `fp_client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fp_field`
--

DROP TABLE IF EXISTS `fp_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fp_field` (
  `field_id` int(11) NOT NULL,
  `field_name` varchar(32) NOT NULL,
  `store` tinyint(1) NOT NULL,
  `validate` tinyint(1) NOT NULL,
  `return_param` char(16) DEFAULT NULL,
  PRIMARY KEY (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fp_field`
--

LOCK TABLES `fp_field` WRITE;
/*!40000 ALTER TABLE `fp_field` DISABLE KEYS */;
INSERT INTO `fp_field` VALUES (1,'Useragent',1,0,''),(2,'SessionCookie',1,0,''),(3,'RemoteIp',1,0,''),(4,'AcceptedLangs',1,0,''),(5,'RemoteIpBlock',1,0,''),(6,'Platform',1,0,''),(7,'ScreenResWidth',1,1,'iw'),(8,'ScreenResHeight',1,1,'ih'),(9,'Etag',1,0,''),(10,'ValidationToken',0,0,''),(11,'ReturnToken',1,0,'token'),(12,'TimeOffset',1,1,'toff');
/*!40000 ALTER TABLE `fp_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fp_record`
--

DROP TABLE IF EXISTS `fp_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fp_record` (
  `record_id` int(11) NOT NULL AUTO_INCREMENT,
  `field_id` int(11) NOT NULL,
  `field_value` varchar(255) NOT NULL,
  PRIMARY KEY (`record_id`),
  UNIQUE KEY `field_id` (`field_id`,`field_value`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fp_record`
--

LOCK TABLES `fp_record` WRITE;
/*!40000 ALTER TABLE `fp_record` DISABLE KEYS */;
INSERT INTO `fp_record` VALUES (1,1,'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2'),(2,2,'8ea3cb7c35062fff38802d04b17be840'),(3,3,'127.0.0.1'),(4,4,'en-us,en;q=0.5'),(5,5,'127.0.0'),(6,6,'Win7-win64'),(8,7,'1170'),(9,8,'578'),(14,12,'-1');
/*!40000 ALTER TABLE `fp_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fp_session`
--

DROP TABLE IF EXISTS `fp_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fp_session` (
  `session_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fp_session`
--

LOCK TABLES `fp_session` WRITE;
/*!40000 ALTER TABLE `fp_session` DISABLE KEYS */;
INSERT INTO `fp_session` VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12);
/*!40000 ALTER TABLE `fp_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `record_client_count_v`
--

DROP TABLE IF EXISTS `record_client_count_v`;
/*!50001 DROP VIEW IF EXISTS `record_client_count_v`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `record_client_count_v` (
  `record_id` int(11),
  `client_count` bigint(21)
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `session_record`
--

DROP TABLE IF EXISTS `session_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `session_record` (
  `session_id` int(11) NOT NULL,
  `record_id` int(11) NOT NULL,
  `record_timestamp` datetime NOT NULL,
  PRIMARY KEY (`session_id`,`record_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session_record`
--

LOCK TABLES `session_record` WRITE;
/*!40000 ALTER TABLE `session_record` DISABLE KEYS */;
INSERT INTO `session_record` VALUES (1,1,'2012-03-14 17:28:15'),(1,2,'2012-03-14 17:28:15'),(1,3,'2012-03-14 17:28:15'),(1,4,'2012-03-14 17:28:15'),(1,5,'2012-03-14 17:28:15'),(1,6,'2012-03-14 17:28:16'),(1,8,'2012-03-14 17:28:16'),(1,9,'2012-03-14 17:28:16'),(2,1,'2012-03-14 17:42:17'),(2,2,'2012-03-14 17:42:17'),(2,3,'2012-03-14 17:42:17'),(2,4,'2012-03-14 17:42:17'),(2,5,'2012-03-14 17:42:18'),(2,6,'2012-03-14 17:42:18'),(2,8,'2012-03-14 17:42:18'),(2,9,'2012-03-14 17:42:18'),(3,1,'2012-03-14 17:44:02'),(3,2,'2012-03-14 17:44:02'),(3,3,'2012-03-14 17:44:02'),(3,4,'2012-03-14 17:44:02'),(3,5,'2012-03-14 17:44:02'),(3,6,'2012-03-14 17:44:02'),(3,8,'2012-03-14 17:44:03'),(3,9,'2012-03-14 17:44:03'),(4,1,'2012-03-14 17:45:28'),(4,2,'2012-03-14 17:45:28'),(4,3,'2012-03-14 17:45:28'),(4,4,'2012-03-14 17:45:28'),(4,5,'2012-03-14 17:45:28'),(4,6,'2012-03-14 17:45:28'),(4,8,'2012-03-14 17:45:29'),(4,9,'2012-03-14 17:45:29'),(5,1,'2012-03-14 18:15:13'),(5,2,'2012-03-14 18:15:13'),(5,3,'2012-03-14 18:15:13'),(5,4,'2012-03-14 18:15:13'),(5,5,'2012-03-14 18:15:14'),(5,6,'2012-03-14 18:15:14'),(5,8,'2012-03-14 18:15:14'),(5,9,'2012-03-14 18:15:14'),(5,14,'2012-03-14 18:15:14'),(6,1,'2012-03-14 18:15:48'),(6,2,'2012-03-14 18:15:49'),(6,3,'2012-03-14 18:15:49'),(6,4,'2012-03-14 18:15:49'),(6,5,'2012-03-14 18:15:49'),(6,6,'2012-03-14 18:15:49'),(6,8,'2012-03-14 18:15:49'),(6,9,'2012-03-14 18:15:49'),(6,14,'2012-03-14 18:15:49'),(7,1,'2012-03-14 18:17:26'),(7,2,'2012-03-14 18:17:26'),(7,3,'2012-03-14 18:17:26'),(7,4,'2012-03-14 18:17:27'),(7,5,'2012-03-14 18:17:27'),(7,6,'2012-03-14 18:17:27'),(7,8,'2012-03-14 18:17:27'),(7,9,'2012-03-14 18:17:27'),(7,14,'2012-03-14 18:17:27'),(8,1,'2012-03-14 18:18:13'),(8,2,'2012-03-14 18:18:13'),(8,3,'2012-03-14 18:18:13'),(8,4,'2012-03-14 18:18:13'),(8,5,'2012-03-14 18:18:13'),(8,6,'2012-03-14 18:18:13'),(8,8,'2012-03-14 18:18:14'),(8,9,'2012-03-14 18:18:14'),(9,1,'2012-03-14 18:18:24'),(9,2,'2012-03-14 18:18:24'),(9,3,'2012-03-14 18:18:24'),(9,4,'2012-03-14 18:18:24'),(9,5,'2012-03-14 18:18:24'),(9,6,'2012-03-14 18:18:24'),(9,8,'2012-03-14 18:18:25'),(9,9,'2012-03-14 18:18:25'),(10,1,'2012-03-14 18:25:03'),(10,2,'2012-03-14 18:25:03'),(10,3,'2012-03-14 18:25:03'),(10,4,'2012-03-14 18:25:04'),(10,5,'2012-03-14 18:25:04'),(10,6,'2012-03-14 18:25:04'),(10,8,'2012-03-14 18:25:04'),(10,9,'2012-03-14 18:25:04'),(10,14,'2012-03-14 18:25:04'),(11,1,'2012-03-14 18:37:38'),(11,2,'2012-03-14 18:37:39'),(11,3,'2012-03-14 18:37:39'),(11,4,'2012-03-14 18:37:39'),(11,5,'2012-03-14 18:37:39'),(11,6,'2012-03-14 18:37:39'),(11,8,'2012-03-14 18:37:39'),(11,9,'2012-03-14 18:37:39'),(11,14,'2012-03-14 18:37:39'),(12,1,'2012-03-14 18:38:07'),(12,2,'2012-03-14 18:38:08'),(12,3,'2012-03-14 18:38:08'),(12,4,'2012-03-14 18:38:08'),(12,5,'2012-03-14 18:38:08'),(12,6,'2012-03-14 18:38:08'),(12,8,'2012-03-14 18:38:08'),(12,9,'2012-03-14 18:38:08'),(12,14,'2012-03-14 18:38:09');
/*!40000 ALTER TABLE `session_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sherlock_config`
--

DROP TABLE IF EXISTS `sherlock_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sherlock_config` (
  `name` varchar(32) NOT NULL,
  `value` varchar(255) NOT NULL,
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sherlock_config`
--

LOCK TABLES `sherlock_config` WRITE;
/*!40000 ALTER TABLE `sherlock_config` DISABLE KEYS */;
INSERT INTO `sherlock_config` VALUES ('db_version','7');
/*!40000 ALTER TABLE `sherlock_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `client_record_v`
--

/*!50001 DROP TABLE IF EXISTS `client_record_v`*/;
/*!50001 DROP VIEW IF EXISTS `client_record_v`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `client_record_v` AS select distinct `fp_client`.`client_id` AS `client_id`,`fp_record`.`record_id` AS `record_id` from ((((`fp_client` join `client_session`) join `fp_session`) join `session_record`) join `fp_record`) where ((1 = 1) and (`fp_client`.`client_id` = `client_session`.`client_id`) and (`client_session`.`session_id` = `fp_session`.`session_id`) and (`fp_session`.`session_id` = `session_record`.`session_id`) and (`session_record`.`record_id` = `fp_record`.`record_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `client_session_t`
--

/*!50001 DROP TABLE IF EXISTS `client_session_t`*/;
/*!50001 DROP VIEW IF EXISTS `client_session_t`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `client_session_t` AS select `client_session`.`client_id` AS `client_id`,`client_session`.`session_id` AS `session_id` from `client_session` where 1 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `record_client_count_v`
--

/*!50001 DROP TABLE IF EXISTS `record_client_count_v`*/;
/*!50001 DROP VIEW IF EXISTS `record_client_count_v`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `record_client_count_v` AS select `fp_record`.`record_id` AS `record_id`,count(distinct `fp_client`.`client_id`) AS `client_count` from ((((`fp_record` join `session_record`) join `fp_session`) join `client_session`) join `fp_client`) where ((`fp_record`.`record_id` = `session_record`.`record_id`) and (`session_record`.`session_id` = `fp_session`.`session_id`) and (`fp_session`.`session_id` = `client_session`.`session_id`) and (`client_session`.`client_id` = `fp_client`.`client_id`)) group by `fp_record`.`record_id` */;
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

-- Dump completed on 2012-03-14 18:45:26

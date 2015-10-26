-- MySQL dump 10.13  Distrib 5.5.20, for Win64 (x86)
--
-- Host: localhost    Database: browserfp
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fp_client`
--

LOCK TABLES `fp_client` WRITE;
/*!40000 ALTER TABLE `fp_client` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fp_record`
--

LOCK TABLES `fp_record` WRITE;
/*!40000 ALTER TABLE `fp_record` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fp_session`
--

LOCK TABLES `fp_session` WRITE;
/*!40000 ALTER TABLE `fp_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `fp_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `record_client_count`
--

DROP TABLE IF EXISTS `record_client_count`;
/*!50001 DROP VIEW IF EXISTS `record_client_count`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `record_client_count` (
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
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`session_id`,`record_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session_record`
--

LOCK TABLES `session_record` WRITE;
/*!40000 ALTER TABLE `session_record` DISABLE KEYS */;
/*!40000 ALTER TABLE `session_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `session_record_active`
--

DROP TABLE IF EXISTS `session_record_active`;
/*!50001 DROP VIEW IF EXISTS `session_record_active`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `session_record_active` (
  `session_id` int(11),
  `record_id` int(11),
  `record_timestamp` datetime,
  `active` tinyint(1)
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

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
INSERT INTO `sherlock_config` VALUES ('db_version','8');
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
/*!50001 VIEW `client_session_t` AS select `client_session`.`client_id` AS `client_id`,`client_session`.`session_id` AS `session_id` from `client_session` where 1 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `record_client_count`
--

/*!50001 DROP TABLE IF EXISTS `record_client_count`*/;
/*!50001 DROP VIEW IF EXISTS `record_client_count`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `record_client_count` AS select `fp_record`.`record_id` AS `record_id`,count(distinct `fp_client`.`client_id`) AS `client_count` from ((((`fp_record` join `session_record`) join `fp_session`) join `client_session`) join `fp_client`) where ((`fp_record`.`record_id` = `session_record`.`record_id`) and (`session_record`.`session_id` = `fp_session`.`session_id`) and (`fp_session`.`session_id` = `client_session`.`session_id`) and (`client_session`.`client_id` = `fp_client`.`client_id`)) group by `fp_record`.`record_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `session_record_active`
--

/*!50001 DROP TABLE IF EXISTS `session_record_active`*/;
/*!50001 DROP VIEW IF EXISTS `session_record_active`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `session_record_active` AS select `session_record`.`session_id` AS `session_id`,`session_record`.`record_id` AS `record_id`,`session_record`.`record_timestamp` AS `record_timestamp`,`session_record`.`active` AS `active` from `session_record` where (`session_record`.`active` = 1) */;
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

-- Dump completed on 2012-03-15  0:36:43

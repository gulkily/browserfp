-- phpMyAdmin SQL Dump
-- version 3.4.10.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 14, 2012 at 03:49 PM
-- Server version: 5.5.20
-- PHP Version: 5.3.10

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `sherlock`
--

-- --------------------------------------------------------

--
-- Stand-in structure for view `client_record_v`
--
CREATE TABLE IF NOT EXISTS `client_record_v` (
`client_id` int(11)
,`record_id` int(11)
);
-- --------------------------------------------------------

--
-- Table structure for table `client_session`
--

CREATE TABLE IF NOT EXISTS `client_session` (
  `client_id` int(11) NOT NULL,
  `session_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Stand-in structure for view `client_session_t`
--
CREATE TABLE IF NOT EXISTS `client_session_t` (
`client_id` int(11)
,`session_id` int(11)
);
-- --------------------------------------------------------

--
-- Table structure for table `client_variable`
--

CREATE TABLE IF NOT EXISTS `client_variable` (
  `client_id` int(11) NOT NULL,
  `var_name` char(32) NOT NULL,
  `var_value` varchar(255) NOT NULL,
  UNIQUE KEY `client_id` (`client_id`,`var_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `fp_client`
--

CREATE TABLE IF NOT EXISTS `fp_client` (
  `client_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `fp_fields`
--

CREATE TABLE IF NOT EXISTS `fp_fields` (
  `field_id` int(11) NOT NULL,
  `field_name` varchar(32) NOT NULL,
  `store` tinyint(1) NOT NULL,
  `validate` tinyint(1) NOT NULL,
  `return_param` char(16) DEFAULT NULL,
  PRIMARY KEY (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `fp_fields`
--

INSERT INTO `fp_fields` (`field_id`, `field_name`, `store`, `validate`, `return_param`) VALUES
(1, 'Useragent', 1, 0, ''),
(2, 'SessionCookie', 1, 0, ''),
(3, 'RemoteIp', 1, 0, ''),
(4, 'AcceptedLangs', 1, 0, ''),
(5, 'RemoteIpBlock', 1, 0, ''),
(6, 'Platform', 1, 0, ''),
(7, 'ScreenResWidth', 1, 1, 'iw'),
(8, 'ScreenResHeight', 1, 1, 'ih'),
(9, 'Etag', 1, 0, ''),
(10, 'ValidationToken', 0, 0, ''),
(11, 'ReturnToken', 1, 0, 'token'),
(12, 'TimeOffset', 1, 1, 'toff');

-- --------------------------------------------------------

--
-- Table structure for table `fp_record`
--

CREATE TABLE IF NOT EXISTS `fp_record` (
  `record_id` int(11) NOT NULL AUTO_INCREMENT,
  `field_id` int(11) NOT NULL,
  `field_value` varchar(255) NOT NULL,
  PRIMARY KEY (`record_id`),
  UNIQUE KEY `field_id` (`field_id`,`field_value`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `fp_session`
--

CREATE TABLE IF NOT EXISTS `fp_session` (
  `session_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `record_client_count_v`
--
CREATE TABLE IF NOT EXISTS `record_client_count_v` (
`record_id` int(11)
,`client_count` bigint(21)
);
-- --------------------------------------------------------

--
-- Table structure for table `session_record`
--

CREATE TABLE IF NOT EXISTS `session_record` (
  `session_id` int(11) NOT NULL,
  `record_id` int(11) NOT NULL,
  `record_timestamp` datetime NOT NULL,
  PRIMARY KEY (`session_id`,`record_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `sherlock_config`
--

CREATE TABLE IF NOT EXISTS `sherlock_config` (
  `name` varchar(32) NOT NULL,
  `value` varchar(255) NOT NULL,
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sherlock_config`
--

INSERT INTO `sherlock_config` (`name`, `value`) VALUES
('db_version', '5');

-- --------------------------------------------------------

--
-- Structure for view `client_record_v`
--
DROP TABLE IF EXISTS `client_record_v`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `client_record_v` AS select distinct `fp_client`.`client_id` AS `client_id`,`fp_record`.`record_id` AS `record_id` from ((((`fp_client` join `client_session`) join `fp_session`) join `session_record`) join `fp_record`) where ((1 = 1) and (`fp_client`.`client_id` = `client_session`.`client_id`) and (`client_session`.`session_id` = `fp_session`.`session_id`) and (`fp_session`.`session_id` = `session_record`.`session_id`) and (`session_record`.`record_id` = `fp_record`.`record_id`));

-- --------------------------------------------------------

--
-- Structure for view `client_session_t`
--
DROP TABLE IF EXISTS `client_session_t`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `client_session_t` AS select `client_session`.`client_id` AS `client_id`,`client_session`.`session_id` AS `session_id` from `client_session` where 1;

-- --------------------------------------------------------

--
-- Structure for view `record_client_count_v`
--
DROP TABLE IF EXISTS `record_client_count_v`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `record_client_count_v` AS select `fp_record`.`record_id` AS `record_id`,count(distinct `fp_client`.`client_id`) AS `client_count` from ((((`fp_record` join `session_record`) join `fp_session`) join `client_session`) join `fp_client`) where ((`fp_record`.`record_id` = `session_record`.`record_id`) and (`session_record`.`session_id` = `fp_session`.`session_id`) and (`fp_session`.`session_id` = `client_session`.`session_id`) and (`client_session`.`client_id` = `fp_client`.`client_id`)) group by `fp_record`.`record_id`;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

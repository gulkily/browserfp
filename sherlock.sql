-- phpMyAdmin SQL Dump
-- version 3.4.10.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 14, 2012 at 09:02 PM
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

--
-- Dumping data for table `client_session`
--

INSERT INTO `client_session` (`client_id`, `session_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(1, 9),
(1, 10),
(1, 11),
(1, 12),
(1, 13),
(1, 14),
(1, 15),
(1, 16),
(1, 17),
(1, 18),
(1, 19),
(1, 20),
(1, 21);

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

--
-- Dumping data for table `client_variable`
--

INSERT INTO `client_variable` (`client_id`, `var_name`, `var_value`) VALUES
(1, 'favorite_color', '#f5fbd3'),
(1, 'name', 'joe');

-- --------------------------------------------------------

--
-- Table structure for table `fp_client`
--

CREATE TABLE IF NOT EXISTS `fp_client` (
  `client_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `fp_client`
--

INSERT INTO `fp_client` (`client_id`) VALUES
(1);

-- --------------------------------------------------------

--
-- Table structure for table `fp_field`
--

CREATE TABLE IF NOT EXISTS `fp_field` (
  `field_id` int(11) NOT NULL,
  `field_name` varchar(32) NOT NULL,
  `store` tinyint(1) NOT NULL,
  `validate` tinyint(1) NOT NULL,
  `return_param` char(16) DEFAULT NULL,
  PRIMARY KEY (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `fp_field`
--

INSERT INTO `fp_field` (`field_id`, `field_name`, `store`, `validate`, `return_param`) VALUES
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=49 ;

--
-- Dumping data for table `fp_record`
--

INSERT INTO `fp_record` (`record_id`, `field_id`, `field_value`) VALUES
(27, 1, 'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0)'),
(38, 1, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/534.52.7 (KHTML, like Gecko) Version/5.1.2 Safari/534.52.7'),
(21, 1, 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.79 Safari/535.11'),
(1, 1, 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2'),
(31, 1, 'Opera/9.80 (Windows NT 6.1; U; Edition United States Local; en) Presto/2.10.229 Version/11.61'),
(32, 2, '86fa1671732d44dd82f58edcd5b9bc7b'),
(2, 2, '8ea3cb7c35062fff38802d04b17be840'),
(39, 2, 'b11e214ef33b4d28b76b5ce33298411e'),
(22, 2, 'c342b18f8ed320e355ce67dd682b923a'),
(28, 2, 'e6609aafa715efbbd9832aa4db11631f'),
(3, 3, '127.0.0.1'),
(29, 4, 'en-US'),
(4, 4, 'en-us,en;q=0.5'),
(23, 4, 'en-US,en;q=0.8'),
(33, 4, 'en-US,en;q=0.9'),
(5, 5, '127.0.0'),
(34, 6, 'Win7-win32'),
(6, 6, 'Win7-win64'),
(8, 7, '1170'),
(36, 7, '1183'),
(41, 7, '1213'),
(25, 7, '1264'),
(9, 8, '578'),
(26, 8, '606'),
(37, 8, '640'),
(42, 8, '642'),
(10, 12, '-1');

-- --------------------------------------------------------

--
-- Table structure for table `fp_session`
--

CREATE TABLE IF NOT EXISTS `fp_session` (
  `session_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=22 ;

--
-- Dumping data for table `fp_session`
--

INSERT INTO `fp_session` (`session_id`) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10),
(11),
(12),
(13),
(14),
(15),
(16),
(17),
(18),
(19),
(20),
(21);

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

--
-- Dumping data for table `session_record`
--

INSERT INTO `session_record` (`session_id`, `record_id`, `record_timestamp`) VALUES
(1, 1, '2012-03-14 15:24:14'),
(1, 2, '2012-03-14 15:24:14'),
(1, 3, '2012-03-14 15:24:15'),
(1, 4, '2012-03-14 15:24:15'),
(1, 5, '2012-03-14 15:24:15'),
(1, 6, '2012-03-14 15:24:15'),
(1, 8, '2012-03-14 15:24:16'),
(1, 9, '2012-03-14 15:24:17'),
(1, 10, '2012-03-14 15:24:17'),
(2, 1, '2012-03-14 15:25:29'),
(2, 2, '2012-03-14 15:25:29'),
(2, 3, '2012-03-14 15:25:29'),
(2, 4, '2012-03-14 15:25:29'),
(2, 5, '2012-03-14 15:25:29'),
(2, 6, '2012-03-14 15:25:30'),
(2, 8, '2012-03-14 15:25:32'),
(2, 9, '2012-03-14 15:25:32'),
(3, 1, '2012-03-14 15:29:13'),
(3, 2, '2012-03-14 15:29:13'),
(3, 3, '2012-03-14 15:29:13'),
(3, 4, '2012-03-14 15:29:13'),
(3, 5, '2012-03-14 15:29:13'),
(3, 6, '2012-03-14 15:29:14'),
(3, 8, '2012-03-14 15:29:26'),
(3, 9, '2012-03-14 15:29:26'),
(4, 1, '2012-03-14 15:29:56'),
(4, 2, '2012-03-14 15:29:56'),
(4, 3, '2012-03-14 15:29:56'),
(4, 4, '2012-03-14 15:29:56'),
(4, 5, '2012-03-14 15:29:56'),
(4, 6, '2012-03-14 15:29:56'),
(4, 8, '2012-03-14 15:29:58'),
(4, 9, '2012-03-14 15:29:58'),
(4, 10, '2012-03-14 15:29:58'),
(5, 1, '2012-03-14 15:30:40'),
(5, 2, '2012-03-14 15:30:40'),
(5, 3, '2012-03-14 15:30:40'),
(5, 4, '2012-03-14 15:30:40'),
(5, 5, '2012-03-14 15:30:40'),
(5, 6, '2012-03-14 15:30:40'),
(5, 8, '2012-03-14 15:30:42'),
(5, 9, '2012-03-14 15:30:42'),
(5, 10, '2012-03-14 15:30:43'),
(6, 1, '2012-03-14 15:34:17'),
(6, 2, '2012-03-14 15:34:17'),
(6, 3, '2012-03-14 15:34:18'),
(6, 4, '2012-03-14 15:34:18'),
(6, 5, '2012-03-14 15:34:18'),
(6, 6, '2012-03-14 15:34:18'),
(6, 8, '2012-03-14 15:34:18'),
(6, 9, '2012-03-14 15:34:18'),
(6, 10, '2012-03-14 15:34:18'),
(7, 1, '2012-03-14 16:03:56'),
(7, 2, '2012-03-14 16:03:56'),
(7, 3, '2012-03-14 16:03:56'),
(7, 4, '2012-03-14 16:03:57'),
(7, 5, '2012-03-14 16:03:57'),
(7, 6, '2012-03-14 16:03:57'),
(7, 8, '2012-03-14 16:03:57'),
(7, 9, '2012-03-14 16:03:57'),
(7, 10, '2012-03-14 16:03:57'),
(8, 1, '2012-03-14 16:04:42'),
(8, 2, '2012-03-14 16:04:42'),
(8, 3, '2012-03-14 16:04:42'),
(8, 4, '2012-03-14 16:04:42'),
(8, 5, '2012-03-14 16:04:42'),
(8, 6, '2012-03-14 16:04:42'),
(8, 8, '2012-03-14 16:04:43'),
(8, 9, '2012-03-14 16:04:43'),
(9, 1, '2012-03-14 16:04:53'),
(9, 2, '2012-03-14 16:04:53'),
(9, 3, '2012-03-14 16:04:53'),
(9, 4, '2012-03-14 16:04:54'),
(9, 5, '2012-03-14 16:04:54'),
(9, 6, '2012-03-14 16:04:54'),
(9, 8, '2012-03-14 16:04:54'),
(9, 9, '2012-03-14 16:04:54'),
(9, 10, '2012-03-14 16:04:54'),
(10, 1, '2012-03-14 16:05:10'),
(10, 2, '2012-03-14 16:05:10'),
(10, 3, '2012-03-14 16:05:10'),
(10, 4, '2012-03-14 16:05:11'),
(10, 5, '2012-03-14 16:05:11'),
(10, 6, '2012-03-14 16:05:11'),
(10, 8, '2012-03-14 16:05:11'),
(10, 9, '2012-03-14 16:05:11'),
(10, 10, '2012-03-14 16:05:12'),
(11, 1, '2012-03-14 16:07:23'),
(11, 2, '2012-03-14 16:07:23'),
(11, 3, '2012-03-14 16:07:24'),
(11, 4, '2012-03-14 16:07:24'),
(11, 5, '2012-03-14 16:07:24'),
(11, 6, '2012-03-14 16:07:24'),
(11, 8, '2012-03-14 16:07:24'),
(11, 9, '2012-03-14 16:07:24'),
(11, 10, '2012-03-14 16:07:25'),
(12, 3, '2012-03-14 16:07:47'),
(12, 5, '2012-03-14 16:07:48'),
(12, 6, '2012-03-14 16:07:48'),
(12, 10, '2012-03-14 16:07:53'),
(12, 21, '2012-03-14 16:07:46'),
(12, 22, '2012-03-14 16:07:47'),
(12, 23, '2012-03-14 16:07:48'),
(12, 25, '2012-03-14 16:07:52'),
(12, 26, '2012-03-14 16:07:53'),
(13, 3, '2012-03-14 16:07:57'),
(13, 5, '2012-03-14 16:07:57'),
(13, 6, '2012-03-14 16:07:57'),
(13, 10, '2012-03-14 16:07:58'),
(13, 27, '2012-03-14 16:07:56'),
(13, 28, '2012-03-14 16:07:56'),
(13, 29, '2012-03-14 16:07:57'),
(14, 3, '2012-03-14 16:08:00'),
(14, 5, '2012-03-14 16:08:00'),
(14, 10, '2012-03-14 16:08:01'),
(14, 31, '2012-03-14 16:08:00'),
(14, 32, '2012-03-14 16:08:00'),
(14, 33, '2012-03-14 16:08:00'),
(14, 34, '2012-03-14 16:08:01'),
(14, 36, '2012-03-14 16:08:01'),
(14, 37, '2012-03-14 16:08:01'),
(15, 3, '2012-03-14 16:08:04'),
(15, 5, '2012-03-14 16:08:04'),
(15, 10, '2012-03-14 16:08:05'),
(15, 29, '2012-03-14 16:08:04'),
(15, 34, '2012-03-14 16:08:04'),
(15, 38, '2012-03-14 16:08:03'),
(15, 39, '2012-03-14 16:08:03'),
(15, 41, '2012-03-14 16:08:05'),
(15, 42, '2012-03-14 16:08:05'),
(16, 3, '2012-03-14 16:09:52'),
(16, 5, '2012-03-14 16:09:52'),
(16, 10, '2012-03-14 16:09:53'),
(16, 29, '2012-03-14 16:09:52'),
(16, 34, '2012-03-14 16:09:52'),
(16, 38, '2012-03-14 16:09:52'),
(16, 39, '2012-03-14 16:09:52'),
(16, 41, '2012-03-14 16:09:52'),
(16, 42, '2012-03-14 16:09:52'),
(17, 1, '2012-03-14 16:10:49'),
(17, 2, '2012-03-14 16:10:49'),
(17, 3, '2012-03-14 16:10:49'),
(17, 4, '2012-03-14 16:10:49'),
(17, 5, '2012-03-14 16:10:49'),
(17, 6, '2012-03-14 16:10:49'),
(17, 8, '2012-03-14 16:10:50'),
(17, 9, '2012-03-14 16:10:50'),
(17, 10, '2012-03-14 16:10:50'),
(18, 1, '2012-03-14 16:51:17'),
(18, 2, '2012-03-14 16:51:17'),
(18, 3, '2012-03-14 16:51:17'),
(18, 4, '2012-03-14 16:51:17'),
(18, 5, '2012-03-14 16:51:17'),
(18, 6, '2012-03-14 16:51:17'),
(18, 8, '2012-03-14 16:51:18'),
(18, 9, '2012-03-14 16:51:18'),
(19, 1, '2012-03-14 16:52:16'),
(19, 2, '2012-03-14 16:52:16'),
(19, 3, '2012-03-14 16:52:17'),
(19, 4, '2012-03-14 16:52:17'),
(19, 5, '2012-03-14 16:52:17'),
(19, 6, '2012-03-14 16:52:17'),
(19, 8, '2012-03-14 16:52:17'),
(19, 9, '2012-03-14 16:52:17'),
(19, 10, '2012-03-14 16:52:17'),
(20, 1, '2012-03-14 16:54:21'),
(20, 2, '2012-03-14 16:54:21'),
(20, 3, '2012-03-14 16:54:21'),
(20, 4, '2012-03-14 16:54:21'),
(20, 5, '2012-03-14 16:54:21'),
(20, 6, '2012-03-14 16:54:22'),
(20, 8, '2012-03-14 16:54:22'),
(20, 9, '2012-03-14 16:54:22'),
(21, 1, '2012-03-14 16:54:39'),
(21, 2, '2012-03-14 16:54:39'),
(21, 3, '2012-03-14 16:54:39'),
(21, 4, '2012-03-14 16:54:39'),
(21, 5, '2012-03-14 16:54:39'),
(21, 6, '2012-03-14 16:54:39'),
(21, 8, '2012-03-14 16:54:39'),
(21, 9, '2012-03-14 16:54:40'),
(21, 10, '2012-03-14 16:54:40');

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
('db_version', '7');

-- --------------------------------------------------------

--
-- Structure for view `client_record_v`
--
DROP TABLE IF EXISTS `client_record_v`;

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `client_record_v` AS select distinct `fp_client`.`client_id` AS `client_id`,`fp_record`.`record_id` AS `record_id` from ((((`fp_client` join `client_session`) join `fp_session`) join `session_record`) join `fp_record`) where ((1 = 1) and (`fp_client`.`client_id` = `client_session`.`client_id`) and (`client_session`.`session_id` = `fp_session`.`session_id`) and (`fp_session`.`session_id` = `session_record`.`session_id`) and (`session_record`.`record_id` = `fp_record`.`record_id`));

-- --------------------------------------------------------

--
-- Structure for view `client_session_t`
--
DROP TABLE IF EXISTS `client_session_t`;

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `client_session_t` AS select `client_session`.`client_id` AS `client_id`,`client_session`.`session_id` AS `session_id` from `client_session` where 1;

-- --------------------------------------------------------

--
-- Structure for view `record_client_count_v`
--
DROP TABLE IF EXISTS `record_client_count_v`;

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `record_client_count_v` AS select `fp_record`.`record_id` AS `record_id`,count(distinct `fp_client`.`client_id`) AS `client_count` from ((((`fp_record` join `session_record`) join `fp_session`) join `client_session`) join `fp_client`) where ((`fp_record`.`record_id` = `session_record`.`record_id`) and (`session_record`.`session_id` = `fp_session`.`session_id`) and (`fp_session`.`session_id` = `client_session`.`session_id`) and (`client_session`.`client_id` = `fp_client`.`client_id`)) group by `fp_record`.`record_id`;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

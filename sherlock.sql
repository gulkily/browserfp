-- phpMyAdmin SQL Dump
-- version 3.4.10.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 13, 2012 at 08:26 PM
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
(1, 8);

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
(1, 'favorite_color', '#dbf5df');

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
-- Table structure for table `fp_record`
--

CREATE TABLE IF NOT EXISTS `fp_record` (
  `record_id` int(11) NOT NULL AUTO_INCREMENT,
  `field_id` int(11) NOT NULL,
  `field_value` varchar(255) NOT NULL,
  PRIMARY KEY (`record_id`),
  UNIQUE KEY `field_id` (`field_id`,`field_value`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

--
-- Dumping data for table `fp_record`
--

INSERT INTO `fp_record` (`record_id`, `field_id`, `field_value`) VALUES
(1, 1, 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2'),
(2, 2, '431707fe1ecf53fd3bd6fe0cc6cea131'),
(3, 3, '127.0.0.1'),
(4, 4, 'en-us,en;q=0.5'),
(5, 5, '127.0.0'),
(6, 6, 'Win7-win64'),
(8, 9, '0d942fe0e78b37fdee48bacb27852f8f'),
(9, 9, '35c595bce916ea64aae1a3c3c915d742'),
(11, 9, '64d7b18091001eded856fb5d496ab804'),
(10, 9, '8888ea45a458ab292d91d67ff150bec9'),
(7, 9, 'ae3f81d8719a664e5292f5a4419078f6');

-- --------------------------------------------------------

--
-- Table structure for table `fp_session`
--

CREATE TABLE IF NOT EXISTS `fp_session` (
  `session_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

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
(8);

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
(1, 1, '2012-03-13 15:37:44'),
(1, 2, '2012-03-13 15:37:45'),
(1, 3, '2012-03-13 15:37:45'),
(1, 4, '2012-03-13 15:37:45'),
(1, 5, '2012-03-13 15:37:45'),
(1, 6, '2012-03-13 15:37:45'),
(2, 1, '2012-03-13 15:37:49'),
(2, 2, '2012-03-13 15:37:49'),
(2, 3, '2012-03-13 15:37:49'),
(2, 4, '2012-03-13 15:37:49'),
(2, 5, '2012-03-13 15:37:49'),
(2, 6, '2012-03-13 15:37:50'),
(3, 1, '2012-03-13 15:37:51'),
(3, 2, '2012-03-13 15:37:51'),
(3, 3, '2012-03-13 15:37:52'),
(3, 4, '2012-03-13 15:37:52'),
(3, 5, '2012-03-13 15:37:52'),
(3, 6, '2012-03-13 15:37:52'),
(4, 1, '2012-03-13 16:22:56'),
(4, 2, '2012-03-13 16:22:56'),
(4, 3, '2012-03-13 16:22:56'),
(4, 4, '2012-03-13 16:22:56'),
(4, 5, '2012-03-13 16:22:56'),
(4, 6, '2012-03-13 16:22:56'),
(4, 7, '2012-03-13 16:22:57'),
(5, 1, '2012-03-13 16:23:21'),
(5, 2, '2012-03-13 16:23:21'),
(5, 3, '2012-03-13 16:23:21'),
(5, 4, '2012-03-13 16:23:21'),
(5, 5, '2012-03-13 16:23:21'),
(5, 6, '2012-03-13 16:23:21'),
(5, 8, '2012-03-13 16:23:22'),
(6, 1, '2012-03-13 16:23:24'),
(6, 2, '2012-03-13 16:23:24'),
(6, 3, '2012-03-13 16:23:24'),
(6, 4, '2012-03-13 16:23:24'),
(6, 5, '2012-03-13 16:23:24'),
(6, 6, '2012-03-13 16:23:24'),
(6, 9, '2012-03-13 16:23:24'),
(7, 1, '2012-03-13 16:24:14'),
(7, 2, '2012-03-13 16:24:14'),
(7, 3, '2012-03-13 16:24:14'),
(7, 4, '2012-03-13 16:24:14'),
(7, 5, '2012-03-13 16:24:14'),
(7, 6, '2012-03-13 16:24:14'),
(7, 10, '2012-03-13 16:24:14'),
(8, 1, '2012-03-13 16:24:35'),
(8, 2, '2012-03-13 16:24:36'),
(8, 3, '2012-03-13 16:24:36'),
(8, 4, '2012-03-13 16:24:36'),
(8, 5, '2012-03-13 16:24:36'),
(8, 6, '2012-03-13 16:24:36'),
(8, 11, '2012-03-13 16:24:36');

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

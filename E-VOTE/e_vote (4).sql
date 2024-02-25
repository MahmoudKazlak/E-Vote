-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jan 27, 2024 at 04:23 PM
-- Server version: 8.0.35-0ubuntu0.22.04.1
-- PHP Version: 8.2.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `e_vote`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `identification_number` varchar(100) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `is_canceled` tinyint NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `name`, `identification_number`, `user_id`, `is_canceled`) VALUES
(1, 'محمود', '1', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `adv`
--

CREATE TABLE `adv` (
  `id` int NOT NULL,
  `insert_time` datetime DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `period` int DEFAULT NULL COMMENT 'مدة الاعلان بالساعات'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `adv`
--

INSERT INTO `adv` (`id`, `insert_time`, `name`, `period`) VALUES
(1, '2024-01-25 18:24:41', 'انتظروا النسخة الجديدة قريبا', 144),
(2, '2024-01-25 18:24:41', 'ادعوا اصدقاءكم لدعم المرشحين', 99),
(3, '2024-01-25 18:24:41', 'لا تنسوا تحديث البيانات', 100),
(4, '2024-01-27 17:27:32', '4674747', 99);

-- --------------------------------------------------------

--
-- Table structure for table `candidate`
--

CREATE TABLE `candidate` (
  `id` int NOT NULL,
  `insert_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fname` varchar(50) DEFAULT NULL,
  `lname` varchar(50) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `gender_id` int DEFAULT NULL COMMENT '1.male 2.female',
  `birthdate` date DEFAULT NULL,
  `bio` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci COMMENT 'السيرة الذاتية',
  `img` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `residence_region_id` int DEFAULT NULL,
  `specialty_id` int DEFAULT NULL,
  `activation` int DEFAULT '1' COMMENT '1.active 2.deactive',
  `user_id` int DEFAULT NULL,
  `is_canceled` tinyint DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `candidate`
--

INSERT INTO `candidate` (`id`, `insert_time`, `fname`, `lname`, `phone`, `gender_id`, `birthdate`, `bio`, `img`, `residence_region_id`, `specialty_id`, `activation`, `user_id`, `is_canceled`) VALUES
(1, '2023-01-03 08:21:48', 'الشخص1', 'العائلة1', NULL, 1, '2023-01-02', 'welcome', NULL, 1, 1, 1, 3, 0),
(11, '2023-11-29 21:14:13', 'خالد', 'محمود', NULL, 1, '2000-11-04', NULL, NULL, 2, 2, 1, 27, 0),
(12, '2023-12-03 18:26:36', 'محمد', 'احمد', NULL, 1, NULL, NULL, NULL, 2, 2, 1, 28, 0),
(13, '2023-12-25 23:05:08', 'nnn', 'nnn', NULL, 1, NULL, 'nnn', NULL, 2, 1, 1, 29, 0);

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `id` int NOT NULL,
  `create_by` int DEFAULT NULL COMMENT 'user_id',
  `title` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  `max_allowed_number` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`id`, `create_by`, `title`, `date`, `time`, `max_allowed_number`) VALUES
(1, 2, 'محمود', NULL, NULL, '2'),
(2, 2, 'علي', '2023-01-12', '03:15:00', '0'),
(3, 3, 'حسان', '2023-01-18', '04:58:00', '0'),
(4, 1, 'خالد', '2023-01-19', '10:00:00', '0'),
(5, 1, 'محمد يوسف', '2023-01-11', '10:01:00', '8'),
(6, 1, 'حسن', '2023-01-11', '04:01:00', '7'),
(7, 3, 'عيسى', '2023-01-12', '10:22:00', '1'),
(8, 44, 'احمد', '2023-01-11', '15:55:00', '65'),
(9, 2, 'ghj', '2023-01-11', '16:01:00', '5'),
(10, 2, 'ggg', '2023-01-10', '12:08:00', '88'),
(11, 2, 'ali', '2023-11-29', '00:00:00', '2');

-- --------------------------------------------------------

--
-- Table structure for table `link_event_user`
--

CREATE TABLE `link_event_user` (
  `id` int NOT NULL,
  `event_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `link_event_user`
--

INSERT INTO `link_event_user` (`id`, `event_id`, `user_id`) VALUES
(1, 1, 1),
(9, 1, 2),
(11, 6, 2),
(12, 7, 2),
(13, 5, 2);

-- --------------------------------------------------------

--
-- Table structure for table `link_pollTopic_candidate`
--

CREATE TABLE `link_pollTopic_candidate` (
  `id` int NOT NULL,
  `poll_topic_id` int DEFAULT NULL,
  `candidate_id` int DEFAULT NULL,
  `election_program` text,
  `notification_num` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `link_pollTopic_candidate`
--

INSERT INTO `link_pollTopic_candidate` (`id`, `poll_topic_id`, `candidate_id`, `election_program`, `notification_num`) VALUES
(3, 1, 1, 'egertert', 0),
(4, 2, 1, 'ertwert', 0),
(5, 2, 11, 'ewryewry', 3),
(6, 3, 1, 'ewrywery', 0),
(7, 3, 11, 'eee', 4),
(8, 1, 12, 'eryery', 2),
(9, 2, 13, 'sdgasdgasdgasg', 1);

-- --------------------------------------------------------

--
-- Table structure for table `link_pollTopic_candidate_userVoted`
--

CREATE TABLE `link_pollTopic_candidate_userVoted` (
  `id` int NOT NULL,
  `poll_topic_id` int DEFAULT NULL,
  `candidate_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `link_pollTopic_candidate_userVoted`
--

INSERT INTO `link_pollTopic_candidate_userVoted` (`id`, `poll_topic_id`, `candidate_id`, `user_id`) VALUES
(1, 2, 1, 3),
(2, 1, 1, 3),
(3, 1, 12, 35),
(4, 2, 11, 2),
(5, 1, 1, 3),
(6, 1, 11, 4),
(7, 2, 11, 1);

-- --------------------------------------------------------

--
-- Table structure for table `member`
--

CREATE TABLE `member` (
  `id` int NOT NULL,
  `insert_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fname` varchar(50) DEFAULT NULL,
  `lname` varchar(50) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `gender_id` int DEFAULT NULL COMMENT '1.male 2.female',
  `birthdate` date DEFAULT NULL,
  `bio` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci COMMENT 'السيرة الذاتية',
  `img` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `residence_region_id` int DEFAULT NULL,
  `specialty_id` int DEFAULT NULL,
  `activation` int DEFAULT '1' COMMENT '1.active 2.deactive',
  `user_id` int DEFAULT NULL,
  `is_canceled` tinyint DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `member`
--

INSERT INTO `member` (`id`, `insert_time`, `fname`, `lname`, `phone`, `gender_id`, `birthdate`, `bio`, `img`, `residence_region_id`, `specialty_id`, `activation`, `user_id`, `is_canceled`) VALUES
(1, '2023-01-03 08:21:48', 'الاسم الاول1', 'الاسم الاخير1', NULL, 1, '2023-01-02', 'welcome', '4_1_1673910459.png', 1, 2, 1, 7, 0),
(7, '2023-01-18 11:24:11', 'ddd', 'ddd', '23523523', 2, NULL, NULL, NULL, 2, 1, 1, 5, 0),
(8, '2023-01-18 11:53:24', 'asd', 'ghjj', NULL, 1, NULL, '', NULL, 0, 0, 1, 6, 0),
(10, '2023-11-25 01:28:04', 'qeee', 'qeeeee', NULL, 1, '2000-01-13', 'qqq', '1210874868_image_upload_1700915644.png', 1, 1, 1, 8, 0),
(11, '2023-11-25 12:54:07', 'محمد ', 'خالد', NULL, 1, NULL, 'sdg sdgsd gsdgsdg', NULL, 2, 1, 1, 4, 0),
(12, '2023-11-25 14:35:23', 'eeee', 'eeee', NULL, 1, '2023-11-03', 'eeee', NULL, 1, 2, 2, 2, 0),
(13, '2023-11-25 15:13:29', 'asd', 'asd', NULL, 1, '2023-11-09', 'asd', NULL, 2, 2, 1, 9, 0),
(14, '2023-11-25 16:05:48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 10, 1),
(15, '2023-11-25 16:20:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 23, 1),
(16, '2023-11-25 16:22:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 25, 1),
(17, '2023-11-25 16:24:54', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 26, 1),
(18, '2024-01-04 01:07:00', 'kkk', 'klk', '352355236', 1, NULL, NULL, NULL, 2, 2, 1, 30, 0),
(19, '2024-01-04 08:43:12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 31, 0),
(20, '2024-01-04 08:44:52', 'vvbd', 'احمد', '25653465', 1, NULL, NULL, NULL, 2, 2, 1, 35, 0);

-- --------------------------------------------------------

--
-- Table structure for table `poll_topic`
--

CREATE TABLE `poll_topic` (
  `id` int NOT NULL,
  `insert_time` datetime DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `period` int DEFAULT NULL COMMENT 'مدة الاستفتاء بالساعات'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `poll_topic`
--

INSERT INTO `poll_topic` (`id`, `insert_time`, `name`, `period`) VALUES
(1, '2024-01-26 10:11:25', 'انتخابات مجلس اتحاد الطلبة /النجاح', 144),
(2, '2024-01-26 10:11:25', 'انتخابات لادارة نادي الشباب', 33),
(3, '2023-12-03 18:24:41', 'انتخاب رئيس', 0);

-- --------------------------------------------------------

--
-- Table structure for table `residence_region`
--

CREATE TABLE `residence_region` (
  `id` int NOT NULL,
  `name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `residence_region`
--

INSERT INTO `residence_region` (`id`, `name`) VALUES
(1, 'رام الله'),
(2, 'نابلس');

-- --------------------------------------------------------

--
-- Table structure for table `restore_password`
--

CREATE TABLE `restore_password` (
  `id` int NOT NULL,
  `insert_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` int DEFAULT NULL,
  `user_level_id` int DEFAULT NULL,
  `is_done` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `restore_password`
--

INSERT INTO `restore_password` (`id`, `insert_time`, `user_id`, `user_level_id`, `is_done`) VALUES
(1, '2024-01-04 01:26:18', 2, 3, 0),
(2, '2024-01-04 01:26:46', 4, 3, 0),
(3, '2024-01-04 01:26:46', 5, 3, 0),
(4, '2024-01-04 08:42:33', 29, 2, 0),
(5, '2024-01-04 08:42:35', 29, 2, 0),
(6, '2024-01-04 08:42:35', 29, 2, 0),
(7, '2024-01-04 08:42:36', 29, 2, 0),
(8, '2024-01-04 08:46:02', 35, 3, 0),
(9, '2024-01-04 08:46:11', 35, 3, 0);

-- --------------------------------------------------------

--
-- Table structure for table `specialties`
--

CREATE TABLE `specialties` (
  `id` int NOT NULL,
  `name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `specialties`
--

INSERT INTO `specialties` (`id`, `name`) VALUES
(1, 'هندسة حاسوب'),
(2, 'هندسة مدنية');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `insert_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `loginname` varchar(100) DEFAULT NULL,
  `password` varchar(200) DEFAULT NULL,
  `user_level_id` int DEFAULT NULL COMMENT '1.admin 2.candidate 3.member',
  `is_canceled` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `insert_time`, `loginname`, `password`, `user_level_id`, `is_canceled`) VALUES
(1, '2023-01-03 08:20:26', 'admin', '0c7540eb7e65b553ec1ba6b20de79608', 1, 0),
(2, '2023-01-03 08:20:40', 'asd22244', '7fff46f1af649af94f056fbbc0836293', 3, 0),
(3, '2023-01-03 08:20:52', 'ccc', '085001698122db5c27c174d2302c1c44', 2, 0),
(4, '2023-01-18 11:14:20', '222', 'ca529f4290906e078e93ff33ac47c02f', 3, 0),
(5, '2023-01-18 11:24:11', 'ddd', '08d321fdaafd4f1b1b37ab71bebca591', 3, 0),
(6, '2023-01-18 11:53:24', 'm', '9a1cc5d78e92960bf5b1d6f159456597', 3, 0),
(8, '2023-11-25 01:28:04', 'www', '079f28f182deced498b33a836b6185e0', 3, 0),
(9, '2023-11-25 15:13:29', 'asd', 'd1205746e3192ca4641605d9f67cc897', 3, 0),
(10, '2023-11-25 16:05:48', 'fff', '36091e5151bfdb5f8572f5e30cd2933c', 2, 0),
(23, '2023-11-25 16:20:57', 'asd1', 'fb67e7f037cfe29c033229ae9f425bb3', 2, 0),
(25, '2023-11-25 16:22:14', 'asd2', '3c4263c3c3f716cc7af988311d09cdc9', 3, 0),
(26, '2023-11-25 16:24:53', 'asd3', '4199e5d36e6851f210ead47763b11b05', 3, 0),
(27, '2023-11-29 21:14:13', 'asdf', 'b37e0eec43049a49d6d22843dd7b1280', 3, 0),
(28, '2023-12-03 18:26:36', 'mmm', '2fbd2bcfe52b27b27360c9fa69e35238', 2, 0),
(29, '2023-12-25 23:05:08', 'nnn', 'd48750fb0de0061af81f2b8941aedd7b', 2, 0),
(30, '2024-01-04 01:07:00', 'kkk', 'bbc9abeae2a25558f136720d4c0fa12c', 3, 0),
(31, '2024-01-04 08:43:12', 'vvb', '8a80fad693bb369ca2f818a0f5eebf12', 3, 0),
(35, '2024-01-04 08:44:52', '111', 'c72f5359811af711f29b1fac7150042f', 3, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `adv`
--
ALTER TABLE `adv`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `candidate`
--
ALTER TABLE `candidate`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `link_event_user`
--
ALTER TABLE `link_event_user`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `link_pollTopic_candidate`
--
ALTER TABLE `link_pollTopic_candidate`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `link_pollTopic_candidate_userVoted`
--
ALTER TABLE `link_pollTopic_candidate_userVoted`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `member`
--
ALTER TABLE `member`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `poll_topic`
--
ALTER TABLE `poll_topic`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `residence_region`
--
ALTER TABLE `residence_region`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `restore_password`
--
ALTER TABLE `restore_password`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `specialties`
--
ALTER TABLE `specialties`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `loginname` (`loginname`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `adv`
--
ALTER TABLE `adv`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `candidate`
--
ALTER TABLE `candidate`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `link_event_user`
--
ALTER TABLE `link_event_user`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `link_pollTopic_candidate`
--
ALTER TABLE `link_pollTopic_candidate`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `link_pollTopic_candidate_userVoted`
--
ALTER TABLE `link_pollTopic_candidate_userVoted`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `member`
--
ALTER TABLE `member`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `poll_topic`
--
ALTER TABLE `poll_topic`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `residence_region`
--
ALTER TABLE `residence_region`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `restore_password`
--
ALTER TABLE `restore_password`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `specialties`
--
ALTER TABLE `specialties`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

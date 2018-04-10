-- phpMyAdmin SQL Dump
-- version 4.7.7
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 03, 2018 at 10:15 PM
-- Server version: 10.1.30-MariaDB
-- PHP Version: 7.2.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `fantasticfour_p4`
--

-- --------------------------------------------------------

--
-- Table structure for table `person`
--

CREATE TABLE `person` (
  `id` int(11) NOT NULL,
  `unitID` int(11) NOT NULL,
  `rank` varchar(64) NOT NULL,
  `firstname` varchar(128) NOT NULL,
  `lastname` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='A Person. Added and edited by Users. Belongs to a Unit.';

--
-- Dumping data for table `person`
--

INSERT INTO `person` (`id`, `unitID`, `rank`, `firstname`, `lastname`) VALUES
(1, 1, 'Pfc', 'Lawrence', 'Clark'),
(2, 1, 'Pvt', 'Chester', 'Harej'),
(3, 1, 'Pfc', 'Vito', 'Mikalauski'),
(4, 2, 'Cpl', 'Harvey', 'Keller'),
(5, 2, 'Pvt', 'Jessie', 'Staggs');

-- --------------------------------------------------------

--
-- Table structure for table `unit`
--

CREATE TABLE `unit` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `unit`
--

INSERT INTO `unit` (`id`, `name`) VALUES
(1, 'Assault Gun Platoon'),
(2, 'Reconaissance Platoon');

-- --------------------------------------------------------

--
-- Table structure for table `unitevent`
--

CREATE TABLE `unitevent` (
  `id` int(11) NOT NULL,
  `unitID` int(11) NOT NULL,
  `eventName` varchar(64) NOT NULL,
  `type` varchar(32) NOT NULL,
  `date` date NOT NULL,
  `description` text NOT NULL,
  `locationName` text NOT NULL,
  `latitude` float NOT NULL,
  `longitude` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='An event that occurred to some Unit along the campaign. Can be a battle, an operation, a diary entry, etc.';

--
-- Dumping data for table `unitevent`
--

INSERT INTO `unitevent` (`id`, `unitID`, `eventName`, `type`, `date`, `description`, `locationName`, `latitude`, `longitude`) VALUES
(1, 1, 'Sample Battle #1', 'BATTLE', '1944-12-10', 'Lorem ipsum dolor sit amet', 'Somewhere in France', 46.8207, 2.37545),
(2, 1, 'Sample Battle #2', 'BATTLE', '1945-01-12', 'Lorem ipsum dolor sit amet', 'Somewhere in France', 46.8206, 2.37545),
(3, 1, 'Sample Battle #3', 'BATTLE', '1945-01-31', 'Lorem ipsum dolor sit amet', 'Somewhere in Germany', 46.8201, 2.37532);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `userId` int(11) NOT NULL,
  `username` varchar(128) NOT NULL,
  `pword_hash` varchar(255) NOT NULL,
  `email` text NOT NULL,
  `type` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='A user account.';

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`userId`, `username`, `pword_hash`, `email`, `type`) VALUES
(2, 'levelone', '$2y$10$gXx4IKj7O9FTNDndXIV./OG8gKCnTMovRPvhMFXWIT64QAWjY6YLq', 'leslie6@vt.edu', 1),
(3, 'leveltwo', '$2y$10$0VZNmMVkZXzeRdbzmpouROdMt0Cd9WY.h96r.S11RKA1TptzsPMmK', 'leslie6@vt.edu', 2),
(4, 'levelthree', '$2y$10$gJmElM29rboLdeRXt7LuGu1TIWB7dT/Nbn70BK42KMaRUi/7yqjSC', 'leslie6@vt.edu', 3);

-- --------------------------------------------------------

--
-- Table structure for table `usertoken`
--

CREATE TABLE `usertoken` (
  `tokenId` int(11) NOT NULL,
  `user` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `expires` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Represents an authenticated user session.';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `person`
--
ALTER TABLE `person`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Person_Person_unitId_fk` (`unitID`);

--
-- Indexes for table `unit`
--
ALTER TABLE `unit`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `unitevent`
--
ALTER TABLE `unitevent`
  ADD PRIMARY KEY (`id`),
  ADD KEY `UnitEvent_Unit_unitID_fk` (`unitID`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`userId`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `usertoken`
--
ALTER TABLE `usertoken`
  ADD PRIMARY KEY (`tokenId`),
  ADD KEY `UserToken_User_userId_fk` (`user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `person`
--
ALTER TABLE `person`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `unit`
--
ALTER TABLE `unit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `unitevent`
--
ALTER TABLE `unitevent`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `userId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `usertoken`
--
ALTER TABLE `usertoken`
  MODIFY `tokenId` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `person`
--
ALTER TABLE `person`
  ADD CONSTRAINT `Person_Person_unitId_fk` FOREIGN KEY (`unitID`) REFERENCES `unit` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `unitevent`
--
ALTER TABLE `unitevent`
  ADD CONSTRAINT `UnitEvent_Unit_unitID_fk` FOREIGN KEY (`unitID`) REFERENCES `unit` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `usertoken`
--
ALTER TABLE `usertoken`
  ADD CONSTRAINT `UserToken_User_userId_fk` FOREIGN KEY (`user`) REFERENCES `user` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
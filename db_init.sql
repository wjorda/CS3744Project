/**
Configuration file for the project's database.
Creates the database, user, tables, and sample data for the project.
 */

CREATE DATABASE IF NOT EXISTS fantasticfour_p4;
CREATE USER IF NOT EXISTS 'fantasticfour'@'localhost' IDENTIFIED BY 'cs3744';
GRANT ALL PRIVILEGES ON fantasticfour_p4.* to 'fantasticfour'@'localhost';

USE fantasticfour_p4;

DROP TABLE IF EXISTS Person;
DROP TABLE IF EXISTS UnitEvent;
DROP TABLE IF EXISTS Unit;
DROP TABLE IF EXISTS UserToken;
DROP TABLE IF EXISTS User;
DROP TABLE IF EXISTS Following;


CREATE TABLE User
(
  userId INT PRIMARY KEY AUTO_INCREMENT,
  username VARCHAR(128) UNIQUE NOT NULL,
  pword_hash VARCHAR(255) NOT NULL,
  email TEXT NOT NULL
);
ALTER TABLE User COMMENT = 'A user account.';


CREATE TABLE UserToken
(
  tokenId INT PRIMARY KEY AUTO_INCREMENT,
  user INT NOT NULL ,
  created DATETIME NOT NULL,
  expires DATETIME NOT NULL,
  CONSTRAINT UserToken_User_userId_fk FOREIGN KEY (user) REFERENCES User(userId) ON DELETE CASCADE ON UPDATE CASCADE
);
ALTER TABLE UserToken COMMENT = 'Represents an authenticated user session.';

CREATE TABLE Unit
(
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL
);

CREATE TABLE Person
(
  id INT PRIMARY KEY AUTO_INCREMENT,
  unitID INT NOT NULL ,
  rank VARCHAR(64) NOT NULL ,
  firstname VARCHAR(128) NOT NULL ,
  lastname VARCHAR(128) NOT NULL,
  CONSTRAINT Person_Person_unitId_fk FOREIGN KEY (unitID) REFERENCES Unit(id) ON DELETE CASCADE ON UPDATE CASCADE
);
ALTER TABLE Person COMMENT = 'A Person. Added and edited by Users. Belongs to a Unit.';

CREATE TABLE UnitEvent
(
  id INT PRIMARY KEY AUTO_INCREMENT,
  unitID INT NOT NULL ,
  eventName VARCHAR(64) NOT NULL,
  type VARCHAR(32) NOT NULL ,
  date DATE NOT NULL ,
  description TEXT NOT NULL ,
  locationName TEXT NOT NULL ,
  latitude FLOAT NOT NULL ,
  longitude FLOAT NOT NULL ,

  CONSTRAINT UnitEvent_Unit_unitID_fk FOREIGN KEY (unitID) REFERENCES Unit(id)
    ON DELETE CASCADE ON UPDATE CASCADE
);
ALTER TABLE UnitEvent COMMENT = 'An event that occurred to some Unit along the campaign. Can be a battle, an operation, a diary entry, etc.';

/** Add Sample Data **/

/** Username: adminuser; Password: mypassword **/
INSERT INTO fantasticfour_p4.User (userId, username, pword_hash, email) VALUES (1, 'adminuser', '$2y$10$Hj1xEDJR.vr3KOPxi/iXC.et92qXsgyyb3hmM/NaAv2acz/SVxBwK', 'sample@example.com');

INSERT INTO fantasticfour_p4.Unit (id, name) VALUES (1, 'Assault Gun Platoon');
INSERT INTO fantasticfour_p4.Unit (id, name) VALUES (2, 'Reconaissance Platoon');

INSERT INTO fantasticfour_p4.Person (id, unitID, rank, firstname, lastname) VALUES (1, 1, 'Pfc', 'Lawrence', 'Clark');
INSERT INTO fantasticfour_p4.Person (id, unitID, rank, firstname, lastname) VALUES (2, 1, 'Pvt', 'Chester', 'Harej');
INSERT INTO fantasticfour_p4.Person (id, unitID, rank, firstname, lastname) VALUES (3, 1, 'Pfc', 'Vito', 'Mikalauski');
INSERT INTO fantasticfour_p4.Person (id, unitID, rank, firstname, lastname) VALUES (4, 2, 'Cpl', 'Harvey', 'Keller');
INSERT INTO fantasticfour_p4.Person (id, unitID, rank, firstname, lastname) VALUES (5, 2, 'Pvt', 'Jessie', 'Staggs');

INSERT INTO fantasticfour_p4.UnitEvent (id, unitID, eventName, type, date, description, locationName, latitude, longitude) VALUES
  (1, 1, 'Sample Battle #1', 'BATTLE', '1944-12-10', 'Lorem ipsum dolor sit amet', 'Somewhere in France', 46.820675, 2.375450);
INSERT INTO fantasticfour_p4.UnitEvent (id, unitID, eventName, type, date, description, locationName, latitude, longitude) VALUES
  (2, 1, 'Sample Battle #2', 'BATTLE', '1945-01-12', 'Lorem ipsum dolor sit amet', 'Somewhere in France', 46.820615, 2.375450);
INSERT INTO fantasticfour_p4.UnitEvent (id, unitID, eventName, type, date, description, locationName, latitude, longitude) VALUES
  (3, 1, 'Sample Battle #3', 'BATTLE', '1945-01-31', 'Lorem ipsum dolor sit amet', 'Somewhere in Germany', 46.820115, 2.375321);




  CREATE TABLE `following` (
    `id` int(11) NOT NULL,
    `userFrom` int(11) NOT NULL,
    `userTo` int(11) NOT NULL
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

  --
  -- Dumping data for table `following`
  --

  INSERT INTO `following` (`id`, `userFrom`, `userTo`) VALUES
  (1, 1, 2);

  --
  -- Indexes for dumped tables
  --

  --
  -- Indexes for table `following`
  --
  ALTER TABLE `following`
    ADD PRIMARY KEY (`id`);

  --
  -- AUTO_INCREMENT for dumped tables
  --

  --
  -- AUTO_INCREMENT for table `following`
  --
  ALTER TABLE `following`
    MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
  COMMIT;

  /*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
  /*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
  /*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

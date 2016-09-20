--
-- DarkOrbit general private server database
--
-- So I designed this database in order to offer a clean and easy to use
-- database for DarkOrbit private servers.
--
-- I was alone at home thinking about how to make a GOOD database.
-- Instead of making a table when it's needed I decided to study DarkOrbit and design
-- a database to have everything fixed.
-- The standard of this database is as follows:
--
--  -All table names are in plural. Why? A table contains various records so it's like
--   a collection of values. You don't say "An onion bag", instead you say "An onions bag"...
--   idk if this sounds good in English, but it does in Spanish :P
--
--  -All table identifiers are named "id" and are unsigned integers. Why? It makes more
--   readable the query, (I think) it's easier to read the query "SELECT * FROM `users` WHERE `users.id`=1"
--   than "SELECT * FROM `users` WHERE `users.usersID`=1"
--
--  -All table rows name are singular and grouped. Let me explain this...
--   The table `user` contains the values `register_ip` and `register_date`.
--   Those values are grouped by `register` because they're used when the user registers
--   Same applies to table names: `accounts_messages` and `accounts_profiles` are grouped by `accounts`
--
--  -Other table references are tableName_rowName, for example, table `accounts` contains the row
--   `users_id` you can read it like "From table `users` use row `id`"
--
-- If you find anything wrong here, or you want me to change something, post it in the thread.
-- I STRONGLY RECOMMEND YOU that if you extend this database to use the same standard as mine.
-- If you don't, change the whole database standards because it's going to be a mess.
--
-- See you!
--
-- @author Manulaiko
--
-- @version 0.3
--

-- Change the name of the database here
DROP DATABASE IF EXISTS `blackeye`;
CREATE DATABASE `blackeye`;
USE `blackeye`;

-- --------------------------------------------------------

--
-- Accounts
--
-- User's account, there can be more than one row with same `users_id`
--
-- @author Manulaiko
--
-- @version 0.2
--
-- @since 0.1
--

CREATE TABLE `accounts` (
  `id`                            int(10)      UNSIGNED NOT NULL AUTO_INCREMENT,
  `users_id`                      int(10)      UNSIGNED NOT NULL,
  `register_date`                 timestamp             NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `register_ip`                   varchar(15)           NOT NULL DEFAULT '0.0.0.0',
  `register_users_id`             int(10)      UNSIGNED NOT NULL,
  `last_login_date`               timestamp             NULL     DEFAULT NULL,
  `last_login_ip`                 varchar(15)           NOT NULL DEFAULT '0.0.0.0',
  `session_id`                    char(32)              NOT NULL,
  `accounts_equipment_hangars_id` int(10)      UNSIGNED NOT NULL DEFAULT '0',
  `name`                          varchar(255)          NOT NULL,
  `factions_id`                   tinyint(3)   UNSIGNED NOT NULL,
  `clans_id`                      int(10)      UNSIGNED NOT NULL DEFAULT '0',
  `uridium`                       int(11)               NOT NULL DEFAULT '10000',
  `credits`                       bigint(20)            NOT NULL DEFAULT '10000',
  `jackpot`                       decimal(5,2)          NOT NULL DEFAULT '0.00',
  `experience`                    bigint(20)            NOT NULL DEFAULT '0',
  `honor`                         int(11)               NOT NULL DEFAULT '0',
  `levels_id`                     tinyint(3)   UNSIGNED NOT NULL DEFAULT '1',
  `is_premium`                    tinyint(1)            NOT NULL DEFAULT '0',
  `ranks_id`                      int(10)      UNSIGNED NOT NULL DEFAULT '1',
  `rank_points`                   int(10)      UNSIGNED NOT NULL DEFAULT '0',
  `rank_position`                 int(10)      UNSIGNED NOT NULL DEFAULT '0',
  `rank_best_points`              int(10)      UNSIGNED NOT NULL DEFAULT '0',
  `rank_best_position`            int(10)      UNSIGNED NOT NULL DEFAULT '0',
  `quests`                        varchar(255)          NOT NULL DEFAULT '[]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Accounts
--   Equipment
--     Drones
--
-- Account's drones
--
-- @author Manulaiko
--
-- @version 0.1
--
-- @since 0.1
--

CREATE TABLE `accounts_equipment_configurations` (
  `id`                          int(10)       UNSIGNED NOT NULL AUTO_INCREMENT,
  `accounts_equipment_ships_id` int(10)       UNSIGNED NOT NULL,
  `configuration`               tinyint(3)    UNSIGNED NOT NULL,
  `lasers`                      varchar(1023)          NOT NULL DEFAULT '[]',
  `hellstorms`                  varchar(255)           NOT NULL DEFAULT '[]',
  `generators`                  varchar(1023)          NOT NULL DEFAULT '[]',
  `extras`                      varchar(1023)          NOT NULL DEFAULT '[]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Accounts
--   Equipment
--     Drones
--
-- Account's drones
--
-- @author Manulaiko
--
-- @version 0.1
--
-- @since 0.1
--

CREATE TABLE `accounts_equipment_drones` (
  `id`             int(10)       UNSIGNED NOT NULL AUTO_INCREMENT,
  `accounts_id`    int(10)       UNSIGNED NOT NULL,
  `drones_id`      int(10)       UNSIGNED NOT NULL,
  `levels_id`      tinyint(3)    UNSIGNED NOT NULL DEFAULT '1',
  `experience`     smallint(5)   UNSIGNED NOT NULL,
  `damage`         decimal(3,2)           NOT NULL,
  `configurations` varchar(2047)          NOT NULL DEFAULT '[]' COMMENT '[{"accounts_equipment_hangars_id":1,"items":[{"slots":1,"accounts_equipment_items_id":1}]}]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Accounts
--   Equipment
--     Hangars
--
-- Account's hangars
--
-- @author Manulaiko
--
-- @version 0.2
--
-- @since 0.1
--

CREATE TABLE `accounts_equipment_hangars` (
  `id`             int(10)      UNSIGNED NOT NULL AUTO_INCREMENT,
  `accounts_id`    int(10)      UNSIGNED NOT NULL,
  `date`           timestamp             NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `name`           varchar(255)          NOT NULL DEFAULT 'HANGAR',
  `resources`      varchar(1023)         NOT NULL DEFAULT '[0,0,0,0,0,0,0,0,0]',
  `configurations` varchar(2047)         NOT NULL DEFAULT '[{"configurationId":1,"lasers":[],"heavy_guns":[],"generators":[],"extras":[]},{"configurationId":2,"lasers":[],"heavy_guns":[],"generators":[],"extras":[]}]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Accounts
--   Equipment
--     Items
--
-- Accounts items
--
-- @author Manulaiko
--
-- @version 0.1
--
-- @since 0.1
--

CREATE TABLE `accounts_equipment_items` (
  `id`        int(10)    UNSIGNED NOT NULL AUTO_INCREMENT,
  `items_id`  int(10)    UNSIGNED NOT NULL,
  `levels_id` tinyint(3) UNSIGNED NOT NULL DEFAULT '1',
  `date`      timestamp           NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `amount`    int(10)    UNSIGNED NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Accounts
--   Equipment
--     Ships
--
-- If `accounts_equipment_hangars_id` is 0 it means ship stills in shipsyard
--
-- @author Manulaiko
--
-- @version 0.2
--
-- @since 0.1
--

CREATE TABLE `accounts_equipment_ships` (
  `id`                            int(10)      UNSIGNED NOT NULL AUTO_INCREMENT,
  `accounts_id`                   int(10)      UNSIGNED NOT NULL,
  `accounts_equipment_hangars_id` int(10)      UNSIGNED NOT NULL DEFAULT '0',
  `ships_id`                      smallint(5)  UNSIGNED NOT NULL,
  `ships_designs_id`              int(10)      UNSIGNED NOT NULL,
  `gfx`                           int(10)      UNSIGNED NOT NULL,
  `maps_id`                       int(10)      UNSIGNED NOT NULL,
  `date`                          timestamp             NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `position`                      varchar(255)          NOT NULL DEFAULT '[]',
  `health`                        int(11)               NOT NULL DEFAULT '0',
  `nanohull`                      int(11)               NOT NULL DEFAULT '0',
  `shield`                        int(11)               NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
--
-- Accounts
--   GalaxyGates
--
-- Account's galaxy gates
--
-- @author Manulaiko
--
-- @version 0.1
--
-- @since 0.1
--

CREATE TABLE `accounts_galaxygates` (
  `id`             int(10)     UNSIGNED NOT NULL AUTO_INCREMENT,
  `galaxygates_id` tinyint(3)  UNSIGNED NOT NULL,
  `accounts_id`    int(10)     UNSIGNED NOT NULL,
  `parts`          tinyint(3)  UNSIGNED NOT NULL,
  `wave`           smallint(6)          NOT NULL DEFAULT '-1',
  `lives`          tinyint(4)           NOT NULL DEFAULT '-1',
  `amount`         tinyint(3)  UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Accounts
--   Messages
--
-- `from_status` and `to_status` contains the current status of the
-- message for the author and the receiver.
-- Possible values:
--  -0: Message isn't read
--  -1: Message is read
--  -2: Message is deleted
--
-- @author Manulaiko
--
-- @version 0.1
--
-- @since 0.1
--

CREATE TABLE `accounts_messages` (
  `id`               int(10)      UNSIGNED NOT NULL AUTO_INCREMENT,
  `date`             timestamp              NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `from_accounts_id` int(10)      UNSIGNED NOT NULL,
  `from_status`      tinyint(1)   UNSIGNED NOT NULL DEFAULT '0',
  `to_accounts_id`   int(10)      UNSIGNED NOT NULL,
  `to_status`        tinyint(1)   UNSIGNED NOT NULL DEFAULT '0',
  `title`            varchar(255)          NOT NULL,
  `text`             text                  NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Accounts
--   Profiles
--
-- Account's profile
--
-- @author Manulaiko
--
-- @version 0.1
--
-- @since 0.1
--

CREATE TABLE `accounts_profiles` (
  `id`          int(10)        UNSIGNED NOT NULL AUTO_INCREMENT,
  `accounts_id` int(10)        UNSIGNED NOT NULL,
  `skin`        varchar(15)             NOT NULL DEFAULT 'blue',
  `avatar`      varchar(255)            NOT NULL DEFAULT 'default.jpg',
  `status`      varchar(1023)           NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Clan
--
-- Ranks JSON:
-- An array that contains objects that represents the rank.
-- Object variables:
--  -name: Rank name.
--  -rights: Array containing rank rights.
--
-- Example:
--  [{
--    "name": "Rank 1",
--    "rights": [
--      true, //Create Newsletters
--      false, //View and Edit applications
--      false, //Dismiss members
--      false, //Edit ranks
--      false, //Diplomacy: View requests, start diplomatic agreement
--      false, //Diplomacy: End alliances
--      false, //Diplomacy: Declare war on other clans
--      false, //Payment from clan treasury
--      false, //Change tax rate
--      false, //Create clan news
--      false, //Manage Battle Station Modules
--      false, //Activate/deactivate Battle Station Deflector
--      false, //Build Battle Station
--    ]
--  }, {
--    "name": "Rank 2",
--    "rights": [
--      true, //Create Newsletters
--      false, //View and Edit applications
--      false, //Dismiss members
--      false, //Edit ranks
--      false, //Diplomacy: View requests, start diplomatic agreement
--      false, //Diplomacy: End alliances
--      false, //Diplomacy: Declare war on other clans
--      false, //Payment from clan treasury
--      false, //Change tax rate
--      false, //Create clan news
--      true, //Manage Battle Station Modules
--      true, //Activate/deactivate Battle Station Deflector
--      true, //Build Battle Station
--    ]
--  }]
--
-- Members JSON:
-- An array that contains objects that represents members in the clan.
-- Object variables:
--  -accounts_id
--  -rank: Member's rank (name or JSON array index) (-1 = leader)
--  -date: Join date (timestamp or full date)
--
-- Example:
--  [{
--    "accounts_id": 1,
--    "rank": -1,
--    "date": 11992456,
--  }, {
--    "accounts_id": 2,
--    "rank": "Rank 2",
--    "date": "2015-12-25 00:00:00",
--  }]
--
-- @author Manulaiko
--
-- @version 0.1
--
-- @since 0.2
--

CREATE TABLE `clans` (
  `id`                 int(11)       UNSIGNED NOT NULL AUTO_INCREMENT,
  `date`               timestamp              NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tag`                varchar(4)             NOT NULL DEFAULT '',
  `name`               varchar(255)           NOT NULL DEFAULT '',
  `rank_points`        int(10)                NOT NULL DEFAULT '0',
  `rank_position`      int(10)                NOT NULL DEFAULT '0',
  `rank_best_points`   int(10)                NOT NULL DEFAULT '0',
  `rank_best_position` int(10)                NOT NULL DEFAULT '0',
  `ranks`              varchar(1023)          NOT NULL DEFAULT '[]',
  `members`            varchar(1023)          NOT NULL DEFAULT '[]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Collectables
--
-- A node from game.xml:
--   <collectable class="2" id="132" resKey="beacon_3_2" easterResKey="beacon_easter_3_2" soundID="3"/>
-- If you take a look you'll see there are different classes of
-- collectables:
--  -BonusBoxes (0)
--  -Resources  (1)
--  -Beacons    (2)
--  -Fireworks  (3)
-- The row `gfx` is the attribute "id" and the row `name` is the attribute "resKey"
--
-- @author Manulaiko
--
-- @version 0.1
--
-- @since 0.2
--

CREATE TABLE `collectables` (
  `id`      int(11)       UNSIGNED NOT NULL AUTO_INCREMENT,
  `gfx`     smallint(3)   UNSIGNED NOT NULL,
  `class`   tinyint(1)             NOT NULL DEFAULT '0' COMMENT '0 = box, 1 = ore, 2 = beacon, 3 = firework',
  `name`    varchar(255)           NOT NULL DEFAULT '',
  `rewards` varchar(2048)          NOT NULL DEFAULT '[]' COMMENT '[{"items_id":1,"amount":1,"probability":100.0}]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

INSERT INTO `collectables` (`id`, `gfx`, `class`, `name`, `rewards`) VALUES
(1, 0, 0, 'box0', '[]'),
(2, 1, 0, 'box1', '[]'),
(3, 2, 0, 'box2', '[]'),
(4, 3, 0, 'easterEgg', '[]'),
(5, 5, 0, 'bigPumpkin', '[]'),
(6, 6, 0, 'orangePumpkin', '[]'),
(7, 7, 0, 'turkey', '[]'),
(8, 8, 0, 'bigXmasStar', '[]'),
(9, 9, 0, 'stdXmasStar', '[]'),
(10, 10, 0, 'flower_mothersday', '[]'),
(11, 11, 0, 'theItalianBox', '[]'),
(12, 14, 0, 'crestAndStar', '[]'),
(13, 15, 0, 'polishBonusBox', '[]'),
(14, 16, 0, 'winterGiftBox', '[]'),
(15, 17, 0, 'carnival_box', '[]'),
(16, 19, 0, 'bonusBoxSun', '[]'),
(17, 20, 0, 'petWeekBox', '[]'),
(18, 21, 0, 'pirateBootyBox', '[]'),
(19, 22, 0, 'pirateBootyGoldBox', '[]'),
(20, 23, 0, 'hungarianRevolutionBox', '[]'),
(21, 24, 0, 'stpatricksDayBox', '[]'),
(22, 25, 0, 'titanicBonusBox', '[]'),
(23, 26, 0, 'brazilBonusBox', '[]'),
(24, 27, 0, 'victoryFrBonusBox', '[]'),
(25, 28, 0, 'victoryRuBonusBox', '[]'),
(26, 29, 0, 'victoryCzBonusBox', '[]'),
(27, 30, 0, 'boxStar', '[]'),
(28, 31, 0, 'pirateBootyRedBox', '[]'),
(29, 32, 0, 'pirateBootyBlueBox', '[]'),
(30, 33, 0, 'victoryFrBonusBox', '[]'),
(31, 34, 0, 'mexicanBonusBox', '[]'),
(32, 35, 0, 'boxAntec', '[]'),
(33, 36, 0, 'germanUnificationDayBox', '[]'),
(34, 37, 0, 'hispanicDayBox', '[]'),
(35, 38, 0, 'candyBox', '[]'),
(36, 39, 0, 'birthdayBox', '[]'),
(37, 40, 0, 'treasureChest', '[]'),
(38, 41, 0, 'fathersDayBox', '[]'),
(39, 42, 0, 'summerEventBox', '[]'),
(40, 43, 0, 'silverBootyBox', '[]'),
(41, 44, 0, 'britishBox', '[]'),
(42, 45, 0, 'football_box', '[]'),
(43, 46, 0, 'demanerTransporterBootyBox', '[]'),
(44, 47, 0, 'icyBox', '[]'),
(45, 0, 1, 'oreRed', '[]'),
(46, 1, 1, 'oreBlue', '[]'),
(47, 2, 1, 'oreYellow', '[]'),
(48, 8, 1, 'ore_palladium', '[]'),
(49, 112, 2, 'beacon_1_2', '[]'),
(50, 113, 2, 'beacon_1_3', '[]'),
(51, 121, 2, 'beacon_2_1', '[]'),
(52, 123, 2, 'beacon_2_3', '[]'),
(53, 131, 2, 'beacon_3_1', '[]'),
(54, 132, 2, 'beacon_3_2', '[]'),
(55, 212, 2, 'beacon_1_2', '[]'),
(56, 213, 2, 'beacon_1_3', '[]'),
(57, 221, 0, 'beacon_2_1', '[]'),
(58, 223, 0, 'beacon_2_3', '[]'),
(59, 231, 0, 'beacon_3_1', '[]'),
(60, 232, 0, 'beacon_3_2', '[]'),
(61, 31, 3, 'fireworks_box', '[]'),
(62, 32, 3, 'fireworks_box', '[]'),
(63, 33, 3, 'fireworks_box', '[]'),
(64, 34, 3, 'fireworks_box', '[]'),
(65, 35, 3, 'fireworks_box', '[]'),
(66, 36, 3, 'fireworks_box', '[]'),
(67, 121, 3, 'fireworks_box', '[]'),
(68, 122, 3, 'fireworks_box', '[]'),
(69, 123, 3, 'fireworks_box', '[]'),
(70, 131, 3, 'fireworks_box', '[]'),
(71, 132, 3, 'fireworks_box', '[]'),
(72, 133, 3, 'fireworks_box', '[]'),
(73, 211, 3, 'fireworks_box', '[]'),
(74, 212, 3, 'fireworks_box', '[]'),
(75, 213, 3, 'fireworks_box', '[]'),
(76, 221, 3, 'fireworks_box', '[]'),
(77, 222, 3, 'fireworks_box', '[]'),
(78, 223, 3, 'fireworks_box', '[]'),
(79, 231, 3, 'fireworks_box', '[]'),
(80, 232, 3, 'fireworks_box', '[]'),
(81, 233, 3, 'fireworks_box', '[]'),
(82, 311, 3, 'fireworks_box', '[]'),
(83, 312, 3, 'fireworks_box', '[]'),
(84, 313, 3, 'fireworks_box', '[]'),
(85, 321, 3, 'fireworks_box', '[]'),
(86, 322, 3, 'fireworks_box', '[]'),
(87, 323, 3, 'fireworks_box', '[]'),
(88, 331, 3, 'fireworks_box', '[]'),
(89, 332, 3, 'fireworks_box', '[]'),
(90, 333, 3, 'fireworks_box', '[]'),
(91, 411, 3, 'fireworks_box', '[]'),
(92, 412, 3, 'fireworks_box', '[]'),
(93, 413, 3, 'fireworks_box', '[]'),
(94, 421, 3, 'fireworks_box', '[]'),
(95, 422, 3, 'fireworks_box', '[]'),
(96, 423, 3, 'fireworks_box', '[]'),
(97, 431, 3, 'fireworks_box', '[]'),
(98, 432, 3, 'fireworks_box', '[]'),
(99, 433, 3, 'fireworks_box', '[]'),
(100, 511, 3, 'fireworks_box', '[]'),
(101, 512, 3, 'fireworks_box', '[]'),
(102, 513, 3, 'fireworks_box', '[]'),
(103, 521, 3, 'fireworks_box', '[]'),
(104, 522, 3, 'fireworks_box', '[]'),
(105, 523, 3, 'fireworks_box', '[]'),
(106, 531, 3, 'fireworks_box', '[]'),
(107, 532, 3, 'fireworks_box', '[]'),
(108, 533, 3, 'fireworks_box', '[]'),
(109, 601, 3, 'fireworks_box', '[]'),
(110, 602, 3, 'fireworks_box', '[]'),
(111, 603, 3, 'fireworks_box', '[]');

-- --------------------------------------------------------

--
-- Drones
--
-- Contains the available drone types of the server
--
-- @author Manulaiko
--
-- @version 0.1
--
-- @since 0.3
--

CREATE TABLE `drones` (
  `id`       int(10)       UNSIGNED NOT NULL AUTO_INCREMENT,
  `items_id` int(10)       UNSIGNED NOT NULL,
  `graphics` varchar(1024)          NOT NULL DEFAULT '[]' COMMENT '[{"levels_id":1,"gfx":1}]',
  `slots`    tinyint(4)             NOT NULL,
  `bonus`    varchar(1024)          NOT NULL DEFAULT '[]' COMMENT '[{"type":"damage","value":10.0,"conditions":[]}]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Factions
-- `is_public` means if user can join to the company (Saturn company isn't public)
--
-- @author Manulaiko
--
-- @version 0.2
--
-- @since 0.1
--

CREATE TABLE `factions` (
  `id`            tinyint(3)    UNSIGNED NOT NULL AUTO_INCREMENT,
  `name`          varchar(255)           NOT NULL,
  `abbreviation`  char(3)                NOT NULL,
  `color`         char(6)                NOT NULL,
  `is_public`     tinyint(1)             NOT NULL DEFAULT '0',
  `description`   text                   NOT NULL,
  `home_maps_id`  tinyint(3)    UNSIGNED NOT NULL DEFAULT '1',
  `home_position` varchar(255)           NOT NULL DEFAULT '[1000,1000]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

INSERT INTO `factions` (`id`, `name`, `abbreviation`, `color`, `is_public`, `home_maps_id`, `home_position`) VALUES
(1, 'Mars Mining Operations', 'mmo', 'FF8787', 1, 'I\'m not going to blow smoke up your tush, so I\'ll just get straight to the point. We at Mars Mining Operations want you for two reasons: to mine ore and to eradicate all alien scum infecting our galactic sector. Do this successfully and you\'ll soon be popping rival pilots for thrills and honor!', '[]', 1, '[1000,1000]'),
(2, 'Earth Industries Corporations', 'eic', '87FFFF', 1, 'Pilot, these are trying times during which only those made of the purest inner steel can prevail! How tough is your mettle? We reward loyalty and impeccable manners with the best lasers Uridium can buy. Join us in the fight to cleanse our sector of all those cretins that stand in our way. For glory and privilege!', '[]', 5, '[18500,1000]'),
(3, 'Venus Resources Unlimited', 'vru', 'C3FF87', 1, 'We pride ourselves in our ability to push the envelope of technological advancement, while retaining a communal atmosphere. Some call us a cult desiring galactic domination, but they simply misunderstand our brilliant recruitment methods. We are always looking for talented pilots to help us destroy our enemies and shape humanity\'s future!', '[]', 8, '[18500,12500]');

-- --------------------------------------------------------

--
-- GalaxyGates
-- Reward JSON:
--   An object that contains the reward that user receives once
--   the gate is completed
--   Variables:
--    -experience
--    -honor
--    -uridium
--    -credits
--    -resources: An array containing the amount of resources of the
--                cargobox (if any), each index is `collectables_id`
--    -others: An array containing an object that represents other items that
--             can be dropped when gate is completed.
--             Variables:
--              -items_id
--              -amount
--              -provability: A double that contains the provability of the gate
--                            to drop "items_id" once it's completed
--   Example:
--    {
--      "experience": 1000000,
--      "honor": 100000,
--      "uridium": 10000,
--      "credits": 10000000,
--      "resources": [
--        0, //prometium
--        0, //Endurium
--        0, //Terbium
--        0, //Prometid
--        0, //Duranium
--        0, //Xenomit
--        0, //Promerium
--        0, //Seprom
--        0, //Palladium
--      ],
--      "others": [{
--        "items_id": 243, //Let's assume it's LF4
--        "provability": 33.33
--      }]
--    }
--
-- Waves JSON:
--   An array that contains arrays for each step of the wave.
--   The wave step is a object that contains the "ship_id" and the "amount" of "ship_id"
--   Example:
--    [[ //Wave 1
--      { //step 1
--        "ships_id": 84, //Streuners
--        "amount": 10
--      }, { //step 2, once user has completed step 1
--        "ships_id": 84, //Streuners
--        "amount": 20
--      }, { //step 3, once user has completed step 2
--        "ships_id": 84, //Streuners
--        "amount": 10
--      }
--    ], [ //Wave 2
--      { //step 1
--        "ships_id": 85, //Lordakias
--        "amount": 20
--      }, { //step 2, once user has completed step 1
--        "ships_id": 85, //Lordakias
--        "amount": 40
--      }, { //step 3, once user has completed step 2
--        "ships_id": 85, //Lordakias
--        "amount": 20
--      }
--    ]]
--
-- @author Manulaiko
--
-- @version 0.1
--
-- @since 0.1
--

CREATE TABLE `galaxygates` (
  `id`      tinyint(3)    UNSIGNED NOT NULL AUTO_INCREMENT,
  `maps_id` tinyint(3)    UNSIGNED NOT NULL,
  `parts`   tinyint(3)    UNSIGNED NOT NULL,
  `reward`  varchar(1023)          NOT NULL DEFAULT '{"experience":0,"honor":0,"uridium":0,"credits":0,"resources":[0,0,0,0,0,0,0,0,0],"others":[]}',
  `waves`   varchar(2047)          NOT NULL DEFAULT '[]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Items
--
-- @author Manulaiko
--
-- @version 0.1
--
-- @since 0.1
--

CREATE TABLE `items` (
  `id`         smallint(5)  UNSIGNED NOT NULL AUTO_INCREMENT,
  `loot_id`    varchar(255)          NOT NULL,
  `name`       varchar(255)          NOT NULL,
  `category`   varchar(31)           NOT NULL,
  `filter`     tinyint(3)   UNSIGNED NOT NULL,
  `price_buy`  int(10)      UNSIGNED NOT NULL,
  `price_sell` int(10)      UNSIGNED NOT NULL,
  `is_elite`   tinyint(1)            NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Levels
--
-- @author Manulaiko
--
-- @version 0.1
--
-- @since 0.1
--

CREATE TABLE `levels` (
  `id`              tinyint(3)    UNSIGNED NOT NULL AUTO_INCREMENT,
  `accounts`        bigint(20)    UNSIGNED NOT NULL,
  `drones`          smallint(6)            NOT NULL DEFAULT '-1',
  `pets`            int(11)                NOT NULL DEFAULT '-1',
  `upgrade_credits` varchar(2048)          NOT NULL DEFAULT '[]' COMMENT '[{"probability":5,"amount":100000}]',
  `upgrade_uridium` varchar(2048)          NOT NULL DEFAULT '[]' COMMENT '[{"probability":5,"amount":200}]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

INSERT INTO `levels` (`id`, `accounts`, `drones`, `pets`, `upgrade_credits`, `upgrade_uridium`) VALUES
(1, 0, 0, 8000, '[]', '[]'),
(2, 10000, 100, 64000, '[{"probability":5,"amount":125000},{"probability":10,"amount":225000},{"probability":15,"amount":325000},{"probability":20,"amount":425000},{"probability":25,"amount":525000},{"probability":30,"amount":625000},{"probability":35,"amount":725000},{"probability":40,"amount":825000},{"probability":45,"amount":925000},{"probability":50,"amount":1025000},{"probability":55,"amount":1125000},{"probability":60,"amount":1225000},{"probability":65,"amount":1325000},{"probability":70,"amount":1425000},{"probability":75,"amount":1525000},{"probability":80,"amount":1625000},{"probability":85,"amount":1725000},{"probability":90,"amount":1825000},{"probability":95,"amount":1925000},{"probability":100,"amount":2025000}]', '[{"probability":5,"amount":200},{"probability":10,"amount":260},{"probability":15,"amount":335},{"probability":20,"amount":425},{"probability":25,"amount":530},{"probability":30,"amount":650},{"probability":35,"amount":785},{"probability":40,"amount":935},{"probability":45,"amount":1100},{"probability":50,"amount":1280},{"probability":55,"amount":1475},{"probability":60,"amount":1685},{"probability":65,"amount":1910},{"probability":70,"amount":2150},{"probability":75,"amount":2405},{"probability":80,"amount":2675},{"probability":85,"amount":2960},{"probability":90,"amount":3260},{"probability":95,"amount":3575},{"probability":100,"amount":3905}]'),
(3, 20000, 200, 216000, '[{"probability":5,"amount":150000},{"probability":10,"amount":300000},{"probability":15,"amount":475000},{"probability":20,"amount":675000},{"probability":25,"amount":900000},{"probability":30,"amount":1150000},{"probability":35,"amount":1425000},{"probability":40,"amount":1725000},{"probability":45,"amount":2050000},{"probability":50,"amount":2400000},{"probability":55,"amount":2755000},{"probability":60,"amount":3175000},{"probability":65,"amount":3600000},{"probability":70,"amount":4050000},{"probability":75,"amount":4525000},{"probability":80,"amount":5025000},{"probability":85,"amount":5500000},{"probability":90,"amount":6100000},{"probability":95,"amount":6675000},{"probability":100,"amount":7275000}]', '[{"probability":5,"amount":350},{"probability":10,"amount":425},{"probability":15,"amount":515},{"probability":20,"amount":620},{"probability":25,"amount":740},{"probability":30,"amount":845},{"probability":35,"amount":1025},{"probability":40,"amount":1190},{"probability":45,"amount":1370},{"probability":50,"amount":1565},{"probability":55,"amount":1775},{"probability":60,"amount":2000},{"probability":65,"amount":2240},{"probability":70,"amount":2495},{"probability":75,"amount":2765},{"probability":80,"amount":3050},{"probability":85,"amount":3320},{"probability":90,"amount":3665},{"probability":95,"amount":3995},{"probability":100,"amount":4340}]'),
(4, 40000, 400, 512000, '[{"probability":5,"amount":175000},{"probability":10,"amount":375000},{"probability":15,"amount":625000},{"probability":20,"amount":925000},{"probability":25,"amount":1275000},{"probability":30,"amount":1675000},{"probability":35,"amount":2125000},{"probability":40,"amount":2625000},{"probability":45,"amount":3175000},{"probability":50,"amount":3775000},{"probability":55,"amount":4425000},{"probability":60,"amount":5125000},{"probability":65,"amount":5875000},{"probability":70,"amount":6675000},{"probability":75,"amount":7525000},{"probability":80,"amount":8425000},{"probability":85,"amount":9375000},{"probability":90,"amount":10375000},{"probability":95,"amount":11425000},{"probability":100,"amount":12525000}]', '[{"probability":5,"amount":500},{"probability":10,"amount":590},{"probability":15,"amount":695},{"probability":20,"amount":815},{"probability":25,"amount":950},{"probability":30,"amount":1100},{"probability":35,"amount":1265},{"probability":40,"amount":1445},{"probability":45,"amount":1640},{"probability":50,"amount":1850},{"probability":55,"amount":2075},{"probability":60,"amount":2315},{"probability":65,"amount":2570},{"probability":70,"amount":2840},{"probability":75,"amount":3125},{"probability":80,"amount":3425},{"probability":85,"amount":3740},{"probability":90,"amount":4070},{"probability":95,"amount":4415},{"probability":100,"amount":4775}]'),
(5, 80000, 800, 1000000, '[{"probability":5,"amount":200000},{"probability":10,"amount":450000},{"probability":15,"amount":775000},{"probability":20,"amount":1175000},{"probability":25,"amount":1650000},{"probability":30,"amount":2200000},{"probability":35,"amount":2825000},{"probability":40,"amount":3525000},{"probability":45,"amount":4300000},{"probability":50,"amount":5150000},{"probability":55,"amount":6075000},{"probability":60,"amount":7075000},{"probability":65,"amount":8150000},{"probability":70,"amount":9300000},{"probability":75,"amount":10525000},{"probability":80,"amount":11825000},{"probability":85,"amount":13200000},{"probability":90,"amount":14650000},{"probability":95,"amount":16175000},{"probability":100,"amount":17775000}]', '[{"probability":5,"amount":650},{"probability":10,"amount":755},{"probability":15,"amount":875},{"probability":20,"amount":1010},{"probability":25,"amount":1160},{"probability":30,"amount":1325},{"probability":35,"amount":1505},{"probability":40,"amount":1700},{"probability":45,"amount":1910},{"probability":50,"amount":2135},{"probability":55,"amount":2375},{"probability":60,"amount":2630},{"probability":65,"amount":2900},{"probability":70,"amount":3185},{"probability":75,"amount":3485},{"probability":80,"amount":3800},{"probability":85,"amount":4130},{"probability":90,"amount":4475},{"probability":95,"amount":4835},{"probability":100,"amount":5210}]'),
(6, 160000, 1600, 1728000, '[{"probability":5,"amount":225000},{"probability":10,"amount":525000},{"probability":15,"amount":925000},{"probability":20,"amount":1425000},{"probability":25,"amount":2025000},{"probability":30,"amount":2725000},{"probability":35,"amount":3525000},{"probability":40,"amount":4425000},{"probability":45,"amount":5425000},{"probability":50,"amount":6525000},{"probability":55,"amount":7725000},{"probability":60,"amount":9025000},{"probability":65,"amount":10425000},{"probability":70,"amount":11925000},{"probability":75,"amount":13525000},{"probability":80,"amount":15225000},{"probability":85,"amount":17025000},{"probability":90,"amount":18925000},{"probability":95,"amount":20925000},{"probability":100,"amount":23025000}]', '[{"probability":5,"amount":800},{"probability":10,"amount":920},{"probability":15,"amount":1055},{"probability":20,"amount":1205},{"probability":25,"amount":1370},{"probability":30,"amount":1550},{"probability":35,"amount":1745},{"probability":40,"amount":1955},{"probability":45,"amount":2180},{"probability":50,"amount":2420},{"probability":55,"amount":2675},{"probability":60,"amount":2945},{"probability":65,"amount":3230},{"probability":70,"amount":3530},{"probability":75,"amount":3845},{"probability":80,"amount":4175},{"probability":85,"amount":4520},{"probability":90,"amount":4880},{"probability":95,"amount":5255},{"probability":100,"amount":5645}]'),
(7, 320000, -1, 2744000, '[{"probability":5,"amount":250000},{"probability":10,"amount":600000},{"probability":15,"amount":1075000},{"probability":20,"amount":1675000},{"probability":25,"amount":2400000},{"probability":30,"amount":3250000},{"probability":35,"amount":4225000},{"probability":40,"amount":5325000},{"probability":45,"amount":6550000},{"probability":50,"amount":7900000},{"probability":55,"amount":9375000},{"probability":60,"amount":10975000},{"probability":65,"amount":12700000},{"probability":70,"amount":14550000},{"probability":75,"amount":16525000},{"probability":80,"amount":18625000},{"probability":85,"amount":20850000},{"probability":90,"amount":23200000},{"probability":95,"amount":25675000},{"probability":100,"amount":28275000}]', '[{"probability":5,"amount":950},{"probability":10,"amount":1085},{"probability":15,"amount":1235},{"probability":20,"amount":1400},{"probability":25,"amount":1580},{"probability":30,"amount":1775},{"probability":35,"amount":1985},{"probability":40,"amount":2210},{"probability":45,"amount":2420},{"probability":50,"amount":2705},{"probability":55,"amount":2975},{"probability":60,"amount":3260},{"probability":65,"amount":3530},{"probability":70,"amount":3875},{"probability":75,"amount":4205},{"probability":80,"amount":4550},{"probability":85,"amount":4910},{"probability":90,"amount":5285},{"probability":95,"amount":5675},{"probability":100,"amount":6080}]'),
(8, 640000, -1, 4096000, '[{"probability":5,"amount":250000},{"probability":10,"amount":675000},{"probability":15,"amount":1225000},{"probability":20,"amount":1925000},{"probability":25,"amount":2775000},{"probability":30,"amount":3775000},{"probability":35,"amount":4925000},{"probability":40,"amount":6225000},{"probability":45,"amount":7675000},{"probability":50,"amount":9275000},{"probability":55,"amount":11025000},{"probability":60,"amount":12925000},{"probability":65,"amount":14975000},{"probability":70,"amount":17175000},{"probability":75,"amount":19525000},{"probability":80,"amount":22025000},{"probability":85,"amount":24675000},{"probability":90,"amount":27475000},{"probability":95,"amount":30425000},{"probability":100,"amount":33525000}]', '[{"probability":5,"amount":1100},{"probability":10,"amount":1250},{"probability":15,"amount":1415},{"probability":20,"amount":1595},{"probability":25,"amount":1790},{"probability":30,"amount":2000},{"probability":35,"amount":2225},{"probability":40,"amount":2465},{"probability":45,"amount":2720},{"probability":50,"amount":2990},{"probability":55,"amount":3275},{"probability":60,"amount":3575},{"probability":65,"amount":3890},{"probability":70,"amount":4220},{"probability":75,"amount":4565},{"probability":80,"amount":4925},{"probability":85,"amount":5300},{"probability":90,"amount":5690},{"probability":95,"amount":6095},{"probability":100,"amount":6515}]'),
(9, 1280000, -1, 5832000, '[{"probability":5,"amount":300000},{"probability":10,"amount":750000},{"probability":15,"amount":1375000},{"probability":20,"amount":2175000},{"probability":25,"amount":3150000},{"probability":30,"amount":4300000},{"probability":35,"amount":5625000},{"probability":40,"amount":7125000},{"probability":45,"amount":8800000},{"probability":50,"amount":10650000},{"probability":55,"amount":12675000},{"probability":60,"amount":14875000},{"probability":65,"amount":17250000},{"probability":70,"amount":19800000},{"probability":75,"amount":22525000},{"probability":80,"amount":25425000},{"probability":85,"amount":28500000},{"probability":90,"amount":31750000},{"probability":95,"amount":35175000},{"probability":100,"amount":38775000}]', '[{"probability":5,"amount":1250},{"probability":10,"amount":1415},{"probability":15,"amount":1595},{"probability":20,"amount":1790},{"probability":25,"amount":2000},{"probability":30,"amount":2225},{"probability":35,"amount":2465},{"probability":40,"amount":2720},{"probability":45,"amount":2990},{"probability":50,"amount":3275},{"probability":55,"amount":3575},{"probability":60,"amount":3890},{"probability":65,"amount":4220},{"probability":70,"amount":4565},{"probability":75,"amount":4925},{"probability":80,"amount":5300},{"probability":85,"amount":5690},{"probability":90,"amount":6095},{"probability":95,"amount":6515},{"probability":100,"amount":9650}]'),
(10, 2560000, -1, 8000000, '[{"probability":5,"amount":325000},{"probability":10,"amount":825000},{"probability":15,"amount":1525000},{"probability":20,"amount":2425000},{"probability":25,"amount":3525000},{"probability":30,"amount":4825000},{"probability":35,"amount":6325000},{"probability":40,"amount":8025000},{"probability":45,"amount":9925000},{"probability":50,"amount":12025000},{"probability":55,"amount":14325000},{"probability":60,"amount":16825000},{"probability":65,"amount":19525000},{"probability":70,"amount":22425000},{"probability":75,"amount":25525000},{"probability":80,"amount":28825000},{"probability":85,"amount":32325000},{"probability":90,"amount":36025000},{"probability":95,"amount":39925000},{"probability":100,"amount":44025000}]', '[{"probability":5,"amount":1400},{"probability":10,"amount":1580},{"probability":15,"amount":1775},{"probability":20,"amount":1985},{"probability":25,"amount":2210},{"probability":30,"amount":2450},{"probability":35,"amount":2705},{"probability":40,"amount":2975},{"probability":45,"amount":3260},{"probability":50,"amount":3560},{"probability":55,"amount":3875},{"probability":60,"amount":4205},{"probability":65,"amount":4550},{"probability":70,"amount":4910},{"probability":75,"amount":5285},{"probability":80,"amount":5675},{"probability":85,"amount":6080},{"probability":90,"amount":6500},{"probability":95,"amount":6935},{"probability":100,"amount":7385}]'),
(11, 5120000, -1, 10648000, '[{"probability":5,"amount":350000},{"probability":10,"amount":900000},{"probability":15,"amount":1675000},{"probability":20,"amount":2675000},{"probability":25,"amount":3900000},{"probability":30,"amount":5350000},{"probability":35,"amount":7025000},{"probability":40,"amount":8925000},{"probability":45,"amount":11025000},{"probability":50,"amount":13400000},{"probability":55,"amount":15975000},{"probability":60,"amount":18775000},{"probability":65,"amount":21800000},{"probability":70,"amount":25050000},{"probability":75,"amount":28525000},{"probability":80,"amount":32225000},{"probability":85,"amount":36150000},{"probability":90,"amount":40300000},{"probability":95,"amount":44675000},{"probability":100,"amount":49275000}]', '[{"probability":5,"amount":1550},{"probability":10,"amount":1745},{"probability":15,"amount":1955},{"probability":20,"amount":2180},{"probability":25,"amount":2420},{"probability":30,"amount":2675},{"probability":35,"amount":2945},{"probability":40,"amount":3230},{"probability":45,"amount":3530},{"probability":50,"amount":3845},{"probability":55,"amount":4175},{"probability":60,"amount":4520},{"probability":65,"amount":4880},{"probability":70,"amount":5255},{"probability":75,"amount":5645},{"probability":80,"amount":6050},{"probability":85,"amount":6470},{"probability":90,"amount":6905},{"probability":95,"amount":7355},{"probability":100,"amount":7820}]'),
(12, 10240000, -1, 13824000, '[{"probability":5,"amount":375000},{"probability":10,"amount":975000},{"probability":15,"amount":1825000},{"probability":20,"amount":2925000},{"probability":25,"amount":4275000},{"probability":30,"amount":5875000},{"probability":35,"amount":7725000},{"probability":40,"amount":9825000},{"probability":45,"amount":12175000},{"probability":50,"amount":14775000},{"probability":55,"amount":17625000},{"probability":60,"amount":20725000},{"probability":65,"amount":24075000},{"probability":70,"amount":27675000},{"probability":75,"amount":31525000},{"probability":80,"amount":35625000},{"probability":85,"amount":39975000},{"probability":90,"amount":44575000},{"probability":95,"amount":49425000},{"probability":100,"amount":54525000}]', '[{"probability":5,"amount":1700},{"probability":10,"amount":1910},{"probability":15,"amount":2135},{"probability":20,"amount":2375},{"probability":25,"amount":2630},{"probability":30,"amount":2900},{"probability":35,"amount":3185},{"probability":40,"amount":3485},{"probability":45,"amount":3800},{"probability":50,"amount":4130},{"probability":55,"amount":4475},{"probability":60,"amount":4835},{"probability":65,"amount":5210},{"probability":70,"amount":5600},{"probability":75,"amount":6005},{"probability":80,"amount":6425},{"probability":85,"amount":6860},{"probability":90,"amount":7310},{"probability":95,"amount":7755},{"probability":100,"amount":8255}]'),
(13, 20480000, -1, 17576000, '[{"probability":5,"amount":400000},{"probability":10,"amount":1050000},{"probability":15,"amount":1975000},{"probability":20,"amount":3175000},{"probability":25,"amount":4650000},{"probability":30,"amount":6400000},{"probability":35,"amount":8425000},{"probability":40,"amount":10725000},{"probability":45,"amount":13300000},{"probability":50,"amount":16150000},{"probability":55,"amount":19275000},{"probability":60,"amount":22675000},{"probability":65,"amount":26350000},{"probability":70,"amount":30300000},{"probability":75,"amount":34525000},{"probability":80,"amount":39025000},{"probability":85,"amount":43800000},{"probability":90,"amount":48850000},{"probability":95,"amount":54175000},{"probability":100,"amount":59775000}]', '[{"probability":5,"amount":1850},{"probability":10,"amount":2075},{"probability":15,"amount":2315},{"probability":20,"amount":2570},{"probability":25,"amount":2840},{"probability":30,"amount":3125},{"probability":35,"amount":3425},{"probability":40,"amount":3740},{"probability":45,"amount":4070},{"probability":50,"amount":4415},{"probability":55,"amount":4775},{"probability":60,"amount":5150},{"probability":65,"amount":5540},{"probability":70,"amount":5945},{"probability":75,"amount":6365},{"probability":80,"amount":6800},{"probability":85,"amount":7250},{"probability":90,"amount":7715},{"probability":95,"amount":8195},{"probability":100,"amount":8690}]'),
(14, 40960000, -1, 21952000, '[{"probability":5,"amount":425000},{"probability":10,"amount":1125000},{"probability":15,"amount":2125000},{"probability":20,"amount":3425000},{"probability":25,"amount":5025000},{"probability":30,"amount":6925000},{"probability":35,"amount":9125000},{"probability":40,"amount":11625000},{"probability":45,"amount":14425000},{"probability":50,"amount":17525000},{"probability":55,"amount":20925000},{"probability":60,"amount":24625000},{"probability":65,"amount":28625000},{"probability":70,"amount":32925000},{"probability":75,"amount":37525000},{"probability":80,"amount":42425000},{"probability":85,"amount":47625000},{"probability":90,"amount":53125000},{"probability":95,"amount":58925000},{"probability":100,"amount":65025000}]', '[{"probability":5,"amount":2000},{"probability":10,"amount":2240},{"probability":15,"amount":2495},{"probability":20,"amount":2756},{"probability":25,"amount":3050},{"probability":30,"amount":3665},{"probability":35,"amount":3995},{"probability":40,"amount":4530},{"probability":45,"amount":4700},{"probability":50,"amount":5075},{"probability":55,"amount":5465},{"probability":60,"amount":5870},{"probability":65,"amount":6290},{"probability":70,"amount":6725},{"probability":75,"amount":7175},{"probability":80,"amount":7640},{"probability":85,"amount":8120},{"probability":90,"amount":8615},{"probability":95,"amount":9125},{"probability":100,"amount":59775000}]'),
(15, 81920000, -1, 27000000, '[{"probability":5,"amount":450000},{"probability":10,"amount":1200000},{"probability":15,"amount":2275000},{"probability":20,"amount":3675000},{"probability":25,"amount":5400000},{"probability":30,"amount":7450000},{"probability":35,"amount":9825000},{"probability":40,"amount":12525000},{"probability":45,"amount":15550000},{"probability":50,"amount":18900000},{"probability":55,"amount":22575000},{"probability":60,"amount":26575000},{"probability":65,"amount":30900000},{"probability":70,"amount":35550000},{"probability":75,"amount":40252000},{"probability":80,"amount":45825000},{"probability":85,"amount":51450000},{"probability":90,"amount":57400000},{"probability":95,"amount":63675000},{"probability":100,"amount":70275000}]', '[{"probability":5,"amount":2150},{"probability":10,"amount":2405},{"probability":15,"amount":2675},{"probability":20,"amount":2960},{"probability":25,"amount":3260},{"probability":30,"amount":3575},{"probability":35,"amount":3905},{"probability":40,"amount":4250},{"probability":45,"amount":4610},{"probability":50,"amount":4985},{"probability":55,"amount":5375},{"probability":60,"amount":5780},{"probability":65,"amount":6200},{"probability":70,"amount":6635},{"probability":75,"amount":7085},{"probability":80,"amount":7550},{"probability":85,"amount":8030},{"probability":90,"amount":8525},{"probability":95,"amount":9035},{"probability":100,"amount":9560}]'),
(16, 163840000, -1, -1, '[{"probability":5,"amount":475000},{"probability":10,"amount":1275000},{"probability":15,"amount":2425000},{"probability":20,"amount":3925000},{"probability":25,"amount":5775000},{"probability":30,"amount":7975000},{"probability":35,"amount":10525000},{"probability":40,"amount":13425000},{"probability":45,"amount":16675000},{"probability":50,"amount":20275000},{"probability":55,"amount":24225000},{"probability":60,"amount":28525000},{"probability":65,"amount":33175000},{"probability":70,"amount":38175000},{"probability":75,"amount":43525000},{"probability":80,"amount":49225000},{"probability":85,"amount":55275000},{"probability":90,"amount":61675000},{"probability":95,"amount":68425000},{"probability":100,"amount":15525000}]', '[{"probability":5,"amount":2300},{"probability":10,"amount":2570},{"probability":15,"amount":2855},{"probability":20,"amount":3155},{"probability":25,"amount":3470},{"probability":30,"amount":3800},{"probability":35,"amount":4145},{"probability":40,"amount":4505},{"probability":45,"amount":4880},{"probability":50,"amount":5270},{"probability":55,"amount":5675},{"probability":60,"amount":6095},{"probability":65,"amount":6530},{"probability":70,"amount":6980},{"probability":75,"amount":7445},{"probability":80,"amount":7925},{"probability":85,"amount":8420},{"probability":90,"amount":8930},{"probability":95,"amount":9455},{"probability":100,"amount":9995}]'),
(17, 327680000, -1, -1, '[]', '[]'),
(18, 655360000, -1, -1, '[]', '[]'),
(19, 1310720000, -1, -1, '[]', '[]'),
(20, 2621440000, -1, -1, '[]', '[]'),
(21, 5242880000, -1, -1, '[]', '[]'),
(22, 10485760000, -1, -1, '[]', '[]'),
(23, 20971520000, -1, -1, '[]', '[]'),
(24, 41943040000, -1, -1, '[]', '[]'),
(25, 83886080000, -1, -1, '[]', '[]'),
(26, 167772160000, -1, -1, '[]', '[]'),
(27, 335544320000, -1, -1, '[]', '[]'),
(28, 671088640000, -1, -1, '[]', '[]'),
(29, 1342177280000, -1, -1, '[]', '[]'),
(30, 2684354560000, -1, -1, '[]', '[]'),
(31, 5368709120000, -1, -1, '[]', '[]'),
(32, 10737418240000, -1, -1, '[]', '[]'),
(33, 21474836480000, -1, -1, '[]', '[]'),
(34, 42949672960000, -1, -1, '[]', '[]'),
(35, 85899345920000, -1, -1, '[]', '[]'),
(36, 171798691840000, -1, -1, '[]', '[]'),
(37, 343597383680000, -1, -1, '[]', '[]'),
(38, 687194767360000, -1, -1, '[]', '[]'),
(39, 1374389534720000, -1, -1, '[]', '[]'),
(40, 2748779069440000, -1, -1, '[]', '[]');

-- --------------------------------------------------------

--
-- Maps
--
-- Stations JSON:
--   An array containing map's station.
--   Variables:
--    -position: Station position
--    -factions_id: Station's faction
--
--   Example:
--    [{
--      "position": [
--        1000, //X
--        1000, //Y
--      ],
--      "factions_id": 1
--    }]
--
-- NPCS JSON:
--   An array containing map's NPCs.
--   Variables:
--    -npcs_id
--    -amount
--
--   Example:
--    [{
--      "npcs_id": 84,
--      "amount": 50
--    }]
--
-- @author Manulaiko
--
-- @version 0.1
--
-- @since 0.1
--

CREATE TABLE `maps` (
  `id`           int(10)       UNSIGNED NOT NULL AUTO_INCREMENT,
  `name`         char(3)                NOT NULL,
  `limits`       varchar(255)           NOT NULL DEFAULT '[20800,12800]',
  `stations`     varchar(1023)          NOT NULL DEFAULT '[]' COMMENT '[{"position":[1000,1000],"factions_id":1}]',
  `npcs`         varchar(1023)          NOT NULL DEFAULT '[]' COMMENT '[{"npcs_id":1,"amount":100}]',
  `collectables` varchar(1023)          NOT NULL DEFAULT '[]' COMMENT '[{"collectables_id":1,"amount":200,"top_x":[1000,1000],"bottom_y":[4000,4000]}]'
  `is_pvp`       tinyint(1)             NOT NULL DEFAULT '0',
  `is_starter`   tinyint(1)             NOT NULL DEFAULT '0',
  `factions_id`  tinyint(1)    UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Maps' portals
--
-- @author Manulaiko
--
-- @version 0.1
--
-- @since 0.4
--

CREATE TABLE `maps_portals` (
  `id`              int(10)      UNSIGNED NOT NULL AUTO_INCREMENT,
  `maps_id`         int(10)      UNSIGNED NOT NULL DEFAULT '0',
  `levels_id`       int(10)      UNSIGNED NOT NULL DEFAULT '1',
  `position`        varchar(255)          NOT NULL DEFAULT '[]',
  `target_maps_id`  int(10)      UNSIGNED NOT NULL DEFAULT '0',
  `target_position` varchar(255)          NOT NULL DEFAULT '[]',
  `is_visible`      boolean(1)            NOT NULL DEFAULT '1',
  `is_working`      boolean(1)            NOT NULL DEFAULT '1',
  `factions_scrap`  tinyint(3)   UNSIGNED NOT NULL DEFAULT '0',
  `gfx`             tinyint(3)   UNSIGNED NOT NULL DEFAULT '1',
  PRIMARY KEY(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- News
--
-- @author Manulaiko
--
-- @version 0.1
--
-- @since 0.1
--

CREATE TABLE `news` (
  `id`        int(10)      UNSIGNED NOT NULL AUTO_INCREMENT,
  `date`      timestamp             NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `permalink` varchar(31)           NOT NULL,
  `title`     varchar(255)          NOT NULL,
  `text`      text                  NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- NPCs table
--
-- Contains the NPCs from server
--
-- @author Manulaiko
--
-- @version 0.1
--
-- @since 0.3
--

CREATE TABLE `npcs` (
  `id`                int(10)       UNSIGNED NOT NULL AUTO_INCREMENT,
  `gfx`               int(10)       UNSIGNED NOT NULL,
  `name`              varchar(255)           NOT NULL DEFAULT '-=[Streuner]=-',
  `health`            int(10)       UNSIGNED NOT NULL,
  `shield`            int(10)       UNSIGNED NOT NULL,
  `shield_absorbtion` decimal(3,2)           NOT NULL DEFAULT '9.99',
  `damage`            int(10)       UNSIGNED NOT NULL,
  `speed`             smallint(5)   UNSIGNED NOT NULL,
  `reward`            varchar(2048)          NOT NULL DEFAULT '{"experience":0,"honor":0,"uridium":0,"credits":0,"resources":[0,0,0,0,0,0,0,0,0],"others":[]}' COMMENT '{"experience":0,"honor":0,"uridium":0,"credits":0,"resources":[0,0,0,0,0,0,0,0,0],"others":[]}',
  `ai_type`           tinyint(3)    UNSIGNED NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Quests
-- Reward JSON:
--   An array that contains an object with 2 variables:
--    -items_id: The ID of the reward item (from `items`)
--               things like uridium, credits, experience or honor
--               don't have a row in `items` so just put the name in uppercase
--               ("URIDIUM", "CREDITS", "EXPERIENCE", "HONOR")
--    -amount:  The amount of items to give
-- Example:
-- [{
--   "items_id": "CREDITS",
--   "amount": 10000
-- }, {
--   "items_id": 1,
--   "amount": 4
-- }]
--
-- Quest JSON:
--   An array that contains the things to do in order
--   to complete the quest.
--   Each index is an object that contains the thing to do
--   The content of the object can vary from each kind of thing
--   (Collect ore, kill enemies, stay alive...)
--
--   Common variables:
--    -type:      The kind of type the user must complete.
--                it can be either a constant (uppercase string) or a integer
--                Examples:
--                 - COLLECT      (1)
--                 - FLY_DISTANCE (2)
--                 - KILL         (3)
--                 - STAY_ALIVE   (4)
--                 - VISIT_MAP    (5)
--                 - ANY_OF       (6)
--                 - IN_ORDER     (7)
--    -condition: An array containing objects that represents the condition
--                to accomplish. Variables:
--                 -type:  Can be either a constant or an integer and it represents
--                         the type of condition, Examples:
--                          - ACCOMPLISH_BEFORE (1)
--                          - ON_MAP            (2)
--                          - DO_NOT_DIE        (3)
--                 -value: An integer that contains the value of the condition.
--                Examples:
--                 [{
--                   "type":  "ACCOMPLISH_BEFORE",
--                   "value": 3600, //Number of seconds on which the condition should be accomplished
--                 }, {
--                   "type":  2,
--                   "value": 1, //maps_id, if is string like home1 represents user's faction 1st map (1-1 MMO, 2-1 EIC, 3-1 VRU)
--                 }, {
--                   "type":  "DO_NOT_DIE",
--                   "value": 5,//Don't die more than 5 times (0=Must complete the condition without dying)
--                 }]
--    -locked: A boolean that tells if the user needs to complete the condition asked before the current one
--
--   Variables for each type:
--   COLLECT:
--    Requires user to collect collectables.
--    Variables:
--     -collectables_id: Identifier of table `collectables` (0=any)
--     -amount:          Amount of collectables to collect
--
--   FLY_DISTANCE:
--    Requires user to fly a distance.
--    Variables:
--     -distance: Amount of distance to travel
--
--   KILL:
--    Requires user to kill a ship (user or npc).
--    Variables:
--     -ships_id: Identifier of table `ships` (0=any)
--     -amount:   Amount of ships to kill
--
--   STAY_ALIVE:
--    Requires the user to stay alive.
--    Variables:
--     -amount: Amount of seconds to stay alive
--
--   VISIT_MAP:
--    Requires the user to visit a map
--     -maps_id: Identifier of table `maps` (0=any)
--
--   ANY_OF:
--    An array containing different options that user can choose to complete.
--    The array is like the main quest array.
--    Variables:
--     -options: the array
--
--   IN_ORDER:
--    Same as above but user needs to complete the things in order.
--    Variables:
--     -options: the array
-- Example:
--  [{
--    "type": "COLLECT",
--    "collectables_id": 1, //Let's assume it's prometium
--    "amount": 10,
--    "condition": [{
--      "type": "ON_MAP",
--      "value": "home2" //MMO: 1-2, EIC: 2-2, VRU: 3-2
--    },{
--      "type": "ACCOMPLISH_BEFORE",
--      "value": 3600 //In less than an hour
--    }]
--  }, {
--    "type": "IN_ORDER",
--    "options": [{ //Accomplish the following things in order
--      "type": "KILL",
--      "ships_id": 84, //Streuners
--      "amount": 10,
--      "condition": [{
--        "type": "ON_MAP",
--        "value": "home-1" //MMO: 1-1, EIC: 2-1, VRU 3-1
--      }, {
--        "type": "DO_NOT_DIE",
--        "value": 0 //Complete it without dying
--      }]
--    }, {
--      "type": "STAY_ALIVE",
--      "amount": 300, //Stay alive 5 minutes
--      "condition": [{
--        "type": "ON_MAP",
--        "value": "enemy-5" //For MMO: 2-5 and 3-5, for EIC: 1-5 and 3-5, for VRU. 1-5 and 2-5
--      }]
--    }]
--  }]
--
-- @author Manulaiko
--
-- @version 0.1
--
-- @since 0.1
--

CREATE TABLE `quests` (
  `id`     int(10)       UNSIGNED NOT NULL AUTO_INCREMENT,
  `reward` varchar(1023)          NOT NULL,
  `quest`  text                   NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Ranks
--
-- @author Manulaiko
--
-- @version 0.1
--
-- @since 0.1
--

CREATE TABLE `ranks` (
  `id`         int(10)      UNSIGNED NOT NULL AUTO_INCREMENT,
  `name`       varchar(31)           NOT NULL,
  `percentage` decimal(3,2)          NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Ships
-- Reward JSON:
--   An object that contains the reward that user receives once
--   the ship is killed
--   Variables:
--    -experience
--    -honor
--
-- @author Manulaiko
--
-- @version 0.1
--
-- @since 0.1
--
CREATE TABLE `ships` (
  `id`         int(10)       UNSIGNED NOT NULL AUTO_INCREMENT,
  `items_id`   int(10)       UNSIGNED NOT NULL,
  `health`     int(10)       UNSIGNED NOT NULL DEFAULT '1000',
  `speed`      smallint(5)   UNSIGNED NOT NULL DEFAULT '100',
  `cargo`      smallint(5)   UNSIGNED NOT NULL DEFAULT '100',
  `lasers`     tinyint(3)    UNSIGNED NOT NULL DEFAULT '1',
  `generators` tinyint(3)    UNSIGNED NOT NULL DEFAULT '1',
  `extras`     tinyint(3)    UNSIGNED NOT NULL DEFAULT '1',
  `batteries`  int(10)       UNSIGNED NOT NULL DEFAULT '2000',
  `rockets`    int(10)       UNSIGNED NOT NULL DEFAULT '100',
  `reward`     varchar(2047)          NOT NULL DEFAULT '{"experience":0,"honor":0}',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Ships
--   Designs
--
-- Ship's design table
--
-- Bonus JSON:
--   A JSON array containing design's bonus.
--   Each index is an object with 3 variables.
--   Variabes:
--     -type
--     -value
--     -conditions
--
-- @author Manulaiko
--
-- @version 0.1
--
-- @since 0.3
--

CREATE TABLE `ships_designs` (
  `id`       int(10)       UNSIGNED NOT NULL AUTO_INCREMENT,
  `ships_id` int(10)       UNSIGNED NOT NULL,
  `gfx`      int(11)                NOT NULL,
  `bonus`    varchar(2048)          NOT NULL DEFAULT '[]' COMMENT '[{"type":"experience","value":10.0,"conditions":[]},{"type":"honor","value":10.0,"conditions":[]}]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Trade
-- All items that are available in the trade are stored here.
-- `accounts_id` is the highest bidder and `bid` is the highest bid
--
-- @author Manulaiko
--
-- @version 0.1
--
-- @since 0.1
--

CREATE TABLE `trade` (
  `id`          int(10)    UNSIGNED NOT NULL AUTO_INCREMENT,
  `items_id`    int(10)    UNSIGNED NOT NULL,
  `accounts_id` int(10)    UNSIGNED NOT NULL DEFAULT '0',
  `bid`         bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Users
-- This tables represents user's details.
-- Instead of putting all account related things here I've made
-- another table so same user can have more than one account.
--
-- The account on which user logged in last time is stored in `last_login_accounts_id`
-- and the account that was created when the user registered is in `register_accounts_id`
--
-- About email verification, if `email_verification_date` is 0 it means user hasn't
-- verified its email
--
-- @author Manulaiko
--
-- @version 0.1
--
-- @since 0.1
--
CREATE TABLE `users` (
  `id`                      int(10)      UNSIGNED NOT NULL AUTO_INCREMENT,
  `invitation_code`         char(32)              NOT NULL DEFAULT '00000000000000000000000000000000',
  `register_date`           timestamp             NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `register_ip`             varchar(15)           NOT NULL DEFAULT '0.0.0.0',
  `register_accounts_id`    int(10)      UNSIGNED NOT NULL,
  `last_login_date`         timestamp             NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_login_ip`           varchar(15)           NOT NULL DEFAULT '0.0.0.0',
  `last_login_accounts_id`  int(10)      UNSIGNED NOT NULL,
  `session_id`              char(32)              NOT NULL,
  `name`                    varchar(255)          NOT NULL,
  `password`                char(32)              NOT NULL,
  `email`                   varchar(255)          NOT NULL,
  `email_verification_code` char(32)              NOT NULL,
  `email_verification_date` timestamp             NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

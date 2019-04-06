/*
Navicat MySQL Data Transfer

Source Server         : statistics
Source Server Version : 50638
Source Host           : localhost:3306
Source Database       : statistics

Target Server Type    : MYSQL
Target Server Version : 50638
File Encoding         : 65001

Date: 2019-04-06 21:30:33
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for players
-- ----------------------------
DROP TABLE IF EXISTS `players`;
CREATE TABLE `players` (
  `player_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `number` tinyint(3) unsigned NOT NULL COMMENT 'Игровой номер',
  `surname` varchar(100) NOT NULL COMMENT 'Фамилия',
  `name` varchar(100) NOT NULL COMMENT 'Имя',
  `birthdate` date NOT NULL,
  `country_id` smallint(5) NOT NULL,
  `game_position_id` tinyint(3) NOT NULL,
  `height` smallint(5) NOT NULL,
  `weight` smallint(5) NOT NULL,
  `avatar_src` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`player_id`)
) ENGINE=InnoDB AUTO_INCREMENT=187 DEFAULT CHARSET=utf8 COMMENT='Список игроков';

-- ----------------------------
-- Records of players
-- ----------------------------
INSERT INTO `players` VALUES ('81', '1', 'Швед', 'Алексей', '1988-12-16', '1', '2', '198', '86', '/images/player_avatars/shved.jpg');
INSERT INTO `players` VALUES ('103', '8', 'Зайцев', 'Вячеслав', '1989-08-28', '1', '2', '190', '86', '/images/player_avatars/zaytsev.jpg');
INSERT INTO `players` VALUES ('113', '12', 'Моня', 'Сергей', '1983-04-15', '1', '1', '202', '107', null);
INSERT INTO `players` VALUES ('124', '6', 'Вяльцев', 'Егор', '1985-10-10', '1', '2', '193', '88', null);
INSERT INTO `players` VALUES ('142', '0', 'Патеев', 'Руслан', '0000-00-00', '0', '0', '0', '0', null);
INSERT INTO `players` VALUES ('155', '0', 'Ханникатт', 'Тайлер', '0000-00-00', '0', '0', '0', '0', null);
INSERT INTO `players` VALUES ('156', '0', 'Соколов', 'Дмитрий', '0000-00-00', '0', '0', '0', '0', null);
INSERT INTO `players` VALUES ('157', '0', 'Тодорович', 'Марко', '0000-00-00', '0', '0', '0', '0', null);
INSERT INTO `players` VALUES ('161', '16', 'Якушкин', 'Тимофей', '1997-01-16', '1', '2', '194', '82', null);
INSERT INTO `players` VALUES ('171', '22', 'Дженкинс', 'Чарльз', '1989-02-28', '2', '2', '191', '100', null);
INSERT INTO `players` VALUES ('172', '9', 'Маркович', 'Стефан', '1988-04-25', '3', '2', '199', '98', null);
INSERT INTO `players` VALUES ('173', '0', 'Андерсон', 'Джеймс', '1989-03-25', '2', '0', '198', '98', null);
INSERT INTO `players` VALUES ('174', '20', 'Зубков', 'Андрей', '1991-06-29', '1', '1', '205', '100', null);
INSERT INTO `players` VALUES ('175', '13', 'Гилл', 'Энтони', '1992-10-17', '2', '1', '203', '104', null);
INSERT INTO `players` VALUES ('176', '23', 'Томас', 'Малькольм', '1988-11-08', '2', '1', '206', '102', null);
INSERT INTO `players` VALUES ('177', '0', 'Ткаченко', 'Максим', '0000-00-00', '0', '0', '0', '0', null);
INSERT INTO `players` VALUES ('178', '0', 'Прощенко', 'Маским', '0000-00-00', '0', '0', '0', '0', null);
INSERT INTO `players` VALUES ('179', '0', 'Робинсон', 'Томас', '0000-00-00', '0', '0', '0', '0', null);
INSERT INTO `players` VALUES ('181', '3', 'Бост', 'Ди', '1989-10-12', '2', '2', '188', '80', null);
INSERT INTO `players` VALUES ('182', '5', 'Крокер', 'Тони', '1987-01-17', '2', '1', '198', '98', null);
INSERT INTO `players` VALUES ('183', '7', 'Грин', 'Гарлон', '1991-01-11', '2', '1', '201', '98', null);
INSERT INTO `players` VALUES ('184', '10', 'Прэтер', 'Кейси', '1991-05-29', '2', '2', '198', '96', null);
INSERT INTO `players` VALUES ('185', '15', 'Губанов', 'Петр', '1987-04-03', '1', '3', '207', '103', null);
INSERT INTO `players` VALUES ('186', '25', 'Мики', 'Джордан', '1994-07-09', '2', '1', '203', '107', null);

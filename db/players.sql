/*
Navicat MySQL Data Transfer

Source Server         : Stat-origin
Source Server Version : 50643
Source Host           : VH247.spaceweb.ru:3306
Source Database       : ivanshiru_stat

Target Server Type    : MYSQL
Target Server Version : 50643
File Encoding         : 65001

Date: 2019-08-01 23:30:08
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
INSERT INTO `players` VALUES ('113', '12', 'Моня', 'Сергей', '1983-04-15', '1', '1', '202', '107', '/images/player_avatars/monya.jpg');
INSERT INTO `players` VALUES ('124', '6', 'Вяльцев', 'Егор', '1985-10-10', '1', '2', '193', '88', '/images/player_avatars/vyalzev.jpg');
INSERT INTO `players` VALUES ('142', '7', 'Патеев', 'Руслан', '1990-04-25', '1', '1', '212', '111', '/images/player_avatars/pateev.jpg');
INSERT INTO `players` VALUES ('147', '11', 'Ильницкий', 'Станислав', '1994-02-24', '1', '1', '200', '98', '/images/player_avatars/ilnickiy.jpg');
INSERT INTO `players` VALUES ('155', '2', 'Ханникатт', 'Тайлер', '1990-07-15', '2', '1', '203', '90', '/images/player_avatars/channicat.jpg');
INSERT INTO `players` VALUES ('156', '10', 'Соколов', 'Дмитрий', '1985-01-21', '1', '3', '214', '115', '/images/player_avatars/sokolov.jpg');
INSERT INTO `players` VALUES ('157', '19', 'Тодорович', 'Марко', '1992-04-19', '0', '3', '210', '111', '/images/player_avatars/todorovich.jpg');
INSERT INTO `players` VALUES ('161', '16', 'Якушкин', 'Тимофей', '1997-01-16', '1', '2', '194', '82', '/images/player_avatars/yakushin.jpg');
INSERT INTO `players` VALUES ('162', '2', 'Браун', 'Маркел', '1992-01-29', '2', '2', '191', '84', '/images/player_avatars/brown.jpg');
INSERT INTO `players` VALUES ('163', '16', 'Бунго-Коло', 'Нобель', '1988-04-26', '0', '1', '203', '90', '/images/player_avatars/bungo-kolo.jpg');
INSERT INTO `players` VALUES ('164', '0', 'Джонс', 'Перри', '1991-09-24', '2', '1', '211', '106', '/images/player_avatars/jones.jpg');
INSERT INTO `players` VALUES ('165', '0', 'Картер', 'Джастин', '1987-04-21', '0', '0', '193', '91', null);
INSERT INTO `players` VALUES ('166', '13', 'Лиходей', 'Валерий', '1986-10-23', '1', '1', '204', '100', '/images/player_avatars/lichodey.jpg');
INSERT INTO `players` VALUES ('167', '0', 'Пуллен', 'Джейкоб', '1989-11-10', '0', '2', '185', '91', '/images/player_avatars/pullen.jpg');
INSERT INTO `players` VALUES ('168', '22', 'Роуленд', 'Эрл', '1983-05-18', '2', '2', '188', '86', '/images/player_avatars/rowland.jpg');
INSERT INTO `players` VALUES ('169', '6', 'Хаммел', 'Робби', '1989-03-08', '2', '1', '206', '99', '/images/player_avatars/hammel.jpg');
INSERT INTO `players` VALUES ('170', '21', 'Эванс', 'Джереми', '1987-10-24', '2', '3', '206', '91', '/images/player_avatars/evans.jpg');
INSERT INTO `players` VALUES ('171', '22', 'Дженкинс', 'Чарльз', '1989-02-28', '2', '2', '191', '100', '/images/player_avatars/jenkins.jpg');
INSERT INTO `players` VALUES ('172', '9', 'Маркович', 'Стефан', '1988-04-25', '3', '2', '199', '98', '/images/player_avatars/markovich.jpg');
INSERT INTO `players` VALUES ('173', '21', 'Андерсон', 'Джеймс', '1989-03-25', '2', '0', '198', '98', '/images/player_avatars/anderson.jpg');
INSERT INTO `players` VALUES ('174', '20', 'Зубков', 'Андрей', '1991-06-29', '1', '1', '205', '100', '/images/player_avatars/zubkov.jpg');
INSERT INTO `players` VALUES ('175', '13', 'Гилл', 'Энтони', '1992-10-17', '2', '1', '203', '104', '/images/player_avatars/gill.jpg');
INSERT INTO `players` VALUES ('176', '23', 'Томас', 'Малькольм', '1988-11-08', '2', '1', '206', '102', '/images/player_avatars/tomas.jpg');
INSERT INTO `players` VALUES ('177', '25', 'Ткаченко', 'Максим', '1992-01-16', '1', '1', '185', '85', '');
INSERT INTO `players` VALUES ('178', '27', 'Прощенко', 'Максим', '1997-04-25', '1', '1', '208', '90', '/images/player_avatars/proshenko.jpg');
INSERT INTO `players` VALUES ('179', '0', 'Робинсон', 'Томас', '1991-03-17', '2', '3', '208', '108', '/images/player_avatars/robinson.jpg');
INSERT INTO `players` VALUES ('181', '3', 'Бост', 'Ди', '1989-10-12', '2', '2', '188', '80', '/images/player_avatars/');
INSERT INTO `players` VALUES ('182', '5', 'Крокер', 'Тони', '1987-01-17', '2', '1', '198', '98', '/images/player_avatars/');
INSERT INTO `players` VALUES ('183', '7', 'Грин', 'Гарлон', '1991-01-11', '2', '1', '201', '98', '');
INSERT INTO `players` VALUES ('184', '10', 'Прэтер', 'Кейси', '1991-05-29', '2', '2', '198', '96', null);
INSERT INTO `players` VALUES ('185', '15', 'Губанов', 'Петр', '1987-04-03', '1', '3', '207', '103', null);
INSERT INTO `players` VALUES ('186', '25', 'Мики', 'Джордан', '1994-07-09', '2', '1', '203', '107', null);
SET FOREIGN_KEY_CHECKS=1;

/*
Navicat MySQL Data Transfer

Source Server         : Stat-origin
Source Server Version : 50643
Source Host           : VH247.spaceweb.ru:3306
Source Database       : ivanshiru_stat

Target Server Type    : MYSQL
Target Server Version : 50643
File Encoding         : 65001

Date: 2019-08-01 23:31:02
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for tournaments
-- ----------------------------
DROP TABLE IF EXISTS `tournaments`;
CREATE TABLE `tournaments` (
  `tournament_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT 'Название турнира',
  PRIMARY KEY (`tournament_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='Список турниров';

-- ----------------------------
-- Records of tournaments
-- ----------------------------
INSERT INTO `tournaments` VALUES ('1', 'Единая Лига ВТБ');
INSERT INTO `tournaments` VALUES ('2', 'Евролига');
INSERT INTO `tournaments` VALUES ('3', 'Еврокубок');
INSERT INTO `tournaments` VALUES ('4', 'ПБЛ');
INSERT INTO `tournaments` VALUES ('5', 'Чемпионат России');
INSERT INTO `tournaments` VALUES ('6', 'Кубок вызова');
INSERT INTO `tournaments` VALUES ('7', 'Кубок России');
INSERT INTO `tournaments` VALUES ('8', 'Высшая лига');
INSERT INTO `tournaments` VALUES ('9', 'Кубок Корача');
INSERT INTO `tournaments` VALUES ('10', 'Кубок ФИБА Европа');
SET FOREIGN_KEY_CHECKS=1;

/*
Navicat MySQL Data Transfer

Source Server         : Stat-origin
Source Server Version : 50643
Source Host           : VH247.spaceweb.ru:3306
Source Database       : ivanshiru_stat

Target Server Type    : MYSQL
Target Server Version : 50643
File Encoding         : 65001

Date: 2019-08-01 23:30:20
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for seasons
-- ----------------------------
DROP TABLE IF EXISTS `seasons`;
CREATE TABLE `seasons` (
  `season_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT 'Дата сезона',
  PRIMARY KEY (`season_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='Список сезонов';

-- ----------------------------
-- Records of seasons
-- ----------------------------
INSERT INTO `seasons` VALUES ('16', '2016-2017');
INSERT INTO `seasons` VALUES ('17', '2017-2018');
SET FOREIGN_KEY_CHECKS=1;

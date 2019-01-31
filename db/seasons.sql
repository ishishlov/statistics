/*
Navicat MySQL Data Transfer

Source Server         : statistics
Source Server Version : 50638
Source Host           : localhost:3306
Source Database       : statistics

Target Server Type    : MYSQL
Target Server Version : 50638
File Encoding         : 65001

Date: 2019-01-31 22:45:36
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
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COMMENT='Список сезонов';

-- ----------------------------
-- Records of seasons
-- ----------------------------
INSERT INTO `seasons` VALUES ('10', '2010-2011');
INSERT INTO `seasons` VALUES ('11', '2011-2012');
INSERT INTO `seasons` VALUES ('12', '2012-2013');
INSERT INTO `seasons` VALUES ('13', '2013-2014');
INSERT INTO `seasons` VALUES ('14', '2014-2015');
INSERT INTO `seasons` VALUES ('15', '2015-2016');
INSERT INTO `seasons` VALUES ('16', '2016-2017');
INSERT INTO `seasons` VALUES ('17', '2017-2018');
INSERT INTO `seasons` VALUES ('18', '2018-2019');
INSERT INTO `seasons` VALUES ('19', '2019-2020');
INSERT INTO `seasons` VALUES ('20', '2020-2021');
INSERT INTO `seasons` VALUES ('21', '2021-2022');
INSERT INTO `seasons` VALUES ('22', '2022-2023');
INSERT INTO `seasons` VALUES ('23', '2023-2024');
INSERT INTO `seasons` VALUES ('24', '2024-2025');
INSERT INTO `seasons` VALUES ('25', '2025-2026');
INSERT INTO `seasons` VALUES ('26', '2026-2027');
INSERT INTO `seasons` VALUES ('27', '2027-2028');
INSERT INTO `seasons` VALUES ('28', '2028-2029');
INSERT INTO `seasons` VALUES ('29', '2029-2030');
INSERT INTO `seasons` VALUES ('30', '2030-2031');

/*
Navicat MySQL Data Transfer

Source Server         : statistics
Source Server Version : 50638
Source Host           : localhost:3306
Source Database       : statistics

Target Server Type    : MYSQL
Target Server Version : 50638
File Encoding         : 65001

Date: 2019-04-09 22:58:55
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for countries
-- ----------------------------
DROP TABLE IF EXISTS `countries`;
CREATE TABLE `countries` (
  `country_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `logo_src` varchar(255) NOT NULL COMMENT 'Название команды',
  `alpha` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`country_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Список команд';

-- ----------------------------
-- Records of countries
-- ----------------------------
INSERT INTO `countries` VALUES ('1', '/images/country_logos/ru.gif', 'RU', 'Россия');
INSERT INTO `countries` VALUES ('2', '/images/country_logos/us.gif', 'US', 'США');
INSERT INTO `countries` VALUES ('3', '/images/country_logos/rs.gif', 'RS', 'Сербия');

/*
Navicat MySQL Data Transfer

Source Server         : Stat-origin
Source Server Version : 50643
Source Host           : VH247.spaceweb.ru:3306
Source Database       : ivanshiru_stat

Target Server Type    : MYSQL
Target Server Version : 50643
File Encoding         : 65001

Date: 2019-08-01 23:29:25
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
SET FOREIGN_KEY_CHECKS=1;

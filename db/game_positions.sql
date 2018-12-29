/*
Navicat MySQL Data Transfer

Source Server         : statistics
Source Server Version : 50638
Source Host           : localhost:3306
Source Database       : statistics

Target Server Type    : MYSQL
Target Server Version : 50638
File Encoding         : 65001

Date: 2018-12-29 23:28:11
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for game_positions
-- ----------------------------
DROP TABLE IF EXISTS `game_positions`;
CREATE TABLE `game_positions` (
  `game_position_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT 'Название позиции',
  PRIMARY KEY (`game_position_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COMMENT='Список сезонов';

-- ----------------------------
-- Records of game_positions
-- ----------------------------
INSERT INTO `game_positions` VALUES ('1', 'Форвард');
INSERT INTO `game_positions` VALUES ('2', 'Защитник');
INSERT INTO `game_positions` VALUES ('3', 'Центровой');
SET FOREIGN_KEY_CHECKS=1;

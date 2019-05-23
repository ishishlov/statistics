/*
Navicat MySQL Data Transfer

Source Server         : originstatistic
Source Server Version : 50643
Source Host           : VH247.spaceweb.ru:3306
Source Database       : ivanshiru_stat

Target Server Type    : MYSQL
Target Server Version : 50643
File Encoding         : 65001

Date: 2019-05-23 21:48:20
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Список сезонов';

-- ----------------------------
-- Records of game_positions
-- ----------------------------
INSERT INTO `game_positions` VALUES ('1', 'Форвард');
INSERT INTO `game_positions` VALUES ('2', 'Защитник');
INSERT INTO `game_positions` VALUES ('3', 'Центровой');

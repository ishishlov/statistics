/*
Navicat MySQL Data Transfer

Source Server         : originstatistic
Source Server Version : 50643
Source Host           : VH247.spaceweb.ru:3306
Source Database       : ivanshiru_stat

Target Server Type    : MYSQL
Target Server Version : 50643
File Encoding         : 65001

Date: 2019-05-23 21:48:34
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for history
-- ----------------------------
DROP TABLE IF EXISTS `history`;
CREATE TABLE `history` (
  `history_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `team_id_one` int(10) unsigned NOT NULL,
  `team_id_two` int(10) unsigned NOT NULL,
  `dt` date NOT NULL DEFAULT '1901-01-01',
  `score_one` smallint(5) unsigned NOT NULL,
  `score_two` smallint(5) unsigned NOT NULL,
  `tournament_id` int(10) unsigned NOT NULL COMMENT 'Id турнира. Ссылка на поле tournament_id из tournaments',
  `season_id` tinyint(3) unsigned NOT NULL COMMENT 'Id сезона. Ссылка на поле season_id из seasons',
  PRIMARY KEY (`history_id`)
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8 COMMENT='Список сезонов';

-- ----------------------------
-- Records of history
-- ----------------------------
INSERT INTO `history` VALUES ('54', '31', '7', '2018-04-17', '98', '95', '2', '17');
INSERT INTO `history` VALUES ('55', '23', '25', '2018-04-17', '96', '67', '2', '17');
INSERT INTO `history` VALUES ('56', '28', '6', '2018-04-18', '82', '73', '2', '17');
INSERT INTO `history` VALUES ('57', '22', '15', '2018-04-18', '78', '87', '2', '17');
INSERT INTO `history` VALUES ('58', '31', '7', '2018-04-19', '89', '84', '2', '17');
INSERT INTO `history` VALUES ('59', '23', '25', '2018-04-19', '82', '89', '2', '17');
INSERT INTO `history` VALUES ('60', '28', '6', '2018-04-20', '95', '89', '2', '17');
INSERT INTO `history` VALUES ('61', '22', '15', '2018-04-20', '79', '68', '2', '17');
INSERT INTO `history` VALUES ('62', '15', '22', '2018-04-24', '80', '60', '2', '17');
INSERT INTO `history` VALUES ('63', '6', '28', '2018-04-24', '88', '83', '2', '17');
INSERT INTO `history` VALUES ('64', '25', '23', '2018-04-25', '81', '74', '2', '17');
INSERT INTO `history` VALUES ('65', '7', '31', '2018-04-25', '79', '73', '2', '17');
INSERT INTO `history` VALUES ('66', '15', '22', '2018-04-26', '101', '91', '2', '17');
INSERT INTO `history` VALUES ('67', '6', '28', '2018-04-26', '83', '92', '2', '17');
INSERT INTO `history` VALUES ('68', '7', '31', '2018-04-27', '88', '89', '2', '17');
INSERT INTO `history` VALUES ('69', '25', '23', '2018-04-27', '89', '82', '2', '17');
INSERT INTO `history` VALUES ('70', '28', '15', '2018-05-18', '76', '67', '2', '17');
INSERT INTO `history` VALUES ('71', '31', '25', '2018-05-18', '76', '67', '2', '17');
INSERT INTO `history` VALUES ('72', '31', '15', '2018-05-20', '77', '79', '2', '17');
INSERT INTO `history` VALUES ('73', '25', '28', '2018-05-20', '85', '80', '2', '17');
INSERT INTO `history` VALUES ('74', '18', '7', '2018-05-23', '66', '79', '1', '17');
INSERT INTO `history` VALUES ('75', '27', '21', '2018-05-23', '84', '66', '1', '17');
INSERT INTO `history` VALUES ('76', '16', '1', '2018-05-24', '91', '80', '1', '17');
INSERT INTO `history` VALUES ('77', '11', '31', '2018-05-24', '83', '112', '1', '17');
INSERT INTO `history` VALUES ('78', '7', '18', '2018-05-26', '77', '72', '1', '17');
INSERT INTO `history` VALUES ('79', '21', '27', '2018-05-26', '77', '74', '1', '17');
INSERT INTO `history` VALUES ('80', '1', '16', '2018-05-27', '73', '79', '1', '17');
INSERT INTO `history` VALUES ('81', '31', '11', '2018-05-27', '100', '80', '1', '17');
INSERT INTO `history` VALUES ('82', '7', '18', '2018-05-28', '86', '73', '1', '17');
INSERT INTO `history` VALUES ('83', '21', '27', '2018-05-28', '94', '95', '1', '17');
INSERT INTO `history` VALUES ('84', '1', '16', '2018-05-29', '78', '90', '1', '17');
INSERT INTO `history` VALUES ('85', '31', '11', '2018-05-29', '99', '73', '1', '17');
INSERT INTO `history` VALUES ('86', '27', '21', '2018-05-31', '101', '86', '1', '17');
INSERT INTO `history` VALUES ('87', '31', '16', '2018-06-08', '84', '67', '1', '17');
INSERT INTO `history` VALUES ('88', '27', '7', '2018-06-08', '71', '76', '1', '17');
INSERT INTO `history` VALUES ('89', '27', '16', '2018-06-10', '79', '93', '1', '17');
INSERT INTO `history` VALUES ('90', '31', '7', '2018-06-10', '95', '84', '1', '17');

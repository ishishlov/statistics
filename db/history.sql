/*
Navicat MySQL Data Transfer

Source Server         : Stat-origin
Source Server Version : 50643
Source Host           : VH247.spaceweb.ru:3306
Source Database       : ivanshiru_stat

Target Server Type    : MYSQL
Target Server Version : 50643
File Encoding         : 65001

Date: 2019-08-01 23:29:48
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
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=utf8 COMMENT='Список сезонов';

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
INSERT INTO `history` VALUES ('91', '16', '11', '2017-05-01', '93', '81', '1', '16');
INSERT INTO `history` VALUES ('92', '16', '11', '2017-05-03', '79', '74', '1', '16');
INSERT INTO `history` VALUES ('93', '7', '14', '2017-05-04', '91', '84', '1', '16');
INSERT INTO `history` VALUES ('94', '31', '3', '2017-05-05', '77', '54', '1', '16');
INSERT INTO `history` VALUES ('95', '18', '27', '2017-05-05', '62', '71', '1', '16');
INSERT INTO `history` VALUES ('96', '11', '16', '2017-05-06', '51', '92', '1', '16');
INSERT INTO `history` VALUES ('97', '7', '14', '2017-05-06', '109', '81', '1', '16');
INSERT INTO `history` VALUES ('98', '31', '3', '2017-05-07', '94', '74', '1', '16');
INSERT INTO `history` VALUES ('99', '18', '27', '2017-05-07', '92', '76', '1', '16');
INSERT INTO `history` VALUES ('100', '14', '7', '2017-05-09', '68', '89', '1', '16');
INSERT INTO `history` VALUES ('101', '27', '18', '2017-05-10', '71', '83', '1', '16');
INSERT INTO `history` VALUES ('102', '3', '31', '2017-05-10', '73', '91', '1', '16');
INSERT INTO `history` VALUES ('103', '27', '18', '2017-05-12', '79', '84', '1', '16');
INSERT INTO `history` VALUES ('104', '16', '7', '2017-05-25', '99', '95', '1', '16');
INSERT INTO `history` VALUES ('105', '31', '18', '2017-05-26', '101', '95', '1', '16');
INSERT INTO `history` VALUES ('106', '16', '7', '2017-05-27', '92', '89', '1', '16');
INSERT INTO `history` VALUES ('107', '31', '18', '2017-05-28', '84', '71', '1', '16');
INSERT INTO `history` VALUES ('108', '7', '16', '2017-05-30', '97', '73', '1', '16');
INSERT INTO `history` VALUES ('109', '18', '31', '2017-05-31', '66', '74', '1', '16');
INSERT INTO `history` VALUES ('110', '7', '16', '2017-06-01', '73', '71', '1', '16');
INSERT INTO `history` VALUES ('111', '16', '7', '2017-06-04', '84', '90', '1', '16');
INSERT INTO `history` VALUES ('112', '31', '7', '2017-06-08', '94', '88', '1', '16');
INSERT INTO `history` VALUES ('113', '31', '7', '2017-06-10', '99', '79', '1', '16');
INSERT INTO `history` VALUES ('114', '7', '31', '2017-06-13', '72', '95', '1', '16');
INSERT INTO `history` VALUES ('115', '18', '16', '2017-02-28', '75', '52', '3', '16');
INSERT INTO `history` VALUES ('116', '38', '12', '2017-02-28', '87', '67', '3', '16');
INSERT INTO `history` VALUES ('117', '4', '26', '2017-02-28', '91', '82', '3', '16');
INSERT INTO `history` VALUES ('118', '10', '7', '2017-02-28', '88', '82', '3', '16');
INSERT INTO `history` VALUES ('119', '7', '10', '2017-03-03', '98', '74', '3', '16');
INSERT INTO `history` VALUES ('120', '16', '18', '2017-03-03', '77', '88', '3', '16');
INSERT INTO `history` VALUES ('121', '26', '4', '2017-03-03', '82', '67', '3', '16');
INSERT INTO `history` VALUES ('122', '12', '38', '2017-03-03', '79', '85', '3', '16');
INSERT INTO `history` VALUES ('123', '4', '26', '2017-03-08', '69', '74', '3', '16');
INSERT INTO `history` VALUES ('124', '10', '7', '2017-03-08', '92', '76', '3', '16');
INSERT INTO `history` VALUES ('125', '18', '26', '2017-03-14', '57', '73', '3', '16');
INSERT INTO `history` VALUES ('126', '10', '38', '2017-03-14', '83', '68', '3', '16');
INSERT INTO `history` VALUES ('127', '38', '10', '2017-03-17', '79', '66', '3', '16');
INSERT INTO `history` VALUES ('128', '26', '18', '2017-03-17', '74', '63', '3', '16');
INSERT INTO `history` VALUES ('129', '10', '38', '2017-03-22', '90', '75', '3', '16');
INSERT INTO `history` VALUES ('130', '10', '26', '2017-03-28', '68', '62', '3', '16');
INSERT INTO `history` VALUES ('131', '26', '10', '2017-03-31', '79', '71', '3', '16');
INSERT INTO `history` VALUES ('132', '10', '26', '2017-04-05', '58', '63', '3', '16');
SET FOREIGN_KEY_CHECKS=1;

/*
Navicat MySQL Data Transfer

Source Server         : statistics
Source Server Version : 50638
Source Host           : localhost:3306
Source Database       : statistics

Target Server Type    : MYSQL
Target Server Version : 50638
File Encoding         : 65001

Date: 2019-05-12 21:30:29
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
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COMMENT='Список сезонов';

-- ----------------------------
-- Records of history
-- ----------------------------
INSERT INTO `history` VALUES ('31', '2', '4', '2019-05-01', '50', '65', '1', '17');
INSERT INTO `history` VALUES ('33', '5', '6', '2019-05-02', '43', '50', '2', '17');
INSERT INTO `history` VALUES ('34', '12', '13', '2019-05-05', '34', '65', '2', '17');
INSERT INTO `history` VALUES ('35', '19', '20', '2019-05-04', '66', '12', '1', '17');
INSERT INTO `history` VALUES ('36', '25', '28', '2019-05-03', '52', '99', '1', '17');

/*
Navicat MySQL Data Transfer

Source Server         : openserver
Source Server Version : 50638
Source Host           : localhost:3306
Source Database       : statistics

Target Server Type    : MYSQL
Target Server Version : 50638
File Encoding         : 65001

Date: 2019-01-08 11:34:12
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for statistic_games
-- ----------------------------
DROP TABLE IF EXISTS `statistic_games`;
CREATE TABLE `statistic_games` (
  `game_id` int(10) unsigned NOT NULL,
  `dt` date NOT NULL DEFAULT '1901-01-01' COMMENT 'Дата проведения',
  `tournament_id` int(10) unsigned NOT NULL COMMENT 'Id турнира. Ссылка на поле tournament_id из tournaments',
  `team_id` int(10) unsigned NOT NULL COMMENT 'Id команды. Ссылка на team_id из teams',
  `venue` bit(1) NOT NULL COMMENT 'Место проведения. 1 - дом, 0 - гость',
  `season_id` tinyint(3) NOT NULL COMMENT 'Id сезона. Ссылка на поле season_id из seasons',
  `score` varchar(9) NOT NULL COMMENT 'Счет',
  `status` tinyint(3) NOT NULL COMMENT 'Статус подтверждения протокола. 1 - подтвержден, 2 - не подтвержден',
  PRIMARY KEY (`game_id`),
  KEY `tournament_id_season_id` (`tournament_id`,`season_id`),
  KEY `season_id` (`season_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Статистика игр';

-- ----------------------------
-- Records of statistic_games
-- ----------------------------
INSERT INTO `statistic_games` VALUES ('1046', '2019-01-09', '2', '15', '\0', '16', '72:81', '1');
INSERT INTO `statistic_games` VALUES ('1047', '2019-01-23', '2', '20', '\0', '16', '66:69', '1');
INSERT INTO `statistic_games` VALUES ('1048', '2019-01-02', '2', '2', '\0', '16', '55:65', '1');
INSERT INTO `statistic_games` VALUES ('1049', '2019-01-03', '1', '12', '\0', '16', '55:65', '1');
INSERT INTO `statistic_games` VALUES ('1050', '2017-10-01', '1', '4', '', '17', '76:68', '1');
INSERT INTO `statistic_games` VALUES ('1051', '2017-10-02', '1', '6', '\0', '17', '70:95', '1');
INSERT INTO `statistic_games` VALUES ('1052', '2017-10-03', '2', '31', '', '17', '35:36', '1');
INSERT INTO `statistic_games` VALUES ('1053', '2017-10-05', '1', '28', '', '17', '66:72', '1');
INSERT INTO `statistic_games` VALUES ('1054', '2017-10-07', '1', '13', '\0', '17', '70:45', '1');
INSERT INTO `statistic_games` VALUES ('1055', '2017-10-10', '1', '22', '\0', '17', '46:40', '1');
INSERT INTO `statistic_games` VALUES ('1056', '2017-10-12', '1', '23', '\0', '17', '68:69', '1');
INSERT INTO `statistic_games` VALUES ('1057', '2017-10-15', '2', '25', '', '17', '50:59', '1');
INSERT INTO `statistic_games` VALUES ('1058', '2017-10-15', '2', '5', '', '17', '50:59', '1');
SET FOREIGN_KEY_CHECKS=1;

/*
Navicat MySQL Data Transfer

Source Server         : statistics
Source Server Version : 50638
Source Host           : localhost:3306
Source Database       : statistics

Target Server Type    : MYSQL
Target Server Version : 50638
File Encoding         : 65001

Date: 2018-12-29 23:28:51
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
  KEY `tournament_id_season_id` (`tournament_id`,`season_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Статистика игр';

-- ----------------------------
-- Records of statistic_games
-- ----------------------------
INSERT INTO `statistic_games` VALUES ('1050', '2017-10-01', '2', '24', '', '17', '76:68', '1');
INSERT INTO `statistic_games` VALUES ('1051', '2017-10-02', '1', '11', '\0', '17', '70:95', '1');
INSERT INTO `statistic_games` VALUES ('1052', '2017-10-03', '2', '21', '', '17', '35:36', '1');
INSERT INTO `statistic_games` VALUES ('1053', '2017-10-05', '1', '23', '', '17', '66:72', '1');
INSERT INTO `statistic_games` VALUES ('1054', '2017-10-07', '2', '15', '\0', '17', '70:45', '1');
INSERT INTO `statistic_games` VALUES ('1055', '2017-10-10', '1', '1', '\0', '17', '46:40', '1');
INSERT INTO `statistic_games` VALUES ('1056', '2017-10-12', '2', '26', '\0', '17', '68:69', '1');
INSERT INTO `statistic_games` VALUES ('1057', '2017-10-15', '1', '24', '', '17', '50:59', '1');
SET FOREIGN_KEY_CHECKS=1;

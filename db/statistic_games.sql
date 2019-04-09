/*
Navicat MySQL Data Transfer

Source Server         : statistics
Source Server Version : 50638
Source Host           : localhost:3306
Source Database       : statistics

Target Server Type    : MYSQL
Target Server Version : 50638
File Encoding         : 65001

Date: 2019-04-09 22:59:20
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
INSERT INTO `statistic_games` VALUES ('1057', '2017-10-05', '1', '29', '', '17', '83:55', '1');
INSERT INTO `statistic_games` VALUES ('1058', '2017-10-09', '1', '11', '\0', '17', '104:64', '1');
INSERT INTO `statistic_games` VALUES ('1059', '2017-10-13', '2', '10', '', '17', '75:70', '1');
INSERT INTO `statistic_games` VALUES ('1060', '2017-10-16', '1', '24', '\0', '17', '106:69', '1');
INSERT INTO `statistic_games` VALUES ('1061', '2017-10-20', '2', '15', '', '17', '85:77', '1');
INSERT INTO `statistic_games` VALUES ('1062', '2017-10-24', '2', '30', '', '17', '85:78', '1');
INSERT INTO `statistic_games` VALUES ('1063', '2017-10-26', '2', '22', '\0', '17', '75:92', '1');
INSERT INTO `statistic_games` VALUES ('1064', '2017-10-30', '1', '3', '', '17', '72:71', '1');
INSERT INTO `statistic_games` VALUES ('1065', '2017-11-02', '2', '25', '\0', '17', '86:80', '1');
INSERT INTO `statistic_games` VALUES ('1066', '2017-11-06', '1', '31', '', '17', '81:96', '1');
INSERT INTO `statistic_games` VALUES ('1067', '2017-11-10', '2', '6', '', '17', '91:90', '1');
INSERT INTO `statistic_games` VALUES ('1068', '2017-11-14', '2', '23', '\0', '17', '65:93', '1');
INSERT INTO `statistic_games` VALUES ('1069', '2017-11-16', '2', '19', '', '17', '69:77', '1');
INSERT INTO `statistic_games` VALUES ('1070', '2017-11-19', '1', '16', '', '17', '66:76', '1');
INSERT INTO `statistic_games` VALUES ('1071', '2017-11-24', '2', '28', '\0', '17', '67:71', '1');
INSERT INTO `statistic_games` VALUES ('1072', '2017-11-30', '2', '8', '', '17', '82:73', '1');
INSERT INTO `statistic_games` VALUES ('1073', '2017-12-03', '1', '27', '\0', '17', '79:80', '1');
INSERT INTO `statistic_games` VALUES ('1074', '2017-12-07', '2', '20', '\0', '17', '77:71', '1');
INSERT INTO `statistic_games` VALUES ('1075', '2017-12-10', '1', '21', '', '17', '90:87', '1');
INSERT INTO `statistic_games` VALUES ('1076', '2017-12-14', '2', '26', '\0', '17', '84:93', '1');
INSERT INTO `statistic_games` VALUES ('1077', '2017-12-20', '2', '2', '', '17', '86:68', '1');
INSERT INTO `statistic_games` VALUES ('1078', '2017-12-22', '2', '31', '\0', '17', '68:79', '1');
INSERT INTO `statistic_games` VALUES ('1079', '2017-12-26', '1', '14', '', '17', '92:62', '1');
INSERT INTO `statistic_games` VALUES ('1080', '2017-12-29', '2', '5', '', '17', '65:79', '1');
INSERT INTO `statistic_games` VALUES ('1081', '2018-01-05', '2', '8', '\0', '17', '74:70', '1');
INSERT INTO `statistic_games` VALUES ('1082', '2018-01-07', '1', '17', '\0', '17', '84:92', '1');
INSERT INTO `statistic_games` VALUES ('1083', '2018-01-12', '2', '25', '', '17', '78:95', '1');
INSERT INTO `statistic_games` VALUES ('1084', '2018-01-16', '2', '30', '\0', '17', '79:70', '1');
INSERT INTO `statistic_games` VALUES ('1085', '2018-01-18', '2', '22', '', '17', '82:54', '1');
INSERT INTO `statistic_games` VALUES ('1086', '2018-01-21', '1', '18', '\0', '17', '78:93', '1');
INSERT INTO `statistic_games` VALUES ('1087', '2018-01-26', '2', '10', '\0', '17', '83:85', '1');
INSERT INTO `statistic_games` VALUES ('1088', '2018-01-29', '1', '1', '', '17', '88:75', '1');
INSERT INTO `statistic_games` VALUES ('1089', '2018-02-02', '2', '26', '', '17', '68:66', '1');
INSERT INTO `statistic_games` VALUES ('1090', '2018-02-05', '1', '31', '\0', '17', '71:90', '1');
INSERT INTO `statistic_games` VALUES ('1091', '2018-02-09', '2', '15', '\0', '17', '84:76', '1');
INSERT INTO `statistic_games` VALUES ('1092', '2018-02-12', '1', '11', '', '17', '73:77', '1');
INSERT INTO `statistic_games` VALUES ('1093', '2018-02-15', '1', '16', '\0', '17', '98:80', '1');
INSERT INTO `statistic_games` VALUES ('1094', '2018-02-23', '2', '23', '', '17', '78:61', '1');
INSERT INTO `statistic_games` VALUES ('1095', '2018-03-01', '2', '6', '\0', '17', '77:87', '1');
INSERT INTO `statistic_games` VALUES ('1096', '2018-03-04', '1', '21', '\0', '17', '82:79', '1');
INSERT INTO `statistic_games` VALUES ('1097', '2018-03-08', '2', '20', '', '17', '77:86', '1');
INSERT INTO `statistic_games` VALUES ('1098', '2018-03-11', '1', '3', '\0', '17', '79:84', '1');
INSERT INTO `statistic_games` VALUES ('1099', '2018-03-15', '2', '19', '\0', '17', '94:91', '1');
INSERT INTO `statistic_games` VALUES ('1100', '2018-03-21', '2', '2', '\0', '17', '85:73', '1');
INSERT INTO `statistic_games` VALUES ('1101', '2018-03-23', '2', '31', '', '17', '73:90', '1');
INSERT INTO `statistic_games` VALUES ('1102', '2018-03-26', '1', '27', '', '17', '80:83', '1');
INSERT INTO `statistic_games` VALUES ('1103', '2018-03-29', '2', '28', '', '17', '64:73', '1');
INSERT INTO `statistic_games` VALUES ('1104', '2018-04-01', '1', '17', '', '17', '96:85', '1');
INSERT INTO `statistic_games` VALUES ('1105', '2018-04-05', '2', '5', '\0', '17', '82:86', '1');
INSERT INTO `statistic_games` VALUES ('1106', '2018-04-09', '1', '24', '', '17', '90:87', '1');
INSERT INTO `statistic_games` VALUES ('1107', '2018-04-12', '1', '29', '\0', '17', '82:79', '1');
INSERT INTO `statistic_games` VALUES ('1108', '2018-04-17', '2', '31', '\0', '17', '95:98', '1');
INSERT INTO `statistic_games` VALUES ('1109', '2018-04-19', '2', '31', '\0', '17', '84:89', '1');
INSERT INTO `statistic_games` VALUES ('1110', '2018-04-25', '2', '31', '', '17', '79:73', '1');
INSERT INTO `statistic_games` VALUES ('1111', '2018-04-27', '2', '31', '', '17', '88:89', '1');
INSERT INTO `statistic_games` VALUES ('1112', '2018-05-05', '1', '1', '\0', '17', '92:104', '1');
INSERT INTO `statistic_games` VALUES ('1113', '2018-05-09', '1', '18', '', '17', '83:90', '1');
INSERT INTO `statistic_games` VALUES ('1114', '2018-05-12', '1', '14', '\0', '17', '89:84', '1');
INSERT INTO `statistic_games` VALUES ('1115', '2018-05-23', '1', '18', '\0', '17', '79:66', '1');
INSERT INTO `statistic_games` VALUES ('1116', '2018-05-26', '1', '18', '', '17', '77:72', '1');
INSERT INTO `statistic_games` VALUES ('1117', '2018-05-28', '1', '18', '', '17', '86:73', '1');
INSERT INTO `statistic_games` VALUES ('1118', '2018-06-08', '1', '27', '\0', '17', '76:71', '1');
INSERT INTO `statistic_games` VALUES ('1119', '2018-06-10', '1', '31', '\0', '17', '84:95', '1');

/*
Navicat MySQL Data Transfer

Source Server         : Stat-origin
Source Server Version : 50643
Source Host           : VH247.spaceweb.ru:3306
Source Database       : ivanshiru_stat

Target Server Type    : MYSQL
Target Server Version : 50643
File Encoding         : 65001

Date: 2019-08-01 23:30:29
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
  `venue` tinyint(3) NOT NULL COMMENT 'Место проведения. 1 - дом, 0 - гость',
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
INSERT INTO `statistic_games` VALUES ('1005', '2016-10-08', '1', '11', '1', '16', '73:76', '1');
INSERT INTO `statistic_games` VALUES ('1006', '2016-10-12', '3', '35', '1', '16', '76:71', '1');
INSERT INTO `statistic_games` VALUES ('1007', '2016-10-19', '3', '37', '0', '16', '85:89', '1');
INSERT INTO `statistic_games` VALUES ('1008', '2016-10-23', '1', '18', '1', '16', '73:65', '1');
INSERT INTO `statistic_games` VALUES ('1009', '2016-10-26', '3', '32', '0', '16', '102:72', '1');
INSERT INTO `statistic_games` VALUES ('1010', '2016-11-06', '1', '27', '1', '16', '87:70', '1');
INSERT INTO `statistic_games` VALUES ('1011', '2016-11-09', '3', '33', '0', '16', '91:72', '1');
INSERT INTO `statistic_games` VALUES ('1012', '2016-11-13', '1', '14', '1', '16', '72:64', '1');
INSERT INTO `statistic_games` VALUES ('1013', '2016-11-16', '3', '35', '0', '16', '91:93', '1');
INSERT INTO `statistic_games` VALUES ('1014', '2016-11-20', '1', '21', '1', '16', '90:84', '1');
INSERT INTO `statistic_games` VALUES ('1015', '2016-11-23', '3', '37', '1', '16', '96:84', '1');
INSERT INTO `statistic_games` VALUES ('1016', '2016-11-27', '1', '29', '0', '16', '77:73', '1');
INSERT INTO `statistic_games` VALUES ('1017', '2016-11-30', '3', '32', '1', '16', '88:77', '1');
INSERT INTO `statistic_games` VALUES ('1018', '2016-12-03', '1', '1', '1', '16', '102:70', '1');
INSERT INTO `statistic_games` VALUES ('1019', '2016-12-10', '1', '24', '1', '16', '92:66', '1');
INSERT INTO `statistic_games` VALUES ('1020', '2016-12-14', '3', '33', '1', '16', '99:78', '1');
INSERT INTO `statistic_games` VALUES ('1021', '2016-12-18', '1', '31', '0', '16', '79:95', '1');
INSERT INTO `statistic_games` VALUES ('1022', '2016-12-22', '1', '17', '0', '16', '84:77', '1');
INSERT INTO `statistic_games` VALUES ('1023', '2017-01-04', '3', '34', '1', '16', '88:80', '1');
INSERT INTO `statistic_games` VALUES ('1024', '2017-01-08', '1', '16', '0', '16', '110:114', '1');
INSERT INTO `statistic_games` VALUES ('1025', '2017-01-11', '3', '4', '0', '16', '74:90', '1');
INSERT INTO `statistic_games` VALUES ('1026', '2017-01-15', '1', '3', '1', '16', '83:66', '1');
INSERT INTO `statistic_games` VALUES ('1027', '2017-01-18', '3', '36', '0', '16', '95:90', '1');
INSERT INTO `statistic_games` VALUES ('1028', '2017-01-22', '1', '17', '1', '16', '81:57', '1');
INSERT INTO `statistic_games` VALUES ('1029', '2017-01-25', '3', '36', '1', '16', '85:84', '1');
INSERT INTO `statistic_games` VALUES ('1030', '2017-01-29', '1', '11', '0', '16', '104:90', '1');
INSERT INTO `statistic_games` VALUES ('1031', '2017-02-01', '3', '34', '0', '16', '89:77', '1');
INSERT INTO `statistic_games` VALUES ('1032', '2017-02-08', '3', '4', '1', '16', '74:96', '1');
INSERT INTO `statistic_games` VALUES ('1033', '2017-02-15', '1', '1', '0', '16', '118:109', '1');
INSERT INTO `statistic_games` VALUES ('1034', '2017-02-20', '1', '27', '0', '16', '98:73', '1');
INSERT INTO `statistic_games` VALUES ('1035', '2017-02-24', '1', '18', '0', '16', '89:84', '1');
INSERT INTO `statistic_games` VALUES ('1036', '2017-02-28', '3', '10', '0', '16', '82:88', '1');
INSERT INTO `statistic_games` VALUES ('1037', '2017-03-03', '3', '10', '1', '16', '98:74', '1');
INSERT INTO `statistic_games` VALUES ('1038', '2017-03-05', '1', '29', '1', '16', '80:72', '1');
INSERT INTO `statistic_games` VALUES ('1039', '2017-03-08', '3', '10', '0', '16', '76:92', '1');
INSERT INTO `statistic_games` VALUES ('1040', '2017-03-11', '1', '24', '0', '16', '87:83', '1');
INSERT INTO `statistic_games` VALUES ('1041', '2017-03-27', '1', '31', '1', '16', '70:92', '1');
INSERT INTO `statistic_games` VALUES ('1042', '2017-04-02', '1', '21', '0', '16', '99:90', '1');
INSERT INTO `statistic_games` VALUES ('1043', '2017-04-09', '1', '16', '1', '16', '66:74', '1');
INSERT INTO `statistic_games` VALUES ('1044', '2017-04-17', '1', '3', '0', '16', '90:87', '1');
INSERT INTO `statistic_games` VALUES ('1045', '2017-04-23', '1', '14', '0', '16', '104:64', '1');
INSERT INTO `statistic_games` VALUES ('1046', '2017-05-04', '1', '14', '1', '16', '91:84', '1');
INSERT INTO `statistic_games` VALUES ('1047', '2017-05-06', '1', '14', '1', '16', '109:81', '1');
INSERT INTO `statistic_games` VALUES ('1048', '2017-05-09', '1', '14', '0', '16', '89:68', '1');
INSERT INTO `statistic_games` VALUES ('1049', '2017-05-25', '1', '16', '0', '16', '95:99', '1');
INSERT INTO `statistic_games` VALUES ('1050', '2017-05-27', '1', '16', '0', '16', '89:92', '1');
INSERT INTO `statistic_games` VALUES ('1051', '2017-05-30', '1', '16', '1', '16', '97:73', '1');
INSERT INTO `statistic_games` VALUES ('1052', '2017-06-01', '1', '16', '1', '16', '73:71', '1');
INSERT INTO `statistic_games` VALUES ('1053', '2017-06-04', '1', '16', '0', '16', '90:84', '1');
INSERT INTO `statistic_games` VALUES ('1054', '2017-06-08', '1', '31', '0', '16', '88:94', '1');
INSERT INTO `statistic_games` VALUES ('1055', '2017-06-10', '1', '31', '0', '16', '79:99', '1');
INSERT INTO `statistic_games` VALUES ('1056', '2017-06-13', '1', '31', '1', '16', '72:95', '1');
INSERT INTO `statistic_games` VALUES ('1057', '2017-10-05', '1', '29', '1', '17', '83:55', '1');
INSERT INTO `statistic_games` VALUES ('1058', '2017-10-09', '1', '11', '0', '17', '104:64', '1');
INSERT INTO `statistic_games` VALUES ('1059', '2017-10-13', '2', '10', '1', '17', '75:70', '1');
INSERT INTO `statistic_games` VALUES ('1060', '2017-10-16', '1', '24', '0', '17', '106:69', '1');
INSERT INTO `statistic_games` VALUES ('1061', '2017-10-20', '2', '15', '1', '17', '85:77', '1');
INSERT INTO `statistic_games` VALUES ('1062', '2017-10-24', '2', '30', '1', '17', '85:78', '1');
INSERT INTO `statistic_games` VALUES ('1063', '2017-10-26', '2', '22', '0', '17', '75:92', '1');
INSERT INTO `statistic_games` VALUES ('1064', '2017-10-30', '1', '3', '1', '17', '72:71', '1');
INSERT INTO `statistic_games` VALUES ('1065', '2017-11-02', '2', '25', '0', '17', '86:80', '1');
INSERT INTO `statistic_games` VALUES ('1066', '2017-11-06', '1', '31', '1', '17', '81:96', '1');
INSERT INTO `statistic_games` VALUES ('1067', '2017-11-10', '2', '6', '1', '17', '91:90', '1');
INSERT INTO `statistic_games` VALUES ('1068', '2017-11-14', '2', '23', '0', '17', '65:93', '1');
INSERT INTO `statistic_games` VALUES ('1069', '2017-11-16', '2', '19', '1', '17', '69:77', '1');
INSERT INTO `statistic_games` VALUES ('1070', '2017-11-19', '1', '16', '1', '17', '66:76', '1');
INSERT INTO `statistic_games` VALUES ('1071', '2017-11-24', '2', '28', '0', '17', '67:71', '1');
INSERT INTO `statistic_games` VALUES ('1072', '2017-11-30', '2', '8', '1', '17', '82:73', '1');
INSERT INTO `statistic_games` VALUES ('1073', '2017-12-03', '1', '27', '0', '17', '79:80', '1');
INSERT INTO `statistic_games` VALUES ('1074', '2017-12-07', '2', '20', '0', '17', '77:71', '1');
INSERT INTO `statistic_games` VALUES ('1075', '2017-12-10', '1', '21', '1', '17', '90:87', '1');
INSERT INTO `statistic_games` VALUES ('1076', '2017-12-14', '2', '26', '0', '17', '84:93', '1');
INSERT INTO `statistic_games` VALUES ('1077', '2017-12-20', '2', '2', '1', '17', '86:68', '1');
INSERT INTO `statistic_games` VALUES ('1078', '2017-12-22', '2', '31', '0', '17', '68:79', '1');
INSERT INTO `statistic_games` VALUES ('1079', '2017-12-26', '1', '14', '1', '17', '92:62', '1');
INSERT INTO `statistic_games` VALUES ('1080', '2017-12-29', '2', '5', '1', '17', '65:79', '1');
INSERT INTO `statistic_games` VALUES ('1081', '2018-01-05', '2', '8', '0', '17', '74:70', '1');
INSERT INTO `statistic_games` VALUES ('1082', '2018-01-07', '1', '17', '0', '17', '84:92', '1');
INSERT INTO `statistic_games` VALUES ('1083', '2018-01-12', '2', '25', '1', '17', '78:95', '1');
INSERT INTO `statistic_games` VALUES ('1084', '2018-01-16', '2', '30', '0', '17', '79:70', '1');
INSERT INTO `statistic_games` VALUES ('1085', '2018-01-18', '2', '22', '1', '17', '82:54', '1');
INSERT INTO `statistic_games` VALUES ('1086', '2018-01-21', '1', '18', '0', '17', '78:93', '1');
INSERT INTO `statistic_games` VALUES ('1087', '2018-01-26', '2', '10', '0', '17', '83:85', '1');
INSERT INTO `statistic_games` VALUES ('1088', '2018-01-29', '1', '1', '1', '17', '88:75', '1');
INSERT INTO `statistic_games` VALUES ('1089', '2018-02-02', '2', '26', '1', '17', '68:66', '1');
INSERT INTO `statistic_games` VALUES ('1090', '2018-02-05', '1', '31', '0', '17', '71:90', '1');
INSERT INTO `statistic_games` VALUES ('1091', '2018-02-09', '2', '15', '0', '17', '84:76', '1');
INSERT INTO `statistic_games` VALUES ('1092', '2018-02-12', '1', '11', '1', '17', '73:77', '1');
INSERT INTO `statistic_games` VALUES ('1093', '2018-02-15', '1', '16', '0', '17', '98:80', '1');
INSERT INTO `statistic_games` VALUES ('1094', '2018-02-23', '2', '23', '1', '17', '78:61', '1');
INSERT INTO `statistic_games` VALUES ('1095', '2018-03-01', '2', '6', '0', '17', '77:87', '1');
INSERT INTO `statistic_games` VALUES ('1096', '2018-03-04', '1', '21', '0', '17', '82:79', '1');
INSERT INTO `statistic_games` VALUES ('1097', '2018-03-08', '2', '20', '1', '17', '77:86', '1');
INSERT INTO `statistic_games` VALUES ('1098', '2018-03-11', '1', '3', '0', '17', '79:84', '1');
INSERT INTO `statistic_games` VALUES ('1099', '2018-03-15', '2', '19', '0', '17', '94:91', '1');
INSERT INTO `statistic_games` VALUES ('1100', '2018-03-21', '2', '2', '0', '17', '85:73', '1');
INSERT INTO `statistic_games` VALUES ('1101', '2018-03-23', '2', '31', '1', '17', '73:90', '1');
INSERT INTO `statistic_games` VALUES ('1102', '2018-03-26', '1', '27', '1', '17', '80:83', '1');
INSERT INTO `statistic_games` VALUES ('1103', '2018-03-29', '2', '28', '1', '17', '64:73', '1');
INSERT INTO `statistic_games` VALUES ('1104', '2018-04-01', '1', '17', '1', '17', '96:85', '1');
INSERT INTO `statistic_games` VALUES ('1105', '2018-04-05', '2', '5', '0', '17', '82:86', '1');
INSERT INTO `statistic_games` VALUES ('1106', '2018-04-09', '1', '24', '1', '17', '90:87', '1');
INSERT INTO `statistic_games` VALUES ('1107', '2018-04-12', '1', '29', '0', '17', '82:79', '1');
INSERT INTO `statistic_games` VALUES ('1108', '2018-04-17', '2', '31', '0', '17', '95:98', '1');
INSERT INTO `statistic_games` VALUES ('1109', '2018-04-19', '2', '31', '0', '17', '84:89', '1');
INSERT INTO `statistic_games` VALUES ('1110', '2018-04-25', '2', '31', '1', '17', '79:73', '1');
INSERT INTO `statistic_games` VALUES ('1111', '2018-04-27', '2', '31', '1', '17', '88:89', '1');
INSERT INTO `statistic_games` VALUES ('1112', '2018-05-05', '1', '1', '0', '17', '92:104', '1');
INSERT INTO `statistic_games` VALUES ('1113', '2018-05-09', '1', '18', '1', '17', '83:90', '1');
INSERT INTO `statistic_games` VALUES ('1114', '2018-05-12', '1', '14', '0', '17', '89:84', '1');
INSERT INTO `statistic_games` VALUES ('1115', '2018-05-23', '1', '18', '0', '17', '79:66', '1');
INSERT INTO `statistic_games` VALUES ('1116', '2018-05-26', '1', '18', '1', '17', '77:72', '1');
INSERT INTO `statistic_games` VALUES ('1117', '2018-05-28', '1', '18', '1', '17', '86:73', '1');
INSERT INTO `statistic_games` VALUES ('1118', '2018-06-08', '1', '27', '0', '17', '76:71', '1');
INSERT INTO `statistic_games` VALUES ('1119', '2018-06-10', '1', '31', '0', '17', '84:95', '1');
SET FOREIGN_KEY_CHECKS=1;

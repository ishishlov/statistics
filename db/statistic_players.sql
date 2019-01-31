/*
Navicat MySQL Data Transfer

Source Server         : statistics
Source Server Version : 50638
Source Host           : localhost:3306
Source Database       : statistics

Target Server Type    : MYSQL
Target Server Version : 50638
File Encoding         : 65001

Date: 2019-01-31 22:45:49
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for statistic_players
-- ----------------------------
DROP TABLE IF EXISTS `statistic_players`;
CREATE TABLE `statistic_players` (
  `player_id` int(10) unsigned NOT NULL,
  `game_id` int(10) unsigned NOT NULL COMMENT 'Ссылка на game_id из statistic_games',
  `min` varchar(10) NOT NULL,
  `two_point_made` smallint(5) unsigned NOT NULL COMMENT 'Двухочковый гол',
  `two_point_throw` smallint(5) unsigned NOT NULL COMMENT 'Двухочковый бросок',
  `three_point_made` smallint(5) unsigned NOT NULL COMMENT 'Трехочковый гол',
  `three_point_throw` smallint(5) unsigned NOT NULL COMMENT 'Трехочковый бросок',
  `free_made` smallint(5) unsigned NOT NULL COMMENT 'Штрафной гол',
  `free_throw` smallint(5) unsigned NOT NULL COMMENT 'Штрафной бросок',
  `offensive_rebound` smallint(5) unsigned NOT NULL COMMENT 'Подборы на чужом щите',
  `deffensive_rebound` smallint(5) unsigned NOT NULL COMMENT 'Подборы на своем щите',
  `assists` smallint(5) unsigned NOT NULL COMMENT 'Результативные передачи',
  `commited_foul` smallint(5) unsigned NOT NULL,
  `recieved_foul` smallint(5) unsigned NOT NULL COMMENT 'Персональный фол',
  `turnover` smallint(5) unsigned NOT NULL COMMENT 'Потеря',
  `steal` smallint(5) unsigned NOT NULL COMMENT 'Перехват',
  `in_fawor` smallint(5) unsigned NOT NULL COMMENT 'Блок-шоты игрока',
  `against` smallint(5) unsigned NOT NULL COMMENT 'Блок-шоты, полученные игроком',
  `effectiveness` smallint(5) NOT NULL COMMENT 'Эффективность',
  `plus_minus` smallint(5) NOT NULL COMMENT 'Показатель «плюс-минус»',
  `points_scored` smallint(5) unsigned NOT NULL COMMENT 'Очки',
  `games` smallint(5) unsigned NOT NULL,
  `gs` smallint(5) NOT NULL COMMENT 'ИС',
  PRIMARY KEY (`player_id`,`game_id`),
  UNIQUE KEY `player_id_game_id` (`player_id`,`game_id`),
  KEY `game_id` (`game_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Статистика игроков';

-- ----------------------------
-- Records of statistic_players
-- ----------------------------
INSERT INTO `statistic_players` VALUES ('81', '1046', '27:55:00', '5', '5', '5', '5', '3', '4', '0', '1', '5', '0', '7', '3', '0', '0', '0', '15', '21', '19', '1', '1');
INSERT INTO `statistic_players` VALUES ('81', '1047', '27:55:00', '5', '5', '5', '5', '3', '4', '0', '1', '5', '0', '7', '3', '0', '0', '0', '15', '21', '19', '1', '1');
INSERT INTO `statistic_players` VALUES ('81', '1048', '27:55:00', '5', '5', '5', '5', '3', '4', '0', '1', '5', '0', '7', '3', '0', '0', '0', '15', '21', '19', '1', '1');
INSERT INTO `statistic_players` VALUES ('81', '1049', '27:55:00', '5', '5', '5', '5', '3', '4', '0', '1', '5', '0', '7', '3', '0', '0', '0', '15', '21', '19', '1', '1');
INSERT INTO `statistic_players` VALUES ('81', '1050', '27:55:00', '5', '5', '5', '5', '3', '4', '0', '1', '5', '0', '7', '3', '0', '0', '0', '15', '21', '19', '1', '1');
INSERT INTO `statistic_players` VALUES ('81', '1051', '27:55:00', '5', '5', '5', '5', '3', '4', '0', '1', '5', '0', '7', '3', '0', '0', '0', '15', '21', '19', '1', '1');
INSERT INTO `statistic_players` VALUES ('81', '1052', '27:55:00', '5', '6', '2', '7', '3', '4', '0', '1', '5', '0', '7', '3', '0', '0', '0', '15', '21', '19', '1', '1');
INSERT INTO `statistic_players` VALUES ('81', '1053', '27:55:00', '5', '6', '2', '7', '3', '4', '0', '1', '5', '0', '7', '3', '0', '0', '0', '15', '21', '19', '1', '1');
INSERT INTO `statistic_players` VALUES ('81', '1054', '27:55:00', '5', '6', '2', '7', '3', '4', '0', '1', '5', '0', '7', '3', '0', '0', '0', '15', '21', '19', '1', '1');
INSERT INTO `statistic_players` VALUES ('81', '1055', '27:55:00', '5', '6', '2', '7', '3', '4', '0', '1', '5', '0', '7', '3', '0', '0', '0', '15', '21', '19', '1', '1');
INSERT INTO `statistic_players` VALUES ('81', '1056', '27:55:00', '5', '6', '2', '7', '3', '4', '0', '1', '5', '0', '7', '3', '0', '0', '0', '15', '21', '19', '1', '1');
INSERT INTO `statistic_players` VALUES ('81', '1057', '27:55:00', '5', '6', '2', '7', '3', '4', '0', '1', '5', '0', '7', '3', '0', '0', '0', '15', '21', '19', '1', '1');
INSERT INTO `statistic_players` VALUES ('81', '1058', '27:55:00', '5', '6', '2', '7', '3', '4', '0', '1', '5', '0', '7', '3', '0', '0', '0', '15', '21', '19', '1', '1');
INSERT INTO `statistic_players` VALUES ('103', '1046', '10:30', '2', '2', '0', '0', '1', '2', '0', '1', '2', '0', '1', '1', '2', '1', '0', '9', '8', '5', '1', '0');
INSERT INTO `statistic_players` VALUES ('103', '1047', '10:30', '2', '2', '0', '0', '1', '2', '0', '1', '2', '0', '1', '1', '2', '1', '0', '9', '8', '5', '1', '0');
INSERT INTO `statistic_players` VALUES ('103', '1048', '10:30', '2', '2', '0', '0', '1', '2', '0', '1', '2', '0', '1', '1', '2', '1', '0', '9', '8', '5', '1', '0');
INSERT INTO `statistic_players` VALUES ('103', '1049', '10:30', '2', '2', '0', '0', '1', '2', '0', '1', '2', '0', '1', '1', '2', '1', '0', '9', '8', '5', '1', '0');
INSERT INTO `statistic_players` VALUES ('103', '1050', '10:30', '2', '2', '0', '0', '1', '2', '0', '1', '2', '0', '1', '1', '2', '1', '0', '9', '8', '5', '1', '0');
INSERT INTO `statistic_players` VALUES ('103', '1051', '10:30', '6', '6', '6', '6', '1', '2', '0', '1', '2', '0', '1', '1', '2', '1', '0', '9', '8', '5', '1', '0');
INSERT INTO `statistic_players` VALUES ('103', '1052', '10:30', '6', '6', '6', '6', '1', '2', '0', '1', '2', '0', '1', '1', '2', '1', '0', '9', '8', '5', '1', '0');
INSERT INTO `statistic_players` VALUES ('103', '1053', '10:30', '2', '2', '0', '0', '1', '2', '0', '1', '2', '0', '1', '1', '2', '1', '0', '9', '8', '5', '1', '0');
INSERT INTO `statistic_players` VALUES ('103', '1054', '10:30', '2', '2', '0', '0', '1', '2', '0', '1', '2', '0', '1', '1', '2', '1', '0', '9', '8', '5', '1', '0');
INSERT INTO `statistic_players` VALUES ('103', '1055', '10:30', '2', '2', '0', '0', '1', '2', '0', '1', '2', '0', '1', '1', '2', '1', '0', '9', '8', '5', '1', '0');
INSERT INTO `statistic_players` VALUES ('103', '1056', '10:30', '2', '2', '0', '0', '1', '2', '0', '1', '2', '0', '1', '1', '2', '1', '0', '9', '8', '5', '1', '0');
INSERT INTO `statistic_players` VALUES ('103', '1057', '10:30', '2', '2', '0', '0', '1', '2', '0', '1', '2', '0', '1', '1', '2', '1', '0', '9', '8', '5', '1', '0');
INSERT INTO `statistic_players` VALUES ('103', '1058', '10:30', '2', '2', '0', '0', '1', '2', '0', '1', '2', '0', '1', '1', '2', '1', '0', '9', '8', '5', '1', '0');
INSERT INTO `statistic_players` VALUES ('113', '1046', '11:01', '18', '36', '1', '2', '0', '0', '0', '3', '2', '3', '0', '2', '0', '2', '0', '7', '13', '3', '1', '0');
INSERT INTO `statistic_players` VALUES ('113', '1047', '11:01', '18', '36', '1', '2', '0', '0', '0', '3', '2', '3', '0', '2', '0', '2', '0', '7', '13', '3', '1', '0');
INSERT INTO `statistic_players` VALUES ('113', '1048', '11:01', '18', '36', '1', '2', '0', '0', '0', '3', '2', '3', '0', '2', '0', '2', '0', '7', '13', '3', '1', '0');
INSERT INTO `statistic_players` VALUES ('113', '1049', '11:01', '18', '36', '1', '2', '0', '0', '0', '3', '2', '3', '0', '2', '0', '2', '0', '7', '13', '3', '1', '0');
INSERT INTO `statistic_players` VALUES ('113', '1050', '11:01', '18', '36', '1', '2', '0', '0', '0', '3', '2', '3', '0', '2', '0', '2', '0', '7', '13', '3', '1', '0');
INSERT INTO `statistic_players` VALUES ('113', '1051', '11:01', '18', '36', '1', '2', '0', '0', '0', '3', '2', '3', '0', '2', '0', '2', '0', '7', '13', '3', '1', '0');
INSERT INTO `statistic_players` VALUES ('113', '1052', '11:01', '18', '36', '1', '2', '0', '0', '0', '3', '2', '3', '0', '2', '0', '2', '0', '7', '13', '3', '1', '0');
INSERT INTO `statistic_players` VALUES ('113', '1053', '11:01', '7', '7', '7', '7', '0', '0', '0', '3', '2', '3', '0', '2', '0', '2', '0', '7', '13', '3', '1', '0');
INSERT INTO `statistic_players` VALUES ('113', '1054', '11:01', '7', '7', '7', '7', '0', '0', '0', '3', '2', '3', '0', '2', '0', '2', '0', '7', '13', '3', '1', '0');
INSERT INTO `statistic_players` VALUES ('113', '1055', '11:01', '18', '36', '1', '2', '0', '0', '0', '3', '2', '3', '0', '2', '0', '2', '0', '7', '13', '3', '1', '0');
INSERT INTO `statistic_players` VALUES ('113', '1056', '11:01', '18', '36', '1', '2', '0', '0', '0', '3', '2', '3', '0', '2', '0', '2', '0', '7', '13', '3', '1', '0');
INSERT INTO `statistic_players` VALUES ('113', '1057', '11:01', '18', '36', '1', '2', '0', '0', '0', '3', '2', '3', '0', '2', '0', '2', '0', '7', '13', '3', '1', '0');
INSERT INTO `statistic_players` VALUES ('113', '1058', '11:01', '18', '36', '1', '2', '0', '0', '0', '3', '2', '3', '0', '2', '0', '2', '0', '7', '13', '3', '1', '0');
INSERT INTO `statistic_players` VALUES ('124', '1046', '21:20', '0', '0', '3', '3', '0', '0', '0', '4', '1', '1', '1', '2', '0', '0', '0', '12', '10', '9', '1', '0');
INSERT INTO `statistic_players` VALUES ('124', '1047', '21:20', '0', '0', '3', '3', '0', '0', '0', '4', '1', '1', '1', '2', '0', '0', '0', '12', '10', '9', '1', '0');
INSERT INTO `statistic_players` VALUES ('124', '1048', '21:20', '0', '0', '3', '3', '0', '0', '0', '4', '1', '1', '1', '2', '0', '0', '0', '12', '10', '9', '1', '0');
INSERT INTO `statistic_players` VALUES ('124', '1049', '21:20', '0', '0', '3', '3', '0', '0', '0', '4', '1', '1', '1', '2', '0', '0', '0', '12', '10', '9', '1', '0');
INSERT INTO `statistic_players` VALUES ('124', '1050', '21:20', '0', '0', '3', '3', '0', '0', '0', '4', '1', '1', '1', '2', '0', '0', '0', '12', '10', '9', '1', '0');
INSERT INTO `statistic_players` VALUES ('124', '1051', '21:20', '0', '0', '3', '3', '0', '0', '0', '4', '1', '1', '1', '2', '0', '0', '0', '12', '10', '9', '1', '0');
INSERT INTO `statistic_players` VALUES ('124', '1052', '21:20', '8', '8', '8', '8', '0', '0', '0', '4', '1', '1', '1', '2', '0', '0', '0', '12', '10', '9', '1', '0');
INSERT INTO `statistic_players` VALUES ('124', '1053', '21:20', '8', '8', '8', '8', '0', '0', '0', '4', '1', '1', '1', '2', '0', '0', '0', '12', '10', '9', '1', '0');
INSERT INTO `statistic_players` VALUES ('124', '1054', '21:20', '0', '0', '3', '3', '0', '0', '0', '4', '1', '1', '1', '2', '0', '0', '0', '12', '10', '9', '1', '0');
INSERT INTO `statistic_players` VALUES ('124', '1055', '21:20', '0', '0', '3', '3', '0', '0', '0', '4', '1', '1', '1', '2', '0', '0', '0', '12', '10', '9', '1', '0');
INSERT INTO `statistic_players` VALUES ('124', '1056', '21:20', '0', '0', '3', '3', '0', '0', '0', '4', '1', '1', '1', '2', '0', '0', '0', '12', '10', '9', '1', '0');
INSERT INTO `statistic_players` VALUES ('124', '1057', '21:20', '0', '0', '3', '3', '0', '0', '0', '4', '1', '1', '1', '2', '0', '0', '0', '12', '10', '9', '1', '0');
INSERT INTO `statistic_players` VALUES ('124', '1058', '21:20', '0', '0', '3', '3', '0', '0', '0', '4', '1', '1', '1', '2', '0', '0', '0', '12', '10', '9', '1', '0');
INSERT INTO `statistic_players` VALUES ('161', '1046', '2:38', '0', '0', '0', '1', '0', '0', '0', '0', '1', '0', '0', '0', '1', '0', '0', '1', '3', '0', '1', '0');
INSERT INTO `statistic_players` VALUES ('161', '1047', '2:38', '0', '0', '0', '1', '0', '0', '0', '0', '1', '0', '0', '0', '1', '0', '0', '1', '3', '0', '1', '0');
INSERT INTO `statistic_players` VALUES ('161', '1048', '2:38', '0', '0', '0', '1', '0', '0', '0', '0', '1', '0', '0', '0', '1', '0', '0', '1', '3', '0', '1', '0');
INSERT INTO `statistic_players` VALUES ('161', '1049', '2:38', '0', '0', '0', '1', '0', '0', '0', '0', '1', '0', '0', '0', '1', '0', '0', '1', '3', '0', '1', '0');
INSERT INTO `statistic_players` VALUES ('161', '1050', '2:38', '0', '0', '0', '1', '0', '0', '0', '0', '1', '0', '0', '0', '1', '0', '0', '1', '3', '0', '1', '0');
INSERT INTO `statistic_players` VALUES ('161', '1051', '2:38', '0', '0', '0', '1', '0', '0', '0', '0', '1', '0', '0', '0', '1', '0', '0', '1', '3', '0', '1', '0');
INSERT INTO `statistic_players` VALUES ('161', '1052', '2:38', '0', '0', '0', '1', '0', '0', '0', '0', '1', '0', '0', '0', '1', '0', '0', '1', '3', '0', '1', '0');
INSERT INTO `statistic_players` VALUES ('161', '1053', '2:38', '0', '0', '0', '1', '0', '0', '0', '0', '1', '0', '0', '0', '1', '0', '0', '1', '3', '0', '1', '0');
INSERT INTO `statistic_players` VALUES ('161', '1054', '2:38', '9', '9', '9', '9', '9', '0', '0', '0', '1', '0', '0', '0', '1', '0', '0', '1', '3', '0', '1', '0');
INSERT INTO `statistic_players` VALUES ('161', '1055', '2:38', '9', '9', '9', '9', '9', '0', '0', '0', '1', '0', '0', '0', '1', '0', '0', '1', '3', '0', '1', '0');
INSERT INTO `statistic_players` VALUES ('161', '1056', '2:38', '0', '0', '0', '1', '0', '0', '0', '0', '1', '0', '0', '0', '1', '0', '0', '1', '3', '0', '1', '0');
INSERT INTO `statistic_players` VALUES ('161', '1057', '2:38', '0', '0', '0', '1', '0', '0', '0', '0', '1', '0', '0', '0', '1', '0', '0', '1', '3', '0', '1', '0');
INSERT INTO `statistic_players` VALUES ('161', '1058', '2:38', '0', '0', '0', '1', '0', '0', '0', '0', '1', '0', '0', '0', '1', '0', '0', '1', '3', '0', '1', '0');
INSERT INTO `statistic_players` VALUES ('171', '1046', '19:48', '1', '1', '4', '5', '0', '0', '0', '2', '0', '3', '0', '0', '4', '0', '0', '19', '26', '14', '1', '1');
INSERT INTO `statistic_players` VALUES ('171', '1047', '19:48', '1', '1', '4', '5', '0', '0', '0', '2', '0', '3', '0', '0', '4', '0', '0', '19', '26', '14', '1', '1');
INSERT INTO `statistic_players` VALUES ('171', '1048', '19:48', '1', '1', '4', '5', '0', '0', '0', '2', '0', '3', '0', '0', '4', '0', '0', '19', '26', '14', '1', '1');
INSERT INTO `statistic_players` VALUES ('171', '1049', '19:48', '1', '1', '4', '5', '0', '0', '0', '2', '0', '3', '0', '0', '4', '0', '0', '19', '26', '14', '1', '1');
INSERT INTO `statistic_players` VALUES ('171', '1050', '19:48', '1', '1', '4', '5', '0', '0', '0', '2', '0', '3', '0', '0', '4', '0', '0', '19', '26', '14', '1', '1');
INSERT INTO `statistic_players` VALUES ('171', '1051', '19:48', '1', '1', '4', '5', '0', '0', '0', '2', '0', '3', '0', '0', '4', '0', '0', '19', '26', '14', '1', '1');
INSERT INTO `statistic_players` VALUES ('171', '1052', '19:48', '1', '1', '1', '1', '0', '0', '0', '2', '0', '3', '0', '0', '4', '0', '0', '19', '26', '14', '1', '1');
INSERT INTO `statistic_players` VALUES ('171', '1053', '19:48', '1', '1', '1', '1', '0', '0', '0', '2', '0', '3', '0', '0', '4', '0', '0', '19', '26', '14', '1', '1');
INSERT INTO `statistic_players` VALUES ('171', '1054', '19:48', '1', '1', '4', '5', '0', '0', '0', '2', '0', '3', '0', '0', '4', '0', '0', '19', '26', '14', '1', '1');
INSERT INTO `statistic_players` VALUES ('171', '1055', '19:48', '1', '1', '4', '5', '0', '0', '0', '2', '0', '3', '0', '0', '4', '0', '0', '19', '26', '14', '1', '1');
INSERT INTO `statistic_players` VALUES ('171', '1056', '19:48', '1', '1', '4', '5', '0', '0', '0', '2', '0', '3', '0', '0', '4', '0', '0', '19', '26', '14', '1', '1');
INSERT INTO `statistic_players` VALUES ('171', '1057', '19:48', '1', '1', '4', '5', '0', '0', '0', '2', '0', '3', '0', '0', '4', '0', '0', '19', '26', '14', '1', '1');
INSERT INTO `statistic_players` VALUES ('171', '1058', '19:48', '1', '1', '4', '5', '0', '0', '0', '2', '0', '3', '0', '0', '4', '0', '0', '19', '26', '14', '1', '1');
INSERT INTO `statistic_players` VALUES ('172', '1046', '21:46', '1', '3', '0', '3', '7', '8', '0', '3', '7', '3', '6', '1', '2', '0', '1', '14', '5', '9', '1', '0');
INSERT INTO `statistic_players` VALUES ('172', '1047', '21:46', '1', '3', '0', '3', '7', '8', '0', '3', '7', '3', '6', '1', '2', '0', '1', '14', '5', '9', '1', '0');
INSERT INTO `statistic_players` VALUES ('172', '1048', '21:46', '1', '3', '0', '3', '7', '8', '0', '3', '7', '3', '6', '1', '2', '0', '1', '14', '5', '9', '1', '0');
INSERT INTO `statistic_players` VALUES ('172', '1049', '21:46', '1', '3', '0', '3', '7', '8', '0', '3', '7', '3', '6', '1', '2', '0', '1', '14', '5', '9', '1', '0');
INSERT INTO `statistic_players` VALUES ('172', '1050', '21:46', '1', '3', '0', '3', '7', '8', '0', '3', '7', '3', '6', '1', '2', '0', '1', '14', '5', '9', '1', '0');
INSERT INTO `statistic_players` VALUES ('172', '1051', '21:46', '1', '3', '0', '3', '7', '8', '0', '3', '7', '3', '6', '1', '2', '0', '1', '14', '5', '9', '1', '0');
INSERT INTO `statistic_players` VALUES ('172', '1052', '21:46', '1', '3', '0', '3', '7', '8', '0', '3', '7', '3', '6', '1', '2', '0', '1', '14', '5', '9', '1', '0');
INSERT INTO `statistic_players` VALUES ('172', '1053', '21:46', '1', '3', '0', '3', '7', '8', '0', '3', '7', '3', '6', '1', '2', '0', '1', '14', '5', '9', '1', '0');
INSERT INTO `statistic_players` VALUES ('172', '1054', '21:46', '1', '3', '0', '3', '7', '8', '0', '3', '7', '3', '6', '1', '2', '0', '1', '14', '5', '9', '1', '0');
INSERT INTO `statistic_players` VALUES ('172', '1055', '21:46', '1', '3', '0', '3', '7', '8', '0', '3', '7', '3', '6', '1', '2', '0', '1', '14', '5', '9', '1', '0');
INSERT INTO `statistic_players` VALUES ('172', '1056', '21:46', '1', '3', '0', '3', '7', '8', '0', '3', '7', '3', '6', '1', '2', '0', '1', '14', '5', '9', '1', '0');
INSERT INTO `statistic_players` VALUES ('172', '1057', '21:46', '1', '3', '0', '3', '7', '8', '0', '3', '7', '3', '6', '1', '2', '0', '1', '14', '5', '9', '1', '0');
INSERT INTO `statistic_players` VALUES ('172', '1058', '21:46', '1', '3', '0', '3', '7', '8', '0', '3', '7', '3', '6', '1', '2', '0', '1', '14', '5', '9', '1', '0');
INSERT INTO `statistic_players` VALUES ('174', '1046', '23:40', '1', '2', '0', '3', '0', '0', '2', '0', '1', '1', '2', '2', '0', '0', '1', '-1', '3', '2', '1', '0');
INSERT INTO `statistic_players` VALUES ('174', '1047', '23:40', '1', '2', '0', '3', '0', '0', '2', '0', '1', '1', '2', '2', '0', '0', '1', '-1', '3', '2', '1', '0');
INSERT INTO `statistic_players` VALUES ('174', '1048', '23:40', '1', '2', '0', '3', '0', '0', '2', '0', '1', '1', '2', '2', '0', '0', '1', '-1', '3', '2', '1', '0');
INSERT INTO `statistic_players` VALUES ('174', '1049', '23:40', '1', '2', '0', '3', '0', '0', '2', '0', '1', '1', '2', '2', '0', '0', '1', '-1', '3', '2', '1', '0');
INSERT INTO `statistic_players` VALUES ('174', '1050', '23:40', '1', '2', '0', '3', '0', '0', '2', '0', '1', '1', '2', '2', '0', '0', '1', '-1', '3', '2', '1', '0');
INSERT INTO `statistic_players` VALUES ('174', '1051', '23:40', '1', '2', '0', '3', '0', '0', '2', '0', '1', '1', '2', '2', '0', '0', '1', '-1', '3', '2', '1', '0');
INSERT INTO `statistic_players` VALUES ('174', '1052', '23:40', '1', '2', '0', '3', '0', '0', '2', '0', '1', '1', '2', '2', '0', '0', '1', '-1', '3', '2', '1', '0');
INSERT INTO `statistic_players` VALUES ('174', '1053', '23:40', '1', '2', '0', '3', '0', '0', '2', '0', '1', '1', '2', '2', '0', '0', '1', '-1', '3', '2', '1', '0');
INSERT INTO `statistic_players` VALUES ('174', '1054', '23:40', '1', '2', '0', '3', '0', '0', '2', '0', '1', '1', '2', '2', '0', '0', '1', '-1', '3', '2', '1', '0');
INSERT INTO `statistic_players` VALUES ('174', '1055', '23:40', '1', '2', '0', '3', '0', '0', '2', '0', '1', '1', '2', '2', '0', '0', '1', '-1', '3', '2', '1', '0');
INSERT INTO `statistic_players` VALUES ('174', '1056', '23:40', '1', '2', '0', '3', '0', '0', '2', '0', '1', '1', '2', '2', '0', '0', '1', '-1', '3', '2', '1', '0');
INSERT INTO `statistic_players` VALUES ('174', '1057', '23:40', '1', '2', '0', '3', '0', '0', '2', '0', '1', '1', '2', '2', '0', '0', '1', '-1', '3', '2', '1', '0');
INSERT INTO `statistic_players` VALUES ('174', '1058', '23:40', '1', '2', '0', '3', '0', '0', '2', '0', '1', '1', '2', '2', '0', '0', '1', '-1', '3', '2', '1', '0');
INSERT INTO `statistic_players` VALUES ('176', '1046', '23:57', '2', '3', '0', '0', '4', '4', '2', '6', '2', '1', '5', '1', '1', '2', '0', '19', '22', '8', '1', '1');
INSERT INTO `statistic_players` VALUES ('176', '1053', '23:57', '2', '3', '0', '0', '4', '4', '2', '6', '2', '1', '5', '1', '1', '2', '0', '19', '22', '8', '1', '1');

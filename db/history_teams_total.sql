/*
Navicat MySQL Data Transfer

Source Server         : Stat-origin
Source Server Version : 50643
Source Host           : VH247.spaceweb.ru:3306
Source Database       : ivanshiru_stat

Target Server Type    : MYSQL
Target Server Version : 50643
File Encoding         : 65001

Date: 2019-08-01 23:30:38
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for statistic_players
-- ----------------------------
DROP TABLE IF EXISTS `history_teams_total`;
CREATE TABLE `history_teams_total` (
  `history_teams_total_id` int(10) unsigned NOT NULL,
  `number` int(10) unsigned NOT NULL,
  `team_id` int(10) unsigned NOT NULL COMMENT 'Ссылка на team_id из teams',
  `season_id` tinyint(3) unsigned NOT NULL COMMENT 'Ссылка на season_id из seasons',
  `two_point_made` smallint(5) unsigned NOT NULL COMMENT 'Двухочковый гол',
  `two_point_throw` smallint(5) unsigned NOT NULL COMMENT 'Двухочковый бросок',
  `two_point_percent` smallint(5) unsigned NOT NULL COMMENT 'Соотношение двухочковый бросков',
  `three_point_made` smallint(5) unsigned NOT NULL COMMENT 'Трехочковый гол',
  `three_point_throw` smallint(5) unsigned NOT NULL COMMENT 'Трехочковый бросок',
  `three_point_percent` smallint(5) unsigned NOT NULL COMMENT 'Сумма трехочковых бросков',
  `two_three_point_made` smallint(5) unsigned NOT NULL COMMENT 'Трехочковые голы',
  `two_three_point_throw` smallint(5) unsigned NOT NULL COMMENT 'Трехочковые броски',
  `two_three_point_percent` smallint(5) unsigned NOT NULL COMMENT 'Соотношение трехочковых бросков',
  `free_made` smallint(5) unsigned NOT NULL COMMENT 'Штрафной гол',
  `free_throw` smallint(5) unsigned NOT NULL COMMENT 'Штрафной бросок',
  `free_percent` smallint(5) unsigned NOT NULL COMMENT 'Соотношение штрафных бросков',
  `offensive_rebound` smallint(5) unsigned NOT NULL COMMENT 'Подборы на чужом щите',
  `deffensive_rebound` smallint(5) unsigned NOT NULL COMMENT 'Подборы на своем щите',
  `sum_rebound` smallint(5) unsigned NOT NULL COMMENT 'Сумма подборов',
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
  PRIMARY KEY (`history_teams_total_id`),
  KEY `season_id` (`season_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Статистика сезона по командам';

-- ----------------------------
-- Records of statistic_players
-- ----------------------------
INSERT INTO `history_teams_total` VALUES (1,1,7,17,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2);
INSERT INTO `history_teams_total` VALUES (2,2,4,17,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2);
INSERT INTO `history_teams_total` VALUES (3,3,5,17,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2);
INSERT INTO `history_teams_total` VALUES (4,4,6,17,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2);
INSERT INTO `history_teams_total` VALUES (5,5,7,17,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2);
SET FOREIGN_KEY_CHECKS=1;

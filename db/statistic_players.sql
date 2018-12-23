
CREATE TABLE `statistic_players` (
  `player_id` int(10) unsigned NOT NULL,
  `game_id` int(10) unsigned NOT NULL COMMENT 'Ссылка на game_id из statistic_games',
  `min` varchar(10) NOT NULL,
  `two-point_made` tinyint(3) unsigned DEFAULT NULL COMMENT 'Двухочковый гол',
  `two-point_throw` tinyint(3) unsigned DEFAULT NULL COMMENT 'Двухочковый бросок',
  `three-point_made` tinyint(3) unsigned DEFAULT NULL COMMENT 'Трехочковый гол',
  `three-point_throw` tinyint(3) unsigned DEFAULT NULL COMMENT 'Трехочковый бросок',
  `free_made` tinyint(3) unsigned DEFAULT NULL COMMENT 'Штрафной гол',
  `free_throw` tinyint(3) unsigned DEFAULT NULL COMMENT 'Штрафной бросок',
  `offensive_rebound` tinyint(3) unsigned DEFAULT NULL COMMENT 'Подборы на чужом щите',
  `deffensive_rebound` tinyint(3) unsigned DEFAULT NULL COMMENT 'Подборы на своем щите',
  `assists` tinyint(3) unsigned DEFAULT NULL COMMENT 'Результативные передачи',
  `commited_foul` tinyint(3) unsigned DEFAULT NULL,
  `recieved_foul` tinyint(3) unsigned DEFAULT NULL COMMENT 'Персональный фол',
  `turnover` tinyint(3) unsigned DEFAULT NULL COMMENT 'Потеря',
  `steal` tinyint(3) unsigned DEFAULT NULL COMMENT 'Перехват',
  `in_fawor` tinyint(3) unsigned DEFAULT NULL COMMENT 'Блок-шоты игрока',
  `against` tinyint(3) unsigned DEFAULT NULL COMMENT 'Блок-шоты, полученные игроком',
  `effectiveness` smallint(4) DEFAULT NULL COMMENT 'Эффективность',
  `plus-minus` tinyint(3) DEFAULT NULL COMMENT 'Показатель «плюс-минус»',
  `points_scored` tinyint(3) unsigned DEFAULT NULL COMMENT 'Очки',
  `games` tinyint(3) unsigned DEFAULT NULL,
  `gs` tinyint(3) DEFAULT NULL COMMENT 'ИС',
  PRIMARY KEY (`player_id`,`game_id`),
  UNIQUE KEY `player_id_game_id` (`player_id`,`game_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Статистика игроков';

-- ----------------------------
-- Records of statistic_players
-- ----------------------------

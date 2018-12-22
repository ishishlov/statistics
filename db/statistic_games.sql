CREATE TABLE `statistic_games` (
  `game_id` int(10) unsigned NOT NULL,
  `dt` date NOT NULL DEFAULT '1901-01-01' COMMENT 'Дата проведения',
  `tournament_id` int(10) unsigned NOT NULL COMMENT 'Id турнира. Ссылка на поле tournament_id из tournaments',
  `team_id` int(10) unsigned NOT NULL COMMENT 'Id команды. Ссылка на team_id из teams',
  `venue` bit(1) NOT NULL COMMENT 'Место проведения. 1 - дом, 0 - гость',
  `season_id` tinyint(3) NOT NULL COMMENT 'Id сезона. Ссылка на поле season_id из seasons',
  PRIMARY KEY (`game_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Статистика игр';

INSERT INTO `statistic_games` VALUES ('1057', '2017-10-05', '1', '24', '', '17');
INSERT INTO `statistic_games` VALUES ('1058', '2017-10-09', '1', '8', '', '17');
INSERT INTO `statistic_games` VALUES ('1059', '2017-10-13', '2', '7', '', '17');

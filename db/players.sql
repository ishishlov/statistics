
CREATE TABLE `players` (
  `player_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT 'Фамилия Имя игрока',
  PRIMARY KEY (`player_id`)
) ENGINE=InnoDB AUTO_INCREMENT=180 DEFAULT CHARSET=utf8 COMMENT='Список игроков';

-- ----------------------------
-- Records of players
-- ----------------------------
INSERT INTO `players` VALUES ('81', 'ШВЕД Алексей');
INSERT INTO `players` VALUES ('103', 'ЗАЙЦЕВ Вячеслав');
INSERT INTO `players` VALUES ('113', 'МОНЯ Сергей');
INSERT INTO `players` VALUES ('124', 'ВЯЛЬЦЕВ Егор');
INSERT INTO `players` VALUES ('142', 'ПАТЕЕВ Руслан');
INSERT INTO `players` VALUES ('155', 'ХАННИКАТТ Тайлер');
INSERT INTO `players` VALUES ('156', 'СОКОЛОВ Дмитрий');
INSERT INTO `players` VALUES ('157', 'ТОДОРОВИЧ Марко');
INSERT INTO `players` VALUES ('161', 'ЯКУШИН Тимофей');
INSERT INTO `players` VALUES ('171', 'ДЖЕНКИНС Чарльз');
INSERT INTO `players` VALUES ('172', 'МАРКОВИЧ Стефан');
INSERT INTO `players` VALUES ('173', 'АНДЕРСОН Джеймс');
INSERT INTO `players` VALUES ('174', 'ЗУБКОВ Андрей');
INSERT INTO `players` VALUES ('175', 'ГИЛЛ Энтони');
INSERT INTO `players` VALUES ('176', 'ТОМАС Малькольм');
INSERT INTO `players` VALUES ('177', 'ТКАЧЕНКО Максим');
INSERT INTO `players` VALUES ('178', 'ПРОЩЕНКО Маским');
INSERT INTO `players` VALUES ('179', 'РОБИНСОН Томас');

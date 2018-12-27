CREATE TABLE `teams` (
  `team_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT 'Название команды',
  PRIMARY KEY (`team_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COMMENT='Список команд';

-- ----------------------------
-- Records of teams
-- ----------------------------
INSERT INTO `teams` VALUES ('1', 'АВТОДОР');
INSERT INTO `teams` VALUES ('2', 'АНАДОЛУ ЭФЕС');
INSERT INTO `teams` VALUES ('3', 'АСТАНА');
INSERT INTO `teams` VALUES ('4', 'БАРСЕЛОНА');
INSERT INTO `teams` VALUES ('5', 'БАСКОНИЯ');
INSERT INTO `teams` VALUES ('6', 'БРОЗЕ');
INSERT INTO `teams` VALUES ('7', 'ВАЛЕНСИИЯ');
INSERT INTO `teams` VALUES ('8', 'ВЭФ');
INSERT INTO `teams` VALUES ('9', 'ЕНИСЕЙ');
INSERT INTO `teams` VALUES ('10', 'ЖАЛЬГИРИС');
INSERT INTO `teams` VALUES ('11', 'ЗЕНИТ');
INSERT INTO `teams` VALUES ('12', 'КАЛЕВ');
INSERT INTO `teams` VALUES ('13', 'ЛОКОМОТИВ');
INSERT INTO `teams` VALUES ('14', 'МАККАБИ');
INSERT INTO `teams` VALUES ('15', 'МИЛАН');
INSERT INTO `teams` VALUES ('16', 'НИЖНИЙ НОВГОРОД');
INSERT INTO `teams` VALUES ('17', 'ОЛИМПИАКОС');
INSERT INTO `teams` VALUES ('18', 'ПАНАТИНАИКОС');
INSERT INTO `teams` VALUES ('19', 'ПАРМА');
INSERT INTO `teams` VALUES ('20', 'РЕАЛ');
INSERT INTO `teams` VALUES ('21', 'УНИКАХА');
INSERT INTO `teams` VALUES ('22', 'УНИКС');
INSERT INTO `teams` VALUES ('23', 'ФЕНЕРБАХЧЕ');
INSERT INTO `teams` VALUES ('24', 'ЦМОКИ');
INSERT INTO `teams` VALUES ('25', 'ЦРВЕНА ЗВЕЗДА');
INSERT INTO `teams` VALUES ('26', 'ЦСКА');


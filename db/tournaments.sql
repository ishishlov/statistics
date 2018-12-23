
CREATE TABLE `tournaments` (
  `tournament_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT 'Название турнира',
  PRIMARY KEY (`tournament_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Список турниров';

-- ----------------------------
-- Records of tournaments
-- ----------------------------
INSERT INTO `tournaments` VALUES ('1', 'ВТБ');
INSERT INTO `tournaments` VALUES ('2', 'ЕЛ');

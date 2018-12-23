
CREATE TABLE `seasons` (
  `season_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT 'Дата сезона',
  PRIMARY KEY (`season_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COMMENT='Список сезонов';

-- ----------------------------
-- Records of seasons
-- ----------------------------
INSERT INTO `seasons` VALUES ('10', '2010-11');
INSERT INTO `seasons` VALUES ('11', '2011-12');
INSERT INTO `seasons` VALUES ('12', '2012-13');
INSERT INTO `seasons` VALUES ('13', '2013-14');
INSERT INTO `seasons` VALUES ('14', '2014-15');
INSERT INTO `seasons` VALUES ('15', '2015-16');
INSERT INTO `seasons` VALUES ('16', '2016-17');
INSERT INTO `seasons` VALUES ('17', '2017-18');
INSERT INTO `seasons` VALUES ('18', '2018-19');
INSERT INTO `seasons` VALUES ('19', '2019-20');
INSERT INTO `seasons` VALUES ('20', '2020-21');
INSERT INTO `seasons` VALUES ('21', '2021-22');
INSERT INTO `seasons` VALUES ('22', '2022-23');
INSERT INTO `seasons` VALUES ('23', '2023-24');
INSERT INTO `seasons` VALUES ('24', '2024-25');
INSERT INTO `seasons` VALUES ('25', '2025-26');
INSERT INTO `seasons` VALUES ('26', '2026-27');
INSERT INTO `seasons` VALUES ('27', '2027-28');
INSERT INTO `seasons` VALUES ('28', '2028-29');
INSERT INTO `seasons` VALUES ('29', '2029-30');
INSERT INTO `seasons` VALUES ('30', '2030-31');

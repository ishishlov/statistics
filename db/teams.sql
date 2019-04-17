/*
Navicat MySQL Data Transfer

Source Server         : statistics
Source Server Version : 50638
Source Host           : localhost:3306
Source Database       : statistics

Target Server Type    : MYSQL
Target Server Version : 50638
File Encoding         : 65001

Date: 2019-04-09 22:59:47
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for teams
-- ----------------------------
DROP TABLE IF EXISTS `teams`;
CREATE TABLE `teams` (
  `team_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT 'Название команды',
  `logo_url` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  PRIMARY KEY (`team_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COMMENT='Список команд';

-- ----------------------------
-- Records of teams
-- ----------------------------
INSERT INTO `teams` VALUES ('1', 'АВТОДОР', '', '');
INSERT INTO `teams` VALUES ('2', 'АНАДОЛУ ЭФЕС', '/images/command_logos/anadolu_efes.jpg', 'https://www.anadoluefessk.org/en');
INSERT INTO `teams` VALUES ('3', 'АСТАНА', '', '');
INSERT INTO `teams` VALUES ('4', 'БАВАРИЯ', '/images/command_logos/bavaria.jpg', 'https://fcb-basketball.de/en');
INSERT INTO `teams` VALUES ('5', 'БАРСЕЛОНА', '/images/command_logos/barselona.jpg', 'https://www.fcbarcelona.com/en/basketball/');
INSERT INTO `teams` VALUES ('6', 'БАСКОНИЯ', '/images/command_logos/basconia.jpg', 'https://www.baskonia.com/inicio/');
INSERT INTO `teams` VALUES ('7', 'БК ХИМКИ', '/images/command_logos/bkchimki.jpg', '');
INSERT INTO `teams` VALUES ('8', 'БРОЗЕ', '', '');
INSERT INTO `teams` VALUES ('9', 'БУДУЧНОСТЬ', '/images/command_logos/buduchnost.jpg', 'https://www.kkbuducnost.me/');
INSERT INTO `teams` VALUES ('10', 'ВАЛЕНСИЯ', '', '');
INSERT INTO `teams` VALUES ('11', 'ВЭФ', '', '');
INSERT INTO `teams` VALUES ('12', 'ГРАН-КАНАРИЯ', '/images/command_logos/gran_kanaria.jpg', 'https://cbgrancanaria.net/en/');
INSERT INTO `teams` VALUES ('13', 'ДАРЮШШАФАКА', '/images/command_logos/darushshafaka.jpg', 'http://www.darussafakabasketbol.com/');
INSERT INTO `teams` VALUES ('14', 'ЕНИСЕЙ', '', '');
INSERT INTO `teams` VALUES ('15', 'ЖАЛЬГИРИС', '/images/command_logos/zhalgiris.jpg', 'http://zalgiris.lt/en/');
INSERT INTO `teams` VALUES ('16', 'ЗЕНИТ', '', '');
INSERT INTO `teams` VALUES ('17', 'КАЛЕВ', '', '');
INSERT INTO `teams` VALUES ('18', 'ЛОКОМОТИВ', '', '');
INSERT INTO `teams` VALUES ('19', 'МАККАБИ', '/images/command_logos/makkabi_tel_aviv.jpg', 'http://www.maccabi.co.il/?lang=en');
INSERT INTO `teams` VALUES ('20', 'МИЛАН', '/images/command_logos/olimpia_milan.jpg', 'http://www.olimpiamilano.com/en/');
INSERT INTO `teams` VALUES ('21', 'НИЖНИЙ НОВГОРОД', '', '');
INSERT INTO `teams` VALUES ('22', 'ОЛИМПИАКОС', '/images/command_logos/olimpiakos.jpg', 'http://www.olympiacosbc.gr/en/');
INSERT INTO `teams` VALUES ('23', 'ПАНАТИНАИКОС', '/images/command_logos/panatinaikos.jpg', 'https://www.paobc.gr/page.ashx?pid=1&lang=2');
INSERT INTO `teams` VALUES ('24', 'ПАРМА', '', '');
INSERT INTO `teams` VALUES ('25', 'РЕАЛ', '/images/command_logos/real_madrid.jpg', 'https://www.realmadrid.com/en/basketball');
INSERT INTO `teams` VALUES ('26', 'УНИКАХА', '', '');
INSERT INTO `teams` VALUES ('27', 'УНИКС', '', '');
INSERT INTO `teams` VALUES ('28', 'ФЕНЕРБАХЧЕ', '/images/command_logos/fenerbachche.jpg', 'https://www.fenerbahce.org/basketbolerkek/');
INSERT INTO `teams` VALUES ('29', 'ЦМОКИ', '', '');
INSERT INTO `teams` VALUES ('30', 'ЦРВЕНА ЗВЕЗДА', '', '');
INSERT INTO `teams` VALUES ('31', 'ЦСКА', '/images/command_logos/cska.jpg', 'https://cskabasket.com/');

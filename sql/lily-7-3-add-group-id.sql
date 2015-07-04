/*
Navicat MySQL Data Transfer

Source Server         : localhost_3309
Source Server Version : 50403
Source Host           : localhost:3309
Source Database       : lily

Target Server Type    : MYSQL
Target Server Version : 50403
File Encoding         : 65001

Date: 2015-07-03 11:23:56
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `balance`
-- ----------------------------
DROP TABLE IF EXISTS `balance`;
CREATE TABLE `balance` (
  `creditor` varchar(30) NOT NULL,
  `debtor` varchar(30) NOT NULL,
  `amount` float(10,2) unsigned zerofill NOT NULL,
  PRIMARY KEY (`creditor`,`debtor`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of balance
-- ----------------------------
INSERT INTO `balance` VALUES ('cdh', 'ty', '0000000.00');
INSERT INTO `balance` VALUES ('cdh', 'zl', '0000000.00');
INSERT INTO `balance` VALUES ('ty', 'cdh', '0000000.00');
INSERT INTO `balance` VALUES ('ty', 'zl', '0000000.00');
INSERT INTO `balance` VALUES ('zl', 'cdh', '0000000.00');
INSERT INTO `balance` VALUES ('zl', 'ty', '0000017.00');
INSERT INTO `balance` VALUES ('meng', 'zl', '0000000.00');
INSERT INTO `balance` VALUES ('zl', 'meng', '0000001.83');
INSERT INTO `balance` VALUES ('meng', 'cdh', '0000000.00');
INSERT INTO `balance` VALUES ('cdh', 'meng', '0000000.00');
INSERT INTO `balance` VALUES ('meng', 'ty', '0000021.16');
INSERT INTO `balance` VALUES ('ty', 'meng', '0000000.00');

-- ----------------------------
-- Table structure for `trans_detail`
-- ----------------------------
DROP TABLE IF EXISTS `trans_detail`;
CREATE TABLE `trans_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `trans_id` bigint(20) NOT NULL,
  `debtor` varchar(30) NOT NULL,
  `amount` float(10,2) NOT NULL,
  `percent` float(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `trans_id` (`trans_id`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of trans_detail
-- ----------------------------
INSERT INTO `trans_detail` VALUES ('1', '143564913038', 'zl', '10.00', null);
INSERT INTO `trans_detail` VALUES ('2', '143564913038', 'ty', '10.00', null);
INSERT INTO `trans_detail` VALUES ('3', '143564913038', 'meng', '10.00', null);
INSERT INTO `trans_detail` VALUES ('4', '143564922018', 'zl', '7.00', null);
INSERT INTO `trans_detail` VALUES ('5', '143564922018', 'ty', '7.00', null);
INSERT INTO `trans_detail` VALUES ('6', '143564922018', 'meng', '7.00', null);
INSERT INTO `trans_detail` VALUES ('7', '143568555582', 'meng', '9.99', null);
INSERT INTO `trans_detail` VALUES ('8', '143573059364', 'zl', '7.50', null);
INSERT INTO `trans_detail` VALUES ('9', '143573059364', 'meng', '15.00', null);
INSERT INTO `trans_detail` VALUES ('10', '143573059364', 'ty', '7.50', null);
INSERT INTO `trans_detail` VALUES ('11', '143573110105', 'zl', '13.33', null);
INSERT INTO `trans_detail` VALUES ('12', '143573110105', 'meng', '13.33', null);
INSERT INTO `trans_detail` VALUES ('13', '143573110105', 'ty', '13.33', null);
INSERT INTO `trans_detail` VALUES ('14', '143573282217', 'zl', '0.33', null);
INSERT INTO `trans_detail` VALUES ('15', '143573282217', 'meng', '0.33', null);
INSERT INTO `trans_detail` VALUES ('16', '143573282217', 'ty', '0.33', null);

-- ----------------------------
-- Table structure for `transaction`
-- ----------------------------
DROP TABLE IF EXISTS `transaction`;
CREATE TABLE `transaction` (
  `id` bigint(20) NOT NULL,
  `username` varchar(30) NOT NULL,
  `type` varchar(30) NOT NULL,
  `message` varchar(1000) DEFAULT NULL,
  `amount` float(10,2) NOT NULL,
  `date` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of transaction
-- ----------------------------
INSERT INTO `transaction` VALUES ('143564913038', 'zl', 'buy', 'mekong å¤–å–æ™šé¥­---- shared with zl,ty,meng----ty owe zl from $0.0 to $10.0----meng owe zl from $0.0 to $10.0', '30.00', '6-29');
INSERT INTO `transaction` VALUES ('143564922018', 'zl', 'buy', 'mekong èœç­‰---- shared with zl,ty,meng----ty owe zl from $10.0 to $17.0----meng owe zl from $10.0 to $17.0', '21.00', '6-29');
INSERT INTO `transaction` VALUES ('143568555582', 'zl', 'buy', 'Car Mount, AVANTEK Universal Cell Phone Air Vent Car Mount Holder for iPhone 6 / 6 Plus / 5S / 5C / 4S, Samsung Galaxy S6 / S6 Edge / S5 / S4 / S3 / Note 4/3, Google Nexus 5/4, LG G4, Nokia, Xperia, Moto, HTC---- shared with meng----meng owe zl from $17.0', '9.99', '6-30');
INSERT INTO `transaction` VALUES ('143572986871', 'meng', 'pay', '----meng owe zl from $26.99 to $25.99', '1.00', '2015-06-30 22:51:08.714000');
INSERT INTO `transaction` VALUES ('143573034603', 'meng', 'pay', '----meng owe zl from $25.99 to $23.99', '2.00', '2015-06-30 22:59:06.037000');
INSERT INTO `transaction` VALUES ('143573059364', 'meng', 'buy', 'å“ˆå“ˆå“ˆå“ˆå“ˆå“ˆå“ˆ---- shared with zl,meng*2,ty----meng yang owe zhang lei from $23.99 to $16.49----tang yue owe meng yang from $0.0 to $7.5', '30.00', '6-30');
INSERT INTO `transaction` VALUES ('143573088527', 'meng', 'pay', '----meng yang owe zhang lei from $16.49 to $15.49', '1.00', '2015-06-30 23:08:05.272000');
INSERT INTO `transaction` VALUES ('143573110105', 'meng', 'buy', 'qwewewqe---- shared with zhang lei,meng yang,tang yue----meng yang owe zhang lei from $15.49 to $2.15666666667----tang yue owe meng yang from $7.5 to $20.8333333333', '40.00', '21213');
INSERT INTO `transaction` VALUES ('143573282217', 'meng', 'buy', 'sadsd---- shared with zhang lei,meng yang,tang yue----meng yang owe zhang lei from $2.16 to $1.83----tang yue owe meng yang from $20.83 to $21.16', '1.00', 'swewqew');

-- ----------------------------
-- Table structure for `users`
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL,
  `screen_name` varchar(30) NOT NULL,
  `type` varchar(30) NOT NULL COMMENT 'normal or super',
  `group_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('1', 'zl', '123', 'zhang lei', 'normal', '1');
INSERT INTO `users` VALUES ('2', 'cdh', '123', 'cdh', 'normal', '3');
INSERT INTO `users` VALUES ('3', 'ty', '123', 'Tang Yue', 'normal', '1');
INSERT INTO `users` VALUES ('4', 'root', '123', 'root', 'super', '0');
INSERT INTO `users` VALUES ('5', 'meng', '123', 'meng yang', 'normal', '1');

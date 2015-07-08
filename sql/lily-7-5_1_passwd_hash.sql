/*
Navicat MySQL Data Transfer

Source Server         : localhost_3309
Source Server Version : 50403
Source Host           : localhost:3309
Source Database       : lily

Target Server Type    : MYSQL
Target Server Version : 50403
File Encoding         : 65001

Date: 2015-07-05 11:58:46
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
INSERT INTO `balance` VALUES ('ty', 'zl', '0000034.53');
INSERT INTO `balance` VALUES ('zl', 'cdh', '0000000.00');
INSERT INTO `balance` VALUES ('zl', 'ty', '0000000.00');
INSERT INTO `balance` VALUES ('meng', 'zl', '0000000.00');
INSERT INTO `balance` VALUES ('zl', 'meng', '0000010.90');
INSERT INTO `balance` VALUES ('meng', 'cdh', '0000000.00');
INSERT INTO `balance` VALUES ('cdh', 'meng', '0000000.00');
INSERT INTO `balance` VALUES ('meng', 'ty', '0000000.00');
INSERT INTO `balance` VALUES ('ty', 'meng', '0000000.00');
INSERT INTO `balance` VALUES ('April', 'zl', '0000000.00');
INSERT INTO `balance` VALUES ('zl', 'April', '0000000.00');
INSERT INTO `balance` VALUES ('April', 'cdh', '0000000.00');
INSERT INTO `balance` VALUES ('cdh', 'April', '0000000.00');
INSERT INTO `balance` VALUES ('April', 'ty', '0000000.00');
INSERT INTO `balance` VALUES ('ty', 'April', '0000000.00');
INSERT INTO `balance` VALUES ('April', 'meng', '0000000.00');
INSERT INTO `balance` VALUES ('meng', 'April', '0000000.00');
INSERT INTO `balance` VALUES ('Sophie', 'zl', '0000000.00');
INSERT INTO `balance` VALUES ('zl', 'Sophie', '0000000.00');
INSERT INTO `balance` VALUES ('Sophie', 'cdh', '0000000.00');
INSERT INTO `balance` VALUES ('cdh', 'Sophie', '0000000.00');
INSERT INTO `balance` VALUES ('Sophie', 'ty', '0000000.00');
INSERT INTO `balance` VALUES ('ty', 'Sophie', '0000000.00');
INSERT INTO `balance` VALUES ('Sophie', 'meng', '0000000.00');
INSERT INTO `balance` VALUES ('meng', 'Sophie', '0000000.00');
INSERT INTO `balance` VALUES ('Sophie', 'April', '0000000.00');
INSERT INTO `balance` VALUES ('April', 'Sophie', '0000000.00');
INSERT INTO `balance` VALUES ('zhuzhu', 'zl', '0000000.00');
INSERT INTO `balance` VALUES ('zl', 'zhuzhu', '0000000.00');
INSERT INTO `balance` VALUES ('zhuzhu', 'cdh', '0000000.00');
INSERT INTO `balance` VALUES ('cdh', 'zhuzhu', '0000000.00');
INSERT INTO `balance` VALUES ('zhuzhu', 'ty', '0000000.00');
INSERT INTO `balance` VALUES ('ty', 'zhuzhu', '0000000.00');
INSERT INTO `balance` VALUES ('zhuzhu', 'meng', '0000000.00');
INSERT INTO `balance` VALUES ('meng', 'zhuzhu', '0000000.00');
INSERT INTO `balance` VALUES ('zhuzhu', 'April', '0000000.00');
INSERT INTO `balance` VALUES ('April', 'zhuzhu', '0000000.00');
INSERT INTO `balance` VALUES ('zhuzhu', 'Sophie', '0000000.00');
INSERT INTO `balance` VALUES ('Sophie', 'zhuzhu', '0000000.00');

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
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

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
INSERT INTO `trans_detail` VALUES ('8', '143586772023', 'zl', '69.00', null);
INSERT INTO `trans_detail` VALUES ('9', '143586772023', 'ty', '69.00', null);
INSERT INTO `trans_detail` VALUES ('10', '143598794011', 'zl', '9.04', null);
INSERT INTO `trans_detail` VALUES ('11', '143598794011', 'meng', '9.04', null);
INSERT INTO `trans_detail` VALUES ('12', '143598794011', 'ty', '9.04', null);
INSERT INTO `trans_detail` VALUES ('13', '143598799557', 'zl', '1.86', null);
INSERT INTO `trans_detail` VALUES ('14', '143598799557', 'meng', '1.86', null);
INSERT INTO `trans_detail` VALUES ('15', '143598799557', 'ty', '1.86', null);
INSERT INTO `trans_detail` VALUES ('16', '143598809567', 'zl', '2.50', null);
INSERT INTO `trans_detail` VALUES ('17', '143598809567', 'ty', '2.50', null);
INSERT INTO `trans_detail` VALUES ('18', '143598814311', 'zl', '4.06', null);
INSERT INTO `trans_detail` VALUES ('19', '143598814311', 'ty', '4.06', null);

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
INSERT INTO `transaction` VALUES ('143577921630', 'meng', 'pay', '----meng owe zhang lei from $26.99 to $0.00', '26.99', '2015-07-02 03:33:36.304658');
INSERT INTO `transaction` VALUES ('143586772023', 'ty', 'buy', 'Cabanaå®šé‡‘---- shared with zhang lei,ty----zhang lei owe ty from $-17.00 to $52.00', '138.00', '7-2');
INSERT INTO `transaction` VALUES ('143596759900', 'zl', 'pay', '----zhang lei owe ty from $52.00 to $51.99', '0.01', '2015-07-04 07:53:19.006167');
INSERT INTO `transaction` VALUES ('143598794011', 'zl', 'buy', 'å¾·å·žæ‰’é¸¡ï¼Œæ¢…èœç­‰---- shared with zhang lei,meng,ty----meng owe zhang lei from $0.00 to $9.04----zhang lei owe ty from $51.99 to $42.95', '27.11', '7/3/2015');
INSERT INTO `transaction` VALUES ('143598799557', 'zl', 'buy', 'ä»Šå¤©çš„æ™šé¥­---- shared with zhang lei,meng,ty----meng owe zhang lei from $9.04 to $10.90----zhang lei owe ty from $42.95 to $41.09', '5.58', '7/3/2015');
INSERT INTO `transaction` VALUES ('143598809567', 'zl', 'buy', 'æ—©é¥­è›‹ç³•---- shared with zhang lei,ty----zhang lei owe ty from $41.09 to $38.59', '5.00', '6/25/2015');
INSERT INTO `transaction` VALUES ('143598814311', 'zl', 'buy', 'çŸ¿æ³‰æ°´å’Œé¢åŒ…---- shared with zhang lei,ty----zhang lei owe ty from $38.59 to $34.53', '8.12', '7/3/2015');

-- ----------------------------
-- Table structure for `users`
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `password` varchar(50) NOT NULL,
  `screen_name` varchar(30) NOT NULL,
  `type` varchar(30) NOT NULL COMMENT 'normal or super',
  `group_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('1', 'zl', '3aad20e566bf9d5585c9dfbafae029f9', 'zhang lei', 'normal', '1');
INSERT INTO `users` VALUES ('2', 'cdh', '3aad20e566bf9d5585c9dfbafae029f9', 'cdh', 'normal', '2');
INSERT INTO `users` VALUES ('3', 'ty', '3aad20e566bf9d5585c9dfbafae029f9', 'ty', 'normal', '1');
INSERT INTO `users` VALUES ('4', 'root', '3aad20e566bf9d5585c9dfbafae029f9', 'root', 'super', '0');
INSERT INTO `users` VALUES ('5', 'meng', '3aad20e566bf9d5585c9dfbafae029f9', 'meng', 'normal', '1');
INSERT INTO `users` VALUES ('7', 'April', '160173b2b4a677e3465d2b2a31af12d6', 'April', 'normal', '3');
INSERT INTO `users` VALUES ('8', 'Sophie', '2116207468f3d58bfe2b49615a2a474a', 'Sophie', 'normal', '3');

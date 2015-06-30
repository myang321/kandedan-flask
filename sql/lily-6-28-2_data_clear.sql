/*
Navicat MySQL Data Transfer

Source Server         : localhost_3309
Source Server Version : 50403
Source Host           : localhost:3309
Source Database       : lily

Target Server Type    : MYSQL
Target Server Version : 50403
File Encoding         : 65001

Date: 2015-06-28 20:50:13
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of balance
-- ----------------------------
INSERT INTO `balance` VALUES ('cdh', 'ty', '0000000.00');
INSERT INTO `balance` VALUES ('cdh', 'zl', '0000000.00');
INSERT INTO `balance` VALUES ('ty', 'cdh', '0000000.00');
INSERT INTO `balance` VALUES ('ty', 'zl', '0000000.00');
INSERT INTO `balance` VALUES ('zl', 'cdh', '0000000.00');
INSERT INTO `balance` VALUES ('zl', 'ty', '0000000.00');

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
  KEY `trans_id` (`trans_id`),
  CONSTRAINT `trans_id` FOREIGN KEY (`trans_id`) REFERENCES `transaction` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of trans_detail
-- ----------------------------

-- ----------------------------
-- Table structure for `transaction`
-- ----------------------------
DROP TABLE IF EXISTS `transaction`;
CREATE TABLE `transaction` (
  `id` bigint(20) NOT NULL,
  `username` varchar(30) NOT NULL,
  `type` varchar(30) NOT NULL,
  `message` varchar(255) DEFAULT NULL,
  `amount` float(10,2) NOT NULL,
  `date` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of transaction
-- ----------------------------

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
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('1', 'zl', '123', 'zhang lei', 'normal');
INSERT INTO `users` VALUES ('2', 'cdh', '123', 'cdh', 'normal');
INSERT INTO `users` VALUES ('3', 'ty', '123', 'ty', 'normal');
INSERT INTO `users` VALUES ('4', 'root', '123', 'root', 'super');

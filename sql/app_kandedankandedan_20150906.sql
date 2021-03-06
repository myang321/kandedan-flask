-- phpMyAdmin SQL Dump
-- version 3.3.8.1
-- http://www.phpmyadmin.net
--
-- 主机: w.rdc.sae.sina.com.cn:3307
-- 生成日期: 2015 年 09 月 07 日 07:54
-- 服务器版本: 5.5.23
-- PHP 版本: 5.3.3

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 数据库: `app_kandedan`
--

-- --------------------------------------------------------

--
-- 表的结构 `balance`
--

CREATE TABLE IF NOT EXISTS `balance` (
  `creditor` varchar(30) NOT NULL,
  `debtor` varchar(30) NOT NULL,
  `amount` float(10,2) unsigned zerofill NOT NULL,
  PRIMARY KEY (`creditor`,`debtor`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- 转存表中的数据 `balance`
--

INSERT INTO `balance` (`creditor`, `debtor`, `amount`) VALUES
('ty', 'zl', 0000000.00),
('zl', 'ty', 0000085.59),
('meng', 'zl', 0000000.00),
('zl', 'meng', 0000017.08),
('meng', 'ty', 0000003.78),
('ty', 'meng', 0000000.00),
('April', 'Sophie', 0000000.00),
('Sophie', 'April', 0000000.00);

-- --------------------------------------------------------

--
-- 表的结构 `groups`
--

CREATE TABLE IF NOT EXISTS `groups` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL DEFAULT '',
  `holder` varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `hehe` (`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=17 ;

--
-- 转存表中的数据 `groups`
--

INSERT INTO `groups` (`id`, `name`, `holder`) VALUES
(1, 'kandedan', 'meng'),
(2, 'cdh', 'cdh'),
(3, 'april', 'April');

-- --------------------------------------------------------

--
-- 表的结构 `transaction`
--

CREATE TABLE IF NOT EXISTS `transaction` (
  `id` bigint(20) NOT NULL,
  `username` varchar(30) NOT NULL,
  `type` varchar(30) NOT NULL,
  `message` varchar(1000) DEFAULT NULL,
  `amount` float(10,2) NOT NULL,
  `date` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- 转存表中的数据 `transaction`
--

INSERT INTO `transaction` (`id`, `username`, `type`, `message`, `amount`, `date`) VALUES
(143564913038, 'zl', 'buy', 'mekong å¤–å–æ™šé¥­---- shared with zl,ty,meng----ty owe zl from $0.0 to $10.0----meng owe zl from $0.0 to $10.0', 30.00, '6-29'),
(143564922018, 'zl', 'buy', 'mekong èœç­‰---- shared with zl,ty,meng----ty owe zl from $10.0 to $17.0----meng owe zl from $10.0 to $17.0', 21.00, '6-29'),
(143568555582, 'zl', 'buy', 'Car Mount, AVANTEK Universal Cell Phone Air Vent Car Mount Holder for iPhone 6 / 6 Plus / 5S / 5C / 4S, Samsung Galaxy S6 / S6 Edge / S5 / S4 / S3 / Note 4/3, Google Nexus 5/4, LG G4, Nokia, Xperia, Moto, HTC---- shared with meng----meng owe zl from $17.0', 9.99, '6-30'),
(143577921630, 'meng', 'pay', '----meng owe zhang lei from $26.99 to $0.00', 26.99, '2015-07-02 03:33:36.304658'),
(143586772023, 'ty', 'buy', 'Cabanaå®šé‡‘---- shared with zhang lei,ty----zhang lei owe ty from $-17.00 to $52.00', 138.00, '7-2'),
(143596759900, 'zl', 'pay', '----zhang lei owe ty from $52.00 to $51.99', 0.01, '2015-07-04 07:53:19.006167'),
(143598794011, 'zl', 'buy', 'å¾·å·žæ‰’é¸¡ï¼Œæ¢…èœç­‰---- shared with zhang lei,meng,ty----meng owe zhang lei from $0.00 to $9.04----zhang lei owe ty from $51.99 to $42.95', 27.11, '7/3/2015'),
(143598799557, 'zl', 'buy', 'ä»Šå¤©çš„æ™šé¥­---- shared with zhang lei,meng,ty----meng owe zhang lei from $9.04 to $10.90----zhang lei owe ty from $42.95 to $41.09', 5.58, '7/3/2015'),
(143598809567, 'zl', 'buy', 'æ—©é¥­è›‹ç³•---- shared with zhang lei,ty----zhang lei owe ty from $41.09 to $38.59', 5.00, '6/25/2015'),
(143598814311, 'zl', 'buy', 'çŸ¿æ³‰æ°´å’Œé¢åŒ…---- shared with zhang lei,ty----zhang lei owe ty from $38.59 to $34.53', 8.12, '7/3/2015'),
(143613203595, 'meng', 'buy', 'ç¾Žç©ºä¹°èœ æŽ’éª¨ï¼Œé¸­ç¿…---- shared with zhang lei,meng,ty----meng owe zhang lei from $10.90 to $1.39----ty owe meng from $0.00 to $9.51', 28.53, '7-5'),
(143640395989, 'zl', 'buy', 'food city tomato,potato---- shared with å¼ å¤§ç¾Žå¥³,meng,å”è¶Š----meng owe å¼ å¤§ç¾Žå¥³ from $1.39 to $2.81----å¼ å¤§ç¾Žå¥³ owe å”è¶Š from $34.53 to $33.11', 4.26, '7-8'),
(143650456058, 'zl', 'buy', 'æ°´ foodcity---- shared with å¼ å¤§ç¾Žå¥³,å”è¶Š----å¼ å¤§ç¾Žå¥³ owe å”è¶Š from $33.11 to $31.08', 4.06, '7-8'),
(143658743236, 'zl', 'buy', 'mekong,sushi+food---- shared with å¼ å¤§ç¾Žå¥³,meng,å”è¶Š----meng owe å¼ å¤§ç¾Žå¥³ from $2.81 to $18.15----å¼ å¤§ç¾Žå¥³ owe å”è¶Š from $31.08 to $15.74', 46.03, '2015-7-10'),
(143658747011, 'zl', 'buy', 'adidas ---- shared with å¼ å¤§ç¾Žå¥³,meng----meng owe å¼ å¤§ç¾Žå¥³ from $18.15 to $25.68', 15.06, '2015-7-10'),
(143658761491, 'meng', 'buy', 'crocså‡‰éž‹---- shared with å¼ å¤§ç¾Žå¥³----meng owe å¼ å¤§ç¾Žå¥³ from $25.68 to $20.68', 5.00, '7-10'),
(143658899002, 'zl', 'buy', 'amazonè±šéª¨æ‹‰é¢---- shared with meng----meng owe å¼ å¤§ç¾Žå¥³ from $20.68 to $31.55', 10.87, '7-10'),
(143673116060, 'zl', 'buy', 'amazon \r\nAveeno Eczema Therapy Moisturizing Cream, 7.3 oz.---- shared with meng----meng owe å¼ å¤§ç¾Žå¥³ from $31.55 to $42.63', 11.08, '7-12'),
(143673125840, 'meng', 'buy', 'é¢åŒ…---- shared with å¼ å¤§ç¾Žå¥³,å”è¶Š----meng owe å¼ å¤§ç¾Žå¥³ from $42.63 to $41.13----å”è¶Š owe meng from $9.51 to $11.01', 3.00, '7-11'),
(143673132450, 'meng', 'buy', 'foodcity æ°´ï¼Œç•ªèŒ„---- shared with å¼ å¤§ç¾Žå¥³,meng,å”è¶Š----meng owe å¼ å¤§ç¾Žå¥³ from $41.13 to $40.50----å”è¶Š owe meng from $11.01 to $11.64', 1.90, '7-12'),
(143673165249, 'ty', 'buy', '07/08 frys fushuai chifan---- shared with å¼ å¤§ç¾Žå¥³,meng,å”è¶Š----å¼ å¤§ç¾Žå¥³ owe å”è¶Š from $15.74 to $19.67----å”è¶Š owe meng from $11.64 to $7.71', 11.78, ''),
(143690593311, 'ty', 'buy', 'mekong ä¹°çš„èœ---- shared with å¼ å¤§ç¾Žå¥³,meng,è¶Šå§å¤§å¤§----å¼ å¤§ç¾Žå¥³ owe è¶Šå§å¤§å¤§ from $19.67 to $31.99----meng owe è¶Šå§å¤§å¤§ from $-7.71 to $4.61', 36.95, '2015-07-14'),
(143691255124, 'ty', 'buy', 'safeway---- shared with å¼ å¤§ç¾Žå¥³,è¶Šå§å¤§å¤§----å¼ å¤§ç¾Žå¥³ owe è¶Šå§å¤§å¤§ from $31.99 to $43.89', 23.80, '2015-07-14'),
(143691257435, 'ty', 'buy', 'safeway é¢åŒ…---- shared with meng----meng owe è¶Šå§å¤§å¤§ from $4.61 to $9.66', 5.05, '2015-07-14'),
(143691267802, 'meng', 'buy', 'å®¶å…·---- shared with è¶Šå§å¤§å¤§----è¶Šå§å¤§å¤§ owe meng from $-9.66 to $30.34', 40.00, '2015-07-14'),
(143691273443, 'meng', 'buy', 'å®¶å…·---- shared with å¼ å¤§ç¾Žå¥³----å¼ å¤§ç¾Žå¥³ owe meng from $-40.50 to $19.50', 60.00, '2015-07-14'),
(143726224665, 'meng', 'buy', 'food city æ°´ï¼Œç•ªèŒ„---- shared with å¼ å¤§ç¾Žå¥³,å“ˆå“ˆå“ˆ,è¶Šå§å¤§å¤§----å¼ å¤§ç¾Žå¥³ owe å“ˆå“ˆå“ˆ from $19.50 to $20.42----è¶Šå§å¤§å¤§ owe å“ˆå“ˆå“ˆ from $30.34 to $31.26', 2.75, '2015-07-18'),
(143726968901, 'zl', 'buy', 'ç…Žè›‹é”…---- shared with å“ˆå“ˆå“ˆ----å¼ å¤§ç¾Žå¥³ owe å“ˆå“ˆå“ˆ from $20.42 to $14.51', 5.91, '2015-07-18'),
(143727666932, 'zl', 'buy', 'mekong ç«é”…---- shared with å¼ å¤§ç¾Žå¥³,å“ˆå“ˆå“ˆ,è¶Šå§å¤§å¤§----å“ˆå“ˆå“ˆ owe å¼ å¤§ç¾Žå¥³ from $-14.51 to $4.66----å¼ å¤§ç¾Žå¥³ owe è¶Šå§å¤§å¤§ from $43.89 to $24.72', 57.52, '2015-07-18'),
(143753685207, 'zl', 'buy', 'vans éž‹å­---- shared with å“ˆå“ˆå“ˆ----å“ˆå“ˆå“ˆ owe å¼ å¤§ç¾Žå¥³ from $4.66 to $34.66', 30.00, '2015-07-21'),
(143753694241, 'zl', 'buy', 'lamian---- shared with å“ˆå“ˆå“ˆ----å“ˆå“ˆå“ˆ owe å¼ å¤§ç¾Žå¥³ from $34.66 to $69.66', 35.00, '2015-07-21'),
(143771892581, 'meng', 'buy', 'æ‰“æ°´---- shared with å¼ å¤§ç¾Žå¥³,å“ˆå“ˆå“ˆ,è¶Šå§å¤§å¤§----å“ˆå“ˆå“ˆ owe å¼ å¤§ç¾Žå¥³ from $69.66 to $69.49----è¶Šå§å¤§å¤§ owe å“ˆå“ˆå“ˆ from $31.26 to $31.43', 0.50, '2015-07-23'),
(143772171607, 'meng', 'buy', 'foodcity ç•ªèŒ„*2---- shared with å¼ å¤§ç¾Žå¥³,å“ˆå“ˆå“ˆ,è¶Šå§å¤§å¤§----å“ˆå“ˆå“ˆ owe å¼ å¤§ç¾Žå¥³ from $69.49 to $68.86----è¶Šå§å¤§å¤§ owe å“ˆå“ˆå“ˆ from $31.43 to $32.06', 1.89, '2015-07-24'),
(143786707309, 'meng', 'buy', 'mekong èœ---- shared with å¼ å¤§ç¾Žå¥³,å“ˆå“ˆå“ˆ,è¶Šå§å¤§å¤§----å“ˆå“ˆå“ˆ owe å¼ å¤§ç¾Žå¥³ from $68.86 to $60.03----è¶Šå§å¤§å¤§ owe å“ˆå“ˆå“ˆ from $32.06 to $40.89', 26.49, '2015-07-25'),
(143786716332, 'meng', 'buy', 'mekong èœ---- shared with å¼ å¤§ç¾Žå¥³,å“ˆå“ˆå“ˆ----å“ˆå“ˆå“ˆ owe å¼ å¤§ç¾Žå¥³ from $60.03 to $47.25', 25.56, '2015-07-25'),
(143786728073, 'meng', 'pay', '----å“ˆå“ˆå“ˆ owe å¼ å¤§ç¾Žå¥³ from $47.25 to $0.00', 47.25, '2015-07-25 16:34:40.733679-07:'),
(143786742185, 'meng', 'buy_cancelled', 'test1---- shared with å¼ å¤§ç¾Žå¥³*2,å“ˆå“ˆå“ˆ,è¶Šå§å¤§å¤§----å¼ å¤§ç¾Žå¥³ owe å“ˆå“ˆå“ˆ from $0.00 to $55.50----è¶Šå§å¤§å¤§ owe å“ˆå“ˆå“ˆ from $40.89 to $68.64----å¼ å¤§ç¾Žå¥³ owe å“ˆå“ˆå“ˆ from $55.50 to $0.00----è¶Šå§å¤§å¤§ owe å“ˆå“ˆå“ˆ from $68.64 to $40.89', 111.00, '2015-07-25'),
(143797367294, 'ty', 'buy', 'fry''s ä¹°çš„é¦™è‚ é¸¡è›‹è‹¹æžœ....---- shared with å¼ å¤§ç¾Žå¥³,å“ˆå“ˆå“ˆ,è¶Šå§å¤§å¤§----å¼ å¤§ç¾Žå¥³ owe è¶Šå§å¤§å¤§ from $24.72 to $31.72----è¶Šå§å¤§å¤§ owe å“ˆå“ˆå“ˆ from $40.89 to $33.89', 21.00, '2015-07-26'),
(143803165454, 'zl', 'buy', 'å‰å‡ å¤©foodcityçš„è¥¿çº¢æŸ¿å’Œé¤å·¾çº¸---- shared with å¼ å¤§ç¾Žå¥³,å“ˆå“ˆå“ˆ,è¶Šå§å¤§å¤§----å“ˆå“ˆå“ˆ owe å¼ å¤§ç¾Žå¥³ from $0.00 to $1.43----å¼ å¤§ç¾Žå¥³ owe è¶Šå§å¤§å¤§ from $31.72 to $30.29', 4.30, '2015-07-27'),
(143822668398, 'zl', 'pay', '----å¼ å¤§ç¾Žå¥³ owe è¶Šå§å¤§å¤§ from $30.29 to $0.00', 30.29, '2015-07-29 20:24:43.983618-07:'),
(143822696206, 'meng', 'buy', 'çœ‹ç”µå½± ant-man---- shared with å¼ å¤§ç¾Žå¥³,å“ˆå“ˆå“ˆ,è¶Šå§å¤§å¤§----å¼ å¤§ç¾Žå¥³ owe å“ˆå“ˆå“ˆ from $-1.43 to $6.90----è¶Šå§å¤§å¤§ owe å“ˆå“ˆå“ˆ from $33.89 to $42.22', 25.00, '2015-07-27'),
(143829489695, 'meng', 'buy', 'money order @fry''s---- shared with å¼ å¤§ç¾Žå¥³,è¶Šå§å¤§å¤§----å¼ å¤§ç¾Žå¥³ owe å“ˆå“ˆå“ˆ from $6.90 to $7.40----è¶Šå§å¤§å¤§ owe å“ˆå“ˆå“ˆ from $42.22 to $42.72', 1.00, '2015-07-30'),
(143856063485, 'zl', 'buy', 'amazon å¾ˆå¤šä¸œè¥¿---- shared with å“ˆå“ˆå“ˆ----å“ˆå“ˆå“ˆ owe å¼ å¤§ç¾Žå¥³ from $-7.40 to $21.12', 28.52, '2015-08-02'),
(143874510385, 'ty', 'buy', 'æ¬å®¶å‰mekongå’Œfoodcityä¹°çš„èœ---- shared with å¼ å¤§ç¾Žå¥³,å“ˆå“ˆå“ˆ,è¶Šå§å¤§å¤§----å¼ å¤§ç¾Žå¥³ owe è¶Šå§å¤§å¤§ from $0.00 to $12.04----è¶Šå§å¤§å¤§ owe å“ˆå“ˆå“ˆ from $42.72 to $30.68', 36.11, '2015-07-30'),
(143874517234, 'ty', 'buy', 'å®œå®¶æ‰«å¸šå’Œè°ƒæ–™ç›’---- shared with å¼ å¤§ç¾Žå¥³,è¶Šå§å¤§å¤§----å¼ å¤§ç¾Žå¥³ owe è¶Šå§å¤§å¤§ from $12.04 to $15.54', 7.00, '2015-08-04'),
(143874521102, 'ty', 'buy', 'cox---- shared with å¼ å¤§ç¾Žå¥³,è¶Šå§å¤§å¤§----å¼ å¤§ç¾Žå¥³ owe è¶Šå§å¤§å¤§ from $15.54 to $31.17', 31.26, '2015-08-04'),
(143874530283, 'ty', 'buy', 'uhaul---- shared with å¼ å¤§ç¾Žå¥³,è¶Šå§å¤§å¤§----å¼ å¤§ç¾Žå¥³ owe è¶Šå§å¤§å¤§ from $31.17 to $45.36', 28.38, '2015-08-04'),
(143881169199, 'meng', 'buy', 'safeway é»„ç“œå’Œæ°´---- shared with å¼ å¤§ç¾Žå¥³,å“ˆå“ˆå“ˆ,è¶Šå§å¤§å¤§----å“ˆå“ˆå“ˆ owe å¼ å¤§ç¾Žå¥³ from $21.12 to $18.58----è¶Šå§å¤§å¤§ owe å“ˆå“ˆå“ˆ from $30.68 to $33.22', 7.61, '2015-08-04'),
(143896824543, 'meng', 'buy_cancelled', 'ç½‘è´¹ï¼Œ39.99internet ï¼‹15 activation feeï¼‹ç¨Ž---- shared with å¼ å¤§ç¾Žå¥³,è¶Šå§å¤§å¤§----å¼ å¤§ç¾Žå¥³ owe å“ˆå“ˆå“ˆ from $-18.58 to $9.53----è¶Šå§å¤§å¤§ owe å“ˆå“ˆå“ˆ from $33.22 to $61.33----å“ˆå“ˆå“ˆ owe å¼ å¤§ç¾Žå¥³ from $-9.53 to $18.58----è¶Šå§å¤§å¤§ owe å“ˆå“ˆå“ˆ from $61.33 to $33.22', 56.21, '2015-08-07'),
(143896847842, 'zl', 'buy', '39.99 internet+15 activation fee +tax---- shared with å¼ å¤§ç¾Žå¥³,è¶Šå§å¤§å¤§----å¼ å¤§ç¾Žå¥³ owe è¶Šå§å¤§å¤§ from $45.36 to $17.25', 56.21, '2015-08-07'),
(143896871790, 'zl', 'buy', 'fry''s è¥¿ç“œï¼Œæ°´ï¼Œç‰›å¥¶ï¼Œæžœæ±---- shared with å¼ å¤§ç¾Žå¥³,è¶Šå§å¤§å¤§----å¼ å¤§ç¾Žå¥³ owe è¶Šå§å¤§å¤§ from $17.25 to $11.16', 12.19, '2015-08-03'),
(143900796063, 'zl', 'buy', 'food city æ²¹---- shared with å¼ å¤§ç¾Žå¥³,å“ˆå“ˆå“ˆ,è¶Šå§å¤§å¤§----å“ˆå“ˆå“ˆ owe å¼ å¤§ç¾Žå¥³ from $18.58 to $20.26----å¼ å¤§ç¾Žå¥³ owe è¶Šå§å¤§å¤§ from $11.15 to $9.47', 5.03, '2015-08-07'),
(143909323240, 'ty', 'buy', 'Mekong ä¹°çš„èœ---- shared with å¼ å¤§ç¾Žå¥³,å“ˆå“ˆå“ˆ,è¶Šå§å¤§å¤§----å¼ å¤§ç¾Žå¥³ owe è¶Šå§å¤§å¤§ from $9.47 to $23.86----è¶Šå§å¤§å¤§ owe å“ˆå“ˆå“ˆ from $33.22 to $18.83', 43.17, '2015-08-08'),
(143909385203, 'ty', 'buy', 'mekong è¯·å®¢åƒçš„ç±³çº¿---- shared with å¼ å¤§ç¾Žå¥³,è¶Šå§å¤§å¤§----å¼ å¤§ç¾Žå¥³ owe è¶Šå§å¤§å¤§ from $23.86 to $42.27', 36.81, '2015-08-08'),
(143925067089, 'meng', 'buy', 'foodcityçš„æ°´---- shared with å¼ å¤§ç¾Žå¥³,å“ˆå“ˆå“ˆ,è¶Šå§å¤§å¤§----å“ˆå“ˆå“ˆ owe å¼ å¤§ç¾Žå¥³ from $20.26 to $19.08----è¶Šå§å¤§å¤§ owe å“ˆå“ˆå“ˆ from $18.83 to $20.01', 3.55, '2015-08-10'),
(143925074191, 'zl', 'buy', 'safewayçš„ä¸¤æ¬¡é¢åŒ…---- shared with å¼ å¤§ç¾Žå¥³,è¶Šå§å¤§å¤§----å¼ å¤§ç¾Žå¥³ owe è¶Šå§å¤§å¤§ from $42.27 to $37.27', 10.00, '2015-08-10'),
(143967024884, 'ty', 'buy', 'mekong ä¹°çš„èœ---- shared with å¼ å¤§ç¾Žå¥³,å“ˆå“ˆå“ˆ,è¶Šå§å¤§å¤§----å¼ å¤§ç¾Žå¥³ owe è¶Šå§å¤§å¤§ from $37.27 to $52.34----è¶Šå§å¤§å¤§ owe å“ˆå“ˆå“ˆ from $20.01 to $4.94', 45.20, '2015-08-15'),
(144012984292, 'zl', 'buy', 'è¥¿ç“œí ¼í½‰---- shared with å¼ å¤§ç¾Žå¥³,å“ˆå“ˆå“ˆ,è¶Šå§å¤§å¤§----å“ˆå“ˆå“ˆ owe å¼ å¤§ç¾Žå¥³ from $19.08 to $21.08----å¼ å¤§ç¾Žå¥³ owe è¶Šå§å¤§å¤§ from $52.34 to $50.34', 6.00, '2015-08-20'),
(144022685885, 'meng', 'buy', 'food cityä¹°æ°´---- shared with å¼ å¤§ç¾Žå¥³,è¶Šå§å¤§å¤§----å“ˆå“ˆå“ˆ owe å¼ å¤§ç¾Žå¥³ from $21.08 to $19.80----è¶Šå§å¤§å¤§ owe å“ˆå“ˆå“ˆ from $4.94 to $6.21', 2.55, '2015-08-22'),
(144029877942, 'zl', 'buy', 'é¸¡è›‹ï½ž---- shared with å¼ å¤§ç¾Žå¥³,è¶Šå§å¤§å¤§----å¼ å¤§ç¾Žå¥³ owe è¶Šå§å¤§å¤§ from $50.34 to $48.57', 3.55, '2015-08-22'),
(144057135720, 'zl', 'buy', 'ç‰™åˆ·---- shared with è¶Šå§å¤§å¤§----å¼ å¤§ç¾Žå¥³ owe è¶Šå§å¤§å¤§ from $48.56 to $33.61', 14.95, '2015-08-25'),
(144091439718, 'meng', 'buy', 'åˆ·ç¢—çš„åˆ·å¤´---- shared with å¼ å¤§ç¾Žå¥³,è¶Šå§å¤§å¤§----å“ˆå“ˆå“ˆ owe å¼ å¤§ç¾Žå¥³ from $19.80 to $18.15----è¶Šå§å¤§å¤§ owe å“ˆå“ˆå“ˆ from $6.21 to $7.86', 3.30, '2015-08-29'),
(144091480544, 'meng', 'buy', 'foodcity æ°´---- shared with å¼ å¤§ç¾Žå¥³,è¶Šå§å¤§å¤§----å“ˆå“ˆå“ˆ owe å¼ å¤§ç¾Žå¥³ from $18.15 to $15.85----è¶Šå§å¤§å¤§ owe å“ˆå“ˆå“ˆ from $7.86 to $10.16', 4.60, '2015-08-28'),
(144105926904, 'meng', 'buy', '2ä¸ªè¥¿ç“œ---- shared with å¼ å¤§ç¾Žå¥³,å“ˆå“ˆå“ˆ----å“ˆå“ˆå“ˆ owe å¼ å¤§ç¾Žå¥³ from $15.85 to $13.35', 5.00, '2015-08-27å·¦å³'),
(144105967812, 'ty', 'buy', 'mekong---- shared with å¼ å¤§ç¾Žå¥³,å“ˆå“ˆå“ˆ,è¶Šå§å¤§å¤§----å¼ å¤§ç¾Žå¥³ owe è¶Šå§å¤§å¤§ from $33.61 to $38.77----è¶Šå§å¤§å¤§ owe å“ˆå“ˆå“ˆ from $10.16 to $5.00', 15.48, '2015-08-31'),
(144117846576, 'zl', 'buy', 'hehe---- shared with è¶Šå§å¤§å¤§----è¶Šå§å¤§å¤§ owe å¼ å¤§ç¾Žå¥³ from $-38.77 to $561.23', 600.00, '2015-09-02'),
(144117852547, 'ty', 'buy', 'é¸¡ç¿…---- shared with å¼ å¤§ç¾Žå¥³,å“ˆå“ˆå“ˆ----è¶Šå§å¤§å¤§ owe å¼ å¤§ç¾Žå¥³ from $561.23 to $558.23----è¶Šå§å¤§å¤§ owe å“ˆå“ˆå“ˆ from $5.00 to $2.00', 6.00, '2015-09-02'),
(144117860007, 'ty', 'buy', 'æˆ¿ç§Ÿ---- shared with å¼ å¤§ç¾Žå¥³,è¶Šå§å¤§å¤§----è¶Šå§å¤§å¤§ owe å¼ å¤§ç¾Žå¥³ from $558.23 to $133.47', 849.52, '2015-09-02'),
(144117876611, 'ty', 'buy', 'ç”µè´¹---- shared with å¼ å¤§ç¾Žå¥³,è¶Šå§å¤§å¤§----è¶Šå§å¤§å¤§ owe å¼ å¤§ç¾Žå¥³ from $133.47 to $85.59', 95.76, '2015-09-02'),
(144123699839, 'meng', 'buy', 'äºšé©¬é€Š é˜²æ™’éœœ\r\nBiore Sarasara UV Aqua Rich Watery Essence Sunscreen SPF50---- shared with å¼ å¤§ç¾Žå¥³,å“ˆå“ˆå“ˆ----å“ˆå“ˆå“ˆ owe å¼ å¤§ç¾Žå¥³ from $13.35 to $3.73', 19.23, '2015-09-02'),
(144150826464, 'zl', 'buy', 'shanxi---- shared with å¼ å¤§ç¾Žå¥³,å“ˆå“ˆå“ˆ----å“ˆå“ˆå“ˆ owe å¼ å¤§ç¾Žå¥³ from $3.73 to $18.86', 30.26, '2015-09-05'),
(144158333629, 'meng', 'buy', 'foodcity æ°´---- shared with å¼ å¤§ç¾Žå¥³,è¶Šå§å¤§å¤§----å“ˆå“ˆå“ˆ owe å¼ å¤§ç¾Žå¥³ from $18.86 to $17.08----è¶Šå§å¤§å¤§ owe å“ˆå“ˆå“ˆ from $2.00 to $3.78', 3.56, '2015-09-06');

-- --------------------------------------------------------

--
-- 表的结构 `trans_detail`
--

CREATE TABLE IF NOT EXISTS `trans_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `trans_id` bigint(20) NOT NULL,
  `debtor` varchar(30) NOT NULL,
  `amount` float(10,2) NOT NULL,
  `percent` float(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `trans_id` (`trans_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=154 ;

--
-- 转存表中的数据 `trans_detail`
--

INSERT INTO `trans_detail` (`id`, `trans_id`, `debtor`, `amount`, `percent`) VALUES
(1, 143564913038, 'zl', 10.00, NULL),
(2, 143564913038, 'ty', 10.00, NULL),
(3, 143564913038, 'meng', 10.00, NULL),
(4, 143564922018, 'zl', 7.00, NULL),
(5, 143564922018, 'ty', 7.00, NULL),
(6, 143564922018, 'meng', 7.00, NULL),
(7, 143568555582, 'meng', 9.99, NULL),
(8, 143586772023, 'zl', 69.00, NULL),
(9, 143586772023, 'ty', 69.00, NULL),
(10, 143598794011, 'zl', 9.04, NULL),
(11, 143598794011, 'meng', 9.04, NULL),
(12, 143598794011, 'ty', 9.04, NULL),
(13, 143598799557, 'zl', 1.86, NULL),
(14, 143598799557, 'meng', 1.86, NULL),
(15, 143598799557, 'ty', 1.86, NULL),
(16, 143598809567, 'zl', 2.50, NULL),
(17, 143598809567, 'ty', 2.50, NULL),
(18, 143598814311, 'zl', 4.06, NULL),
(19, 143598814311, 'ty', 4.06, NULL),
(20, 143613203595, 'zl', 9.51, NULL),
(21, 143613203595, 'meng', 9.51, NULL),
(22, 143613203595, 'ty', 9.51, NULL),
(23, 143640395989, 'zl', 1.42, NULL),
(24, 143640395989, 'meng', 1.42, NULL),
(25, 143640395989, 'ty', 1.42, NULL),
(26, 143650456058, 'zl', 2.03, NULL),
(27, 143650456058, 'ty', 2.03, NULL),
(28, 143658743236, 'zl', 15.34, NULL),
(29, 143658743236, 'meng', 15.34, NULL),
(30, 143658743236, 'ty', 15.34, NULL),
(31, 143658747011, 'zl', 7.53, NULL),
(32, 143658747011, 'meng', 7.53, NULL),
(33, 143658761491, 'zl', 5.00, NULL),
(34, 143658899002, 'meng', 10.87, NULL),
(35, 143673116060, 'meng', 11.08, NULL),
(36, 143673125840, 'zl', 1.50, NULL),
(37, 143673125840, 'ty', 1.50, NULL),
(38, 143673132450, 'zl', 0.63, NULL),
(39, 143673132450, 'meng', 0.63, NULL),
(40, 143673132450, 'ty', 0.63, NULL),
(41, 143673165249, 'zl', 3.93, NULL),
(42, 143673165249, 'meng', 3.93, NULL),
(43, 143673165249, 'ty', 3.93, NULL),
(44, 143689930924, 'zl', 31.27, NULL),
(45, 143689930924, 'meng', 2.84, NULL),
(46, 143689930924, 'ty', 2.84, NULL),
(47, 143690593311, 'zl', 12.32, NULL),
(48, 143690593311, 'meng', 12.32, NULL),
(49, 143690593311, 'ty', 12.32, NULL),
(50, 143691255124, 'zl', 11.90, NULL),
(51, 143691255124, 'ty', 11.90, NULL),
(52, 143691257435, 'meng', 5.05, NULL),
(53, 143691267802, 'ty', 40.00, NULL),
(54, 143691273443, 'zl', 60.00, NULL),
(55, 143726224665, 'zl', 0.92, NULL),
(56, 143726224665, 'meng', 0.92, NULL),
(57, 143726224665, 'ty', 0.92, NULL),
(58, 143726968901, 'meng', 5.91, NULL),
(59, 143727666932, 'zl', 19.17, NULL),
(60, 143727666932, 'meng', 19.17, NULL),
(61, 143727666932, 'ty', 19.17, NULL),
(62, 143753685207, 'meng', 30.00, NULL),
(63, 143753694241, 'meng', 35.00, NULL),
(64, 143771892581, 'zl', 0.17, NULL),
(65, 143771892581, 'meng', 0.17, NULL),
(66, 143771892581, 'ty', 0.17, NULL),
(67, 143772171607, 'zl', 0.63, NULL),
(68, 143772171607, 'meng', 0.63, NULL),
(69, 143772171607, 'ty', 0.63, NULL),
(70, 143786707309, 'zl', 8.83, NULL),
(71, 143786707309, 'meng', 8.83, NULL),
(72, 143786707309, 'ty', 8.83, NULL),
(73, 143786716332, 'zl', 12.78, NULL),
(74, 143786716332, 'meng', 12.78, NULL),
(75, 143786742185, 'zl', 55.50, NULL),
(76, 143786742185, 'meng', 27.75, NULL),
(77, 143786742185, 'ty', 27.75, NULL),
(78, 143797367294, 'zl', 7.00, NULL),
(79, 143797367294, 'meng', 7.00, NULL),
(80, 143797367294, 'ty', 7.00, NULL),
(81, 143803165454, 'zl', 1.43, NULL),
(82, 143803165454, 'meng', 1.43, NULL),
(83, 143803165454, 'ty', 1.43, NULL),
(84, 143822696206, 'zl', 8.33, NULL),
(85, 143822696206, 'meng', 8.33, NULL),
(86, 143822696206, 'ty', 8.33, NULL),
(87, 143829489695, 'zl', 0.50, NULL),
(88, 143829489695, 'ty', 0.50, NULL),
(89, 143856063485, 'meng', 28.52, NULL),
(90, 143874510385, 'zl', 12.04, NULL),
(91, 143874510385, 'meng', 12.04, NULL),
(92, 143874510385, 'ty', 12.04, NULL),
(93, 143874517234, 'zl', 3.50, NULL),
(94, 143874517234, 'ty', 3.50, NULL),
(95, 143874521102, 'zl', 15.63, NULL),
(96, 143874521102, 'ty', 15.63, NULL),
(97, 143874530283, 'zl', 14.19, NULL),
(98, 143874530283, 'ty', 14.19, NULL),
(99, 143881169199, 'zl', 2.54, NULL),
(100, 143881169199, 'meng', 2.54, NULL),
(101, 143881169199, 'ty', 2.54, NULL),
(102, 143896824543, 'zl', 28.11, NULL),
(103, 143896824543, 'ty', 28.11, NULL),
(104, 143896847842, 'zl', 28.11, NULL),
(105, 143896847842, 'ty', 28.11, NULL),
(106, 143896871790, 'zl', 6.09, NULL),
(107, 143896871790, 'ty', 6.09, NULL),
(108, 143900796063, 'zl', 1.68, NULL),
(109, 143900796063, 'meng', 1.68, NULL),
(110, 143900796063, 'ty', 1.68, NULL),
(111, 143909323240, 'zl', 14.39, NULL),
(112, 143909323240, 'meng', 14.39, NULL),
(113, 143909323240, 'ty', 14.39, NULL),
(114, 143909385203, 'zl', 18.41, NULL),
(115, 143909385203, 'ty', 18.41, NULL),
(116, 143925067089, 'zl', 1.18, NULL),
(117, 143925067089, 'meng', 1.18, NULL),
(118, 143925067089, 'ty', 1.18, NULL),
(119, 143925074191, 'zl', 5.00, NULL),
(120, 143925074191, 'ty', 5.00, NULL),
(121, 143967024884, 'zl', 15.07, NULL),
(122, 143967024884, 'meng', 15.07, NULL),
(123, 143967024884, 'ty', 15.07, NULL),
(124, 144012984292, 'zl', 2.00, NULL),
(125, 144012984292, 'meng', 2.00, NULL),
(126, 144012984292, 'ty', 2.00, NULL),
(127, 144022685885, 'zl', 1.27, NULL),
(128, 144022685885, 'ty', 1.27, NULL),
(129, 144029877942, 'zl', 1.77, NULL),
(130, 144029877942, 'ty', 1.77, NULL),
(131, 144057135720, 'ty', 14.95, NULL),
(132, 144091439718, 'zl', 1.65, NULL),
(133, 144091439718, 'ty', 1.65, NULL),
(134, 144091480544, 'zl', 2.30, NULL),
(135, 144091480544, 'ty', 2.30, NULL),
(136, 144105926904, 'zl', 2.50, NULL),
(137, 144105926904, 'meng', 2.50, NULL),
(138, 144105967812, 'zl', 5.16, NULL),
(139, 144105967812, 'meng', 5.16, NULL),
(140, 144105967812, 'ty', 5.16, NULL),
(141, 144117846576, 'ty', 600.00, NULL),
(142, 144117852547, 'zl', 3.00, NULL),
(143, 144117852547, 'meng', 3.00, NULL),
(144, 144117860007, 'zl', 424.76, NULL),
(145, 144117860007, 'ty', 424.76, NULL),
(146, 144117876611, 'zl', 47.88, NULL),
(147, 144117876611, 'ty', 47.88, NULL),
(148, 144123699839, 'zl', 9.62, NULL),
(149, 144123699839, 'meng', 9.62, NULL),
(150, 144150826464, 'zl', 15.13, NULL),
(151, 144150826464, 'meng', 15.13, NULL),
(152, 144158333629, 'zl', 1.78, NULL),
(153, 144158333629, 'ty', 1.78, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `password` varchar(50) NOT NULL,
  `screen_name` varchar(30) NOT NULL,
  `type` varchar(30) NOT NULL COMMENT 'normal or super',
  `group_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- 转存表中的数据 `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `screen_name`, `type`, `group_id`) VALUES
(1, 'zl', '3aad20e566bf9d5585c9dfbafae029f9', 'å¼ å¤§ç¾Žå¥³', 'normal', 1),
(2, 'cdh', '3aad20e566bf9d5585c9dfbafae029f9', 'cdh', 'normal', 2),
(3, 'ty', '3aad20e566bf9d5585c9dfbafae029f9', 'è¶Šå§å¤§å¤§', 'normal', 1),
(4, 'root', '3aad20e566bf9d5585c9dfbafae029f9', 'root', 'super', 0),
(5, 'meng', '3aad20e566bf9d5585c9dfbafae029f9', 'å“ˆå“ˆå“ˆ', 'normal', 1),
(7, 'April', '160173b2b4a677e3465d2b2a31af12d6', 'April', 'normal', 3),
(8, 'Sophie', '2116207468f3d58bfe2b49615a2a474a', 'Sophie', 'normal', 3),
(10, 'qq', '2cd9db975f43e36057d72b1810940beb', 'ww', 'normal', 0);

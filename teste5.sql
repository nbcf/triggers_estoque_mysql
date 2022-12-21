# MySQL-Front 5.0  (Build 1.0)

/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE */;
/*!40101 SET SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES */;
/*!40103 SET SQL_NOTES='ON' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;


# Host: localhost    Database: teste5
# ------------------------------------------------------
# Server version 5.1.50-community

#
# Table structure for table table_01
#

DROP TABLE IF EXISTS `table_01`;
CREATE TABLE `table_01` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ITEM1` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
INSERT INTO `table_01` VALUES (1,10);
/*!40000 ALTER TABLE `table_01` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table table_02
#

DROP TABLE IF EXISTS `table_02`;
CREATE TABLE `table_02` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Table_01_ID` int(10) unsigned NOT NULL,
  `PEGA_ITEM1` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `Table_02_FKIndex1` (`Table_01_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
INSERT INTO `table_02` VALUES (1,1,5);
/*!40000 ALTER TABLE `table_02` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for trigger inserindo
#

DROP TRIGGER IF EXISTS `inserindo`;
CREATE DEFINER='root'@`localhost` TRIGGER `inserindo` AFTER INSERT ON `table_02`
  FOR EACH ROW begin

update table_01 set ITEM1=ITEM1-New.PEGA_ITEM1
where table_01.ID=New.Table_01_ID;
end;


#
# Source for trigger atualiza
#

DROP TRIGGER IF EXISTS `atualiza`;
CREATE DEFINER='root'@`localhost` TRIGGER `atualiza` AFTER UPDATE ON `table_02`
  FOR EACH ROW begin
update table_01 set ITEM1=ITEM1+Old.PEGA_ITEM1
where table_01.ID=Old.Table_01_ID;
update table_01 set ITEM1=ITEM1-New.PEGA_ITEM1
where table_01.ID=New.Table_01_ID;
end;


#
# Source for trigger deletando
#

DROP TRIGGER IF EXISTS `deletando`;
CREATE DEFINER='root'@`localhost` TRIGGER `deletando` AFTER DELETE ON `table_02`
  FOR EACH ROW begin
update table_01 set ITEM1=ITEM1+Old.PEGA_ITEM1
where table_01.ID=Old.Table_01_ID;
end;


/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;

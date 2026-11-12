
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `order_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT '1',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `order_item_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `order_item_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `order_item` DISABLE KEYS */;
INSERT INTO `order_item` VALUES (1,1,1,1,199.00),(2,2,31,1,259.00),(3,3,3,20,599.00),(4,4,7,1,1299.00);
/*!40000 ALTER TABLE `order_item` ENABLE KEYS */;
DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `total_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `status` varchar(20) NOT NULL DEFAULT '待付款',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,199.00,'已付款','2026-11-01 00:42:57'),(2,2,259.00,'已取消','2026-11-01 01:35:43'),(3,3,11980.00,'已取消','2026-11-03 21:37:23'),(4,3,1299.00,'待付款','2026-11-03 21:44:58');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT '商品名称',
  `price` decimal(10,2) NOT NULL COMMENT '单价',
  `stock` int(11) NOT NULL DEFAULT '0' COMMENT '库存',
  `category` varchar(50) DEFAULT '其他' COMMENT '分类',
  `image_url` varchar(200) DEFAULT '' COMMENT '图片地址',
  `description` text COMMENT '商品描述',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'机械键盘 87 键',199.00,49,'数码','/shop/images/keyboard-80he.png','红轴客制化机械键盘，热插拔轴座，RGB 背光。','2026-11-01 00:26:20'),(2,'无线鼠标',89.00,120,'数码','/shop/images/mouse.jpg','2.4G 无线连接，静音按键，续航 6 个月。','2026-11-01 00:26:20'),(3,'人体工学椅',599.00,20,'家具','/shop/images/chair.jpg','网布靠背，可调腰托与扶手，久坐不累。','2026-11-01 00:26:20'),(4,'编程入门教材',69.00,200,'图书','/shop/images/programming-book.jpg','零基础学 Java，配套示例代码与习题。','2026-11-01 00:26:20'),(5,'保温杯 500ml',49.00,300,'生活','/shop/images/thermos.jpg','316 不锈钢内胆，12 小时保温保冷。','2026-11-01 00:26:20'),(6,'蓝牙耳机',159.00,80,'数码','/shop/images/earbuds.jpg','主动降噪，单次续航 8 小时，佩戴轻盈。','2026-11-01 00:26:20'),(7,'4K 显示器',1299.00,29,'数码','/shop/images/monitor.jpg','27 英寸 4K IPS，99% sRGB，Type-C 供电。','2026-11-01 00:48:58'),(8,'移动电源 20000mAh',129.00,150,'数码','/shop/images/powerbank.jpg','双向快充，数显电量，可上飞机。','2026-11-01 00:48:58'),(9,'智能手表',899.00,60,'数码','/shop/images/watch.jpg','心率血氧监测，GPS 定位，14 天续航。','2026-11-01 00:48:58'),(10,'机械硬盘 2TB',399.00,80,'数码','/shop/images/hdd.jpg','台式机 3.5 寸，7200 转，海量存储。','2026-11-01 00:48:58'),(11,'实木书桌',459.00,25,'家具','/shop/images/desk.jpg','橡木桌面，可调高度，承重稳固。','2026-11-01 00:48:58'),(12,'落地台灯',159.00,90,'家具','/shop/images/floor-lamp.jpg','三档色温，无频闪，护眼阅读灯。','2026-11-01 00:48:58'),(13,'收纳箱 三件套',79.00,200,'家具','/shop/images/storage-box.jpg','折叠收纳，透明可视，节省空间。','2026-11-01 00:48:58'),(14,'高等数学教材',59.00,180,'图书','/shop/images/math-book.jpg','同济第七版，考研打底必备。','2026-11-01 00:48:58'),(15,'计算机网络',65.00,160,'图书','/shop/images/network-book.jpg','自顶向下方法，经典教材。','2026-11-01 00:48:58'),(16,'香薰蜡烛',39.00,250,'生活','/shop/images/candle.jpg','大豆蜡，雪松木质香，助眠放松。','2026-11-01 00:48:58'),(17,'纯棉毛巾',25.00,400,'生活','/shop/images/towel.jpg','新疆长绒棉，吸水柔软，加厚款。','2026-11-01 00:48:58'),(18,'速溶咖啡',69.00,300,'食品','/shop/images/coffee.jpg','阿拉比卡豆，0 蔗糖，提神醒脑。','2026-11-01 00:48:58'),(19,'坚果礼盒',99.00,220,'食品','/shop/images/nuts.jpg','每日坚果混合装，独立小包。','2026-11-01 00:48:58'),(20,'黑巧克力',45.00,260,'食品','/shop/images/chocolate.jpg','72% 可可，微苦不腻，纯脂制作。','2026-11-01 00:48:58'),(21,'瑜伽垫',89.00,180,'运动','/shop/images/yoga-mat.jpg','TPE 材质，防滑加厚，居家健身。','2026-11-01 00:48:58'),(22,'哑铃 可调节',199.00,120,'运动','/shop/images/dumbbell.jpg','包胶铸铁，2-10kg 可调，静音。','2026-11-01 00:48:58'),(23,'运动鞋',299.00,140,'服饰','/shop/images/sneakers.jpg','轻量缓震，透气网面，日常跑步。','2026-11-01 00:48:58'),(24,'纯棉 T 恤',49.00,500,'服饰','/shop/images/tshirt.jpg','100% 棉，基础百搭，多色可选。','2026-11-01 00:48:58'),(25,'牛仔裤',129.00,300,'服饰','/shop/images/jeans.jpg','直筒修身，弹力面料，耐穿不易变形。','2026-11-01 00:48:58'),(26,'双肩背包',199.00,150,'服饰','/shop/images/backpack.jpg','防泼水面料，大容量，电脑隔层。','2026-11-01 00:48:58'),(27,'保湿面霜',119.00,200,'美妆','/shop/images/cream.jpg','神经酰胺配方，长效补水，温和无香。','2026-11-01 00:48:58'),(28,'精华水',139.00,160,'美妆','/shop/images/essence.jpg','玻尿酸保湿，舒缓泛红，换季友好。','2026-11-01 00:48:58'),(29,'笔记本 线圈本',19.00,600,'文具','/shop/images/notebook.jpg','A5 方格内页，可拆卸，书写顺滑。','2026-11-01 00:48:58'),(30,'中性笔 10 支装',15.00,800,'文具','/shop/images/pen.jpg','0.5mm 子弹头，速干不晕染。','2026-11-01 00:48:58'),(31,'台式音箱',259.00,70,'数码','/shop/images/speaker.jpg','2.0 声道，木质箱体，HiFi 听感。','2026-11-01 00:48:58'),(32,'抱枕 沙发枕',59.00,240,'家具','/shop/images/cushion.jpg','羽绒棉填充，可拆洗，客厅点缀。','2026-11-01 00:48:58');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL COMMENT '登录名',
  `password` varchar(100) NOT NULL COMMENT 'BCrypt 加密存储',
  `name` varchar(50) DEFAULT '' COMMENT '昵称/真实姓名',
  `phone` varchar(20) DEFAULT '' COMMENT '手机号',
  `email` varchar(100) DEFAULT '' COMMENT '邮箱',
  `role` varchar(20) NOT NULL DEFAULT 'member' COMMENT 'admin/member',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin','$2a$10$0Va0PtpFRLjjTNlCJBFSxOtpVhJ/TYJShD.oNV4CYfoTDLLH04Ovm','系统管理员','','','admin','2026-11-01 00:26:20'),(2,'huangke','$2a$10$WzzfbWl5q1HBQIjV7dIb8.4IWug49uMKcCMwbhLt84b8B9pPIEZN6','黄可','1 352 046 3225','3241958955@qq.com','member','2026-11-01 01:35:16'),(3,'2024011544','$2a$10$.L6BMB1mipwM6oR1jXLQdevcI3eOHLb3eTyNxWrFaLFEDqrWU.Jr6','黄可','1 352 046 3225','3241958955@qq.com','member','2026-11-03 21:33:43');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;


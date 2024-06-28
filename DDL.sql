SELECT @@global.time_zone;


DROP TABLE IF EXISTS `carts`;
CREATE TABLE `carts` (
  `user_id` int NOT NULL,
  `food_id` int NOT NULL,
  `quantity` int NOT NULL,
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`,`food_id`),
  KEY `food_id` (`food_id`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text,
  `icon` json DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `cities`;
CREATE TABLE `cities` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `food_likes`;
CREATE TABLE `food_likes` (
  `user_id` int NOT NULL,
  `food_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`,`food_id`),
  KEY `food_id` (`food_id`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `food_ratings`;
CREATE TABLE `food_ratings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `food_id` int NOT NULL,
  `point` float DEFAULT '0',
  `comment` text,
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `food_id` (`food_id`) USING BTREE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `foods`;
CREATE TABLE `foods` (
  `id` int NOT NULL AUTO_INCREMENT,
  `restaurant_id` int NOT NULL,
  `category_id` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `description` text,
  `price` float NOT NULL,
  `images` json NOT NULL,
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `restaurant_id` (`restaurant_id`) USING BTREE,
  KEY `category_id` (`category_id`) USING BTREE,
  KEY `status` (`status`) USING BTREE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `images`;
CREATE TABLE `images` (
  `id` int NOT NULL AUTO_INCREMENT,
  `file_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `width` int NOT NULL,
  `height` int NOT NULL,
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `order_details`;
CREATE TABLE `order_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `food_origin` json DEFAULT NULL,
  `price` float NOT NULL,
  `quantity` int NOT NULL,
  `discount` float DEFAULT '0',
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`) USING BTREE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `order_trackings`;
CREATE TABLE `order_trackings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `state` enum('waiting_for_shipper','preparing','on_the_way','delivered','cancel') NOT NULL,
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`) USING BTREE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `total_price` float NOT NULL,
  `shipper_id` int DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `shipper_id` (`shipper_id`) USING BTREE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `restaurant_foods`;
CREATE TABLE `restaurant_foods` (
  `restaurant_id` int NOT NULL,
  `food_id` int NOT NULL,
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`restaurant_id`,`food_id`),
  KEY `food_id` (`food_id`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `restaurant_likes`;
CREATE TABLE `restaurant_likes` (
  `restaurant_id` int NOT NULL,
  `user_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`restaurant_id`,`user_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `restaurant_ratings`;
CREATE TABLE `restaurant_ratings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `restaurant_id` int NOT NULL,
  `point` float NOT NULL DEFAULT '0',
  `comment` text,
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `restaurant_id` (`restaurant_id`) USING BTREE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `restaurants`;
CREATE TABLE `restaurants` (
  `id` int NOT NULL AUTO_INCREMENT,
  `owner_id` int NOT NULL,
  `name` varchar(50) NOT NULL,
  `addr` varchar(255) NOT NULL,
  `city_id` int DEFAULT NULL,
  `lat` double DEFAULT NULL,
  `lng` double DEFAULT NULL,
  `cover` json NOT NULL,
  `logo` json NOT NULL,
  `shipping_fee_per_km` double DEFAULT '0',
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `owner_id` (`owner_id`) USING BTREE,
  KEY `city_id` (`city_id`) USING BTREE,
  KEY `status` (`status`) USING BTREE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `user_addresses`;
CREATE TABLE `user_addresses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `city_id` int NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `icon` json DEFAULT NULL,
  `addr` varchar(255) NOT NULL,
  `lat` double DEFAULT NULL,
  `lng` double DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `city_id` (`city_id`) USING BTREE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `user_device_tokens`;
CREATE TABLE `user_device_tokens` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned DEFAULT NULL,
  `is_production` tinyint(1) DEFAULT '0',
  `os` enum('ios','android','web') DEFAULT 'ios' COMMENT '1: iOS, 2: Android',
  `token` varchar(255) DEFAULT NULL,
  `status` smallint unsigned NOT NULL DEFAULT '1',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `os` (`os`) USING BTREE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(50) NOT NULL,
  `fb_id` varchar(50) DEFAULT NULL,
  `gg_id` varchar(50) DEFAULT NULL,
  `password` varchar(50) NOT NULL,
  `salt` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `role` enum('user','admin','shipper') NOT NULL DEFAULT 'user',
  `avatar` json DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB;

INSERT INTO `cities` (`id`, `title`, `status`, `created_at`, `updated_at`) VALUES
(1, 'An Giang', 1, '2020-05-18 06:52:22', '2020-05-18 06:52:22'),
(2, 'Vũng Tàu', 1, '2020-05-18 06:52:22', '2020-05-18 06:52:22'),
(3, 'Bắc Giang', 1, '2020-05-18 06:52:22', '2020-05-18 06:52:22'),
(4, 'Bắc Cạn', 1, '2020-05-18 06:52:22', '2020-05-18 06:52:22'),
(5, 'Bạc Liêu', 1, '2020-05-18 06:52:22', '2020-05-18 06:52:22'),
(6, 'Bắc Ninh', 1, '2020-05-18 06:52:22', '2020-05-18 06:52:22'),
(7, 'Bến Tre', 1, '2020-05-18 06:52:22', '2020-05-18 06:52:22'),
(8, 'Bình Định', 1, '2020-05-18 06:52:22', '2020-05-18 06:52:22'),
(9, 'Bình Dương', 1, '2020-05-18 06:52:22', '2020-05-18 06:52:22'),
(10, 'Bình Phước', 1, '2020-05-18 06:52:22', '2020-05-18 06:52:22'),
(11, 'Bình Thuận', 1, '2020-05-18 06:52:22', '2020-05-18 06:52:22'),
(12, 'Cà Mau', 1, '2020-05-18 06:52:22', '2020-05-18 06:52:22'),
(13, 'Cần Thơ', 1, '2020-05-18 06:52:22', '2020-05-18 06:52:22'),
(14, 'Cao Bằng', 1, '2020-05-18 06:52:22', '2020-05-18 06:52:22'),
(15, 'Đà Nẵng', 1, '2020-05-18 06:52:21', '2020-05-18 06:52:21'),
(16, 'Đắk Lắk', 1, '2020-05-18 06:52:22', '2020-05-18 06:52:22'),
(17, 'Đắk Nông', 1, '2020-05-18 06:52:22', '2020-05-18 06:52:22'),
(18, 'Điện Biên', 1, '2020-05-18 06:52:22', '2020-05-18 06:52:22'),
(19, 'Đồng Nai', 1, '2020-05-18 06:52:21', '2020-05-18 06:52:21'),
(20, 'Đồng Tháp', 1, '2020-05-18 06:52:22', '2020-05-18 06:52:22'),
(21, 'Gia Lai', 1, '2020-05-18 06:52:22', '2020-05-18 06:52:22'),
(22, 'Hà Giang', 1, '2020-05-18 06:52:22', '2020-05-18 06:52:22'),
(23, 'Hà Nam', 1, '2020-05-18 06:52:22', '2020-05-18 06:52:22'),
(24, 'Hà Nội', 1, '2020-05-18 06:52:21', '2020-05-18 06:52:21'),
(25, 'Hà Tĩnh', 1, '2020-05-18 06:52:22', '2020-05-18 06:52:22'),
(26, 'Hải Dương', 1, '2020-05-18 06:52:22', '2020-05-18 06:52:22'),
(27, 'Hải Phòng', 1, '2020-05-18 06:52:22', '2020-05-18 06:52:22'),
(28, 'Hậu Giang', 1, '2020-05-18 06:52:23', '2020-05-18 06:52:23'),
(29, 'Hoà Bình', 1, '2020-05-18 06:52:23', '2020-05-18 06:52:23'),
(30, 'Hưng Yên', 1, '2020-05-18 06:52:23', '2020-05-18 06:52:23'),
(31, 'Khánh Hoà', 1, '2020-05-18 06:52:23', '2020-05-18 06:52:23'),
(32, 'Kiên Giang', 1, '2020-05-18 06:52:23', '2020-05-18 06:52:23'),
(33, 'Kon Tum', 1, '2020-05-18 06:52:23', '2020-05-18 06:52:23'),
(34, 'Lai Châu', 1, '2020-05-18 06:52:23', '2020-05-18 06:52:23'),
(35, 'Lâm Đồng', 1, '2020-05-18 06:52:23', '2020-05-18 06:52:23'),
(36, 'Lạng Sơn', 1, '2020-05-18 06:52:23', '2020-05-18 06:52:23'),
(37, 'Lào Cai', 1, '2020-05-18 06:52:23', '2020-05-18 06:52:23'),
(38, 'Long An', 1, '2020-05-18 06:52:23', '2020-05-18 06:52:23'),
(39, 'Nam Định', 1, '2020-05-18 06:52:23', '2020-05-18 06:52:23'),
(40, 'Nghệ An', 1, '2020-05-18 06:52:23', '2020-05-18 06:52:23'),
(41, 'Ninh Bình', 1, '2020-05-18 06:52:23', '2020-05-18 06:52:23'),
(42, 'Ninh Thuận', 1, '2020-05-18 06:52:23', '2020-05-18 06:52:23'),
(43, 'Phú Thọ', 1, '2020-05-18 06:52:23', '2020-05-18 06:52:23'),
(44, 'Phú Yên', 1, '2020-05-18 06:52:23', '2020-05-18 06:52:23'),
(45, 'Quảng Bình', 1, '2020-05-18 06:52:23', '2020-05-18 06:52:23'),
(46, 'Quảng Namm', 1, '2020-05-18 06:52:23', '2020-05-18 06:52:23'),
(47, 'Quãng Ngãi', 1, '2020-05-18 06:55:18', '2020-05-18 06:55:18'),
(48, 'Quãng Ninh', 1, '2020-05-18 06:55:18', '2020-05-18 06:55:18'),
(49, 'Quãng Trị', 1, '2020-05-18 06:55:18', '2020-05-18 06:55:18'),
(50, 'Sóc Trăng', 1, '2020-05-18 06:55:18', '2020-05-18 06:55:18'),
(51, 'Sơn La', 1, '2020-05-18 06:55:18', '2020-05-18 06:55:18'),
(52, 'Tây Ninh', 1, '2020-05-18 06:55:18', '2020-05-18 06:55:18'),
(53, 'Thái Bình', 1, '2020-05-18 06:55:18', '2020-05-18 06:55:18'),
(54, 'Thái Nguyên', 1, '2020-05-18 06:55:18', '2020-05-18 06:55:18'),
(55, 'Thanh Hoá', 1, '2020-05-18 06:55:18', '2020-05-18 06:55:18'),
(56, 'Huế', 1, '2020-05-18 06:55:18', '2020-05-18 06:55:18'),
(57, 'Tiền Giang', 1, '2020-05-18 06:55:18', '2020-05-18 06:55:18'),
(58, 'Hồ Chí Minh', 1, '2020-05-18 06:41:51', '2020-05-18 06:41:51'),
(59, 'Trà Vinh', 1, '2020-05-18 06:55:18', '2020-05-18 06:55:18'),
(60, 'Tuyên Quang', 1, '2020-05-18 06:55:18', '2020-05-18 06:55:18'),
(61, 'Vĩnh Long', 1, '2020-05-18 06:55:18', '2020-05-18 06:55:18'),
(62, 'Vĩnh Phúc', 1, '2020-05-18 06:55:18', '2020-05-18 06:55:18'),
(63, 'Yên Bái', 1, '2020-05-18 06:55:19', '2020-05-18 06:55:19');


alter table restaurants
add liked_count int default 0
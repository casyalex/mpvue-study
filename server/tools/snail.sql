CREATE TABLE `books` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `isbn` varchar(20) CHARACTER SET utf8mb4 NOT NULL,
  `openid` varchar(50) CHARACTER SET utf8mb4 NOT NULL,
  `title` varchar(100) CHARACTER SET utf8mb4 NOT NULL,
  `image` varchar(200) CHARACTER SET utf8mb4 DEFAULT NULL,
  `alt` varchar(100) CHARACTER SET utf8mb4 NOT NULL,
  `publisher` varchar(100) CHARACTER SET utf8mb4 NOT NULL,
  `summary` varchar(1000) CHARACTER SET utf8mb4 NOT NULL,
  `price` varchar(100) CHARACTER SET utf8mb4 NOT NULL,
  `rate` float DEFAULT NULL,
  `tags` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL,
  `author` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

create table comments(
  id int not null AUTO_INCREMENT PRIMARY KEY,
  openid varchar(100) not null,
  bookid varchar(10) not null,
  comment varchar(200) not null,
  phone varchar(50),
  location varchar(50)
);

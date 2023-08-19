-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 10, 2022 at 06:02 PM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 8.0.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `springproject`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `categoryid` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for table `categories`
--

ALTER TABLE `categories`
  ADD PRIMARY KEY (`categoryid`);
  
--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`categoryid`, `name`) VALUES
(1, 'Fruits and Vegetables'),
(2, 'Meat and Seafood'),
(3, 'Grains and Pasta'),
(4, 'Beverages'),
(5, 'Bread & Bakery');


--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `categoryid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE `login` (
  `id` int(11) NOT NULL,
  `password` varchar(20) NOT NULL,
  `username` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`id`, `password`, `username`) VALUES
(1, '123', '1');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` text NOT NULL,
  `categoryid` int(11),
  `quantity` int(11) NOT NULL,
  `price` decimal(5,2) NOT NULL,
  `onDiscount` boolean NOT NULL DEFAULT 0,
  `discPercent` int NOT NULL DEFAULT 0,
  `discPrice` decimal(5,2) NOT NULL DEFAULT 0,
  `qtySold` int(11) NOT NULL DEFAULT 0,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for table `products`
--

ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `products_ibfk_1` (`categoryid`);

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `image`, `categoryid`, `quantity`, `price`, `discPrice`, `description`) VALUES
(1, 'Organic Apples', 'https://467210.fs1.hubspotusercontent-na1.net/hubfs/467210/Eric%20Sandbox/apples.jpg', 1, 5, 2.99, 2.99, 'Fresh organic apples picked from local farms.'),
(2, 'Wild Alaskan Salmon', 'https://467210.fs1.hubspotusercontent-na1.net/hubfs/467210/Eric%20Sandbox/wild-salmon.jpg', 2, 19, 15.99, 15.99, 'Sustainably caught, wild Alaskan salmon fillets.'),
(3, 'Organic Quinoa', 'https://467210.fs1.hubspotusercontent-na1.net/hubfs/467210/Eric%20Sandbox/quinoa.jpg', 3, 20, 4.99, 4.99, 'Organic gluten-free quinoa sourced from South America.'),
(4, 'Organic Baby Carrots', 'https://467210.fs1.hubspotusercontent-na1.net/hubfs/467210/Eric%20Sandbox/baby-carrots.jpg', 1, 16, 1.99, 1.99, 'Organic baby carrots, perfect for snacking.'),
(5, 'Grass-Fed Beef', 'https://467210.fs1.hubspotusercontent-na1.net/hubfs/467210/Eric%20Sandbox/grassfed-beef.jpg', 2, 14, 25.99, 25.99, 'Grass-fed, pasture-raised beef from local farms.'),
(6, 'Organic Brown Rice', 'https://467210.fs1.hubspotusercontent-na1.net/hubfs/467210/Eric%20Sandbox/brown-rice.jpg', 3, 38, 3.99, 3.99, 'Organic whole-grain brown rice from California.'),
(7, 'Lemonade 2L', 'https://467210.fs1.hubspotusercontent-na1.net/hubfs/467210/Eric%20Sandbox/lemonade.jpg', 4, 27, 3.99, 3.99, 'Enjoy the refreshing taste of Sealtest lemonade.'),
(8, 'Buffalo Short Rib Roast', 'https://467210.fs1.hubspotusercontent-na1.net/hubfs/467210/Eric%20Sandbox/rib-roast.jpg', 2, 54, 28.99, 28.99, 'Known to be tender and juicy, accompany it with its au jus for even more flavor. '),
(9, 'Veal Shank', 'https://467210.fs1.hubspotusercontent-na1.net/hubfs/467210/Eric%20Sandbox/veal-shank.jpg', 2, 43, 34.99, 34.99, 'This grain-fed veal shank can be prepared as a stew or braised. '),
(10, 'Schweppes Gingerale 12-Pack', 'https://467210.fs1.hubspotusercontent-na1.net/hubfs/467210/Eric%20Sandbox/gingerale.jpg', 4, 31, 5.99, 5.99, 'Refined since 1783, Schweppes® ginger ale has an authentic and original crisp taste. '),
(11, 'Andalos Pita Bread', 'https://467210.fs1.hubspotusercontent-na1.net/hubfs/467210/Eric%20Sandbox/pita.jpg', 5, 45, 4.5, 4.5, 'Our Selection whole wheat pita bread are the perfect choice for a quick and delicious meal!'),
(12, 'Boneless Chicken Breast', 'https://467210.fs1.hubspotusercontent-na1.net/hubfs/467210/Eric%20Sandbox/chicken-breast.jpg', 2, 33, 12.99, 12.99, 'Versatile, delicious, and nutritious, there are a myriad of ways to prepare boneless trimmed chicken breasts. '),
(13, 'Crispy Chocolatines ', 'https://467210.fs1.hubspotusercontent-na1.net/hubfs/467210/Eric%20Sandbox/chocolatine.jpg', 5, 62, 6.99, 6.99, 'Collection Première Moisson all-butter chocolate croissants are made with flaky pastry.'),
(14, 'Sandwich Club White Bread', 'https://467210.fs1.hubspotusercontent-na1.net/hubfs/467210/Eric%20Sandbox/slice-bread.jpg', 5, 34, 5.99, 5.99, 'Gadoua® Moelleux Sandwich Club White Bread is a soft sliced bread made from enriched wheat flour. '),
(15, 'Maroc Clementines', 'https://467210.fs1.hubspotusercontent-na1.net/hubfs/467210/Eric%20Sandbox/clementine.jpg', 1, 54, 8.99, 8.99, 'Clementines are easy to peel and have a sweet juicy flesh. '),
(16, 'Chateau Aqueria Tavel Red Wine', 'https://467210.fs1.hubspotusercontent-na1.net/hubfs/467210/Eric%20Sandbox/wine.jpg', 4, 44, 19.99, 19.99, 'Fresh, fleshy and velvety palate, with just enough lightness and bite to elevate the ripe grape'),
(17, 'Dry Rotini Pasta', 'https://467210.fs1.hubspotusercontent-na1.net/hubfs/467210/Eric%20Sandbox/rotini.jpg', 3, 58, 4.99, 4.99, 'Primo® pasta is low in fat, cholesterol free, as well as being a source of 5 essential nutrients and fibre. '),
(18, 'Whole Wheat Baguette', 'https://467210.fs1.hubspotusercontent-na1.net/hubfs/467210/Eric%20Sandbox/baguette.jpg', 5, 32, 2.99, 2.99, 'Rustic natural sourdough baguette made from wheat grown in Québec.'),
(19, 'Organic Snap Peas', 'https://467210.fs1.hubspotusercontent-na1.net/hubfs/467210/Eric%20Sandbox/snap-pea.jpg', 1, 36, 7.99, 7.99, 'Delicioso Sugar Snap Peas.'),
(20, 'Gatorade Assorted Pack', 'https://467210.fs1.hubspotusercontent-na1.net/hubfs/467210/Eric%20Sandbox/gatorade.jpg', 4, 77, 12.99, 6.99, '12 Pack of Blue Chill, Fruit Punch, Lime, Orange');

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`categoryid`) REFERENCES `categories` (`categoryid`) ON DELETE SET NULL;
COMMIT;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(64) NOT NULL,
  `role` varchar(45) NOT NULL,
  `enabled` tinyint(4) DEFAULT NULL,
  `email` varchar(110) NOT NULL,
  `address` varchar(225)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for table `users`
--

ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);
  
--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `password`, `role`, `enabled`, `email`) VALUES
(1, 'jay', '123', 'ROLE_USER', 1, 'gajerajay9@gmail.com'),
(2, 'admin', '123', 'ROLE_ADMIN', 1, '20ceuos042@ddu.ac.in'),
(3, 'mab', '123', 'ROLE_USER', 1, 'gajerajay9@gmail.com'),
(4, 'eric', '123', 'ROLE_USER', 1, 'espensieri@hotmail.com');

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

ALTER TABLE `users` CHANGE COLUMN `role` `role` VARCHAR(250) NULL;

ALTER TABLE `users` CHANGE COLUMN `role` `role` VARCHAR(250) NOT NULL DEFAULT 'ROLE_USERS';

-- --------------------------------------------------------

--
-- Table structure for table `sesssions`
--

CREATE TABLE `sessions` (
  `session_id` DATETIME,
  `user_id` int(11)
);

--
-- Indexes for table `sessions`
--

ALTER TABLE `sessions`
  ADD PRIMARY KEY (`user_id`,`session_id`);

--
-- Dumping data for table `sessions`
--
-----------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11),
  `user_id` int(11),
  `order_date` DATE,
  `status` varchar(20)
);

--
-- Indexes for table `orders`
--

ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=100;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `user_id`) VALUES
(100, 1),
(101, 4),
(102, 4);

-- --------------------------------------------------------

--
-- Table structure for table `favorites`
--

CREATE TABLE `favorites` (
  `user_id` int(11),
  `product_id` int(11)
);

--
-- Indexes for table `favorites`
--

ALTER TABLE `favorites`
  ADD PRIMARY KEY (`user_id`,`product_id`);

-- --------------------------------------------------------

--
-- Table structure for table `basket`
--

CREATE TABLE `basketItems` (
  `user_id` int(11),
  `product_id` int(11),
  `quantity` int
);

INSERT INTO `basketItems` (`user_id`, `product_id`, `quantity`) VALUES
(1, 1, 2),
(1, 2, 3),
(4, 2, 3),
(4, 3, 1),
(4, 1, 2),
(2, 1, 1);


--
-- Indexes for table `basket`
--

ALTER TABLE `basketItems`
  ADD PRIMARY KEY (`user_id`,`product_id`);

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `product_id` int(11),
  `qtySold` int(11),
  `order_id` int(11)
);

--
-- Indexes for table `sales`
--

ALTER TABLE `sales`
  ADD PRIMARY KEY (`order_id`,`product_id`);

INSERT INTO `sales` (`order_id`, `product_id`, `qtySold`) VALUES
(100, 1, 2),
(100, 2, 3),
(101, 2, 3),
(101, 3, 1),
(101, 1, 2),
(102, 1, 1);
-----------------------------------------------------------

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 05-11-2024 a las 17:22:12
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `070_hms_db`
--
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `070_reservations`, `070_rooms`, `070_customers`, `070_payments`, `070_room_category`;

SET FOREIGN_KEY_CHECKS = 1;

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `070_available_rooms_by_category_and_capacity`$$
CREATE PROCEDURE `070_available_rooms_by_category_and_capacity` (IN `var_date_in` DATE, IN `var_date_out` DATE, IN `var_capacity` INT, IN `var_room_category_name` VARCHAR(20))   BEGIN
    -- Selecciona las habitaciones disponibles en las fechas proporcionadas y con la capacidad solicitada
    SELECT *
    FROM 070_rooms_view
    WHERE room_id NOT IN (
        SELECT room_id
        FROM 070_reservations
        WHERE (070_reservations.date_in < var_date_out AND 070_reservations.date_out > var_date_in))
AND capacity >= var_capacity 
AND room_status = 1
AND room_category_name = var_room_category_name
ORDER BY rand()
LIMIT 1;
    
END$$

DROP PROCEDURE IF EXISTS `070_customers_verify`$$
CREATE PROCEDURE `070_customers_verify` (IN `var_email` VARCHAR(50), IN `var_password` VARCHAR(20))   BEGIN
    SELECT *
    FROM `070_customers`
    WHERE `email` = var_email AND `password` = var_password;
END$$

DROP PROCEDURE IF EXISTS `070_select_category_name_per_price`$$
CREATE PROCEDURE `070_select_category_name_per_price` ()   BEGIN
    SELECT room_category_name, room_category_id
    FROM `070_room_category`
    GROUP BY room_category_id
    ORDER BY room_category_price_per_day;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `070_customers`
--

DROP TABLE IF EXISTS `070_customers`;
CREATE TABLE `070_customers` (
  `customer_id` int(11) NOT NULL,
  `forename` varchar(50) NOT NULL,
  `surname` varchar(50) NOT NULL,
  `nif` varchar(20) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `password` varchar(50) NOT NULL,
  `birthday` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `070_customers`
--

INSERT INTO `070_customers` (`customer_id`, `forename`, `surname`, `nif`, `email`, `phone`, `password`, `birthday`) VALUES
(1, 'Juan', 'Pérez', '12345678A', 'juan.perez@example.com', '+34123456789', 'password123', '1985-06-15'),
(2, 'Ana', 'García', '87654321B', 'ana.garcia@example.com', '+34123456788', 'password456', '1990-08-20'),
(3, 'Carlos', 'López', '45612378C', 'carlos.lopez@example.com', '+34123456787', 'pass789', '1987-12-05'),
(4, 'Lucía', 'Martínez', '78965432D', 'lucia.martinez@example.com', '+34123456786', 'lucia321', '1995-03-10'),
(5, 'Miguel', 'Fernández', '32145698E', 'miguel.fernandez@example.com', '+34123456785', 'miguel987', '1992-11-22'),
(6, 'Sofía', 'Rodríguez', '95175328F', 'sofia.rodriguez@example.com', '+34123456784', 'sofia123', '1998-01-15'),
(7, 'David', 'Sánchez', '65478912G', 'david.sanchez@example.com', '+34123456783', 'david456', '1983-04-30'),
(8, 'Elena', 'Díaz', '85236974H', 'elena.diaz@example.com', '+34123456782', 'elena789', '1989-09-19'),
(9, 'Jorge', 'Moreno', '14785236I', 'jorge.moreno@example.com', '+34123456781', 'jorge321', '1978-05-25'),
(10, 'María', 'Gómez', '96385214J', 'maria.gomez@example.com', '+34123456780', 'maria654', '1993-07-12'),
(11, 'Jhonatan', 'Ramirez', 'dfdgsdfgsdfg', 'mity.jar@gmail.com', '435234234', 'fsfewffsdf', '2000-11-29'),
(15, 'Miriam', 'De Palma', 'sdfsdfdfsdf', 'mimi@gmail.com', '23454564565', '3464sdfsdfsdf', '1988-08-07');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `070_payments`
--

DROP TABLE IF EXISTS `070_payments`;
CREATE TABLE `070_payments` (
  `payment_id` int(11) NOT NULL,
  `reservation_id` int(11) DEFAULT NULL,
  `payment_date` datetime NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_method` enum('credit_card','cash','paypal') NOT NULL,
  `payment_status` enum('completed','failed','pending','Refunded') DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `070_payments`
--

INSERT INTO `070_payments` (`payment_id`, `reservation_id`, `payment_date`, `amount`, `payment_method`, `payment_status`) VALUES
(1, 1, '2024-10-10 00:00:00', 750.00, 'cash', 'completed'),
(2, 2, '2024-11-01 00:00:00', 150.00, 'paypal', 'completed'),
(3, 3, '2024-09-20 00:00:00', 480.00, 'paypal', 'completed'),
(4, 4, '2024-10-05 00:00:00', 100.00, 'cash', 'Refunded'),
(5, 5, '2024-10-15 00:00:00', 240.00, 'credit_card', 'completed'),
(6, 6, '2024-11-29 00:00:00', 110.00, 'paypal', 'completed'),
(7, 7, '2024-11-20 00:00:00', 510.00, 'credit_card', 'pending'),
(8, 8, '2024-10-12 00:00:00', 170.00, 'credit_card', 'completed'),
(9, 9, '2024-10-30 00:00:00', 120.00, 'paypal', 'Refunded'),
(10, 10, '2024-12-10 00:00:00', 450.00, 'cash', 'completed');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `070_reservations`
--

DROP TABLE IF EXISTS `070_reservations`;
CREATE TABLE `070_reservations` (
  `reservation_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `room_id` int(11) DEFAULT NULL,
  `date_in` date NOT NULL,
  `date_out` date NOT NULL,
  `price_per_day` decimal(10,2) NOT NULL,
  `status` enum('booked','cancelled','checked_in','checked_out') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `070_reservations`
--

INSERT INTO `070_reservations` (`reservation_id`, `customer_id`, `room_id`, `date_in`, `date_out`, `price_per_day`, `status`) VALUES
(1, 1, 11, '2024-10-15', '2024-10-20', 750.00, 'checked_in'),
(2, 2, 2, '2024-11-05', '2024-11-07', 150.00, 'booked'),
(3, 3, 6, '2024-09-22', '2024-09-25', 480.00, 'booked'),
(4, 4, 1, '2024-10-10', '2024-10-12', 100.00, 'cancelled'),
(5, 5, 5, '2024-10-18', '2024-10-21', 240.00, 'booked'),
(6, 6, 4, '2024-12-01', '2024-12-03', 110.00, 'booked'),
(7, 7, 9, '2024-11-25', '2024-11-28', 510.00, 'booked'),
(8, 8, 8, '2024-10-13', '2024-10-15', 170.00, 'booked'),
(9, 9, 7, '2024-11-02', '2024-11-04', 120.00, 'cancelled'),
(10, 10, 10, '2024-12-15', '2024-12-20', 450.00, 'booked'),
(11, 11, 11, '2024-10-01', '2024-10-10', 350.00, 'booked'),
(12, 1, 9, '2024-10-01', '2024-10-10', 90.00, 'booked'),
(13, 11, 11, '2024-10-29', '2024-10-31', 150.00, 'cancelled'),
(14, 6, 10, '2024-11-06', '2024-11-08', 150.00, 'booked'),
(15, 1, 2, '2024-11-09', '2024-11-11', 60.00, 'booked');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `070_reservations_view`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `070_reservations_view`;
CREATE TABLE `070_reservations_view` (
`reservation_id` int(11)
,`customer_id` int(11)
,`forename` varchar(50)
,`surname` varchar(50)
,`nif` varchar(20)
,`phone` varchar(15)
,`room_id` int(11)
,`room_number` varchar(10)
,`room_category_name` varchar(50)
,`date_in` date
,`date_out` date
,`price_per_day` decimal(10,2)
,`status` enum('booked','cancelled','checked_in','checked_out')
,`total_days` int(7)
,`total_price` decimal(16,2)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `070_rooms`
--

DROP TABLE IF EXISTS `070_rooms`;
CREATE TABLE `070_rooms` (
  `room_id` int(11) NOT NULL,
  `room_number` varchar(10) NOT NULL,
  `room_category_id` int(11) DEFAULT 1,
  `room_status` tinyint(1) NOT NULL,
  `capacity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `070_rooms`
--

INSERT INTO `070_rooms` (`room_id`, `room_number`, `room_category_id`, `room_status`, `capacity`) VALUES
(1, '101', 2, 0, 1),
(2, '102', 1, 1, 2),
(3, '103', 2, 1, 4),
(4, '104', 1, 0, 1),
(5, '105', 1, 1, 2),
(6, '106', 3, 0, 4),
(7, '107', 2, 0, 1),
(8, '108', 1, 0, 2),
(9, '109', 2, 1, 4),
(10, '110', 3, 1, 2),
(11, '124', 3, 1, 5),
(27, '788', 0, 1, 4);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `070_rooms_view`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `070_rooms_view`;
CREATE TABLE `070_rooms_view` (
`room_id` int(11)
,`room_number` varchar(10)
,`room_category_id` int(11)
,`room_category_name` varchar(50)
,`room_category_price_per_day` decimal(10,0)
,`room_status` tinyint(1)
,`capacity` int(11)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `070_room_category`
--

DROP TABLE IF EXISTS `070_room_category`;
CREATE TABLE `070_room_category` (
  `room_category_id` int(11) NOT NULL,
  `room_category_name` varchar(50) DEFAULT NULL,
  `room_category_price_per_day` decimal(10,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `070_room_category`
--

INSERT INTO `070_room_category` (`room_category_id`, `room_category_name`, `room_category_price_per_day`) VALUES
(1, 'simple', 60),
(2, 'double', 90),
(3, 'suite', 150);

-- --------------------------------------------------------

--
-- Estructura para la vista `070_reservations_view`
--
DROP TABLE IF EXISTS `070_reservations_view`;

DROP VIEW IF EXISTS `070_reservations_view`;
CREATE VIEW `070_reservations_view`  AS SELECT `070_reservations`.`reservation_id` AS `reservation_id`, `070_reservations`.`customer_id` AS `customer_id`, `070_customers`.`forename` AS `forename`, `070_customers`.`surname` AS `surname`, `070_customers`.`nif` AS `nif`, `070_customers`.`phone` AS `phone`, `070_reservations`.`room_id` AS `room_id`, `070_rooms_view`.`room_number` AS `room_number`, `070_rooms_view`.`room_category_name` AS `room_category_name`, `070_reservations`.`date_in` AS `date_in`, `070_reservations`.`date_out` AS `date_out`, `070_reservations`.`price_per_day` AS `price_per_day`, `070_reservations`.`status` AS `status`, to_days(`070_reservations`.`date_out`) - to_days(`070_reservations`.`date_in`) AS `total_days`, `070_reservations`.`price_per_day`* (to_days(`070_reservations`.`date_out`) - to_days(`070_reservations`.`date_in`)) AS `total_price` FROM ((`070_reservations` join `070_rooms_view` on(`070_reservations`.`room_id` = `070_rooms_view`.`room_id`)) join `070_customers` on(`070_reservations`.`customer_id` = `070_customers`.`customer_id`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `070_rooms_view`
--
DROP TABLE IF EXISTS `070_rooms_view`;

DROP VIEW IF EXISTS `070_rooms_view`;
CREATE VIEW `070_rooms_view`  AS SELECT `070_rooms`.`room_id` AS `room_id`, `070_rooms`.`room_number` AS `room_number`, `070_rooms`.`room_category_id` AS `room_category_id`, `070_room_category`.`room_category_name` AS `room_category_name`, `070_room_category`.`room_category_price_per_day` AS `room_category_price_per_day`, `070_rooms`.`room_status` AS `room_status`, `070_rooms`.`capacity` AS `capacity` FROM (`070_rooms` join `070_room_category` on(`070_rooms`.`room_category_id` = `070_room_category`.`room_category_id`)) ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `070_customers`
--
ALTER TABLE `070_customers`
  ADD PRIMARY KEY (`customer_id`) USING BTREE,
  ADD UNIQUE KEY `email` (`email`);

--
-- Indices de la tabla `070_payments`
--
ALTER TABLE `070_payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `fk_reservation` (`reservation_id`);

--
-- Indices de la tabla `070_reservations`
--
ALTER TABLE `070_reservations`
  ADD PRIMARY KEY (`reservation_id`),
  ADD KEY `fk_room` (`room_id`),
  ADD KEY `fk_customer` (`customer_id`);

--
-- Indices de la tabla `070_rooms`
--
ALTER TABLE `070_rooms`
  ADD PRIMARY KEY (`room_id`),
  ADD UNIQUE KEY `room_number` (`room_number`),
  ADD KEY `room_category_id` (`room_category_id`);

--
-- Indices de la tabla `070_room_category`
--
ALTER TABLE `070_room_category`
  ADD PRIMARY KEY (`room_category_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `070_customers`
--
ALTER TABLE `070_customers`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `070_payments`
--
ALTER TABLE `070_payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `070_reservations`
--
ALTER TABLE `070_reservations`
  MODIFY `reservation_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `070_rooms`
--
ALTER TABLE `070_rooms`
  MODIFY `room_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT de la tabla `070_room_category`
--
ALTER TABLE `070_room_category`
  MODIFY `room_category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `070_payments`
--
ALTER TABLE `070_payments`
  ADD CONSTRAINT `fk_reservation` FOREIGN KEY (`reservation_id`) REFERENCES `070_reservations` (`reservation_id`);

--
-- Filtros para la tabla `070_reservations`
--
ALTER TABLE `070_reservations`
  ADD CONSTRAINT `fk_customer` FOREIGN KEY (`customer_id`) REFERENCES `070_customers` (`customer_id`),
  ADD CONSTRAINT `fk_room` FOREIGN KEY (`room_id`) REFERENCES `070_rooms` (`room_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

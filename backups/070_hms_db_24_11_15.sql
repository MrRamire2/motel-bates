-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 15-11-2024 a las 13:08:00
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";
SET FOREIGN_KEY_CHECKS = 0;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `070_hms_db`
--

DROP TABLE IF EXISTS `070_reservations`, `070_rooms`, `070_customers`, `070_payments`, `070_room_category`, `070_rooms_view`, `070_reservations_view`, `070_users_view`, `070_customers_view`;

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
SET FOREIGN_KEY_CHECKS = 1;
DROP TABLE IF EXISTS `070_customers`;
CREATE TABLE `070_customers` (
  `customer_id` int(11) NOT NULL,
  `customer_requirements` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `070_customers`
--

INSERT INTO `070_customers` (`customer_id`, `customer_requirements`) VALUES
(1, 'Requiere habitación con vista al mar'),
(2, 'Solicita habitación doble con cama extra grande'),
(3, 'Necesita servicio de transporte desde el aeropuerto'),
(4, 'Prefiere habitación tranquila en el piso superior'),
(5, 'Requiere habitación accesible para personas con discapacidad'),
(6, 'Solicita desayuno incluido'),
(7, 'Necesita una cuna en la habitación'),
(8, 'Requiere una habitación con bañera de hidromasaje'),
(9, 'Solicita late check-out'),
(10, 'Prefiere habitación con ventana a la piscina'),
(11, 'Requiere una habitación con vista panorámica al mar'),
(12, 'Solicita una habitación adaptada para personas con movilidad reducida'),
(13, 'Prefiere habitación en el primer piso'),
(14, 'Necesita habitación para mascota'),
(15, 'Requiere paquete de spa y bienestar'),
(16, 'Solicita servicio de transporte privado desde la estación de tren'),
(17, 'Necesita asistencia para organizar tours turísticos'),
(18, 'Prefiere habitación tranquila y sin ruidos'),
(19, 'Solicita servicio de desayuno en la habitación'),
(20, 'Requiere late check-out el último día');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `070_employees`
--

DROP TABLE IF EXISTS `070_employees`;
CREATE TABLE `070_employees` (
  `employee_id` int(11) NOT NULL,
  `position_id` int(11) NOT NULL,
  `date_hiring` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `070_employees`
--

INSERT INTO `070_employees` (`employee_id`, `position_id`, `date_hiring`) VALUES
(1, 1, '2022-01-15'),
(2, 2, '2022-03-20'),
(3, 3, '2023-06-10'),
(4, 4, '2023-05-01'),
(5, 5, '2023-07-11'),
(6, 6, '2022-11-30'),
(7, 7, '2022-10-22'),
(8, 8, '2021-09-15'),
(9, 9, '2021-10-05'),
(10, 10, '2022-08-17'),
(11, 11, '2022-12-01'),
(12, 12, '2023-02-19'),
(13, 13, '2023-03-23'),
(14, 14, '2021-07-09'),
(15, 15, '2022-09-03');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `070_employees_positions`
--

DROP TABLE IF EXISTS `070_employees_positions`;
CREATE TABLE `070_employees_positions` (
  `position_id` int(11) NOT NULL,
  `position_name` varchar(100) NOT NULL,
  `position_salary` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `070_employees_positions`
--

INSERT INTO `070_employees_positions` (`position_id`, `position_name`, `position_salary`) VALUES
(1, 'General Manager', 5000.00),
(2, 'Assistant Manager', 3500.00),
(3, 'Receptionist', 1800.00),
(4, 'Concierge', 2000.00),
(5, 'Bellhop', 1500.00),
(6, 'Housekeeping Manager', 2800.00),
(7, 'Room Attendant', 1600.00),
(8, 'Chef', 4000.00),
(9, 'Cook', 2200.00),
(10, 'Waiter', 1500.00),
(11, 'Bartender', 1700.00),
(12, 'Maintenance Technician', 2400.00),
(13, 'Security Guard', 1800.00),
(14, 'Human Resources', 3000.00),
(15, 'Accountant', 3200.00);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `070_employees_view`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `070_employees_view`;
CREATE TABLE `070_employees_view` (
`employee_id` int(11)
,`date_hiring` date
,`position_id` int(11)
,`position_name` varchar(100)
,`position_salary` decimal(10,2)
);

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
(8, 8, 8, '2024-10-13', '2024-10-15', 170.00, 'cancelled'),
(9, 9, 7, '2024-11-02', '2024-11-04', 120.00, 'cancelled'),
(10, 10, 10, '2024-12-15', '2024-12-20', 450.00, 'cancelled'),
(11, 11, 11, '2024-10-01', '2024-10-10', 350.00, 'booked'),
(12, 1, 9, '2024-10-01', '2024-10-10', 90.00, 'cancelled'),
(13, 11, 11, '2024-10-29', '2024-10-31', 150.00, 'cancelled'),
(14, 6, 10, '2024-11-06', '2024-11-08', 150.00, 'booked'),
(15, 1, 2, '2024-11-09', '2024-11-11', 60.00, 'booked'),
(60, 1, 10, '2024-11-15', '2024-11-16', 150.00, 'booked'),
(61, 3, 2, '2024-11-15', '2024-11-19', 60.00, 'booked'),
(62, 15, 11, '2024-11-20', '2024-11-23', 151.00, 'booked');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `070_reservations_view`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `070_reservations_view`;
CREATE TABLE `070_reservations_view` (
`reservation_id` int(11)
,`customer_id` int(11)
,`user_id` int(11)
,`forename` varchar(50)
,`surname` varchar(50)
,`nif` varchar(10)
,`email` varchar(50)
,`phone` varchar(15)
,`birthday` date
,`customer_requirements` varchar(250)
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
-- Estructura de tabla para la tabla `070_users`
--

DROP TABLE IF EXISTS `070_users`;
CREATE TABLE `070_users` (
  `user_id` int(11) NOT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `user_forename` varchar(50) NOT NULL,
  `user_surname` varchar(50) NOT NULL,
  `user_nif` varchar(10) NOT NULL,
  `user_email` varchar(50) NOT NULL,
  `user_password` varchar(50) NOT NULL,
  `user_phone` varchar(15) NOT NULL,
  `user_birthday` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `070_users`
--

INSERT INTO `070_users` (`user_id`, `employee_id`, `customer_id`, `user_forename`, `user_surname`, `user_nif`, `user_email`, `user_password`, `user_phone`, `user_birthday`) VALUES
(1, 1, NULL, 'Juan', 'Pérez', '12345678A', 'juan.perez@example.com', 'pass1234', '555123456', '1985-03-15'),
(2, 2, NULL, 'María', 'Gómez', '23456789B', 'maria.gomez@example.com', 'pass1234', '555234567', '1990-06-25'),
(3, 3, NULL, 'Carlos', 'Lopez', '34567890C', 'carlos.lopez@example.com', 'pass1234', '555345678', '1992-09-10'),
(4, 4, NULL, 'Ana', 'Martínez', '45678901D', 'ana.martinez@example.com', 'pass1234', '555456789', '1988-11-12'),
(5, 5, NULL, 'Luis', 'Fernandez', '56789012E', 'luis.fernandez@example.com', 'pass1234', '555567890', '1993-01-05'),
(6, 6, NULL, 'Isabel', 'Ramirez', '67890123F', 'isabel.ramirez@example.com', 'pass1234', '555678901', '1987-04-22'),
(7, 7, NULL, 'Jorge', 'Hernandez', '78901234G', 'jorge.hernandez@example.com', 'pass1234', '555789012', '1995-02-15'),
(8, 8, NULL, 'Lucia', 'Mendoza', '89012345H', 'lucia.mendoza@example.com', 'pass1234', '555890123', '1983-08-19'),
(9, 9, NULL, 'Raúl', 'Morales', '90123456I', 'raul.morales@example.com', 'pass1234', '555901234', '1990-05-30'),
(10, 10, NULL, 'Sara', 'Castillo', '01234567J', 'sara.castillo@example.com', 'pass1234', '555012345', '1992-07-21'),
(11, 11, NULL, 'David', 'Ortega', '12345012K', 'david.ortega@example.com', 'pass1234', '555123450', '1994-10-13'),
(12, 12, NULL, 'Elena', 'Nuñez', '23456023L', 'elena.nunez@example.com', 'pass1234', '555234560', '1989-12-08'),
(13, 13, NULL, 'Victor', 'Flores', '34567034M', 'victor.flores@example.com', 'pass1234', '555345670', '1993-06-17'),
(14, 14, NULL, 'Clara', 'Vargas', '45678045N', 'clara.vargas@example.com', 'pass1234', '555456780', '1988-03-03'),
(15, 15, NULL, 'Pablo', 'Cruz', '56789056O', 'pablo.cruz@example.com', 'pass1234', '555567890', '1986-11-29'),
(16, 3, 1, 'Juan', 'Pérez', '12345678A', 'juan.perez@example.com', 'password123', '555123456', '1985-03-15'),
(17, 4, 2, 'María', 'Gómez', '23456789B', 'maria.gomez@example.com', 'password123', '555234567', '1990-06-25'),
(18, 5, 3, 'Carlos', 'Lopez', '34567890C', 'carlos.lopez@example.com', 'password123', '555345678', '1992-09-10'),
(19, 6, 4, 'Ana', 'Martínez', '45678901D', 'ana.martinez@example.com', 'password123', '555456789', '1988-11-12'),
(20, 7, 5, 'Luis', 'Fernandez', '56789012E', 'luis.fernandez@example.com', 'password123', '555567890', '1993-01-05'),
(21, NULL, 16, 'Ricardo', 'Sánchez', '56789012A', 'ricardo.sanchez@example.com', 'pass5678', '555678901', '1991-07-11'),
(22, NULL, 17, 'Patricia', 'Jiménez', '67890123B', 'patricia.jimenez@example.com', 'pass5678', '555789012', '1990-09-25'),
(23, NULL, 18, 'Daniela', 'Morales', '78901234C', 'daniela.morales@example.com', 'pass5678', '555890123', '1992-01-18'),
(24, NULL, 19, 'Fernando', 'Ruiz', '89012345D', 'fernando.ruiz@example.com', 'pass5678', '555901234', '1989-03-22'),
(25, NULL, 20, 'Olga', 'Fernández', '90123456E', 'olga.fernandez@example.com', 'pass5678', '555012345', '1993-11-05');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `070_users_view`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `070_users_view`;
CREATE TABLE `070_users_view` (
`user_id` int(11)
,`user_forename` varchar(50)
,`user_surname` varchar(50)
,`user_nif` varchar(10)
,`user_email` varchar(50)
,`user_password` varchar(50)
,`user_phone` varchar(15)
,`user_birthday` date
,`customer_id` int(11)
,`customer_requirements` varchar(250)
,`employee_id` int(11)
,`date_hiring` date
,`position_id` int(11)
,`position_name` varchar(100)
,`position_salary` decimal(10,2)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `070_employees_view`
--
DROP TABLE IF EXISTS `070_employees_view`;

DROP VIEW IF EXISTS `070_employees_view`;
CREATE VIEW `070_employees_view`  AS SELECT `e`.`employee_id` AS `employee_id`, `e`.`date_hiring` AS `date_hiring`, `ep`.`position_id` AS `position_id`, `ep`.`position_name` AS `position_name`, `ep`.`position_salary` AS `position_salary` FROM (`070_employees` `e` join `070_employees_positions` `ep` on(`e`.`position_id` = `ep`.`position_id`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `070_reservations_view`
--
DROP TABLE IF EXISTS `070_reservations_view`;

DROP VIEW IF EXISTS `070_reservations_view`;
CREATE VIEW `070_reservations_view`  AS SELECT `r`.`reservation_id` AS `reservation_id`, `r`.`customer_id` AS `customer_id`, `u`.`user_id` AS `user_id`, `u`.`user_forename` AS `forename`, `u`.`user_surname` AS `surname`, `u`.`user_nif` AS `nif`, `u`.`user_email` AS `email`, `u`.`user_phone` AS `phone`, `u`.`user_birthday` AS `birthday`, `u`.`customer_requirements` AS `customer_requirements`, `r`.`room_id` AS `room_id`, `rv`.`room_number` AS `room_number`, `rv`.`room_category_name` AS `room_category_name`, `r`.`date_in` AS `date_in`, `r`.`date_out` AS `date_out`, `r`.`price_per_day` AS `price_per_day`, `r`.`status` AS `status`, to_days(`r`.`date_out`) - to_days(`r`.`date_in`) AS `total_days`, `r`.`price_per_day`* (to_days(`r`.`date_out`) - to_days(`r`.`date_in`)) AS `total_price` FROM ((`070_reservations` `r` join `070_rooms_view` `rv` on(`r`.`room_id` = `rv`.`room_id`)) join `070_users_view` `u` on(`r`.`customer_id` = `u`.`customer_id`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `070_rooms_view`
--
DROP TABLE IF EXISTS `070_rooms_view`;

DROP VIEW IF EXISTS `070_rooms_view`;
CREATE VIEW `070_rooms_view`  AS SELECT `070_rooms`.`room_id` AS `room_id`, `070_rooms`.`room_number` AS `room_number`, `070_rooms`.`room_category_id` AS `room_category_id`, `070_room_category`.`room_category_name` AS `room_category_name`, `070_room_category`.`room_category_price_per_day` AS `room_category_price_per_day`, `070_rooms`.`room_status` AS `room_status`, `070_rooms`.`capacity` AS `capacity` FROM (`070_rooms` join `070_room_category` on(`070_rooms`.`room_category_id` = `070_room_category`.`room_category_id`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `070_users_view`
--
DROP TABLE IF EXISTS `070_users_view`;

DROP VIEW IF EXISTS `070_users_view`;
CREATE VIEW `070_users_view`  AS SELECT `u`.`user_id` AS `user_id`, `u`.`user_forename` AS `user_forename`, `u`.`user_surname` AS `user_surname`, `u`.`user_nif` AS `user_nif`, `u`.`user_email` AS `user_email`, `u`.`user_password` AS `user_password`, `u`.`user_phone` AS `user_phone`, `u`.`user_birthday` AS `user_birthday`, `c`.`customer_id` AS `customer_id`, `c`.`customer_requirements` AS `customer_requirements`, `e`.`employee_id` AS `employee_id`, `e`.`date_hiring` AS `date_hiring`, `e`.`position_id` AS `position_id`, `e`.`position_name` AS `position_name`, `e`.`position_salary` AS `position_salary` FROM ((`070_users` `u` left join `070_customers` `c` on(`u`.`customer_id` = `c`.`customer_id`)) left join `070_employees_view` `e` on(`u`.`employee_id` = `e`.`employee_id`)) ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `070_customers`
--
ALTER TABLE `070_customers`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indices de la tabla `070_employees`
--
ALTER TABLE `070_employees`
  ADD PRIMARY KEY (`employee_id`);

--
-- Indices de la tabla `070_employees_positions`
--
ALTER TABLE `070_employees_positions`
  ADD PRIMARY KEY (`position_id`);

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
  ADD KEY `fk_room` (`room_id`);

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
-- Indices de la tabla `070_users`
--
ALTER TABLE `070_users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `070_customers`
--
ALTER TABLE `070_customers`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `070_employees`
--
ALTER TABLE `070_employees`
  MODIFY `employee_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `070_employees_positions`
--
ALTER TABLE `070_employees_positions`
  MODIFY `position_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `070_payments`
--
ALTER TABLE `070_payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `070_reservations`
--
ALTER TABLE `070_reservations`
  MODIFY `reservation_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

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
-- AUTO_INCREMENT de la tabla `070_users`
--
ALTER TABLE `070_users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

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

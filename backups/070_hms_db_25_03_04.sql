-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 23-02-2025 a las 16:20:16
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

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
DROP TABLE IF EXISTS `070_reservations`, `070_rooms`, `070_customers`, `070_users` ,`070_employees` ,`070_employees_positions` , `070_payments`, `070_room_category`, `070_rooms_view`, `070_reservations_view`, `070_users_view`, `070_employees_view`, `070_services`, `070_reservations_services`, `070_reservations_services_view`, `070_reservations_services_view_capacity`, `070_apis`, `070_reviews`, `070_reviews_view`;
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

DROP PROCEDURE IF EXISTS `070_select_category_name_per_price`$$
CREATE PROCEDURE `070_select_category_name_per_price` ()   BEGIN
    SELECT room_category_name, room_category_id
    FROM `070_room_category`
    GROUP BY room_category_id
    ORDER BY room_category_price_per_day;
END$$

DROP PROCEDURE IF EXISTS `070_users_verify`$$
CREATE PROCEDURE `070_users_verify` (IN `var_email` VARCHAR(50), IN `var_password` VARCHAR(20))   BEGIN
    SELECT *
    FROM `070_users_view`
    WHERE `user_email` = var_email AND `user_password` = var_password;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `070_apis`
--

SET FOREIGN_KEY_CHECKS = 1;
DROP TABLE IF EXISTS `070_apis`;
CREATE TABLE `070_apis` (
  `id` int(11) NOT NULL,
  `api_id` varchar(50) DEFAULT NULL,
  `api_inserted_on` timestamp NULL DEFAULT NULL,
  `api_json` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `070_apis`
--

INSERT INTO `070_apis` (`id`, `api_id`, `api_inserted_on`, `api_json`) VALUES
(1, 'accuweather', '2025-02-06 20:07:24', '{\n    \"LocalObservationDateTime\": \"2025-02-06T14:35:00-05:00\",\n    \"EpochTime\": 1738870500,\n    \"WeatherText\": \"Clouds and sun\",\n    \"WeatherIcon\": 4,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 20.3,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 69,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(2, 'accuweather', '2025-02-07 16:23:58', '{\n    \"LocalObservationDateTime\": \"2025-02-07T11:10:00-05:00\",\n    \"EpochTime\": 1738944600,\n    \"WeatherText\": \"Mostly cloudy\",\n    \"WeatherIcon\": 6,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 17.9,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 64,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(3, 'accuweather', '2025-02-07 16:24:53', '{\n    \"LocalObservationDateTime\": \"2025-02-07T11:10:00-05:00\",\n    \"EpochTime\": 1738944600,\n    \"WeatherText\": \"Mostly cloudy\",\n    \"WeatherIcon\": 6,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 17.9,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 64,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(4, 'accuweather', '2025-02-07 16:27:20', '{\n    \"LocalObservationDateTime\": \"2025-02-07T11:20:00-05:00\",\n    \"EpochTime\": 1738945200,\n    \"WeatherText\": \"Mostly cloudy\",\n    \"WeatherIcon\": 6,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 17.9,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 64,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(5, 'accuweather', '2025-02-07 16:55:06', '{\n    \"LocalObservationDateTime\": \"2025-02-07T11:35:00-05:00\",\n    \"EpochTime\": 1738946100,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 17.9,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 64,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(6, 'accuweather', '2025-02-07 16:55:13', '{\n    \"LocalObservationDateTime\": \"2025-02-07T11:35:00-05:00\",\n    \"EpochTime\": 1738946100,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 17.9,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 64,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(7, 'accuweather', '2025-02-07 17:02:52', '{\n    \"LocalObservationDateTime\": \"2025-02-07T11:35:00-05:00\",\n    \"EpochTime\": 1738946100,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 17.9,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 64,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(8, 'accuweather', '2025-02-07 17:08:15', '{\n    \"LocalObservationDateTime\": \"2025-02-07T11:55:00-05:00\",\n    \"EpochTime\": 1738947300,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 17.9,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 64,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(9, 'accuweather', '2025-02-07 17:08:53', '{\n    \"LocalObservationDateTime\": \"2025-02-07T11:55:00-05:00\",\n    \"EpochTime\": 1738947300,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 17.9,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 64,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(10, 'accuweather', '2025-02-07 17:15:12', '{\n    \"LocalObservationDateTime\": \"2025-02-07T11:55:00-05:00\",\n    \"EpochTime\": 1738947300,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 17.9,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 64,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(11, 'accuweather', '2025-02-07 17:54:03', '{\n    \"LocalObservationDateTime\": \"2025-02-07T12:35:00-05:00\",\n    \"EpochTime\": 1738949700,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 19.4,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 67,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(12, 'accuweather', '2025-02-07 17:57:36', '{\n    \"LocalObservationDateTime\": \"2025-02-07T12:35:00-05:00\",\n    \"EpochTime\": 1738949700,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 19.4,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 67,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(13, 'accuweather', '2025-02-07 18:02:40', '{\n    \"LocalObservationDateTime\": \"2025-02-07T12:35:00-05:00\",\n    \"EpochTime\": 1738949700,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 19.4,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 67,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(14, 'accuweather', '2025-02-07 18:03:33', '{\n    \"LocalObservationDateTime\": \"2025-02-07T12:35:00-05:00\",\n    \"EpochTime\": 1738949700,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 19.4,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 67,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(15, 'accuweather', '2025-02-07 18:03:41', '{\n    \"LocalObservationDateTime\": \"2025-02-07T12:35:00-05:00\",\n    \"EpochTime\": 1738949700,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 19.4,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 67,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(16, 'accuweather', '2025-02-07 18:11:41', '{\n    \"LocalObservationDateTime\": \"2025-02-07T12:55:00-05:00\",\n    \"EpochTime\": 1738950900,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 19.4,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 67,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(17, 'accuweather', '2025-02-07 18:13:04', '{\n    \"LocalObservationDateTime\": \"2025-02-07T12:55:00-05:00\",\n    \"EpochTime\": 1738950900,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 19.4,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 67,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(18, 'accuweather', '2025-02-07 18:13:30', '{\n    \"LocalObservationDateTime\": \"2025-02-07T12:55:00-05:00\",\n    \"EpochTime\": 1738950900,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 19.4,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 67,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(19, 'accuweather', '2025-02-07 18:24:54', '{\n    \"LocalObservationDateTime\": \"2025-02-07T13:10:00-05:00\",\n    \"EpochTime\": 1738951800,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 20.3,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 69,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(20, 'accuweather', '2025-02-07 18:25:45', '{\n    \"LocalObservationDateTime\": \"2025-02-07T13:10:00-05:00\",\n    \"EpochTime\": 1738951800,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 20.3,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 69,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(21, 'accuweather', '2025-02-07 18:26:36', '{\n    \"LocalObservationDateTime\": \"2025-02-07T13:10:00-05:00\",\n    \"EpochTime\": 1738951800,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 20.3,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 69,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(22, 'accuweather', '2025-02-07 18:27:40', '{\n    \"LocalObservationDateTime\": \"2025-02-07T13:20:00-05:00\",\n    \"EpochTime\": 1738952400,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 20.3,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 69,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(23, 'accuweather', '2025-02-07 18:27:50', '{\n    \"LocalObservationDateTime\": \"2025-02-07T13:20:00-05:00\",\n    \"EpochTime\": 1738952400,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 20.3,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 69,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(24, 'accuweather', '2025-02-07 18:28:32', '{\n    \"LocalObservationDateTime\": \"2025-02-07T13:20:00-05:00\",\n    \"EpochTime\": 1738952400,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 20.3,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 69,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(25, 'accuweather', '2025-02-07 18:30:16', '{\n    \"LocalObservationDateTime\": \"2025-02-07T13:20:00-05:00\",\n    \"EpochTime\": 1738952400,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 20.3,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 69,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(26, 'accuweather', '2025-02-07 18:32:04', '{\n    \"LocalObservationDateTime\": \"2025-02-07T13:20:00-05:00\",\n    \"EpochTime\": 1738952400,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 20.3,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 69,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(27, 'accuweather', '2025-02-07 18:34:08', '{\n    \"LocalObservationDateTime\": \"2025-02-07T13:20:00-05:00\",\n    \"EpochTime\": 1738952400,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 20.3,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 69,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(28, 'accuweather', '2025-02-07 18:36:59', '{\n    \"LocalObservationDateTime\": \"2025-02-07T13:20:00-05:00\",\n    \"EpochTime\": 1738952400,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 20.3,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 69,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(29, 'accuweather', '2025-02-07 18:37:06', '{\n    \"LocalObservationDateTime\": \"2025-02-07T13:20:00-05:00\",\n    \"EpochTime\": 1738952400,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 20.3,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 69,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(30, 'accuweather', '2025-02-07 18:37:30', '{\n    \"LocalObservationDateTime\": \"2025-02-07T13:20:00-05:00\",\n    \"EpochTime\": 1738952400,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 20.3,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 69,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(31, 'accuweather', '2025-02-07 18:39:08', '{\n    \"LocalObservationDateTime\": \"2025-02-07T13:20:00-05:00\",\n    \"EpochTime\": 1738952400,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 20.3,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 69,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(32, 'accuweather', '2025-02-12 16:05:04', '{\n    \"LocalObservationDateTime\": \"2025-02-12T11:35:00-05:00\",\n    \"EpochTime\": 1739378100,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 17.5,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 64,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(33, 'accuweather', '2025-02-12 16:05:34', '{\n    \"LocalObservationDateTime\": \"2025-02-12T11:35:00-05:00\",\n    \"EpochTime\": 1739378100,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 17.5,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 64,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(34, 'accuweather', '2025-02-12 16:05:50', '{\n    \"LocalObservationDateTime\": \"2025-02-12T11:35:00-05:00\",\n    \"EpochTime\": 1739378100,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 17.5,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 64,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(35, 'accuweather', '2025-02-12 16:05:53', '{\n    \"LocalObservationDateTime\": \"2025-02-12T11:35:00-05:00\",\n    \"EpochTime\": 1739378100,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 17.5,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 64,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(36, 'accuweather', '2025-02-12 16:07:33', '{\n    \"LocalObservationDateTime\": \"2025-02-12T11:35:00-05:00\",\n    \"EpochTime\": 1739378100,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 17.5,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 64,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(37, 'accuweather', '2025-02-12 16:08:04', '{\n    \"LocalObservationDateTime\": \"2025-02-12T11:35:00-05:00\",\n    \"EpochTime\": 1739378100,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 17.5,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 64,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(38, 'accuweather', '2025-02-12 16:08:13', '{\n    \"LocalObservationDateTime\": \"2025-02-12T11:35:00-05:00\",\n    \"EpochTime\": 1739378100,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 17.5,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 64,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(39, 'accuweather', '2025-02-12 16:08:27', '{\n    \"LocalObservationDateTime\": \"2025-02-12T11:35:00-05:00\",\n    \"EpochTime\": 1739378100,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 17.5,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 64,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(40, 'accuweather', '2025-02-12 16:53:27', '{\n    \"LocalObservationDateTime\": \"2025-02-12T12:35:00-05:00\",\n    \"EpochTime\": 1739381700,\n    \"WeatherText\": \"Mostly cloudy\",\n    \"WeatherIcon\": 6,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 18.2,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 65,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(41, 'accuweather', '2025-02-12 16:57:16', '{\n    \"LocalObservationDateTime\": \"2025-02-12T12:35:00-05:00\",\n    \"EpochTime\": 1739381700,\n    \"WeatherText\": \"Mostly cloudy\",\n    \"WeatherIcon\": 6,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 18.2,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 65,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(42, 'accuweather', '2025-02-12 16:57:36', '{\n    \"LocalObservationDateTime\": \"2025-02-12T12:35:00-05:00\",\n    \"EpochTime\": 1739381700,\n    \"WeatherText\": \"Mostly cloudy\",\n    \"WeatherIcon\": 6,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 18.2,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 65,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(43, 'accuweather', '2025-02-12 16:57:59', '{\n    \"LocalObservationDateTime\": \"2025-02-12T12:35:00-05:00\",\n    \"EpochTime\": 1739381700,\n    \"WeatherText\": \"Mostly cloudy\",\n    \"WeatherIcon\": 6,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 18.2,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 65,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(44, 'accuweather', '2025-02-12 16:59:56', '{\n    \"LocalObservationDateTime\": \"2025-02-12T12:35:00-05:00\",\n    \"EpochTime\": 1739381700,\n    \"WeatherText\": \"Mostly cloudy\",\n    \"WeatherIcon\": 6,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 18.2,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 65,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(45, 'accuweather', '2025-02-12 17:21:44', '{\n    \"LocalObservationDateTime\": \"2025-02-12T12:55:00-05:00\",\n    \"EpochTime\": 1739382900,\n    \"WeatherText\": \"Mostly cloudy\",\n    \"WeatherIcon\": 6,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 18.2,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 65,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(46, 'accuweather', '2025-02-12 17:42:39', '{\n    \"LocalObservationDateTime\": \"2025-02-12T13:35:00-05:00\",\n    \"EpochTime\": 1739385300,\n    \"WeatherText\": \"Mostly cloudy\",\n    \"WeatherIcon\": 6,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 18.8,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 66,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(47, 'accuweather', '2025-02-06 20:07:24', '{\n    \"LocalObservationDateTime\": \"2025-02-06T14:35:00-05:00\",\n    \"EpochTime\": 1738870500,\n    \"WeatherText\": \"Clouds and sun\",\n    \"WeatherIcon\": 4,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 20.3,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 69,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(48, 'accuweather', '2025-02-07 16:23:58', '{\n    \"LocalObservationDateTime\": \"2025-02-07T11:10:00-05:00\",\n    \"EpochTime\": 1738944600,\n    \"WeatherText\": \"Mostly cloudy\",\n    \"WeatherIcon\": 6,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 17.9,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 64,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(49, 'accuweather', '2025-02-07 16:24:53', '{\n    \"LocalObservationDateTime\": \"2025-02-07T11:10:00-05:00\",\n    \"EpochTime\": 1738944600,\n    \"WeatherText\": \"Mostly cloudy\",\n    \"WeatherIcon\": 6,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 17.9,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 64,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(50, 'accuweather', '2025-02-07 16:27:20', '{\n    \"LocalObservationDateTime\": \"2025-02-07T11:20:00-05:00\",\n    \"EpochTime\": 1738945200,\n    \"WeatherText\": \"Mostly cloudy\",\n    \"WeatherIcon\": 6,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 17.9,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 64,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(51, 'accuweather', '2025-02-07 16:55:06', '{\n    \"LocalObservationDateTime\": \"2025-02-07T11:35:00-05:00\",\n    \"EpochTime\": 1738946100,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 17.9,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 64,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(52, 'accuweather', '2025-02-07 16:55:13', '{\n    \"LocalObservationDateTime\": \"2025-02-07T11:35:00-05:00\",\n    \"EpochTime\": 1738946100,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 17.9,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 64,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(53, 'accuweather', '2025-02-07 17:02:52', '{\n    \"LocalObservationDateTime\": \"2025-02-07T11:35:00-05:00\",\n    \"EpochTime\": 1738946100,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 17.9,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 64,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(54, 'accuweather', '2025-02-07 17:08:15', '{\n    \"LocalObservationDateTime\": \"2025-02-07T11:55:00-05:00\",\n    \"EpochTime\": 1738947300,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 17.9,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 64,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(55, 'accuweather', '2025-02-07 17:08:53', '{\n    \"LocalObservationDateTime\": \"2025-02-07T11:55:00-05:00\",\n    \"EpochTime\": 1738947300,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 17.9,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 64,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(56, 'accuweather', '2025-02-07 17:15:12', '{\n    \"LocalObservationDateTime\": \"2025-02-07T11:55:00-05:00\",\n    \"EpochTime\": 1738947300,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 17.9,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 64,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(57, 'accuweather', '2025-02-07 17:54:03', '{\n    \"LocalObservationDateTime\": \"2025-02-07T12:35:00-05:00\",\n    \"EpochTime\": 1738949700,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 19.4,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 67,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(58, 'accuweather', '2025-02-07 17:57:36', '{\n    \"LocalObservationDateTime\": \"2025-02-07T12:35:00-05:00\",\n    \"EpochTime\": 1738949700,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 19.4,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 67,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(59, 'accuweather', '2025-02-07 18:02:40', '{\n    \"LocalObservationDateTime\": \"2025-02-07T12:35:00-05:00\",\n    \"EpochTime\": 1738949700,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 19.4,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 67,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(60, 'accuweather', '2025-02-07 18:03:33', '{\n    \"LocalObservationDateTime\": \"2025-02-07T12:35:00-05:00\",\n    \"EpochTime\": 1738949700,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 19.4,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 67,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(61, 'accuweather', '2025-02-07 18:03:41', '{\n    \"LocalObservationDateTime\": \"2025-02-07T12:35:00-05:00\",\n    \"EpochTime\": 1738949700,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 19.4,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 67,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(62, 'accuweather', '2025-02-07 18:11:41', '{\n    \"LocalObservationDateTime\": \"2025-02-07T12:55:00-05:00\",\n    \"EpochTime\": 1738950900,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 19.4,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 67,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(63, 'accuweather', '2025-02-07 18:13:04', '{\n    \"LocalObservationDateTime\": \"2025-02-07T12:55:00-05:00\",\n    \"EpochTime\": 1738950900,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 19.4,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 67,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}');
INSERT INTO `070_apis` (`id`, `api_id`, `api_inserted_on`, `api_json`) VALUES
(64, 'accuweather', '2025-02-07 18:13:30', '{\n    \"LocalObservationDateTime\": \"2025-02-07T12:55:00-05:00\",\n    \"EpochTime\": 1738950900,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 19.4,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 67,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(65, 'accuweather', '2025-02-07 18:24:54', '{\n    \"LocalObservationDateTime\": \"2025-02-07T13:10:00-05:00\",\n    \"EpochTime\": 1738951800,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 20.3,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 69,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(66, 'accuweather', '2025-02-07 18:25:45', '{\n    \"LocalObservationDateTime\": \"2025-02-07T13:10:00-05:00\",\n    \"EpochTime\": 1738951800,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 20.3,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 69,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(67, 'accuweather', '2025-02-07 18:26:36', '{\n    \"LocalObservationDateTime\": \"2025-02-07T13:10:00-05:00\",\n    \"EpochTime\": 1738951800,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 20.3,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 69,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(68, 'accuweather', '2025-02-07 18:27:40', '{\n    \"LocalObservationDateTime\": \"2025-02-07T13:20:00-05:00\",\n    \"EpochTime\": 1738952400,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 20.3,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 69,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(69, 'accuweather', '2025-02-07 18:27:50', '{\n    \"LocalObservationDateTime\": \"2025-02-07T13:20:00-05:00\",\n    \"EpochTime\": 1738952400,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 20.3,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 69,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(70, 'accuweather', '2025-02-07 18:28:32', '{\n    \"LocalObservationDateTime\": \"2025-02-07T13:20:00-05:00\",\n    \"EpochTime\": 1738952400,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 20.3,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 69,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(71, 'accuweather', '2025-02-07 18:30:16', '{\n    \"LocalObservationDateTime\": \"2025-02-07T13:20:00-05:00\",\n    \"EpochTime\": 1738952400,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 20.3,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 69,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(72, 'accuweather', '2025-02-07 18:32:04', '{\n    \"LocalObservationDateTime\": \"2025-02-07T13:20:00-05:00\",\n    \"EpochTime\": 1738952400,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 20.3,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 69,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(73, 'accuweather', '2025-02-07 18:34:08', '{\n    \"LocalObservationDateTime\": \"2025-02-07T13:20:00-05:00\",\n    \"EpochTime\": 1738952400,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 20.3,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 69,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(74, 'accuweather', '2025-02-07 18:36:59', '{\n    \"LocalObservationDateTime\": \"2025-02-07T13:20:00-05:00\",\n    \"EpochTime\": 1738952400,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 20.3,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 69,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(75, 'accuweather', '2025-02-07 18:37:06', '{\n    \"LocalObservationDateTime\": \"2025-02-07T13:20:00-05:00\",\n    \"EpochTime\": 1738952400,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 20.3,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 69,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(76, 'accuweather', '2025-02-07 18:37:30', '{\n    \"LocalObservationDateTime\": \"2025-02-07T13:20:00-05:00\",\n    \"EpochTime\": 1738952400,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 20.3,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 69,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(77, 'accuweather', '2025-02-07 18:39:08', '{\n    \"LocalObservationDateTime\": \"2025-02-07T13:20:00-05:00\",\n    \"EpochTime\": 1738952400,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 20.3,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 69,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(78, 'accuweather', '2025-02-12 16:05:04', '{\n    \"LocalObservationDateTime\": \"2025-02-12T11:35:00-05:00\",\n    \"EpochTime\": 1739378100,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 17.5,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 64,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(79, 'accuweather', '2025-02-12 16:05:34', '{\n    \"LocalObservationDateTime\": \"2025-02-12T11:35:00-05:00\",\n    \"EpochTime\": 1739378100,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 17.5,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 64,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(80, 'accuweather', '2025-02-12 16:05:50', '{\n    \"LocalObservationDateTime\": \"2025-02-12T11:35:00-05:00\",\n    \"EpochTime\": 1739378100,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 17.5,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 64,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(81, 'accuweather', '2025-02-12 16:05:53', '{\n    \"LocalObservationDateTime\": \"2025-02-12T11:35:00-05:00\",\n    \"EpochTime\": 1739378100,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 17.5,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 64,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(82, 'accuweather', '2025-02-12 16:07:33', '{\n    \"LocalObservationDateTime\": \"2025-02-12T11:35:00-05:00\",\n    \"EpochTime\": 1739378100,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 17.5,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 64,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(83, 'accuweather', '2025-02-12 16:08:04', '{\n    \"LocalObservationDateTime\": \"2025-02-12T11:35:00-05:00\",\n    \"EpochTime\": 1739378100,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 17.5,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 64,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(84, 'accuweather', '2025-02-12 16:08:13', '{\n    \"LocalObservationDateTime\": \"2025-02-12T11:35:00-05:00\",\n    \"EpochTime\": 1739378100,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 17.5,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 64,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(85, 'accuweather', '2025-02-12 16:08:27', '{\n    \"LocalObservationDateTime\": \"2025-02-12T11:35:00-05:00\",\n    \"EpochTime\": 1739378100,\n    \"WeatherText\": \"Cloudy\",\n    \"WeatherIcon\": 7,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 17.5,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 64,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(86, 'accuweather', '2025-02-12 16:53:27', '{\n    \"LocalObservationDateTime\": \"2025-02-12T12:35:00-05:00\",\n    \"EpochTime\": 1739381700,\n    \"WeatherText\": \"Mostly cloudy\",\n    \"WeatherIcon\": 6,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 18.2,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 65,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(87, 'accuweather', '2025-02-12 16:57:16', '{\n    \"LocalObservationDateTime\": \"2025-02-12T12:35:00-05:00\",\n    \"EpochTime\": 1739381700,\n    \"WeatherText\": \"Mostly cloudy\",\n    \"WeatherIcon\": 6,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 18.2,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 65,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(88, 'accuweather', '2025-02-12 16:57:36', '{\n    \"LocalObservationDateTime\": \"2025-02-12T12:35:00-05:00\",\n    \"EpochTime\": 1739381700,\n    \"WeatherText\": \"Mostly cloudy\",\n    \"WeatherIcon\": 6,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 18.2,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 65,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(89, 'accuweather', '2025-02-12 16:57:59', '{\n    \"LocalObservationDateTime\": \"2025-02-12T12:35:00-05:00\",\n    \"EpochTime\": 1739381700,\n    \"WeatherText\": \"Mostly cloudy\",\n    \"WeatherIcon\": 6,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 18.2,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 65,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(90, 'accuweather', '2025-02-12 16:59:56', '{\n    \"LocalObservationDateTime\": \"2025-02-12T12:35:00-05:00\",\n    \"EpochTime\": 1739381700,\n    \"WeatherText\": \"Mostly cloudy\",\n    \"WeatherIcon\": 6,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 18.2,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 65,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(91, 'accuweather', '2025-02-12 17:21:44', '{\n    \"LocalObservationDateTime\": \"2025-02-12T12:55:00-05:00\",\n    \"EpochTime\": 1739382900,\n    \"WeatherText\": \"Mostly cloudy\",\n    \"WeatherIcon\": 6,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 18.2,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 65,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}'),
(92, 'accuweather', '2025-02-12 17:42:39', '{\n    \"LocalObservationDateTime\": \"2025-02-12T13:35:00-05:00\",\n    \"EpochTime\": 1739385300,\n    \"WeatherText\": \"Mostly cloudy\",\n    \"WeatherIcon\": 6,\n    \"HasPrecipitation\": false,\n    \"PrecipitationType\": null,\n    \"IsDayTime\": true,\n    \"Temperature\": {\n        \"Metric\": {\n            \"Value\": 18.8,\n            \"Unit\": \"C\",\n            \"UnitType\": 17\n        },\n        \"Imperial\": {\n            \"Value\": 66,\n            \"Unit\": \"F\",\n            \"UnitType\": 18\n        }\n    },\n    \"MobileLink\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\",\n    \"Link\": \"http://www.accuweather.com/en/co/bogota/107487/current-weather/107487?lang=en-us\"\n}');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `070_customers`
--

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
  `target_user_id` int(11) DEFAULT NULL,
  `position_id` int(11) NOT NULL,
  `date_hiring` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `070_employees`
--

INSERT INTO `070_employees` (`employee_id`, `target_user_id`, `position_id`, `date_hiring`) VALUES
(1, NULL, 1, '2022-01-15'),
(2, NULL, 2, '2022-03-20'),
(3, NULL, 3, '2023-06-10'),
(4, NULL, 4, '2023-05-01'),
(5, NULL, 5, '2023-07-11'),
(6, NULL, 6, '2022-11-30'),
(7, NULL, 7, '2022-10-22'),
(8, NULL, 8, '2021-09-15'),
(9, NULL, 9, '2021-10-05'),
(10, NULL, 10, '2022-08-17'),
(11, NULL, 11, '2022-12-01'),
(12, NULL, 12, '2023-02-19'),
(13, NULL, 13, '2023-03-23'),
(14, NULL, 14, '2021-07-09'),
(15, NULL, 15, '2022-09-03'),
(16, NULL, 1, '2024-11-21'),
(17, NULL, 2, '2024-11-20'),
(18, 26, 14, '2024-11-21'),
(26, 11, 8, '2024-11-24');

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `070_reservations`
--

DROP TABLE IF EXISTS `070_reservations`;
CREATE TABLE `070_reservations` (
  `reservation_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `room_id` int(11) DEFAULT NULL,
  `date_in` date NOT NULL,
  `date_out` date NOT NULL,
  `price_per_day` decimal(10,2) NOT NULL,
  `extras_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '{"gym": {}, "restaurant": {}, "spa": {}}',
  `status` enum('booked','cancelled','checked_in','checked_out') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `070_reservations`
--

INSERT INTO `070_reservations` (`reservation_id`, `user_id`, `room_id`, `date_in`, `date_out`, `price_per_day`, `extras_json`, `status`) VALUES
(66, 25, 11, '2024-12-12', '2024-12-14', 150.00, '{\"gym\": {\"256809\": {\"ticket_date_time\": \"2024-12-30-16:00\", \"ticket_subtotal\": \"222\", \"ticket_details\": \"{}\"}, \"854218\": {\"ticket_date_time\": \"2024-12-25-15:00\", \"ticket_subtotal\": \"213\", \"ticket_details\": \"{}\"}}, \"restaurant\": {}, \"spa\": {}}', 'booked'),
(67, 10, 3, '2024-12-13', '2024-12-14', 90.00, '{\"gym\": {}, \"restaurant\": {}, \"spa\": {}}', 'booked'),
(68, 27, 3, '2024-12-31', '2025-01-22', 90.00, '{\"gym\": {}, \"restaurant\": {}, \"spa\": {}}', 'booked'),
(69, 25, 11, '2024-12-17', '2024-12-20', 150.00, '{\"gym\": {}, \"restaurant\": {}, \"spa\": {}}', 'booked'),
(70, 9, 10, '2025-02-25', '2025-02-27', 150.00, '{\"gym\": {}, \"restaurant\": {}, \"spa\": {}}', 'booked'),
(71, 11, 5, '2025-02-25', '2025-02-27', 60.00, '{\"gym\": {}, \"restaurant\": {}, \"spa\": {}}', 'booked'),
(72, 12, 2, '2025-02-25', '2025-02-27', 60.00, '{\"gym\": {}, \"restaurant\": {}, \"spa\": {}}', 'booked');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `070_reservations_services`
--

DROP TABLE IF EXISTS `070_reservations_services`;
CREATE TABLE `070_reservations_services` (
  `rs_id` int(11) NOT NULL,
  `reservation_id` int(11) DEFAULT NULL,
  `service_id` varchar(20) DEFAULT NULL,
  `rs_quantity` int(11) DEFAULT NULL,
  `rs_unit_price` double(8,2) DEFAULT NULL,
  `rs_date` date DEFAULT NULL,
  `rs_time` time DEFAULT NULL,
  `rs_state` enum('booked','cancelled','enjoyed') DEFAULT 'booked'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `070_reservations_services`
--

INSERT INTO `070_reservations_services` (`rs_id`, `reservation_id`, `service_id`, `rs_quantity`, `rs_unit_price`, `rs_date`, `rs_time`, `rs_state`) VALUES
(1, 66, 'gym', 8, 40.00, '2025-01-29', '15:00:00', 'enjoyed'),
(2, 67, 'restaurant', 1, 20.00, '2025-01-23', '10:00:00', 'booked'),
(3, 66, 'gym', 2, 40.00, '2025-01-29', '10:00:00', 'enjoyed'),
(6, 68, 'gym', 4, 0.00, '2025-01-29', '14:00:00', 'booked'),
(7, 68, 'gym', 3, 0.00, '2025-01-30', '14:00:00', 'booked'),
(8, 67, 'gym', 10, 0.00, '2025-01-29', '17:00:00', 'booked'),
(9, 66, 'gym', 4, 0.00, '2025-01-29', '10:00:00', 'booked'),
(10, 69, 'gym', 4, 0.00, '2025-02-13', '10:00:00', 'booked'),
(11, 69, 'gym', 1, 0.00, '2025-01-29', '13:00:00', 'booked'),
(12, 69, 'spa', 2, 0.00, '2025-02-12', '10:00:00', 'booked'),
(13, 69, 'gym', 1, 10.00, '2025-02-07', '10:00:00', 'booked'),
(14, 66, 'spa', 3, 25.00, '2025-02-14', '10:00:00', 'booked');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `070_reservations_services_view`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `070_reservations_services_view`;
CREATE TABLE `070_reservations_services_view` (
`rs_id` int(11)
,`reservation_id` int(11)
,`service_id` varchar(20)
,`rs_quantity` int(11)
,`rs_unit_price` double(8,2)
,`rs_date` date
,`rs_time` time
,`rs_state` enum('booked','cancelled','enjoyed')
,`rs_current_persons` decimal(32,0)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `070_reservations_services_view_capacity`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `070_reservations_services_view_capacity`;
CREATE TABLE `070_reservations_services_view_capacity` (
`reservation_id` int(11)
,`service_id` varchar(20)
,`rs_date` date
,`rs_time` time
,`rs_current_persons` decimal(32,0)
,`service_max_capacity` int(11)
,`available_capacity` decimal(33,0)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `070_reservations_view`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `070_reservations_view`;
CREATE TABLE `070_reservations_view` (
`reservation_id` int(11)
,`user_id` int(11)
,`user_forename` varchar(50)
,`user_surname` varchar(50)
,`user_nif` varchar(10)
,`user_email` varchar(50)
,`user_password` varchar(50)
,`user_phone` varchar(15)
,`user_birthday` date
,`user_status` enum('active','inactive')
,`customer_id` int(11)
,`customer_requirements` varchar(250)
,`room_id` int(11)
,`room_number` varchar(10)
,`room_category_id` int(11)
,`room_category_name` varchar(50)
,`date_in` date
,`date_out` date
,`price_per_day` decimal(10,2)
,`extras_json` longtext
,`status` enum('booked','cancelled','checked_in','checked_out')
,`total_days` int(7)
,`total_price` decimal(16,2)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `070_reviews`
--

DROP TABLE IF EXISTS `070_reviews`;
CREATE TABLE `070_reviews` (
  `user_id` int(11) NOT NULL,
  `room_category_id` int(11) NOT NULL,
  `review` varchar(500) DEFAULT NULL,
  `review_score` enum('1','2','3','4','5') NOT NULL DEFAULT '5',
  `review_inserted_on` date DEFAULT NULL,
  `review_state` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `070_reviews`
--

INSERT INTO `070_reviews` (`user_id`, `room_category_id`, `review`, `review_score`, `review_inserted_on`, `review_state`) VALUES
(9, 2, 'prueba', '5', '2025-02-19', 0),
(9, 3, 'Muy agradable y cómodo, en buena zona.\nUn paseo agradable hasta el centro histórico.\nDesayuno completo, amplio y variado.\nHabitaciones amplias, con un baño grande.\nMuy buen gimnasio.\nBuena wifi.\nMuy buen trato.', '4', '2025-02-22', 1),
(10, 2, 'La ubicación era excelente, con un excelente acceso a todas las instalaciones y enlaces de transporte.', '5', '2025-02-22', 1),
(11, 1, 'Mienten con reserva realizada con mes de antelación y no ofrecen ninguna compensación a pesar de ser cliente. Para unos nada se saltan las normas, para otros trato vejatorio y maleducado.', '2', '2025-02-22', 1),
(12, 1, 'El hotel esta &quot;suspendido&quot; en el pasado, con un mantenimiento impecable y un &quot;charme&quot; de los 60. El servicio es bueno, aunque medido y las instalaciones son interesantes y limpias aunque no llegan a las comodidades estandar actuales. Su jardin, su piscina y ambiente y su publico limitado, acompañan ese encanto que tuvo y mantiene.', '5', '2025-02-22', 1),
(25, 3, 'Todo muy bien, pero por encima de todo Susana, amable, atenta..., una pasada.\nCon personas así da gusto ir a cualquier hotel.\nY la habitación que nos ha tocado, además de estar muy bien y muy limpia, tiene un tesoro que es la terraza, con unas vistas muy bonitas de la ciudad.', '5', '2025-02-22', 1);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `070_reviews_view`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `070_reviews_view`;
CREATE TABLE `070_reviews_view` (
`user_id` int(11)
,`user_forename` varchar(50)
,`user_surname` varchar(50)
,`user_email` varchar(50)
,`user_image_url` varchar(200)
,`room_category_id` int(11)
,`room_category_name` varchar(50)
,`review` varchar(500)
,`review_score` enum('1','2','3','4','5')
,`review_inserted_on` date
,`review_state` tinyint(1)
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
(11, '124', 3, 1, 6),
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
-- Estructura de tabla para la tabla `070_services`
--

DROP TABLE IF EXISTS `070_services`;
CREATE TABLE `070_services` (
  `service_id` varchar(20) NOT NULL,
  `service_unit_price` double(8,2) DEFAULT NULL,
  `service_max_capacity` int(11) DEFAULT NULL,
  `service_time_json` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `070_services`
--

INSERT INTO `070_services` (`service_id`, `service_unit_price`, `service_max_capacity`, `service_time_json`) VALUES
('bar', NULL, 40, '[\"10:00\", \"11:00\", \"12:00\", \"13:00\", \"14:00\", \"15:00\", \"16:00\", \"17:00\", \"18:00\"]'),
('gym', 10.00, 10, '[\"10:00\", \"11:00\", \"12:00\", \"13:00\", \"14:00\", \"15:00\", \"16:00\", \"17:00\", \"18:00\"]'),
('restaurant', NULL, 80, '[\"10:00\", \"11:00\", \"12:00\", \"13:00\", \"14:00\", \"15:00\", \"16:00\", \"17:00\", \"18:00\"]'),
('spa', 25.00, 20, '[\"10:00\", \"11:00\", \"12:00\", \"13:00\", \"14:00\", \"15:00\", \"16:00\", \"17:00\", \"18:00\"]');

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
  `user_birthday` date NOT NULL,
  `user_rol` enum('admin','customer') NOT NULL DEFAULT 'customer',
  `user_status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `user_image_url` varchar(200) NOT NULL DEFAULT '/images/users/default.jpg'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `070_users`
--

INSERT INTO `070_users` (`user_id`, `employee_id`, `customer_id`, `user_forename`, `user_surname`, `user_nif`, `user_email`, `user_password`, `user_phone`, `user_birthday`, `user_rol`, `user_status`, `user_image_url`) VALUES
(6, 6, NULL, 'Isabel', 'Ramirez', '67890123F', 'isabel.ramirez@example.com', 'pass1234', '555678901', '1987-04-22', 'customer', 'active', '/images/users/498a8261m2556189.jpg'),
(7, 7, NULL, 'Jorge', 'Hernandez', '78901234G', 'jorge.hernandez@example.com', 'pass1234', '555789012', '1995-02-15', 'customer', 'active', '/images/users/094r8796r727284.jpg'),
(8, 8, NULL, 'Lucia', 'Mendoza', '89012345H', 'lucia.mendoza@example.com', 'pass1234', '555890123', '1983-08-19', 'customer', 'active', '/images/users/093c0802n4305503.jpg'),
(9, 9, NULL, 'Raúl', 'Morales', '90123456I', 'raul.morales@example.com', 'pass1234', '555901234', '1990-05-30', 'customer', 'active', '/images/users/911ú6899r9568959.jpg'),
(10, 10, NULL, 'Chloe', 'Decker', '01234567J', 'sara.castillo@example.com', 'pass1234', '555012345', '1992-07-21', 'customer', 'active', '/images/users/413l0430c0763527.jpg'),
(11, 26, NULL, 'David', 'Ortega', '12345012K', 'david.ortega@example.com', 'pass1234', '555123450', '1994-10-13', 'customer', 'active', '/images/users/448v8336t4215663.jpg'),
(12, 12, NULL, 'Elena', 'Nuñez', '23456023L', 'elena.nunez@example.com', 'pass1234', '555234560', '1989-12-08', 'customer', 'active', '/images/users/710e5474ñ8133195.jpg'),
(13, 13, NULL, 'Victor', 'Flores', '34567034M', 'victor.flores@example.com', 'pass1234', '555345670', '1993-06-17', 'customer', 'active', '/images/users/763c3015o8328104.jpg'),
(14, 14, NULL, 'Clara', 'Vargas', '45678045N', 'clara.vargas@example.com', 'pass1234', '555456780', '1988-03-03', 'customer', 'active', '/images/users/918a3576r8147482.jpg'),
(15, 15, NULL, 'Pablo', 'Cruz', '56789056O', 'pablo.cruz@example.com', 'pass1234', '555567890', '1986-11-29', 'customer', 'active', '/images/users/830b4863u8435165.jpg'),
(16, 3, 1, 'Juan', 'Pérez', '12345678A', 'juan.perez@example.com', 'password123', '555123456', '1985-03-15', 'customer', 'active', '/images/users/684a2675r6326583.jpg'),
(17, 4, 2, 'María', 'Gómez', '23456789B', 'maria.gomez@example.com', 'password123', '555234567', '1990-06-25', 'customer', 'active', '/images/users/346r2862m987251376.jpg'),
(18, 5, 3, 'Carlos', 'Lopez', '34567890C', 'carlos.lopez@example.com', 'password123', '555345678', '1992-09-10', 'customer', 'active', '/images/users/218r6950p0478776.jpg'),
(19, 6, 4, 'Ana', 'Martínez', '45678901D', 'ana.martinez@example.com', 'password123', '555456789', '1988-11-12', 'customer', 'active', '/images/users/167a8889r3239615.jpg'),
(20, 7, 5, 'Luis', 'Fernandez', '56789012E', 'luis.fernandez@example.com', 'password123', '555567890', '1993-01-05', 'customer', 'active', '/images/users/516i3666r77376094.jpg'),
(21, NULL, 16, 'Ricardo', 'Sánchez', '56789012A', 'ricardo.sanchez@example.com', 'pass5678', '555678901', '1991-07-11', 'customer', 'active', '/images/users/765c3450n3034552.jpg'),
(22, NULL, 17, 'Patricia', 'Jiménez', '67890123B', 'patricia.jimenez@example.com', 'pass5678', '555789012', '1990-09-25', 'customer', 'active', '/images/users/300t7170m5344124.jpg'),
(23, NULL, 18, 'Daniela', 'Morales', '78901234C', 'daniela.morales@example.com', 'pass5678', '555890123', '1992-01-18', 'customer', 'active', '/images/users/347n0661r70924173.jpg'),
(24, NULL, 19, 'Fernando', 'Ruiz', '89012345D', 'fernando.ruiz@example.com', 'pass5678', '555901234', '1989-03-22', 'customer', 'active', '/images/users/734r9476i4597431.jpg'),
(25, NULL, 20, 'Olga', 'Fernández', '90123456E', 'olga.fernandez@example.com', 'pass5678', '555012345', '1993-11-05', 'customer', 'active', '/images/users/36a811n.jpg'),
(26, 18, NULL, 'Jhonatan', 'Ramirez', '12345678Y', 'j.ramirezap@gmail.com', '12345678a', '234545645', '2000-11-29', 'admin', 'active', '/images/users/58n554i.jpg'),
(27, 18, NULL, 'Enrique', 'Enrique', '12345678e', 'enrique@gmail.com', 'dwesteacher', '123456789', '1965-12-01', 'admin', 'active', '/images/users/196r9627r5726793.jpg');

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
,`user_rol` enum('admin','customer')
,`user_status` enum('active','inactive')
,`user_image_url` varchar(200)
,`customer_id` int(11)
,`customer_requirements` varchar(250)
,`employee_id` int(11)
,`date_hiring` varchar(10)
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
-- Estructura para la vista `070_reservations_services_view`
--
DROP TABLE IF EXISTS `070_reservations_services_view`;

DROP VIEW IF EXISTS `070_reservations_services_view`;
CREATE VIEW `070_reservations_services_view`  AS SELECT `070_reservations_services`.`rs_id` AS `rs_id`, `070_reservations_services`.`reservation_id` AS `reservation_id`, `070_reservations_services`.`service_id` AS `service_id`, `070_reservations_services`.`rs_quantity` AS `rs_quantity`, `070_reservations_services`.`rs_unit_price` AS `rs_unit_price`, `070_reservations_services`.`rs_date` AS `rs_date`, `070_reservations_services`.`rs_time` AS `rs_time`, `070_reservations_services`.`rs_state` AS `rs_state`, sum(`070_reservations_services`.`rs_quantity`) AS `rs_current_persons` FROM `070_reservations_services` WHERE `070_reservations_services`.`rs_state` <> 'cancelled' GROUP BY `070_reservations_services`.`service_id`, `070_reservations_services`.`rs_date`, `070_reservations_services`.`rs_time` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `070_reservations_services_view_capacity`
--
DROP TABLE IF EXISTS `070_reservations_services_view_capacity`;

DROP VIEW IF EXISTS `070_reservations_services_view_capacity`;
CREATE VIEW `070_reservations_services_view_capacity`  AS SELECT `rsv`.`reservation_id` AS `reservation_id`, `rsv`.`service_id` AS `service_id`, `rsv`.`rs_date` AS `rs_date`, `rsv`.`rs_time` AS `rs_time`, `rsv`.`rs_current_persons` AS `rs_current_persons`, `s`.`service_max_capacity` AS `service_max_capacity`, `s`.`service_max_capacity`- `rsv`.`rs_current_persons` AS `available_capacity` FROM (`070_reservations_services_view` `rsv` join `070_services` `s` on(`rsv`.`service_id` = `s`.`service_id`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `070_reservations_view`
--
DROP TABLE IF EXISTS `070_reservations_view`;

DROP VIEW IF EXISTS `070_reservations_view`;
CREATE VIEW `070_reservations_view`  AS SELECT `r`.`reservation_id` AS `reservation_id`, `r`.`user_id` AS `user_id`, `u`.`user_forename` AS `user_forename`, `u`.`user_surname` AS `user_surname`, `u`.`user_nif` AS `user_nif`, `u`.`user_email` AS `user_email`, `u`.`user_password` AS `user_password`, `u`.`user_phone` AS `user_phone`, `u`.`user_birthday` AS `user_birthday`, `u`.`user_status` AS `user_status`, `u`.`customer_id` AS `customer_id`, `u`.`customer_requirements` AS `customer_requirements`, `r`.`room_id` AS `room_id`, `rv`.`room_number` AS `room_number`, `rv`.`room_category_id` AS `room_category_id`, `rv`.`room_category_name` AS `room_category_name`, `r`.`date_in` AS `date_in`, `r`.`date_out` AS `date_out`, `r`.`price_per_day` AS `price_per_day`, `r`.`extras_json` AS `extras_json`, `r`.`status` AS `status`, to_days(`r`.`date_out`) - to_days(`r`.`date_in`) AS `total_days`, `r`.`price_per_day`* (to_days(`r`.`date_out`) - to_days(`r`.`date_in`)) AS `total_price` FROM ((`070_reservations` `r` left join `070_rooms_view` `rv` on(`r`.`room_id` = `rv`.`room_id`)) left join `070_users_view` `u` on(`r`.`user_id` = `u`.`user_id`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `070_reviews_view`
--
DROP TABLE IF EXISTS `070_reviews_view`;

DROP VIEW IF EXISTS `070_reviews_view`;
CREATE VIEW `070_reviews_view`  AS SELECT `r`.`user_id` AS `user_id`, `u`.`user_forename` AS `user_forename`, `u`.`user_surname` AS `user_surname`, `u`.`user_email` AS `user_email`, `u`.`user_image_url` AS `user_image_url`, `r`.`room_category_id` AS `room_category_id`, `rc`.`room_category_name` AS `room_category_name`, `r`.`review` AS `review`, `r`.`review_score` AS `review_score`, `r`.`review_inserted_on` AS `review_inserted_on`, `r`.`review_state` AS `review_state` FROM ((`070_reviews` `r` join `070_users` `u` on(`u`.`user_id` = `r`.`user_id`)) join `070_room_category` `rc` on(`rc`.`room_category_id` = `r`.`room_category_id`)) ;

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
CREATE VIEW `070_users_view`  AS SELECT `u`.`user_id` AS `user_id`, `u`.`user_forename` AS `user_forename`, `u`.`user_surname` AS `user_surname`, `u`.`user_nif` AS `user_nif`, `u`.`user_email` AS `user_email`, `u`.`user_password` AS `user_password`, `u`.`user_phone` AS `user_phone`, `u`.`user_birthday` AS `user_birthday`, `u`.`user_rol` AS `user_rol`, `u`.`user_status` AS `user_status`, `u`.`user_image_url` AS `user_image_url`, coalesce(`c`.`customer_id`,0) AS `customer_id`, coalesce(`c`.`customer_requirements`,'') AS `customer_requirements`, coalesce(`e`.`employee_id`,0) AS `employee_id`, coalesce(`e`.`date_hiring`,'') AS `date_hiring`, coalesce(`e`.`position_id`,0) AS `position_id`, coalesce(`e`.`position_name`,'') AS `position_name`, coalesce(`e`.`position_salary`,0) AS `position_salary` FROM ((`070_users` `u` left join `070_customers` `c` on(`u`.`customer_id` = `c`.`customer_id`)) left join `070_employees_view` `e` on(`u`.`employee_id` = `e`.`employee_id`)) ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `070_apis`
--
ALTER TABLE `070_apis`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `070_customers`
--
ALTER TABLE `070_customers`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indices de la tabla `070_employees`
--
ALTER TABLE `070_employees`
  ADD PRIMARY KEY (`employee_id`),
  ADD UNIQUE KEY `target_user_id` (`target_user_id`),
  ADD KEY `fk_employees_positions` (`position_id`);

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
  ADD KEY `fk_room` (`room_id`),
  ADD KEY `fk_user` (`user_id`);

--
-- Indices de la tabla `070_reservations_services`
--
ALTER TABLE `070_reservations_services`
  ADD PRIMARY KEY (`rs_id`),
  ADD KEY `reservation_id` (`reservation_id`),
  ADD KEY `service_id` (`service_id`);

--
-- Indices de la tabla `070_reviews`
--
ALTER TABLE `070_reviews`
  ADD PRIMARY KEY (`user_id`,`room_category_id`),
  ADD KEY `room_category_id` (`room_category_id`);

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
-- Indices de la tabla `070_services`
--
ALTER TABLE `070_services`
  ADD PRIMARY KEY (`service_id`);

--
-- Indices de la tabla `070_users`
--
ALTER TABLE `070_users`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `employee_id` (`employee_id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `070_apis`
--
ALTER TABLE `070_apis`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=93;

--
-- AUTO_INCREMENT de la tabla `070_customers`
--
ALTER TABLE `070_customers`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `070_employees`
--
ALTER TABLE `070_employees`
  MODIFY `employee_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

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
  MODIFY `reservation_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT de la tabla `070_reservations_services`
--
ALTER TABLE `070_reservations_services`
  MODIFY `rs_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `070_rooms`
--
ALTER TABLE `070_rooms`
  MODIFY `room_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT de la tabla `070_room_category`
--
ALTER TABLE `070_room_category`
  MODIFY `room_category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `070_users`
--
ALTER TABLE `070_users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `070_employees`
--
ALTER TABLE `070_employees`
  ADD CONSTRAINT `fk_employees_positions` FOREIGN KEY (`position_id`) REFERENCES `070_employees_positions` (`position_id`);

--
-- Filtros para la tabla `070_payments`
--
ALTER TABLE `070_payments`
  ADD CONSTRAINT `fk_reservation` FOREIGN KEY (`reservation_id`) REFERENCES `070_reservations` (`reservation_id`);

--
-- Filtros para la tabla `070_reservations`
--
ALTER TABLE `070_reservations`
  ADD CONSTRAINT `fk_room` FOREIGN KEY (`room_id`) REFERENCES `070_rooms` (`room_id`),
  ADD CONSTRAINT `fk_user` FOREIGN KEY (`user_id`) REFERENCES `070_users` (`user_id`);

--
-- Filtros para la tabla `070_reservations_services`
--
ALTER TABLE `070_reservations_services`
  ADD CONSTRAINT `070_reservations_services_ibfk_1` FOREIGN KEY (`reservation_id`) REFERENCES `070_reservations` (`reservation_id`),
  ADD CONSTRAINT `070_reservations_services_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `070_services` (`service_id`);

--
-- Filtros para la tabla `070_reviews`
--
ALTER TABLE `070_reviews`
  ADD CONSTRAINT `070_reviews_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `070_users` (`user_id`),
  ADD CONSTRAINT `070_reviews_ibfk_2` FOREIGN KEY (`room_category_id`) REFERENCES `070_room_category` (`room_category_id`);

--
-- Filtros para la tabla `070_users`
--
ALTER TABLE `070_users`
  ADD CONSTRAINT `070_users_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `070_employees` (`employee_id`),
  ADD CONSTRAINT `070_users_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `070_customers` (`customer_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

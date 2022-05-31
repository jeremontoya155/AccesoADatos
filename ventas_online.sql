-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 10-12-2021 a las 04:30:20
-- Versión del servidor: 10.4.20-MariaDB
-- Versión de PHP: 7.4.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `ventas_online`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `marcas`
--

CREATE TABLE `marcas` (
  `nombre_marca` varchar(30) NOT NULL,
  `sucursal` varchar(50) NOT NULL,
  `pais_origen` varchar(50) NOT NULL,
  `precio_exp` int(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `marcas`
--

INSERT INTO `marcas` (`nombre_marca`, `sucursal`, `pais_origen`, `precio_exp`) VALUES
('Asus', 'Easy', 'Macedonia', 200),
('Lenovo', 'Walmart', 'Mexico', 60),
('LG', 'Megatone', 'Suiza', 100),
('Logitech', 'Easy', 'India', 70),
('Noga', 'Megatone', 'China', 50);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id` smallint(6) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `precio` bigint(100) NOT NULL,
  `marca` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `nombre`, `precio`, `marca`) VALUES
(1, 'Monitor', 3000, 'Lenovo'),
(2, 'Mouse', 2000, 'Lenovo'),
(3, 'Teclado', 2200, 'Noga'),
(4, 'Impresora', 22000, 'Noga'),
(5, 'Cooler', 700, 'Logitech'),
(6, 'Conector Bluetooth', 1200, 'Logitech'),
(7, 'Silla Gamer', 45000, 'Asus'),
(8, 'Fuente', 20000, 'Asus'),
(9, 'Pantalla', 10000, 'LG'),
(10, 'Celular', 19000, 'LG');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sucursal`
--

CREATE TABLE `sucursal` (
  `sucursal` varchar(50) NOT NULL,
  `ventas` int(100) NOT NULL,
  `marcas_vendidas` int(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `sucursal`
--

INSERT INTO `sucursal` (`sucursal`, `ventas`, `marcas_vendidas`) VALUES
('Easy', 894, 2),
('Megatone', 950, 2),
('Walmart', 1000, 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `marcas`
--
ALTER TABLE `marcas`
  ADD PRIMARY KEY (`nombre_marca`),
  ADD KEY `sucursal` (`sucursal`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `marca` (`marca`);

--
-- Indices de la tabla `sucursal`
--
ALTER TABLE `sucursal`
  ADD PRIMARY KEY (`sucursal`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `marcas`
--
ALTER TABLE `marcas`
  ADD CONSTRAINT `marcas_ibfk_1` FOREIGN KEY (`sucursal`) REFERENCES `sucursal` (`sucursal`);

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`marca`) REFERENCES `marcas` (`nombre_marca`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

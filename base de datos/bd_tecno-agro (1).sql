-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 17-05-2021 a las 20:52:04
-- Versión del servidor: 10.4.14-MariaDB
-- Versión de PHP: 7.4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bd_tecno-agro`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comentarios`
--

CREATE TABLE `comentarios` (
  `idComentario` int(11) NOT NULL,
  `comentario` varchar(45) DEFAULT NULL,
  `usuarios_idusuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detallepedido`
--

CREATE TABLE `detallepedido` (
  `idDetallePedido` int(11) NOT NULL,
  `pedido` varchar(45) DEFAULT NULL,
  `producto` varchar(45) DEFAULT NULL,
  `cantidad` float DEFAULT NULL,
  `pedidos_idPedido` int(11) NOT NULL,
  `pedidos_productos_idproducto` int(11) NOT NULL,
  `pedidos_productos_usuarios_idusuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura`
--

CREATE TABLE `factura` (
  `idFactura` int(11) NOT NULL,
  `detallePedido_idDetallePedido` int(11) NOT NULL,
  `detallePedido_pedidos_idPedido` int(11) NOT NULL,
  `detallePedido_pedidos_productos_idproducto` int(11) NOT NULL,
  `detallePedido_pedidos_productos_usuarios_idusuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos`
--

CREATE TABLE `pedidos` (
  `idPedido` int(11) NOT NULL,
  `idUsuario` int(11) DEFAULT NULL,
  `fechaPedido` datetime DEFAULT NULL,
  `productos_idproducto` int(11) NOT NULL,
  `productos_usuarios_idusuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `idproducto` int(11) NOT NULL,
  `nombreProducto` varchar(100) DEFAULT NULL,
  `precioProducto` int(11) DEFAULT NULL,
  `categoriasProducto` varchar(100) DEFAULT NULL,
  `ubicacionProducto` varchar(100) DEFAULT NULL,
  `descripcionProducto` varchar(10000) DEFAULT NULL,
  `disponibilidadProducto` int(11) DEFAULT NULL,
  `usuarios_idusuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`idproducto`, `nombreProducto`, `precioProducto`, `categoriasProducto`, `ubicacionProducto`, `descripcionProducto`, `disponibilidadProducto`, `usuarios_idusuario`) VALUES
(35, 'zanahoria', 3500, 'Hortaliza', 'velez santander', 'zanahoria', 1000, 2),
(36, 'fresa', 4500, 'fruta', 'velez santander', 'fresa', 2000, 2),
(37, 'Cilantro', 2000, 'Hortaliza', 'el peñon santander', 'cilantro', 1000, 2),
(38, 'Tomate', 3200, 'verdura', 'el peñon santander', 'tomate', 2000, 2),
(39, 'Frijol', 3600, 'fruta', 'velez santander', 'Frijol', 2000, 2),
(40, 'Platano', 3800, 'fruta', 'el peñon santander', 'Platano', 3200, 2),
(41, 'Yuca', 4000, 'Hortaliza', 'velez santander', 'Yuca', 1000, 2),
(42, 'Manzana', 5600, 'fruta', 'velez santander', 'manzana', 1000, 2),
(43, 'Lulo', 4500, 'fruta', 'el peñon santander', 'Lulo', 2500, 2),
(44, 'Papaya', 3000, 'fruta', 'el peñon santander', 'papaya', 3000, 2),
(45, 'Mora', 2300, 'fruta', 'el peñon santander', 'mora', 2000, 2),
(46, 'Papa', 1500, 'Hortaliza', 'velez santander', 'papa', 3000, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `idProveedor` int(11) NOT NULL,
  `nombreProveedor` varchar(45) DEFAULT NULL,
  `telefonoProveedor` varchar(45) DEFAULT NULL,
  `usuarios_idusuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `repartidores`
--

CREATE TABLE `repartidores` (
  `idRepartidor` int(11) NOT NULL,
  `nombreRepartidor` varchar(45) DEFAULT NULL,
  `telefonoRepartidor` varchar(45) DEFAULT NULL,
  `vehiculoRepartidor` varchar(45) DEFAULT NULL,
  `repartidorescol` int(11) DEFAULT NULL,
  `vehiculos_idVehiculo` int(11) NOT NULL,
  `factura_idFactura` int(11) NOT NULL,
  `factura_detallePedido_idDetallePedido` int(11) NOT NULL,
  `factura_detallePedido_pedidos_idPedido` int(11) NOT NULL,
  `factura_detallePedido_pedidos_productos_idproducto` int(11) NOT NULL,
  `factura_detallePedido_pedidos_productos_usuarios_idusuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `idusuario` int(11) NOT NULL,
  `nombresUsuario` varchar(100) DEFAULT NULL,
  `documentoUsuario` varchar(45) DEFAULT NULL,
  `telefonoUsuario` varchar(45) DEFAULT NULL,
  `direccionUsuario` varchar(100) DEFAULT NULL,
  `correoUsuario` varchar(100) DEFAULT NULL,
  `contrasenaUsuario` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`idusuario`, `nombresUsuario`, `documentoUsuario`, `telefonoUsuario`, `direccionUsuario`, `correoUsuario`, `contrasenaUsuario`) VALUES
(2, 'Fabian Andres Ariza', '1098171632', '3142276424', 'Cra 6a #7a-30', 'fabian@gmail.com', '$2b$12$JxW6IPK4FeehZU.XTdPO3u9GMMXCG.AUnlihqRZJJ0IFFRJHzD3YC'),
(3, 'Anayeli Peña', '123456', '3142276478', 'Velez Santander', 'anayeli@gmail.com', '$2b$12$s8esfIjIpR29eHCGeIY69OqKzhWHhxPGYP/Yoyo86gWd3IQ77ixVi');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vehiculos`
--

CREATE TABLE `vehiculos` (
  `idVehiculo` int(11) NOT NULL,
  `placaVehiculo` varchar(45) DEFAULT NULL,
  `marcaVehiculo` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `comentarios`
--
ALTER TABLE `comentarios`
  ADD PRIMARY KEY (`idComentario`,`usuarios_idusuario`),
  ADD KEY `fk_comentarios_usuarios1_idx` (`usuarios_idusuario`);

--
-- Indices de la tabla `detallepedido`
--
ALTER TABLE `detallepedido`
  ADD PRIMARY KEY (`idDetallePedido`,`pedidos_idPedido`,`pedidos_productos_idproducto`,`pedidos_productos_usuarios_idusuario`),
  ADD KEY `fk_detallePedido_pedidos1_idx` (`pedidos_idPedido`,`pedidos_productos_idproducto`,`pedidos_productos_usuarios_idusuario`);

--
-- Indices de la tabla `factura`
--
ALTER TABLE `factura`
  ADD PRIMARY KEY (`idFactura`,`detallePedido_idDetallePedido`,`detallePedido_pedidos_idPedido`,`detallePedido_pedidos_productos_idproducto`,`detallePedido_pedidos_productos_usuarios_idusuario`),
  ADD KEY `fk_factura_detallePedido1_idx` (`detallePedido_idDetallePedido`,`detallePedido_pedidos_idPedido`,`detallePedido_pedidos_productos_idproducto`,`detallePedido_pedidos_productos_usuarios_idusuario`);

--
-- Indices de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`idPedido`,`productos_idproducto`,`productos_usuarios_idusuario`),
  ADD KEY `fk_pedidos_productos1_idx` (`productos_idproducto`,`productos_usuarios_idusuario`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`idproducto`,`usuarios_idusuario`),
  ADD KEY `fk_productos_usuarios1_idx` (`usuarios_idusuario`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`idProveedor`,`usuarios_idusuario`),
  ADD KEY `fk_proveedores_usuarios1_idx` (`usuarios_idusuario`);

--
-- Indices de la tabla `repartidores`
--
ALTER TABLE `repartidores`
  ADD PRIMARY KEY (`idRepartidor`,`vehiculos_idVehiculo`,`factura_idFactura`,`factura_detallePedido_idDetallePedido`,`factura_detallePedido_pedidos_idPedido`,`factura_detallePedido_pedidos_productos_idproducto`,`factura_detallePedido_pedidos_productos_usuarios_idusuario`),
  ADD KEY `fk_repartidores_vehiculos1_idx` (`vehiculos_idVehiculo`),
  ADD KEY `fk_repartidores_factura1_idx` (`factura_idFactura`,`factura_detallePedido_idDetallePedido`,`factura_detallePedido_pedidos_idPedido`,`factura_detallePedido_pedidos_productos_idproducto`,`factura_detallePedido_pedidos_productos_usuarios_idusuario`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`idusuario`);

--
-- Indices de la tabla `vehiculos`
--
ALTER TABLE `vehiculos`
  ADD PRIMARY KEY (`idVehiculo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `comentarios`
--
ALTER TABLE `comentarios`
  MODIFY `idComentario` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detallepedido`
--
ALTER TABLE `detallepedido`
  MODIFY `idDetallePedido` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `factura`
--
ALTER TABLE `factura`
  MODIFY `idFactura` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  MODIFY `idPedido` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `idproducto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `idProveedor` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `repartidores`
--
ALTER TABLE `repartidores`
  MODIFY `idRepartidor` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `idusuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `vehiculos`
--
ALTER TABLE `vehiculos`
  MODIFY `idVehiculo` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `comentarios`
--
ALTER TABLE `comentarios`
  ADD CONSTRAINT `fk_comentarios_usuarios1` FOREIGN KEY (`usuarios_idusuario`) REFERENCES `usuarios` (`idusuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `detallepedido`
--
ALTER TABLE `detallepedido`
  ADD CONSTRAINT `fk_detallePedido_pedidos1` FOREIGN KEY (`pedidos_idPedido`,`pedidos_productos_idproducto`,`pedidos_productos_usuarios_idusuario`) REFERENCES `pedidos` (`idPedido`, `productos_idproducto`, `productos_usuarios_idusuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `factura`
--
ALTER TABLE `factura`
  ADD CONSTRAINT `fk_factura_detallePedido1` FOREIGN KEY (`detallePedido_idDetallePedido`,`detallePedido_pedidos_idPedido`,`detallePedido_pedidos_productos_idproducto`,`detallePedido_pedidos_productos_usuarios_idusuario`) REFERENCES `detallepedido` (`idDetallePedido`, `pedidos_idPedido`, `pedidos_productos_idproducto`, `pedidos_productos_usuarios_idusuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD CONSTRAINT `fk_pedidos_productos1` FOREIGN KEY (`productos_idproducto`,`productos_usuarios_idusuario`) REFERENCES `productos` (`idproducto`, `usuarios_idusuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `fk_productos_usuarios1` FOREIGN KEY (`usuarios_idusuario`) REFERENCES `usuarios` (`idusuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD CONSTRAINT `fk_proveedores_usuarios1` FOREIGN KEY (`usuarios_idusuario`) REFERENCES `usuarios` (`idusuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `repartidores`
--
ALTER TABLE `repartidores`
  ADD CONSTRAINT `fk_repartidores_factura1` FOREIGN KEY (`factura_idFactura`,`factura_detallePedido_idDetallePedido`,`factura_detallePedido_pedidos_idPedido`,`factura_detallePedido_pedidos_productos_idproducto`,`factura_detallePedido_pedidos_productos_usuarios_idusuario`) REFERENCES `factura` (`idFactura`, `detallePedido_idDetallePedido`, `detallePedido_pedidos_idPedido`, `detallePedido_pedidos_productos_idproducto`, `detallePedido_pedidos_productos_usuarios_idusuario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_repartidores_vehiculos1` FOREIGN KEY (`vehiculos_idVehiculo`) REFERENCES `vehiculos` (`idVehiculo`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

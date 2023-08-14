-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Aug 14, 2023 at 06:41 PM
-- Server version: 8.0.31
-- PHP Version: 8.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dbalmacen`
--

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `sp_buscar_recibos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_buscar_recibos` (IN `id` INT)   BEGIN
select * from tblRecibos where IdRecibos = id;
END$$

DROP PROCEDURE IF EXISTS `sp_disminuir_stock`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_disminuir_stock` (IN `idprod` VARCHAR(45), IN `st` INT)   begin
update tblAlmacen set Stock = Stock - st where IdAlmacen = idprod;
END$$

DROP PROCEDURE IF EXISTS `sp_editar_lineas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_editar_lineas` (IN `id` INT, IN `linea` VARCHAR(45))   BEGIN
UPDATE tblLineas SET Nombre=linea WHERE IdLineas = id;
END$$

DROP PROCEDURE IF EXISTS `sp_editar_proveedores`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_editar_proveedores` (IN `id` INT, IN `nom` VARCHAR(45), IN `dom` VARCHAR(45), IN `tel` VARCHAR(45))   BEGIN
UPDATE tblProveedores SET NombreRS=nom, Domicilio=dom, Telefono=tel WHERE IdProveedores = id;
END$$

DROP PROCEDURE IF EXISTS `sp_editar_usuarios`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_editar_usuarios` (IN `id` INT, IN `nom` VARCHAR(45), IN `us` VARCHAR(45), IN `pass` VARCHAR(45), IN `perf` VARCHAR(45))   BEGIN
UPDATE tblUsuarios SET Nombre=nom, Usuario=us, Clave=pass, Perfil=perf WHERE IdUsuarios = id;
END$$

DROP PROCEDURE IF EXISTS `sp_eliminar_lineas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_eliminar_lineas` (IN `id` INT)   BEGIN
DELETE FROM tblLineas WHERE IdLineas = id;
END$$

DROP PROCEDURE IF EXISTS `sp_eliminar_proveedores`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_eliminar_proveedores` (IN `id` INT)   BEGIN
DELETE FROM tblProveedores WHERE IdProveedores = id;
END$$

DROP PROCEDURE IF EXISTS `sp_eliminar_usuarios`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_eliminar_usuarios` (IN `id` INT)   BEGIN
DELETE FROM tblUsuarios WHERE IdUsuarios = id;
END$$

DROP PROCEDURE IF EXISTS `sp_insertar_datellerecib`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_datellerecib` (IN `recibid` INT, IN `prodid` VARCHAR(45), IN `idlin` INT, IN `cant` INT, IN `tot` DECIMAL(18,2))   BEGIN
insert into tblDetRecibos (RecibosId,ProductosId,LineasId,Cantidad,Total) values (recibid,prodid,idlin,cant,tot);
END$$

DROP PROCEDURE IF EXISTS `sp_insertar_detallefacturas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_detallefacturas` (IN `idfact` INT, IN `idprod` VARCHAR(45), IN `cant` INT, IN `tot` DECIMAL(10,2))   BEGIN
insert into tblDetalleFactura (FacturasId,ProductosId,Cantidad,Total) values (idfact,idprod,cant,tot);
END$$

DROP PROCEDURE IF EXISTS `sp_insertar_facturas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_facturas` (IN `idlin` INT, IN `idprov` INT, IN `fechen` DATE, OUT `idfac` INT)   BEGIN
insert into tblFacturas (LineasId, ProveedoresId, FechaEntrada) values (idlin, idprov, fechen);
set idfac = @@identity;
END$$

DROP PROCEDURE IF EXISTS `sp_insertar_lineas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_lineas` (IN `linea` VARCHAR(45))   BEGIN
INSERT INTO tblLineas (Nombre) VALUES (linea);
END$$

DROP PROCEDURE IF EXISTS `sp_insertar_productos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_productos` (IN `idprod` VARCHAR(45), IN `idlin` INT, IN `descrip` VARCHAR(45), IN `st` INT, IN `punit` DECIMAL(10,2), IN `umed` VARCHAR(45))   begin
  IF EXISTS (select * from tblAlmacen where IdAlmacen = idprod) THEN
    update tblAlmacen set Stock = Stock + st where IdAlmacen = idprod;
  ELSE 
    INSERT INTO tblAlmacen (IdAlmacen, LineasId, Descripcion, PUnitario, Stock, UMedida) VALUES (idprod, idlin, descrip, punit, st, umed);
  END IF;
end$$

DROP PROCEDURE IF EXISTS `sp_insertar_proveedores`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_proveedores` (IN `nom` VARCHAR(45), IN `dom` VARCHAR(45), IN `tel` VARCHAR(45))   BEGIN
INSERT INTO tblProveedores (NombreRS, Domicilio, Telefono) VALUES (nom, dom, tel);
END$$

DROP PROCEDURE IF EXISTS `sp_insertar_recibos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_recibos` (IN `fechs` DATE, IN `personae` VARCHAR(45), IN `personar` VARCHAR(45), OUT `idrec` INT)   BEGIN
insert into tblRecibos (FechaS, PersonaEntrega, PersonaRecibe) values (fechs, personae, personar);
set idrec = @@identity;
END$$

DROP PROCEDURE IF EXISTS `sp_insertar_usuarios`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_usuarios` (IN `nom` VARCHAR(45), IN `us` VARCHAR(45), IN `pass` VARCHAR(45), IN `perf` VARCHAR(45))   BEGIN
INSERT INTO tblUsuarios (Nombre, Usuario, Clave, Perfil) VALUES (nom, us, pass, perf);
END$$

DROP PROCEDURE IF EXISTS `sp_mostrarbuscar_lineas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mostrarbuscar_lineas` (IN `linea` VARCHAR(45))   BEGIN
SELECT * FROM tblLineas WHERE Nombre LIKE CONCAT('%',linea,'%');
END$$

DROP PROCEDURE IF EXISTS `sp_mostrarbuscar_productos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mostrarbuscar_productos` (IN `prod` VARCHAR(45))   BEGIN
select * from tblAlmacen where IdAlmacen LIKE concat('%',prod,'%');
END$$

DROP PROCEDURE IF EXISTS `sp_mostrarbuscar_proveedores`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mostrarbuscar_proveedores` (IN `nom` VARCHAR(45))   BEGIN
SELECT * FROM tblProveedores WHERE NombreRS LIKE CONCAT('%',nom,'%');
END$$

DROP PROCEDURE IF EXISTS `sp_mostrarbuscar_usuarios`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mostrarbuscar_usuarios` (IN `us` VARCHAR(45))   BEGIN
SELECT * FROM tblUsuarios WHERE Usuario LIKE CONCAT('%',us,'%');
END$$

DROP PROCEDURE IF EXISTS `sp_mostrardetalleFacturas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mostrardetalleFacturas` (IN `id` INT)   BEGIN
SELECT d.ProductosId, p.Descripcion, d.Cantidad, p.UMedida,p.PUnitario,d.Total FROM tblDetalleFactura d INNER JOIN tblAlmacen p ON p.IdAlmacen = d.ProductosId WHERE FacturasId = id;
END$$

DROP PROCEDURE IF EXISTS `sp_mostrardetalleRecibos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mostrardetalleRecibos` (IN `id` INT)   BEGIN
SELECT d.ProductosId, p.Descripcion, d.Cantidad, p.UMedida,p.PUnitario,l.Nombre, d.Total FROM tblDetRecibos d INNER JOIN tblAlmacen p ON p.IdAlmacen = d.ProductosId INNER JOIN tblLineas l ON l.IdLineas = d.LineasId WHERE RecibosId = id;
END$$

DROP PROCEDURE IF EXISTS `sp_mostrar_facturas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mostrar_facturas` ()   BEGIN
SELECT f.IdFacturas, p.NombreRS, l.Nombre, f.FechaEntrada FROM tblFacturas f INNER JOIN tblProveedores p ON f.ProveedoresId = p.IdProveedores INNER JOIN tblLineas l ON f.LineasId = l.IdLineas;
END$$

DROP PROCEDURE IF EXISTS `sp_mostrar_inventario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mostrar_inventario` (IN `id` VARCHAR(45))   BEGIN
select a.IdAlmacen, a.Descripcion, a.Stock, a.UMedida, a.PUnitario, (a.Stock*a.PUnitario) AS Total, l.Nombre from tblAlmacen a INNER JOIN tblLineas l on a.LineasId = l.IdLineas where a.IdAlmacen LIKE concat('%',id,'%');
END$$

DROP PROCEDURE IF EXISTS `sp_mostrar_productosrecibos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mostrar_productosrecibos` (IN `idprod` VARCHAR(45))   BEGIN
select a.IdAlmacen, a.Descripcion, a.UMedida, a.PUnitario, l.Nombre, l.IdLineas from tblAlmacen a INNER JOIN tblLineas l on a.LineasId = l.IdLineas where a.IdAlmacen LIKE concat('%',idprod,'%');
END$$

DROP PROCEDURE IF EXISTS `sp_mostrar_recibos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mostrar_recibos` ()   BEGIN
select * from tblRecibos;
END$$

DROP PROCEDURE IF EXISTS `sp_validarusuario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validarusuario` (IN `us` VARCHAR(45), IN `pass` VARCHAR(45))   BEGIN
SELECT * FROM tblUsuarios WHERE Usuario = us AND Clave = pass;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tblalmacen`
--

DROP TABLE IF EXISTS `tblalmacen`;
CREATE TABLE IF NOT EXISTS `tblalmacen` (
  `IdAlmacen` varchar(45) NOT NULL,
  `LineasId` int NOT NULL,
  `Descripcion` varchar(45) NOT NULL,
  `Stock` int NOT NULL,
  `UMedida` varchar(45) DEFAULT NULL,
  `PUnitario` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`IdAlmacen`),
  KEY `LineasId` (`LineasId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tblalmacen`
--

INSERT INTO `tblalmacen` (`IdAlmacen`, `LineasId`, `Descripcion`, `Stock`, `UMedida`, `PUnitario`) VALUES
('1', 2, 'Pala', 24, 'Pieza', '50.00'),
('2', 2, 'martillo', 16, 'pieza', '15.00'),
('3', 1, 'escoba', 1, 'pieza', '15.00');

-- --------------------------------------------------------

--
-- Table structure for table `tbldetallefactura`
--

DROP TABLE IF EXISTS `tbldetallefactura`;
CREATE TABLE IF NOT EXISTS `tbldetallefactura` (
  `IdDetalleFacturas` int NOT NULL AUTO_INCREMENT,
  `FacturasId` int NOT NULL,
  `ProductosId` varchar(45) NOT NULL,
  `Cantidad` int NOT NULL,
  `Total` decimal(10,2) NOT NULL,
  PRIMARY KEY (`IdDetalleFacturas`),
  KEY `FacturasId` (`FacturasId`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tbldetallefactura`
--

INSERT INTO `tbldetallefactura` (`IdDetalleFacturas`, `FacturasId`, `ProductosId`, `Cantidad`, `Total`) VALUES
(1, 10, '2', 1, '15.00'),
(2, 11, '2', 1, '15.00'),
(3, 11, '1', 2, '100.00'),
(4, 12, '2', 4, '60.00'),
(5, 12, '1', 2, '100.00'),
(6, 13, '2', 2, '30.00'),
(7, 13, '1', 2, '100.00'),
(8, 14, '1', 3, '150.00'),
(9, 15, '2', 1, '15.00'),
(10, 15, '1', 2, '100.00'),
(11, 16, '2', 1, '15.00'),
(12, 16, '1', 2, '100.00'),
(13, 17, '2', 1, '15.00'),
(14, 17, '1', 1, '50.00'),
(15, 18, '2', 1, '15.00'),
(16, 18, '1', 1, '50.00'),
(17, 19, '2', 1, '15.00'),
(18, 19, '1', 1, '50.00'),
(19, 20, '2', 1, '15.00'),
(20, 20, '1', 1, '50.00'),
(21, 21, '1', 1, '50.00'),
(22, 21, '2', 2, '30.00'),
(23, 22, '1', 1, '50.00'),
(24, 23, '2', 1, '15.00'),
(25, 23, '1', 1, '50.00'),
(26, 24, '2', 1, '15.00'),
(27, 24, '1', 1, '50.00'),
(28, 25, '2', 1, '15.00'),
(29, 25, '1', 1, '50.00'),
(30, 26, '2', 1, '15.00'),
(31, 26, '1', 2, '100.00'),
(32, 27, '2', 1, '15.00'),
(33, 27, '1', 2, '100.00'),
(34, 28, '2', 1, '15.00'),
(35, 28, '1', 1, '50.00');

-- --------------------------------------------------------

--
-- Table structure for table `tbldetrecibos`
--

DROP TABLE IF EXISTS `tbldetrecibos`;
CREATE TABLE IF NOT EXISTS `tbldetrecibos` (
  `IdDetalleRecib` int NOT NULL AUTO_INCREMENT,
  `RecibosId` int NOT NULL,
  `ProductosId` varchar(45) DEFAULT NULL,
  `LineasId` int NOT NULL,
  `Cantidad` int NOT NULL,
  `Total` decimal(18,2) DEFAULT NULL,
  PRIMARY KEY (`IdDetalleRecib`),
  KEY `RecibosId` (`RecibosId`),
  KEY `LineasId` (`LineasId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tbldetrecibos`
--

INSERT INTO `tbldetrecibos` (`IdDetalleRecib`, `RecibosId`, `ProductosId`, `LineasId`, `Cantidad`, `Total`) VALUES
(1, 2, '3', 1, 1, '15.00'),
(2, 2, '2', 2, 1, '15.00'),
(3, 2, '1', 2, 2, '100.00'),
(4, 3, '2', 2, 4, '60.00'),
(5, 3, '1', 2, 3, '150.00');

-- --------------------------------------------------------

--
-- Table structure for table `tblfacturas`
--

DROP TABLE IF EXISTS `tblfacturas`;
CREATE TABLE IF NOT EXISTS `tblfacturas` (
  `IdFacturas` int NOT NULL AUTO_INCREMENT,
  `LineasId` int NOT NULL,
  `ProveedoresId` int NOT NULL,
  `FechaEntrada` date NOT NULL,
  PRIMARY KEY (`IdFacturas`),
  KEY `LineasId` (`LineasId`),
  KEY `ProveedoresId` (`ProveedoresId`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tblfacturas`
--

INSERT INTO `tblfacturas` (`IdFacturas`, `LineasId`, `ProveedoresId`, `FechaEntrada`) VALUES
(1, 1, 1, '2020-01-24'),
(2, 2, 1, '2020-01-09'),
(3, 2, 1, '2020-01-10'),
(4, 1, 1, '2020-01-18'),
(5, 1, 1, '2020-01-03'),
(6, 2, 1, '2020-01-09'),
(7, 2, 1, '2020-01-31'),
(8, 2, 1, '2020-01-09'),
(9, 2, 1, '2020-01-02'),
(10, 2, 1, '2020-01-26'),
(11, 2, 1, '2020-01-26'),
(12, 2, 1, '2020-01-28'),
(13, 1, 1, '2020-01-25'),
(14, 2, 1, '2020-01-30'),
(15, 2, 1, '2020-01-27'),
(16, 2, 1, '2020-01-30'),
(17, 2, 1, '2020-01-27'),
(18, 2, 1, '2020-01-28'),
(19, 2, 1, '2020-01-22'),
(20, 2, 1, '2020-01-30'),
(21, 2, 1, '2020-01-30'),
(22, 2, 1, '2020-01-31'),
(23, 2, 1, '2020-01-29'),
(24, 2, 1, '2020-01-30'),
(25, 2, 1, '2020-01-31'),
(26, 2, 1, '2020-01-31'),
(27, 2, 1, '2020-01-31'),
(28, 2, 1, '2020-01-30');

-- --------------------------------------------------------

--
-- Table structure for table `tbllineas`
--

DROP TABLE IF EXISTS `tbllineas`;
CREATE TABLE IF NOT EXISTS `tbllineas` (
  `IdLineas` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`IdLineas`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tbllineas`
--

INSERT INTO `tbllineas` (`IdLineas`, `Nombre`) VALUES
(1, 'Limpieza'),
(2, 'Ferreteria');

-- --------------------------------------------------------

--
-- Table structure for table `tblproveedores`
--

DROP TABLE IF EXISTS `tblproveedores`;
CREATE TABLE IF NOT EXISTS `tblproveedores` (
  `IdProveedores` int NOT NULL AUTO_INCREMENT,
  `NombreRS` varchar(45) NOT NULL,
  `Telefono` varchar(45) NOT NULL,
  `Domicilio` varchar(45) NOT NULL,
  PRIMARY KEY (`IdProveedores`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tblproveedores`
--

INSERT INTO `tblproveedores` (`IdProveedores`, `NombreRS`, `Telefono`, `Domicilio`) VALUES
(1, 'don jose', '829-999-9872', 'Punta Cana'),
(3, 'Kelyn Tejada', '809-000-0123', 'Santo Domingo');

-- --------------------------------------------------------

--
-- Table structure for table `tblrecibos`
--

DROP TABLE IF EXISTS `tblrecibos`;
CREATE TABLE IF NOT EXISTS `tblrecibos` (
  `IdRecibos` int NOT NULL AUTO_INCREMENT,
  `FechaS` date NOT NULL,
  `PersonaEntrega` varchar(45) NOT NULL,
  `PersonaRecibe` varchar(45) NOT NULL,
  PRIMARY KEY (`IdRecibos`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tblrecibos`
--

INSERT INTO `tblrecibos` (`IdRecibos`, `FechaS`, `PersonaEntrega`, `PersonaRecibe`) VALUES
(1, '2020-04-10', 'Admin', 'Enrique'),
(2, '2020-04-18', 'Admin', 'Enrique'),
(3, '2020-04-18', 'Admin', 'dvfsbvgfb');

-- --------------------------------------------------------

--
-- Table structure for table `tblusuarios`
--

DROP TABLE IF EXISTS `tblusuarios`;
CREATE TABLE IF NOT EXISTS `tblusuarios` (
  `IdUsuarios` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(45) NOT NULL,
  `Usuario` varchar(45) NOT NULL,
  `Clave` varchar(45) NOT NULL,
  `Perfil` varchar(45) NOT NULL,
  PRIMARY KEY (`IdUsuarios`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tblusuarios`
--

INSERT INTO `tblusuarios` (`IdUsuarios`, `Nombre`, `Usuario`, `Clave`, `Perfil`) VALUES
(6, 'Sterling', 'jose', '1234', 'Administrador');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tblalmacen`
--
ALTER TABLE `tblalmacen`
  ADD CONSTRAINT `tblalmacen_ibfk_1` FOREIGN KEY (`LineasId`) REFERENCES `tbllineas` (`IdLineas`);

--
-- Constraints for table `tbldetallefactura`
--
ALTER TABLE `tbldetallefactura`
  ADD CONSTRAINT `tbldetallefactura_ibfk_1` FOREIGN KEY (`FacturasId`) REFERENCES `tblfacturas` (`IdFacturas`);

--
-- Constraints for table `tbldetrecibos`
--
ALTER TABLE `tbldetrecibos`
  ADD CONSTRAINT `tbldetrecibos_ibfk_1` FOREIGN KEY (`RecibosId`) REFERENCES `tblrecibos` (`IdRecibos`),
  ADD CONSTRAINT `tbldetrecibos_ibfk_2` FOREIGN KEY (`LineasId`) REFERENCES `tbllineas` (`IdLineas`);

--
-- Constraints for table `tblfacturas`
--
ALTER TABLE `tblfacturas`
  ADD CONSTRAINT `tblfacturas_ibfk_1` FOREIGN KEY (`LineasId`) REFERENCES `tbllineas` (`IdLineas`),
  ADD CONSTRAINT `tblfacturas_ibfk_2` FOREIGN KEY (`ProveedoresId`) REFERENCES `tblproveedores` (`IdProveedores`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

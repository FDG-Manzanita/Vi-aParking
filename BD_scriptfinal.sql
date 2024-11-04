-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema MuniBD
-- -----------------------------------------------------

CREATE SCHEMA IF NOT EXISTS `MuniBD` DEFAULT CHARACTER SET utf8mb3 ;
USE `MuniBD` ;

-- -----------------------------------------------------
-- Table `MuniBD`.`detalle_pago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MuniBD`.`detalle_pago` (
  `idDetalle_pago` INT NOT NULL,
  `Total` INT NULL DEFAULT NULL,
  `descuento` TINYINT NULL DEFAULT NULL,
  `fecha` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`idDetalle_pago`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

-- -----------------------------------------------------
-- Table `MuniBD`.`encargados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MuniBD`.`encargados` (
  `idEncargado` INT NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `apellido` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idEncargado`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

-- -----------------------------------------------------
-- Table `MuniBD`.`pagos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MuniBD`.`pagos` (
  `idpagos` INT NOT NULL,
  `Tiempo_total` INT NULL DEFAULT NULL,
  `Tiempo_inicio` INT NULL DEFAULT NULL,
  `Detalle_pago_idDetalle_pago` INT NOT NULL,
  `tarifa` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idpagos`, `Detalle_pago_idDetalle_pago`),
  INDEX `fk_pagos_Detalle_pago1_idx` (`Detalle_pago_idDetalle_pago` ASC),
  CONSTRAINT `fk_pagos_Detalle_pago1`
    FOREIGN KEY (`Detalle_pago_idDetalle_pago`)
    REFERENCES `MuniBD`.`detalle_pago` (`idDetalle_pago`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

-- -----------------------------------------------------
-- Table `MuniBD`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MuniBD`.`usuarios` (
  `idUsuario` INT NOT NULL,
  `Nombre` VARCHAR(45) NULL DEFAULT NULL,
  `Apellido` VARCHAR(45) NULL DEFAULT NULL,
  `telefono` INT NULL DEFAULT NULL,
  `contraseña` VARCHAR(45) NULL DEFAULT NULL,
  `tipo` VARCHAR(5) NULL DEFAULT NULL,
  `Direccion` VARCHAR(45) NULL DEFAULT NULL,
  `Email` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`idUsuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

-- -----------------------------------------------------
-- Table `MuniBD`.`viajes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MuniBD`.`viajes` (
  `idViajes` INT NOT NULL,
  `Destino` VARCHAR(45) NULL DEFAULT NULL,
  `Fecha` VARCHAR(45) NULL DEFAULT NULL,
  `estado` TINYINT NULL DEFAULT NULL,
  `Usuario_idUsuario` INT NOT NULL,
  `pagos_idpagos` INT NOT NULL,
  PRIMARY KEY (`idViajes`, `pagos_idpagos`),
  INDEX `fk_Viajes_Usuario1_idx` (`Usuario_idUsuario` ASC),
  INDEX `fk_Viajes_pagos1_idx` (`pagos_idpagos` ASC),
  CONSTRAINT `fk_Viajes_pagos1`
    FOREIGN KEY (`pagos_idpagos`)
    REFERENCES `MuniBD`.`pagos` (`idpagos`),
  CONSTRAINT `fk_Viajes_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `MuniBD`.`usuarios` (`idUsuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

-- -----------------------------------------------------
-- Table `MuniBD`.`sector`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MuniBD`.`sector` (
  `id_sector` INT NOT NULL,
  `direccion` VARCHAR(45) NULL DEFAULT NULL,
  `ubicación` INT NULL DEFAULT NULL,
  `Encargados_idEncargado` INT NOT NULL,
  `Viajes_idViajes` INT NOT NULL,
  PRIMARY KEY (`id_sector`),
  INDEX `fk_Sector_Encargados1_idx` (`Encargados_idEncargado` ASC),
  INDEX `fk_Sector_Viajes1_idx` (`Viajes_idViajes` ASC),
  CONSTRAINT `fk_Sector_Encargados1`
    FOREIGN KEY (`Encargados_idEncargado`)
    REFERENCES `MuniBD`.`encargados` (`idEncargado`),
  CONSTRAINT `fk_Sector_Viajes1`
    FOREIGN KEY (`Viajes_idViajes`)
    REFERENCES `MuniBD`.`viajes` (`idViajes`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

-- -----------------------------------------------------
-- Table `MuniBD`.`estacionamientos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MuniBD`.`estacionamientos` (
  `Id_Estacionamiento` INT NOT NULL,
  `Nombre` VARCHAR(100) NULL DEFAULT NULL,
  `Ubicación` VARCHAR(100) NULL DEFAULT NULL,
  `Cupostotales` INT NULL DEFAULT NULL,
  `Cuposdisponibles` INT NULL DEFAULT NULL,
  `estado` VARCHAR(45) NULL DEFAULT NULL,
  `Sector_id_sector` INT NOT NULL,
  PRIMARY KEY (`Id_Estacionamiento`, `Sector_id_sector`),
  INDEX `fk_Estacionamientos_Sector_idx` (`Sector_id_sector` ASC),
  CONSTRAINT `fk_Estacionamientos_Sector`
    FOREIGN KEY (`Sector_id_sector`)
    REFERENCES `MuniBD`.`sector` (`id_sector`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

-- -----------------------------------------------------
-- Table `MuniBD`.`tarifas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MuniBD`.`tarifas` (
  `idTarifas` INT NOT NULL,
  `Precio` INT NULL DEFAULT NULL,
  `tiempo` INT NULL DEFAULT NULL,
  `tipo` VARCHAR(15) NULL DEFAULT NULL,
  `Estacionamientos_Id_Estacionamiento` INT NOT NULL,
  `Estacionamientos_Sector_id_sector` INT NOT NULL,
  `pagos_idpagos` INT NOT NULL,
  PRIMARY KEY (`idTarifas`, `pagos_idpagos`),
  INDEX `fk_Tarifas_Estacionamientos1_idx` (`Estacionamientos_Id_Estacionamiento` ASC, `Estacionamientos_Sector_id_sector` ASC),
  INDEX `fk_Tarifas_pagos1_idx` (`pagos_idpagos` ASC),
  CONSTRAINT `fk_Tarifas_Estacionamientos1`
    FOREIGN KEY (`Estacionamientos_Id_Estacionamiento` , `Estacionamientos_Sector_id_sector`)
    REFERENCES `MuniBD`.`estacionamientos` (`Id_Estacionamiento` , `Sector_id_sector`),
  CONSTRAINT `fk_Tarifas_pagos1`
    FOREIGN KEY (`pagos_idpagos`)
    REFERENCES `MuniBD`.`pagos` (`idpagos`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

-- -----------------------------------------------------
-- Table `MuniBD`.`vehiculos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MuniBD`.`vehiculos` (
  `idVehiculo` INT NOT NULL,
  `patente` VARCHAR(10) NOT NULL,
  `Usuario_idUsuario` INT NOT NULL,
  PRIMARY KEY (`idVehiculo`),
  INDEX `fk_Vehiculo_Usuario1_idx` (`Usuario_idUsuario` ASC),
  CONSTRAINT `fk_Vehiculo_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `MuniBD`.`usuarios` (`idUsuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

-- -----------------------------------------------------
-- Table `MuniBD`.`Incidente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MuniBD`.`Incidente` (
  `idIncidente` INT NOT NULL,
  `Tipo` VARCHAR(45) NULL,
  `fecha` DATE NULL,
  `estacionamientos_Id_Estacionamiento` INT NOT NULL,
  `estacionamientos_Sector_id_sector` INT NOT NULL,
  PRIMARY KEY (`idIncidente`),
  INDEX `fk_Incidente_estacionamientos1_idx` (`estacionamientos_Id_Estacionamiento` ASC, `estacionamientos_Sector_id_sector` ASC),
  CONSTRAINT `fk_Incidente_estacionamientos1`
    FOREIGN KEY (`estacionamientos_Id_Estacionamiento` , `estacionamientos_Sector_id_sector`)
    REFERENCES `MuniBD`.`estacionamientos` (`Id_Estacionamiento` , `Sector_id_sector`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

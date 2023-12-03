-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema spot_port_5
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema spot_port_5
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `spot_port_5` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
-- -----------------------------------------------------
-- Schema study_cafe_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema study_cafe_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `study_cafe_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `spot_port_5` ;

-- -----------------------------------------------------
-- Table `spot_port_5`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spot_port_5`.`user` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(55) NULL DEFAULT NULL,
  `password` VARCHAR(55) NULL DEFAULT NULL,
  `name` VARCHAR(55) NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `spot_port_5`.`spots`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spot_port_5`.`spots` (
  `spot_id` INT NOT NULL AUTO_INCREMENT,
  `spot_address` VARCHAR(200) NULL DEFAULT NULL,
  `city` VARCHAR(55) NULL DEFAULT NULL,
  `spot_name` VARCHAR(55) NULL DEFAULT NULL,
  PRIMARY KEY (`spot_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `spot_port_5`.`rating`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spot_port_5`.`rating` (
  `user_id` INT NOT NULL,
  `spot_id` INT NOT NULL,
  `spot_rating` INT NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`, `spot_id`),
  INDEX `spot_id` (`spot_id` ASC) VISIBLE,
  CONSTRAINT `rating_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `spot_port_5`.`user` (`user_id`),
  CONSTRAINT `rating_ibfk_2`
    FOREIGN KEY (`spot_id`)
    REFERENCES `spot_port_5`.`spots` (`spot_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `study_cafe_db` ;

-- -----------------------------------------------------
-- Table `study_cafe_db`.`cafes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `study_cafe_db`.`cafes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `city` VARCHAR(255) NOT NULL,
  `price_level` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `study_cafe_db`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `study_cafe_db`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(255) NOT NULL,
  `favorites` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username` (`username` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `study_cafe_db`.`favorites`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `study_cafe_db`.`favorites` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `cafe_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `user_id` (`user_id` ASC, `cafe_id` ASC) VISIBLE,
  INDEX `cafe_id` (`cafe_id` ASC) VISIBLE,
  CONSTRAINT `favorites_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `study_cafe_db`.`users` (`id`),
  CONSTRAINT `favorites_ibfk_2`
    FOREIGN KEY (`cafe_id`)
    REFERENCES `study_cafe_db`.`cafes` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

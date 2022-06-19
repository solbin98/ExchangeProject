-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`USER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`USER` (
  `user_id` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`COIN`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`COIN` (
  `coin_number` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `price` FLOAT NULL,
  PRIMARY KEY (`coin_number`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ASSET`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ASSET` (
  `average_price` FLOAT NULL,
  `volume` FLOAT NULL,
  `volume_frozen` FLOAT NULL,
  `COIN_coin_number` INT NOT NULL,
  `USER_user_id` VARCHAR(45) NOT NULL,
  INDEX `fk_ASSET_COIN1_idx` (`COIN_coin_number` ASC) VISIBLE,
  INDEX `fk_ASSET_USER1_idx` (`USER_user_id` ASC) VISIBLE,
  PRIMARY KEY (`USER_user_id`, `COIN_coin_number`),
  CONSTRAINT `fk_ASSET_COIN1`
    FOREIGN KEY (`COIN_coin_number`)
    REFERENCES `mydb`.`COIN` (`coin_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ASSET_USER1`
    FOREIGN KEY (`USER_user_id`)
    REFERENCES `mydb`.`USER` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ORDER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ORDER` (
  `order_number` INT NOT NULL AUTO_INCREMENT,
  `price` FLOAT NULL,
  `volume` FLOAT NULL,
  `type` VARCHAR(10) NULL,
  `date` VARCHAR(45) NULL,
  `USER_user_id` VARCHAR(45) NOT NULL,
  `COIN_coin_number` INT NOT NULL,
  PRIMARY KEY (`order_number`),
  INDEX `fk_ORDER_USER1_idx` (`USER_user_id` ASC) VISIBLE,
  INDEX `fk_ORDER_COIN1_idx` (`COIN_coin_number` ASC) VISIBLE,
  CONSTRAINT `fk_ORDER_USER1`
    FOREIGN KEY (`USER_user_id`)
    REFERENCES `mydb`.`USER` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ORDER_COIN1`
    FOREIGN KEY (`COIN_coin_number`)
    REFERENCES `mydb`.`COIN` (`coin_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


drop table coin_ohlc_store;

-- -----------------------------------------------------
-- Table `mydb`.`COIN_OHLC_STORE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`COIN_OHLC_STORE` (
  `coin_number` INT,
  `open` FLOAT NULL,
  `close` FLOAT NULL,
  `low` FLOAT NULL,
  `high` FLOAT NULL,
  `volume` FLOAT NULL,
  `date` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`coin_number`, `date`))
ENGINE = InnoDB;

select * from coin_ohlc_store;
drop table coin_ohlc_store;

-- -----------------------------------------------------
-- Table `mydb`.`COIN_OHLC_BACKUP`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`COIN_OHLC_BACKUP` (
  `coin_number` INT NOT NULL AUTO_INCREMENT,
  `open` FLOAT NULL,
  `close` FLOAT NULL,
  `low` FLOAT NULL,
  `high` FLOAT NULL,
  `volume` FLOAT NULL,
  PRIMARY KEY (`coin_number`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ORDER_COMPLETE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ORDER_COMPLETE` (
  `order_number` INT NOT NULL AUTO_INCREMENT,
  `price` FLOAT NULL,
  `volume` FLOAT NULL,
  `type` VARCHAR(10) NULL,
  `date` VARCHAR(45) NULL,
  `date_complete` TIME NULL,
  `USER_user_id` VARCHAR(45) NOT NULL,
  `COIN_coin_number` INT NOT NULL,
  PRIMARY KEY (`order_number`),
  INDEX `fk_ORDER_USER1_idx` (`USER_user_id` ASC) VISIBLE,
  INDEX `fk_ORDER_COIN1_idx` (`COIN_coin_number` ASC) VISIBLE,
  CONSTRAINT `fk_ORDER_USER10`
    FOREIGN KEY (`USER_user_id`)
    REFERENCES `mydb`.`USER` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ORDER_COIN10`
    FOREIGN KEY (`COIN_coin_number`)
    REFERENCES `mydb`.`COIN` (`coin_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

select * from user;
Select * from asset;
Select * from coin;
Select * from coin_ohlc;
Select * from coin_ohlc_store;
Select * from order_table;
Select * from orderbook;
Select * from order_complete;
Select * from user;

update user set user_id = "exode4" where user_id = "3";
update coin set name = "솔빈코인" where coin_number = "2";

insert into asset(average_price, volume, volume_frozen, coin_number, user_id) VALUES (0, 1000000, 0, 1, "exode4");
insert into asset(average_price, volume, volume_frozen, coin_number, user_id) VALUES (100, 2000, 0, 2, "exode4");
insert into coin_ohlc_backup(coin_number, open, close, low, high, volume) VALUES (2, 0,0,0,0,0);
insert into user(user_id, password, name) VALUES (2, "232423e", "exode4");
insert into user(user_id, password, name) VALUES (3, "1234", "test");
insert into coin(coin_number, name, price) VALUES (0, "KRW", "0");
insert into coin(coin_number, name, price) VALUES (1, "솔빈코인", "100");
insert into coin(coin_number, name, price) VALUES (0, "그냥코인", "100");
insert into orderbook(order_number, price, volume, remain_volume, type, date, user_id, coin_number) VALUES (0, 105, 1, 1, "LS", "2022-06-04", 'exode4', 2);
update orderbook set type = 'LS' where price > 100;
update asset set volume = 1, volume_frozen = 1 where user_id = "exode4" and coin_number = 2;
delete from asset where coin_number = 2;

select close from coin_ohlc where coin_number = 2;

update asset set volume_frozen = 0;
delete from orderbook;
delete from order_complete;
delete from order_table;

alter TABLE coin_ohlc_store drop column COIN_coin_number;
alter TABLE asset change COIN_coin_number coin_number int;
alter TABLE asset change USER_user_id user_id varchar(45);
alter TABLE orderbook add remain_volume float;
ALTER TABLE orderbook MODIFY COLUMN remain_volume float AFTER volume;

ALTER TABLE orderbook RENAME order_table;
ALTER TABLE coin_ohlc_backup RENAME coin_ohlc;

#매도 호가들 호출
select * from orderbook where 100 <= price and side = "LS" and coin_number = 2 order by price asc limit 15;
select * from orderbook where price >= 100 and side = "LS" order by price asc limit 15;
select * from orderbook where price <= 100 and side = "LB" order by price desc limit 15;

select * from orderbook;
DROP TABLE orderbook;
CREATE TABLE  orderbook (
  coin_number INT NOT NULL,
  price FLOAT,
  volume FLOAT NULL,
  side VARCHAR(4),
   PRIMARY KEY (price, coin_number),
   FOREIGN KEY (coin_number)
    REFERENCES coin (coin_number)
  )







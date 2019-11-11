-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema e-surat
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `e-surat` ;

-- -----------------------------------------------------
-- Schema e-surat
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `e-surat` DEFAULT CHARACTER SET utf8 ;
USE `e-surat` ;

-- -----------------------------------------------------
-- Table `e-surat`.`instansi`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `e-surat`.`instansi` ;

CREATE TABLE IF NOT EXISTS `e-surat`.`instansi` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nama` VARCHAR(45) NULL,
  `alamat` TEXT NULL,
  `no_telepon` VARCHAR(20) NULL,
  `kode_pos` VARCHAR(10) NULL,
  `fax` VARCHAR(20) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e-surat`.`jabatan`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `e-surat`.`jabatan` ;

CREATE TABLE IF NOT EXISTS `e-surat`.`jabatan` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nama` VARCHAR(45) NULL,
  `instansi_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_jabatan_instansi1_idx` (`instansi_id` ASC),
  CONSTRAINT `fk_jabatan_instansi1`
    FOREIGN KEY (`instansi_id`)
    REFERENCES `e-surat`.`instansi` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e-surat`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `e-surat`.`users` ;

CREATE TABLE IF NOT EXISTS `e-surat`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `auth_key` VARCHAR(255) NOT NULL,
  `password_hash` VARCHAR(255) NULL,
  `password_reset_token` VARCHAR(255) NULL,
  `email` VARCHAR(45) NOT NULL,
  `status` VARCHAR(45) NULL,
  `role` VARCHAR(45) NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e-surat`.`kategori_surat`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `e-surat`.`kategori_surat` ;

CREATE TABLE IF NOT EXISTS `e-surat`.`kategori_surat` (
  `id` INT NOT NULL,
  `nama` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e-surat`.`sifat`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `e-surat`.`sifat` ;

CREATE TABLE IF NOT EXISTS `e-surat`.`sifat` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nama` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e-surat`.`golongan`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `e-surat`.`golongan` ;

CREATE TABLE IF NOT EXISTS `e-surat`.`golongan` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nama` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e-surat`.`jabatan_users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `e-surat`.`jabatan_users` ;

CREATE TABLE IF NOT EXISTS `e-surat`.`jabatan_users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `jabatan_id` INT NOT NULL,
  `users_id` INT NOT NULL,
  `golongan_id` INT NOT NULL,
  `instansi_id` INT NOT NULL,
  `status` TINYINT(1) NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_jabatan_users_jabatan1_idx` (`jabatan_id` ASC) ,
  INDEX `fk_jabatan_users_users1_idx` (`users_id` ASC) ,
  INDEX `fk_jabatan_users_golongan1_idx` (`golongan_id` ASC) ,
  INDEX `fk_jabatan_users_instansi1_idx` (`instansi_id` ASC) ,
  CONSTRAINT `fk_jabatan_users_jabatan1`
    FOREIGN KEY (`jabatan_id`)
    REFERENCES `e-surat`.`jabatan` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_jabatan_users_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `e-surat`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_jabatan_users_golongan1`
    FOREIGN KEY (`golongan_id`)
    REFERENCES `e-surat`.`golongan` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_jabatan_users_instansi1`
    FOREIGN KEY (`instansi_id`)
    REFERENCES `e-surat`.`instansi` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e-surat`.`surat_masuk`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `e-surat`.`surat_masuk` ;

CREATE TABLE IF NOT EXISTS `e-surat`.`surat_masuk` (
  `id` INT NOT NULL,
  `nomor_agenda` VARCHAR(45) NULL,
  `no_surat` VARCHAR(45) NULL,
  `surat_dari` VARCHAR(45) NULL,
  `instansi_id` INT NOT NULL,
  `is_antar_dinas` TINYINT(1) NULL,
  `kategori_surat_id` INT NOT NULL,
  `sifat_id` INT NOT NULL,
  `no_tindak_lanjut` VARCHAR(45) NULL,
  `perihal` TEXT NULL,
  `tanggal` DATE NULL,
  `lampiran` VARCHAR(45) NULL,
  `file_surat` VARCHAR(45) NULL,
  `file_lampiran` VARCHAR(45) NULL,
  `jumlah_lampiran` INT NULL,
  `jabatan_users_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_surat_masuk_instansi_idx` (`instansi_id` ASC) ,
  INDEX `fk_surat_masuk_kategori_surat_masuk1_idx` (`kategori_surat_id` ASC) ,
  INDEX `fk_surat_masuk_sifat1_idx` (`sifat_id` ASC) ,
  INDEX `fk_surat_masuk_jabatan_users1_idx` (`jabatan_users_id` ASC) ,
  CONSTRAINT `fk_surat_masuk_instansi`
    FOREIGN KEY (`instansi_id`)
    REFERENCES `e-surat`.`instansi` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_surat_masuk_kategori_surat_masuk1`
    FOREIGN KEY (`kategori_surat_id`)
    REFERENCES `e-surat`.`kategori_surat` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_surat_masuk_sifat1`
    FOREIGN KEY (`sifat_id`)
    REFERENCES `e-surat`.`sifat` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_surat_masuk_jabatan_users1`
    FOREIGN KEY (`jabatan_users_id`)
    REFERENCES `e-surat`.`jabatan_users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `e-surat`.`surat_keluar`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `e-surat`.`surat_keluar` ;

CREATE TABLE IF NOT EXISTS `e-surat`.`surat_keluar` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nomor_klasifikasi` VARCHAR(45) NULL,
  `file_lampiran` VARCHAR(45) NULL,
  `perihal` TEXT NULL,
  `jabatan_id` INT NOT NULL,
  `sifat_id` INT NOT NULL,
  `kategori_surat_id` INT NOT NULL,
  `isi_surat` TEXT NULL,
  `isi_lampiran_surat` TEXT NULL,
  `no_agenda` VARCHAR(45) NULL,
  `tanggal` DATETIME NULL,
  `instansi_id` INT NOT NULL,
  `approval_surat_keluar_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_surat_keluar_jabatan1_idx` (`jabatan_id` ASC) ,
  INDEX `fk_surat_keluar_sifat1_idx` (`sifat_id` ASC) ,
  INDEX `fk_surat_keluar_kategori_surat1_idx` (`kategori_surat_id` ASC) ,
  INDEX `fk_surat_keluar_instansi1_idx` (`instansi_id` ASC) ,
  INDEX `fk_surat_keluar_approval_surat_keluar1_idx` (`approval_surat_keluar_id` ASC) ,
  CONSTRAINT `fk_surat_keluar_jabatan1`
    FOREIGN KEY (`jabatan_id`)
    REFERENCES `e-surat`.`jabatan` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_surat_keluar_sifat1`
    FOREIGN KEY (`sifat_id`)
    REFERENCES `e-surat`.`sifat` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_surat_keluar_kategori_surat1`
    FOREIGN KEY (`kategori_surat_id`)
    REFERENCES `e-surat`.`kategori_surat` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_surat_keluar_instansi1`
    FOREIGN KEY (`instansi_id`)
    REFERENCES `e-surat`.`instansi` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e-surat`.`approval_surat_keluar`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `e-surat`.`approval_surat_keluar` ;

CREATE TABLE IF NOT EXISTS `e-surat`.`approval_surat_keluar` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `surat_keluar_id` INT NOT NULL,
  `jabatan_users_id` INT NOT NULL,
  `status` VARCHAR(45) NULL,
  `tanggal` DATETIME NULL,
  `keterangan` TEXT NULL,
  `dari_jabatan_users_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_approval_surat_keluar_surat_keluar1_idx` (`surat_keluar_id` ASC) ,
  INDEX `fk_approval_surat_keluar_jabatan_users1_idx` (`jabatan_users_id` ASC) ,
  INDEX `fk_approval_surat_keluar_jabatan_users2_idx` (`dari_jabatan_users_id` ASC) ,
  CONSTRAINT `fk_approval_surat_keluar_surat_keluar1`
    FOREIGN KEY (`surat_keluar_id`)
    REFERENCES `e-surat`.`surat_keluar` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_approval_surat_keluar_jabatan_users1`
    FOREIGN KEY (`jabatan_users_id`)
    REFERENCES `e-surat`.`jabatan_users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_approval_surat_keluar_jabatan_users2`
    FOREIGN KEY (`dari_jabatan_users_id`)
    REFERENCES `e-surat`.`jabatan_users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `e-surat`.`kategori_surat_keluar`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `e-surat`.`kategori_surat_keluar` ;

CREATE TABLE IF NOT EXISTS `e-surat`.`kategori_surat_keluar` (
  `id` INT NOT NULL,
  `nama` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e-surat`.`disposisi_surat_masuk`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `e-surat`.`disposisi_surat_masuk` ;

CREATE TABLE IF NOT EXISTS `e-surat`.`disposisi_surat_masuk` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `surat_masuk_id` INT NOT NULL,
  `jabatan_users_id` INT NOT NULL,
  `status` VARCHAR(20) NULL,
  `tanggal` DATETIME NULL,
  `keterangan` VARCHAR(45) NULL,
  `dari_jabatan_users_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_disposisi_surat_masuk_surat_masuk1_idx` (`surat_masuk_id` ASC) ,
  INDEX `fk_disposisi_surat_masuk_jabatan_users1_idx` (`jabatan_users_id` ASC) ,
  INDEX `fk_disposisi_surat_masuk_jabatan_users2_idx` (`dari_jabatan_users_id` ASC) ,
  CONSTRAINT `fk_disposisi_surat_masuk_surat_masuk1`
    FOREIGN KEY (`surat_masuk_id`)
    REFERENCES `e-surat`.`surat_masuk` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_disposisi_surat_masuk_jabatan_users1`
    FOREIGN KEY (`jabatan_users_id`)
    REFERENCES `e-surat`.`jabatan_users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_disposisi_surat_masuk_jabatan_users2`
    FOREIGN KEY (`dari_jabatan_users_id`)
    REFERENCES `e-surat`.`jabatan_users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e-surat`.`disposisi_rules_node`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `e-surat`.`disposisi_rules_node` ;

CREATE TABLE IF NOT EXISTS `e-surat`.`disposisi_rules_node` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `instansi_id` INT NOT NULL,
  `jabatan_id` INT NOT NULL,
  `penerima_surat` TINYINT(1) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_surat_rules_node_instansi1_idx` (`instansi_id` ASC) ,
  INDEX `fk_surat_rules_node_jabatan1_idx` (`jabatan_id` ASC) ,
  CONSTRAINT `fk_surat_rules_node_instansi1`
    FOREIGN KEY (`instansi_id`)
    REFERENCES `e-surat`.`instansi` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_surat_rules_node_jabatan1`
    FOREIGN KEY (`jabatan_id`)
    REFERENCES `e-surat`.`jabatan` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e-surat`.`disposisi_rules_edge`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `e-surat`.`disposisi_rules_edge` ;

CREATE TABLE IF NOT EXISTS `e-surat`.`disposisi_rules_edge` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `parent_node_id` INT NOT NULL,
  `child_node_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_surat_rules_edge_surat_rules_node1_idx` (`parent_node_id` ASC) ,
  INDEX `fk_surat_rules_edge_surat_rules_node2_idx` (`child_node_id` ASC) ,
  CONSTRAINT `fk_surat_rules_edge_surat_rules_node1`
    FOREIGN KEY (`parent_node_id`)
    REFERENCES `e-surat`.`disposisi_rules_node` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_surat_rules_edge_surat_rules_node2`
    FOREIGN KEY (`child_node_id`)
    REFERENCES `e-surat`.`disposisi_rules_node` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e-surat`.`appoval_rules_node`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `e-surat`.`appoval_rules_node` ;

CREATE TABLE IF NOT EXISTS `e-surat`.`appoval_rules_node` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `instansi_id` INT NOT NULL,
  `jabatan_id` INT NOT NULL,
  `bisa_menandatangani` TINYINT(1) NULL,
  `bisa_atas_nama` TINYINT(1) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_appoval_rules_node_instansi1_idx` (`instansi_id` ASC) ,
  INDEX `fk_appoval_rules_node_jabatan1_idx` (`jabatan_id` ASC) ,
  CONSTRAINT `fk_appoval_rules_node_instansi1`
    FOREIGN KEY (`instansi_id`)
    REFERENCES `e-surat`.`instansi` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_appoval_rules_node_jabatan1`
    FOREIGN KEY (`jabatan_id`)
    REFERENCES `e-surat`.`jabatan` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e-surat`.`approval_rules_edge`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `e-surat`.`approval_rules_edge` ;

CREATE TABLE IF NOT EXISTS `e-surat`.`approval_rules_edge` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `parent_rules_node_id` INT NOT NULL,
  `child_rules_node_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_approval_rules_edge_appoval_rules_node1_idx` (`parent_rules_node_id` ASC) ,
  INDEX `fk_approval_rules_edge_appoval_rules_node2_idx` (`child_rules_node_id` ASC) ,
  CONSTRAINT `fk_approval_rules_edge_appoval_rules_node1`
    FOREIGN KEY (`parent_rules_node_id`)
    REFERENCES `e-surat`.`appoval_rules_node` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_approval_rules_edge_appoval_rules_node2`
    FOREIGN KEY (`child_rules_node_id`)
    REFERENCES `e-surat`.`appoval_rules_node` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

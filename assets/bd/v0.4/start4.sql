-- MySQL Script generated by MySQL Workbench
-- Sun Oct  6 19:06:49 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

-- SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
-- SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
-- SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema infin526_quizv2
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table `evento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `evento` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `evenome` VARCHAR(200) NOT NULL,
  `eveimg` VARCHAR(100) DEFAULT NULL,
  `evesituacao` INT(11) NOT NULL DEFAULT 0 COMMENT '0 - criado\n1 - iniciado\n2 - finalizado',
  `criado_em` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `atualizado_em` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `equipe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `equipe` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idevento` INT NOT NULL,
  `equnome` VARCHAR(200) NOT NULL,
  `equlogada` INT NOT NULL DEFAULT 0,
  `equlogo` VARCHAR(100) DEFAULT NULL,
  `criado_em` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `atualizado_em` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_equipe_evento1_idx` (`idevento` ASC) VISIBLE,
  CONSTRAINT `fk_equipe_evento1`
    FOREIGN KEY (`idevento`)
    REFERENCES `evento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `usuario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `ideventoativo` INT DEFAULT NULL,
  `usunome` VARCHAR(100) NOT NULL,
  `usuemail` VARCHAR(100) NOT NULL,
  `ususenha` VARCHAR(100) NOT NULL,
  `ativo` INT NOT NULL DEFAULT 1,
  `criado_em` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `atualizado_em` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_usuario_evento1_idx` (`ideventoativo` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_evento1`
    FOREIGN KEY (`ideventoativo`)
    REFERENCES `evento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `log`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `log` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `logtexto` TEXT DEFAULT NULL,
  `idusuario` INT DEFAULT NULL,
  `criado_em` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_log_usuario1_idx` (`idusuario` ASC) VISIBLE,
  CONSTRAINT `fk_log_usuario1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `questaotipo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `questaotipo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `qtdescricao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `questao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `questao` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idevento` INT NOT NULL,
  `idquestaotipo` INT NOT NULL,
  `queordem` INT NOT NULL,
  `quetempo` INT NOT NULL,
  `queponto` INT NOT NULL,
  `quetexto` TEXT DEFAULT NULL,
  `quediscursiva` TEXT DEFAULT NULL,
  `queimg` VARCHAR(100) DEFAULT NULL,
  `quedtliberacao` TIMESTAMP NULL DEFAULT NULL,
  `quedtlimite` TIMESTAMP NULL DEFAULT NULL,
  `quesituacao` INT NOT NULL DEFAULT 0 COMMENT '0 - não liberada\n1 - liberada',
  `criado_em` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `atualizado_em` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_questao_evento1_idx` (`idevento` ASC) VISIBLE,
  INDEX `fk_questao_questaotipo1_idx` (`idquestaotipo` ASC) VISIBLE,
  CONSTRAINT `fk_questao_evento1`
    FOREIGN KEY (`idevento`)
    REFERENCES `evento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_questao_questaotipo1`
    FOREIGN KEY (`idquestaotipo`)
    REFERENCES `questaotipo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `questaoresposta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `questaoresposta` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `qrordem` VARCHAR(10) NOT NULL,
  `qrtexto` TEXT DEFAULT NULL,
  `qrimg` VARCHAR(100) DEFAULT NULL,
  `qrcorreta` INT NOT NULL DEFAULT 0,
  `idquestao` INT NOT NULL,
  `criado_em` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `atualizado_em` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_questaoresposta_questao1_idx` (`idquestao` ASC) VISIBLE,
  CONSTRAINT `fk_questaoresposta_questao1`
    FOREIGN KEY (`idquestao`)
    REFERENCES `questao` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `equipe_questaoresposta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `equipe_questaoresposta` (
  `idequipe` INT NOT NULL,
  `idquestao` INT NOT NULL,
  `idquestaoresposta` INT DEFAULT NULL,
  `eqrtempo` INT NOT NULL,
  `eqrponto` INT NOT NULL,
  `eqrdiscursiva` TEXT DEFAULT NULL,
  `criado_em` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idequipe`, `idquestao`),
  INDEX `fk_equipe_questaoresposta_questaoresposta1_idx` (`idquestaoresposta` ASC) VISIBLE,
  INDEX `fk_equipe_questaoresposta_equipe1_idx` (`idequipe` ASC) VISIBLE,
  INDEX `fk_equipe_questaoresposta_questao1_idx` (`idquestao` ASC) VISIBLE,
  CONSTRAINT `fk_equipe_questaoresposta_equipe1`
    FOREIGN KEY (`idequipe`)
    REFERENCES `equipe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_equipe_questaoresposta_questaoresposta1`
    FOREIGN KEY (`idquestaoresposta`)
    REFERENCES `questaoresposta` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_equipe_questaoresposta_questao1`
    FOREIGN KEY (`idquestao`)
    REFERENCES `questao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Insert `questaotipo`
-- -----------------------------------------------------
INSERT INTO `questaotipo` (`id`, `qtdescricao`)
VALUES (1,'Objetiva'), (2,'Discursiva');



-- -----------------------------------------------------
-- Insert `evento`
-- -----------------------------------------------------
INSERT INTO `evento` (`id`, `evenome`, `evesituacao`, `criado_em`, `atualizado_em`)
VALUES
	(1,'Quiz Teste 01',0,'2023-09-15 12:15:39','2023-09-18 09:31:52'),
	(2,'Quiz Teste 02',0,'2023-09-18 10:00:24','2023-09-18 10:00:24');



-- -----------------------------------------------------
-- Insert `usuario`
-- -----------------------------------------------------
INSERT INTO `usuario` (`id`, `usunome`, `usuemail`, `ususenha`, `ativo`,
`ideventoativo`, `criado_em`, `atualizado_em`)
VALUES
	(1,'David Paolini Develly','dpdevelly@gmail.com','$2y$10$7PTc7/eNq3sz/s2jWljAUufd02jx2K/mlhKMDdOdXNXoRQJPAYLeS',1,1,'2023-09-15 11:16:23','2023-09-15 11:58:23'),
	(3,'Administrador','adm@adm.com.br','$2y$10$Y/UM2fVGxrr44HG646pU7uVBT6dL7JeSCi.xS2Obk9/s7YAbsdy..',1,NULL,'2023-09-20 11:25:52','2023-09-20 11:25:52');



-- SET SQL_MODE=@OLD_SQL_MODE;
-- SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
-- SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

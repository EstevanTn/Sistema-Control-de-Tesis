-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.1.13-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win32
-- HeidiSQL Versión:             9.3.0.4984
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Volcando estructura de base de datos para control_tesis
DROP DATABASE IF EXISTS `control_tesis`;
CREATE DATABASE IF NOT EXISTS `control_tesis` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;
USE `control_tesis`;


-- Volcando estructura para tabla control_tesis.acta
DROP TABLE IF EXISTS `acta`;
CREATE TABLE IF NOT EXISTS `acta` (
  `acta_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tram_id` bigint(20) NOT NULL,
  `eva_id` bigint(20) NOT NULL,
  `estado_tesis` enum('APROBADO','APROBADO POR MAYORIA','EVALUANDO','DESAPROVADO') COLLATE utf8_unicode_ci DEFAULT 'EVALUANDO',
  PRIMARY KEY (`acta_id`),
  UNIQUE KEY `uk_evaluacion_id` (`eva_id`),
  KEY `FK_acta_tramite` (`tram_id`),
  CONSTRAINT `FK_acta_evaluacion` FOREIGN KEY (`eva_id`) REFERENCES `evaluacion` (`eva_id`),
  CONSTRAINT `FK_acta_tramite` FOREIGN KEY (`tram_id`) REFERENCES `tramite` (`tram_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla control_tesis.acta: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `acta` DISABLE KEYS */;
/*!40000 ALTER TABLE `acta` ENABLE KEYS */;


-- Volcando estructura para tabla control_tesis.asesoria
DROP TABLE IF EXISTS `asesoria`;
CREATE TABLE IF NOT EXISTS `asesoria` (
  `asesoria_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tram_id` bigint(20) DEFAULT NULL COMMENT 'Numero de Tramite',
  `doc_codigo` char(10) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Codigo de docente',
  `estado_informe` enum('RECIBIDO','RECHAZADO','ACEPTADO') COLLATE utf8_unicode_ci DEFAULT 'RECIBIDO' COMMENT 'Estado de Informe ''RECIBIDO'',''RECHAZADO'',''ACEPTADO''',
  PRIMARY KEY (`asesoria_id`),
  KEY `fk_asesoria_docente_cod` (`doc_codigo`),
  KEY `fk_asesoria_esquema_id` (`tram_id`),
  CONSTRAINT `fk_asesoria_docente_cod` FOREIGN KEY (`doc_codigo`) REFERENCES `docente` (`doc_codigo`),
  CONSTRAINT `fk_asesoria_esquema_id` FOREIGN KEY (`tram_id`) REFERENCES `esquema` (`tram_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='AsignaciÃ³n de asesor';

-- Volcando datos para la tabla control_tesis.asesoria: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `asesoria` DISABLE KEYS */;
INSERT INTO `asesoria` (`asesoria_id`, `tram_id`, `doc_codigo`, `estado_informe`) VALUES
	(5, 1, '1212121221', 'RECIBIDO'),
	(6, 2, '1265454231', 'RECIBIDO');
/*!40000 ALTER TABLE `asesoria` ENABLE KEYS */;


-- Volcando estructura para tabla control_tesis.cargo
DROP TABLE IF EXISTS `cargo`;
CREATE TABLE IF NOT EXISTS `cargo` (
  `car_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `car_nombre` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Nombre de Cargo',
  `car_descripcion` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Descripcion de cargo',
  PRIMARY KEY (`car_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla control_tesis.cargo: ~5 rows (aproximadamente)
/*!40000 ALTER TABLE `cargo` DISABLE KEYS */;
INSERT INTO `cargo` (`car_id`, `car_nombre`, `car_descripcion`) VALUES
	(1, 'Presidente', 'Presidente Evaluador de la sustentacion.'),
	(2, 'Alcalde', 'Alcalde Evaluativo de la sustentacion.'),
	(3, 'Secretaria', 'Secretario Evaluativa de la sustentacion.'),
	(4, 'Vocal', 'Vocal Evaluativo de la sustentacion.'),
	(5, 'Auxiliar', 'Auxiliar de respaldo Evaluativo de la sustentacion.');
/*!40000 ALTER TABLE `cargo` ENABLE KEYS */;


-- Volcando estructura para tabla control_tesis.det_evaluacion
DROP TABLE IF EXISTS `det_evaluacion`;
CREATE TABLE IF NOT EXISTS `det_evaluacion` (
  `eva_id` bigint(20) DEFAULT NULL,
  `jur_id` bigint(20) DEFAULT NULL,
  `apruba` bit(1) DEFAULT NULL,
  KEY `fk_det_evaluacion_evaluacion_id` (`eva_id`),
  KEY `fk_det_evaluacion_jurado_id` (`jur_id`),
  CONSTRAINT `fk_det_evaluacion_evaluacion_id` FOREIGN KEY (`eva_id`) REFERENCES `evaluacion` (`eva_id`),
  CONSTRAINT `fk_det_evaluacion_jurado_id` FOREIGN KEY (`jur_id`) REFERENCES `jurado` (`jur_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla control_tesis.det_evaluacion: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `det_evaluacion` DISABLE KEYS */;
INSERT INTO `det_evaluacion` (`eva_id`, `jur_id`, `apruba`) VALUES
	(1, 3, b'1'),
	(1, 4, b'0'),
	(1, 5, b'1');
/*!40000 ALTER TABLE `det_evaluacion` ENABLE KEYS */;


-- Volcando estructura para tabla control_tesis.docente
DROP TABLE IF EXISTS `docente`;
CREATE TABLE IF NOT EXISTS `docente` (
  `doc_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `doc_codigo` char(10) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Codigo de Docente',
  `per_id` bigint(20) DEFAULT NULL,
  `doc_fecha_reg` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha actual del sistema',
  PRIMARY KEY (`doc_id`),
  UNIQUE KEY `uk_docente_codigo` (`doc_codigo`),
  KEY `fk_docente_persona_id` (`per_id`),
  CONSTRAINT `fk_docente_persona_id` FOREIGN KEY (`per_id`) REFERENCES `persona` (`per_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla control_tesis.docente: ~5 rows (aproximadamente)
/*!40000 ALTER TABLE `docente` DISABLE KEYS */;
INSERT INTO `docente` (`doc_id`, `doc_codigo`, `per_id`, `doc_fecha_reg`) VALUES
	(1, '1212345687', 2, '2016-09-29 01:43:47'),
	(2, '1254875121', 3, '2016-09-29 01:43:47'),
	(3, '1265454231', 4, '2016-09-29 01:43:47'),
	(4, '1212121221', 9, '2016-09-29 01:43:47'),
	(5, '1287545121', 10, '2016-09-29 01:43:47');
/*!40000 ALTER TABLE `docente` ENABLE KEYS */;


-- Volcando estructura para tabla control_tesis.esquema
DROP TABLE IF EXISTS `esquema`;
CREATE TABLE IF NOT EXISTS `esquema` (
  `tram_id` bigint(20) NOT NULL COMMENT 'Nro de Tramite de tesis',
  `titulo_tesis` varchar(300) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Titulo de la tesis',
  `keyswords` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Palabras clave',
  `obj_pri` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Objetivos principales de la tesis',
  `obj_sec` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Objetivos secundarios de la tesis',
  `resumen` text COLLATE utf8_unicode_ci COMMENT 'Resumen de Tesis',
  `esq_estado` enum('RECHAZADO','APROVADO','REVISANDO','PRESENTADO') COLLATE utf8_unicode_ci DEFAULT 'PRESENTADO' COMMENT 'Estado de Plan de tesis (rechazado|aprovado|revisando|presentado)',
  `esq_fecha` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha actual del sistema en que se registra el esquema',
  `usu_id` bigint(20) NOT NULL,
  PRIMARY KEY (`tram_id`),
  CONSTRAINT `fk_esquema_tramite_id` FOREIGN KEY (`tram_id`) REFERENCES `tramite` (`tram_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

-- Volcando datos para la tabla control_tesis.esquema: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `esquema` DISABLE KEYS */;
INSERT INTO `esquema` (`tram_id`, `titulo_tesis`, `keyswords`, `obj_pri`, `obj_sec`, `resumen`, `esq_estado`, `esq_fecha`, `usu_id`) VALUES
	(1, 'Relacion de la practica de valores sociales y la disciplina escolar de los estudiantes del 4° ciclo de educacion primaria del centro de desarrollo comunal de el porvenir.', 'Relacion, Disciplina, Eduacacion, Viabilidad', 'Fortalecer los Valores en los jovenes hoy en dia', 'Asignar valores en cada hogar, Mejorar la educacion Vial', 'Relacion de la practica de valores sociales y la disciplina escolar de los estudiantes del 4° ciclo de educacion primaria del centro de desarrollo comunal de el porvenir.', 'APROVADO', '2016-09-29 04:38:26', 3),
	(2, 'Programa tutorial para fortalecer las habilidades sociales en los estudiantes del 4°to Grado de educacion primaria de la I.E 81014 Pedro Mercedes Ureña "Centro Viejo" Trujillo 2012', 'Tutorial, Fortalecimiento, Abiabilidad', 'Fortalecer las habilidades de las personas', 'Ofrecer Charlas, Mejorar el rendimiento social', 'Programa tutorial para fortalecer las habilidades sociales en los estudiantes del 4°to Grado de educacion primaria de la I.E 81014 Pedro Mercedes Ureña "Centro Viejo" Trujillo 2012', 'PRESENTADO', '2016-09-29 04:38:26', 3);
/*!40000 ALTER TABLE `esquema` ENABLE KEYS */;


-- Volcando estructura para tabla control_tesis.estudiante
DROP TABLE IF EXISTS `estudiante`;
CREATE TABLE IF NOT EXISTS `estudiante` (
  `est_codigo` char(10) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Codigo de estudiante',
  `per_id` bigint(20) DEFAULT NULL,
  `est_estado` bit(1) DEFAULT b'1' COMMENT 'Si es estudiante o no. (0/1)',
  `fecha_reg` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`est_codigo`),
  KEY `fk_estudiante_persona` (`per_id`),
  CONSTRAINT `fk_estudiante_persona` FOREIGN KEY (`per_id`) REFERENCES `persona` (`per_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla control_tesis.estudiante: ~11 rows (aproximadamente)
/*!40000 ALTER TABLE `estudiante` DISABLE KEYS */;
INSERT INTO `estudiante` (`est_codigo`, `per_id`, `est_estado`, `fecha_reg`) VALUES
	('1111523148', 11, b'1', '2016-09-29 02:12:56'),
	('1111545484', 17, b'1', '2016-09-29 02:12:56'),
	('1111545874', 7, b'1', '2016-09-29 02:12:56'),
	('1111568427', 5, b'1', '2016-09-29 02:12:56'),
	('1111597532', 6, b'1', '2016-09-29 02:12:56'),
	('1112100975', 1, b'1', '2016-09-29 14:20:17'),
	('1112134515', 16, b'1', '2016-09-29 02:12:56'),
	('1113214567', 14, b'1', '2016-09-29 02:12:56'),
	('1113216548', 12, b'1', '2016-09-29 02:12:56'),
	('1113658245', 15, b'1', '2016-09-29 02:12:56'),
	('1119876541', 13, b'1', '2016-09-29 02:12:56');
/*!40000 ALTER TABLE `estudiante` ENABLE KEYS */;


-- Volcando estructura para tabla control_tesis.evaluacion
DROP TABLE IF EXISTS `evaluacion`;
CREATE TABLE IF NOT EXISTS `evaluacion` (
  `eva_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tram_id` bigint(20) DEFAULT NULL,
  `eva_fecha_erg` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `tipo_evaluacion` enum('B','A') COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Tipo de evaluacion (A - si es una evaluacion del plan de tesis, B- si es una evaluacion de la sustentacion)',
  `eva_estado` enum('RECHAZADO','EVALUANDO','EN ESPERA','APROBADO') COLLATE utf8_unicode_ci DEFAULT 'EN ESPERA' COMMENT 'Estado de la evaluacion ''RECHAZADO'',''APROBADO'',''EVALUANDO'', ''EN ESPERA''',
  `eva_descripcion` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`eva_id`),
  KEY `fk_evaluacion_tramite_id` (`tram_id`),
  CONSTRAINT `fk_evaluacion_tramite_id` FOREIGN KEY (`tram_id`) REFERENCES `esquema` (`tram_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla control_tesis.evaluacion: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `evaluacion` DISABLE KEYS */;
INSERT INTO `evaluacion` (`eva_id`, `tram_id`, `eva_fecha_erg`, `tipo_evaluacion`, `eva_estado`, `eva_descripcion`) VALUES
	(1, 1, '2016-09-29 21:20:46', 'A', 'EVALUANDO', NULL),
	(2, 2, '2016-09-29 21:21:26', 'A', 'EN ESPERA', NULL);
/*!40000 ALTER TABLE `evaluacion` ENABLE KEYS */;


-- Volcando estructura para tabla control_tesis.jurado
DROP TABLE IF EXISTS `jurado`;
CREATE TABLE IF NOT EXISTS `jurado` (
  `jur_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `doc_codigo` char(10) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Codigo de Docente',
  `tipo_jurado` enum('EVALUADOR','DICTAMINADOR') COLLATE utf8_unicode_ci DEFAULT NULL,
  `car_id` bigint(20) DEFAULT NULL COMMENT 'Cargo de Jurado',
  PRIMARY KEY (`jur_id`),
  KEY `fk_jurado_cargo_id` (`car_id`),
  KEY `fk_jurado_docente_cod` (`doc_codigo`),
  CONSTRAINT `fk_jurado_cargo_id` FOREIGN KEY (`car_id`) REFERENCES `cargo` (`car_id`),
  CONSTRAINT `fk_jurado_docente_cod` FOREIGN KEY (`doc_codigo`) REFERENCES `docente` (`doc_codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla control_tesis.jurado: ~5 rows (aproximadamente)
/*!40000 ALTER TABLE `jurado` DISABLE KEYS */;
INSERT INTO `jurado` (`jur_id`, `doc_codigo`, `tipo_jurado`, `car_id`) VALUES
	(1, '1212345687', 'EVALUADOR', 1),
	(2, '1254875121', 'EVALUADOR', 2),
	(3, '1265454231', 'DICTAMINADOR', 1),
	(4, '1212121221', 'DICTAMINADOR', 4),
	(5, '1287545121', 'DICTAMINADOR', 3);
/*!40000 ALTER TABLE `jurado` ENABLE KEYS */;


-- Volcando estructura para tabla control_tesis.observacion
DROP TABLE IF EXISTS `observacion`;
CREATE TABLE IF NOT EXISTS `observacion` (
  `obs_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `jur_id` bigint(20) DEFAULT NULL COMMENT 'Identificador de jurado',
  `eva_id` bigint(20) DEFAULT NULL,
  `obs_titulo` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Titulo de observacion',
  `obs_descripcion` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `obs_respuesta` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `obs_estado` enum('OK','RECIBIDO','REACER') COLLATE utf8_unicode_ci DEFAULT 'RECIBIDO' COMMENT 'Estado de la observacion ''OK'',''RECIBIDO'',''REACER''',
  PRIMARY KEY (`obs_id`),
  KEY `fk_observacion_jurado_id` (`jur_id`),
  KEY `fk_observacion_evaluacion_id` (`eva_id`),
  CONSTRAINT `fk_observacion_evaluacion_id` FOREIGN KEY (`eva_id`) REFERENCES `det_evaluacion` (`eva_id`),
  CONSTRAINT `fk_observacion_jurado_id` FOREIGN KEY (`jur_id`) REFERENCES `jurado` (`jur_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla control_tesis.observacion: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `observacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `observacion` ENABLE KEYS */;


-- Volcando estructura para procedimiento control_tesis.pa_insertar_tramite
DROP PROCEDURE IF EXISTS `pa_insertar_tramite`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_insertar_tramite`(in cod_est char(10), in cod_pag char(12))
BEGIN
INSERT INTO `tramite`(`est_codigo`, `pag_codigo`) VALUES (cod_est, cod_pag);
    END//
DELIMITER ;


-- Volcando estructura para procedimiento control_tesis.pa_insertar_usuario
DROP PROCEDURE IF EXISTS `pa_insertar_usuario`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_insertar_usuario`(in nom_usu varchar(16), in passw varchar(40), in estado char(1), in pers_id bigint(20), in tipo bigint(20))
BEGIN
     INSERT INTO `usuario`(`usu_login`, `usu_password`, `usu_estado`, `per_id`, `tipo_usu_id`) VALUES (nom_usu, sha1(passw), estado, pers_id, tipo);
    END//
DELIMITER ;


-- Volcando estructura para tabla control_tesis.persona
DROP TABLE IF EXISTS `persona`;
CREATE TABLE IF NOT EXISTS `persona` (
  `per_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `per_dni` char(8) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Documento de Identidad',
  `per_nombre` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Nombres',
  `per_ape_pat` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Apellido paterno',
  `per_ape_mat` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Apellido materno',
  `per_direccion` varchar(70) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Direccion',
  `per_telefono` char(12) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Telefono',
  `per_email` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Correo electronico',
  `per_fecha_nac` date NOT NULL,
  `per_fecha_reg` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha actual del sistema al registrar a la persona',
  PRIMARY KEY (`per_id`),
  UNIQUE KEY `uk_dni_persona` (`per_dni`),
  FULLTEXT KEY `uk_nombre_persona` (`per_nombre`,`per_ape_pat`,`per_ape_mat`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla control_tesis.persona: ~17 rows (aproximadamente)
/*!40000 ALTER TABLE `persona` DISABLE KEYS */;
INSERT INTO `persona` (`per_id`, `per_dni`, `per_nombre`, `per_ape_pat`, `per_ape_mat`, `per_direccion`, `per_telefono`, `per_email`, `per_fecha_nac`, `per_fecha_reg`) VALUES
	(1, '12345678', 'Estefany', 'Alvarado', 'Gamboa', 'A.v.Simon Bolivar', '474857', 'estefany@gmail.com', '1991-10-04', '2016-09-29 01:08:23'),
	(2, '45755486', 'Pedro', 'Baltazar', 'Torres', 'A.v.28 de Julio', '458457', 'Pedro@gmail.com', '1990-11-03', '2016-09-29 01:08:23'),
	(3, '45845212', 'Bryan', 'Castillo', 'Vaca', 'A.v.28 de Julio', '589568', 'Bryan@gmail.com', '1991-10-05', '2016-09-29 01:08:23'),
	(4, '25458457', 'Carlos', 'Torres', 'Flores', 'La esperanza', '845795', 'Carlos@gmail.com', '1991-10-03', '2016-09-29 01:08:23'),
	(5, '62354584', 'Raida', 'Alvarado', 'Torres', 'Las brisas', '356268', 'Raida@hotmail.com', '1990-03-10', '2016-09-29 01:08:23'),
	(6, '95685325', 'Nicol', 'Castillo', 'Gamboa', 'El trapecio', '326598', 'Nicol@hotmail.com', '1990-04-10', '2016-09-29 01:08:23'),
	(7, '95685212', 'Andy', 'Ramirez', 'Rimac', 'A.v. Argentina', '215487', 'Andy@hotmail.com', '1990-03-07', '2016-09-29 01:08:23'),
	(8, '54326598', 'Josselyn', 'Arismendis', 'Avila', 'A.v. Santa', '516554', 'Joss@hotmail.com', '1990-03-04', '2016-09-29 01:08:23'),
	(9, '75315985', 'Wilson', 'Rubio ', 'Zavaleta', 'A.v. Santa', '214875', 'Wi@hotmail.com', '1991-03-07', '2016-09-29 01:08:23'),
	(10, '25896314', 'Genesis', 'BarrioNuevo', 'Mendez', 'A.v. Campo Sol', '625891', 'Gene@hotmail.com', '1992-03-08', '2016-09-29 01:08:23'),
	(11, '32165459', 'Eddy', 'Olano', 'Leon', 'A.v.28 de Julio', '502600', 'Eddy@hotmail.com', '1991-02-11', '2016-09-29 02:07:45'),
	(12, '20215174', 'Maycol', 'Neyra ', 'Arcos', 'A.v.La union', '659865', 'May@gmail.com', '1994-12-24', '2016-09-29 02:08:53'),
	(13, '15975824', 'Milena', 'Zarate', 'Rojas', 'A.v.Santa', '155420', 'Mil@gmail.com', '1995-11-04', '2016-09-29 02:09:45'),
	(14, '32165484', 'Cristina', 'Bobadilla', 'Bernuy', 'A.v.Santa', '321544', 'Cris@hotmail.com', '1994-10-03', '2016-09-29 02:10:27'),
	(15, '32101201', 'Alfredo', 'Carrion', 'SaldaÃ±a', 'A.v.Santa', '159753', 'Alfr@gmail.com', '1995-11-02', '2016-09-29 02:11:07'),
	(16, '96312314', 'Mia', 'Carranza', 'OcaÃ±a', 'A.v.Santa', '741852', 'Mia@hotmail.com', '1995-07-03', '2016-09-29 02:11:53'),
	(17, '15975382', 'Valerie', 'Mondo?edo', 'Torres', 'A.v.Santa', '146352', 'Valer@gmail.com', '1995-08-05', '2016-09-29 02:12:40');
/*!40000 ALTER TABLE `persona` ENABLE KEYS */;


-- Volcando estructura para tabla control_tesis.programacion
DROP TABLE IF EXISTS `programacion`;
CREATE TABLE IF NOT EXISTS `programacion` (
  `prog_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `asesoria_id` bigint(20) DEFAULT NULL,
  `eva_id` bigint(20) DEFAULT NULL,
  `prog_fecha` date DEFAULT NULL,
  `prog_hora` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `prog_f_reg` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`prog_id`),
  KEY `fk_sustentacion_asesoria_id` (`asesoria_id`),
  KEY `fk_sustentacion_evaluacion_id` (`eva_id`),
  CONSTRAINT `fk_sustentacion_asesoria_id` FOREIGN KEY (`asesoria_id`) REFERENCES `asesoria` (`asesoria_id`),
  CONSTRAINT `fk_sustentacion_evaluacion_id` FOREIGN KEY (`eva_id`) REFERENCES `evaluacion` (`eva_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla control_tesis.programacion: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `programacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `programacion` ENABLE KEYS */;


-- Volcando estructura para tabla control_tesis.seguimiento
DROP TABLE IF EXISTS `seguimiento`;
CREATE TABLE IF NOT EXISTS `seguimiento` (
  `tram_id` bigint(20) NOT NULL,
  `seg_fecha` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha y hora del sistema',
  `seg_descripcion` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Descripcion de Seguimiento',
  `seg_origen` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Origen proceso ',
  `seg_destino` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Destinpo de proceso',
  `seg_estado` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'El estado en el que se encuentra el proceso',
  PRIMARY KEY (`tram_id`),
  CONSTRAINT `fk_seguimiento_tramite` FOREIGN KEY (`tram_id`) REFERENCES `tramite` (`tram_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla control_tesis.seguimiento: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `seguimiento` DISABLE KEYS */;
INSERT INTO `seguimiento` (`tram_id`, `seg_fecha`, `seg_descripcion`, `seg_origen`, `seg_destino`, `seg_estado`) VALUES
	(1, '2016-09-29 20:37:34', 'Se ha iniciado el tramite para presentacion de tÃ©sis.', 'Eddy Olano Leon', 'DirecciÃ³n de Escuela.', 'EN PROCESO'),
	(2, '2016-09-29 21:10:32', 'Se ha iniciado el tramite para presentacion de tÃ©sis.', 'Alfredo Carrion SaldaÃ±a', 'DirecciÃ³n de Escuela.', 'EN PROCESO'),
	(3, '2016-09-29 21:34:44', 'Se ha iniciado el tramite para presentacion de tesis.', 'Estefany Alvarado Gamboa', 'Dirección de Escuela.', 'EN PROCESO');
/*!40000 ALTER TABLE `seguimiento` ENABLE KEYS */;


-- Volcando estructura para tabla control_tesis.tipo_usuario
DROP TABLE IF EXISTS `tipo_usuario`;
CREATE TABLE IF NOT EXISTS `tipo_usuario` (
  `tipo_usu_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tipo_usu_nombre` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tipo_usu_descripcion` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`tipo_usu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla control_tesis.tipo_usuario: ~6 rows (aproximadamente)
/*!40000 ALTER TABLE `tipo_usuario` DISABLE KEYS */;
INSERT INTO `tipo_usuario` (`tipo_usu_id`, `tipo_usu_nombre`, `tipo_usu_descripcion`) VALUES
	(1, 'Administrador', 'Acceso Completo al Sistema.'),
	(2, 'Secretaria', 'Acceso Parcial al Sistema.'),
	(3, 'Docente', 'Acceso Controlado al Sistema.'),
	(4, 'Estudiante', 'Acceso al control de su desarrollo de la Tesis.'),
	(5, 'Jurado Dictaminador', 'Acceso a la evaluacion del Pla de Tesis.'),
	(6, 'Jurado Evaluador', 'Acceso a la evaluacion de la sustentacion de la Tesis.');
/*!40000 ALTER TABLE `tipo_usuario` ENABLE KEYS */;


-- Volcando estructura para tabla control_tesis.tramite
DROP TABLE IF EXISTS `tramite`;
CREATE TABLE IF NOT EXISTS `tramite` (
  `tram_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `est_codigo` char(10) COLLATE utf8_unicode_ci NOT NULL,
  `pag_codigo` char(10) COLLATE utf8_unicode_ci NOT NULL,
  `tram_fecha_reg` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`tram_id`),
  UNIQUE KEY `uk_pago_tramite` (`pag_codigo`),
  KEY `FK_tramite_estudiante` (`est_codigo`),
  CONSTRAINT `FK_tramite_estudiante` FOREIGN KEY (`est_codigo`) REFERENCES `estudiante` (`est_codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Es la solicitud que hace para inscribir su esquema de tesis';

-- Volcando datos para la tabla control_tesis.tramite: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `tramite` DISABLE KEYS */;
INSERT INTO `tramite` (`tram_id`, `est_codigo`, `pag_codigo`, `tram_fecha_reg`) VALUES
	(1, '1111523148', 'PAG5014001', '2016-09-29 20:37:33'),
	(2, '1113658245', 'PAG1545847', '2016-09-29 21:10:31'),
	(3, '1112100975', 'PAG1523847', '2016-09-29 21:34:44');
/*!40000 ALTER TABLE `tramite` ENABLE KEYS */;


-- Volcando estructura para tabla control_tesis.usuario
DROP TABLE IF EXISTS `usuario`;
CREATE TABLE IF NOT EXISTS `usuario` (
  `usu_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `usu_login` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Nombre de usuario',
  `usu_password` varchar(41) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'ContraseÃ±a de usuario',
  `usu_estado` enum('B','D','A') COLLATE utf8_unicode_ci DEFAULT 'A' COMMENT 'Estado de Usuario(Activo| Desactivado | Bloqueado)',
  `per_id` bigint(20) NOT NULL,
  `tipo_usu_id` bigint(20) NOT NULL COMMENT 'Identificador Tipo Usuario',
  PRIMARY KEY (`usu_id`),
  KEY `fk_usuario_tipusuario` (`tipo_usu_id`),
  KEY `fk_usuario_persona` (`per_id`),
  CONSTRAINT `fk_usuario_persona` FOREIGN KEY (`per_id`) REFERENCES `persona` (`per_id`),
  CONSTRAINT `fk_usuario_tipusuario` FOREIGN KEY (`tipo_usu_id`) REFERENCES `tipo_usuario` (`tipo_usu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Se validara el ingreso al sistema';

-- Volcando datos para la tabla control_tesis.usuario: ~16 rows (aproximadamente)
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` (`usu_id`, `usu_login`, `usu_password`, `usu_estado`, `per_id`, `tipo_usu_id`) VALUES
	(1, '1112100975', '8efa180793a3a5a4ed0643c4856c5e2c2e2b99f9', 'A', 1, 4),
	(2, '1111523148', 'dad15d19fdaeb3cced64d4307dece481d0e97174', 'A', 11, 4),
	(3, '1111545484', '6bb4ae2db942bd6d54d085421e6881e36bd291d3', 'A', 17, 4),
	(4, '1111545874', '1207c3076e648f1ccffade40f965e94b5470d1fb', 'A', 7, 4),
	(5, '1111568427', '01fde134565035fc47965f89290c3a88eba42040', 'A', 5, 4),
	(6, '1111597532', '979d0a413ef128e35f6724ace69fab2f2e2e177f', 'A', 6, 4),
	(7, '1112134515', '12aeae32bc9ed64b1ceb7aada751ec0e39255166', 'A', 16, 4),
	(8, '1113214567', '5565138501c0df9e152d4dba2b068778f6d4d6fa', 'A', 14, 4),
	(9, '1113216548', '1846db42101be21728622eb5cf89c5168eab7318', 'A', 12, 4),
	(10, '1113658245', '025f0c7fdf90b69a49a961590e90a81cffd7cf2c', 'A', 15, 4),
	(11, '1119876541', 'f9ec8a7cd121f5a59a4ade1a4d03010ac7e1995a', 'A', 13, 4),
	(12, '1212345687', '0e7a31983adc04b4a2133deea69caff6f82c998f', 'A', 2, 3),
	(13, '1254875121', '36cf573aedf6b5ab67ac2c7737c53e654321837a', 'A', 3, 3),
	(14, '1265454231', 'c6f50e1b9ba2e1e090840ecc842732c144254238', 'A', 4, 3),
	(15, '1212121221', 'c8039299ecd90efa4a14e185cd93646bef511bbd', 'A', 9, 3),
	(16, '1287545121', '105cef3bf96587ac008042d93ef24a0921db784d', 'A', 10, 3);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;


-- Volcando estructura para vista control_tesis.view_docente
DROP VIEW IF EXISTS `view_docente`;
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `view_docente` (
	`doc_id` BIGINT(20) NOT NULL,
	`doc_fecha_reg` TIMESTAMP NULL COMMENT 'Fecha actual del sistema',
	`doc_codigo` CHAR(10) NOT NULL COMMENT 'Codigo de Docente' COLLATE 'utf8_unicode_ci',
	`per_id` BIGINT(20) NOT NULL,
	`per_dni` CHAR(8) NOT NULL COMMENT 'Documento de Identidad' COLLATE 'utf8_unicode_ci',
	`per_nombre` VARCHAR(50) NOT NULL COMMENT 'Nombres' COLLATE 'utf8_unicode_ci',
	`per_ape_pat` VARCHAR(50) NOT NULL COMMENT 'Apellido paterno' COLLATE 'utf8_unicode_ci',
	`per_ape_mat` VARCHAR(50) NOT NULL COMMENT 'Apellido materno' COLLATE 'utf8_unicode_ci',
	`per_direccion` VARCHAR(70) NULL COMMENT 'Direccion' COLLATE 'utf8_unicode_ci',
	`per_telefono` CHAR(12) NULL COMMENT 'Telefono' COLLATE 'utf8_unicode_ci',
	`per_email` VARCHAR(50) NULL COMMENT 'Correo electronico' COLLATE 'utf8_unicode_ci',
	`per_fecha_nac` DATE NOT NULL,
	`per_fecha_reg` TIMESTAMP NULL COMMENT 'Fecha actual del sistema al registrar a la persona'
) ENGINE=MyISAM;


-- Volcando estructura para vista control_tesis.view_estudiante
DROP VIEW IF EXISTS `view_estudiante`;
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `view_estudiante` (
	`est_codigo` CHAR(10) NOT NULL COMMENT 'Codigo de estudiante' COLLATE 'utf8_unicode_ci',
	`est_estado` BIT(1) NULL COMMENT 'Si es estudiante o no. (0/1)',
	`est_fecha_reg` TIMESTAMP NOT NULL,
	`per_id` BIGINT(20) NOT NULL,
	`per_dni` CHAR(8) NOT NULL COMMENT 'Documento de Identidad' COLLATE 'utf8_unicode_ci',
	`per_nombre` VARCHAR(50) NOT NULL COMMENT 'Nombres' COLLATE 'utf8_unicode_ci',
	`per_ape_pat` VARCHAR(50) NOT NULL COMMENT 'Apellido paterno' COLLATE 'utf8_unicode_ci',
	`per_ape_mat` VARCHAR(50) NOT NULL COMMENT 'Apellido materno' COLLATE 'utf8_unicode_ci',
	`per_direccion` VARCHAR(70) NULL COMMENT 'Direccion' COLLATE 'utf8_unicode_ci',
	`per_telefono` CHAR(12) NULL COMMENT 'Telefono' COLLATE 'utf8_unicode_ci',
	`per_email` VARCHAR(50) NULL COMMENT 'Correo electronico' COLLATE 'utf8_unicode_ci',
	`per_fecha_nac` DATE NOT NULL,
	`per_fecha_reg` TIMESTAMP NULL COMMENT 'Fecha actual del sistema al registrar a la persona'
) ENGINE=MyISAM;


-- Volcando estructura para vista control_tesis.view_jurado
DROP VIEW IF EXISTS `view_jurado`;
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `view_jurado` (
	`jur_id` BIGINT(20) NOT NULL,
	`tipo_jurado` ENUM('EVALUADOR','DICTAMINADOR') NULL COLLATE 'utf8_unicode_ci',
	`car_nombre` VARCHAR(50) NULL COMMENT 'Nombre de Cargo' COLLATE 'utf8_unicode_ci',
	`car_descripcion` VARCHAR(255) NULL COMMENT 'Descripcion de cargo' COLLATE 'utf8_unicode_ci',
	`doc_codigo` CHAR(10) NULL COMMENT 'Codigo de Docente' COLLATE 'utf8_unicode_ci',
	`per_id` BIGINT(20) NOT NULL,
	`per_dni` CHAR(8) NOT NULL COMMENT 'Documento de Identidad' COLLATE 'utf8_unicode_ci',
	`per_nombre` VARCHAR(50) NOT NULL COMMENT 'Nombres' COLLATE 'utf8_unicode_ci',
	`per_ape_pat` VARCHAR(50) NOT NULL COMMENT 'Apellido paterno' COLLATE 'utf8_unicode_ci',
	`per_ape_mat` VARCHAR(50) NOT NULL COMMENT 'Apellido materno' COLLATE 'utf8_unicode_ci',
	`per_direccion` VARCHAR(70) NULL COMMENT 'Direccion' COLLATE 'utf8_unicode_ci',
	`per_telefono` CHAR(12) NULL COMMENT 'Telefono' COLLATE 'utf8_unicode_ci',
	`per_email` VARCHAR(50) NULL COMMENT 'Correo electronico' COLLATE 'utf8_unicode_ci',
	`per_fecha_nac` DATE NOT NULL,
	`per_fecha_reg` TIMESTAMP NULL COMMENT 'Fecha actual del sistema al registrar a la persona'
) ENGINE=MyISAM;


-- Volcando estructura para disparador control_tesis.tgr_seguimiento_tramite
DROP TRIGGER IF EXISTS `tgr_seguimiento_tramite`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `tgr_seguimiento_tramite` AFTER INSERT ON `tramite` FOR EACH ROW BEGIN
DECLARE nombre_est varchar(100);
set nombre_est = (SELECT CONCAT(per_nombre,' ', per_ape_pat, ' ',per_ape_mat) FROM view_estudiante WHERE view_estudiante.est_codigo=NEW.est_codigo);
INSERT INTO `seguimiento`(`tram_id`, `seg_fecha`, `seg_descripcion`, `seg_origen`, `seg_destino`, `seg_estado`) VALUES (NEW.tram_id, CURRENT_TIMESTAMP, 'Se ha iniciado el tramite para presentacion de tesis.', nombre_est,'Dirección de Escuela.', 'EN PROCESO');
    END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;


-- Volcando estructura para disparador control_tesis.tgr_usuario_docente
DROP TRIGGER IF EXISTS `tgr_usuario_docente`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `tgr_usuario_docente` AFTER INSERT ON `docente` FOR EACH ROW BEGIN
 call pa_insertar_usuario(NEW.doc_codigo, NEW.doc_codigo, 'A', NEW.per_id, 3) ;
    END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;


-- Volcando estructura para disparador control_tesis.tgr_usuario_estudiante
DROP TRIGGER IF EXISTS `tgr_usuario_estudiante`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `tgr_usuario_estudiante` AFTER INSERT ON `estudiante` FOR EACH ROW call pa_insertar_usuario(NEW.est_codigo, NEW.est_codigo, 'A', NEW.per_id, 4)//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;


-- Volcando estructura para vista control_tesis.view_docente
DROP VIEW IF EXISTS `view_docente`;
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `view_docente`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` VIEW `view_docente` AS (select `docente`.`doc_id` AS `doc_id`,`docente`.`doc_fecha_reg` AS `doc_fecha_reg`,`docente`.`doc_codigo` AS `doc_codigo`,`persona`.`per_id` AS `per_id`,`persona`.`per_dni` AS `per_dni`,`persona`.`per_nombre` AS `per_nombre`,`persona`.`per_ape_pat` AS `per_ape_pat`,`persona`.`per_ape_mat` AS `per_ape_mat`,`persona`.`per_direccion` AS `per_direccion`,`persona`.`per_telefono` AS `per_telefono`,`persona`.`per_email` AS `per_email`,`persona`.`per_fecha_nac` AS `per_fecha_nac`,`persona`.`per_fecha_reg` AS `per_fecha_reg` from (`docente` join `persona` on((`docente`.`per_id` = `persona`.`per_id`)))) ;


-- Volcando estructura para vista control_tesis.view_estudiante
DROP VIEW IF EXISTS `view_estudiante`;
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `view_estudiante`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` VIEW `view_estudiante` AS (select `estudiante`.`est_codigo` AS `est_codigo`,`estudiante`.`est_estado` AS `est_estado`,`estudiante`.`fecha_reg` AS `est_fecha_reg`,`persona`.`per_id` AS `per_id`,`persona`.`per_dni` AS `per_dni`,`persona`.`per_nombre` AS `per_nombre`,`persona`.`per_ape_pat` AS `per_ape_pat`,`persona`.`per_ape_mat` AS `per_ape_mat`,`persona`.`per_direccion` AS `per_direccion`,`persona`.`per_telefono` AS `per_telefono`,`persona`.`per_email` AS `per_email`,`persona`.`per_fecha_nac` AS `per_fecha_nac`,`persona`.`per_fecha_reg` AS `per_fecha_reg` from (`persona` join `estudiante` on((`persona`.`per_id` = `estudiante`.`per_id`)))) ;


-- Volcando estructura para vista control_tesis.view_jurado
DROP VIEW IF EXISTS `view_jurado`;
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `view_jurado`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` VIEW `view_jurado` AS (select `jurado`.`jur_id` AS `jur_id`,`jurado`.`tipo_jurado` AS `tipo_jurado`,`cargo`.`car_nombre` AS `car_nombre`,`cargo`.`car_descripcion` AS `car_descripcion`,`jurado`.`doc_codigo` AS `doc_codigo`,`persona`.`per_id` AS `per_id`,`persona`.`per_dni` AS `per_dni`,`persona`.`per_nombre` AS `per_nombre`,`persona`.`per_ape_pat` AS `per_ape_pat`,`persona`.`per_ape_mat` AS `per_ape_mat`,`persona`.`per_direccion` AS `per_direccion`,`persona`.`per_telefono` AS `per_telefono`,`persona`.`per_email` AS `per_email`,`persona`.`per_fecha_nac` AS `per_fecha_nac`,`persona`.`per_fecha_reg` AS `per_fecha_reg` from (((`persona` join `docente` on((`persona`.`per_id` = `docente`.`per_id`))) join `jurado` on((`jurado`.`doc_codigo` = `docente`.`doc_codigo`))) join `cargo` on((`cargo`.`car_id` = `jurado`.`car_id`)))) ;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

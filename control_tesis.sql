-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Oct 27, 2016 at 10:08 PM
-- Server version: 10.1.13-MariaDB
-- PHP Version: 5.5.37

SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `control_tesis`
--
CREATE DATABASE IF NOT EXISTS `control_tesis` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE `control_tesis`;

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `pa_insertar_tramite`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_insertar_tramite` (IN `cod_est` CHAR(10), IN `cod_pag` CHAR(12))  BEGIN
INSERT INTO `tramite`(`est_codigo`, `pag_codigo`) VALUES (cod_est, cod_pag);
    END$$

DROP PROCEDURE IF EXISTS `pa_insertar_usuario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_insertar_usuario` (IN `nom_usu` VARCHAR(16), IN `passw` VARCHAR(40), IN `estado` CHAR(1), IN `pers_id` BIGINT(20), IN `tipo` BIGINT(20))  BEGIN
     INSERT INTO `usuario`(`usu_login`, `usu_password`, `usu_estado`, `per_id`, `tipo_usu_id`) VALUES (nom_usu, sha1(passw), estado, pers_id, tipo);
    END$$

--
-- Functions
--
DROP FUNCTION IF EXISTS `func_rank`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `func_rank` () RETURNS INT(11) NO SQL
begin
	  SET @var := IFNULL(@var,0) + 1;
      return @var;
     end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `acta`
--

DROP TABLE IF EXISTS `acta`;
CREATE TABLE `acta` (
  `acta_id` bigint(20) NOT NULL,
  `tram_id` bigint(20) NOT NULL,
  `eva_id` bigint(20) NOT NULL,
  `estado_tesis` enum('APROBADO','APROBADO POR MAYORIA','EVALUANDO','DESAPROVADO') COLLATE utf8_unicode_ci DEFAULT 'EVALUANDO'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `asesoria`
--

DROP TABLE IF EXISTS `asesoria`;
CREATE TABLE `asesoria` (
  `asesoria_id` bigint(20) NOT NULL,
  `tram_id` bigint(20) DEFAULT NULL COMMENT 'Numero de Tramite',
  `doc_codigo` char(10) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Codigo de docente',
  `estado_informe` enum('RECIBIDO','RECHAZADO','ACEPTADO') COLLATE utf8_unicode_ci DEFAULT 'RECIBIDO' COMMENT 'Estado de Informe ''RECIBIDO'',''RECHAZADO'',''ACEPTADO'''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='AsignaciÃ³n de asesor';

--
-- Dumping data for table `asesoria`
--

INSERT INTO `asesoria` (`asesoria_id`, `tram_id`, `doc_codigo`, `estado_informe`) VALUES
(5, 1, '1212121221', 'RECIBIDO'),
(6, 2, '1265454231', 'RECIBIDO');

-- --------------------------------------------------------

--
-- Table structure for table `cargo`
--

DROP TABLE IF EXISTS `cargo`;
CREATE TABLE `cargo` (
  `car_id` bigint(20) NOT NULL,
  `car_nombre` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Nombre de Cargo',
  `car_descripcion` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Descripcion de cargo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `cargo`
--

INSERT INTO `cargo` (`car_id`, `car_nombre`, `car_descripcion`) VALUES
(1, 'Presidente', 'Presidente Evaluador de la sustentacion.'),
(2, 'Alcalde', 'Alcalde Evaluativo de la sustentacion.'),
(3, 'Secretaria', 'Secretario Evaluativa de la sustentacion.'),
(4, 'Vocal', 'Vocal Evaluativo de la sustentacion.'),
(5, 'Auxiliar', 'Auxiliar de respaldo Evaluativo de la sustentacion.');

-- --------------------------------------------------------

--
-- Table structure for table `det_evaluacion`
--

DROP TABLE IF EXISTS `det_evaluacion`;
CREATE TABLE `det_evaluacion` (
  `eva_id` bigint(20) DEFAULT NULL,
  `jur_id` bigint(20) DEFAULT NULL,
  `apruba` bit(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `det_evaluacion`
--

INSERT INTO `det_evaluacion` (`eva_id`, `jur_id`, `apruba`) VALUES
(1, 3, b'1'),
(1, 4, b'0'),
(1, 5, b'1');

-- --------------------------------------------------------

--
-- Table structure for table `docente`
--

DROP TABLE IF EXISTS `docente`;
CREATE TABLE `docente` (
  `doc_id` bigint(20) NOT NULL,
  `doc_codigo` char(10) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Codigo de Docente',
  `per_id` bigint(20) DEFAULT NULL,
  `doc_fecha_reg` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha actual del sistema'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `docente`
--

INSERT INTO `docente` (`doc_id`, `doc_codigo`, `per_id`, `doc_fecha_reg`) VALUES
(1, '1212345687', 2, '2016-09-29 06:43:47'),
(2, '1254875121', 3, '2016-09-29 06:43:47'),
(3, '1265454231', 4, '2016-09-29 06:43:47'),
(4, '1212121221', 9, '2016-09-29 06:43:47'),
(5, '1287545121', 10, '2016-09-29 06:43:47');

--
-- Triggers `docente`
--
DROP TRIGGER IF EXISTS `tgr_usuario_docente`;
DELIMITER $$
CREATE TRIGGER `tgr_usuario_docente` AFTER INSERT ON `docente` FOR EACH ROW BEGIN
 call pa_insertar_usuario(NEW.doc_codigo, NEW.doc_codigo, 'A', NEW.per_id, 3) ;
    END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `esquema`
--

DROP TABLE IF EXISTS `esquema`;
CREATE TABLE `esquema` (
  `tram_id` bigint(20) NOT NULL COMMENT 'Nro de Tramite de tesis',
  `titulo_tesis` varchar(300) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Titulo de la tesis',
  `keyswords` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Palabras clave',
  `obj_pri` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Objetivos principales de la tesis',
  `obj_sec` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Objetivos secundarios de la tesis',
  `resumen` text COLLATE utf8_unicode_ci COMMENT 'Resumen de Tesis',
  `esq_estado` enum('RECHAZADO','APROBADO','REVISANDO','PRESENTADO') COLLATE utf8_unicode_ci DEFAULT 'PRESENTADO' COMMENT 'Estado de Plan de tesis (rechazado|aprovado|revisando|presentado)',
  `esq_fecha` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha actual del sistema en que se registra el esquema',
  `usu_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `esquema`
--

INSERT INTO `esquema` (`tram_id`, `titulo_tesis`, `keyswords`, `obj_pri`, `obj_sec`, `resumen`, `esq_estado`, `esq_fecha`, `usu_id`) VALUES
(1, 'Relacion de la practica de valores sociales y la disciplina escolar de los estudiantes del 4° ciclo de educacion primaria del centro de desarrollo comunal de el porvenir.', 'Relacion, Disciplina, Eduacacion, Viabilidad', 'Fortalecer los Valores en los jovenes hoy en dia', 'Asignar valores en cada hogar, Mejorar la educacion Vial', 'Relacion de la practica de valores sociales y la disciplina escolar de los estudiantes del 4° ciclo de educacion primaria del centro de desarrollo comunal de el porvenir.', 'APROBADO', '2016-09-29 09:38:26', 3),
(2, 'Programa tutorial para fortalecer las habilidades sociales en los estudiantes del 4°to Grado de educacion primaria de la I.E 81014 Pedro Mercedes Ureña "Centro Viejo" Trujillo 2012', 'Tutorial, Fortalecimiento, Abiabilidad', 'Fortalecer las habilidades de las personas', 'Ofrecer Charlas, Mejorar el rendimiento social', 'Programa tutorial para fortalecer las habilidades sociales en los estudiantes del 4°to Grado de educacion primaria de la I.E 81014 Pedro Mercedes Ureña "Centro Viejo" Trujillo 2012', 'PRESENTADO', '2016-09-29 09:38:26', 3);

-- --------------------------------------------------------

--
-- Table structure for table `estudiante`
--

DROP TABLE IF EXISTS `estudiante`;
CREATE TABLE `estudiante` (
  `est_codigo` char(10) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Codigo de estudiante',
  `per_id` bigint(20) DEFAULT NULL,
  `est_estado` bit(1) DEFAULT b'1' COMMENT 'Si es estudiante o no. (0/1)',
  `fecha_reg` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `estudiante`
--

INSERT INTO `estudiante` (`est_codigo`, `per_id`, `est_estado`, `fecha_reg`) VALUES
('1111523148', 11, b'1', '2016-09-29 07:12:56'),
('1111545484', 17, b'1', '2016-09-29 07:12:56'),
('1111545874', 7, b'1', '2016-09-29 07:12:56'),
('1111568427', 5, b'1', '2016-09-29 07:12:56'),
('1111597532', 6, b'1', '2016-09-29 07:12:56'),
('1112100975', 1, b'1', '2016-09-29 19:20:17'),
('1112134515', 16, b'1', '2016-09-29 07:12:56'),
('1113214567', 14, b'1', '2016-09-29 07:12:56'),
('1113216548', 12, b'1', '2016-09-29 07:12:56'),
('1113658245', 15, b'1', '2016-09-29 07:12:56'),
('1119876541', 13, b'1', '2016-09-29 07:12:56');

--
-- Triggers `estudiante`
--
DROP TRIGGER IF EXISTS `tgr_usuario_estudiante`;
DELIMITER $$
CREATE TRIGGER `tgr_usuario_estudiante` AFTER INSERT ON `estudiante` FOR EACH ROW call pa_insertar_usuario(NEW.est_codigo, NEW.est_codigo, 'A', NEW.per_id, 4)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `evaluacion`
--

DROP TABLE IF EXISTS `evaluacion`;
CREATE TABLE `evaluacion` (
  `eva_id` bigint(20) NOT NULL,
  `tram_id` bigint(20) DEFAULT NULL,
  `eva_fecha_erg` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `tipo_evaluacion` enum('B','A') COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Tipo de evaluacion (A - si es una evaluacion del plan de tesis, B- si es una evaluacion de la sustentacion)',
  `eva_estado` enum('RECHAZADO','EVALUANDO','EN ESPERA','APROBADO') COLLATE utf8_unicode_ci DEFAULT 'EN ESPERA' COMMENT 'Estado de la evaluacion ''RECHAZADO'',''APROBADO'',''EVALUANDO'', ''EN ESPERA''',
  `eva_descripcion` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `evaluacion`
--

INSERT INTO `evaluacion` (`eva_id`, `tram_id`, `eva_fecha_erg`, `tipo_evaluacion`, `eva_estado`, `eva_descripcion`) VALUES
(1, 1, '2016-09-30 02:20:46', 'A', 'EVALUANDO', NULL),
(2, 2, '2016-09-30 02:21:26', 'A', 'EN ESPERA', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `jurado`
--

DROP TABLE IF EXISTS `jurado`;
CREATE TABLE `jurado` (
  `jur_id` bigint(20) NOT NULL,
  `doc_codigo` char(10) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Codigo de Docente',
  `tipo_jurado` enum('EVALUADOR','DICTAMINADOR') COLLATE utf8_unicode_ci DEFAULT NULL,
  `car_id` bigint(20) DEFAULT NULL COMMENT 'Cargo de Jurado'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `jurado`
--

INSERT INTO `jurado` (`jur_id`, `doc_codigo`, `tipo_jurado`, `car_id`) VALUES
(1, '1212345687', 'EVALUADOR', 1),
(2, '1254875121', 'EVALUADOR', 2),
(3, '1265454231', 'DICTAMINADOR', 1),
(4, '1212121221', 'DICTAMINADOR', 4),
(5, '1287545121', 'DICTAMINADOR', 3);

-- --------------------------------------------------------

--
-- Table structure for table `observacion`
--

DROP TABLE IF EXISTS `observacion`;
CREATE TABLE `observacion` (
  `obs_id` bigint(20) NOT NULL,
  `jur_id` bigint(20) DEFAULT NULL COMMENT 'Identificador de jurado',
  `eva_id` bigint(20) DEFAULT NULL,
  `obs_titulo` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Titulo de observacion',
  `obs_descripcion` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `obs_respuesta` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `obs_estado` enum('OK','RECIBIDO','REACER') COLLATE utf8_unicode_ci DEFAULT 'RECIBIDO' COMMENT 'Estado de la observacion ''OK'',''RECIBIDO'',''REACER'''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pagina`
--

DROP TABLE IF EXISTS `pagina`;
CREATE TABLE `pagina` (
  `pag_id` bigint(20) NOT NULL,
  `pag_nombre` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `pag_icono` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `pag_url` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `pag_padre` int(11) DEFAULT NULL,
  `pag_cantidad` int(11) NOT NULL DEFAULT '0',
  `pag_estado` tinyint(1) NOT NULL,
  `tipo_usu_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `pagina`
--

INSERT INTO `pagina` (`pag_id`, `pag_nombre`, `pag_icono`, `pag_url`, `pag_padre`, `pag_cantidad`, `pag_estado`, `tipo_usu_id`) VALUES
(1, 'ESQUEMAS', 'icon-bar-chart', 'esquema', NULL, 0, 1, 1),
(2, 'ASESOR', 'icon-user', 'asesor', NULL, 0, 1, 1),
(3, 'JURADO', 'icon-legal', 'jurado', NULL, 0, 1, 1),
(4, 'TESIS', 'icon-book', 'tesis', NULL, 0, 1, 1),
(5, 'PROGRAMACIÓN', 'icon-calendar', 'programacion', NULL, 0, 1, 1),
(6, 'USUARIO', 'icon-group', 'usuario', NULL, 0, 1, 1),
(7, 'NUEVO ESQUEMA', 'icon-plus', 'esquema/nuevo', 1, 0, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `persona`
--

DROP TABLE IF EXISTS `persona`;
CREATE TABLE `persona` (
  `per_id` bigint(20) NOT NULL,
  `per_dni` char(8) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Documento de Identidad',
  `per_nombre` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Nombres',
  `per_ape_pat` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Apellido paterno',
  `per_ape_mat` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Apellido materno',
  `per_direccion` varchar(70) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Direccion',
  `per_telefono` char(12) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Telefono',
  `per_email` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Correo electronico',
  `per_fecha_nac` date NOT NULL,
  `per_fecha_reg` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha actual del sistema al registrar a la persona'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `persona`
--

INSERT INTO `persona` (`per_id`, `per_dni`, `per_nombre`, `per_ape_pat`, `per_ape_mat`, `per_direccion`, `per_telefono`, `per_email`, `per_fecha_nac`, `per_fecha_reg`) VALUES
(1, '12345678', 'Estefany', 'Alvarado', 'Gamboa', 'A.v.Simon Bolivar', '474857', 'estefany@gmail.com', '1991-10-04', '2016-09-29 06:08:23'),
(2, '45755486', 'Pedro', 'Baltazar', 'Torres', 'A.v.28 de Julio', '458457', 'Pedro@gmail.com', '1990-11-03', '2016-09-29 06:08:23'),
(3, '45845212', 'Bryan', 'Castillo', 'Vaca', 'A.v.28 de Julio', '589568', 'Bryan@gmail.com', '1991-10-05', '2016-09-29 06:08:23'),
(4, '25458457', 'Carlos', 'Torres', 'Flores', 'La esperanza', '845795', 'Carlos@gmail.com', '1991-10-03', '2016-09-29 06:08:23'),
(5, '62354584', 'Raida', 'Alvarado', 'Torres', 'Las brisas', '356268', 'Raida@hotmail.com', '1990-03-10', '2016-09-29 06:08:23'),
(6, '95685325', 'Nicol', 'Castillo', 'Gamboa', 'El trapecio', '326598', 'Nicol@hotmail.com', '1990-04-10', '2016-09-29 06:08:23'),
(7, '95685212', 'Andy', 'Ramirez', 'Rimac', 'A.v. Argentina', '215487', 'Andy@hotmail.com', '1990-03-07', '2016-09-29 06:08:23'),
(8, '54326598', 'Josselyn', 'Arismendis', 'Avila', 'A.v. Santa', '516554', 'Joss@hotmail.com', '1990-03-04', '2016-09-29 06:08:23'),
(9, '75315985', 'Wilson', 'Rubio ', 'Zavaleta', 'A.v. Santa', '214875', 'Wi@hotmail.com', '1991-03-07', '2016-09-29 06:08:23'),
(10, '25896314', 'Genesis', 'BarrioNuevo', 'Mendez', 'A.v. Campo Sol', '625891', 'Gene@hotmail.com', '1992-03-08', '2016-09-29 06:08:23'),
(11, '32165459', 'Eddy', 'Olano', 'Leon', 'A.v.28 de Julio', '502600', 'Eddy@hotmail.com', '1991-02-11', '2016-09-29 07:07:45'),
(12, '20215174', 'Maycol', 'Neyra ', 'Arcos', 'A.v.La union', '659865', 'May@gmail.com', '1994-12-24', '2016-09-29 07:08:53'),
(13, '15975824', 'Milena', 'Zarate', 'Rojas', 'A.v.Santa', '155420', 'Mil@gmail.com', '1995-11-04', '2016-09-29 07:09:45'),
(14, '32165484', 'Cristina', 'Bobadilla', 'Bernuy', 'A.v.Santa', '321544', 'Cris@hotmail.com', '1994-10-03', '2016-09-29 07:10:27'),
(15, '32101201', 'Alfredo', 'Carrion', 'Saldaña', 'A.v.Santa', '159753', 'Alfr@gmail.com', '1995-11-02', '2016-09-29 07:11:07'),
(16, '96312314', 'Mia', 'Carranza', 'Ocaña', 'A.v.Santa', '741852', 'Mia@hotmail.com', '1995-07-03', '2016-09-29 07:11:53'),
(17, '15975382', 'Valerie', 'Mondoñedo', 'Torres', 'A.v.Santa', '146352', 'Valer@gmail.com', '1995-08-05', '2016-09-29 07:12:40'),
(18, '70129676', 'Alexander Estevan', 'Tume', 'Naquiche', 'Amp. Nueva Generación Mz Bt 3', '969918216', 'tumenaquiche@gmail.com', '1994-10-05', '2016-10-19 05:18:08');

-- --------------------------------------------------------

--
-- Table structure for table `programacion`
--

DROP TABLE IF EXISTS `programacion`;
CREATE TABLE `programacion` (
  `prog_id` bigint(20) NOT NULL,
  `asesoria_id` bigint(20) DEFAULT NULL,
  `eva_id` bigint(20) DEFAULT NULL,
  `prog_fecha` date DEFAULT NULL,
  `prog_hora` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `prog_f_reg` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `seguimiento`
--

DROP TABLE IF EXISTS `seguimiento`;
CREATE TABLE `seguimiento` (
  `tram_id` bigint(20) NOT NULL,
  `seg_fecha` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha y hora del sistema',
  `seg_descripcion` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Descripcion de Seguimiento',
  `seg_origen` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Origen proceso ',
  `seg_destino` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Destinpo de proceso',
  `seg_estado` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'El estado en el que se encuentra el proceso'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `seguimiento`
--

INSERT INTO `seguimiento` (`tram_id`, `seg_fecha`, `seg_descripcion`, `seg_origen`, `seg_destino`, `seg_estado`) VALUES
(1, '2016-09-30 01:37:34', 'Se ha iniciado el tramite para presentacion de tÃ©sis.', 'Eddy Olano Leon', 'DirecciÃ³n de Escuela.', 'EN PROCESO'),
(2, '2016-09-30 02:10:32', 'Se ha iniciado el tramite para presentacion de tÃ©sis.', 'Alfredo Carrion SaldaÃ±a', 'DirecciÃ³n de Escuela.', 'EN PROCESO'),
(3, '2016-09-30 02:34:44', 'Se ha iniciado el tramite para presentacion de tesis.', 'Estefany Alvarado Gamboa', 'Dirección de Escuela.', 'EN PROCESO');

-- --------------------------------------------------------

--
-- Table structure for table `tipo_usuario`
--

DROP TABLE IF EXISTS `tipo_usuario`;
CREATE TABLE `tipo_usuario` (
  `tipo_usu_id` bigint(20) NOT NULL,
  `tipo_usu_nombre` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tipo_usu_descripcion` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tipo_usuario`
--

INSERT INTO `tipo_usuario` (`tipo_usu_id`, `tipo_usu_nombre`, `tipo_usu_descripcion`) VALUES
(1, 'ADMINISTRADOR', 'Acceso Completo al Sistema.'),
(2, 'SECRETARIA', 'Acceso Parcial al Sistema.'),
(3, 'DOCENTE', 'Acceso Controlado al Sistema.'),
(4, 'ESTUDIANTE', 'Acceso al control de su desarrollo de la Tesis.'),
(5, 'JUR. DICTAMINADOR', 'Acceso a la evaluacion del Pla de Tesis.'),
(6, 'JUR. EVALUADOR', 'Acceso a la evaluacion de la sustentacion de la Tesis.');

-- --------------------------------------------------------

--
-- Table structure for table `tramite`
--

DROP TABLE IF EXISTS `tramite`;
CREATE TABLE `tramite` (
  `tram_id` bigint(20) NOT NULL,
  `est_codigo` char(10) COLLATE utf8_unicode_ci NOT NULL,
  `pag_codigo` char(10) COLLATE utf8_unicode_ci NOT NULL,
  `tram_fecha_reg` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Es la solicitud que hace para inscribir su esquema de tesis';

--
-- Dumping data for table `tramite`
--

INSERT INTO `tramite` (`tram_id`, `est_codigo`, `pag_codigo`, `tram_fecha_reg`) VALUES
(1, '1111523148', 'PAG5014001', '2016-09-30 01:37:33'),
(2, '1113658245', 'PAG1545847', '2016-09-30 02:10:31'),
(3, '1112100975', 'PAG1523847', '2016-09-30 02:34:44');

--
-- Triggers `tramite`
--
DROP TRIGGER IF EXISTS `tgr_seguimiento_tramite`;
DELIMITER $$
CREATE TRIGGER `tgr_seguimiento_tramite` AFTER INSERT ON `tramite` FOR EACH ROW BEGIN
DECLARE nombre_est varchar(100);
set nombre_est = (SELECT CONCAT(per_nombre,' ', per_ape_pat, ' ',per_ape_mat) FROM view_estudiante WHERE view_estudiante.est_codigo=NEW.est_codigo);
INSERT INTO `seguimiento`(`tram_id`, `seg_fecha`, `seg_descripcion`, `seg_origen`, `seg_destino`, `seg_estado`) VALUES (NEW.tram_id, CURRENT_TIMESTAMP, 'Se ha iniciado el tramite para presentacion de tesis.', nombre_est,'Dirección de Escuela.', 'EN PROCESO');
    END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
CREATE TABLE `usuario` (
  `usu_id` bigint(20) NOT NULL,
  `usu_login` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Nombre de usuario',
  `usu_password` varchar(41) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'ContraseÃ±a de usuario',
  `usu_estado` enum('B','D','A') COLLATE utf8_unicode_ci DEFAULT 'A' COMMENT 'Estado de Usuario(Activo| Desactivado | Bloqueado)',
  `per_id` bigint(20) NOT NULL,
  `tipo_usu_id` bigint(20) NOT NULL COMMENT 'Identificador Tipo Usuario'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Se validara el ingreso al sistema';

--
-- Dumping data for table `usuario`
--

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
(16, '1287545121', '105cef3bf96587ac008042d93ef24a0921db784d', 'A', 10, 3),
(17, 'TUNAQUI', '759bc326b9065395ebdc93c1891139d46fad28c5', 'A', 18, 1);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_docente`
--
DROP VIEW IF EXISTS `view_docente`;
CREATE TABLE `view_docente` (
`doc_id` bigint(20)
,`doc_fecha_reg` timestamp
,`doc_codigo` char(10)
,`per_id` bigint(20)
,`per_dni` char(8)
,`per_nombre` varchar(50)
,`per_ape_pat` varchar(50)
,`per_ape_mat` varchar(50)
,`per_direccion` varchar(70)
,`per_telefono` char(12)
,`per_email` varchar(50)
,`per_fecha_nac` date
,`per_fecha_reg` timestamp
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_esquema`
--
DROP VIEW IF EXISTS `view_esquema`;
CREATE TABLE `view_esquema` (
`tram_id` bigint(20)
,`titulo_tesis` varchar(300)
,`keyswords` varchar(255)
,`obj_pri` varchar(255)
,`obj_sec` varchar(500)
,`resumen` text
,`esq_estado` enum('RECHAZADO','APROBADO','REVISANDO','PRESENTADO')
,`esq_fecha` timestamp
,`usu_id` bigint(20)
,`est_codigo` char(10)
,`est_estado` bit(1)
,`est_fecha_reg` timestamp
,`per_id` bigint(20)
,`per_dni` char(8)
,`per_nombre` varchar(50)
,`per_ape_pat` varchar(50)
,`per_ape_mat` varchar(50)
,`per_direccion` varchar(70)
,`per_telefono` char(12)
,`per_email` varchar(50)
,`per_fecha_nac` date
,`per_fecha_reg` timestamp
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_estudiante`
--
DROP VIEW IF EXISTS `view_estudiante`;
CREATE TABLE `view_estudiante` (
`fila` int(11)
,`est_codigo` char(10)
,`est_estado` bit(1)
,`est_fecha_reg` timestamp
,`per_id` bigint(20)
,`per_dni` char(8)
,`per_nombre` varchar(50)
,`per_ape_pat` varchar(50)
,`per_ape_mat` varchar(50)
,`per_direccion` varchar(70)
,`per_telefono` char(12)
,`per_email` varchar(50)
,`per_fecha_nac` date
,`per_fecha_reg` timestamp
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_jurado`
--
DROP VIEW IF EXISTS `view_jurado`;
CREATE TABLE `view_jurado` (
`jur_id` bigint(20)
,`tipo_jurado` enum('EVALUADOR','DICTAMINADOR')
,`car_nombre` varchar(50)
,`car_descripcion` varchar(255)
,`doc_codigo` char(10)
,`per_id` bigint(20)
,`per_dni` char(8)
,`per_nombre` varchar(50)
,`per_ape_pat` varchar(50)
,`per_ape_mat` varchar(50)
,`per_direccion` varchar(70)
,`per_telefono` char(12)
,`per_email` varchar(50)
,`per_fecha_nac` date
,`per_fecha_reg` timestamp
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_usuario`
--
DROP VIEW IF EXISTS `view_usuario`;
CREATE TABLE `view_usuario` (
`rank` bigint(11)
,`usu_id` bigint(20)
,`usu_login` varchar(16)
,`usu_password` varchar(41)
,`per_id` bigint(20)
,`tipo_usu_id` bigint(20)
,`usu_estado` varchar(11)
,`tipo_usu_nombre` varchar(50)
,`nombres` varchar(152)
);

-- --------------------------------------------------------

--
-- Structure for view `view_docente`
--
DROP TABLE IF EXISTS `view_docente`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_docente`  AS  (select `docente`.`doc_id` AS `doc_id`,`docente`.`doc_fecha_reg` AS `doc_fecha_reg`,`docente`.`doc_codigo` AS `doc_codigo`,`persona`.`per_id` AS `per_id`,`persona`.`per_dni` AS `per_dni`,`persona`.`per_nombre` AS `per_nombre`,`persona`.`per_ape_pat` AS `per_ape_pat`,`persona`.`per_ape_mat` AS `per_ape_mat`,`persona`.`per_direccion` AS `per_direccion`,`persona`.`per_telefono` AS `per_telefono`,`persona`.`per_email` AS `per_email`,`persona`.`per_fecha_nac` AS `per_fecha_nac`,`persona`.`per_fecha_reg` AS `per_fecha_reg` from (`docente` join `persona` on((`docente`.`per_id` = `persona`.`per_id`)))) ;

-- --------------------------------------------------------

--
-- Structure for view `view_esquema`
--
DROP TABLE IF EXISTS `view_esquema`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_esquema`  AS  select `tramite`.`tram_id` AS `tram_id`,`esquema`.`titulo_tesis` AS `titulo_tesis`,`esquema`.`keyswords` AS `keyswords`,`esquema`.`obj_pri` AS `obj_pri`,`esquema`.`obj_sec` AS `obj_sec`,`esquema`.`resumen` AS `resumen`,`esquema`.`esq_estado` AS `esq_estado`,`esquema`.`esq_fecha` AS `esq_fecha`,`esquema`.`usu_id` AS `usu_id`,`view_estudiante`.`est_codigo` AS `est_codigo`,`view_estudiante`.`est_estado` AS `est_estado`,`view_estudiante`.`est_fecha_reg` AS `est_fecha_reg`,`view_estudiante`.`per_id` AS `per_id`,`view_estudiante`.`per_dni` AS `per_dni`,`view_estudiante`.`per_nombre` AS `per_nombre`,`view_estudiante`.`per_ape_pat` AS `per_ape_pat`,`view_estudiante`.`per_ape_mat` AS `per_ape_mat`,`view_estudiante`.`per_direccion` AS `per_direccion`,`view_estudiante`.`per_telefono` AS `per_telefono`,`view_estudiante`.`per_email` AS `per_email`,`view_estudiante`.`per_fecha_nac` AS `per_fecha_nac`,`view_estudiante`.`per_fecha_reg` AS `per_fecha_reg` from ((`esquema` join `tramite` on((`tramite`.`tram_id` = `esquema`.`tram_id`))) join `view_estudiante` on((`view_estudiante`.`est_codigo` = `tramite`.`est_codigo`))) ;

-- --------------------------------------------------------

--
-- Structure for view `view_estudiante`
--
DROP TABLE IF EXISTS `view_estudiante`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_estudiante`  AS  (select `func_rank`() AS `fila`,`estudiante`.`est_codigo` AS `est_codigo`,`estudiante`.`est_estado` AS `est_estado`,`estudiante`.`fecha_reg` AS `est_fecha_reg`,`persona`.`per_id` AS `per_id`,`persona`.`per_dni` AS `per_dni`,`persona`.`per_nombre` AS `per_nombre`,`persona`.`per_ape_pat` AS `per_ape_pat`,`persona`.`per_ape_mat` AS `per_ape_mat`,`persona`.`per_direccion` AS `per_direccion`,`persona`.`per_telefono` AS `per_telefono`,`persona`.`per_email` AS `per_email`,`persona`.`per_fecha_nac` AS `per_fecha_nac`,`persona`.`per_fecha_reg` AS `per_fecha_reg` from (`persona` join `estudiante` on((`persona`.`per_id` = `estudiante`.`per_id`)))) ;

-- --------------------------------------------------------

--
-- Structure for view `view_jurado`
--
DROP TABLE IF EXISTS `view_jurado`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_jurado`  AS  (select `jurado`.`jur_id` AS `jur_id`,`jurado`.`tipo_jurado` AS `tipo_jurado`,`cargo`.`car_nombre` AS `car_nombre`,`cargo`.`car_descripcion` AS `car_descripcion`,`jurado`.`doc_codigo` AS `doc_codigo`,`persona`.`per_id` AS `per_id`,`persona`.`per_dni` AS `per_dni`,`persona`.`per_nombre` AS `per_nombre`,`persona`.`per_ape_pat` AS `per_ape_pat`,`persona`.`per_ape_mat` AS `per_ape_mat`,`persona`.`per_direccion` AS `per_direccion`,`persona`.`per_telefono` AS `per_telefono`,`persona`.`per_email` AS `per_email`,`persona`.`per_fecha_nac` AS `per_fecha_nac`,`persona`.`per_fecha_reg` AS `per_fecha_reg` from (((`persona` join `docente` on((`persona`.`per_id` = `docente`.`per_id`))) join `jurado` on((`jurado`.`doc_codigo` = `docente`.`doc_codigo`))) join `cargo` on((`cargo`.`car_id` = `jurado`.`car_id`)))) ;

-- --------------------------------------------------------

--
-- Structure for view `view_usuario`
--
DROP TABLE IF EXISTS `view_usuario`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_usuario`  AS  select (select `func_rank`()) AS `rank`,`usuario`.`usu_id` AS `usu_id`,`usuario`.`usu_login` AS `usu_login`,`usuario`.`usu_password` AS `usu_password`,`usuario`.`per_id` AS `per_id`,`usuario`.`tipo_usu_id` AS `tipo_usu_id`,if((`usuario`.`usu_estado` = 'A'),'ACTIVO',if((`usuario`.`usu_estado` = 'B'),'BLOQUEADO','DESACTIVADO')) AS `usu_estado`,`tipo_usuario`.`tipo_usu_nombre` AS `tipo_usu_nombre`,concat(`persona`.`per_nombre`,' ',`persona`.`per_ape_pat`,' ',`persona`.`per_ape_mat`) AS `nombres` from ((`usuario` join `persona` on((`persona`.`per_id` = `usuario`.`per_id`))) join `tipo_usuario` on((`tipo_usuario`.`tipo_usu_id` = `usuario`.`tipo_usu_id`))) order by `usuario`.`usu_id` desc ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `acta`
--
ALTER TABLE `acta`
  ADD PRIMARY KEY (`acta_id`),
  ADD UNIQUE KEY `uk_evaluacion_id` (`eva_id`),
  ADD KEY `FK_acta_tramite` (`tram_id`);

--
-- Indexes for table `asesoria`
--
ALTER TABLE `asesoria`
  ADD PRIMARY KEY (`asesoria_id`),
  ADD KEY `fk_asesoria_docente_cod` (`doc_codigo`),
  ADD KEY `fk_asesoria_esquema_id` (`tram_id`);

--
-- Indexes for table `cargo`
--
ALTER TABLE `cargo`
  ADD PRIMARY KEY (`car_id`);

--
-- Indexes for table `det_evaluacion`
--
ALTER TABLE `det_evaluacion`
  ADD KEY `fk_det_evaluacion_evaluacion_id` (`eva_id`),
  ADD KEY `fk_det_evaluacion_jurado_id` (`jur_id`);

--
-- Indexes for table `docente`
--
ALTER TABLE `docente`
  ADD PRIMARY KEY (`doc_id`),
  ADD UNIQUE KEY `uk_docente_codigo` (`doc_codigo`),
  ADD KEY `fk_docente_persona_id` (`per_id`);

--
-- Indexes for table `esquema`
--
ALTER TABLE `esquema`
  ADD PRIMARY KEY (`tram_id`);

--
-- Indexes for table `estudiante`
--
ALTER TABLE `estudiante`
  ADD PRIMARY KEY (`est_codigo`),
  ADD KEY `fk_estudiante_persona` (`per_id`);

--
-- Indexes for table `evaluacion`
--
ALTER TABLE `evaluacion`
  ADD PRIMARY KEY (`eva_id`),
  ADD KEY `fk_evaluacion_tramite_id` (`tram_id`);

--
-- Indexes for table `jurado`
--
ALTER TABLE `jurado`
  ADD PRIMARY KEY (`jur_id`),
  ADD KEY `fk_jurado_cargo_id` (`car_id`),
  ADD KEY `fk_jurado_docente_cod` (`doc_codigo`);

--
-- Indexes for table `observacion`
--
ALTER TABLE `observacion`
  ADD PRIMARY KEY (`obs_id`),
  ADD KEY `fk_observacion_jurado_id` (`jur_id`),
  ADD KEY `fk_observacion_evaluacion_id` (`eva_id`);

--
-- Indexes for table `pagina`
--
ALTER TABLE `pagina`
  ADD PRIMARY KEY (`pag_id`);

--
-- Indexes for table `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`per_id`),
  ADD UNIQUE KEY `uk_dni_persona` (`per_dni`);
ALTER TABLE `persona` ADD FULLTEXT KEY `uk_nombre_persona` (`per_nombre`,`per_ape_pat`,`per_ape_mat`);

--
-- Indexes for table `programacion`
--
ALTER TABLE `programacion`
  ADD PRIMARY KEY (`prog_id`),
  ADD KEY `fk_sustentacion_asesoria_id` (`asesoria_id`),
  ADD KEY `fk_sustentacion_evaluacion_id` (`eva_id`);

--
-- Indexes for table `seguimiento`
--
ALTER TABLE `seguimiento`
  ADD PRIMARY KEY (`tram_id`);

--
-- Indexes for table `tipo_usuario`
--
ALTER TABLE `tipo_usuario`
  ADD PRIMARY KEY (`tipo_usu_id`);

--
-- Indexes for table `tramite`
--
ALTER TABLE `tramite`
  ADD PRIMARY KEY (`tram_id`),
  ADD UNIQUE KEY `uk_pago_tramite` (`pag_codigo`),
  ADD KEY `FK_tramite_estudiante` (`est_codigo`);

--
-- Indexes for table `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`usu_id`),
  ADD KEY `fk_usuario_tipusuario` (`tipo_usu_id`),
  ADD KEY `fk_usuario_persona` (`per_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `acta`
--
ALTER TABLE `acta`
  MODIFY `acta_id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `asesoria`
--
ALTER TABLE `asesoria`
  MODIFY `asesoria_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `cargo`
--
ALTER TABLE `cargo`
  MODIFY `car_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `docente`
--
ALTER TABLE `docente`
  MODIFY `doc_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `evaluacion`
--
ALTER TABLE `evaluacion`
  MODIFY `eva_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `jurado`
--
ALTER TABLE `jurado`
  MODIFY `jur_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `observacion`
--
ALTER TABLE `observacion`
  MODIFY `obs_id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pagina`
--
ALTER TABLE `pagina`
  MODIFY `pag_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `persona`
--
ALTER TABLE `persona`
  MODIFY `per_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT for table `programacion`
--
ALTER TABLE `programacion`
  MODIFY `prog_id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tipo_usuario`
--
ALTER TABLE `tipo_usuario`
  MODIFY `tipo_usu_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `tramite`
--
ALTER TABLE `tramite`
  MODIFY `tram_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `usuario`
--
ALTER TABLE `usuario`
  MODIFY `usu_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `acta`
--
ALTER TABLE `acta`
  ADD CONSTRAINT `FK_acta_evaluacion` FOREIGN KEY (`eva_id`) REFERENCES `evaluacion` (`eva_id`),
  ADD CONSTRAINT `FK_acta_tramite` FOREIGN KEY (`tram_id`) REFERENCES `tramite` (`tram_id`);

--
-- Constraints for table `asesoria`
--
ALTER TABLE `asesoria`
  ADD CONSTRAINT `fk_asesoria_docente_cod` FOREIGN KEY (`doc_codigo`) REFERENCES `docente` (`doc_codigo`),
  ADD CONSTRAINT `fk_asesoria_esquema_id` FOREIGN KEY (`tram_id`) REFERENCES `esquema` (`tram_id`);

--
-- Constraints for table `det_evaluacion`
--
ALTER TABLE `det_evaluacion`
  ADD CONSTRAINT `fk_det_evaluacion_evaluacion_id` FOREIGN KEY (`eva_id`) REFERENCES `evaluacion` (`eva_id`),
  ADD CONSTRAINT `fk_det_evaluacion_jurado_id` FOREIGN KEY (`jur_id`) REFERENCES `jurado` (`jur_id`);

--
-- Constraints for table `docente`
--
ALTER TABLE `docente`
  ADD CONSTRAINT `fk_docente_persona_id` FOREIGN KEY (`per_id`) REFERENCES `persona` (`per_id`);

--
-- Constraints for table `esquema`
--
ALTER TABLE `esquema`
  ADD CONSTRAINT `fk_esquema_tramite_id` FOREIGN KEY (`tram_id`) REFERENCES `tramite` (`tram_id`);

--
-- Constraints for table `estudiante`
--
ALTER TABLE `estudiante`
  ADD CONSTRAINT `fk_estudiante_persona` FOREIGN KEY (`per_id`) REFERENCES `persona` (`per_id`);

--
-- Constraints for table `evaluacion`
--
ALTER TABLE `evaluacion`
  ADD CONSTRAINT `fk_evaluacion_tramite_id` FOREIGN KEY (`tram_id`) REFERENCES `esquema` (`tram_id`);

--
-- Constraints for table `jurado`
--
ALTER TABLE `jurado`
  ADD CONSTRAINT `fk_jurado_cargo_id` FOREIGN KEY (`car_id`) REFERENCES `cargo` (`car_id`),
  ADD CONSTRAINT `fk_jurado_docente_cod` FOREIGN KEY (`doc_codigo`) REFERENCES `docente` (`doc_codigo`);

--
-- Constraints for table `observacion`
--
ALTER TABLE `observacion`
  ADD CONSTRAINT `fk_observacion_evaluacion_id` FOREIGN KEY (`eva_id`) REFERENCES `det_evaluacion` (`eva_id`),
  ADD CONSTRAINT `fk_observacion_jurado_id` FOREIGN KEY (`jur_id`) REFERENCES `jurado` (`jur_id`);

--
-- Constraints for table `programacion`
--
ALTER TABLE `programacion`
  ADD CONSTRAINT `fk_sustentacion_asesoria_id` FOREIGN KEY (`asesoria_id`) REFERENCES `asesoria` (`asesoria_id`),
  ADD CONSTRAINT `fk_sustentacion_evaluacion_id` FOREIGN KEY (`eva_id`) REFERENCES `evaluacion` (`eva_id`);

--
-- Constraints for table `seguimiento`
--
ALTER TABLE `seguimiento`
  ADD CONSTRAINT `fk_seguimiento_tramite` FOREIGN KEY (`tram_id`) REFERENCES `tramite` (`tram_id`);

--
-- Constraints for table `tramite`
--
ALTER TABLE `tramite`
  ADD CONSTRAINT `FK_tramite_estudiante` FOREIGN KEY (`est_codigo`) REFERENCES `estudiante` (`est_codigo`);

--
-- Constraints for table `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `fk_usuario_persona` FOREIGN KEY (`per_id`) REFERENCES `persona` (`per_id`),
  ADD CONSTRAINT `fk_usuario_tipusuario` FOREIGN KEY (`tipo_usu_id`) REFERENCES `tipo_usuario` (`tipo_usu_id`);
SET FOREIGN_KEY_CHECKS=1;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

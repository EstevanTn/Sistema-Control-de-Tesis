<?php
/**
 * Global Configuration Override
 *
 * You can use this file for overriding configuration values from modules, etc.
 * You would place values in here that are agnostic to the environment and not
 * sensitive to security.
 *
 * @NOTE: In practice, this file will typically be INCLUDED in your source
 * control, so do not include passwords or other sensitive information in this
 * file.
 */
error_reporting(0);
session_start();
define('SESSION_NAME', 'TnqSoftSession');
define('COOKIE_NAME', 'TnqSoftCookie');

return [
    'db' => array(
        'driver' => 'Pdo',
        'dsn'            => 'mysql:dbname=jhankevi_tesis;host=184.154.80.186',
        'host'           => '184.154.80.186',
        'username'       => 'jhankevi_tesis',
        'password'       => 'Tume_2094',
        'driver_options' => array(
            PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES \'UTF8\''
        ),
    ),
    /*'db'=>array(
        'driver' => 'Mysqli',
        'host' => '184.154.80.186',
        'database' => 'jhankevi_tesis',
        'username' => 'jhankevi_tesis',
        'password' => '@Tume_2094',
        'charset'  => 'utf8',
        'options' => array('buffer_results' => true)
    ),*/
    'service_manager' => array(
        'factories' => array(
            'Zend\Db\Adapter\Adapter' => 'Zend\Db\Adapter\AdapterServiceFactory',
        ),
    ),
];

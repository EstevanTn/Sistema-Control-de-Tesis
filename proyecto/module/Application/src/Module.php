<?php
/**
 * @link      http://github.com/zendframework/ZendSkeletonApplication for the canonical source repository
 * @copyright Copyright (c) 2005-2016 Zend Technologies USA Inc. (http://www.zend.com)
 * @license   http://framework.zend.com/license/new-bsd New BSD License
 */

namespace Application;

use Zend\Db\Adapter\AdapterInterface;
use Zend\Db\ResultSet\ResultSet;
use Zend\Db\TableGateway\TableGateway;
use Zend\ModuleManager\Feature\ConfigProviderInterface;

class Module implements ConfigProviderInterface
{
    const VERSION = '3.0.2dev';

    public function getConfig()
    {
        return include __DIR__ . '/../config/module.config.php';
    }

    public function getServiceConfig()
    {
        return [
            'factories' => [
                Model\PaginaTable::class => function($container) {
                    $tableGateway = $container->get(Model\PaginaTableGateway::class);
                    return new Model\PaginaTable($tableGateway);
                },
                Model\PaginaTableGateway::class => function ($container) {
                    $dbAdapter = $container->get(AdapterInterface::class);
                    $resultSetPrototype = new ResultSet();
                    $resultSetPrototype->setArrayObjectPrototype(new Model\Entities\Pagina());
                    return new TableGateway('pagina', $dbAdapter, null, $resultSetPrototype);
                },

                Model\UsuarioTable::class => function($container) {
                    $tableGateway = $container->get(Model\UsuarioTableGateway::class);
                    return new Model\UsuarioTable($tableGateway);
                },
                Model\UsuarioTableGateway::class => function ($container) {
                    $dbAdapter = $container->get(AdapterInterface::class);
                    $resultSetPrototype = new ResultSet();
                    $resultSetPrototype->setArrayObjectPrototype(new Model\Entities\Usuario());
                    return new TableGateway('view_usuario', $dbAdapter, null, $resultSetPrototype);
                },

                Model\EsquemaTable::class => function($container) {
                    $tableGateway = $container->get(Model\EsquemaTableGateway::class);
                    return new Model\EsquemaTable($tableGateway);
                },
                Model\EsquemaTableGateway::class => function ($container) {
                    $dbAdapter = $container->get(AdapterInterface::class);
                    $resultSetPrototype = new ResultSet();
                    $resultSetPrototype->setArrayObjectPrototype(new Model\Entities\Esquema());
                    return new TableGateway('view_esquema', $dbAdapter, null, $resultSetPrototype);
                },

                Model\EstudianteTable::class => function($container) {
                    $tableGateway = $container->get(Model\EstudianteTableGateway::class);
                    return new Model\EstudianteTable($tableGateway);
                },
                Model\EstudianteTableGateway::class => function ($container) {
                    $dbAdapter = $container->get(AdapterInterface::class);
                    $resultSetPrototype = new ResultSet();
                    $resultSetPrototype->setArrayObjectPrototype(new Model\Entities\Estudiante());
                    return new TableGateway('view_estudiante', $dbAdapter, null, $resultSetPrototype);
                },

                Model\JuradoTable::class => function($container) {
                    $tableGateway = $container->get(Model\JuradoTableGateway::class);
                    return new Model\JuradoTable($tableGateway);
                },
                Model\JuradoTableGateway::class => function ($container) {
                    $dbAdapter = $container->get(AdapterInterface::class);
                    $resultSetPrototype = new ResultSet();
                    $resultSetPrototype->setArrayObjectPrototype(new Model\Entities\Jurado());
                    return new TableGateway('view_jurado', $dbAdapter, null, $resultSetPrototype);
                },

                Model\TramiteTable::class => function($container) {
                    $tableGateway = $container->get(Model\TramiteTableGateway::class);
                    return new Model\TramiteTable($tableGateway);
                },
                Model\TramiteTableGateway::class => function ($container) {
                    $dbAdapter = $container->get(AdapterInterface::class);
                    $resultSetPrototype = new ResultSet();
                    $resultSetPrototype->setArrayObjectPrototype(new Model\Entities\Tramite());
                    return new TableGateway('tramite', $dbAdapter, null, $resultSetPrototype);
                },
            ],
        ];


    }

    public function getControllerConfig()
    {
        return [
            'factories' => [
                Controller\IndexController::class => function($container){
                  return new Controller\IndexController(
                      $container->get(Model\PaginaTable::class)
                  );
                },
                Controller\UsuarioController::class => function($container) {
                    return new Controller\UsuarioController(
                        $container->get(Model\UsuarioTable::class),
                        $container->get(Model\PaginaTable::class)
                    );
                },
                Controller\AuthController::class => function($container) {
                    return new Controller\AuthController(
                        $container->get(Model\UsuarioTable::class)
                    );
                },
                Controller\EsquemaController::class => function($container) {
                    return new Controller\EsquemaController(
                        $container->get(Model\EsquemaTable::class),
                        $container->get(Model\PaginaTable::class)
                    );
                },
                Controller\AsesorController::class => function($container){
                    return new Controller\AsesorController(
                        $container->get(Model\PaginaTable::class)
                    );
                },
                Controller\ProgramacionController::class => function($container){
                    return new Controller\ProgramacionController(
                        $container->get(Model\PaginaTable::class)
                    );
                },
                Controller\EstudianteController::class => function($container){
                    return new Controller\EstudianteController(
                        $container->get(Model\EstudianteTable::class),
                        $container->get(Model\PaginaTable::class)
                    );
                },
                Controller\JuradoController::class => function($container){
                    return new Controller\JuradoController(
                      $container->get(Model\JuradoTable::class),
                        $container->get(Model\PaginaTable::class)
                    );
                },
                Controller\TramiteController::class => function($container){
                    return new Controller\TramiteController(
                        $container->get(Model\TramiteTable::class),
                        $container->get(Model\PaginaTable::class)
                    );
                }
            ],
        ];
    }

}

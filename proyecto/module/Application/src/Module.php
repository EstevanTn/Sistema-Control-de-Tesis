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
            ],
        ];
    }

    public function getControllerConfig()
    {
        return [
            'factories' => [
                Controller\UsuarioController::class => function($container) {
                    return new Controller\UsuarioController(
                        $container->get(Model\UsuarioTable::class)
                    );
                },
                Controller\AuthController::class => function($container) {
                    return new Controller\AuthController(
                        $container->get(Model\UsuarioTable::class)
                    );
                },
                Controller\EsquemaController::class => function($container) {
                    return new Controller\EsquemaController(
                        $container->get(Model\EsquemaTable::class)
                    );
                },
            ],
        ];
    }

}

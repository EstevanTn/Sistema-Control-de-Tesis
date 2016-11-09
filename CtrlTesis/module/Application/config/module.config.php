<?php
/**
 * @link      http://github.com/zendframework/ZendSkeletonApplication for the canonical source repository
 * @copyright Copyright (c) 2005-2016 Zend Technologies USA Inc. (http://www.zend.com)
 * @license   http://framework.zend.com/license/new-bsd New BSD License
 */

namespace Application;

use Zend\Router\Http\Literal;
use Zend\Router\Http\Segment;
use Zend\ServiceManager\Factory\InvokableFactory;

return [
    'router' => [
        'routes' => [
            'home' => [
                'type' => Literal::class,
                'options' => [
                    'route'    => '/',
                    'defaults' => [
                        'controller' => Controller\IndexController::class,
                        'action'     => 'index',
                    ],
                ],
            ],
            'application' => [
                'type'    => Segment::class,
                'options' => [
                    'route'    => '/application[/:action]',
                    'defaults' => [
                        'controller' => Controller\IndexController::class,
                        'action'     => 'index',
                        'constraints' => [
                            'action' => '[a-z]+'
                        ],
                    ],
                ],
            ],
            'auth' => [
                'type'    => Segment::class,
                'options' => [
                    'route'    => '/auth[/:action]',
                    'defaults' => [
                        'controller' => Controller\AuthController::class,
                        'action'     => 'index',
                        'constraints' => [
                            'action' => '[a-z]+'
                        ],
                    ],
                ],
            ],
            'esquema' => [
                'type'    => Segment::class,
                'options' => [
                    'route'    => '/esquema[/:action[/:key]]',
                    'defaults' => [
                        'controller' => Controller\EsquemaController::class,
                        'action'     => 'index',
                        'constraints' => [
                            'action' => '[a-z]+',
                            'key' => '[0-9]+'
                        ],
                    ],
                ],
            ],
            'estudiante' => [
                'type'    => Segment::class,
                'options' => [
                    'route'    => '/estudiante[/:action[/:key]]',
                    'defaults' => [
                        'controller' => Controller\EstudianteController::class,
                        'action'     => 'index',
                        'constraints' => [
                            'action' => '[a-z]+',
                            'key' => '[0-9]+'
                        ],
                    ],
                ],
            ],
            'asesor' => [
                'type'    => Segment::class,
                'options' => [
                    'route'    => '/asesor[/:action[/:key]]',
                    'defaults' => [
                        'controller' => Controller\AsesorController::class,
                        'action'     => 'index',
                        'constraints' => [
                            'action' => '[a-z]+',
                            'key' => '[0-9]+'
                        ],
                    ],
                ],
            ],
            'usuario' => [
                'type'    => Segment::class,
                'options' => [
                    'route'    => '/usuario[/:action[/:key]]',
                    'defaults' => [
                        'controller' => Controller\UsuarioController::class,
                        'action'     => 'index',
                        'constraints' => [
                            'action' => '[a-z]+',
                            'key' => '[0-9]+'
                        ],
                    ],
                ],
            ],
            'docente' => [
                'type'    => Segment::class,
                'options' => [
                    'route'    => '/docente[/:action[/:key]]',
                    'defaults' => [
                        'controller' => Controller\DocenteController::class,
                        'action'     => 'index',
                        'constraints' => [
                            'action' => '[a-z]+',
                            'key' => '[0-9]+'
                        ],
                    ],
                ],
            ],
            'jurado' => [
                'type'    => Segment::class,
                'options' => [
                    'route'    => "/jurado[/:action[/:key]]",
                    'defaults' => [
                        'controller' => Controller\JuradoController::class,
                        'action'     => 'index',
                        'constraints' => [
                            'action' => '[a-z]+',
                            'key' => '[0-9]+'
                        ],
                    ],
                ],
            ],
            'programacion' => [
                'type'    => Segment::class,
                'options' => [
                    'route'    => '/programacion[/:action[/:key]]',
                    'defaults' => [
                        'controller' => Controller\ProgramacionController::class,
                        'action'     => 'index',
                        'constraints' => [
                            'action' => '[a-z]+',
                            'key' => '[0-9]+'
                        ],
                    ],
                ],
            ],
            'tesis' => [
                'type'    => Segment::class,
                'options' => [
                    'route'    => '/tesis[/:action[/:key]]',
                    'defaults' => [
                        'controller' => Controller\TesisController::class,
                        'action'     => 'index',
                        'constraints' => [
                            'action' => '[a-z]+',
                            'key' => '[0-9]+'
                        ],
                    ],
                ],
            ],
            'cargo' => [
                'type'    => Segment::class,
                'options' => [
                    'route'    => '/cargo[/:action[/:key]]',
                    'defaults' => [
                        'controller' => Controller\CargoController::class,
                        'action'     => 'index',
                        'constraints' => [
                            'action' => '[a-z]+',
                            'key' => '[0-9]+'
                        ],
                    ],
                ],
            ],
            'evaluacion' => [
                'type'    => Segment::class,
                'options' => [
                    'route'    => '/evaluacion[/:action[/:key]]',
                    'defaults' => [
                        'controller' => Controller\EvaluacionController::class,
                        'action'     => 'index',
                        'constraints' => [
                            'action' => '[a-z]+',
                            'key' => '[0-9]+'
                        ],
                    ],
                ],
            ],
            'tramite' => [
                'type'    => Segment::class,
                'options' => [
                    'route'    => '/tramite[/:action[/:key]]',
                    'defaults' => [
                        'controller' => Controller\TramiteController::class,
                        'action'     => 'index',
                        'constraints' => [
                            'action' => '[a-z]+',
                            'key' => '[0-9]+'
                        ],
                    ],
                ],
            ],
        ],
    ],
    'controllers' => [
        'factories' => [
            Controller\IndexController::class => InvokableFactory::class,
            Controller\AuthController::class => InvokableFactory::class,
            Controller\EsquemaController::class => InvokableFactory::class,
            Controller\EstudianteController::class => InvokableFactory::class,
            Controller\AsesorController::class => InvokableFactory::class,
            Controller\DocenteController::class => InvokableFactory::class,
            Controller\JuradoController::class => InvokableFactory::class,
            Controller\ProgramacionController::class => InvokableFactory::class,
            Controller\UsuarioController::class => InvokableFactory::class,
            Controller\TesisController::class => InvokableFactory::class,
            Controller\CargoController::class => InvokableFactory::class,
            Controller\EvaluacionController::class => InvokableFactory::class,
            Controller\TramiteController::class => InvokableFactory::class,
        ],
    ],
    'view_manager' => [
        'display_not_found_reason' => true,
        'display_exceptions'       => true,
        'doctype'                  => 'HTML5',
        'not_found_template'       => 'error/404',
        'exception_template'       => 'error/index',
        'template_map' => [
            'layout/layout'           => __DIR__ . '/../view/layout/layout.phtml',
            'layout/layout0'           => __DIR__ . '/../view/layout/layout0.phtml',
            'layout/blank'           => __DIR__ . '/../view/layout/layoutBlank.phtml',
            'application/index/index' => __DIR__ . '/../view/application/index/index.phtml',
            'error/404'               => __DIR__ . '/../view/error/404.phtml',
            'error/index'             => __DIR__ . '/../view/error/index.phtml',
        ],
        'template_path_stack' => [
            __DIR__ . '/../view',
        ],
    ],
];

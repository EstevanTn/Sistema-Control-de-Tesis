<?php
/**
 * @link      http://github.com/zendframework/ZendSkeletonApplication for the canonical source repository
 * @copyright Copyright (c) 2005-2016 Zend Technologies USA Inc. (http://www.zend.com)
 * @license   http://framework.zend.com/license/new-bsd New BSD License
 */

namespace Application;

use Zend\Router\Http\Literal;
use Zend\Router\Http\Segment;

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
                    ],
                ],
            ],
            'auth' => [
                'type'    => Segment::class,
                'options' => [
                    'route'    => '/auth[/:action]',
                    'defaults' => [
                        'controller' => Controller\AuthController::class,
                        'action'     => 'login',
                    ],
                ],
            ],
            'esquema' => [
                'type'    => Segment::class,
                'options' => [
                    'route'    => '/esquema[/:action[/:id]]',
                    'defaults' => [
                        'controller' => Controller\EsquemaController::class,
                        'action'     => 'index',
                        'constraints'   =>  [
                            'action'    =>  '[a-z]+',
                            'id' => '[0-9]+'
                        ]
                    ],
                ],
            ],
            'estudiante' => [
                'type'    => Segment::class,
                'options' => [
                    'route'    => '/estudiante[/:action[/:id]]',
                    'defaults' => [
                        'controller' => Controller\EstudianteController::class,
                        'action'     => 'index',
                        'constraints'   =>  [
                            'action'    =>  '[a-z]+',
                            'id' => '[0-9]+'
                        ]
                    ],
                ],
            ],
            'asesor' => [
                'type'    => Segment::class,
                'options' => [
                    'route'    => '/asesor[/:action]',
                    'defaults' => [
                        'controller' => Controller\AsesorController::class,
                        'action'     => 'index',
                    ],
                ],
            ],
            'programacion' => [
                'type'    => Segment::class,
                'options' => [
                    'route'    => '/programacion[/:action]',
                    'defaults' => [
                        'controller' => Controller\ProgramacionController::class,
                        'action'     => 'index',
                    ],
                ],
            ],
            'usuario' => [
                'type'    => Segment::class,
                'options' => [
                    'route'    => '/usuario[/:action[/:id]]',
                    'defaults' => [
                        'controller' => Controller\UsuarioController::class,
                        'action'     => 'index',
                        'constraints'   =>  [
                            'action'    =>  '[a-z]+',
                            'id' => '[0-9]+'
                        ]
                    ],
                ],
            ],
            'jurado' => [
                'type'    => Segment::class,
                'options' => [
                    'route'    => '/jurado[/:action[/:id]]',
                    'defaults' => [
                        'controller' => Controller\JuradoController::class,
                        'action'     => 'index',
                        'constraints'   =>  [
                            'action'    =>  '[a-z]+',
                            'id' => '[0-9]+'
                        ]
                    ],
                ],
            ],
        ],
    ],
    'controllers' => [
        'factories' => [
            
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
            'layout/modal'           => __DIR__ . '/../view/layout/modal.phtml',
            'application/index/index' => __DIR__ . '/../view/application/index/index.phtml',
            'error/404'               => __DIR__ . '/../view/error/404.phtml',
            'error/index'             => __DIR__ . '/../view/error/index.phtml',
        ],
        'template_path_stack' => [
            __DIR__ . '/../view',
        ],
    ],
];

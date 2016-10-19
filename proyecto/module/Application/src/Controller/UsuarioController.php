<?php
/**
 * @link      http://github.com/zendframework/ZendSkeletonApplication for the canonical source repository
 * @copyright Copyright (c) 2005-2016 Zend Technologies USA Inc. (http://www.zend.com)
 * @license   http://framework.zend.com/license/new-bsd New BSD License
 */

namespace Application\Controller;

use Application\Model\UsuarioTable;
use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;

class UsuarioController extends AbstractActionController
{

    public $table;

    public function __construct(UsuarioTable $table)
    {
        $this->table = $table;
    }

    public function indexAction()
    {
        $this->layout()->title = 'Lista de Usuarios';
        return new ViewModel([
            'usuarios' => $this->table->fetchAll(),
        ]);
    }

    public function nuevoAction(){
        return new ViewModel();
    }
    
    
    
}

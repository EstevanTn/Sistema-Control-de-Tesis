<?php
/**
 * @link      http://github.com/zendframework/ZendSkeletonApplication for the canonical source repository
 * @copyright Copyright (c) 2005-2016 Zend Technologies USA Inc. (http://www.zend.com)
 * @license   http://framework.zend.com/license/new-bsd New BSD License
 */

namespace Application\Controller;

use Application\Model\PaginaTable;
use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;

class ProgramacionController extends AbstractActionController
{

    public $paginas;

    public function __construct(PaginaTable $paginas)
    {
        $this->paginas = $paginas;
    }

    public function indexAction()
    {
        $this->layout()->title = 'Lista de Programaciones';
        $this->layout()->navbar = $this->paginas->getAuthPages();
        return new ViewModel();
    }

    public function nuevoAction()
    {
        $this->layout()->title = 'Nueva Programación';
        return new ViewModel();
    }
    
}

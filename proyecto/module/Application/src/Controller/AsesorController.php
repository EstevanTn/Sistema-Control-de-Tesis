<?php
/**
 * @link      http://github.com/zendframework/ZendSkeletonApplication for the canonical source repository
 * @copyright Copyright (c) 2005-2016 Zend Technologies USA Inc. (http://www.zend.com)
 * @license   http://framework.zend.com/license/new-bsd New BSD License
 */

namespace Application\Controller;

use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;

class AsesorController extends AbstractActionController
{
    public function indexAction()
    {
        $this->layout()->title = 'Lista de Asesores';
        return new ViewModel();
    }

    public function nuevoAction(){
        $this->layout()->title = 'Nuevo asesor';
        return new ViewModel();
    }

    
}

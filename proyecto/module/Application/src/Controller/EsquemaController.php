<?php

namespace Application\Controller;

use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;
use Zend\View\View;

class EsquemaController extends AbstractActionController
{
    public function indexAction()
    {
        $this->layout()->title = "Lista de Esquemas";
        return new ViewModel();
    }

    public function nuevoAction(){
        $this->layout()->title = "Nuevo Esquema";
        return new ViewModel();
    }
    
}
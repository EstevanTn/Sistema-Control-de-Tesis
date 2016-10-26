<?php

namespace Application\Controller;

use Application\Model\EsquemaTable;
use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;
use Zend\View\View;

class EsquemaController extends AbstractActionController
{
    public $table ;
    
    public function __construct(EsquemaTable $table)
    {
        $this->table = $table;
    }

    public function indexAction()
    {
        $this->layout()->title = "Lista de Esquemas";
        return new ViewModel([
            'esquemas'  =>  $this->table->fetchAll(),
        ]);
    }

    public function nuevoAction(){
        $this->layout()->title = "Nuevo Esquema";
        return new ViewModel();
    }
    
    public function editarAction(){
        $id = $this->params('id');
        $this->layout()->title = 'Editanto Esquema #'.$id;
        return new ViewModel([
            'esquema' => $this->table->getEsquema($id),
        ]);
    }
    
}
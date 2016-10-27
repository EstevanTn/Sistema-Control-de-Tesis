<?php

namespace Application\Controller;

use Application\Model\EsquemaTable;
use Application\Model\PaginaTable;
use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;

class EsquemaController extends AbstractActionController
{
    public $table ;
    public $paginas;
    
    public function __construct(EsquemaTable $table, PaginaTable $paginaTable)
    {
        $this->table = $table;
        $this->paginas = $paginaTable;
    }

    public function indexAction()
    {
        $this->layout()->title = "Lista de Esquemas";
        $this->layout()->navbar = $this->paginas->getAuthPages();
        return new ViewModel([
            'esquemas'  =>  $this->table->fetchAll(),
        ]);
    }

    public function nuevoAction(){
        $this->layout()->title = "Nuevo Esquema";
        $this->layout()->navbar = $this->paginas->getAuthPages();
        return new ViewModel();
    }
    
    public function editarAction(){
        $id = $this->params('id');
        $this->layout()->title = 'Editanto Esquema #'.$id;
        $this->layout()->navbar = $this->paginas->getAuthPages();
        return new ViewModel([
            'esquema' => $this->table->getEsquema($id),
        ]);
    }
    
}
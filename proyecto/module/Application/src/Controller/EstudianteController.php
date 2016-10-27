<?php
/**
 * Created by PhpStorm.
 * User: tnqsoft
 * Date: 27/10/16
 * Time: 01:43 AM
 */

namespace Application\Controller;


use Application\Model\EstudianteTable;
use Application\Model\PaginaTable;
use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;

class EstudianteController extends AbstractActionController
{

    public $table;
    public $paginas;
    
    public function __construct(EstudianteTable $table, PaginaTable $paginas)
    {
        $this->table = $table;
        $this->paginas = $paginas;
    }
    
    public function indexAction()
    {
        return new ViewModel();
    }

    public function buscarAction(){
        $this->layout('layout/modal');
        return new ViewModel([
            'estudiantes' => $this->table->buscarInModal(),
        ]);
    }
}
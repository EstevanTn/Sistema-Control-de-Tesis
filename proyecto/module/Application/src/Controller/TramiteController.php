<?php
/**
 * Created by PhpStorm.
 * User: tnqsoft
 * Date: 27/10/16
 * Time: 07:21 AM
 */

namespace Application\Controller;


use Application\Model\AuthSession;
use Application\Model\PaginaTable;
use Application\Model\TramiteTable;
use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;

class TramiteController extends AbstractActionController
{

    public $table;
    public $paginas;
    
    public function __construct(TramiteTable $table, PaginaTable $paginas)
    {
        $this->table = $table;
        $this->paginas = $paginas;
    }
    
    public function tram_alumnoAction(){
        if(AuthSession::Session()){
            return new ViewModel();
        }else{
            $this->redirect()->toRoute('auth');
        }
    }

}
<?php
/**
 * Created by PhpStorm.
 * User: tnqsoft
 * Date: 27/10/16
 * Time: 06:29 AM
 */

namespace Application\Controller;


use Application\Model\AuthSession;
use Application\Model\JuradoTable;
use Application\Model\PaginaTable;
use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;

class JuradoController extends AbstractActionController
{

    public $table;
    public $paginas;

    public function __construct(JuradoTable $table, PaginaTable $paginas)
    {
        $this->table = $table;
        $this->paginas = $paginas;
    }
    
    public function indexAction()
    {
        if(AuthSession::Session()){
            $this->layout()->title = 'Lista de Jurados';
            $this->layout()->navbar = $this->paginas->getAuthPages();
            return new ViewModel();
        }else{
            $this->redirect()->toRoute('auth');
        }
    }

}
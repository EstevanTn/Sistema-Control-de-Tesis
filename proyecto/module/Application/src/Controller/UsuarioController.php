<?php
/**
 * @link      http://github.com/zendframework/ZendSkeletonApplication for the canonical source repository
 * @copyright Copyright (c) 2005-2016 Zend Technologies USA Inc. (http://www.zend.com)
 * @license   http://framework.zend.com/license/new-bsd New BSD License
 */

namespace Application\Controller;

use Application\Model\AuthSession;
use Application\Model\PaginaTable;
use Application\Model\UsuarioTable;
use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;

class UsuarioController extends AbstractActionController
{

    public $table;
    public $paginas;

    public function __construct(UsuarioTable $table, PaginaTable $paginas)
    {
        $this->table = $table;
        $this->paginas = $paginas;
    }

    public function indexAction()
    {
        if(AuthSession::Session()){
            $this->layout()->title = 'Lista de Usuarios';
            $this->layout()->navbar = $this->paginas->getAuthPages();
            return new ViewModel([
                'usuarios' => $this->table->fetchAll(),
            ]);
        }else{
            $this->redirect()->toRoute('auth');
        }
    }

    public function nuevoAction(){
        if(AuthSession::Session()){
            $this->layout()->title = 'Lista de Usuarios';
            $this->layout()->navbar = $this->paginas->getAuthPages();
            return new ViewModel();
        }else{
            $this->redirect()->toRoute('auth');
        }
    }

    public function editarAction(){
        if(AuthSession::Session()){
            $this->layout()->title = 'Editar Usuario #'.$this->params('id');
            $this->layout()->navbar = $this->paginas->getAuthPages();
            return new ViewModel();
        }else{
            $this->redirect()->toRoute('auth');
        }
    }
    
    
}

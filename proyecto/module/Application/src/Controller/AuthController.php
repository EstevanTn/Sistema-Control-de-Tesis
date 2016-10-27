<?php

namespace Application\Controller;

use Application\Model\AuthSession;
use Application\Model\UsuarioTable;
use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;

class AuthController extends AbstractActionController
{
    private $table;

    public function __construct(UsuarioTable $table)
    {
        $this->table = $table;
    }

    public function loginAction()
    {
        if(isset($_POST['username']) and isset($_POST['password'])){
            if(AuthSession::AuthSession($this->table)){
                $this->redirect()->toRoute('home');
            };
        }else{
            if(isset($_SESSION[SESSION_NAME])){
                $this->redirect()->toRoute('home');
            }
        }
        $this->layout('layout/layout0');
        $this->layout()->title = "Inicia de Sessión";
        return new ViewModel();
    }


    public function logoutAction(){
        session_destroy();
        $this->redirect()->toRoute('auth');
        //return new ViewModel();
    }
    
}
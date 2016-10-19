<?php

namespace Application\Controller;

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
            $auth = $this->table->authLogin($_POST['username'],$_POST['password']);
            if($auth['sessionAuth']){
                $_SESSION[SESSION_NAME] = $_POST['username'];
                $_COOKIE[COOKIE_NAME] = json_encode($auth);
                $this->redirect()->toRoute('home');
            }
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
        return new ViewModel();
    }
    
}
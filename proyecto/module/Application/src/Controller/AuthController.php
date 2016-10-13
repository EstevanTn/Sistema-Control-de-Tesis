<?php

namespace Application\Controller;

use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;

class AuthController extends AbstractActionController
{
    public function loginAction()
    {
        session_start();
        if(isset($_POST['username']) and isset($_POST['password'])){
            $_SESSION['session'] = $_POST['username'];
            $this->redirect()->toRoute('home');
        }else{
            $this->layout('layout/layout0');
            $this->layout()->title = "Inicia de Sessión";
            return new ViewModel();
        }
    }


    public function logoutAction(){
        
    }
    
}
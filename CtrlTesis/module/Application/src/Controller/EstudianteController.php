<?php
/**
 * Created by PhpStorm.
 * User: tnqsoft
 * Date: 30/10/16
 * Time: 06:39 PM
 */

namespace Application\Controller;


use Application\Model\AuthSession;
use Zend\Db\Adapter\Adapter;
use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;

class EstudianteController extends AbstractActionController
{

    public $dbAdapter ;

    public function indexAction(){

        $this->dbAdapter = $this->getPluginManager()->getServiceLocator()->get(Adapter::class);
        if(AuthSession::AuthSession($this->dbAdapter)){
            $this->layout()->title = 'Lista de Estudiantes';
            $this->layout()->navbar = AuthSession::getAuthPages($this->dbAdapter);
            return new ViewModel();
        }else{
            $this->redirect()->toRoute('auth');
        }
    }

    public function mbuscarAction(){
        $this->dbAdapter = $this->getPluginManager()->getServiceLocator()->get(Adapter::class);
        if(AuthSession::AuthSession($this->dbAdapter)){
            $this->layout('layout/blank');
            return new ViewModel();
        }else{
            $this->redirect()->toRoute('auth');
        }
    }

}
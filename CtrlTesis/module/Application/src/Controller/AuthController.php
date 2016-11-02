<?php
/**
 * Created by PhpStorm.
 * User: tnqsoft
 * Date: 30/10/16
 * Time: 01:23 PM
 */

namespace Application\Controller;


use Application\Model\AuthSession;
use Zend\Db\Adapter\Adapter;
use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;

class AuthController extends AbstractActionController
{

    public $dbAdapter;

    public function indexAction()
    {
        $this->dbAdapter = $db = $this->getPluginManager()->getServiceLocator()->get(Adapter::class);
        if(AuthSession::AuthSession($this->dbAdapter)){
            $this->redirect()->toRoute('home');
        }
        $this->layout('layout/layout0');
        $this->layout()->title = 'Sitema Control de Tesis';
        return new ViewModel();
    }

    public function destroyAction(){
        session_destroy();
        $this->redirect()->toRoute('auth');
    }

}
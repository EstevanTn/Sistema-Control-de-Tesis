<?php
/**
 * Created by PhpStorm.
 * User: tnqsoft
 * Date: 31/10/16
 * Time: 06:13 PM
 */

namespace Application\Controller;


use Application\Model\AuthSession;
use Application\Model\ModelCargo;
use Zend\Db\Adapter\Adapter;
use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;

class CargoController extends AbstractActionController
{
    public $dbAdapter;
    public function indexAction()
    {
        $this->dbAdapter = $this->getPluginManager()->getServiceLocator()->get(Adapter::class);
        if(AuthSession::AuthSession($this->dbAdapter)){
            $model = new ModelCargo($this->dbAdapter);
            $this->layout()->title = 'Lista de Tesis';
            $this->layout()->navbar = AuthSession::getAuthPages($this->dbAdapter);
            return new ViewModel([
                'cargo' => $model->fetchAll(),
            ]);
        }else{
            $this->redirect()->toRoute('auth');
        }
    }

    public function mbuscarAction(){
        $this->dbAdapter = $this->getPluginManager()->getServiceLocator()->get(Adapter::class);
        if(AuthSession::AuthSession($this->dbAdapter)){
            $model = new ModelCargo($this->dbAdapter);
            $this->layout('layout/blank');
            return new ViewModel([
                'cargo' => $model->fetchAll(),
            ]);
        }else{
            $this->redirect()->toRoute('auth');
        }
    }

}
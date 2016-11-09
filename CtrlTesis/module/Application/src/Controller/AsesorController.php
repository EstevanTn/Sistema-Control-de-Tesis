<?php
/**
 * Created by PhpStorm.
 * User: tnqsoft
 * Date: 31/10/16
 * Time: 06:07 PM
 */

namespace Application\Controller;


use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;
use Application\Model\AuthSession;
use Zend\Db\Adapter\Adapter;
use Application\Model\ModelAsesor;

class AsesorController extends AbstractActionController
{
    public $dbAdapter;

    public function indexAction()
    {
        $this->dbAdapter = $this->getPluginManager()->getServiceLocator()->get(Adapter::class);
        if(AuthSession::AuthSession($this->dbAdapter)){
            $this->layout()->title = 'Lista de Asesoria';
            $this->layout()->navbar = AuthSession::getAuthPages($this->dbAdapter);
            return new ViewModel();
        }else{
            $this->redirect()->toRoute('auth');
        }
        return new ViewModel();
    }

    public function mbuscarAction(){
        $this->dbAdapter = $this->getPluginManager()->getServiceLocator()->get(Adapter::class);
        if(AuthSession::AuthSession($this->dbAdapter)){
            $model = new ModelAsesor($this->dbAdapter);
            $this->layout('layout/blank');
            return new ViewModel([
                'asesoria' => $model->fetchAll(),
            ]);
        }else{
            $this->redirect()->toRoute('auth');
        }
    }
}
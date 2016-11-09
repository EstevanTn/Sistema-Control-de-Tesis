<?php
/**
 * Created by PhpStorm.
 * User: tnqsoft
 * Date: 31/10/16
 * Time: 06:07 PM
 */

namespace Application\Controller;


use Application\Model\AuthSession;
use Application\Model\ModelPersona;
use Zend\Db\Adapter\Adapter;
use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;

class PersonaController extends AbstractActionController
{
    public $dbAdapter;

    public function indexAction()
    {
        $this->dbAdapter = $this->getPluginManager()->getServiceLocator()->get(Adapter::class);
        if(AuthSession::AuthSession($this->dbAdapter)){
            $this->layout()->title = 'Lista de Personas';
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
            $model = new ModelPersona($this->dbAdapter);
            $this->layout('layout/blank');
            return new ViewModel([
                'persona' => $model->fetchAll(),
            ]);
        }else{
            $this->redirect()->toRoute('auth');
        }
    }

    public function nuevoAction(){
        $this->dbAdapter = $this->getPluginManager()->getServiceLocator()->get(Adapter::class);
        if(AuthSession::AuthSession($this->dbAdapter)){
            $model = new ModelPesona($this->dbAdapter);
            $this->layout()->title = 'Nueva Persona';
            $this->layout()->navbar = AuthSession::getAuthPages($this->dbAdapter);
            return new ViewModel($model->insert());
        }else{
            $this->redirect()->toRoute('auth');
        }
    }
}
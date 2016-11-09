<?php
/**
 * Created by PhpStorm.
 * User: tnqsoft
 * Date: 31/10/16
 * Time: 06:09 PM
 */

namespace Application\Controller;


use Application\Model\AuthSession;
use Application\Model\ModelUsuario;
use Zend\Db\Adapter\Adapter;
use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;

class UsuarioController extends AbstractActionController
{

    public $dbAdapter;

    public function indexAction()
    {
        $this->dbAdapter = $this->getPluginManager()->getServiceLocator()->get(Adapter::class);
        if(AuthSession::AuthSession($this->dbAdapter)){
            $model = new ModelUsuario($this->dbAdapter);
            $this->layout()->title = 'Lista de Usuarios';
            $this->layout()->navbar = AuthSession::getAuthPages($this->dbAdapter);
            return new ViewModel([
                'usuarios' => $model->fetchAll(),
            ]);
        }else{
            $this->redirect()->toRoute('auth');
        }
    }

    public function nuevoAction(){
        $this->dbAdapter = $this->getPluginManager()->getServiceLocator()->get(Adapter::class);
        if(AuthSession::AuthSession($this->dbAdapter)){
            $model = new ModelUsuario($this->dbAdapter);
            $this->layout()->title = 'Nuevo Usuario';
            $this->layout()->navbar = AuthSession::getAuthPages($this->dbAdapter);
            return new ViewModel($model->insert());
        }else{
            $this->redirect()->toRoute('auth');
        }
    }

    public function editarAction(){
        $this->dbAdapter = $this->getPluginManager()->getServiceLocator()->get(Adapter::class);
        if(AuthSession::AuthSession($this->dbAdapter)){
            $model = new ModelUsuario($this->dbAdapter);
            $this->layout()->title = 'Editando Usuario';
            $this->layout()->navbar = AuthSession::getAuthPages($this->dbAdapter);
            return new ViewModel();
        }else{
            $this->redirect()->toRoute('auth');
        }
    }

    public function verAction()
    {
        $this->dbAdapter = $this->getPluginManager()->getServiceLocator()->get(Adapter::class);
        if(AuthSession::AuthSession($this->dbAdapter)){
            $model = new ModelUsuario($this->dbAdapter);
            $this->layout('layout/blank');
            return new ViewModel();
        }else{
            $this->redirect()->toRoute('auth');
        }
    }

}
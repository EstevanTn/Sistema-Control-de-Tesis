<?php
/**
 * Created by PhpStorm.
 * User: tnqsoft
 * Date: 31/10/16
 * Time: 06:10 PM
 */

namespace Application\Controller;


use Application\Model\AuthSession;
use Application\Model\ModelDocente;
use Zend\Db\Adapter\Adapter;
use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;

class DocenteController extends AbstractActionController
{
    public $dbAdapter;
    public function indexAction()
    {
        $this->dbAdapter = $this->getPluginManager()->getServiceLocator()->get(Adapter::class);
        if (AuthSession::AuthSession($this->dbAdapter)) {
            $model = new ModelDocente($this->dbAdapter);
            $this->layout()->title = 'Lista de Docentes';
            $this->layout()->navbar = AuthSession::getAuthPages($this->dbAdapter);
            return new ViewModel([
                'list' => $model->fetchAll(),
            ]);
        } else {
            $this->redirect()->toRoute('auth');
        }
    }

    public function editarAction()
    {
        $this->dbAdapter = $this->getPluginManager()->getServiceLocator()->get(Adapter::class);
        if (AuthSession::AuthSession($this->dbAdapter)) {
            $model = new ModelDocente($this->dbAdapter);
            $id = $this->params('key');
            $this->layout()->title = 'Editando Docente N°'.$id;
            $this->layout()->navbar = AuthSession::getAuthPages($this->dbAdapter);
            $result = array_merge($model->update(), ['docente'=> $model->get($id)]);
            return new ViewModel($result);
        } else {
            $this->redirect()->toRoute('auth');
        }
    }

    public function nuevoAction()
    {
        $this->dbAdapter = $this->getPluginManager()->getServiceLocator()->get(Adapter::class);
        if (AuthSession::AuthSession($this->dbAdapter)) {
            $model = new ModelDocente($this->dbAdapter);
            $this->layout()->title = 'Nuevo Docente';
            $this->layout()->navbar = AuthSession::getAuthPages($this->dbAdapter);
            return new ViewModel($model->insert());
        } else {
            $this->redirect()->toRoute('auth');
        }
    }

    public function mbuscarAction(){
        $this->dbAdapter = $this->getPluginManager()->getServiceLocator()->get(Adapter::class);
        if(AuthSession::AuthSession($this->dbAdapter)){
            $model = new ModelDocente($this->dbAdapter);
            $this->layout('layout/blank');
            return new ViewModel([
                'docente' => $model->fetchAll(),
            ]);
        }else{
            $this->redirect()->toRoute('auth');
        }
    }

   
}
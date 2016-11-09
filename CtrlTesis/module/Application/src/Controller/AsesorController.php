<?php
/**
 * Created by PhpStorm.
 * User: tnqsoft
 * Date: 31/10/16
 * Time: 06:07 PM
 */

namespace Application\Controller;


use Application\Model\AuthSession;
use Application\Model\ModelAsesor;
use Zend\Db\Adapter\Adapter;
use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;

class AsesorController extends AbstractActionController
{
    public $dbAdapter;

    public function indexAction()
    {
        $this->dbAdapter = $this->getPluginManager()->getServiceLocator()->get(Adapter::class);
        if(AuthSession::AuthSession($this->dbAdapter)){
            $model = new ModelAsesor($this->dbAdapter);
            $this->layout()->title = 'Lista de Tesis';
            $this->layout()->navbar = AuthSession::getAuthPages($this->dbAdapter);
            return new ViewModel([
                'asesor' => $model->fetchAll(),
            ]);
        }else{
            $this->redirect()->toRoute('auth');
        }
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

    public function nuevoAction(){
        $this->dbAdapter = $this->getPluginManager()->getServiceLocator()->get(Adapter::class);
        if(AuthSession::AuthSession($this->dbAdapter)){
            $model = new ModelAsesor($this->dbAdapter);
            $this->layout()->title = 'Nuevo Asesor';
            $this->layout()->navbar = AuthSession::getAuthPages($this->dbAdapter);
            return new ViewModel($model->insert());
        }else{
            $this->redirect()->toRoute('auth');
        }
    }

    public function editarAction(){
        $this->dbAdapter = $this->getPluginManager()->getServiceLocator()->get(Adapter::class);
        if(AuthSession::AuthSession($this->dbAdapter)){
            $model = new ModelAsesor($this->dbAdapter);
            $key = $this->params('key');
            $this->layout()->title = 'Editando Asesor N°'.$key;
            $this->layout()->navbar = AuthSession::getAuthPages($this->dbAdapter);
            return new ViewModel($model->get($key));
        }else{
            $this->redirect()->toRoute('auth');
        }
    }

    public function alumnosAction(){
        $this->dbAdapter = $this->getPluginManager()->getServiceLocator()->get(Adapter::class);
        if(AuthSession::AuthSession($this->dbAdapter)){
            $model = new ModelAsesor($this->dbAdapter);
            $key = $this->params('key');
            $this->layout('layout/blank');
            return new ViewModel(array_merge(
                ['list' => $model->alumnos($key)]
                , ['title'=>'Lista de alumnos asesorados']));
        }else{
            $this->redirect()->toRoute('auth');
        }
    }

}
<?php
/**
 * Created by PhpStorm.
 * User: tnqsoft
 * Date: 31/10/16
 * Time: 06:08 PM
 */

namespace Application\Controller;


use Application\Model\AuthSession;
use Application\Model\ModelProgramacion;
use Zend\Db\Adapter\Adapter;
use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;

;

class ProgramacionController extends AbstractActionController
{
    public $dbAdapter;
    
    public function indexAction()
    {
        $this->dbAdapter = $this->getPluginManager()->getServiceLocator()->get(Adapter::class);
        if(AuthSession::AuthSession($this->dbAdapter)){
            $model = new ModelProgramacion($this->dbAdapter);
            $this->layout()->title = 'Lista de Programaciones';
            $this->layout()->navbar = AuthSession::getAuthPages($this->dbAdapter);
            return new ViewModel([
                'programacion' => $model->fetchAll(),
            ]);
        }else{
            $this->redirect()->toRoute('auth');
        }
    }

    public function nuevoAction(){
        $this->dbAdapter = $this->getPluginManager()->getServiceLocator()->get(Adapter::class);
        if(AuthSession::AuthSession($this->dbAdapter)){
            $model = new ModelProgramacion($this->dbAdapter);
            $this->layout()->title = 'Nueva Programacion';
            $this->layout()->navbar = AuthSession::getAuthPages($this->dbAdapter);
            return new ViewModel($model->insert());
        }else{
            $this->redirect()->toRoute('auth');
        }
    }

    public function editarAction(){
        $this->dbAdapter = $this->getPluginManager()->getServiceLocator()->get(Adapter::class);
        if(AuthSession::AuthSession($this->dbAdapter)){
            $model = new ModelProgramacion($this->dbAdapter);
            $this->layout()->title = 'Editar Programacion';
            $this->layout()->navbar = AuthSession::getAuthPages($this->dbAdapter);
            return new ViewModel([
                'programacion' => $model->get($this->params('key')),
            ]);
        }else{
            $this->redirect()->toRoute('auth');
        }
    }

}
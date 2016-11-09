<?php
/**
 * Created by PhpStorm.
 * User: tnqsoft
 * Date: 30/10/16
 * Time: 05:01 PM
 */

namespace Application\Controller;


use Application\Model\AuthSession;
use Application\Model\ModelEsquema;
use Zend\Db\Adapter\Adapter;
use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;

class EsquemaController extends AbstractActionController
{
    public $dbAdapter;

    public function indexAction()
    {
        $this->dbAdapter = $this->getPluginManager()->getServiceLocator()->get(Adapter::class);
        if(AuthSession::AuthSession($this->dbAdapter)){
            $model = new ModelEsquema($this->dbAdapter);
            $this->layout()->title = 'Lista de Esquemas';
            $this->layout()->navbar = AuthSession::getAuthPages($this->dbAdapter);
            return new ViewModel([
                'esquemas' => $model->fetchAll(),
            ]);
        }else{
            $this->redirect()->toRoute('auth');
        }
    }

    public function nuevoAction(){
        $this->dbAdapter = $this->getPluginManager()->getServiceLocator()->get(Adapter::class);
        if(AuthSession::AuthSession($this->dbAdapter)){
            $model = new ModelEsquema($this->dbAdapter);
            $this->layout()->title = 'Nuevo Esquema';
            $this->layout()->navbar = AuthSession::getAuthPages($this->dbAdapter);
            return new ViewModel($model->insert());
        }else{
            $this->redirect()->toRoute('auth');
        }
    }

    public function editarAction(){
        $this->dbAdapter = $this->getPluginManager()->getServiceLocator()->get(Adapter::class);
        if(AuthSession::AuthSession($this->dbAdapter)){
            $model = new ModelEsquema($this->dbAdapter);
            $this->layout()->title = 'Editar Esquema';
            $this->layout()->navbar = AuthSession::getAuthPages($this->dbAdapter);
            return new ViewModel([
                'esquema' => $model->get($this->params('key')),
            ]);
        }else{
            $this->redirect()->toRoute('auth');
        }
    }

}
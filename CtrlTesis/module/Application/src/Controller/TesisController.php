<?php
/**
 * Created by PhpStorm.
 * User: tnqsoft
 * Date: 31/10/16
 * Time: 06:13 PM
 */

namespace Application\Controller;


use Application\Model\ModelTesis;
use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;
use Zend\Db\Adapter\Adapter;
use Application\Model\AuthSession;


class TesisController extends AbstractActionController
{
    public $dbAdapter;
    public function indexAction()
    {
        $this->dbAdapter = $this->getPluginManager()->getServiceLocator()->get(Adapter::class);
        if(AuthSession::AuthSession($this->dbAdapter)) {
            $model = new ModelTesis($this->dbAdapter);
            $this->layout()->title = 'Lista de Tesis';
            $this->layout()->navbar = AuthSession::getAuthPages($this->dbAdapter);
            return new ViewModel([
                'tesis' => $model->fetchAll(),
            ]);
        } else{
            $this->redirect()->toRoute('auth');
            }
        return new ViewModel();

    }
    
    public function buscarAction(){
        $this->dbAdapter = $this->getPluginManager()->getServiceLocator()->get(Adapter::class);
        if(AuthSession::AuthSession($this->dbAdapter)){
            $model = new ModelTesis($this->dbAdapter);
            $this->layout('layout/blank');
            return new ViewModel([
                'tesis' => $model->fetchAll(),
            ]);
        }else{
            $this->redirect()->toRoute('auth');
        }
    }
}
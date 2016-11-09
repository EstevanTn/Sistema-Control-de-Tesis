<?php
/**
 * Created by PhpStorm.
 * User: tnqsoft
 * Date: 30/10/16
 * Time: 06:39 PM
 */

namespace Application\Controller;


use Application\Model\AuthSession;
use Application\Model\ModelEvaluacion;
use Zend\Db\Adapter\Adapter;
use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;

class EvaluacionController extends AbstractActionController
{

    public $dbAdapter ;

    public function indexAction(){

        $this->dbAdapter = $this->getPluginManager()->getServiceLocator()->get(Adapter::class);
        if(AuthSession::AuthSession($this->dbAdapter)){
            $this->layout()->title = 'Lista de Evaluaciones';
            $this->layout()->navbar = AuthSession::getAuthPages($this->dbAdapter);
            return new ViewModel();
        }else{
            $this->redirect()->toRoute('auth');
        }
    }

    public function mbuscarAction(){
        $this->dbAdapter = $this->getPluginManager()->getServiceLocator()->get(Adapter::class);
        if(AuthSession::AuthSession($this->dbAdapter)){
            $model = new ModelEvaluacion($this->dbAdapter);
            $this->layout('layout/blank');
            return new ViewModel([
                'evaluacion' => $model->fetchAll(),
            ]);
        }else{
            $this->redirect()->toRoute('auth');
        }
    }

}
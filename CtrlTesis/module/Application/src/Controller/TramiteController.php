<?php
/**
 * Created by PhpStorm.
 * User: tnqsoft
 * Date: 08/11/16
 * Time: 11:18 PM
 */

namespace Application\Controller;


use Application\Model\ModelTramite;
use Zend\Db\Adapter\Adapter;
use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;

class TramiteController extends AbstractActionController
{

    public $dbAdapter;

    public function indexAction()
    {
        return new ViewModel();
    }

    public function tramiteestudianteAction(){
        $this->layout('layout/blank');
        $this->dbAdapter = $this->getPluginManager()->getServiceLocator()->get(Adapter::class);
        $model = new ModelTramite($this->dbAdapter);
        return new ViewModel([
            'codigo' => $this->params('key'),
            'tramites' => $model->getAll($this->params('key')),
        ]);
    }

}
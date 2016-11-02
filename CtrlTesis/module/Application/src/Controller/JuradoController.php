<?php
/**
 * Created by PhpStorm.
 * User: tnqsoft
 * Date: 31/10/16
 * Time: 06:11 PM
 */

namespace Application\Controller;

use Application\Model\AuthSession;
use Application\Model\ModelJurado;
use Zend\Db\Adapter\Adapter;
use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;

class JuradoController extends AbstractActionController
{
    
    public $dbAdapter;
    
    public function indexAction()
    {
        $this->dbAdapter = $this->getPluginManager()->getServiceLocator()->get(Adapter::class);
        if(AuthSession::AuthSession($this->dbAdapter)){
            $model = new ModelJurado($this->dbAdapter);
            $this->layout()->title = 'Lista de Jurados';
            $this->layout()->navbar = AuthSession::getAuthPages($this->dbAdapter);
            return new ViewModel([
                'jurados' => $model->fetchAll(),
            ]);
        }else{
            $this->redirect()->toRoute('auth');
        }
    }

}
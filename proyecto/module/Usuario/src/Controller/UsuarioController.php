<?php
/**
 * @link      http://github.com/zendframework/ZendSkeletonApplication for the canonical source repository
 * @copyright Copyright (c) 2005-2016 Zend Technologies USA Inc. (http://www.zend.com)
 * @license   http://framework.zend.com/license/new-bsd New BSD License
 */

namespace Usuario\Controller;

use Application\Model\UsuarioTable;
use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;

class UsuarioController extends AbstractActionController
{

    public $dbAdapter;

    public function indexAction()
    {
        //$this->dbAdapter = $this->getServiceLocator()->get('Zend\Db\Adapter');
        //$model= new UsuarioTable($this->dbAdapter);
        $this->layout()->title = 'Lista de Usuarios';
        $meta = array(
            'data' => $this->model->GetAll(),
        );
        return new ViewModel($meta);
    }

    public function nuevoAction(){
        return new ViewModel();
    }
    
    
    
}

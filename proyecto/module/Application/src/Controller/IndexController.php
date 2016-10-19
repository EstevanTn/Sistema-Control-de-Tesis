<?php
/**
 * @link      http://github.com/zendframework/ZendSkeletonApplication for the canonical source repository
 * @copyright Copyright (c) 2005-2016 Zend Technologies USA Inc. (http://www.zend.com)
 * @license   http://framework.zend.com/license/new-bsd New BSD License
 */

namespace Application\Controller;

use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;

class IndexController extends AbstractActionController
{
    public function indexAction()
    {
        if(isset($_SESSION[SESSION_NAME])){
            $this->layout()->title = 'Intranet Control Tesis';
            return new ViewModel();
        }else {
            $this->redirect()->toRoute('auth');
        }
    }


    
}

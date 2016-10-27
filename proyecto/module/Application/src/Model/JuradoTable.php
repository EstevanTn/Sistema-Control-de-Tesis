<?php
/**
 * Created by PhpStorm.
 * User: tnqsoft
 * Date: 27/10/16
 * Time: 06:27 AM
 */

namespace Application\Model;


use Zend\Db\TableGateway\TableGatewayInterface;

class JuradoTable
{

    public $tableGateway;

    public function __construct(TableGatewayInterface $tableGatewayInterface)
    {
        $this->tableGateway = $tableGatewayInterface;
    }

    public function fetchAll(){
        
    }

}
<?php
/**
 * Created by PhpStorm.
 * User: tnqsoft
 * Date: 27/10/16
 * Time: 01:44 AM
 */

namespace Application\Model;


use Application\TnqSoft\Functions;
use Zend\Db\Sql\Select;
use Zend\Db\TableGateway\TableGatewayInterface;

class EstudianteTable
{
    public $tableGateway;
    
    public function __construct(TableGatewayInterface $tableGatewayInterface)
    {
        $this->tableGateway = $tableGatewayInterface;
    }

    public function buscarInModal(){
        Functions::createPagination($this->tableGateway);
        return $this->tableGateway->select(function(Select $select){
            $select->where('fila >='.PAGINATION_START)->order('fila DESC')->limit(10);
        });
    }
}
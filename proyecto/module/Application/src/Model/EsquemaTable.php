<?php
/**
 * Created by PhpStorm.
 * User: tnqsoft
 * Date: 19/10/16
 * Time: 11:55 AM
 */

namespace Application\Model;


use Application\TnqSoft\Functions;
use Zend\Db\Sql\Select;
use Zend\Db\TableGateway\TableGatewayInterface;

class EsquemaTable
{

    public $tableGateway;

    public function __construct(TableGatewayInterface $table)
    {
        $this->tableGateway = $table;
    }

    public function fetchAll(){
        Functions::createPagination($this->tableGateway);
        return $this->tableGateway->select(function(Select $select){
            $select->where('tram_id <='.PAGINATION_START)->order('tram_id DESC')->limit(10);
        });
    }
}
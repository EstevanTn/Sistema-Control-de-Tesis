<?php
/**
 * Created by PhpStorm.
 * User: tnqsoft
 * Date: 27/10/16
 * Time: 07:18 AM
 */

namespace Application\Model;


use Zend\Db\TableGateway\TableGatewayInterface;

class TramiteTable
{
    
    public $tableGateway;
    
    public function __construct(TableGatewayInterface $tableGatewayInterface)
    {
        $this->tableGateway = $tableGatewayInterface;
    }
    
    public function buscarCodEstudiante($codigo){
        return $this->tableGateway->select(['est_codigo'=>$codigo]);
    }
    
}
<?php
namespace Application\Model;
use Application\TnqSoft\Functions;
use Zend\Db\Sql\Select;
use Zend\Db\TableGateway\TableGatewayInterface;

class UsuarioTable
{
    private $tableGateway;

    public function __construct(TableGatewayInterface $tableGateway)
    {
        $this->tableGateway = $tableGateway;
    }

    public function fetchAll(){
        Functions::createPagination($this->tableGateway);
        return $this->tableGateway->select(function(Select $select){
            $select->where('usu_id <='.PAGINATION_START)->limit(10);
        });
    }

    public function authLogin($username, $password){
        $resultSet = $this->tableGateway->select(['usu_login'=>$username, 'usu_password'=>sha1($password)]);
        $data = null;
        return[
          'sessionAuth' => count($resultSet)==1?true:false,
            'resultSet'  =>  $resultSet
        ];
    }



}
<?php
namespace Usuario\Model;
use Application\Model\Entities\Usuario;
use Zend\Db\ResultSet\ResultSet;
use Zend\Db\Adapter\Adapter;
use Zend\Db\Sql\Sql;
use Zend\Db\TableGateway\AbstractTableGateway;

class UsuarioTable extends AbstractTableGateway{

    function __construct($adapter)
    {
        $this->table = 'usuario';
        $this->adapter = $adapter;
        $this->resultSetPrototype = new ResultSet();
        $this->resultSetPrototype->setArrayObjectPrototype(new Usuario());
        $this->initialize();
    }

    function GetAll(){
        $resultSet = $this->select();
        return $resultSet;
    }
}
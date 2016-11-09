<?php

namespace Application\Model;


use Zend\Db\Adapter\Adapter;

class ModelTramite implements InterfaceModel
{

    public $adapter;

    public function __construct(Adapter $adapter)
    {
        $this->adapter = $adapter;
    }

    public  function getAll($keyEstudiante){
        $sql = sprintf("SELECT * FROM tramite WHERE est_codigo='%s'", $keyEstudiante);
        $statment = $this->adapter->query($sql);
        $results = $statment->execute();
        return $results;
    }

    public function fetchAll()
    {
        // TODO: Implement fetchAll() method.
    }

    public function insert()
    {
        // TODO: Implement insert() method.
    }

    public function update()
    {
        // TODO: Implement update() method.
    }

    public function delete($id)
    {
        // TODO: Implement delete() method.
    }

    public function get($id)
    {
        // TODO: Implement get() method.
    }

    public function search(array $data)
    {
        // TODO: Implement search() method.
    }
}
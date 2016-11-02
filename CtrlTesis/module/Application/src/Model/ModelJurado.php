<?php
/**
 * Created by PhpStorm.
 * User: root
 * Date: 02/11/16
 * Time: 04:15 AM
 */

namespace Application\Model;


use Zend\Db\Adapter\Adapter;

class ModelJurado implements InterfaceModel
{

    public $dbAdapter;
    
    public function __construct(Adapter $adapter)
    {
        $this->dbAdapter = $adapter;
    }

    public function fetchAll()
    {
        $sql = sprintf("SELECT * FROM view_jurado");
        $statement = $this->dbAdapter->query($sql);
        $results = $statement->execute();
        $list = array();
        foreach ($results as $r){
            $list[] = $r;
        }
        return $list;
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
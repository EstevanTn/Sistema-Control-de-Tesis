<?php
/**
 * Created by PhpStorm.
 * User: root
 * Date: 02/11/16
 * Time: 01:18 AM
 */

namespace Application\Model;


use Zend\Db\Adapter\Adapter;

class ModelAsesor implements InterfaceModel
{

    public $dbAdapter;

    public function __construct(Adapter $adapter)
    {
        $this->dbAdapter = $adapter;
    }

    public function fetchAll()
    {
        $sql = sprintf("SELECT * FROM asesoria");
        $statement = $this->dbAdapter->query($sql);
        $results = $statement->execute();
        $list =array();
        foreach ($results as $row){
            $list[] = $row;
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
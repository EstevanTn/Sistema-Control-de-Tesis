<?php
/**
 * Created by PhpStorm.
 * User: tnqsoft
 * Date: 31/10/16
 * Time: 06:29 PM
 */

namespace Application\Model;


use Zend\Db\Adapter\Adapter;

class ModelUsuario implements InterfaceModel
{

    public $dbAdapter;

    public function __construct(Adapter $adapter)
    {
        $this->dbAdapter = $adapter;
    }

    public function fetchAll()
    {
        $sql = "SELECT * FROM view_usuario";
        $statement = $this->dbAdapter->query($sql);
        $results = $statement->execute();
        $list = array();
        foreach ($results as $item){
            $list[] = $item;
        }
        return $list;
    }

    public function insert()
    {

    }

    public function update()
    {

    }

    public function delete($id)
    {

    }

    public function get($id)
    {

    }

    public function search(array $data)
    {
        // TODO: Implement search() method.
    }
}
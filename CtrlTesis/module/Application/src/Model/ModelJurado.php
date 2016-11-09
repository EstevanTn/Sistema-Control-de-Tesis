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

    public function insert(){
        $response = array();
        $response['post'] = false;
        if(isset($_POST['submit'])){
            $response['post'] = true;
            $codigo = $_POST['codigo'];
            $sql = sprintf("CALL pa_insert_jurado()");
            $statement = $this->dbAdapter->query($sql);
            $result = $statement->execute();

        }
        return $response;
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
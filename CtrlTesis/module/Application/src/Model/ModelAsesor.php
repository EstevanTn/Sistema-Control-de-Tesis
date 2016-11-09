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
        $statement = $this->dbAdapter->query("SELECT * FROM view_asesor");
        $results = $statement->execute();
        $list = array();
        foreach ($results as $item){
            $list[] = $item;
        }
        return $list;
    }

    public function insert()
    {
        $response = array();
        $response['post'] = false;
        if(isset($_POST['submit'])){
            $response['post'] = true;
            $codigo = $_POST['codigo'];
            $sql = sprintf("CALL insert_asesor()");
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
        $response = array();
        $response['post'] = false;
        if(isset($_POST['submit'])){
            $response['post'] = true;
            $codigo = $_POST['codigo'];
            $sql = sprintf("CALL insert_asesor()");
            $statement = $this->dbAdapter->query($sql);
            $result = $statement->execute();

        }
        return $response;
    }

    public function search(array $data)
    {
        // TODO: Implement search() method.
    }
    
    
    public function alumnos($key){
        $statement = $this->dbAdapter->query("call pa_listar_asesorados('".$key."')");
        $results = $statement->execute();
        $list = array();
        foreach ($results as $item){
            $list[] = $item;
        }
        return $list;
    }
    
}
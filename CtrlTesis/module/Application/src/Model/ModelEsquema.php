<?php
/**
 * Created by PhpStorm.
 * User: tnqsoft
 * Date: 30/10/16
 * Time: 06:58 PM
 */

namespace Application\Model;


use Zend\Db\Adapter\Adapter;

class ModelEsquema implements InterfaceModel
{
    
    public $dbAdapter;
    
    public function __construct(Adapter $adapter)
    {
        $this->dbAdapter = $adapter;
    }
    
    public function fetchAll(){
        $statement = $this->dbAdapter->query("SELECT * FROM view_esquema  ORDER BY tram_id DESC");
        $results = $statement->execute();
        $list = array();
        foreach ($results as $item){
            $list[] = $item;
        }
        return $list;
    }
    
    public function insert(){
        
        
    }

    public function delete($id)
    {

    }

    public function update()
    {

    }

    public function get($id)
    {
        $sql = sprintf("SELECT * FROM view_esquema WHERE tram_id=%s", $id);
        $statement = $this->dbAdapter->query($sql);
        $results = $statement->execute();
        $row = array();
        foreach ($results as $r){
            $row = $r;
        }
        return $row;
    }

    public function search(array $data)
    {
        // TODO: Implement search() method.
    }
}
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

    }
    
}
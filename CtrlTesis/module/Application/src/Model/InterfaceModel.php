<?php
/**
 * Created by PhpStorm.
 * User: tnqsoft
 * Date: 30/10/16
 * Time: 07:05 PM
 */

namespace Application\Model;


use Zend\Db\Adapter\Adapter;

interface InterfaceModel
{
    
    public function __construct(Adapter $adapter);

    public function fetchAll();
    
    public function insert();
    
    public function update();
    
    public function delete($id);
    
    public function get($id);
    
}
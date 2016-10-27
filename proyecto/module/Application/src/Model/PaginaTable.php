<?php
/**
 * Created by PhpStorm.
 * User: tnqsoft
 * Date: 26/10/16
 * Time: 06:17 PM
 */

namespace Application\Model;


use Zend\Db\TableGateway\TableGatewayInterface;

class PaginaTable
{

    public $tableGateway;

    public function __construct(TableGatewayInterface $tableGatewayInterface)
    {
        $this->tableGateway = $tableGatewayInterface;
    }

    public function getAuthPages(){
        $idRol = AuthSession::get('rol_id');
        $result = $this->tableGateway->select(['tipo_usu_id' => $idRol, 'pag_estado' => '1', 'pag_padre' => null ]);
        $list = array();
        foreach ($result as $key => $row){
            $sub_list = null;
            if($row->cantidad>0){
                $sub_list = $this->tableGateway->select(['tipo_usu_id' => $idRol,'pag_padre' => $row->id, 'pag_estado' => '1' ]);
            }
            $list[] = [
                'item' => $row,
                'list' => $sub_list
            ];
        }
        return $list;
    }

}
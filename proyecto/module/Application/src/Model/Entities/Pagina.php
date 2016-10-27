<?php
/**
 * Created by PhpStorm.
 * User: tnqsoft
 * Date: 25/10/16
 * Time: 03:31 AM
 */

namespace Application\Model\Entities;


class Pagina
{

    public $id;
    public $nombre;
    public $icono;
    public $url;
    public $padre;
    public $estado;
    public $tipo_usu;
    public $cantidad;

    public function exchangeArray($data)
    {
        $this->id = !empty($data['pag_id'])?$data['pag_id']:0;
        $this->nombre = !empty($data['pag_nombre'])?$data['pag_nombre']:'';
        $this->icono = !empty($data['pag_icono'])?$data['pag_icono']:'';
        $this->url = !empty($data['pag_url'])?$data['pag_url']:'';
        $this->padre = !empty($data['pag_padre'])?$data['pag_padre']:0;
        $this->estado = !empty($data['pag_estado'])?$data['pag_estado']:false;
        $this->tipo_usu = !empty($data['tipo_usu_id'])?$data['tipo_usu_id']:0;
        $this->cantidad = !empty($data['pag_cantidad'])?$data['pag_cantidad']:0;
    }


}
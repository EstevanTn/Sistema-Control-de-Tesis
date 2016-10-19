<?php

namespace Application\Model\Entities;


class Esquema
{
    public $tram_id;
    public $titulo;
    public $keyswords;
    public $objPrincipales;
    public $objSecundarios;
    public $resumen;
    public $estado;
    public $fecha;
    public $usu_id;
    public $estudiante;

    public function exchangeArray(array $data){
        $this->tram_id = !empty($data['tram_id'])?$data['tram_id']:0;
        $this->titulo = !empty($data['titulo_tesis'])?$data['titulo_tesis']:'';
        $this->keyswords = !empty($data['keyswords'])?$data['keyswords']:'';
        $this->objPrincipales = !empty($data['obj_pri'])?$data['obj_pri']:'';
        $this->objSecundarios = !empty($data['obj_sec'])?$data['obj_sec']:0;
        $this->resumen = !empty($data['resumen'])?$data['resumen']:'';
        $this->estado = !empty($data['esq_estado'])?$data['esq_estado']:'PRESENTADO';
        $this->fecha = !empty($data['esq_fecha'])?$data['esq_fecha']:date();
        $this->usu_id = !empty($data['usu_id'])?$data['usu_id']:0;
        $this->estudiante = !empty($data['per_nombre'])?sprintf('%s %s %s',$data['per_nombre'],$data['per_ape_pat'],$data['per_ape_mat']):'';
    }
}
<?php

namespace Application\Model\Entities;


class Jurado extends Persona
{
    public $jur_id;
    public $doc_codigo;
    public $tipo_jurado;
    public $car_id;
    public $car_nombre;
    public $car_descripcion;

    public function exchangeArray($data){
        $this->jur_id = !empty($data['jur_id'])?$data['jur_id']:0;
        $this->doc_codigo = !empty($data['doc_codigo'])?$data['doc_codigo']:'';
        $this->tipo_jurado = !empty($data['tipo_jurado'])?$data['tipo_jurado']:'';
        $this->car_id = !empty($data['car_id'])?$data['car_id']:0;
        $this->car_nombre = !empty($data['car_nombre'])?$data['car_nombre']:'';
        $this->car_descripcion = !empty($data['car_descripcion'])?$data['car_descripcion']:'';
    }



}
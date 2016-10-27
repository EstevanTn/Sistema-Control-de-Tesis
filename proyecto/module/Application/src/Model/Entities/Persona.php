<?php
/**
 * Created by PhpStorm.
 * User: tnqsoft
 * Date: 27/10/16
 * Time: 06:10 AM
 */

namespace Application\Model\Entities;


class Persona
{

    public $per_id;
    public $per_dni;
    public $per_nombre;
    public $per_ape_pat;
    public $per_ape_mat;
    public $per_direccion;
    public $per_telefono;
    public $per_email;
    public $per_fecha_nac;
    public $per_fecha_reg;

    public function exchangeArray($data){
        $this->per_id = !empty($data['per_id'])?$data['per_id']:0;
        $this->per_dni = !empty($data['per_dni'])?$data['per_dni']:'';
        $this->per_nombre = !empty($data['per_nombre'])?$data['per_nombre']:'';
        $this->per_ape_pat = !empty($data['per_ape_pat'])?$data['per_ape_pat']:'';
        $this->per_ape_mat = !empty($data['per_ape_mat'])?$data['per_ape_mat']:'';
        $this->per_direccion = !empty($data['per_direccion'])?$data['per_direccion']:'';
        $this->per_telefono = !empty($data['per_telefono'])?$data['per_telefono']:'';
        $this->per_email = !empty($data['per_email'])?$data['per_email']:'';
        $this->per_fecha_nac = !empty($data['per_fecha_nac'])?$data['per_fecha_nac']:'';
        $this->per_fecha_reg = !empty($data['per_fecha_reg'])?$data['per_fecha_reg']:'';
    }

}
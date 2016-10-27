<?php
/**
 * Created by PhpStorm.
 * User: tnqsoft
 * Date: 19/10/16
 * Time: 01:16 PM
 */

namespace Application\Model\Entities;


class Estudiante
{
    public $codigo;
    public $nombres;
    public $apePaterno;
    public $apeMaterno;
    public $estado;
    public $dni;
    public $per_id;
    public $direccion;
    public $telefono;
    public $fecha_nac;
    public $fecha_reg_pers;
    public $email;

    public function exchangeArray($data){
        $this->codigo = !empty($data['est_codigo'])?$data['est_codigo']:'';
        $this->dni = !empty($data['per_dni'])?$data['per_dni']:'';
        $this->nombres = !empty($data['per_nombre'])?$data['per_nombre']:'';
        $this->apePaterno = !empty($data['per_ape_pat'])?$data['per_ape_pat']:'';
        $this->apeMaterno = !empty($data['per_ape_mat'])?$data['per_ape_mat']:'';
        $this->direccion = !empty($data['per_direccion'])?$data['per_direccion']:'';
        $this->telefono = !empty($data['per_telefono'])?$data['per_telefono']:'';
        $this->fecha_nac= !empty($data['per_fecha_nac'])?$data['per_fecha_nac']:'';
        $this->fecha_reg_pers = !empty($data['per_fecha_reg'])?$data['per_fecha_reg']:'';
        $this->per_id = !empty($data['per_id'])?$data['per_id']:'';
        $this->estado = !empty($data['per_estado'])?$data['per_estado']:false;
        $this->email = !empty($data['per_email'])?$data['per_email']:'';

    }

}
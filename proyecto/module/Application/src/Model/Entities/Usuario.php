<?php
namespace Application\Model\Entities;


class Usuario
{
    public $id;
    public $login;
    public $password;
    public $estado;
    public $per_id;
    public $tipo_id;
    public $nombres;
    public $tipo_nombre;

    public function exchangeArray(array $data){
        $this->id = !empty($data['usu_id']) ? $data['usu_id'] : 0;
        $this->login = !empty($data['usu_login']) ? $data['usu_login'] : '';
        $this->password = !empty($data['usu_password']) ? $data['usu_password'] : '';
        $this->estado = !empty($data['usu_estado']) ? $data['usu_estado'] : 'A';
        $this->per_id = !empty($data['per_id']) ? $data['per_id'] : 0;
        $this->tipo_id = !empty($data['tipo_usu_id']) ? $data['tipo_usu_id'] : 4;
        $this->tipo_nombre = !empty($data['tipo_usu_nombre']) ? $data['tipo_usu_nombre'] : 'ESTUDIANTE';
        $this->nombres = !empty($data['nombres']) ? $data['nombres'] : '';
    }
}
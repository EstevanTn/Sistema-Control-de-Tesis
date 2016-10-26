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

    public function exchangeArray($data){
        
    }

}
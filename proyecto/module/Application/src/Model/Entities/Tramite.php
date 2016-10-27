<?php
/**
 * Created by PhpStorm.
 * User: tnqsoft
 * Date: 27/10/16
 * Time: 07:10 AM
 */

namespace Application\Model\Entities;


class Tramite
{
    
    public $tram_id;
    public $est_codigo;
    public $pag_codigo;
    public $tram_fecha_reg;
    
    public function exchangeArray($data){
        $this->tram_id =!empty($data['tram_id'])?$data['tram_id']:0;
        $this->est_codigo =!empty($data['est_codigo'])?$data['est_codigo']:'';
        $this->pag_codigo =!empty($data['pag_codigo'])?$data['pag_codigo']:'';
        $this->tram_fecha_reg =!empty($data['tram_fecha_reg'])?$data['tram_fecha_reg']:'';
    }
    
}
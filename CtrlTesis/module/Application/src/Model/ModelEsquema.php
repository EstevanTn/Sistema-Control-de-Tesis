<?php

namespace Application\Model;


use Zend\Db\Adapter\Adapter;

class ModelEsquema implements InterfaceModel
{
    
    public $dbAdapter;
    
    public function __construct(Adapter $adapter)
    {
        $this->dbAdapter = $adapter;
    }
    
    public function fetchAll(){
        $statement = $this->dbAdapter->query("SELECT * FROM view_esquema  ORDER BY tram_id DESC");
        $results = $statement->execute();
        $list = array();
        foreach ($results as $item){
            $list[] = $item;
        }
        return $list;
    }
    
    public function insert(){
        $response = array();
        $response['post'] = false;
        if(isset($_POST['submit'])){
            $response['post'] = true;
            $tramite = $_POST['tramite'];
            $titulo = $_POST['tituloTesis'];
            $palabras = $_POST['palabrasClaves'];
            $objP = $_POST["objPrincipales"];
            $objS = $_POST["objSecundarios"];
            $resumen = $_POST['resumen'];
            $estado = $_POST["estado"];
            $usuario = AuthSession::get('id');
            try{
                $sql = sprintf("CALL pa_InsertEsquema('%s', '%s','%s','%s','%s', '%s', '%s', '%s')",
                    $tramite, $titulo, $palabras, $objP, $objS, $resumen, $estado, $usuario);
                $statement = $this->dbAdapter->query($sql);
                $result = $statement->execute();
                if($result){
                    $response['mensaje'] = 'Se ha guardado Correctamente el nuevo esquema.';
                    $response['estado'] = true;
                }else{
                    $response['mensaje'] = 'Error al intentar insertar el nuevo esquema';
                    $response['estado'] = false;
                }
            }catch (\Exception $ex){
                $response['mensaje'] = $ex->getMessage();
                $response['estado'] = false;
            }
        }
        return $response;
    }

    public function delete($id)
    {

    }

    public function update()
    {

    }

    public function get($id)
    {
        $sql = sprintf("SELECT * FROM view_esquema WHERE tram_id=%s", $id);
        $statement = $this->dbAdapter->query($sql);
        $results = $statement->execute();
        $row = array();
        foreach ($results as $r){
            $row = $r;
        }
        return $row;
    }

    public function search(array $data)
    {
        // TODO: Implement search() method.
    }
}
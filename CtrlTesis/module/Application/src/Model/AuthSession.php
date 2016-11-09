<?php
/**
 * Created by PhpStorm.
 * User: tnqsoft
 * Date: 26/10/16
 * Time: 07:11 PM
 */

namespace Application\Model;


use Zend\Db\Adapter\Adapter;

class AuthSession
{
    
    public static function AuthSession(Adapter $dbAdapter,$postUsername='username', $postPassword='password'){
        if(isset($_POST[$postUsername]) and isset($_POST[$postPassword])){
            $sql = sprintf("call pa_verificarLogin('%s', '%s')", $_POST[$postUsername], $_POST[$postPassword]);
            $statement = $dbAdapter->query($sql);
            $results = $statement->execute();
            if($results->count()==1){
                $dataSession = array();
                foreach ($results as $key => $value){
                    $dataSession = [
                        'id' => $value['usu_id'],
                        'username' => $value['usu_login'],
                        'rol_id' => $value['tipo_usu_id'],
                        'rol' => $value['tipo_usu_nombre'],
                        'nombres' => $value['nombres']
                    ];
                }
                $_SESSION[SESSION_NAME] = $_POST[$postUsername];
                setcookie(COOKIE_NAME, json_encode($dataSession));
                return true;
            }else{
                return false;
            }
        }else{
            return isset($_SESSION[SESSION_NAME]);
        }
    }

    public static function getAuthPages(Adapter $dbAdapter){
        $idRol = self::get('rol_id');
        $sql = sprintf("SELECT * FROM pagina WHERE tipo_usu_id='%s' AND pag_estado=1 AND ISNULL(pag_padre)=1 ORDER BY pag_nombre ASC", $idRol);
        $statement = $dbAdapter->query($sql);
        $results = $statement->execute();
        foreach ($results as $key => $row){
            $sub_list = array();
            if($row['pag_cantidad']>0){
                $subSql = sprintf("SELECT * FROM pagina WHERE tipo_usu_id='%s' AND pag_estado=1 AND pag_padre='%s'", $idRol, $row['pag_id']);
                $statement = $dbAdapter->query($subSql);
                $results2 = $statement->execute();
                foreach ($results2 as $item){
                    $sub_list[] = $item;
                }
            }
            $list[] = [
                'item' => $row,
                'list' => $sub_list
            ];
        }
        return $list;
    }

    public static function CookieUser(){
        return json_decode($_COOKIE[COOKIE_NAME]);
    }

    public static function get($name){
        return self::CookieUser()->$name;
    }

}
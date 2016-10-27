<?php
/**
 * Created by PhpStorm.
 * User: tnqsoft
 * Date: 26/10/16
 * Time: 07:11 PM
 */

namespace Application\Model;


class AuthSession
{
    
    public static function AuthSession(UsuarioTable $table,$postUsername='username', $postPassword='password'){
        
        $dataResult = $table->authLogin($_POST[$postUsername], $_POST[$postPassword]);
        if($dataResult['sessionAuth']){
            $_SESSION[SESSION_NAME] = $_POST['username'];
            $dataSession = array();
            foreach ($dataResult['resultSet'] as $key => $value){
                $dataSession = [
                    'id' => $value->id,
                    'username' => $value->login,
                    'rol_id' => $value->tipo_id,
                    'rol' => $value->tipo_nombre,
                    'nombres' => $value->nombres
                ];
            }
            setcookie(COOKIE_NAME, json_encode($dataSession));
            return true;
        }
        return false;
    }

    public static function Session(){
        return isset($_SESSION[SESSION_NAME]);
    }

    public static function CookieUser(){
        return json_decode($_COOKIE[COOKIE_NAME]);
    }

    public static function get($name){
        return self::CookieUser()->$name;
    }

}
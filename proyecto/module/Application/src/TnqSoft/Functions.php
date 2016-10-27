<?php
/**
 * Created by PhpStorm.
 * User: tnqsoft
 * Date: 18/10/16
 * Time: 06:25 PM
 */

namespace Application\TnqSoft;

class Functions
{

    public static function createPagination($table,$id='pagination', $limit=10){
        $total = count($table->select());
        $start = $total;
        $pages = ceil($total/$limit);
        if(isset($_GET['pag'])){
            //$start = (((int)$_GET['pag'])-1)*$limit;
            $page = $_GET['pag'];
            if($_GET['pag']==1){
                $start = $total;
            }else{
                $start = $total-(($page*$limit)-$limit);
            }
        }
        $html = '<select class="form-control" id="'.$id.'" >';
        for($i=1;$i<=$pages;$i++){
            $html .= '<option value="'.$i.'">Pág. '.$i.'</option>';
        }
        $html .= '';
        $html .= '</select>';

        $paginateHtml = '<div class="row-fluid">
            <div class="span6">
            <div class="pull-left">
                <h3 id="title-pages"></h3>
            </div>
</div>
    <div class="span6">
    <div class="pull-right">
        <div class="input-prepend input-append">
            <div class="add-on"><b>Ir</b></div>
            '.$html.'
        </div>

    </div>
</div>
</div>';
        
        define('PAGINATION_HTML', $paginateHtml);
        define('PAGINATION_START', $start);
        define('PAGINATION_PAGES', $pages);
    }
    
    
    public static function getPaginacion(){
        return defined('PAGINATION_HTML')?PAGINATION_HTML:'';
    }
    
}
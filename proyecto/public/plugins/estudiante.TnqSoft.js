var Estudiante = (function () {
    var basePath;
    return{
        elegir: function (key) {
            var row = document.querySelectorAll('tr[data-item="'+key+'"]')[0];
            var items = row.children;
            $('[name=codigo]').val(items[0].innerHTML);
            $('[name=dni]').val(items[1].innerHTML);
            $('[name=nombres]').val(items[2].innerHTML);
            $('[name=apellidos]').val(items[3].innerHTML);
            $('[name=direccion]').val(items[4].innerHTML);
            $('[name=fecha_nac]').val(items[6].innerHTML);
            basePath = $('#btn-buscar-tramite').attr('data-href');
            
        }

    }
}());
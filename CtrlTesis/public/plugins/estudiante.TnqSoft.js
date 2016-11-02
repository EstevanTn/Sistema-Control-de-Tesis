var Estudiante = (function () {
    var instance;
    return{
        elegir: function (key) {
            var row = document.querySelectorAll('tr[data-item="'+key+'"]')[0];
            var items = row.children;
            instance = {
                codigo: items[0].innerHTML,
                dni: items[1].innerHTML,
                nombres: items[2].innerHTML,
                apellidos: items[3].innerHTML,
                direccion: items[4].innerHTML,
                fecha_nac: items[6].innerHTML
            };
            this.loadInfo();
        },
        instance: instance,
        loadInfo: function () {
            $('[name=codigo]').val(instance.codigo);
            $('[name=dni]').val(instance.dni);
            $('[name=nombres]').val(instance.nombres);
            $('[name=apellidos]').val(instance.apellidos);
            $('[name=direccion]').val(instance.direccion);
            $('[name=fecha_nac]').val(instance.fecha_nac);
        },
        nroTramite: function (key) {
            console.log(key);
            $('[name=tramite]').val(key);
        }
    }
}());
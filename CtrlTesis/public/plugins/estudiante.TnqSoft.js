var Estudiante = (function () {
    var instance;
    return{
        elegir: function (codigo, dni, nombres, apellidos, direccion, fecha) {
            instance = {
                codigo: codigo,
                dni: dni,
                nombres: nombres,
                apellidos: apellidos,
                direccion: direccion,
                fecha_nac: fecha
            };
            this.loadInfo();

        },
        instance: instance,
        loadInfo: function () {
            $('#btn-buscar-tramite').attr('data-href', $('#btn-buscar-tramite').attr('data-base')+'/tramite/tramiteestudiante/'+instance.codigo);
            $('[name=codigo]').val(instance.codigo);
            $('[name=dni]').val(instance.dni);
            $('[name=nombres]').val(instance.nombres);
            $('[name=apellidos]').val(instance.apellidos);
            $('[name=direccion]').val(instance.direccion);
            $('[name=fecha_nac]').val(instance.fecha_nac);
        },
        nroTramite: function (key) {
            $('[name=tramite]').val(key);
        }
    }
}());
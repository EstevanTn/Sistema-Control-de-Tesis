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
            console.log(instance);
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
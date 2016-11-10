var Persona = (function () {
    var instance;
    return{
        elegir: function (codigo, dni, nombres, apepat, apemat, direccion, fecha) {
            instance = {
                codigo: codigo,
                dni: dni,
                nombres: nombres,
                apepat: apepat,
                apemat:apemat,
                direccion: direccion,
                fecha_nac: fecha
            };
            this.loadInfo();

        },
        instance: instance,
        loadInfo: function () {
            
            $('[name=codigo]').val(instance.codigo);
            $('[name=dni]').val(instance.dni);
            $('[name=nombres]').val(instance.nombres);
            $('[name=apepat]').val(instance.apepat);
            $('[name=apemat]').val(instance.apemat);
            $('[name=direccion]').val(instance.direccion);
            $('[name=fecha_nac]').val(instance.fecha_nac);
        },
       
    }
}());
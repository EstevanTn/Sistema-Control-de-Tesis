var Docente = (function () {
    var instance;
    return{
        elegir: function (codigo, nombre, apepat, apemat) {
            instance = {
                codigo: codigo,
                nombre: nombre,
                apepat: apepat,
                apemat: apemat

            };
            this.loadInfo();

        },
        instance: instance,
        loadInfo: function () {
            $('[name=codigo]').val(instance.codigo);
            $('[name=nombre]').val(instance.nombre);
            $('[name=apepat]').val(instance.apepat);
            $('[name=apemat]').val(instance.apemat);

        },

    }
}());
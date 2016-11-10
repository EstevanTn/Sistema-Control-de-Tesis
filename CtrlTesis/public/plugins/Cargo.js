var Cargo = (function () {
    var instance;
    return{
        elegir: function (codigo, nombre) {
            instance = {
                codigo: codigo,
                nombre: nombre,

            };
            this.loadInfo();

        },
        instance: instance,
        loadInfo: function () {
            $('[name=codigoca]').val(instance.codigo);
            $('[name=nombreca]').val(instance.nombre);

        },

    }
}());
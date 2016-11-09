var Evaluacion = (function () {
    var instance;
    return{
        elegir: function (codigo, estado) {
            instance = {
                codigo: codigo,
                estado: estado,
            };
            this.loadInfo();

        },
        instance: instance,
        loadInfo: function () {
            $('[name=codigoeva]').val(instance.codigo);
            $('[name=estado]').val(instance.estado);

        },

    }
}());
var Evaluacion = (function () {
    var instance;
    return{
        elegir: function (codigo) {
            instance = {
                codigo: codigo,

            };
            this.loadInfo();

        },
        instance: instance,
        loadInfo: function () {
            $('[name=codigoeva]').val(instance.codigo);

        },

    }
}());
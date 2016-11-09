var Asesoria = (function () {
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
            $('[name=codigo]').val(instance.codigo);

        },

    }
}());
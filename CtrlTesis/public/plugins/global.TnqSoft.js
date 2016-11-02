var Global = (function(){
    return{
        HttpRequest: function (formSelector) {
            $(formSelector).submit(function (e) {
                e.preventDefault();
                var data = $(formSelector).serialize();
                data = TNQSOFT.queryStringToJSON(data);
                $.ajax({
                    url: $(this).attr('action'),
                    type: $(this).attr('method'),
                    //dataType: 'json',
                    data: data,
                    //processData: false,
                    //contentType: false,
                    success: function (response) {
                        $(formSelector).after(response);
                    },
                    error: function (response,status, xhr) {
                        console.error(status);
                    }
                });
            });
        }
    }
}());


var modalEvents = function (modal) {
    console.log(modal);
    jQuery("table").dataTable({
        language: {
            "sProcessing":    "Procesando...",
            "sLengthMenu":    "Mostrar _MENU_ registros",
            "sZeroRecords":   "No se encontraron resultados",
            "sEmptyTable":    "Ningún dato disponible en esta tabla",
            "sInfo":          "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
            "sInfoEmpty":     "Mostrando registros del 0 al 0 de un total de 0 registros",
            "sInfoFiltered":  "(filtrado de un total de _MAX_ registros)",
            "sInfoPostFix":   "",
            "sSearch":        "Buscar: ",
            "sUrl":           "",
            "sInfoThousands":  ",",
            "sLoadingRecords": "Cargando...",
            "oPaginate": {
                "sFirst":    "Primero ",
                "sLast":    "Último ",
                "sNext":    "Siguiente ",
                "sPrevious": "Anterior "
            },
            "oAria": {
                "sSortAscending":  ": Activar para ordenar la columna de manera ascendente",
                "sSortDescending": ": Activar para ordenar la columna de manera descendente"
            }
        }
    });
};
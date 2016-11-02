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

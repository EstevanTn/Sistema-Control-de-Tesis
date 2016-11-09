(function Validation(_p) {

    function init() {
        _p.each('input[type="text"]', function () {
            var e = this.srcElement;
            var validate = e.getAttribute('validate');
            switch(validate){
                case 'dni': validateDni(e);
                    break;
                default:
                    break;
            }
        });
    }
    
    function validateDni(element) {
        element.setAttribute('maxlength',8);
        element.addEventListener('keypress', function (e) {
            console.log(e);
        });
    }


    init();

}(TNQSOFT));
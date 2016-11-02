(function(window){
    
    var rootContainer;
    var instance = function(){};
    var Base64 = {
        // private property
        _keyStr : "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",
        // public method for encoding
        encode : function (input) {
            var output = "";
            var chr1, chr2, chr3, enc1, enc2, enc3, enc4;
            var i = 0;
            input = Base64._utf8_encode(input);
            while (i < input.length) {
                chr1 = input.charCodeAt(i++);
                chr2 = input.charCodeAt(i++);
                chr3 = input.charCodeAt(i++);
                enc1 = chr1 >> 2;
                enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
                enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
                enc4 = chr3 & 63;
                if (isNaN(chr2)) {
                    enc3 = enc4 = 64;
                } else if (isNaN(chr3)) {
                    enc4 = 64;
                }
                output = output +
                this._keyStr.charAt(enc1) + this._keyStr.charAt(enc2) +
                this._keyStr.charAt(enc3) + this._keyStr.charAt(enc4);

            }
            return output;
        },
        // public method for decoding
        decode : function (input) {
            var output = "";
            var chr1, chr2, chr3;
            var enc1, enc2, enc3, enc4;
            var i = 0;
            input = input.replace(/[^A-Za-z0-9\+\/\=]/g, "");
            while (i < input.length) {
                enc1 = this._keyStr.indexOf(input.charAt(i++));
                enc2 = this._keyStr.indexOf(input.charAt(i++));
                enc3 = this._keyStr.indexOf(input.charAt(i++));
                enc4 = this._keyStr.indexOf(input.charAt(i++));
                chr1 = (enc1 << 2) | (enc2 >> 4);
                chr2 = ((enc2 & 15) << 4) | (enc3 >> 2);
                chr3 = ((enc3 & 3) << 6) | enc4;
                output = output + String.fromCharCode(chr1);
                if (enc3 != 64) {
                    output = output + String.fromCharCode(chr2);
                }
                if (enc4 != 64) {
                    output = output + String.fromCharCode(chr3);
                }
            }
            output = Base64._utf8_decode(output);
            return output;
        },

        // private method for UTF-8 encoding
        _utf8_encode : function (string) {
            string = string.replace(/\r\n/g,"\n");
            var utftext = "";
            for (var n = 0; n < string.length; n++) {
                var c = string.charCodeAt(n);
                if (c < 128) {
                    utftext += String.fromCharCode(c);
                }
                else if((c > 127) && (c < 2048)) {
                    utftext += String.fromCharCode((c >> 6) | 192);
                    utftext += String.fromCharCode((c & 63) | 128);
                }
                else {
                    utftext += String.fromCharCode((c >> 12) | 224);
                    utftext += String.fromCharCode(((c >> 6) & 63) | 128);
                    utftext += String.fromCharCode((c & 63) | 128);
                }
            }
            return utftext;
        },
        // private method for UTF-8 decoding
        _utf8_decode : function (utftext) {
            var string = "";
            var i = 0;
            var c = c1 = c2 = 0;
            while ( i < utftext.length ) {
                c = utftext.charCodeAt(i);
                if (c < 128) {
                    string += String.fromCharCode(c);
                    i++;
                }
                else if((c > 191) && (c < 224)) {
                    c2 = utftext.charCodeAt(i+1);
                    string += String.fromCharCode(((c & 31) << 6) | (c2 & 63));
                    i += 2;
                }
                else {
                    c2 = utftext.charCodeAt(i+1);
                    c3 = utftext.charCodeAt(i+2);
                    string += String.fromCharCode(((c & 15) << 12) | ((c2 & 63) << 6) | (c3 & 63));
                    i += 3;
                }
            }
            return string;
        }
    }
    
    var TNQSOFT = (function(){
        var plugins = {}, data;
        _prototypeInstance();
        return {
            initialize: initialize,
            /**
             * Esta función se ejecuta despues de cargar el documento.
             * @param {[function]} customTrigger [Se ejecuta despues de cargar el documento]
             * @param {[Number]} timeOut       [Tiempo de espera despues de cargar el documento: default=300ms]
             * @param {[function]} beforeLoading [Se ejecuta antes de haber cargado el documento]
             */
            onload: function load(customTrigger, timeOut,beforeLoading){
                timeOut = timeOut?timeOut:300;
                if(beforeLoading){ beforeLoading(); }
                var f = customTrigger;
                f.prototype = instance.prototype;
                f.prototype._super = this;
                f.prototype.timeOut = timeOut;
                f.prototype.ROOT_CONTAINER = rootContainer;
                onload(customTrigger, timeOut);
            },
            onresize: function(customTrigger){
                var f = customTrigger;
                f.prototype = instance.prototype;
                f.prototype._super = this;
                f.prototype.ROOT_CONTAINER = rootContainer;
                onresize(customTrigger);
            },
            addPlugin: function(name, customTrigger, isProperty){
                if(isProperty){this.prop(name,customTrigger)};
                plugins[name] = customTrigger;
            },
            add: add,
            data: data,
            prop: prop,
            PLUGINS: plugins,
            each: each,
            jsonToQueryString: jsonToQueryString,
            queryStringToJSON: queryStringToJSON,
            jsonConcat: jsonConcat,
            httpAsync: httpAsync,
            fadeOut: fadeOut,
            fadeIn: fadeIn,
            fadeInEffect: fadeInEffect,
            fadeOutEffect: fadeOutEffect,
            getParameterByName: getParameterByName,
            Base64: Base64
        }
    }());

    function getParameterByName(name, url) {
        if (!url) url = window.location.href;
        name = name.replace(/[\[\]]/g, "\\$&");
        var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
            results = regex.exec(url);
        if (!results) return null;
        if (!results[2]) return '';
        return decodeURIComponent(results[2].replace(/\+/g, " "));
    }
    
    function _prototypeInstance(){
        instance.prototype.jsonConcat = jsonConcat;
        instance.prototype.randomString = randomString;
        instance.prototype.each = each;
    }
    
    /**
     * Crea un contenedor global para ejecutar los scripts extensiones.
     */
    function initialize(){
        if(!TNQSOFT.ROOT_CONTAINER){
            rootContainer = document.createElement('div');
            rootContainer.id = "TNQSOFT";
            rootContainer.style.display="none";
            var key = randomString();
            rootContainer.setAttribute('client-code',key);
            instance.prototype.clientCode = key;
            TNQSOFT.clientCode = key;
        }
        windowSizeDetect();
        window.addEventListener('DOMContentLoaded', function(){
            document.body.insertBefore(rootContainer,document.body.firstChild);
        });
        addStyles();
    }
    
    function addStyles(){
        var styles = document.createElement('style');
        styles.innerHTML = '.spin{width:auto;height:auto;text-align:center;margin:auto;-webkit-animation:spin 1s linear infinite;-moz-animation:spin 1s linear infinite;animation:spin 1s linear infinite}@-moz-keyframes spin{100%{-moz-transform:rotate(360deg)}}@-webkit-keyframes spin{100%{-webkit-transform:rotate(360deg)}}@keyframes spin{100%{-webkit-transform:rotate(360deg);transform:rotate(360deg)}}.fade-scale{transform:scale(0);opacity:0;-webkit-transition:all .25s linear;-o-transition:all .25s linear;transition:all .25s linear}.fade-scale.in{opacity:1;transform:scale(1)}.fade-scale.out{opacity:0;transform:scale(0)}';
        TNQSOFT.ROOT_CONTAINER.appendChild(styles);
    }
    
    function onload(customTrigger, timeOut){
        window.addEventListener('load', function(e){
            windowSizeDetect();
            setTimeout(function(){
                new customTrigger(e,rootContainer,this);
            },timeOut);
        });
        window.addEventListener('resize', function(e){
            windowSizeDetect();
        });
    }
    
    function onresize( customTrigger){
        window.addEventListener('resize', function(e){
            windowSizeDetect();
            new customTrigger(e,rootContainer,this);
        });
    }
    
    function randomString(len, charSet) {;
        len = len ? len : 8
        charSet = charSet || 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
        var randomString = '';
        for (var i = 0; i < len; i++) {
            var randomPoz = Math.floor(Math.random() * charSet.length);
            randomString += charSet.substring(randomPoz,randomPoz+1);
        }
        return randomString;
    }

    function windowSizeDetect(){
        var myWidth = 0, myHeight = 0; 
        if( typeof( window.innerWidth ) == 'number' ) { 
            //No-IE 
            myWidth = window.innerWidth; 
            myHeight = window.innerHeight; 
        } else if( document.documentElement && ( document.documentElement.clientWidth || document.documentElement.clientHeight ) ) {
            //IE 6+ 
            myWidth = document.documentElement.clientWidth; 
            myHeight = document.documentElement.clientHeight; 
        } else if( document.body && ( document.body.clientWidth || document.body.clientHeight ) ) {
            //IE 4 compatible 
            myWidth = document.body.clientWidth;
            myHeight = document.body.clientHeight; 
        }
        instance.prototype.windowHeight = myHeight;
        instance.prototype.windowWidth = myWidth;
        rootContainer.setAttribute('window-height',myHeight);
        rootContainer.setAttribute('window-width',myWidth);
        TNQSOFT.ROOT_CONTAINER =  rootContainer;
        TNQSOFT.windowWidth = myWidth;
        TNQSOFT.windowHeight = myHeight;
    }
    
    function add(name, value){
        this[name] = value;
    }
    
    function prop(name, customTrigger){
        var obj = {};
        obj[name] = customTrigger;
        instance.prototype = jsonConcat(instance.prototype,obj);
    }
    
    function jsonConcat(objJSN1,objJSN2){
        for(var key in objJSN2){
            objJSN1[key] = objJSN2[key];
        }
        return objJSN1;
    }
    
    /**
     * Busca los elementos del selector seleccionado y ejecuta una funcion personaliada a cada elemento.
     * @param {[String||object]} querySelector [Selector]
     * @param {[function]} customTrigger [Evento que se ejecuta para cada elemento]
     */
    function each(querySelector, customTrigger){
        var elements;
        if(typeof querySelector==='string'){
            elements= document.querySelectorAll(querySelector);
        }else{
            elements = querySelector;
        }
        if(elements){
            var x =0 ;
            for(x;x<elements.length;x++){
                var func = customTrigger;
                var date = new Date();
                func.prototype.srcElement = elements[x];
                func.prototype.id = elements[x].id;
                func.prototype.name = elements[x].name?elements[x].name:'';
                func.prototype.className = elements[x].className;
                func.prototype.position = x;
                func.prototype.date = date;
                func.prototype.time = date.getTime();
                new func(elements[x],x);
            }
        }
    }
    
    /**
     * Convierte un objeto JSON a un query String
     * @param   {[Object]} json [Objecto JSON: ejem: {name: 'Alexander', edad: 23}]
     * @returns {string}   [retorna un queryString: ejem: ?name=Alexander&edad=23]
     */
    function jsonToQueryString(json) {
        return '?' + 
            Object.keys(json).map(function(key) {
                return encodeURIComponent(key) + '=' +
                    encodeURIComponent(json[key]);
            }).join('&');
    }
    
    function queryStringToJSON(queryString) {
        if(queryString.indexOf('?') > -1){
            queryString = queryString.split('?')[1];
        }
        var pairs = queryString.split('&');
        var result = {};
        pairs.forEach(function(pair) {
            pair = pair.split('=');
            result[pair[0]] = decodeURIComponent(pair[1] || '');
        });
        return result;
    }
    
    function createXMLHttpRequest(){
        var xmlHttp=null;
        if (window.ActiveXObject){ xmlHttp = new ActiveXObject("Microsoft.XMLHTTP"); }
        else if (window.XMLHttpRequest){
                     xmlHttp = new XMLHttpRequest();}
        return xmlHttp;
    }
    
    function __defaultSettingHttp(options){
        if(options.dataType===null||options.dataType===undefined){ options.dataType = 'text'; }
        if(options.type===null||options.type===undefined){ options.type = 'GET'; }
        if(options.data!==null&&options.data!==undefined&&typeof options.data==='object') { 
            options.data = jsonToQueryString(options.data).substring(1);
        }else{
            options.data = null;
        }
        options.dataType = options.dataType.toLowerCase();
        options.type = options.type.toUpperCase();
        return options;
    }
    
    function httpAsync(options){
        options = __defaultSettingHttp(options);
        var xhr = createXMLHttpRequest();
        xhr.onreadystatechange=function(){
            if(options.custom!==null&&options.custom!==undefined&&typeof options.custom==='function'){
                options.custom(xhr);
            }else{
                if (xhr.readyState == 4 && (xhr.status==200 || window.location.href.indexOf("http")==-1)){
                    if(options.dataType==='xml'){
                       options.success(xhr.responseXML)
                    }
                    if(options.dataType==='json'){
                        var Json = JSON.stringify(xhr.responseText);
                        options.success(Json);
                    }
                    if(options.dataType==='text'){
                        options.success(xhr.responseText);
                    }
                    if(options.dataType==='none'){
                        options.success(xhr.response);
                    }
                }else{
                    if(options.error!==null&&options.error!==undefined){
                        options.error(xhr.status,xhr.statusText);
                    }
                }
            }
        }
        xhr.open(options.type,options.url,true);
        xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        xhr.send(options.data);
    }
    
    function fadeOut(target, customTrigger,time, val){
        each(target,function(ele,pos){
            ele.className = 'fadeOut';
            fadeOutEffect(ele,customTrigger,time,val);
        });
    }
    
    function fadeOutEffect(ele,customTrigger,time,val){
        if(!time){ time = 90; }
        if(!val){ val = 9; }
        ele.style.opacity = '0.'+val;
        ele.style.filter = 'alpha(opacity='+val+'0)';
        if(val>1){
            val--;
            setTimeout(function(){
                fadeOutEffect(ele,customTrigger,time,val);
            },time);
        }else{
            ele.style.opacity = '0';
            ele.style.filter = 'alpha(opacity=0)';
            ele.style.display = 'none';
            if(typeof customTrigger==='function'){
                customTrigger(ele);
            }
        }
    }
    
    /**
     * Efecto fadeIn
     * @param {[String]}   target   [String selector]
     * @param {[function]} customTrigger   [Se ejecuta cuando se encuentra totalmente visible el elemento]
     * @param {[Number]}   time            [Tiempo de intervalo del efecto: default=90ms]
     * @param {[Number]}   val             [Valor de la opacidad]
     */
    function fadeIn(target, customTrigger,time, val){
        each(target,function(ele,pos){
            ele.className = 'fadeIn';
            fadeInEffect(ele,customTrigger,time,val);
        });
    }
    
    /**
     * Efecto fadeIn
     * @param {object}   ele           [Elemento DOM]
     * @param {[function]} customTrigger [Se ejecuta cuando se encuentra totalmente visible el elemento]
     * @param {[Number]} time          [Tiempo de intervalo del efecto: default=90ms]
     * @param {[Number]} val           [Valor de la opacidad]
     */
    function fadeInEffect(ele,customTrigger,time,val){
        ele.style.display = 'block';
        if(!time){ time = 90; }
        if(!val){ val = 0; }
        ele.style.opacity = '0.'+val;
        ele.style.filter = 'alpha(opacity='+val+'0)';
        if(val<9){
            val++;
            setTimeout(function(){
                fadeInEffect(ele,customTrigger,time,val)
            },time);
        }else{
            ele.style.opacity = '1';
            ele.style.filter = 'alpha(opacity=100)';
            if(typeof customTrigger==='function'){
                customTrigger(ele);
            }
        }
    }
        
    function exports(){ 
        TNQSOFT.initialize();
        window.TNQSOFT = TNQSOFT; 
    }
    
    exports();
    
    
}(window));
export var JSONFormat = { 
    run: function() {
        var raw = document.getElementById("raw").innerHTML;
        document.getElementById("raw").innerHTML = JSON.stringify(JSON.parse(raw),null,2);
    }
};

function showUser(str) {
    if (str == "") {
        document.getElementById("txtHint").innerHTML = "";
    } else {
        var xmlhttp = new XMLHttpRequest();
        xmlhttp.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                document.getElementById("txtHint").innerHTML = this.responseText;
            }
        };
        xmlhttp.open("GET", "/student070/dwes/db/ajax-db-users-select.php?q=" + str, true);
        xmlhttp.send();
    }
};
function showUser() {
    //recoger variable
    // let q = str;
    let userId = document.formData.user_id.value;

    // let dataToSend = "userId=" + userId + "&" + "q=" + q; 
    let dataToSend = "userId=" + userId; 

    console.log(userId);

    if (userId == "") {
        document.getElementById("txtHint").innerHTML = "";
    } else {
        var xmlhttp = new XMLHttpRequest();
        xmlhttp.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                let userJson = this.responseText;

                console.log(userJson);

                let user = JSON.parse(userJson);

                console.log(user);

                document.getElementById("txtHint").innerHTML = "";
            }
        };
        xmlhttp.open("POST", "ajax.php", true);
        xmlhttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
        xmlhttp.send(dataToSend);
    }


}
function showRoom(str) {
    if (str == "") {
        document.getElementById("textHint").innerHTML = "";
    } else {
        var xmlhttp = new XMLHttpRequest();
        xmlhttp.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {


                let roomsJso = JSON.parse(this.responseText);

                let format = (
                    "<table class='reservations-table'>" +
                    "<thead>" +
                    "<tr>" +
                    "<th>Number</th>" +
                    "<th>Category</th>" +
                    "<th>Price per day</th>" +
                    "<th>Capacity</th>" +
                    "<th>Status</th>" +
                    "</tr>" +
                    "</thead>" +
                    "<tbody>"
                );

                for (let i = 0; i < roomsJso.length; i++) {
                    let roomStatus;   

                    if (roomsJso[i]['room_status'] == 1) {
                        roomStatus = "available"
                    } else {
                        roomStatus = "disaible"
                    };

                    format += (
                        "<tr>" +
                        "<td>" + roomsJso[i]['room_number'] + "</td>" +
                        "<td>" + roomsJso[i]['room_category_name'] + "</td>" +
                        "<td>" + roomsJso[i]['room_category_price_per_day'] + "</td>" +
                        "<td>" + roomsJso[i]['capacity'] + "</td>" +
                        "<td>" + roomStatus + "</td>" +
                        "</tr>"
                    );
                }
                

                format+= (
                    "</tbody>" +
                    "</table>"
                );


                document.getElementById("textHint").innerHTML = format;
            }
        };
        xmlhttp.open("GET", "/student070/dwes/db/ajax-db-rooms-select.php?q=" + str, true);
        xmlhttp.send();
    }
}
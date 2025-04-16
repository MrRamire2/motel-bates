const personsQuantity = document.getElementById("persons_quantity");
const serviceId = document.getElementById("service-id");
const date = document.getElementById("date");

personsQuantity.addEventListener("change", () => GetData());
serviceId.addEventListener("change", () => GetData());
date.addEventListener("change", () => GetData());

function comprobarInputs() {
    let comprobante = true;
    if (personsQuantity.value === "") comprobante = false;
    if (serviceId.value === "") comprobante = false;
    if (date.value === "") comprobante = false;
    return comprobante;
}

function GetData() {
    if (comprobarInputs()) {
        let xmlhttp = new XMLHttpRequest();
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

                let data_json = JSON.parse(xmlhttp.responseText);

                let options = "";
                data_json.available_hours.forEach(hour => {
                    options += `<option value="${hour}">${hour}</option>`;
                });

                document.getElementById("extra_hour").innerHTML = options;
                document.getElementById("persons_quantity").max = data_json.max_capacity;
                document.getElementById("total_price").innerHTML = `<h2>${data_json.unit_price * personsQuantity.value} €</h2>`;
                document.getElementById("unit_price").value = data_json.unit_price;
            }
        };

        let url = "/motel-bates/db/ajax-db-services-select-unavailable-hours.php" +
            "?personsQuantity=" + encodeURIComponent(personsQuantity.value) +
            "&serviceId=" + encodeURIComponent(serviceId.value) +
            "&date=" + encodeURIComponent(date.value);

        xmlhttp.open("GET", url, true);
        xmlhttp.send();
    } else {
        document.getElementById("extra_hour").innerHTML = "";
    }
}
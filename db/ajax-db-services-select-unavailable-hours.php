<?php
$service_id = htmlspecialchars($_GET['serviceId']);
$persons_quantity = htmlspecialchars($_GET['personsQuantity']);
$date = htmlspecialchars($_GET['date']);

$ROOT = $_SERVER['DOCUMENT_ROOT'];
require($ROOT . '/student070/dwes/stable/db-connect.php');



// hours_unavailable
$sql = "SELECT TIME_FORMAT(rs_time, '%H:%i') 
        FROM `070_reservations_services_view_capacity` 
        WHERE service_id = '$service_id' 
        AND rs_date = '$date' 
        AND available_capacity < $persons_quantity;";

$result = mysqli_query($conn, $sql);

$hours_unavailable = mysqli_fetch_all($result, MYSQLI_NUM);

// hours_available
$sqlHours = "SELECT service_max_capacity, service_unit_price, service_time_json FROM `070_services` WHERE service_id = '$service_id';";

$resultHours = mysqli_query($conn, $sqlHours);

$hours_available = mysqli_fetch_all($resultHours, MYSQLI_NUM);



//capacidad maxima
$service_max_capacity = array_shift($hours_available[0]);
//precio por unidad
$service_unit_price = array_shift($hours_available[0]);

$available_hours = [];

$hours_unavailable_array = [];


foreach ($hours_unavailable as $hour_array) {
    foreach ($hour_array as $hour) {
        array_push($hours_unavailable_array, $hour);
    };
};

$hours_unavailable_json = json_encode($hours_unavailable_array);
$hours_available_array = json_decode($hours_available[0][0], true);
$hours_unavailable_array = json_decode($hours_unavailable_json, true);
$available_hours = array_diff($hours_available_array, $hours_unavailable_array);



mysqli_close($conn);



// Devolver un JSON con las horas y el precio total
$response = [
    "available_hours" => array_values($available_hours),
    "unit_price" => $service_unit_price,
    "max_capacity" => $service_max_capacity
];

header('Content-Type: application/json');
echo json_encode($response);

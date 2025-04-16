<?php
$ROOT = $_SERVER['DOCUMENT_ROOT'];
require($ROOT . '/student070/dwes/stable/db-connect.php');


$locationkey = '107487';
$apikey = 'KtmIkW8jDeAOuxWQKEjUVQARRek3lUQ7';

$url = "http://dataservice.accuweather.com/currentconditions/v1/{$locationkey}?apikey={$apikey}&language=en-us&details=false";

$response = file_get_contents($url);
$weatherData = json_decode($response, true);

$api_json = json_encode($weatherData[0], JSON_PRETTY_PRINT);

$inserted_on = date("Y-m-d H:i:s");

$sql = mysqli_prepare($conn, "INSERT INTO `070_apis`(api_id, api_inserted_on, api_json) VALUES ('accuweather', '" . $inserted_on . "' ,'" . $api_json . "')");

if (mysqli_stmt_execute($sql)) {
    echo 'New json inserted successfully.';
} else {
    echo "Error al insertar: " . mysqli_stmt_error($sql);
}

mysqli_stmt_close($sql);

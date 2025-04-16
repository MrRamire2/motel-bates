<?php
$ROOT = $_SERVER['DOCUMENT_ROOT'];
require($ROOT.'/motel-bates/stable/db-connect.php');
require($ROOT.'/motel-bates/functions/api_format.php');

$sql ="SELECT JSON_EXTRACT(api_json, '$.WeatherIcon') AS icon_name, api_inserted_on as `date_time`, ROUND(AVG(JSON_EXTRACT(JSON_EXTRACT(api_json, '$.Temperature'), '$.Metric.Value'))) AS temperature FROM `070_apis` WHERE HOUR(api_inserted_on) = HOUR(NOW()) GROUP BY DATE(api_inserted_on) LIMIT 5";

$result = mysqli_query($conn, $sql);

$weather_array = mysqli_fetch_all($result, MYSQLI_ASSOC);

mysqli_free_result($result);

mysqli_close($conn);
?>
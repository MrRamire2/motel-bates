<?php

$ROOT = $_SERVER['DOCUMENT_ROOT'];
require($ROOT . '/student070/dwes/stable/db-connect.php');

$sql = 'SELECT SUM(price_per_day) AS total_generated, count(*) AS customers,  DATE_ADD(CURRENT_DATE(), INTERVAL -3 MONTH) AS start_date, CURRENT_DATE() AS end_date
FROM 070_reservations
WHERE date_out BETWEEN DATE_ADD(CURRENT_DATE(), INTERVAL -3 MONTH) AND CURRENT_DATE()';

$result = mysqli_query($conn, $sql);

$my_file = 'quarter.txt';

$handle = fopen($my_file, 'r+');

$quarterData = mysqli_fetch_all($result, MYSQLI_ASSOC);

print_r($quarterData);

fwrite($handle, "QUARTER DATA: " . $quarterData[0]['start_date'] . " " . $quarterData[0]['end_date'] .
"\nCustomers: " . $quarterData[0]['customers'] . 
"\nTotal generated: " . $quarterData[0]['total_generated']);

mysqli_free_result($result);

mysqli_close($conn);



SELECT SUM(price_per_day) AS total_generated, count(*) AS customers, SUM(JSON_EXTRACT(extras_json, '$.gym.'))  DATE_ADD(CURRENT_DATE(), INTERVAL -3 MONTH) AS start_date, CURRENT_DATE() AS end_date
FROM 070_reservations
WHERE date_out BETWEEN DATE_ADD(CURRENT_DATE(), INTERVAL -3 MONTH) AND CURRENT_DATE();




SELECT JSON_EXTRACT(extras_json, '$.gym.*.ticket_subtotal') FROM `070_reservations`
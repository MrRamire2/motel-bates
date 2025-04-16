<?php
$q = htmlspecialchars($_GET['q']);

$ROOT = $_SERVER['DOCUMENT_ROOT'];
require($ROOT.'/motel-bates/stable/db-connect.php');

$sql = "SELECT * FROM 070_rooms_view WHERE CONCAT(room_number, room_category_name) LIKE '%$q%' ORDER BY room_status DESC";

$result = mysqli_query($conn, $sql);
$rooms = mysqli_fetch_all($result, MYSQLI_ASSOC);

$rooms_json = json_encode($rooms);

echo $rooms_json;


mysqli_close($conn);
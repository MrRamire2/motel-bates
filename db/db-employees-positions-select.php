<?php
$ROOT = $_SERVER['DOCUMENT_ROOT'];
require($ROOT . "/student070/dwes/stable/db-connect.php");

$sql = 'SELECT * FROM 070_employees_positions';

$result = mysqli_query($conn, $sql);

$employees_positions = mysqli_fetch_all($result, MYSQLI_ASSOC);

mysqli_free_result($result);

mysqli_close($conn);
?>
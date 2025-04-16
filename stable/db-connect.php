<?php
    $conn = mysqli_connect('localhost', 'root', '', '070_hms_db');

    // Revisar la conexión
    if (!$conn) {
        die('Connection error: ' . mysqli_connect_error());
    }
?>
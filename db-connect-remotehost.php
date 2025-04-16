<?php
    $conn = mysqli_connect('db5017676552.hosting-data.io', 'dbu417225', 'Natanohj797', 'dbs14136192');

    // Configura el conjunto de caracteres en utf8mb4
    $conn->set_charset("utf8mb4");

    // Revisar la conexión
    if (!$conn) {
        die('Connection error: ' . mysqli_connect_error());
    }
?>

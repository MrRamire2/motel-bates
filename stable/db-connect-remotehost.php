<?php
    $conn = mysqli_connect('remotehost.es', 'dwess1234', 'test1234.', 'dwesdatabase');

    // Configura el conjunto de caracteres en utf8mb4
    $conn->set_charset("utf8mb4");

    // Revisar la conexión
    if (!$conn) {
        die('Connection error: ' . mysqli_connect_error());
    }
?>

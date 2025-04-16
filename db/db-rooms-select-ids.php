<?php
$ROOT = $_SERVER['DOCUMENT_ROOT'];
require($ROOT.'/motel-bates/stable/db-connect.php');

// Array para almacenar los detalles de todas las habitaciones
$all_details = [];

foreach ($all_rooms as $room) {
        $room_id = htmlspecialchars($room['room_id']); // Asegurarse de que el ID sea seguro y entero
        // Preparar y ejecutar una consulta adicional para obtener más detalles
        $sql = "SELECT * FROM 070_rooms_view WHERE room_id = $room_id";

        // Ejecutar la consulta
        if ($result = mysqli_query($conn, $sql)) {
        $details = mysqli_fetch_all($result, MYSQLI_ASSOC);
        $all_details = array_merge($all_details, $details); // Acumular resultados

        // Liberar resultados y cerrar la sentencia
        mysqli_free_result($result);
        // Limpiar el conjunto de resultados actual para permitir nuevas consultas
        mysqli_next_result($conn);
    } else {
        echo "Error en la consulta " . mysqli_error($conn);
    }
}

// Cerrar la conexión después de haber procesado todas las habitaciones
mysqli_close($conn);
?>
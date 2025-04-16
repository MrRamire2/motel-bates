<?php
$ROOT = $_SERVER['DOCUMENT_ROOT'];
require($ROOT.'/student070/dwes/stable/db-connect.php');

// Verificar si se recibió un ID
if (isset($room_id)) {
    // Preparar la consulta para seleccionar la habitación con ese ID
    $stmt = mysqli_prepare($conn, "SELECT * FROM 070_rooms_view WHERE room_id = ?");

    // Asociar el parámetro
    mysqli_stmt_bind_param($stmt, "i", $room_id); // "i" indica que es un número entero

    // Ejecutar la consulta
    mysqli_stmt_execute($stmt);

    // Obtener los resultados
    $result = mysqli_stmt_get_result($stmt);

    // Guardar los resultados en un array
    $rooms = mysqli_fetch_all($result, MYSQLI_ASSOC);

    // Liberar resultados y cerrar conexiones
    mysqli_free_result($result);
    mysqli_stmt_close($stmt);
    mysqli_close($conn);
} else {
    // Manejar el caso en que no se haya recibido un room_id
    $rooms = [];
    echo "No room ID received.";
}
?>

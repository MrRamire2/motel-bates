<?php
$ROOT = $_SERVER['DOCUMENT_ROOT'];
require($ROOT . '/student070/dwes/stable/db-connect.php');

$message = ''; // Inicializar $message

try {
    // Captura los datos del formulario
    if (isset($_SESSION['room_number']) && isset($_SESSION['capacity'])) {
        $room_id = htmlspecialchars($_SESSION['room_id']);
        $room_number = htmlspecialchars($_SESSION['room_number']);
        $room_category_id = htmlspecialchars($_SESSION['room_category_id']);
        $room_status = htmlspecialchars($_SESSION['room_status']);
        $capacity = htmlspecialchars($_SESSION['capacity']);

        // Crear la consulta de tipo INSERT
        $sql = mysqli_prepare($conn, "UPDATE 070_rooms SET room_number = ?, room_category_id = ?, room_status = ?, capacity = ? WHERE room_id = ?");

        // Enlazar los parámetros
        mysqli_stmt_bind_param($sql, 'iiiii', $room_number, $room_category_id, $room_status, $capacity, $room_id);

        // Ejecutar la consulta
        if (mysqli_stmt_execute($sql)) {
            $message = 'Registry updated successfully';
        }

        // Cerrar la declaración y la conexión
        mysqli_stmt_close($sql);
        mysqli_close($conn);

        // Limpiar los datos de la sesión después de usarlos
        unset($_SESSION['room_id']);
        unset($_SESSION['room_number']);
        unset($_SESSION['room_category_id']);
        unset($_SESSION['room_status']);
        unset($_SESSION['capacity']);
    } else {
        $message = 'The data has not been received correctly';
    }
} catch (mysqli_sql_exception $e) {
    $message = 'Error: ' . $e->getMessage();
}
?>
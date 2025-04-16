<?php
$ROOT = $_SERVER['DOCUMENT_ROOT'];
require($ROOT . '/motel-bates/stable/db-connect.php');

$message = ''; // Inicializar $message

try {
    if (isset($_SESSION['room_number']) && isset($_SESSION['capacity'])) {
        // Captura de los datos de la sesión
        $room_number = htmlspecialchars($_SESSION['room_number']);
        $room_category_id = htmlspecialchars($_SESSION['room_category_id']);
        $room_status = htmlspecialchars($_SESSION['room_status']);
        $capacity = htmlspecialchars($_SESSION['capacity']);

        // Preparar la consulta
        $sql = mysqli_prepare($conn, "INSERT INTO 070_rooms (room_number, room_category_id, room_status, capacity) VALUES (?, ?, ?, ?)");

        // Enlazar los parámetros
        mysqli_stmt_bind_param($sql, 'iiii', $room_number, $room_category_id, $room_status, $capacity);

        // Intentar ejecutar la consulta
        if (mysqli_stmt_execute($sql)) {
            $message = 'New record inserted successfully';
        }

        // Cerrar la declaración y la conexión
        mysqli_stmt_close($sql);
        mysqli_close($conn);

        // Limpiar los datos de la sesión después de usarlos
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
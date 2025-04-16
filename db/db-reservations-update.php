<?php
$ROOT = $_SERVER['DOCUMENT_ROOT'];
require($ROOT . '/motel-bates/stable/db-connect.php');

try {
    // Captura los datos del formulario
    if (isset($_POST['submit'])) {
        $reservation_id = htmlspecialchars($_POST['reservation_id']);
        $user_id = htmlspecialchars($_POST['user_id']);
        $room_id = htmlspecialchars($_POST['room_id']);
        $price_per_day = htmlspecialchars($_POST['price_per_day']);
        $status = htmlspecialchars($_POST['status']);

        // Crear la consulta de tipo INSERT
        $sql = mysqli_prepare($conn, "UPDATE 070_reservations SET user_id = ?, room_id = ?, price_per_day = ?, `status` = ? WHERE reservation_id = ?");

        // Enlazar los parámetros
        mysqli_stmt_bind_param($sql, 'iidsi', $user_id, $room_id, $price_per_day, $status, $reservation_id);

        // Ejecutar la consulta
        if (mysqli_stmt_execute($sql)) {
            $message = 'Registry updated successfully';
        }

        // Cerrar la conexión
        mysqli_stmt_close($sql); // Cerrar la declaración
        mysqli_close($conn); // Cerrar la conexión
    } else {
        $message = 'The data has not been received correctly';
    }
} catch (mysqli_sql_exception $e) {
    $message = 'Error: ' . $e->getMessage();
}
<?php
$ROOT = $_SERVER['DOCUMENT_ROOT'];
require($ROOT . '/motel-bates/stable/db-connect.php');
$message = ''; // Inicializar $message

try {
    if (isset($_SESSION['user_id']) && isset($_SESSION['room_id']) && isset($_SESSION['date_in']) && isset($_SESSION['date_out']) && isset($_SESSION['room_category_price_per_day'])) {
        $user_id = htmlspecialchars($_SESSION['user_id']);
        $room_id = htmlspecialchars($_SESSION['room_id']);
        $date_in = htmlspecialchars($_SESSION['date_in']);
        $date_out = htmlspecialchars($_SESSION['date_out']);
        $price_per_day = htmlspecialchars($_SESSION['room_category_price_per_day']);

        // Crear la consulta de tipo INSERT
        $sql = mysqli_prepare($conn, "INSERT INTO 070_reservations (`user_id`, `room_id`, `date_in`, `date_out`, `price_per_day`) VALUES (?, ?, ?, ?, ?)");

        // Enlazar los parámetros
        mysqli_stmt_bind_param($sql, 'iissd', $user_id, $room_id, $date_in, $date_out, $price_per_day);

        // Intentar ejecutar la consulta
        if (mysqli_stmt_execute($sql)) {
            $message = 'New record inserted successfully';
        }

        // Cerrar la conexión
        mysqli_stmt_close($sql); // Cerrar la declaración
        mysqli_close($conn); // Cerrar la conexión

        // Limpiar los datos de la sesión después de usarlos
        unset($_SESSION['user_id']);
        unset($_SESSION['room_id']);
        unset($_SESSION['date_in']);
        unset($_SESSION['date_out']);
        unset($_SESSION['room_category_price_per_day']);
        unset($_SESSION['capacity']);
    } else {
        $message = 'The data has not been received correctly';
    }
} catch (mysqli_sql_exception $e) {
    $message = 'Error: ' . $e->getMessage();
}

<?php
$ROOT = $_SERVER['DOCUMENT_ROOT'];
require($ROOT . '/student070/dwes/stable/db-connect.php');

try {
    // Captura los datos del formulario
    if (isset($_POST['delete'])) {
        $reservation_id = htmlspecialchars($_POST['reservation_id']);

        // Crear la consulta de tipo INSERT
        $sql = mysqli_prepare($conn, "UPDATE 070_reservations SET status = 'cancelled' WHERE reservation_id = ?");

        // Enlazar los parámetros
        mysqli_stmt_bind_param($sql, 'i', $reservation_id);

        // Ejecutar la consulta
        if (mysqli_stmt_execute($sql)) {
            $message = 'Reservation removed successfully';
        }

        // Cerrar la conexión
        mysqli_stmt_close($sql); // Cerrar la declaración
        mysqli_close($conn); // Cerrar la conexión
    }
} catch (mysqli_sql_exception $e) {
    // Capturar la excepción y almacenar el mensaje de error
    $message = 'Error: ' . $e->getMessage();
}

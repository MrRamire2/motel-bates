<?php
$ROOT = $_SERVER['DOCUMENT_ROOT'];
require($ROOT.'/student070/dwes/stable/db-connect.php');

// Verificar si se recibió un ID de cliente por POST
if (isset($_POST['reservation_id']) || isset($_GET['reservation_id'])) {
    $reservation_id = isset($_POST['reservation_id']) ? htmlspecialchars($_POST['reservation_id']) : htmlspecialchars($_GET['reservation_id']);

    // Preparar la consulta para seleccionar el cliente con ese ID
    $stmt = mysqli_prepare($conn, "SELECT * FROM 070_reservations_view WHERE reservation_id = ?");

    // Asociar el parámetro
    mysqli_stmt_bind_param($stmt, "i", $reservation_id); // "i" indica que es un número entero

    // Ejecutar la consulta
    mysqli_stmt_execute($stmt);

    // Obtener los resultados
    $result = mysqli_stmt_get_result($stmt);

    // Guardar los resultados en un array
    $reservations = mysqli_fetch_all($result, MYSQLI_ASSOC);

    // Liberar resultados y cerrar conexiones
    mysqli_free_result($result);
    mysqli_stmt_close($stmt);
    mysqli_close($conn);
} else {
    // Manejar el caso en que no se haya recibido un customer_id
    $reservations = [];
    echo "No reservation ID received.";
}
?>

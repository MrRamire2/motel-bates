<?php
$ROOT = $_SERVER['DOCUMENT_ROOT'];
require($ROOT . '/motel-bates/stable/db-connect.php');

try {
    // Captura los datos del formulario
    if (isset($_POST['submit'])) {
        // Capturamos los datos directamente
        $reservation_id = $_POST['reservation_id'];
        $unit_price = $_POST['unit_price'];
        $persons_quantity = $_POST['persons_quantity'];
        $service_id = $_POST['service_id'];
        $date = $_POST['date'];
        $extra_hour = $_POST['extra_hour'];

        echo $unit_price;


        // Aseguramos que la hora tiene los segundos (HH:MM:SS)
        if (strpos($extra_hour, ':') !== false && strpos($extra_hour, ':00') === false) {
            $extra_hour .= ':00'; // Si no tiene los segundos, los agregamos
        }

        // INSERT con consultas preparadas
        $sql = "INSERT INTO `070_reservations_services`(reservation_id, service_id, rs_quantity, rs_unit_price, rs_date, rs_time)
                VALUES (?, ?, ?, ?, ?, ?)";

        // Preparar la consulta
        if ($stmt = mysqli_prepare($conn, $sql)) {
            // Vincular los parámetros
            mysqli_stmt_bind_param($stmt, "isidss", $reservation_id, $service_id, $persons_quantity, $unit_price, $date, $extra_hour);

            // Ejecutar la consulta
            if (mysqli_stmt_execute($stmt)) {
                header("Location:/motel-bates/confirmations/confirmation-extras-add.php");
                $_SESSION["extra_message"] = 'Extra registered';
            } else {
                // Captura cualquier error si la consulta no se ejecuta
                $_SESSION["extra_message"] = 'Error executing the query: ' . mysqli_error($conn);
            }

            // Cerrar la consulta preparada
            mysqli_stmt_close($stmt);
        } else {
            $_SESSION["extra_message"] = 'Error preparing the query: ' . mysqli_error($conn);
        }

        // Cerrar la conexión
        mysqli_close($conn); // Cerrar la conexión
    }

} catch (mysqli_sql_exception $e) {
    $_SESSION["extra_message"] = 'Error: ' . $e->getMessage();
}
?>

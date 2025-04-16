<?php
$ROOT = $_SERVER['DOCUMENT_ROOT'];
require($ROOT . '/motel-bates/db/db-users-select-id.php');
require($ROOT . '/motel-bates/stable/db-connect.php');

$message = ''; // Inicializar $message


try {
    // Captura los datos del formulario
    if (isset($users[0]['employee_id']) && isset($_POST['position_id'])) {
        // Captura de los datos de la sesión
        $employee_id = $users[0]['employee_id'];
        $position_id = $_POST['position_id'];

        // Crear la consulta de tipo UPDATE
        $sql = mysqli_prepare($conn, "UPDATE `070_employees` SET position_id = ? WHERE employee_id = ?");

        // Enlazar los parámetros
        mysqli_stmt_bind_param($sql, 'ii', $position_id, $employee_id);

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

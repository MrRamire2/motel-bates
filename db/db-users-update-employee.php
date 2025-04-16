<?php
$ROOT = $_SERVER['DOCUMENT_ROOT'];
require($ROOT . '/student070/dwes/stable/db-connect.php');

$message = ''; // Inicializar $message


try {
    // Captura los datos del formulario
    if (isset($_POST['target_user_id'])) {
        // Captura de los datos de la sesión
        $target_user_id = $_POST['target_user_id'];

        // Crear la consulta de tipo UPDATE
        $sql = mysqli_prepare($conn, "UPDATE `070_users` SET employee_id = (SELECT employee_id FROM `070_employees` WHERE target_user_id = ? LIMIT 1) WHERE user_id = ?");

      // Enlazar los parámetros
      mysqli_stmt_bind_param($sql, 'ii', $target_user_id, $target_user_id);


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
<?php
$ROOT = $_SERVER['DOCUMENT_ROOT'];
require($ROOT . '/motel-bates/stable/db-connect.php');

$message = ''; // Inicializar $message

try {
    // Captura los datos del formulario
    if (isset($_POST['employee_position']) && isset($_POST['target_user_id']) && isset($_POST['date_hiring'])) {
        // Captura de los datos de la sesión
        $employee_position = $_POST['employee_position'];
        $target_user_id = $_POST['target_user_id'];
        $date_hiring = $_POST['date_hiring'];


        // Crear la consulta de tipo INSERT
        $sql = mysqli_prepare($conn, "INSERT INTO 070_employees (position_id, target_user_id, date_hiring) VALUES (?, ?, ?)");

        // Enlazar los parámetros
        mysqli_stmt_bind_param($sql, 'iis', $employee_position, $target_user_id, $date_hiring);

        // Ejecutar la consulta
        if (mysqli_stmt_execute($sql)) {
            $message = 'New employee inserted successfully.';
        }else{
            $message = "'Execute Error: ' . mysqli_stmt_error($sql)";
        }

        // Cerrar la conexión
        mysqli_stmt_close($sql); // Cerrar la declaración
        mysqli_close($conn); // Cerrar la conexión


    } else {
        $message = 'Error: Missing employee data in session.';
    }
} catch (mysqli_sql_exception $e) {
    $message = 'Error: ' . $e->getMessage();
}
// Cerrar la sesión temporalmente
<?php
$ROOT = $_SERVER['DOCUMENT_ROOT'];
require($ROOT . '/motel-bates/stable/db-connect.php');

try {
    // Verificar si se ha solicitado eliminar (por POST o GET) y si existe el user_id
    if ((isset($_POST['user_id']) || isset($_GET['user_id']))) {

        // Obtener el user_id de manera segura y asegurarse de que sea un número
        $user_id = isset($_POST['user_id']) ? intval($_POST['user_id']) : (isset($_GET['user_id']) ? intval($_GET['user_id']) : null);

        if ($user_id !== null) {
            // Crear la consulta de tipo UPDATE (cambiar estado del usuario a inactivo)
            $sql = mysqli_prepare($conn, "UPDATE `070_users` SET user_status = 'inactive' WHERE user_id = ?");

            // Enlazar los parámetros
            mysqli_stmt_bind_param($sql, 'i', $user_id);

            // Ejecutar la consulta
            if (mysqli_stmt_execute($sql)) {
                $message = 'User removed successfully';
            } else {
                $message = 'Error removing user.';
            }

            // Cerrar la declaración
            mysqli_stmt_close($sql);
        } else {
            $message = 'Invalid user ID.';
        }

        // Cerrar la conexión
        mysqli_close($conn);
    } else {
        $message = 'No delete action or user_id provided.';
    }
} catch (Exception $e) {
    // Capturar errores generales
    $message = 'Error: ' . $e->getMessage();
}
?>

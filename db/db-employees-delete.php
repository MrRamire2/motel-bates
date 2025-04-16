<?php
$ROOT = $_SERVER['DOCUMENT_ROOT'];
require($ROOT . '/student070/dwes/stable/db-connect.php');

try {
     // Captura los datos del formulario
     if (isset($_POST['delete'])) {
          $user_id = htmlspecialchars($_POST['employee_id']);

          // Crear la consulta de tipo UPDATE(cambiar estado del usuario a inactivo)
          $sql = mysqli_prepare($conn, "UPDATE `070_users` SET employee_id = NULL WHERE user_id = ?");
          $sqlDelete = mysqli_prepare($conn, "DELETE FROM `070_employees` WHERE target_user_id = ?");

          // Enlazar los parámetros
          mysqli_stmt_bind_param($sql, 'i', $user_id);
          mysqli_stmt_bind_param($sqlDelete, 'i', $user_id);

          // Ejecutar la consulta
          if (mysqli_stmt_execute($sql) && mysqli_stmt_execute($sqlDelete)) {
               $message = 'User removed successfully';
          }

          // Cerrar la declaración y la conexión
          mysqli_stmt_close($sql);
          mysqli_stmt_close($sqlDelete);
          mysqli_close($conn);
     }
} catch (Exception $e) {
     // Capturar errores generales
     $message = 'Error: ' . $e->getMessage();
}
?>
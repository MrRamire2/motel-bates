<?php
$ROOT = $_SERVER['DOCUMENT_ROOT'];
require($ROOT . '/student070/dwes/stable/db-connect.php');

try {
     // Captura los datos del formulario
     if (isset($_POST['delete'])) {
          $room_id = htmlspecialchars($_POST['room_id']);

          // Crear la consulta de tipo DELETE
          $sql = mysqli_prepare($conn, "DELETE FROM 070_rooms WHERE room_id = ?");

          // Enlazar los parámetros
          mysqli_stmt_bind_param($sql, 'i', $room_id);

          // Ejecutar la consulta
          if (mysqli_stmt_execute($sql)) {
               $message = 'Room removed successfully';
          }

          // Cerrar la declaración y la conexión
          mysqli_stmt_close($sql);
          mysqli_close($conn);
     }
} catch (mysqli_sql_exception $e) {
     // Capturar la excepción y almacenar el mensaje de error
     $message = 'Error: ' . $e->getMessage();
}
?>
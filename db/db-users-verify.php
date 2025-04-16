<?php 
$ROOT = $_SERVER['DOCUMENT_ROOT'];
require($ROOT.'/student070/dwes/stable/db-connect.php');

// Para imprimir el email y la password ingresada en el formulario
if (isset($_POST['submit'])) {
    // Variables para verificar usuario
    $email = htmlspecialchars($_POST['email']);
    $password = htmlspecialchars($_POST['password']);

    // Preparar llamada a procedimiento almacenado para verificar usuarios
    $sql = mysqli_prepare($conn, "CALL 070_users_verify(?, ?)");

    if ($sql) {
        // Asociar variables a los marcadores de posición
        mysqli_stmt_bind_param($sql, "ss", $email, $password);

        // Ejecutar la consulta
        if (mysqli_stmt_execute($sql)) {
            // Tomar el resultado de la consulta
            $result = mysqli_stmt_get_result($sql);

            // Verificar si el usuario fue autenticado correctamente
          if (mysqli_num_rows($result) > 0) {

            session_start();
            $customer = mysqli_fetch_assoc($result); // Obtener solo la primera fila del resultado
            $_SESSION['login_forename'] = $customer['user_forename']; // Guardar el nombre del usuario en la sesión
            $_SESSION['login_user_id'] = $customer['user_id'];
            $_SESSION['login_user_rol'] = $customer['user_rol'];
            $_SESSION['login_user_image_url'] = $customer['user_image_url'];

            session_write_close();

            // Redirigir después de la verificación
            header('Location: /student070/dwes/index.php');
            exit();
          } else {
            $message = 'Usuario o contraseña incorrectos.';
          }
        }


        // Liberar resultados y cerrar statement
        mysqli_stmt_free_result($sql);
        mysqli_stmt_close($sql);
    } else {
        $message = 'Error al preparar la consulta: ' . mysqli_error($conn);
    }

    // Cerrar la conexión
    mysqli_close($conn);
}
?>

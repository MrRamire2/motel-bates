<?php
$ROOT = $_SERVER['DOCUMENT_ROOT'];
require($ROOT . '/student070/dwes/stable/db-connect.php');

$message = ''; // Inicializar $message


try {
    // Captura los datos del formulario
    if (isset($_SESSION['user_forename']) && isset($_SESSION['user_surname']) && isset($_SESSION['user_nif']) && isset($_SESSION['user_email']) && isset($_SESSION['user_phone']) && isset($_SESSION['user_password']) && isset($_SESSION['user_birthday']) && isset($_SESSION['user_id'])) {
        // Captura de los datos de la sesión
        $user_forename = $_SESSION['user_forename'];
        $user_surname = $_SESSION['user_surname'];
        $user_nif = $_SESSION['user_nif'];
        $user_email = $_SESSION['user_email'];
        $user_phone = $_SESSION['user_phone'];
        $user_password = $_SESSION['user_password'];
        $user_birthday = $_SESSION['user_birthday'];
        $user_id = $_SESSION['user_id'];

        $user_image_name = $_SESSION['user_image_name'];


        // Crear la consulta de tipo UPDATE
        $sql = mysqli_prepare($conn, "UPDATE 070_users SET user_forename = ?, user_surname = ?, user_nif = ?, user_email = ?, user_phone = ?, user_password = ?, user_birthday = ?, user_image_url = ? WHERE user_id = ?");

        // Enlazar los parámetros
        mysqli_stmt_bind_param($sql, 'ssssssssi', $user_forename, $user_surname, $user_nif, $user_email, $user_phone, $user_password, $user_birthday, $user_image_name, $user_id);

        // Ejecutar la consulta
        if (mysqli_stmt_execute($sql)) {
            $message = 'Registry updated successfully';
            if ($user_image_name != $_SESSION["login_user_image_url"]) {
                unlink($ROOT . "/student070/dwes" . $_SESSION["login_user_image_url"]);
            };
        }

        // Cerrar la conexión
        mysqli_stmt_close($sql); // Cerrar la declaración
        mysqli_close($conn); // Cerrar la conexión

        //verifica si es customer o el mismo admin para cambiar los datos de la sesion
        if ($_SESSION["login_user_rol"] === "customer" || ($_SESSION["login_user_rol"] === "admin" && intval($_SESSION['login_user_id']) === intval($user_id))) {
            $_SESSION["login_forename"] = $user_forename;
            $_SESSION["login_user_image_url"] = $user_image_name;
        }

        // Limpiar los datos de la sesión después de usarlos
        unset($_SESSION['user_forename']);
        unset($_SESSION['user_surname']);
        unset($_SESSION['user_nif']);
        unset($_SESSION['user_email']);
        unset($_SESSION['user_phone']);
        unset($_SESSION['user_password']);
        unset($_SESSION['user_birthday']);
        unset($_SESSION['user_id']);

        unset($_SESSION['user_image_name']);
    } else {
        $message = 'The data has not been received correctly';
    }
} catch (mysqli_sql_exception $e) {
    $message = 'Error: ' . $e->getMessage();
}

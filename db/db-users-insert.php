<?php
$ROOT = $_SERVER['DOCUMENT_ROOT'];
require($ROOT . '/student070/dwes/stable/db-connect.php');

$message = ''; // Inicializar $message

try {
    // Captura los datos del formulario
    if (isset($_SESSION['forename']) && isset($_SESSION['surname']) && isset($_SESSION['nif']) && isset($_SESSION['email']) && isset($_SESSION['phone']) && isset($_SESSION['password']) && isset($_SESSION['birthday'])) {
        // Captura de los datos de la sesión
        $forename = $_SESSION['forename'];
        $surname = $_SESSION['surname'];
        $nif = $_SESSION['nif'];
        $email = $_SESSION['email'];
        $phone = $_SESSION['phone'];
        $password = $_SESSION['password'];
        $birthday = $_SESSION['birthday'];

        // Crear la consulta de tipo INSERT
        $sql = mysqli_prepare($conn, "INSERT INTO 070_users (user_forename, user_surname, user_nif, user_email, user_phone, `user_password`, user_birthday) VALUES (?, ?, ?, ?, ?, ?, ?)");

        // Enlazar los parámetros
        mysqli_stmt_bind_param($sql, 'sssssss', $forename, $surname, $nif, $email, $phone, $password, $birthday);

        // Ejecutar la consulta
        if (mysqli_stmt_execute($sql)) {
            $message = 'New user inserted successfully.';
            // require($ROOT . '/student070/dwes/db/db-users-select.php');
            // foreach($users as $user){
            //     if($user['user_email'] = $_SESSION['email']){
            //         $user_id = $user['user_id'];
            //     }
            // }
        }

        // Cerrar la conexión
        mysqli_stmt_close($sql); // Cerrar la declaración
        mysqli_close($conn); // Cerrar la conexión

        // Limpiar los datos de la sesión después de usarlos
        unset($_SESSION['forename']);
        unset($_SESSION['surname']);
        unset($_SESSION['nif']);
        unset($_SESSION['email']);
        unset($_SESSION['phone']);
        unset($_SESSION['password']);
        unset($_SESSION['birthday']);


    } else {
        $message = 'Error inserting user: ' . mysqli_stmt_error($sql);
    }
} catch (mysqli_sql_exception $e) {
    $message = 'Error: ' . $e->getMessage();
}
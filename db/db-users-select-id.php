<?php
$ROOT = $_SERVER['DOCUMENT_ROOT'];
require($ROOT.'/student070/dwes/stable/db-connect.php');

// Verificar si se recibió un ID de cliente por POST
if (isset($_GET['user_id']) || isset($_POST['user_id']) || isset($_SESSION['user_id']) || isset($_SESSION['login_user_id'])) {
    
    //dar un valor dependiendo del dato que haya entrado
    if (isset($_GET['user_id'])) {
        $user_id = htmlspecialchars($_GET['user_id']);

    } elseif (isset($_POST['user_id'])) {
        $user_id = htmlspecialchars($_POST['user_id']);
        
    }elseif (isset($_SESSION['login_user_id'])) {
        $user_id = $_SESSION['login_user_id'];

    }
     else {
        $user_id = $_SESSION['user_id'];
    };

    // Preparar la consulta para seleccionar el cliente con ese ID
    $stmt = mysqli_prepare($conn, "SELECT * FROM 070_users_view WHERE user_id = ?");

    // Asociar el parámetro
    mysqli_stmt_bind_param($stmt, "i", $user_id); // "i" indica que es un número entero

    // Ejecutar la consulta
    mysqli_stmt_execute($stmt);

    // Obtener los resultados
    $result = mysqli_stmt_get_result($stmt);

    // Guardar los resultados en un array
    $users = mysqli_fetch_all($result, MYSQLI_ASSOC);

    // Liberar resultados y cerrar conexiones
    mysqli_free_result($result);
    mysqli_stmt_close($stmt);
    mysqli_close($conn);
} else {
    // Manejar el caso en que no se haya recibido un user_id
    $users = [];
    echo "No user ID received.";
}
?>
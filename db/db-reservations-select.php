<?php $ROOT = $_SERVER['DOCUMENT_ROOT'];
require($ROOT.'/motel-bates/stable/db-connect.php'); 

//que se busque a cualquier tipo de usuario solo si es admin
if ($_SESSION["login_user_rol"] === "admin") {
    $user_id = "";
    //que busque los datos del customer ingresado
} elseif ($_SESSION["login_user_rol"] === "customer") {
    $user_id =  ' AND user_id = ' . htmlspecialchars($_SESSION["login_user_id"]);
    //que mande al usuario al login si este no es niguno de los otros dos
} else {
    header('Location:/motel-bates/pages/login.php');
    die();
};

if (isset($_POST['reservation_id'])  || isset($_POST['forename']) || isset($_POST['surname']) || isset($_POST['email']) || $user_id != ""){

    $reservation_id = !empty($_POST['reservation_id']) ? ' AND reservation_id LIKE "%' . intval($_POST['reservation_id']) . '%"' : '';
    $forename = !empty($_POST['forename']) ? ' AND user_forename LIKE "%' . htmlspecialchars($_POST['forename']) . '%"' : '';
    $surname = !empty($_POST['surname']) ? ' AND user_surname LIKE "%' . htmlspecialchars($_POST['surname']) . '%"' : '';
    $email = !empty($_POST['email']) ? ' AND user_email LIKE "%' . htmlspecialchars($_POST['email']) . '%"' : '';   

    $sql = 'SELECT * FROM 070_reservations_view WHERE reservation_id IS NOT NULL ' . $reservation_id . $forename . $surname . $email . $user_id;
}else{

    $sql = 'SELECT * FROM 070_reservations_view WHERE status = "booked" ORDER BY reservation_id DESC';

}

// lanzar consulta y obtener resultado
$result = mysqli_query($conn, $sql);

//tomar el resultado de las filas y guardarlo en forma de un array
$reservations = mysqli_fetch_all($result, MYSQLI_ASSOC);

//Liberar result de la memoria
mysqli_free_result($result);

//cerrar conexión
mysqli_close($conn);
?>

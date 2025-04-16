<?php

//Si el usuario no es admin se manda al login
if ($_SESSION["login_user_rol"] != "admin") {

    header('Location:/motel-bates/pages/login.php');
    die();
    
}

?>
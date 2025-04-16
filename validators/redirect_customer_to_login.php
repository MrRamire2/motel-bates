<?php

//Si es customer se manda al login
if ($_SESSION["login_user_rol"] === "customer") {

    header('Location:/motel-bates/pages/login.php');
    die();
    
}

?>
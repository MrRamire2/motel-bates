<?php

//Si es customer se manda al login
if ($_SESSION["login_user_rol"] === "customer") {

    header('Location:/student070/dwes/pages/login.php');
    die();
    
}

?>
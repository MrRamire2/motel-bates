<?php

//Si el usuario es igual a admin o customer se manda al index
if ($_SESSION["login_user_rol"] === "admin" || $_SESSION["login_user_rol"] === "customer" ) {
  
    header('Location:/student070/dwes/index.php');
    die();

}

?>
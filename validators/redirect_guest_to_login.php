<?php

if ($_SESSION["login_user_rol"] != "admin" && $_SESSION["login_user_rol"] != "customer") {

  header('Location:/motel-bates/pages/login.php');
  die();

};

?>
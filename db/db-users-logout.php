<?php
session_start();
session_unset();
session_destroy();
header('Location: /student070/dwes/index.php');
exit();
?>

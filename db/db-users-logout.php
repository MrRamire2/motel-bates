<?php
session_start();
session_unset();
session_destroy();
header('Location: /motel-bates/index.php');
exit();
?>

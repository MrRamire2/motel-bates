<?php $ROOT = $_SERVER['DOCUMENT_ROOT'];
session_start();

require($ROOT . '/student070/dwes/validators/redirect_customer_guest_to_login.php');

?>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="/student070/dwes/css/header.css">
  <link rel="stylesheet" href="/student070/dwes/css/form.css">
  <title>Select user</title>
</head>

<body>

  <?php include($ROOT . '/student070/dwes/header.php'); ?>

  <main>
    <h1>select the type of user</h1>

    <button onclick="window.location.href='/student070/dwes/forms/form-employees-insert.php'">Employee</button>
    <button onclick="window.location.href='/student070/dwes/forms/form-customers-insert.php'">customer</button>
  </main>
  <?php include($ROOT . '/student070/dwes/footer.php'); ?>

</body>

</html>
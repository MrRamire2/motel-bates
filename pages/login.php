<?php $ROOT = $_SERVER['DOCUMENT_ROOT'];
session_start();

require($ROOT . '/student070/dwes/validators/redirect_admin_customer_to_index.php');

$message = '';
require($ROOT.'/student070/dwes/db/db-users-verify.php');
?>

<!DOCTYPE html>
<html lang="en">

  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/student070/dwes/css/header.css">
    <link rel="stylesheet" href="/student070/dwes/css/login.css">
    <title>Login</title>
  </head>

  <body>

  <?php include($ROOT.'/student070/dwes/header.php'); ?>

    <main>
      <div>
        <form action="login.php" name="register" method="POST">

          <label for="email">Email</label>
          <input type="email" id="email" name="email" required>

          <label for="password">Password</label>
          <input type="password" id="password" name="password" pattern=[A-Za-z\d]{8,20} required>

          <button type="submit" name="submit">Submit</button>

          <h3><?php
            echo $message;
          ?></h3>

        </form>
        <div>
          <a href="/student070/dwes/forms/form-users-insert.php">or register</a>
        </div>
      </div>  
    </main>

    <?php include($ROOT.'/student070/dwes/footer.php'); ?>

  </body>
</html>
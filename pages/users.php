<?php 
$ROOT = $_SERVER['DOCUMENT_ROOT'];
session_start();

require($ROOT . '/student070/dwes/validators/redirect_customer_guest_to_login.php');
?>


<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="/student070/dwes/css/header.css">
  <link rel="stylesheet" href="/student070/dwes/css/list.css">
  <title>users</title>
</head>

<body>

  <?php require($ROOT . '/student070/dwes/header.php'); ?>

  <main>
    <form>
      <label for="search">search</label>
      <input type="text" id="search" onkeyup="showUser(this.value)">
    </form>
      <div id="txtHint"><p>Person info will be listed here...</p></div>
  </main>


  <?php require($ROOT . '/student070/dwes/footer.php'); ?>

</body>


<script src="/student070/dwes/js/ajax-search-user.js"></script>


</html>

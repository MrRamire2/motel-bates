<?php 
$ROOT = $_SERVER['DOCUMENT_ROOT'];
session_start();

require($ROOT . '/motel-bates/validators/redirect_customer_guest_to_login.php');
?>


<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="/motel-bates/css/header.css">
  <link rel="stylesheet" href="/motel-bates/css/list.css">
  <title>users</title>
</head>

<body>

  <?php require($ROOT . '/motel-bates/header.php'); ?>

  <main>
    <form>
      <label for="search">search</label>
      <input type="text" id="search" onkeyup="showUser(this.value)">
    </form>
      <div id="txtHint"><p>Person info will be listed here...</p></div>
  </main>


  <?php require($ROOT . '/motel-bates/footer.php'); ?>

</body>


<script src="/motel-bates/js/ajax-search-user.js"></script>


</html>

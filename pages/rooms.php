<?php $ROOT = $_SERVER['DOCUMENT_ROOT'];
session_start();

require($ROOT . '/student070/dwes/validators/redirect_customer_guest_to_login.php');

  include($ROOT.'/student070/dwes/db/db-rooms-select.php');
?>


<!DOCTYPE html>
<html lang="en">

  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/student070/dwes/css/header.css">
    <link rel="stylesheet" href="/student070/dwes/css/list.css">
    <title>Rooms</title>
  </head>

  <body>

    <?php require($ROOT.'/student070/dwes/header.php'); ?>

    <main>
      <form>
        <label for="searchRoom">Search room</label>
        <input type="text" id="searchRoom" onkeyup="showRoom(this.value)">
      </form>

      <div id="textHint"><p>Room list here...</p></div>
</main>


    <?php require($ROOT.'/student070/dwes/footer.php'); ?>

  </body>

    <script src="/student070/dwes/js/ajax-search-room.js"></script>

</html>
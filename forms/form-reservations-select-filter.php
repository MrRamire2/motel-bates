<?php $ROOT = $_SERVER['DOCUMENT_ROOT'];
session_start();

require($ROOT . '/motel-bates/validators/redirect_guest_to_login.php');
?>


<!DOCTYPE html>
<html lang="en">

  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/motel-bates/css/header.css">
    <link rel="stylesheet" href="/motel-bates/css/form.css">
    <title>Update resevation</title>
  </head>

  <body>

    <?php require($ROOT.'/motel-bates/header.php'); ?>

    <main>
      <h1>Filter reservations</h1>
      <h2>you can leave the spaces blank to see all users</h2>
      <form action="/motel-bates/pages/reservations.php" name="reservations" method="POST">

        <label>
          <span>reservation ID</span>
          <input type="number" name="reservation_id">
        </label>

        <label>
          <span>First name</span>
          <input type="text" name="forename">
        </label>

        <label>
          <span>Last name</span>
          <input type="text" name="surname">
        </label>

        <label>
          <span>Email</span>
          <input type="text" name="email">
        </label>
        
        <label>
          <span>Status reservation</span>
          <select name="status" id="status">
          <option value="">All</option>
            <option value="checked_in">checked_in</option>
            <option value="checked_out">checked_out</option>
            <option value="booked">booked</option>
            <option value="Cancelled">Cancelled</option>
          </select>
        </label>

        <button type="submit">Filter</button>
        
      </form>
    </main>

    <?php require($ROOT.'/motel-bates/footer.php'); ?>

  </body>
</html>

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
  <table class="reservations-table">
    <thead>
      <tr>
        <th>Number</th>
        <th>Category</th>
        <th>Price per Day</th>
        <th>Status</th>
        <th>Capacity</th>
      </tr>
    </thead>
    <tbody>
      <?php foreach ($rooms as $room) { ?>
        <tr>
          <td><?php echo htmlspecialchars($room['room_number']) ?></td>
          <td><?php echo htmlspecialchars($room['room_category_name']) ?></td>
          <td><?php echo htmlspecialchars($room['room_category_price_per_day']) ?></td>
          <td><?php echo htmlspecialchars($room['room_status']) ?></td>
          <td><?php echo htmlspecialchars($room['capacity']) ?></td>
        </tr>
      <?php } ?>
    </tbody>
  </table>
</main>


    <?php require($ROOT.'/student070/dwes/footer.php'); ?>

  </body>
</html>
<?php
$ROOT = $_SERVER['DOCUMENT_ROOT'];
session_start();

include($ROOT . '/motel-bates/db/db-reservations-select.php');
include($ROOT . '/motel-bates/functions/reservation_table_format.php');
?>


<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="/motel-bates/css/header.css">
  <link rel="stylesheet" href="/motel-bates/css/list.css">
  <title>Reservations</title>
</head>

<body>

  <?php require($ROOT . '/motel-bates/header.php'); ?>

  <main>
    <?php if ($_SESSION["login_user_rol"] === "admin") { ?>
      <!-- Tabla de reservas admin-->
      <div class="espacio-completo">
        <button onclick="window.location.href='/motel-bates/forms/form-reservations-select-filter.php'">Go to filters</button>
      </div>

      <h2 class="center"> <?php echo $_POST["status"] ?> </h2>
      <?php reservation_table_format($reservations, $_POST["status"]); ?>




    <?php } elseif ($_SESSION["login_user_rol"] === "customer") { ?>
      <!-- Tabla de reservas customer-->
      <table class="reservations-table">
        <thead>
          <tr>
            <th>Reservation ID</th>
            <th>Full Name</th>
            <th>Room Number</th>
            <th>Check In</th>
            <th>Check Out</th>
            <th>Price per Day</th>
            <th>Status</th>
            <th>Total Days</th>
            <th>Total Price</th>
          </tr>
        </thead>
        <tbody>
          <?php foreach ($reservations as $reservation) { ?>
            <tr>
              <td><?php echo htmlspecialchars($reservation['reservation_id']) ?></td>
              <td><?php echo htmlspecialchars($reservation['user_forename'] . " " . $reservation['user_surname']) ?></td>
              <td><?php echo htmlspecialchars($reservation['room_number']) ?></td>
              <td><?php echo htmlspecialchars($reservation['date_in']) ?></td>
              <td><?php echo htmlspecialchars($reservation['date_out']) ?></td>
              <td><?php echo htmlspecialchars($reservation['price_per_day']) ?></td>
              <td><?php echo htmlspecialchars($reservation['status']) ?></td>
              <td><?php echo htmlspecialchars($reservation['total_days']) ?></td>
              <td><?php echo htmlspecialchars($reservation['total_price']) ?></td>
              <td>
                <a href="/motel-bates/forms/form-reviews-insert.php?user_id=<?php echo htmlspecialchars($reservation['user_id']); ?>&room_category_id=<?php echo htmlspecialchars($reservation['room_category_id']); ?>">
                  <img class='icon' src='/motel-bates/images/reseña.png'>
                </a>
            </tr>
          <?php } ?>
        </tbody>
      </table>
    <?php } ?>

  </main>


  <?php require($ROOT . '/motel-bates/footer.php'); ?>

</body>

</html>
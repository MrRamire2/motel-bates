<?php $ROOT = $_SERVER['DOCUMENT_ROOT'];
session_start();

require($ROOT . '/student070/dwes/validators/redirect_customer_guest_to_login.php');
$reservation_id = isset($_POST["reservation_id"]) ? $_POST["reservation_id"] : $_GET["reservation_id"];
include($ROOT . '/student070/dwes/db/db-reservations-services-select-id.php');

$extras = $reservations_services;
?>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="/student070/dwes/css/header.css">
  <link rel="stylesheet" href="/student070/dwes/css/list.css">
  <title>See extras</title>
</head>

<body>

  <?php require($ROOT . '/student070/dwes/header.php'); ?>

  <main>
    <div>
      <h1>See extras</h1>

      <h2>reservation ID</h2>

      <?php if (isset($extras[0]["reservation_id"])) { ?>
        <h3><?php echo $extras[0]["reservation_id"] ?></h3>
      <?php } else { ?>
        <h3><?php echo "" ?></h3>
      <?php } ?>
      
    </div>
    <table>
      <thead>
        <tr>
          <th>Service</th>
          <th>Quantity</th>
          <th>Subtotal</th>
          <th>Date time</th>
        </tr>
      </thead>
      <tbody>
        <?php
        if (!empty($extras)) {
          foreach ($extras as $extra) { ?>
            <tr>
              <td><?php echo $extra["service_id"] ?></td>
              <td><?php echo $extra["rs_quantity"] ?></td>
              <td><?php echo $extra["rs_unit_price"] * $extra["rs_quantity"] ?></td>
              <td><?php echo $extra["rs_date"] . " " . $extra["rs_time"] ?></td>
            </tr>
        <?php };
        } else {
          echo "<tr><td colspan='3'>No restaurant extras available.</td></tr>";
        }
        ?>
      </tbody>
    </table>

  </main>

  <?php require($ROOT . '/student070/dwes/footer.php'); ?>

</body>

</html>
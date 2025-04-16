<?php $ROOT = $_SERVER['DOCUMENT_ROOT'];
session_start();

require($ROOT . '/motel-bates/validators/redirect_customer_guest_to_login.php');

include($ROOT . '/motel-bates/db/db-reservations-select-id.php');

$reservation_id = $_GET["reservation_id"];
include($ROOT . '/motel-bates/db/db-reservations-services-select-id.php');

$extras = $reservations_services;
$extras_total_price = 0;
?>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="/motel-bates/css/header.css">
  <link rel="stylesheet" href="/motel-bates/css/boxes.css">
  <link rel="stylesheet" href="/motel-bates/css/list.css">
  <title>See extras</title>
</head>

<body>

  <?php require($ROOT . '/motel-bates/header.php'); ?>

  <main class="row">

    <div class="espacio-completo">
      <button onclick="window.location.href='/motel-bates/forms/form-reservations-select-filter.php'">Go to filters</button>
    </div>

    <div class="invoice-container">
      <div class="header">
        <h1>Hotel Invoice</h1>
        <p><strong>Reservation ID:</strong> <?php echo $reservations[0]["reservation_id"] ?> </p>
      </div>

      <!-- Customer Details -->
      <div class="customer-details">
        <h3>Customer Details</h3>
        <ul>
          <li><strong>Name:</strong> <?php echo $reservations[0]["user_forename"] . " " . $reservations[0]["user_surname"] ?> </li>
          <li><strong>Email:</strong> <?php echo $reservations[0]["user_email"] ?> </li>
          <li><strong>Phone:</strong> <?php echo $reservations[0]["user_phone"] ?> </li>
        </ul>
      </div>

      <!-- Reservation Details -->
      <div class="invoice-details">
        <h3>Reservation Details</h3>
        <ul>
          <li><strong>Room Category:</strong> <?php echo $reservations[0]["room_category_name"] ?> </li>
          <li><strong>Room Number:</strong> <?php echo $reservations[0]["room_id"] ?> </li>
          <li><strong>Check-In Date:</strong> <?php echo $reservations[0]["date_in"] ?> </li>
          <li><strong>Check-Out Date:</strong> <?php echo $reservations[0]["date_out"] ?> </li>
          <li><strong>Price per Day:</strong> <?php echo "€" . $reservations[0]["price_per_day"] ?> </li>
        </ul>
      </div>

      <!-- Extras Details -->
      <div class="extras-details">
        <h3>Extras</h3>
        <table style="width:100%" class="center auto-size">
          <tr>
            <th>Service</th>
            <th>Quantity</th>
            <th>Subtotal</th>
            <th>Date time</th>
          </tr>
          <?php
          if (!empty($extras)) {
            foreach ($extras as $extra) {
              $extras_total_price += $extra["rs_unit_price"] * $extra["rs_quantity"]?>
              <tr>
                <td><?php echo $extra["service_id"] ?></td>
                <td><?php echo $extra["rs_quantity"] ?></td>
                <td><?php echo $extra["rs_unit_price"] * $extra["rs_quantity"] ?></td>
                <td><?php echo $extra["rs_date"] . " " . $extra["rs_time"] ?></td>
              </tr>
          <?php };
          } else {
            echo "<tr><td colspan='4'>No extras available.</td></tr>";
          }
          ?>
        </table>
      </div>

      <!-- Total Calculation -->
      <div class="totals">
        <h3>Total Calculation</h3>
        <ul>
          <li><strong>Total Days:</strong> <?php echo $reservations[0]["total_days"] ?> </li>
          <li><strong>Subtotal:</strong> <?php echo "€" . $reservations[0]["total_price"] ?> </li>
          <li><strong>Total Extras:</strong> <?php echo "€" . $extras_total_price; ?> </li>
          <?php $total = ($reservations[0]["total_price"] + $extras_total_price); ?>
          <li><strong class="total">Total Price:</strong> <?php echo "€" . $total; ?> </li>
        </ul>
      </div>

      <div class="footer">
        <p>Thank you for staying with us!</p>
        <p>If you have any questions, please contact us at info@hotel.com</p>
      </div>
    </div>
  </main>

  <?php require($ROOT . '/motel-bates/footer.php'); ?>

</body>

</html>
<?php $ROOT = $_SERVER['DOCUMENT_ROOT'];
session_start();

require($ROOT . '/student070/dwes/validators/redirect_customer_guest_to_login.php');

// include($ROOT . '/student070/dwes/db/db-reservations-select-id.php');
?>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="/student070/dwes/css/header.css">
  <link rel="stylesheet" href="/student070/dwes/css/form.css">
  <title>Add extras</title>
</head>

<body>

  <?php require($ROOT . '/student070/dwes/header.php'); ?>

  <main>
    <h1>Add extras</h1>

    <form action="/student070/dwes/confirmations/confirmation-extras-add.php" name="add" method="POST">

      <!-- Campo oculto para el reservation_id -->
      <input type="hidden" id="reservation_id" name="reservation_id" value="<?php echo isset($_POST["reservation_id"]) ? $_POST["reservation_id"] : $_GET["reservation_id"] ?>">
      <input type="hidden" id="unit_price" name="unit_price">

      <label>
        <span>Number of persons</span>
        <input type="number" name="persons_quantity" id="persons_quantity" min="0">
      </label>

      <label>
        <span>Service</span>
        <select name="service_id" id="service-id">
          <option value="gym">Gym</option>
          <option value="spa">Spa</option>
          <option value="restaurant">Restaurant</option>
        </select>
      </label>

      <label>
        <span>Date</span>
        <input type="date" id="date" name="date" required>
      </label>

      <label>
        <span>Time (Available)</span>
        <select id="extra_hour" name="extra_hour">
        </select>
      </label>

      <div id="total_price"></div>

      <button class="submit" type="submit" name="submit">Update</button>
    </form>
  </main>

  <?php require($ROOT . '/student070/dwes/footer.php'); ?>
  <script src="/student070/dwes/js/ajax-extras-available-hours.js"></script>
</body>

</html>
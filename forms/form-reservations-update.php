<?php $ROOT = $_SERVER['DOCUMENT_ROOT'];
session_start();

require($ROOT . '/student070/dwes/validators/redirect_customer_guest_to_login.php');

include($ROOT.'/student070/dwes/db/db-reservations-select-id.php');
include($ROOT.'/student070/dwes/db/db-users-select.php');

$room_id = htmlspecialchars($reservations[0]['room_id']);
include($ROOT.'/student070/dwes/db/db-rooms-select-id.php');

$date_in = htmlspecialchars($reservations[0]['date_in']);
$date_out = htmlspecialchars($reservations[0]['date_out']);
$capacity = htmlspecialchars($rooms[0]['capacity']);
include($ROOT.'/student070/dwes/db/db-reservations-select-available-rooms-to-update.php');
?>

<!DOCTYPE html>
<html lang="en">

  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/student070/dwes/css/header.css">
    <link rel="stylesheet" href="/student070/dwes/css/form.css">
    <title>Update reservation</title>
  </head>

  <body>

    <?php require($ROOT.'/student070/dwes/header.php'); ?>

    <main>
      <h1>Update reservation</h1>

      <form action="/student070/dwes/confirmations/confirmation-reservations-update.php" name="update" method="POST">

      <!-- Campo oculto para el reservation_id -->
      <input type="hidden" id="reservation_id" name="reservation_id" value="<?php echo htmlspecialchars($reservations[0]['reservation_id']); ?>">

      <?php if (!empty($all_rooms)) { ?>
          <select name="room_id" id="room_id">
              <option value="<?php echo htmlspecialchars($reservations[0]['room_id']) ?>">
                  <?php echo htmlspecialchars($reservations[0]['room_id'] . ' - ' . $reservations[0]['room_category_name']) ?>
              </option>
              <?php foreach ($all_rooms as $room) { ?>
                  <option value="<?php echo htmlspecialchars($room['room_id']) ?>">
                      <?php echo htmlspecialchars($room['room_id'] . ' - ' . $room['room_category_name'] . ' - ' . $room['room_category_price_per_day']) ?>
                  </option>
              <?php } ?>
          </select>
      <?php } else { ?>
          <p>No rooms available for change.</p>
          <input type="hidden" name="room_id" value="<?php echo htmlspecialchars($reservations[0]['room_id']); ?>">
          
      <?php } ?>

      <label>
        <span>user</span>
        <select name="user_id" id="user_id">
            <?php foreach ($users as $user) { ?>
              <option value="<?php echo htmlspecialchars($user['user_id']) ?>"
                  <?php echo ((string) $reservations[0]['user_id'] === (string) $user['user_id']) ? 'selected' : ''; ?>>
                  <?php echo htmlspecialchars($user['user_forename'] . ' ' . $user['user_surname']) ?>
              </option>

            <?php } ?>
        </select>
      </label>


      <label>
        <span>Price per day</span>
        <input type="text" id="price_per_day" name="price_per_day" value="<?php echo htmlspecialchars($reservations[0]['price_per_day']); ?>" required>
      </label>
        
      <label>
        <span>Status</span>
        <select name="status" id="status">
          <option value="cancelled" <?php echo $reservations[0]['status'] === 'cancelled' ? 'selected' : ''; ?>>Cancelled</option>
          <option value="checked_in" <?php echo $reservations[0]['status'] === 'checked_in' ? 'selected' : ''; ?>>Checked in</option>
          <option value="checked_out" <?php echo $reservations[0]['status'] === 'checked_out' ? 'selected' : ''; ?>>Checked out</option>
          <option value="booked" <?php echo ($reservations[0]['status']) === 'booked' ? 'selected' : ''; ?>>Booked</option>
        </select>
      </label>


        <button class="submit" type="submit" name="submit">Update</button>
      </form>
    </main>

    <?php require($ROOT.'/student070/dwes/footer.php'); ?>

  </body>
</html>

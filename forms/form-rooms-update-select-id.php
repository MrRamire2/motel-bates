<?php $ROOT = $_SERVER['DOCUMENT_ROOT'];
session_start();

require($ROOT . '/motel-bates/validators/redirect_customer_guest_to_login.php');

require($ROOT . '/motel-bates/db/db-rooms-select.php');
?>


<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="/motel-bates/css/header.css">
  <link rel="stylesheet" href="/motel-bates/css/form.css">
  <title>Rooms</title>
</head>

<body>

  <?php require($ROOT . '/motel-bates/header.php'); ?>

  <main>
    <h1>Update room</h1>
    <form action="form-rooms-update.php" name="update" method="POST">
      <label for="room_id">Room to update</label>
      <select name="room_id" id="room_id">
        <?php foreach ($rooms as $room) { ?>
          <option value="<?php echo htmlspecialchars($room['room_id']) ?>"><?php echo htmlspecialchars($room['room_number']) ?></option>
        <?php } ?>
      </select>
      <button class="submit" name="submit" type="submit">Update</button>
    </form>
  </main>

  <?php require($ROOT . '/motel-bates/footer.php'); ?>

</body>

</html>
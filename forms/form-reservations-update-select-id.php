<?php $ROOT = $_SERVER['DOCUMENT_ROOT'];
session_start();

require($ROOT . '/motel-bates/validators/redirect_customer_guest_to_login.php');

require($ROOT.'/motel-bates/db/db-reservations-select.php');
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
      <h1>Update reservation</h1>
      <form action="form-reservations-update.php" name="update" method="POST">
      <label for="reservation_id">Reservation ID</label>
            <select name="reservation_id" id="reservation_id">
                <?php foreach ($reservations as $reservation) { ?>
                    <option value="<?php echo htmlspecialchars($reservation['reservation_id']) ?>"><?php echo htmlspecialchars($reservation['reservation_id'])?></option>
                <?php } ?>
            </select>
        <button class="submit" name="submit" type="submit">Update</button>
      </form>
    </main>

    <?php require($ROOT.'/motel-bates/footer.php'); ?>

  </body>
</html>

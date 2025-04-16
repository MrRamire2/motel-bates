<?php $ROOT = $_SERVER['DOCUMENT_ROOT'];
session_start();

require($ROOT . '/student070/dwes/validators/redirect_customer_guest_to_login.php');

require($ROOT.'/student070/dwes/db/db-rooms-select.php');
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/student070/dwes/css/header.css">
    <link rel="stylesheet" href="/student070/dwes/css/form.css">
    <title>Rooms</title>
</head>

<body>

    <?php require($ROOT.'/student070/dwes/header.php'); ?>

    <main>
        <h1>Delete room</h1>
        <form action="/student070/dwes/confirmations/confirmation-rooms-delete.php" name="delete" method="POST">
            <label for="room_id">Room number</label>
            <select name="room_id" id="room_id">
                <?php foreach ($rooms as $room) { ?>
                    <option value="<?php echo htmlspecialchars($room['room_id']) ?>"><?php echo htmlspecialchars($room['room_number'])?></option>
                <?php } ?>
            </select>
            <button class="submit" type="submit" name="delete" value="Delete">Delete</button>
        </form>

          <!-- Muestra el mensaje si existe -->
          <?php if (!empty($message)): ?>
            <div class="message"><?php echo $message; ?></div>
        <?php endif; ?>
    </main>

    <?php require($ROOT.'/student070/dwes/footer.php'); ?>

</body>
</html>

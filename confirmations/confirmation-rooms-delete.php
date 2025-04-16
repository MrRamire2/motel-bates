<?php $ROOT = $_SERVER['DOCUMENT_ROOT'];
session_start();

require($ROOT . '/motel-bates/validators/redirect_customer_guest_to_login.php');

require($ROOT . '/motel-bates/db/db-rooms-delete.php');
?>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="/motel-bates/css/header.css">
  <link rel="stylesheet" href="/motel-bates/css/form.css">
  <title>confirmation</title>
</head>

<body>

  <?php require($ROOT . '/motel-bates/header.php'); ?>

  <main>
    <h1><?php echo isset($message) ? $message : 'Room not removed'; ?></h1>

    <a href="/motel-bates/forms/form-rooms-delete.php">Delete another room</a>
  </main>

  <?php require($ROOT . '/motel-bates/footer.php'); ?>

</body>

</html>
<?php $ROOT = $_SERVER['DOCUMENT_ROOT'];
session_start();

require($ROOT . '/student070/dwes/validators/redirect_guest_to_login.php');

require($ROOT . '/student070/dwes/db/db-reservations-update.php');
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/student070/dwes/css/header.css">
    <link rel="stylesheet" href="/student070/dwes/css/form.css">
    <title>Confirmation</title>
</head>

<body>

    <?php require($ROOT . '/student070/dwes/header.php'); ?>

    <main>
        <h1><?php echo isset($message) ? $message : 'Reservation not updated'; ?></h1>

        <a href="/student070/dwes/forms/form-reservations-update-select-id.php">Update another reservation</a>
    </main>

    <?php require($ROOT . '/student070/dwes/footer.php'); ?>

</body>

</html>
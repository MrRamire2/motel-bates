<?php
$ROOT = $_SERVER['DOCUMENT_ROOT'];
session_start();

require($ROOT . '/motel-bates/validators/redirect_guest_to_login.php');

require($ROOT . '/motel-bates/db/db-users-update.php');
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/motel-bates/css/header.css">
    <link rel="stylesheet" href="/motel-bates/css/form.css">
    <title>Confirmation</title>
</head>

<body>

    <?php require($ROOT . '/motel-bates/header.php'); ?>

    <main>
        <h1><?php echo isset($message) ? $message : 'Customer not updated'; ?></h1>

        <?php if ($_SESSION["login_user_rol"] === "admin") { ?>
        <a href="/motel-bates/forms/form-users-update-select-id.php">Update another user</a>
        <?php } ?>

    </main>

    <?php require($ROOT . '/motel-bates/footer.php'); ?>

</body>
</html>
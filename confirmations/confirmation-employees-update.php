<?php $ROOT = $_SERVER['DOCUMENT_ROOT'];
session_start();

require($ROOT . '/motel-bates/validators/redirect_customer_guest_to_login.php');

require($ROOT . '/motel-bates/db/db-employees-update.php');
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
        <h1><?php echo isset($message) ? $message : 'Employee not updated'; ?></h1>

        <a href="/motel-bates/forms/form-employees-update-select-id.php">Update another employee</a>
    </main>

    <?php require($ROOT . '/motel-bates/footer.php'); ?>

</body>

</html>
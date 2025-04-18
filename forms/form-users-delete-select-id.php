<?php $ROOT = $_SERVER['DOCUMENT_ROOT'];
session_start();

require($ROOT . '/motel-bates/validators/redirect_customer_guest_to_login.php');

require($ROOT.'/motel-bates/db/db-users-select.php');
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/motel-bates/css/header.css">
    <link rel="stylesheet" href="/motel-bates/css/form.css">
    <title>users</title>
</head>

<body>

    <?php require($ROOT.'/motel-bates/header.php'); ?>

    <main>
        <h1>Delete user</h1>
        <form action="/motel-bates/confirmations/confirmation-users-delete.php" name="delete" method="POST">
            <label for="user_id">user number</label>
            <select name="user_id" id="user_id">
                <?php foreach ($users as $user) { ?>
                    <option value="<?php echo htmlspecialchars($user['user_id']) ?>"><?php echo htmlspecialchars($user['user_forename'] . ' ' . $user['user_surname'])?></option>
                <?php } ?>
            </select>
            <button class="submit" type="submit" name="delete" value="Delete">Delete</button>
        </form>

          <!-- Muestra el mensaje si existe -->
          <?php if (!empty($message)): ?>
            <div class="message"><?php echo $message; ?></div>
        <?php endif; ?>
    </main>

    <?php require($ROOT.'/motel-bates/footer.php'); ?>

</body>
</html>

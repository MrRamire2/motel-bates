<?php $ROOT = $_SERVER['DOCUMENT_ROOT'];
session_start();

require($ROOT . '/student070/dwes/validators/redirect_customer_guest_to_login.php');

require($ROOT . '/student070/dwes/db/db-users-select.php');
?>


<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="/student070/dwes/css/header.css">
  <link rel="stylesheet" href="/student070/dwes/css/form.css">
  <title>user</title>

</head>

<body>

  <?php require($ROOT . '/student070/dwes/header.php'); ?>

  <main>
    <h1>Update user</h1>
    <form action="form-users-update.php" name="update" method="POST">
      <label for="user_id">user to update</label>
      <select name="user_id" id="user_id">
        <?php foreach ($users as $user) { ?>
          <option value="<?php echo htmlspecialchars($user['user_id']) ?>">
            <?php echo htmlspecialchars($user['user_forename'] . ' ' . $user['user_surname']) ?>
          </option>
        <?php } ?>
      </select>
      <button class="submit" name="submit" type="submit">Update</button>
    </form>
  </main>

  <?php require($ROOT . '/student070/dwes/footer.php'); ?>

</body>

</html>
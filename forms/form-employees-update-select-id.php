<?php $ROOT = $_SERVER['DOCUMENT_ROOT'];
session_start();

require($ROOT . '/motel-bates/validators/redirect_customer_guest_to_login.php');

require($ROOT . '/motel-bates/db/db-employees-select.php');
?>


<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="/motel-bates/css/header.css">
  <link rel="stylesheet" href="/motel-bates/css/form.css">
  <title>employee</title>

</head>

<body>

  <?php require($ROOT . '/motel-bates/header.php'); ?>

  <main>
    <h1>Update employee</h1>
    <form action="form-employees-update.php" name="update" method="POST">

      <label for="user_id">employee to update</label>
      <select name="user_id" id="user_id">
        <?php foreach ($employees as $employee) { ?>
          <option value="<?php echo htmlspecialchars($employee['user_id']) ?>">
            <?php echo htmlspecialchars($employee['user_forename'] . ' ' . $employee['user_surname']) ?>
          </option>
        <?php } ?>
      </select>
      <button class="submit" name="submit" type="submit">Update</button>
    </form>
  </main>

  <?php require($ROOT . '/motel-bates/footer.php'); ?>

</body>

</html>
<?php $ROOT = $_SERVER['DOCUMENT_ROOT'];
session_start();

require($ROOT . '/student070/dwes/validators/redirect_customer_guest_to_login.php');

require($ROOT . '/student070/dwes/db/db-employees-select.php');
?>


<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="/student070/dwes/css/header.css">
  <link rel="stylesheet" href="/student070/dwes/css/form.css">
  <title>employee</title>

</head>

<body>

  <?php require($ROOT . '/student070/dwes/header.php'); ?>

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

  <?php require($ROOT . '/student070/dwes/footer.php'); ?>

</body>

</html>
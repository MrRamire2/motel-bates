<?php $ROOT = $_SERVER['DOCUMENT_ROOT'];
session_start();

require($ROOT . '/motel-bates/validators/redirect_customer_guest_to_login.php');

require($ROOT . '/motel-bates/db/db-users-select-id.php');
require($ROOT . '/motel-bates/db/db-employees-positions-select.php');
?>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="/motel-bates/css/header.css">
  <link rel="stylesheet" href="/motel-bates/css/form.css">
  <title>Update employee</title>
</head>

<body>

  <?php require($ROOT . '/motel-bates/header.php'); ?>

  <main>
    
    <h1>Update user</h1>
    <form action="/motel-bates/confirmations/confirmation-employees-update.php" name="update" method="POST">

      <input type="hidden" name="user_id" value=" <?php echo $_POST['user_id'] ?>">

      <h2><?php echo $users[0]['user_forename'] . " " . $users[0]['user_surname']?></h2>

      <select name="position_id">
        <?php foreach($employees_positions AS $employee_position) { ?>
          <option value="<?php echo $employee_position['position_id'] ?>"><?php echo $employee_position['position_name'] ?></option>
        <?php } ?>
      </select>

      <button class="update" type="submit" name="update">Update</button>
    </form>
  </main>

  <?php require($ROOT . '/motel-bates/footer.php'); ?>

</body>
</html>
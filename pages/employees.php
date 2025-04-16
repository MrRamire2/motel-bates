<?php $ROOT = $_SERVER['DOCUMENT_ROOT'];
session_start();

require($ROOT . '/motel-bates/validators/redirect_customer_guest_to_login.php');

include($ROOT . '/motel-bates/db/db-employees-select.php');
?>


<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="/motel-bates/css/header.css">
  <link rel="stylesheet" href="/motel-bates/css/list.css">
  <title>employees</title>
</head>

<body>

  <?php require($ROOT . '/motel-bates/header.php'); ?>

  <main>
  <table class="reservations-table">
    <thead>
      <tr>
        <th>First Name</th>
        <th>Second Name</th>
        <th>NIF</th>
        <th>Email</th>
        <th>Phone</th>
        <th>Birthday</th>
      </tr>
    </thead>
    <tbody>
      <?php foreach ($employees as $employee) { ?>
        <tr>
          <td><?php echo htmlspecialchars($employee['user_forename']) ?></td>
          <td><?php echo htmlspecialchars($employee['user_surname']) ?></td>
          <td><?php echo htmlspecialchars($employee['user_nif']) ?></td>
          <td><?php echo htmlspecialchars($employee['user_email']) ?></td>
          <td><?php echo htmlspecialchars($employee['user_phone']) ?></td>
          <td><?php echo htmlspecialchars($employee['user_birthday']) ?></td>
        </tr>
      <?php } ?>
    </tbody>
  </table>
</main>


  <?php require($ROOT . '/motel-bates/footer.php'); ?>

</body>

</html>
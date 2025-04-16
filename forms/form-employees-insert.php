<?php $ROOT = $_SERVER['DOCUMENT_ROOT'];
session_start();

require($ROOT . '/student070/dwes/validators/redirect_customer_guest_to_login.php');

require($ROOT . '/student070/dwes/db/db-employees-positions-select.php');
require($ROOT . '/student070/dwes/db/db-users-select.php');

?>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="/student070/dwes/css/header.css">
  <link rel="stylesheet" href="/student070/dwes/css/form.css">
  <title>Employee</title>
</head>

<body>

  <?php include($ROOT . '/student070/dwes/header.php'); ?>

  <main>
    <h1>Insert employee</h1>
    <form action="/student070/dwes/confirmations/confirmation-employees-insert.php" name="register" method="POST">

      <!--USER ID-->
      
      <label>
        <span>User NIF - Email</span>
        <select name="target_user_id">
          <?php foreach ($users as $user) { ?>
            <?php if($user["employee_id"] === NULL){ ?>
              <option value="<?php echo htmlspecialchars($user["user_id"]) ?>"><?php echo htmlspecialchars($user["user_nif"]) . " - (" . htmlspecialchars($user["user_email"]) . ")" ?></option>
            <?php }
          } ?>
        </select>
      </label>

      <!-- POSITION ID-->
      <label>
      <span>Employee position</span>
      <select name="employee_position">
        <?php foreach ($employees_positions as $employee_position) { ?>
          <option value="<?php echo htmlspecialchars($employee_position["position_id"]) ?>"><?php echo htmlspecialchars($employee_position["position_name"]) ?></option>
          <?php } ?>
        </select>
      </label>

      <!-- FECHA CONTRATACIÓN-->
      <label>
        <span>Date hiring</span>
        <input type="date" id="date_hiring" name="date_hiring" value="<?php echo $date_hiring ?>">
      </label>
      


      <button class="submit" type="submit" name="submit">Submit</button>

    </form>
    <div>
      <a href="/student070/dwes/pages/login.php">or login</a>
    </div>


  </main>

  <?php include($ROOT . '/student070/dwes/footer.php'); ?>

</body>

</html>
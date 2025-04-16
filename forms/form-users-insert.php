<?php $ROOT = $_SERVER['DOCUMENT_ROOT'];
session_start();

require($ROOT . '/student070/dwes/validators/redirect_customer_to_login.php');

include($ROOT . '/student070/dwes/validators/validator-users.php');



$forename = $surname = $nif = $email = $phone = $password = $birthday = '';
$errors = array('forename' => '', 'surname' => '', 'nif' => '', 'email' => '', 'phone' => '', 'password' => '', 'birthday' => '');
$validator = true;

if (isset($_POST['submit'])) {
  // Llamar a la función de validación
  $validator = validator_users($errors);

  // Si todas las validaciones pasan, almacenar en $_SESSION y redirigir
  if ($validator) {

    // Guardar los datos en la sesión
    $_SESSION['forename'] = htmlspecialchars($_POST['forename']);
    $_SESSION['surname'] = htmlspecialchars($_POST['surname']);
    $_SESSION['nif'] = htmlspecialchars($_POST['nif']);
    $_SESSION['email'] = htmlspecialchars($_POST['email']);
    $_SESSION['phone'] = htmlspecialchars($_POST['phone']);
    $_SESSION['password'] = htmlspecialchars($_POST['password']);
    $_SESSION['birthday'] = htmlspecialchars($_POST['birthday']);


    // Redirigir a la página de confirmación
    header('Location: ../confirmations/confirmation-users-insert.php');
    exit();  // Asegura que el script se detenga tras la redirección
  }
  $forename = htmlspecialchars($_POST['forename']);
  $surname = htmlspecialchars($_POST['surname']);
  $nif = htmlspecialchars($_POST['nif']);
  $email = htmlspecialchars($_POST['email']);
  $phone = htmlspecialchars($_POST['phone']);
  $password = htmlspecialchars($_POST['password']);
  $birthday = htmlspecialchars($_POST['birthday']);
}
?>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="/student070/dwes/css/header.css">
  <link rel="stylesheet" href="/student070/dwes/css/form.css">
  <title>customers</title>
</head>

<body>

  <?php include($ROOT . '/student070/dwes/header.php'); ?>

  <main>
    <h1>Insert customer</h1>
    <form action="form-users-insert.php" name="register" method="POST">

      <label for="forename">
        <span>Name</span>
        <input type="text" id="forename" name="forename" value="<?php echo $forename ?>">
      </label>
      <div class="error"><?php echo $errors['forename']; ?></div>

      <label for="surname">
        <span>Last name</span>
        <input type="text" id="surname" name="surname" value="<?php echo $surname ?>">
      </label>
      <div class="error"><?php echo $errors['surname']; ?></div>

      <label for="nif">
        <span>NIF</span>
        <input type="text" id="nif" name="nif" value="<?php echo $nif ?>">
      </label>
      <div class="error"><?php echo $errors['nif']; ?></div>

      <label for="email">
        <span>Email</span>
        <input type="email" id="email" name="email" value="<?php echo $email ?>">
      </label>
      <div class="error"><?php echo $errors['email']; ?></div>

      <label for="phone">
        <span>Phone</span>
        <input type="text" id="phone" name="phone" value="<?php echo $phone ?>">
      </label>
      <div class="error"><?php echo $errors['phone']; ?></div>

      <label for="password">
        <span>Password</span>
        <input type="password" id="password" name="password" value="<?php echo $password ?>">
      </label>
      <div class="error"><?php echo $errors['password']; ?></div>

      <label for="birthday">
        <span>Birthdate</span>
        <input type="date" id="birthday" name="birthday" value="<?php echo $birthday ?>">
      </label>
      <div class="error"><?php echo $errors['birthday']; ?></div>



      <button class="submit" type="submit" name="submit">Submit</button>

    </form>
    <div>
      <a href="/student070/dwes/pages/login.php">or login</a>
    </div>


  </main>

  <?php include($ROOT . '/student070/dwes/footer.php'); ?>

</body>

</html>
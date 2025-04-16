<?php $ROOT = $_SERVER['DOCUMENT_ROOT'];
session_start();

require($ROOT . '/motel-bates/validators/redirect_guest_to_login.php');

require($ROOT . '/motel-bates/db/db-users-select-id.php');
require($ROOT . '/motel-bates/validators/validator-users.php');
require($ROOT . '/motel-bates/functions/personalized_name_gen.php');
require($ROOT . '/motel-bates/functions/save_resized_image.php');


$forename = $surname = $nif = $email = $phone = $password = $birthday = '';
$errors = array('forename' => '', 'surname' => '', 'nif' => '', 'email' => '', 'phone' => '', 'password' => '', 'birthday' => '');
$validator = true;

if (isset($_POST['update'])) {
  // Llamar a la función de validación
  $validator = validator_users($errors);

  // Si todas las validaciones pasan, almacenar en $_SESSION y redirigir
  if ($validator) {

    // Guardar los datos en la sesión
    $_SESSION['user_forename'] = htmlspecialchars($_POST['forename']);
    $_SESSION['user_surname'] = htmlspecialchars($_POST['surname']);
    $_SESSION['user_nif'] = htmlspecialchars($_POST['nif']);
    $_SESSION['user_email'] = htmlspecialchars($_POST['email']);
    $_SESSION['user_phone'] = htmlspecialchars($_POST['phone']);
    $_SESSION['user_password'] = htmlspecialchars($_POST['password']);
    $_SESSION['user_birthday'] = htmlspecialchars($_POST['birthday']);
    $_SESSION['user_id'] = htmlspecialchars($_POST['user_id']);


    if (isset($_FILES['profile_picture']) && $_FILES['profile_picture']['error'] === UPLOAD_ERR_OK) {

      $user_image_name = personalized_name_gen($_SESSION['user_forename'], $_SESSION['user_surname']);
      $path_to_save_with_name = $ROOT . "/motel-bates" . $user_image_name;

      $image_path = $_FILES['profile_picture']['tmp_name'];

      if (move_uploaded_file($image_path, $path_to_save_with_name)) {
        save_resized_image($path_to_save_with_name);
      };

      // Almacenar ruta de la imagen para la db
      $_SESSION['user_image_name'] = $user_image_name;
    } else {
      $_SESSION['user_image_name'] = $_POST["user_image_url"];
    };


    // Redirigir a la página de confirmación
    header('Location: ../confirmations/confirmation-users-update.php');
    exit();  // Asegura que el script se detenga tras la redirección
  }
}
?>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="/motel-bates/css/header.css">
  <link rel="stylesheet" href="/motel-bates/css/form.css">
  <title>Update user</title>
</head>

<body>

  <?php require($ROOT . '/motel-bates/header.php'); ?>

  <main>

    <h1>Update user</h1>
    <form action="form-users-update.php" method="POST" enctype="multipart/form-data">

      <!-- Campo oculto para el user_id -->
      <input type="hidden" id="user_id" name="user_id" value="<?php echo htmlspecialchars($users[0]['user_id']); ?>">

      <label>
        <span>Forename</span>
      <input type="text" id="user_forename" name="forename" value="<?php echo htmlspecialchars($users[0]['user_forename']); ?>">
      </label>
      <!-- error forename -->
      <div class="error"><?php echo $errors['forename']; ?></div>

      <label>
        <span>Surname</span>
      <input type="text" id="user_surname" name="surname" value="<?php echo htmlspecialchars($users[0]['user_surname']); ?>">
      </label>
      <!-- error surname -->
      <div class="error"><?php echo $errors['surname']; ?></div>

      <label>
        <span>NIF</span>
      <input type="text" id="user_nif" name="nif" value="<?php echo htmlspecialchars($users[0]['user_nif']); ?>">
      </label>
      <!-- error nif -->
      <div class="error"><?php echo $errors['nif']; ?></div>

      <label>
        <span>Email</span>
      <input type="email" id="user_email" name="email" value="<?php echo htmlspecialchars($users[0]['user_email']); ?>">
      </label>
      <!-- error email -->
      <div class="error"><?php echo $errors['email']; ?></div>

      <label>
        <span>Phone</span>
      <input type="text" id="user_phone" name="phone" value="<?php echo htmlspecialchars($users[0]['user_phone']); ?>">
      </label>
      <!-- error phone -->
      <div class="error"><?php echo $errors['phone']; ?></div>

      <label>
        <span>Password</span>
      <input type="password" id="user_password" name="password" value="<?php echo htmlspecialchars($users[0]['user_password']); ?>">
      </label>
      <!-- error password -->
      <div class="error"><?php echo $errors['password']; ?></div>

      <label>
        <span>Birthday</span>
      <input type="date" id="user_birthday" name="birthday" value="<?php echo htmlspecialchars($users[0]['user_birthday']); ?>">
      </label>
      <!-- error birthday -->
      <div class="error"><?php echo $errors['birthday']; ?></div>

      <input type="hidden" name="user_image_url" value="<?php echo htmlspecialchars($users[0]['user_image_url']); ?>">
      <label for="profile_picture">profile picture</label>
      <input class="input-file" type="file" name="profile_picture">

      <button class="update" type="submit" name="update">Update</button>
    </form>
  </main>

  <?php require($ROOT . '/motel-bates/footer.php'); ?>

</body>

</html>
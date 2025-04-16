<?php $ROOT = $_SERVER['DOCUMENT_ROOT'];
session_start();

require($ROOT . '/motel-bates/validators/redirect_customer_guest_to_login.php');

$room_id = htmlspecialchars($_POST['room_id']);
require($ROOT . '/motel-bates/db/db-rooms-select-id.php');
require($ROOT . '/motel-bates/db/db-rooms-select-category-name.php');
require($ROOT . '/motel-bates/validators/validator-rooms.php');



$room_number = $capacity = '';
$errors = array('room_number' => '', 'capacity' => '');
$validator = true;

if (isset($_POST['update'])) {
  // Llamar a la función de validación
  $validator = validator_room($errors);

  // Si todas las validaciones pasan, almacenar en $_SESSION y redirigir
  if ($validator) {

    // Guardar los datos en la sesión
    $_SESSION['room_id'] = htmlspecialchars($_POST['room_id']);
    $_SESSION['room_number'] = htmlspecialchars($_POST['room_number']);
    $_SESSION['room_category_id'] = htmlspecialchars($_POST['room_category_id']);
    $_SESSION['room_status'] = htmlspecialchars($_POST['room_status']);
    $_SESSION['capacity'] = htmlspecialchars($_POST['capacity']);


    // Redirigir a la página de confirmación
    header('Location: ../confirmations/confirmation-rooms-update.php');
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
  <title>Rooms</title>
</head>

<body>

  <?php require($ROOT . '/motel-bates/header.php'); ?>

  <main>
    <h1>Update room</h1>
    <form action="form-rooms-update.php" name="update" method="POST">

      <input type="hidden" id="room_id" name="room_id" value="<?php echo $rooms[0]['room_id'] ?>">

      <label for="room_number">
        <span>Number</span>
        <input type="number" id="room_number" name="room_number" value="<?php echo $rooms[0]['room_number']; ?>">
      </label>
      <div class="error"><?php echo $errors['room_number']; ?></div>

      <label for="room_category_id">
        <span>Category</span>
        <select id="room_category_id" name="room_category_id">
          <?php foreach ($rooms_categories as $rooms_category) { ?>
            <option value="<?php echo htmlspecialchars($rooms_category['room_category_id']); ?>"
              <?php if ($rooms[0]['room_category_name'] === $rooms_category['room_category_name']) echo 'selected'; ?>>
              <?php echo htmlspecialchars($rooms_category['room_category_name']); ?>
            </option>
          <?php } ?>
        </select>
      </label>

      <label for="room_status">
        <span>Status</span>
        <select id="room_status" name="room_status">
          <option value="0" <?php if ($rooms[0]['room_status'] === 0) echo 'selected'; ?>>Available</option>
          <option value="1" <?php if ($rooms[0]['room_status'] === 1) echo 'selected'; ?>>Disabled</option>
        </select>
      </label>

      <label for="capacity">
        <span>Capacity</span>
        <input type="number" id="capacity" name="capacity" value="<?php echo $rooms[0]['capacity']; ?>">
      </label>
      <div class="error"><?php echo $errors['capacity']; ?></div>


      <button class="update" type="update" name="update">Update</button>
    </form>
  </main>


  <?php require($ROOT . '/motel-bates/footer.php'); ?>

</body>

</html>
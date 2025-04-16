<?php $ROOT = $_SERVER['DOCUMENT_ROOT'];
session_start();

require($ROOT . '/student070/dwes/validators/redirect_customer_guest_to_login.php');

require($ROOT.'/student070/dwes/db/db-rooms-select-category-name.php');
require($ROOT.'/student070/dwes/validators/validator-rooms.php');



$room_number = $capacity = '';
$errors = array('room_number'=>'', 'capacity'=>'');
$validator = true;

if (isset($_POST['submit'])) {
    // Llamar a la función de validación
    $validator = validator_room($errors);

    // Si todas las validaciones pasan, almacenar en $_SESSION y redirigir
    if ($validator) {

        // Guardar los datos en la sesión
        $_SESSION['room_number'] = htmlspecialchars($_POST['room_number']);
        $_SESSION['room_category_id'] = htmlspecialchars($_POST['room_category_id']);
        $_SESSION['room_status'] = htmlspecialchars($_POST['room_status']);
        $_SESSION['capacity'] = htmlspecialchars($_POST['capacity']);


        // Redirigir a la página de confirmación
        header('Location: ../confirmations/confirmation-rooms-insert.php');
        exit();  // Asegura que el script se detenga tras la redirección
    }
    $room_number = htmlspecialchars($_POST['room_number']);
    $capacity = htmlspecialchars($_POST['capacity']);
}
?>

<!DOCTYPE html>
<html lang="en">

  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/student070/dwes/css/header.css">
    <link rel="stylesheet" href="/student070/dwes/css/form.css">
    <title>Rooms</title>
  </head>

  <body>

    <?php require($ROOT.'/student070/dwes/header.php'); ?>

    <main>
    <h1>Insert room</h1>
    <form action="form-rooms-insert.php" name="insert" method="POST">
    <label for="room_number">
    <span>Number</span>
    <input type="number" id="room_number" name="room_number" value="<?php echo $room_number; ?>">
</label>
<div class="error"><?php echo $errors['room_number']; ?></div>

<label for="room_category_id">
    <span>Category</span>
    <select id="room_category_id" name="room_category_id">
        <?php foreach ($rooms_categories as $rooms_category) { ?>
            <option value="<?php echo htmlspecialchars($rooms_category['room_category_id']); ?>">
                <?php echo htmlspecialchars($rooms_category['room_category_name']); ?>
            </option>
        <?php } ?>
    </select>
</label>

<label for="room_status">
    <span>Status</span>
    <select id="room_status" name="room_status">
        <option value="0">Available</option>
        <option value="1">Disabled</option>
    </select>
</label>

<label for="capacity">
    <span>Capacity</span>
    <input type="number" id="capacity" name="capacity" value="<?php echo $capacity; ?>">
</label>
<div class="error"><?php echo $errors['capacity']; ?></div>


        <button class="submit" type="submit" name="submit">Submit</button>
    </form>
</main>

    <?php require($ROOT.'/student070/dwes/footer.php'); ?>

  </body>
</html>


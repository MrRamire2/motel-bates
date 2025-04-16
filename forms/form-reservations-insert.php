<?php
$ROOT = $_SERVER['DOCUMENT_ROOT'];
session_start();

require($ROOT . '/motel-bates/validators/redirect_guest_to_login.php');
require($ROOT . '/motel-bates/db/db-users-select.php');
require($ROOT . '/motel-bates/validators/validator-reservations.php');

// Inicializar variables de los campos
$date_in = isset($_COOKIE['date_in']) ? $_COOKIE['date_in'] : '';
$date_out = isset($_COOKIE['date_out']) ? $_COOKIE['date_out'] : '';
$capacity = isset($_COOKIE['capacity']) ? $_COOKIE['capacity'] : '';
$errors = array('date_in' => '', 'date_out' => '', 'capacity' => '');

// Validación del formulario
if (isset($_POST['submit'])) {
    // Validar y asignar los valores del formulario
    if (empty($_POST['date_in'])) {
        $errors['date_in'] = 'Date in is required.';
    } else {
        $date_in = $_POST['date_in'];
        setcookie('date_in', $date_in, time() + 3600, '/');
    }

    if (empty($_POST['date_out'])) {
        $errors['date_out'] = 'Date out is required.';
    } else {
        $date_out = $_POST['date_out'];
        setcookie('date_out', $date_out, time() + 3600, '/');
    }

    if (empty($_POST['capacity'])) {
        $errors['capacity'] = 'Capacity is required.';
    } else {
        $capacity = $_POST['capacity'];
        setcookie('capacity', $capacity, time() + 3600, '/');
    }

    // Llamar a la función de validación
    $validator = validator_reservation($errors);

    // Si todas las validaciones pasan, almacenar en $_SESSION y redirigir
    if ($validator) {
        $_SESSION['user_id'] = htmlspecialchars($_POST['user_id']);
        $_SESSION['date_in'] = htmlspecialchars($date_in);
        $_SESSION['date_out'] = htmlspecialchars($date_out);
        $_SESSION['capacity'] = htmlspecialchars($capacity);

        // Redirigir a la página de confirmación
        header('Location: ../forms/form-reservations-insert-available.php');
        exit();  // Asegura que el script se detenga tras la redirección
    }
} else {
    // Si no se envió el formulario, mantenemos los valores previos de las cookies
    $date_in = htmlspecialchars($date_in);
    $date_out = htmlspecialchars($date_out);
    $capacity = htmlspecialchars($capacity);
}

// Asegurar que el rol está definido
if (!isset($_SESSION['login_user_rol'])) {
    $_SESSION['login_user_rol'] = "guest";
}

if ($_SESSION["login_user_rol"] === "admin" || $_SESSION["login_user_rol"] === "customer") {
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/motel-bates/css/header.css">
    <link rel="stylesheet" href="/motel-bates/css/form.css">
    <title>Book now</title>
</head>
<body>

<?php require($ROOT . '/motel-bates/header.php'); ?>

<main>
    <h1>Insert reservation</h1>
    <form action="form-reservations-insert.php" method="POST">

        <?php if ($_SESSION["login_user_rol"] === "admin") { ?>

        <label>
            <span>Users</span>
            <select name="user_id" id="user_id">
                <?php foreach ($users as $user) { ?>
                    <option value="<?php echo htmlspecialchars($user['user_id']) ?>"><?php echo htmlspecialchars($user['user_forename'] . ' ' . $user['user_surname']) ?></option>
                <?php } ?>
            </select>
        </label>

        <?php } elseif ($_SESSION["login_user_rol"] === "customer") { ?>

        <input type="hidden" name="user_id" value="<?php echo $_SESSION["login_user_id"] ?>">

        <?php } ?>

        <label>
            <span>Date in</span>
            <input type="date" name="date_in" value="<?php echo $date_in; ?>">
            <!-- error date_in -->
            <div class="error"><?php echo $errors['date_in']; ?></div>
        </label>

        <label>
            <span>Date out</span>
            <input type="date" name="date_out" value="<?php echo $date_out; ?>">
            <!-- error date_out -->
            <div class="error"><?php echo $errors['date_out']; ?></div>
        </label>

        <label>
            <span>Capacity</span>
            <input type="number" id="capacity" name="capacity" value="<?php echo $capacity; ?>">
            <!-- error capacity -->
            <div class="error"><?php echo $errors['capacity']; ?></div>
        </label>

        <button type="submit" name="submit">Submit</button>
    </form>
</main>

<?php require($ROOT . '/motel-bates/footer.php'); ?>

</body>
</html>

<?php
} else {
    require($ROOT . '/motel-bates/pages/login.php');
}
?>


<?php $ROOT = $_SERVER['DOCUMENT_ROOT'];
session_start();

require($ROOT . '/motel-bates/validators/redirect_guest_to_login.php');

$room_id = htmlspecialchars($_POST['room_id']);
require($ROOT . '/motel-bates/db/db-rooms-select-id.php');
require($ROOT . '/motel-bates/db/db-users-select-id.php');

// Verifica si el formulario fue enviado
if (isset($_POST['submit'])) {
    $_SESSION['room_id'] = htmlspecialchars($_POST['room_id']);
    $_SESSION['room_category_price_per_day'] = htmlspecialchars($rooms[0]['room_category_price_per_day']);
}

// Calcula los días de la reserva
$date_in = new DateTime($_SESSION['date_in']);
$date_out = new DateTime($_SESSION['date_out']);
$days = $date_in->diff($date_out)->days;
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/motel-bates/css/header.css">
    <link rel="stylesheet" href="/motel-bates/css/form.css">
    <title>Reservations</title>
</head>

<body>
    <?php require($ROOT . '/motel-bates/header.php'); ?>

    <main>
        <h1>Reservation Preview</h1>
        <form action="/motel-bates/confirmations/confirmation-reservations-insert.php" method="POST">
            <ul>
                <li>
                    <h2>Full name</h2>
                </li>
                <li><?php echo htmlspecialchars($users[0]['user_forename'] . " " . $users[0]['user_surname']); ?></li>
                <li>
                    <h2>Date in</h2>
                </li>
                <li><?php echo htmlspecialchars($_SESSION['date_in']); ?></li>
                <li>
                    <h2>Date out</h2>
                </li>
                <li><?php echo htmlspecialchars($_SESSION['date_out']); ?></li>
                <li>
                    <h2>Room number</h2>
                </li>
                <li><?php echo htmlspecialchars($rooms[0]['room_number']); ?></li>
                <li>
                    <h2>Room category</h2>
                </li>
                <li><?php echo htmlspecialchars($rooms[0]['room_category_name']); ?></li>
                <li>
                    <h2>Total price</h2>
                </li>
                <li><?php echo htmlspecialchars($_SESSION['room_category_price_per_day'] * $days); ?></li>

                <button type="submit" class="submit" name="submit">Submit</button>
            </ul>
        </form>
    </main>
    <?php require($ROOT . '/motel-bates/footer.php'); ?>
</body>
</html>

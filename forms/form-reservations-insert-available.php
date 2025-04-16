<?php $ROOT = $_SERVER['DOCUMENT_ROOT'];
session_start();

require($ROOT . '/motel-bates/validators/redirect_guest_to_login.php');

// Obtener los valores del SESSION
$date_in = $_SESSION['date_in'];
$date_out = $_SESSION['date_out'];
$capacity = $_SESSION['capacity'];
require($ROOT . '/motel-bates/db/db-reservations-select-available-rooms.php');
require($ROOT . '/motel-bates/db/db-rooms-select-ids.php');
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/motel-bates/css/header.css">
    <link rel="stylesheet" href="/motel-bates/css/boxes.css">
    <title>Available rooms</title>
</head>

<body>

    <?php require($ROOT . '/motel-bates/header.php'); ?>

    <main>

        <?php if (!empty($all_details)): ?>
            <?php foreach ($all_details as $room): ?>
                <div>
                    <form action="/motel-bates/pages/reservations-insert-preview.php" method="post">
                        <!-- Campos ocultos -->
                        <input type="hidden" id="room_id" name="room_id" value="<?php echo htmlspecialchars($room['room_id']); ?>">
                        <ul>
                            <h3>Number:</h3>
                            <li> <?php echo htmlspecialchars($room['room_number']) ?> </li>
                            <h3>Category:</h3>
                            <li> <?php echo htmlspecialchars($room['room_category_name']) ?> </li>
                            <h3>Price per day:</h3>
                            <li> <?php echo htmlspecialchars($room['room_category_price_per_day']) ?> </li>
                            <h3>Status:</h3>
                            <li> <?php echo htmlspecialchars($room['room_status']) ?> </li>
                            <h3>Capacity:</h3>
                            <li> <?php echo htmlspecialchars($room['capacity']) ?> </li>
                        </ul>
                        <button type="submit" class="submit" name="submit">Submit</button>
                    </form>
                </div>
            <?php endforeach; ?>
        <?php else: ?>
            <p>No available rooms found.</p>
        <?php endif; ?>

    </main>

    <?php require($ROOT . '/motel-bates/footer.php'); ?>

</body>

</html>
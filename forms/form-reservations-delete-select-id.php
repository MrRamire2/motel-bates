<?php $ROOT = $_SERVER['DOCUMENT_ROOT'];
session_start();

require($ROOT . '/student070/dwes/validators/redirect_customer_guest_to_login.php');

 require($ROOT.'/student070/dwes/db/db-reservations-select.php');
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/student070/dwes/css/header.css">
    <link rel="stylesheet" href="/student070/dwes/css/form.css">
    <title>Reservations</title>
</head>

<body>

    <?php require($ROOT.'/student070/dwes/header.php'); ?>

    <main>
        <h1>Delete Reservation</h1>
        <form action="/student070/dwes/confirmations/confirmation-reservations-delete.php" name="delete" method="POST">
            <label for="reservation_id">Reservation ID</label>
            <select name="reservation_id" id="reservation_id">
                <?php foreach ($reservations as $reservation) { ?>
                    <option value="<?php echo htmlspecialchars($reservation['reservation_id']) ?>"><?php echo htmlspecialchars($reservation['reservation_id'])?></option>
                <?php } ?>
            </select>
            <button class="submit" type="submit" name="delete" value="delete">Delete</button>
        </form>
    </main>

    <?php require($ROOT.'/student070/dwes/footer.php'); ?>

</body>
</html>

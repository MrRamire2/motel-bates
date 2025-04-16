<?php
$ROOT = $_SERVER['DOCUMENT_ROOT'];
require($ROOT.'/student070/dwes/stable/db-connect.php');


if (isset($reservation_id)) {

    $stmt = mysqli_prepare($conn, "SELECT * FROM `070_reservations_services_view` WHERE reservation_id = ?");

    mysqli_stmt_bind_param($stmt, "i", $reservation_id);

    mysqli_stmt_execute($stmt);

    $result = mysqli_stmt_get_result($stmt);

    $reservations_services = mysqli_fetch_all($result, MYSQLI_ASSOC);

    mysqli_free_result($result);
    mysqli_stmt_close($stmt);
    mysqli_close($conn);
} else {
    $rooms = [];
    echo "No room ID received.";
}
?>

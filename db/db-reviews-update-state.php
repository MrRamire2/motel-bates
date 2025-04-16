<?php
$ROOT = $_SERVER['DOCUMENT_ROOT'];
require($ROOT . '/student070/dwes/stable/db-connect.php');

try {
    $user_id = htmlspecialchars($_GET['user_id']);
    $room_category_id = htmlspecialchars($_GET['room_category_id']);

    $sql = mysqli_prepare($conn, "UPDATE 070_reviews SET review_state = 1 WHERE user_id = ? AND room_category_id = ?");

    mysqli_stmt_bind_param($sql, 'ii', $user_id, $room_category_id);

    if (mysqli_stmt_execute($sql)) {
        $message = 'Reservation updated successfully';
    }

    mysqli_stmt_close($sql);
    mysqli_close($conn);
} catch (mysqli_sql_exception $e) {
    $message = 'Error: ' . $e->getMessage();
}
header('Location: /student070/dwes/pages/reviews.php');

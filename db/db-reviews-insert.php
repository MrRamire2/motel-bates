<?php
$ROOT = $_SERVER['DOCUMENT_ROOT'];
require($ROOT . '/motel-bates/stable/db-connect.php');

$message = '';

try {
    if (isset($_POST['user_id']) && isset($_POST['room_category_id'])) {

        $user_id = htmlspecialchars($_POST['user_id']);
        $room_category_id = htmlspecialchars($_POST['room_category_id']);
        $review_inserted_on = date('Y-m-d');
        $review = htmlspecialchars($_POST['review']);
        $estrellas = htmlspecialchars($_POST['estrellas']);

        $sql = mysqli_prepare($conn, "INSERT INTO 070_reviews (user_id, room_category_id, review, review_score, review_inserted_on) VALUES (?, ?, ?, ?, ?)");

        mysqli_stmt_bind_param($sql, 'iisis', $user_id, $room_category_id, $review, $estrellas, $review_inserted_on);

        if (mysqli_stmt_execute($sql)) {
            $message = 'New record inserted successfully';
        }

        mysqli_stmt_close($sql);

    } else {
        $message = 'The data has not been received correctly';
    }
} catch (mysqli_sql_exception $e) {
    if ($e->getCode() == 1062) {
        $message = "<form method='post' action='/motel-bates/confirmations/confirmation-reviews-update.php'>
                <p>You have already left a review in this category. Do you want to overwrite it?</p>
                <input type='hidden' name='user_id' value='$user_id'>
                <input type='hidden' name='room_category_id' value='$room_category_id'>
                <input type='hidden' name='review' value='$review'>
                <input type='hidden' name='estrellas' value='$estrellas'>
                <button type='submit'>Yes</button>
                <a href='/motel-bates/pages/reservations.php'><button type='button'>No</button></a>
            </form>";
    } else {
        $message = "Error: " . $e->getMessage();
    }
}

mysqli_close($conn);

?>
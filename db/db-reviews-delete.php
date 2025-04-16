<?php
$ROOT = $_SERVER['DOCUMENT_ROOT'];
require($ROOT . '/motel-bates/stable/db-connect.php');

try {
        $user_id = htmlspecialchars($_GET['user_id']);
        $room_category_id = htmlspecialchars($_GET['room_category_id']);

        $sql = mysqli_prepare($conn, "DELETE FROM 070_reviews WHERE user_id = ? AND room_category_id = ?");

        mysqli_stmt_bind_param($sql, 'ii', $user_id, $room_category_id);

        if (mysqli_stmt_execute($sql)) {
            $message = 'Review removed successfully';
        }

        mysqli_stmt_close($sql);
        mysqli_close($conn);
} catch (mysqli_sql_exception $e) {
    $message = 'Error: ' . $e->getMessage();
}
header('Location: /motel-bates/pages/reviews.php');
?>
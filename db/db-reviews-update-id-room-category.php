<?php
$ROOT = $_SERVER['DOCUMENT_ROOT'];
require($ROOT . '/student070/dwes/stable/db-connect.php');

$message = '';

$user_id = htmlspecialchars($_POST['user_id']);
$room_category_id = htmlspecialchars($_POST['room_category_id']);
$review_inserted_on = date('Y-m-d');
$review = htmlspecialchars($_POST['review']);
$estrellas = htmlspecialchars($_POST['estrellas']);

$sql = "UPDATE 070_reviews SET review = ?, review_score = ?, review_inserted_on = ?, review_state = 0 WHERE user_id = ? AND room_category_id = ?";
$stmt = mysqli_prepare($conn, $sql);
mysqli_stmt_bind_param($stmt, 'sisii', $review, $estrellas, $review_inserted_on, $user_id, $room_category_id);
if (mysqli_stmt_execute($stmt)) {
    $message = "Review updated successfully!";
};
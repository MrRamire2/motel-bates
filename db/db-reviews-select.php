<?php $ROOT = $_SERVER['DOCUMENT_ROOT'];
require($ROOT.'/student070/dwes/stable/db-connect.php');
require($ROOT.'/student070/dwes/functions/reviews_format.php');

$sql = 'SELECT * FROM 070_reviews_view ORDER BY review_inserted_on';

$result = mysqli_query($conn, $sql);

$reviews = mysqli_fetch_all($result, MYSQLI_ASSOC);

mysqli_free_result($result);

mysqli_close($conn);
?>
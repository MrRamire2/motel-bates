<?php 
$ROOT = $_SERVER['DOCUMENT_ROOT'];
session_start();

require($ROOT . '/student070/dwes/validators/redirect_customer_guest_to_login.php');
require($ROOT.'/student070/dwes/db/db-reviews-select.php');
?>


<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="/student070/dwes/css/header.css">
  <link rel="stylesheet" href="/student070/dwes/css/list.css">
  <link rel="stylesheet" href="/student070/dwes/css/reviews.css">
  <title>users</title>
</head>

<body>

  <?php require($ROOT . '/student070/dwes/header.php'); ?>

  <main>
    <h2>Customer Reviews</h2>
        <section class="reviews" id="reviews">
            <?php 
            foreach ($reviews as $review) {
                if ($review["review_state"] == 0) {
                    reviews_format($review, "0a2239b9", true);
                }
            }
            ?>
        </section>
  </main>

  <?php require($ROOT . '/student070/dwes/footer.php'); ?>

</body>


<script src="/student070/dwes/js/ajax-search-user.js"></script>


</html>

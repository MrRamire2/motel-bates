<?php 
$ROOT = $_SERVER['DOCUMENT_ROOT'];
session_start();

require($ROOT . '/motel-bates/validators/redirect_customer_guest_to_login.php');
require($ROOT.'/motel-bates/db/db-reviews-select.php');
?>


<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="/motel-bates/css/header.css">
  <link rel="stylesheet" href="/motel-bates/css/list.css">
  <link rel="stylesheet" href="/motel-bates/css/reviews.css">
  <title>users</title>
</head>

<body>

  <?php require($ROOT . '/motel-bates/header.php'); ?>

  <main>
    <h2>Customer Reviews</h2>
        <section class="reviews" id="reviews">
            <?php 
            foreach ($reviews as $review) {
                if ($review["review_state"] == 1) {
                    reviews_format($review, "0a2239b9", false);
                }
            }
            ?>
        </section>
  </main>


  <?php require($ROOT . '/motel-bates/footer.php'); ?>

</body>


<script src="/motel-bates/js/ajax-search-user.js"></script>


</html>

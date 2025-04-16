<?php $ROOT = $_SERVER['DOCUMENT_ROOT'];
session_start();

// require($ROOT . '/student070/dwes/validators/redirect_customer_guest_to_login.php');
?>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="/student070/dwes/css/header.css">
  <link rel="stylesheet" href="/student070/dwes/css/form.css">
  <link rel="stylesheet" href="/student070/dwes/css/review.css">
  <title>Add extras</title>
</head>

<body>

  <?php require($ROOT . '/student070/dwes/header.php'); ?>

  <main>
    <h1>Add review</h1>

    <form action="/student070/dwes/confirmations/confirmation-reviews-insert.php" name="add" method="POST">

      <input type="hidden" id="user_id" name="user_id" value="<?php echo $_GET["user_id"] ?>">
      <input type="hidden" id="room_category_id" name="room_category_id" value="<?php echo $_GET["room_category_id"] ?>">

      <label>
        <span>Review (Max 500 characters)</span>
        <textarea name="review" id="review" maxlength="500"></textarea>
      </label>

      <label class="score">
        <span>Score</span>
        <p class="clasificacion">
            <input id="radio1" type="radio" name="estrellas" value="5" checked>
            <label for="radio1">★</label>
            <input id="radio2" type="radio" name="estrellas" value="4">
            <label for="radio2">★</label>
            <input id="radio3" type="radio" name="estrellas" value="3">
            <label for="radio3">★</label>
            <input id="radio4" type="radio" name="estrellas" value="2">
            <label for="radio4">★</label>
            <input id="radio5" type="radio" name="estrellas" value="1">
            <label for="radio5">★</label>
        </p>
      </label>

      <button class="submit" type="submit" name="submit">Update</button>
    </form>
  </main>

  <?php require($ROOT . '/student070/dwes/footer.php'); ?>
</body>

</html>
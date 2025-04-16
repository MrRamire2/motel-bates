<?php function reviews_format($review, $bcolor, $admin)
{
?>
<?php
echo '<div style="
    box-shadow: inset 0px 0px 150px #' . $bcolor . ';
    color: white;
    display: flex;
    flex-direction: column;
    padding: 10px;
    border-radius: 5px;
    border: 2px solid rgb(255, 255, 255);
">';

echo '  <div class="container">';

echo '      <div class="user-info">
                <div class="img-and-info">
                    <img src="/student070/dwes' . $review["user_image_url"] . '"/>
                    <div class="user-and-date">
                        <h4>' . $review["user_forename"] . ' ' . $review["user_surname"] . '</h4>
                        <h5>' . $review["review_inserted_on"] . '</h5>
                    </div>
                </div>';

if ($admin) {
    echo '      <div class="icons">
                    <a href="/student070/dwes/db/db-reviews-update-state.php?user_id=' . $review["user_id"] . '&room_category_id=' . $review["room_category_id"] . '">
                        <img class="icon" src="/student070/dwes/images/add.png">
                    </a>
                    <a href="/student070/dwes/db/db-reviews-delete.php?user_id=' . $review["user_id"] . '&room_category_id=' . $review["room_category_id"] . '">
                        <img class="icon" src="/student070/dwes/images/borrar.png">
                    </a>
                </div>';
}

echo '      </div>';

echo '      <div class="review-info">
                <h3>' . $review["review"] . '</h3>
            </div>';

echo '      <div class="stars">
                <div class="linea"></div>
                <h4>' . $review["room_category_name"] . '</h4>';

for ($i = 1; $i <= $review["review_score"]; $i++) {
    echo '⭐';
}

echo '      </div>';

echo '  </div>';
echo '</div>';
?>

<?php } ?>
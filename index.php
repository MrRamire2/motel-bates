<?php $ROOT = $_SERVER['DOCUMENT_ROOT']; 
require($ROOT.'/motel-bates/db/db-apis-select.php');
require($ROOT.'/motel-bates/db/db-reviews-select.php');

session_start();
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/motel-bates/css/header.css">
    <link rel="stylesheet" href="/motel-bates/css/style.css">
    <link rel="stylesheet" href="/motel-bates/css/reviews.css">

    <link href="https://api.mapbox.com/mapbox-gl-js/v2.6.1/mapbox-gl.css" rel="stylesheet" />
    <script src="https://api.mapbox.com/mapbox-gl-js/v2.6.1/mapbox-gl.js"></script>
	
    <title>Bates motel</title>
</head>

<body>

    <?php require($ROOT . '/motel-bates/header.php'); ?>

    <main>

    <section class="temperatura" id="temperatura">
        <?php foreach ($weather_array as $data) {
            $icon_name = sprintf('%02d', $data["icon_name"]);
            $temperature = $data['temperature'];
            $date_time = $data['date_time'];
            $icon_name_src = "https://developer.accuweather.com/sites/default/files/{$icon_name}-s.png";

            api_format($icon_name_src, $temperature, $date_time);
        } ?>
    </section>

    <section class="bienvenida" id="bienvenida">
        <h1>Welcome to Bates Motel</h1>
        <p>Discover a cozy and peaceful retreat, perfect for getaways and business trips. At Bates Motel, your comfort is our priority.</p>
    </section>

    <section id="historia">
        <h2>History of the Motel</h2>
        <p>Bates Motel was founded in 1950, and since then it has been a haven for travelers and tourists. With a family-friendly atmosphere and personalized service, we have kept our mission to provide memorable experiences to our guests.</p>
    </section>

    <section class="map">
        <h2>What to see near me</h2>
        <div class="map-content">
            <div id="map" style="height: 400px; width: 100%;"></div>   
            <div class="map-options">
                <button id="restaurantBtn">Restaurant</button>
                <button id="pharmacyBtn">Pharmacy</button>
                <button id="hospitalBtn">Hospital</button>
            </div>
        </div>
    </section>

    <section id="galeria">
        <h2>Image Gallery</h2>
        <div class="galeria">
            <img src="/motel-bates/images/entrada.png" alt="Exterior of Bates Motel">
            <img src="/motel-bates/images/mesa.png" alt="Common Area of Bates Motel">
            <img src="/motel-bates/images/recepcion.png" alt="Pool at Bates Motel">
        </div>
    </section>

    <h2>Customer Reviews</h2>
    <section class="reviews" id="reviews">
        <?php foreach ($reviews as $review) {
            if (strlen($review["review"]) < 250 && $review["review_state"] > 0) {
                reviews_format($review, "f9f9fc63", false);
            }
        }
        ?>
    </section>

</main>

    <?php require($ROOT . '/motel-bates/footer.php'); ?>
    <script src="/motel-bates/js/map.js"></script>

</body>

</html>
<?php $ROOT = $_SERVER['DOCUMENT_ROOT']; ?>
<!DOCTYPE html>
<html lang="en">

  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/motel-bates/css/header.css">
    <link rel="stylesheet" href="/motel-bates/css/views.css">
    <title>Rooms</title>
  </head>

  <body>

    <?php     
    session_start();
    require($ROOT.'/motel-bates/header.php'); ?>

    <main>
    <div class="service">
        <h2>Gym</h2>
        <img class="img-service" src="/motel-bates/images/extras/gym.jpeg">
        <p>Our fully-equipped gym is designed to meet all your fitness needs. Whether you're looking to get a good workout or maintain your routine during your stay, we’ve got you covered.</p>
        <img class="img-more open" src="/motel-bates/images/cerrar.png">
        <ul class="info hidden">
            <li>State-of-the-art gym equipment</li>
            <li>Personal trainer services available upon request</li>
            <li>Free high-speed Wi-Fi</li>
            <li>Private fitness consultations</li>
            <li>Yoga and Pilates classes</li>
            <li>24/7 access for guests</li>
        </ul>
    </div>
    <div class="service">
        <h2>Spa</h2>
        <img class="img-service" src="/motel-bates/images/extras/spa.jpeg">
        <p>Indulge in our relaxing spa services, offering everything from soothing massages to beauty treatments designed to leave you feeling rejuvenated and refreshed.</p>
        <img class="img-more open" src="/motel-bates/images/cerrar.png">
        <ul class="info hidden">
            <li>Relaxing full-body massages</li>
            <li>Facials and beauty treatments</li>
            <li>Private sauna and steam rooms</li>
            <li>Rainfall shower experience</li>
            <li>Complimentary herbal teas and refreshments</li>
            <li>Trained and professional spa therapists</li>
        </ul>
    </div>
    <div class="service">
        <h2>Restaurant</h2>
        <img class="img-service" src="/motel-bates/images/extras/restaurant.jpeg">
        <p>Enjoy a gourmet dining experience at our restaurant, offering a wide variety of delicious meals made with fresh ingredients. Perfect for food lovers looking to savor every bite.</p>
        <img class="img-more open" src="/motel-bates/images/cerrar.png">
        <ul class="info hidden">
            <li>Exquisite international and local cuisine</li>
            <li>Private dining available</li>
            <li>Complimentary gourmet coffee and desserts</li>
            <li>24/7 room service</li>
            <li>Vegetarian and vegan options</li>
            <li>Wine pairing and cocktail menu</li>
        </ul>
    </div>
</main>



    <?php require($ROOT.'/motel-bates/footer.php'); ?>
    <script src="/motel-bates/js/img-transform.js"></script>
    
  </body>
</html>
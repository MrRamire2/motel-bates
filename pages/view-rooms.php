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
        <div class="room">
            <h2>Suite</h2>
            <img class="img-room" src="/motel-bates/images/rooms/suite.jpg">
            <p>Experience luxury with our spacious suites featuring premium amenities and breathtaking views.</p>
            <img class="img-more open" src="/motel-bates/images/cerrar.png">
            <ul class="info hidden">
                <li>Free high-speed Wi-Fi</li>
                <li>Private jacuzzi</li>
                <li>Complimentary breakfast</li>
                <li>42-inch Smart TV with streaming services</li>
                <li>Mini-bar</li>
                <li>Room service available 24/7</li>
            </ul>
        </div>
        <div class="room">
            <h2>Double Room</h2>
            <img class="img-room" src="/motel-bates/images/rooms/double.jpg">
            <p>Perfect for couples or small families, our double rooms offer comfort and convenience.</p>
            <img class="img-more open" src="/motel-bates/images/cerrar.png">
            <ul class="info hidden">
                <li>Free Wi-Fi</li>
                <li>Private bathroom with shower</li>
                <li>Flat-screen TV</li>
                <li>Complimentary coffee and tea</li>
                <li>Daily housekeeping</li>
            </ul>
        </div>
        <div class="room">
            <h2>Simple Room</h2>
            <img class="img-room" src="/motel-bates/images/rooms/simple.jpg">
            <p>Cozy and affordable, ideal for solo travelers looking for a restful stay.</p>
            <img class="img-more open" src="/motel-bates/images/cerrar.png">
            <ul class="info hidden">
                <li>Free Wi-Fi</li>
                <li>Ensuite bathroom</li>
                <li>Desk and chair for work</li>
                <li>Flat-screen TV</li>
                <li>Complimentary toiletries</li>
            </ul>
        </div>
    </main>

    <?php require($ROOT.'/motel-bates/footer.php'); ?>
    <script src="/motel-bates/js/img-transform.js"></script>
    
  </body>
</html>
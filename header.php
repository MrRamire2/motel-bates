<?php
//cambiar si el rol si este lo está logueado
if (!isset($_SESSION['login_user_rol'])) {
  $_SESSION['login_user_rol'] = "guest";
};

?>

<header>
  <div>
    <!-- Logo del sitio -->
    <div class="header-logo">
      <a href="#">
        <img src="/student070/dwes/images/logo.gif" alt="Bates Motel logo" />
      </a>
    </div>

    <div>
      <!-- Selector de idioma -->
      <div class="language-selector" id="google_translate_element"></div>

      <!-- Logueo -->
      <div class="login">
        <?php if (isset($_SESSION['login_forename'])) { ?>
          <div class="user_image"><img class="image" src="/student070/dwes<?php echo $_SESSION['login_user_image_url'] ?>" alt="Imagen de perfil"></div>
          <div>
            <h3>Welcome, <?php echo htmlspecialchars($_SESSION['login_forename']); ?>!</h3>
            <a href="/student070/dwes/db/db-users-logout.php">Logout</a> <!-- Enlace para cerrar sesión -->
          </div>
        <?php } else { ?>
          <a href="/student070/dwes/pages/login.php">Login</a>
        <?php }; ?>
      </div>

      <!-- Botón de reserva -->
      <div class="header-booking">
        <a href="/student070/dwes/forms/form-reservations-insert.php">Book Now</a>
      </div>
    </div>
  </div>


  <?php if ($_SESSION["login_user_rol"] === "admin") { ?>
    <!-- Menú de navegación admin -->
    <nav>
      <ul class="nav-bar-user">
        <li class="container-section">
          <a href="/student070/dwes/index.php">Home</a>
        </li>
      </ul>
      <li class="container-section">
        <a href="#" class="tittle-dropdown">Hotel</a>
        <ul class="container-dropdown">
          <li><a href="/student070/dwes/pages/view-rooms.php">Rooms</a></li>
          <li><a href="/student070/dwes/pages/view-extras.php">Extras</a></li>
        </ul>
      </li>
      <ul class="nav-bar-admin">
        <li class="container-section">
          <a href="#" class="tittle-dropdown">Rooms</a>
          <ul class="container-dropdown">
            <li><a href="/student070/dwes/pages/rooms.php">select</a></li>
            <li><a href="/student070/dwes/forms/form-rooms-insert.php">Insert</a></li>
            <li><a href="/student070/dwes/forms/form-rooms-delete-select-id.php">Delete</a></li>
            <li><a href="/student070/dwes/forms/form-rooms-update-select-id.php">Update</a></li>
          </ul>
        </li>
        <li class="container-section">
          <a href="#" class="tittle-dropdown">Users</a>
          <ul class="container-dropdown">
            <li><a href="/student070/dwes/pages/users.php">select</a></li>
            <li><a href="/student070/dwes/forms/form-users-insert.php">Insert</a></li>
            <li><a href="/student070/dwes/forms/form-users-delete-select-id.php">Delete</a></li>
            <li><a href="/student070/dwes/forms/form-users-update-select-id.php">Update</a></li>
          </ul>
        </li>
        <li class="container-section">
          <a href="#" class="tittle-dropdown">Employees</a>
          <ul class="container-dropdown">
            <li><a href="/student070/dwes/pages/employees.php">select</a></li>
            <li><a href="/student070/dwes/forms/form-employees-insert.php">Insert</a></li>
            <li><a href="/student070/dwes/forms/form-employees-delete-select-id.php">Delete</a></li>
            <li><a href="/student070/dwes/forms/form-employees-update-select-id.php">Update</a></li>
          </ul>
        </li>
        <li class="container-section">
          <a href="#" class="tittle-dropdown">Reservations</a>
          <ul class="container-dropdown">
            <li><a href="/student070/dwes/forms/form-reservations-select-filter.php">select</a></li>
            <li><a href="/student070/dwes/forms/form-reservations-insert.php">Insert</a></li>
            <li><a href="/student070/dwes/forms/form-reservations-delete-select-id.php">Delete</a></li>
            <li><a href="/student070/dwes/forms/form-reservations-update-select-id.php">Update</a></li>
            <li><a href="/student070/dwes/forms/form-extras-reservations-update-select-id.php">Add extras</a></li>
            <li><a href="/student070/dwes/forms/form-extras-reservations-select-select-id.php">See extras</a></li>
          </ul>
        </li>
        <li class="container-section">
          <a href="#" class="tittle-dropdown">Reviews</a>
          <ul class="container-dropdown">
            <li><a href="/student070/dwes/pages/reviews.php">Approve</a></li>
            <li><a href="/student070/dwes/pages/all-reviews.php">Reviews</a></li>
          </ul>
        </li>
      </ul>
    </nav>

  <?php } elseif ($_SESSION["login_user_rol"] === "customer") { ?>
    <!-- Menú de navegación customer -->
    <nav>
      <ul class="nav-bar-user">
        <li class="container-section">
          <a href="/student070/dwes/index.php">Home</a>
        </li>
      </ul>
      <ul class="nav-bar-customer">
        <li class="container-section">
          <a href="#" class="tittle-dropdown">Hotel</a>
          <ul class="container-dropdown">
            <li><a href="/student070/dwes/pages/view-rooms.php">Rooms</a></li>
            <li><a href="/student070/dwes/pages/view-extras.php">Extras</a></li>
          </ul>
        </li>
        <li class="container-section">
          <a href="#" class="tittle-dropdown">Profile</a>
          <ul class="container-dropdown">
            <li><a href="/student070/dwes/forms/form-users-update.php">Edit profile</a></li>
            <li><a href="/student070/dwes/pages/reservations.php">Reservation</a></li>
          </ul>
        </li>
      </ul>
    </nav>

  <?php } else { ?>
    <!-- Menú de navegación guest -->
    <nav>
      <ul class="nav-bar-user">
        <li class="container-section">
          <a href="/student070/dwes/index.php">Home</a>
        </li>
      </ul>
      <ul class="nav-bar-guest">
        <li class="container-section">
          <a href="#" class="tittle-dropdown">Hotel</a>
          <ul class="container-dropdown">
            <li><a href="/student070/dwes/pages/view-rooms.php">Rooms</a></li>
            <li><a href="/student070/dwes/pages/view-extras.php">Extras</a></li>
          </ul>
        </li>
      </ul>
    </nav>
  <?php }; ?>

  <?php
  ?>

</header>

<script src="/student070/dwes/js/header-dropdown.js"></script>
<script src="/student070/dwes/js/translate.js"></script>
<script type="text/javascript" src="https://translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
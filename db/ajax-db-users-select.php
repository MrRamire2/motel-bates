<?php
$q = htmlspecialchars($_GET['q']);

$ROOT = $_SERVER['DOCUMENT_ROOT'];
require($ROOT.'/student070/dwes/stable/db-connect.php');

//consulta
$sql = "SELECT * FROM 070_users_view WHERE user_status = 'active' AND CONCAT(user_forename, user_surname, user_email, user_nif) LIKE '%$q%'";

//lanzar consulta y obtener resultado
$result = mysqli_query($conn, $sql);

$confirm = "Are you sure you want to delete this user?";



echo "<table class='reservations-table'>
      <thead>
        <tr>
          <th>First Name</th>
          <th>Second Name</th>
          <th>NIF</th>
          <th>Email</th>
          <th>Phone</th>
          <th>Birthday</th>
        </tr>
      </thead>
      <tbody>";
      while($row = mysqli_fetch_array($result)) {
        echo "<tr>";
        echo "<td>" . $row['user_forename'] . "</td>";
        echo "<td>" . $row['user_surname'] . "</td>";
        echo "<td>" . $row['user_nif'] . "</td>";
        echo "<td>" . $row['user_email'] . "</td>";
        echo "<td>" . $row['user_phone'] . "</td>";
        echo "<td>" . $row['user_birthday'] . "</td>";

        echo "<td>";
        echo "<a href='/student070/dwes/forms/form-users-update.php?user_id=" . $row['user_id'] . "'>";
        echo "<img class='icon' src='/student070/dwes/images/editar.png'>";
        echo "</a>";

        echo "</a>";
        echo "<a href='/student070/dwes/confirmations/confirmation-users-delete.php?user_id=" . $row['user_id'] . "'";
        echo " onclick='return confirm(\"" . $confirm . "\");'>";
        echo "<img class='icon' src='/student070/dwes/images/borrar.png'>";
        echo "</a>";

        // echo "</a>";
        // echo "<a href='/student070/dwes/forms/form-extras-add.php?user_id=" . $row['user_id'] . "'>";
        // echo "<img class='icon' src='/student070/dwes/images/add-extras.png'>";
        // echo "</a>";

        echo "</td>";
        echo "</tr>";
      }
      echo "</tbody></table>";


// cerrar conexión
mysqli_close($conn);
?>
<?php
// $q = intval($_GET['q']);
$user_id = $_POST['userId'];

// echo $user_id;

$ROOT = $_SERVER['DOCUMENT_ROOT'];
require($ROOT . '/student070/dwes/stable/db-connect.php');

$sql = "SELECT user_forename, user_surname, user_nif FROM `070_users` WHERE user_id = $user_id";
$result = mysqli_query($conn, $sql);
$user = mysqli_fetch_assoc($result);

$user_json = json_encode($user);
// usando JSON
echo $user_json;
// enviando tabla
// echo "<table>
// <tr>
//     <th>Firstname</th>
//     <th>Lastname</th>
//     <th>NIF</th>
// </tr>";

// while ($row = mysqli_fetch_array($result)) {
//     echo "<tr>";
//     echo "<td>" . htmlspecialchars($row['user_forename']) . "</td>";
//     echo "<td>" . htmlspecialchars($row['user_surname']) . "</td>";
//     echo "<td>" . htmlspecialchars($row['user_nif']) . "</td>";
//     echo "</tr>";
// }

// echo "</table>";

mysqli_close($conn);
?>

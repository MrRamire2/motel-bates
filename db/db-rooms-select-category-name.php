<?php
$ROOT = $_SERVER['DOCUMENT_ROOT'];
require($ROOT.'/student070/dwes/stable/db-connect.php');

//guardar call en una variable
$sql = "CALL 070_select_category_name_per_price()";

  // Ejecutar la consulta y obtener el resultado
if($result = mysqli_query($conn, $sql)){
  // Tomar el resultado de las filas y guardarlo en forma de array asociativo
  $rooms_categories = mysqli_fetch_all($result, MYSQLI_ASSOC);

  //liberar resultado de la memoria
  mysqli_free_result($result);
}else{
  echo "Error en la consulta" . mysqli_error($conn);
}

//cerrar conexión
mysqli_close($conn);
?>
<?php $ROOT = $_SERVER['DOCUMENT_ROOT'];
require($ROOT.'/student070/dwes/stable/db-connect.php');


//consulta
$sql = 'SELECT * FROM 070_rooms_view';

//lanzar consulta y obtener resultado
$result = mysqli_query($conn, $sql);

//tomar el resultado de las filas y guardarlo en forma de un array
$rooms = mysqli_fetch_all($result, MYSQLI_ASSOC);

//liberar result de la memoria
mysqli_free_result($result);

// cerrar conexión
mysqli_close($conn);
?>
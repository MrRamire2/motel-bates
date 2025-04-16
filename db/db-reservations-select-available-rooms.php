<?php
include($ROOT . '/student070/dwes/db/db-rooms-select-category-name.php');
require($ROOT.'/student070/dwes/stable/db-connect.php');

// Variable para acumular todas las habitaciones disponibles
$all_rooms = [];

foreach ($rooms_categories as $rooms_category) {
    // Preparar la consulta para cada categoría
    $category_name = htmlspecialchars($rooms_category['room_category_name']);
    $sql = "CALL 070_available_rooms_by_category_and_capacity('$date_in', '$date_out', $capacity, '$category_name')";

    // Ejecutar la consulta para esta categoría
    if ($result = mysqli_query($conn, $sql)) {
        // Guardar el resultado en $all_rooms
        $rooms = mysqli_fetch_all($result, MYSQLI_ASSOC);
        $all_rooms = array_merge($all_rooms, $rooms); // Acumular resultados en $all_rooms
        mysqli_free_result($result);

        // Limpiar el conjunto de resultados actual para permitir nuevas consultas con CALL
        mysqli_next_result($conn);
    } else {
        echo "Error en la consulta para la categoría $category_name: " . mysqli_error($conn);
    }
}

// Cerrar la conexión
mysqli_close($conn);
?>

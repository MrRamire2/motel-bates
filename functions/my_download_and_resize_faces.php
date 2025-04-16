<?php
function download_and_resize_faces($names_and_dates, $output_folder, $target_width = 300) {
    // URL base de la API
    $base_url = "https://randomuser.me/api/";

    // Crear la carpeta de salida si no existe
    if (!file_exists($output_folder)) {
        mkdir($output_folder, 0777, true);
    }

    foreach ($names_and_dates as $file_name) {
        try {
            // Obtener datos de un usuario aleatorio
            $response = file_get_contents($base_url . "?inc=picture");
            if ($response === false) {
                throw new Exception("No se pudo obtener la imagen desde la API.");
            }

            // Convertir la respuesta en un array asociativo
            $user_data = json_decode($response, true);
            $image_url = $user_data['results'][0]['picture']['large'];

            // Descargar la imagen
            $image_content = file_get_contents($image_url);
            if ($image_content === false) {
                throw new Exception("No se pudo descargar la imagen.");
            }

            // Crear una imagen desde los datos obtenidos
            $image = imagecreatefromstring($image_content);
            if (!$image) {
                throw new Exception("No se pudo procesar la imagen.");
            }

            // Obtener dimensiones actuales
            $original_width = imagesx($image);
            $original_height = imagesy($image);

            // Calcular nueva altura manteniendo la relación de aspecto
            $scale = $target_width / $original_width;
            $target_height = intval($original_height * $scale);

            // Crear imagen redimensionada
            $resized_image = imagecreatetruecolor($target_width, $target_height);
            imagecopyresampled($resized_image, $image, 0, 0, 0, 0, $target_width, $target_height, $original_width, $original_height);

            // Guardar la imagen con el nombre especificado
            $output_path = $output_folder . "/" . $file_name;
            imagejpeg($resized_image, $output_path, 90); // Calidad 90%
            
            // Liberar memoria
            imagedestroy($image);
            imagedestroy($resized_image);

            echo "Rostro guardado: $output_path\n";

        } catch (Exception $e) {
            echo "Error con el archivo $file_name: " . $e->getMessage() . "\n";
        }
    }
}

// Lista de nombres y fechas proporcionados
$names_and_dates = [
    '498a8261m2556189.jpg',
    '094r8796r727284.jpg',
    '093c0802n4305503.jpg',
    '911ú6899r9568959.jpg',
    '413l0430c0763527.jpg',
    '448v8336t4215663.jpg',
    '710e5474ñ8133195.jpg',
    '763c3015o8328104.jpg',
    '918a3576r8147482.jpg',
    '830b4863u8435165.jpg',
    '684a2675r6326583.jpg',
    '346r2862m987251376.jpg',
    '218r6950p0478776.jpg',
    '167a8889r3239615.jpg',
    '516i3666r77376094.jpg',
    '765c3450n3034552.jpg',
    '300t7170m5344124.jpg',
    '347n0661r70924173.jpg',
    '734r9476i4597431.jpg',
    '62a326n.jpg',
    '676o0772m09335736.jpg',
    '196r9627r5726793.jpg'
];

// Carpeta de salida
$output_folder = "rostros_generados";

// Ejecutar la función
download_and_resize_faces($names_and_dates, $output_folder);
?>

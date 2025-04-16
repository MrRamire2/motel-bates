<!-- SI DA ERROR: Habilita la extensión GD en `C:\xampp\php\php.ini` quitando `;` de `extension=gd`, luego reinicia Apache y verifica con `phpinfo()`. -->
<?php
function save_resized_image($image_path)
{
    // Verificar si el archivo es una imagen válida antes de intentar abrirlo
    $image_info = getimagesize($image_path);
    if (!$image_info) {
        echo "El archivo no es una imagen válida.";
        return;
    }

    // Verificar el tipo MIME para asegurarse de que sea una imagen JPEG o PNG
    $mime_type = $image_info['mime'];
    if ($mime_type === 'image/jpeg' || $mime_type === 'image/jpg') {
        $image = imagecreatefromjpeg($image_path);
    } elseif ($mime_type === 'image/png') {
        $image = imagecreatefrompng($image_path);
    } else {
        echo "Formato no soportado: $mime_type";
        return;
    }

    // Redimensionar la imagen (ajustando a 200x automático)
    $resized_image = imagescale($image, 200);

    // Eliminar el archivo original
    unlink($image_path);

    // Guardar la imagen redimensionada en el mismo directorio con el mismo nombre
    if ($mime_type === 'image/jpeg' || $mime_type === 'image/jpg') {
        // Guardar la imagen JPEG
        imagejpeg($resized_image, $image_path);  
    } elseif ($mime_type === 'image/png') {
        // Guardar la imagen PNG
        imagepng($resized_image, $image_path);
    }

    // Liberar la memoria
    imagedestroy($image);
    imagedestroy($resized_image);
}

?>

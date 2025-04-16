<?php
function validator_room(&$errors)
{
    $validator = true;

    // Guardar los valores ingresados para mantenerlos en el formulario
    $room_number = htmlspecialchars($_POST['room_number']);
    $capacity = htmlspecialchars($_POST['capacity']);


    // Validación de room_number
    if (empty($room_number)) {
        $errors['room_number'] = 'A number is required';
        $validator = false;
    } else {
        if (!preg_match('/^\d{3}$/', $room_number)) {
            $errors['room_number'] = 'Not a 3 digit positive integer';
            $validator = false;
        }
    }

    // Validación de capacity
    if (empty($capacity)) {
        $errors['capacity'] = 'Capacity is required';
        $validator = false;
    } else {
        if (!preg_match('/^\d{1}$/', $capacity)) {
            $errors['capacity'] = 'Must be a 1-digit positive integer';
            $validator = false;
        }
    }

    return $validator;  // Devuelve si la validación pasó o no
}

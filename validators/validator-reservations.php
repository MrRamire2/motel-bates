<?php
function validator_reservation(&$errors)
{
  $validator = true;

  // Guardar los valores ingresados para mantenerlos en el formulario
  $date_in = htmlspecialchars($_POST['date_in']);
  $date_out = htmlspecialchars($_POST['date_out']);
  $capacity = htmlspecialchars($_POST['capacity']);


  // Validación de fecha de nacimiento (Ejemplo: formato AAAA-MM-DD)
  if (empty($date_in)) {
    $errors['date_in'] = 'required date in';
    $validator = false;
  } else {
    if (!preg_match('/^\d{4}-\d{2}-\d{2}$/', $date_in)) {
      $errors['date_in'] = 'date in format must be YYYY-MM-DD';
      $validator = false;
    } else {
      // Verificar que la fecha sea válida
      list($year, $month, $day) = explode('-', $date_in);
      if (!checkdate($month, $day, $year)) {
        $errors['date_in'] = 'invalid date';
        $validator = false;
      }
    }
  }

  // Validación de fecha de nacimiento (Ejemplo: formato AAAA-MM-DD)
  if (empty($date_out)) {
    $errors['date_out'] = 'required date out';
    $validator = false;
  } else {
    if (!preg_match('/^\d{4}-\d{2}-\d{2}$/', $date_out)) {
      $errors['date_out'] = 'date out format must be YYYY-MM-DD';
      $validator = false;
    } else {
      // Verificar que la fecha sea válida
      list($year, $month, $day) = explode('-', $date_out);
      if (!checkdate($month, $day, $year)) {
        $errors['date_out'] = 'invalid date';
        $validator = false;
      }
    }
  }

  //validar que el date_in sea menor que el date_out
  if ($date_in >= $date_out){
    $errors['date_out'] = 'date less than date in';
    $validator = false;
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

  return $validator; // Devuelve si la validación pasó o no
}

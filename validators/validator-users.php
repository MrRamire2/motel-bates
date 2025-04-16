<?php
function validator_users(&$errors)
{
  $validator = true;

  // Guardar los valores ingresados para mantenerlos en el formulario
  $user_forename = htmlspecialchars($_POST['forename']);
  $user_surname = htmlspecialchars($_POST['surname']);
  $user_nif = htmlspecialchars($_POST['nif']);
  $user_email = htmlspecialchars($_POST['email']);
  $user_phone = htmlspecialchars($_POST['phone']);
  $user_password = htmlspecialchars($_POST['password']);
  $user_birthday = htmlspecialchars($_POST['birthday']);


  // Validación de forename
  if (empty($user_forename)) {
    $errors['forename'] = 'required name';
    $validator = false;
  } else {
    if (!preg_match('/^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s\'\-]{2,50}$/', $user_forename)) {
      $errors['forename'] = 'incorrect character';
      $validator = false;
    }
  }

  // Validación de surname
  if (empty($user_surname)) {
    $errors['surname'] = 'required last name';
    $validator = false;
  } else {
    if (!preg_match('/^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s\'\-]{2,50}$/', $user_surname)) {
      $errors['surname'] = 'incorrect character';
      $validator = false;
    }
  }

  // Validación de nif
  if (empty($user_nif)) {
    $errors['nif'] = 'required NIF';
    $validator = false;
  } else {
    if (!preg_match('/^[0-9]{8}[A-Za-z]$/', $user_nif)) {
      $errors['nif'] = 'incorrect character, there are 8 numbers and 1 letter';
      $validator = false;
    }
  }

  // Validación de email
  if (empty($user_email)) {
    $errors['email'] = 'required email';
    $validator = false;
  } else {
    if (!preg_match('/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/', $user_email)) {
      $errors['email'] = 'incorrect character';
      $validator = false;
    }
  }

  // Validación de teléfono (Ejemplo: solo números, 10 dígitos en total)
  if (empty($user_phone)) {
    $errors['phone'] = 'required phone';
    $validator = false;
  } else {
    if (!preg_match('/^[0-9]{8,10}$/', $user_phone)) {
      $errors['phone'] = 'the telephone number must have between 8 or 10 digits';
      $validator = false;
    }
  }

  // Validación de contraseña (Ejemplo: mínimo 8 caracteres, al menos una letra y un número)
  if (empty($user_password)) {
    $errors['password'] = 'required password';
    $validator = false;
  } else {
    if (!preg_match('/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/', $user_password)) {
      $errors['password'] = 'password must be at least 8 characters and include a letter and a number';
      $validator = false;
    }
  }

  // Validación de fecha de nacimiento (Ejemplo: formato AAAA-MM-DD)
  if (empty($user_birthday)) {
    $errors['birthday'] = 'required birthday';
    $validator = false;
  } else {
    if (!preg_match('/^\d{4}-\d{2}-\d{2}$/', $user_birthday)) {
      $errors['birthday'] = 'birthday format must be YYYY-MM-DD';
      $validator = false;
    } else {
      // Verificar que la fecha sea válida
      list($year, $month, $day) = explode('-', $user_birthday);
      if (!checkdate($month, $day, $year)) {
        $errors['birthday'] = 'invalid date';
        $validator = false;
      }
    }
  }

  return $validator; // Devuelve si la validación pasó o no
}

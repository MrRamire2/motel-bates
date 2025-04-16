<?php
function personalized_name_gen($forename, $surname)
{
  $letter_position_to_subtract = 3;
  $total_letters_subtracted = 1;
  $rand_number = $rand_number = random_int(100000, 999999);


  $forename_letter = substr($forename, $letter_position_to_subtract, $total_letters_subtracted) ?? "";
  $surname_letter = substr($surname, $letter_position_to_subtract, $total_letters_subtracted) ?? "";


  $rand_name_result = sprintf(
    "/images/users/%s%s%s%s.jpg",
    substr($rand_number, 0, 2),
    $forename_letter,
    substr($rand_number, 2, 3),
    $surname_letter
  );


  return $rand_name_result;
}
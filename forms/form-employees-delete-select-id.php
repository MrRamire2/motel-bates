<?php $ROOT = $_SERVER['DOCUMENT_ROOT'];
session_start();

require($ROOT . '/student070/dwes/validators/redirect_customer_guest_to_login.php');

require($ROOT.'/student070/dwes/db/db-employees-select.php');
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/student070/dwes/css/header.css">
    <link rel="stylesheet" href="/student070/dwes/css/form.css">
    <title>employees</title>
</head>

<body>

    <?php require($ROOT.'/student070/dwes/header.php'); ?>

    <main>
        <h1>Delete employee</h1>
        <form action="/student070/dwes/confirmations/confirmation-employees-delete.php" name="delete" method="POST">
            <label for="employee_id">employee number</label>
            <select name="employee_id" id="employee_id">
                <?php foreach ($employees as $employee) { ?>
                    <option value="<?php echo htmlspecialchars($employee['user_id']) ?>"><?php echo htmlspecialchars($employee['user_forename'] . ' ' . $employee['user_surname'])?></option>
                <?php } ?>
            </select>
            <button class="submit" type="submit" name="delete" value="Delete">Delete</button>
        </form>

          <!-- Muestra el mensaje si existe -->
          <?php if (!empty($message)): ?>
            <div class="message"><?php echo $message; ?></div>
        <?php endif; ?>
    </main>

    <?php require($ROOT.'/student070/dwes/footer.php'); ?>

</body>
</html>

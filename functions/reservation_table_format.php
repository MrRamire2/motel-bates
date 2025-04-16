<?php
function reservation_table_format($reservations, $filter_with)
{ ?>
  <table class="reservations-table">
    <thead>
      <tr>
        <th>Reservation ID</th>
        <th>Full Name</th>
        <th>Room Number</th>
        <th>Check In</th>
        <th>Check Out</th>
        <th>Price per Day</th>
        <th>Extras</th>
        <th>Status</th>
        <th>Total Days</th>
        <th>Total Price</th>
      </tr>
    </thead>
    <tbody>
      <?php foreach ($reservations as $reservation) { ?>

        <?php if (empty($filter_with)) { ?>

          <tr>
            <td><?php echo htmlspecialchars($reservation['reservation_id']) ?></td>
            <td><?php echo htmlspecialchars($reservation['user_forename'] . " " . $reservation['user_surname']) ?></td>
            <td><?php echo htmlspecialchars($reservation['room_number']) ?></td>
            <td><?php echo htmlspecialchars($reservation['date_in']) ?></td>
            <td><?php echo htmlspecialchars($reservation['date_out']) ?></td>
            <td><?php echo htmlspecialchars($reservation['price_per_day']) ?></td>
            <td>
              <a href="/student070/dwes/forms/form-extras-see.php?reservation_id=<?php echo urlencode($reservation['reservation_id']); ?>">
                <img class='icon' src='/student070/dwes/images/vision.png'>
              </a>
              <a href="/student070/dwes/forms/form-extras-add.php?reservation_id=<?php echo urlencode($reservation['reservation_id']); ?>">
                <img class='icon' src='/student070/dwes/images/add.png'>
              </a>
            </td>
            <td><?php echo htmlspecialchars($reservation['status']) ?></td>
            <td><?php echo htmlspecialchars($reservation['total_days']) ?></td>
            <td><?php echo htmlspecialchars($reservation['total_price']) ?></td>
            <td>
              <a href="/student070/dwes/pages/Invoice.php?reservation_id=<?php echo urlencode($reservation['reservation_id']); ?>">
                <img class='icon' src='/student070/dwes/images/invoice.png'>
              </a>
              <a href="/student070/dwes/forms/form-reservations-update.php?reservation_id=<?php echo urlencode($reservation['reservation_id']); ?>">
              <img class='icon' src='/student070/dwes/images/editar.png'>
              </a>
              <a href="/student070/dwes/confirmations/confirmation-reservations-delete.php?reservation_id=<?php echo urlencode($reservation['reservation_id']); ?>"
                onclick="return confirm('Are you sure you want to delete this reservation?');">
                <img class='icon' src='/student070/dwes/images/borrar.png'>
              </a>
            </td>
          </tr>

        <?php } else { ?>

          <?php if ($reservation['status'] === $filter_with) { ?>

            <tr>
              <td><?php echo htmlspecialchars($reservation['reservation_id']) ?></td>
              <td><?php echo htmlspecialchars($reservation['user_forename'] . " " . $reservation['user_surname']) ?></td>
              <td><?php echo htmlspecialchars($reservation['room_number']) ?></td>
              <td><?php echo htmlspecialchars($reservation['date_in']) ?></td>
              <td><?php echo htmlspecialchars($reservation['date_out']) ?></td>
              <td><?php echo htmlspecialchars($reservation['price_per_day']) ?></td>
              <td>
                <a href="/student070/dwes/forms/form-extras-see.php?reservation_id=<?php echo urlencode($reservation['reservation_id']); ?>">
                  See
                </a>
                <a href="/student070/dwes/forms/form-extras-add.php?reservation_id=<?php echo urlencode($reservation['reservation_id']); ?>">
                  Add
                </a>
              </td>
              <td><?php echo htmlspecialchars($reservation['status']) ?></td>
              <td><?php echo htmlspecialchars($reservation['total_days']) ?></td>
              <td><?php echo htmlspecialchars($reservation['total_price']) ?></td>
              <td>
                <a href="/student070/dwes/pages/Invoice.php?reservation_id=<?php echo urlencode($reservation['reservation_id']); ?>">
                  Invoice
                </a>
                <a href="/student070/dwes/forms/form-reservations-update.php?reservation_id=<?php echo urlencode($reservation['reservation_id']); ?>">
                  Edit
                </a>
                <a href="/student070/dwes/confirmations/confirmation-reservations-delete.php?reservation_id=<?php echo urlencode($reservation['reservation_id']); ?>"
                  onclick="return confirm('Are you sure you want to delete this reservation?');">
                  Delete
                </a>
              </td>
            </tr>
          <?php } ?>

        <?php } ?>

      <?php } ?>
    </tbody>
  </table>
<?php } ?>
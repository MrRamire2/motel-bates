<?php function api_format($url_img, $dato, $time_array) { 
    $nameOfDay = date('D', strtotime($time_array));
    $numOfDay = date('d m', strtotime($time_array));

    ?>
        <?php
            echo '<div style="box-shadow:inset 0px 0px 70px #0a2239; color: white; display:flex; padding: 10px; margin: 10px; border-radius: 5px;">';
                echo '<img style="height: 45px;" src="' . $url_img . '">';
                echo '<div>';
                    echo '<h3>' . $dato . ' °C</h3>';
                    echo "<h5>" . substr($numOfDay, 0, 2) . " " . $nameOfDay . "</h5>";
                echo '</div>';
            echo '</div>';
        ?>
<?php } ?>
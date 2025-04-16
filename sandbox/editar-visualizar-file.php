<?php
function readFile($file){
   $myFile = fread($file, filesize($file));
};
?>
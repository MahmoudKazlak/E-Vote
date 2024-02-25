<?php

$image = '../save_files/images/'.$_GET['img'];
$imageData = base64_encode(file_get_contents($image));
echo '<img src="data:image/jpeg;base64,'.$imageData.'">';
?>
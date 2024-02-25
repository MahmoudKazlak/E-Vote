<?php
#=============== PHP file works as image file by change header Content-Type ===============

// open the file in a binary mode
$name = '../save_files/images/'.$_GET['img'];
$fp = fopen($name, 'rb');

// send the right headers
$ext=explode(".",$_GET['img'])[1];
header("Content-Type: image/$ext");
header("Content-Length: " . filesize($name));

// dump the picture and stop the script
fpassthru($fp);
exit;
#==========================================================================================
?>
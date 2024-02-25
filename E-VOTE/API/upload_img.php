<?php

	include "../config.php";

	$file_name = $_FILES['image']['name'];
	$ext = pathinfo($file_name, PATHINFO_EXTENSION);
	
	$new_name=rand(1,100)."_".rand(1,100)."_".md5($file_name).".".$ext;
	$user_id = intval($_POST['user_id']);

  #==========================
  
	$imagePath = '../save_files/images/'.$new_name;
	$tmp_name = $_FILES['image']['tmp_name'];
	move_uploaded_file($tmp_name, $imagePath);
  #==========================
  
  $sql="UPDATE member SET img='".$new_name."' WHERE 1 AND user_id=$user_id";
  $update = mysqli_query($GLOBALS['connect'], $sql);
  
  if($update)
  {
    $response=array("status"=>"succeed","image_name"=>$new_name);
    $json_encode=json_encode($response);
    //----------------------debug
    file_put_contents("debug/upload_image.debug", $json_encode);
    //----------------------
    print($json_encode);
  } 


?>

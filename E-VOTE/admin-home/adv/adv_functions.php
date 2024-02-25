


<?php
include "../open_session.php";




if (isset($_POST['_SAVE_UPDATE_BTN_']) ) 
{



	
	$name=mysqli_real_escape_string($connect,$_POST['name']);
  
  $period=intval($_POST['period']);
  

	if($_POST['_SAVE_UPDATE_BTN_'] == 'حفظ')
	{//save



    $datetime=date("Y-m-d H:i:s");
		$sql= "INSERT INTO adv (name,insert_time,period) 
				VALUES 
				('$name','$datetime',$period)";
		
		//echo $sql;
		
	    $query = mysqli_query($connect, $sql );

	    if ($query) {
					header('Location:adv.php ');
	        exit;
	    }
		
		
		
    
        
        
        
	}//save







	else if ($_POST['_SAVE_UPDATE_BTN_'] == 'تعديل') 
	{//update
		


		$adv_id=intval($_POST['adv_id']);


		$sql="UPDATE adv SET name='$name',period='$period' WHERE id='$adv_id'";
		
	
	    $query = mysqli_query($connect, $sql);


	          
	    if ($query) {
					header('Location:adv.php ');
	        exit;
	    } else {
	        echo 'cant';
	    }
	

        
        
	}//update

}

if (isset($_REQUEST['action']) && $_REQUEST['action'] == '_DELETE_DATA_') {


       if (isset($_SERVER['HTTP_REFERER'])) {

			$adv_id = intval($_GET['adv_id']);
			if ($adv_id) {

				$del = mysqli_query($connect, "DELETE FROM `adv` WHERE id='$adv_id'");
				if ($del) {
					header('Location:adv.php ');
					exit;
					
						
				}
			}

	  } else {
		    die("error request");
		}
}


	



?>



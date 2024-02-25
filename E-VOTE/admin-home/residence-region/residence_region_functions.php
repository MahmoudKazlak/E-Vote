


<?php
include "../open_session.php";



if (isset($_POST['_SAVE_UPDATE_BTN_']) ) 
{


	######################################################
	
	$name=mysqli_real_escape_string($connect,$_POST['name']);

	
	######################################################
	
	
		
	if($_POST['_SAVE_UPDATE_BTN_'] == 'حفظ')
	{//save




		$sql= "INSERT INTO residence_region (name) 
				VALUES 
				('$name')";
		
		//echo $sql;
		
	    $query = mysqli_query($connect, $sql );

	    if ($query) {
	      header('Location:residence_region.php ');
        exit();
	    }
		
		
		
    
        
        
        
	}//save







	else if ($_POST['_SAVE_UPDATE_BTN_'] == 'تعديل') 
	{//update
		


		$residence_region_id=intval($_POST['residence_region_id']);


		$sql="UPDATE residence_region SET name='$name' WHERE id='$residence_region_id'";
		
	
	    $query = mysqli_query($connect, $sql);


	          
	    if ($query) {
	        header('Location:residence_region.php ');
	        exit;
	    } else {
	        echo 'cant';
	    }
	

        
        
	}//update

}

if (isset($_REQUEST['action']) && $_REQUEST['action'] == '_DELETE_DATA_') {


       if (isset($_SERVER['HTTP_REFERER'])) {

			$residence_region_id = intval($_GET['residence_region_id']);
			if ($residence_region_id) {

				$del = mysqli_query($connect, "DELETE FROM `residence_region` WHERE id='$residence_region_id'");
				if ($del) {
	        header('Location:residence_region.php ');
					exit;
					
						
				}
			}

	  } else {
		    die("error request");
		}
}


	



?>





<?php
include "../open_session.php";



if (isset($_POST['_SAVE_UPDATE_BTN_']) ) 
{



	
	$name=mysqli_real_escape_string($connect,$_POST['name']);


	if($_POST['_SAVE_UPDATE_BTN_'] == 'حفظ')
	{//save

		#---------------------------------------------------------------------------


		$sql= "INSERT INTO specialties (name) 
				VALUES 
				('$name')";
		
		//echo $sql;
		
	    $query = mysqli_query($connect, $sql );

	    if ($query) {
	        header('Location:specialties.php ');
	        exit;
	    }
		
		
		
    
        
        
        
	}//save







	else if ($_POST['_SAVE_UPDATE_BTN_'] == 'تعديل') 
	{//update
		


		$specialist_id=intval($_POST['specialist_id']);


		$sql="UPDATE specialties SET name='$name' WHERE id='$specialist_id'";
		
	
	    $query = mysqli_query($connect, $sql);


	          
	    if ($query) {
	        header('Location:specialties.php ');
	        exit;
	    } else {
	        echo 'cant';
	    }
	

        
        
	}//update

}

if (isset($_REQUEST['action']) && $_REQUEST['action'] == '_DELETE_DATA_') {


       if (isset($_SERVER['HTTP_REFERER'])) {

			$specialist_id = intval($_GET['specialist_id']);
			if ($specialist_id) {

				$del = mysqli_query($connect, "DELETE FROM `specialties` WHERE id='$specialist_id'");
				if ($del) {
	        header('Location:specialties.php ');
					exit;
					
						
				}
			}

	  } else {
		    die("error request");
		}
}


	

?>



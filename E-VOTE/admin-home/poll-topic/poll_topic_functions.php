


<?php
include "../open_session.php";




if (isset($_POST['_SAVE_UPDATE_BTN_']) ) 
{



	
	$name=mysqli_real_escape_string($connect,$_POST['name']);
  
  $period=intval($_POST['period']);
  

	if($_POST['_SAVE_UPDATE_BTN_'] == 'حفظ')
	{//save



    $datetime=date("Y-m-d H:i:s");
		$sql= "INSERT INTO poll_topic (name,insert_time,period) 
				VALUES 
				('$name','$datetime',$period)";
		
		//echo $sql;
		
	    $query = mysqli_query($connect, $sql );

	    if ($query) {
					header('Location:poll_topic.php ');
	        exit;
	    }
		
		
		
    
        
        
        
	}//save







	else if ($_POST['_SAVE_UPDATE_BTN_'] == 'تعديل') 
	{//update
		


		$poll_topic_id=intval($_POST['poll_topic_id']);


		$sql="UPDATE poll_topic SET name='$name',period='$period' WHERE id='$poll_topic_id'";
		
	
	    $query = mysqli_query($connect, $sql);


	          
	    if ($query) {
					header('Location:poll_topic.php ');
	        exit;
	    } else {
	        echo 'cant';
	    }
	

        
        
	}//update

}

if (isset($_REQUEST['action']) && $_REQUEST['action'] == '_DELETE_DATA_') {


       if (isset($_SERVER['HTTP_REFERER'])) {

			$poll_topic_id = intval($_GET['poll_topic_id']);
			if ($poll_topic_id) {

				$del = mysqli_query($connect, "DELETE FROM `poll_topic` WHERE id='$poll_topic_id'");
				if ($del) {
					header('Location:poll_topic.php ');
					exit;
					
						
				}
			}

	  } else {
		    die("error request");
		}
}


	



?>



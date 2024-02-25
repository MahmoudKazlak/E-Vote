
<?php
include "../open_session.php";


if (isset($_REQUEST['action']) && $_REQUEST['action'] == 'delete') {


       if (isset($_SERVER['HTTP_REFERER'])) {

			#----------------------------------------------------------------------------------
			$sql="SELECT * 
			FROM `link_pollTopic_candidate` 
			WHERE 1 
			AND id=".$_GET['id'];
			
			$query = mysqli_fetch_array(mysqli_query($connect, $sql));  
			
			$poll_topic_id = $query['poll_topic_id'];

 
			#----------------------------------------------------------------------------------
       
       
			$sql="DELETE FROM `link_pollTopic_candidate` WHERE 1 AND id=".intval($_GET['id']);
			$query = mysqli_query($connect, $sql);

		    if ($query) 
		    {	
            header('Location:pollTopic_candidate.php?poll_topic='.$poll_topic_id);
		        exit;
		    }
		    
	  } else {
		    die("error request");
		}
}





?>



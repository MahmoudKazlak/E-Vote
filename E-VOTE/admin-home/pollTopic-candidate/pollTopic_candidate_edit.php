

<?php
include "../open_session.php";
?>
<html>
    <head>
    <meta charset="UTF-8"/>
        <title></title>
        <link rel='stylesheet' type='text/css' href='../assets/css/style.css'/>
        <link rel='stylesheet' type='text/css' href="../assets/css/font_family.css" rel="stylesheet">
        <link rel='stylesheet' type='text/css' href="../assets/css/fontAwesome.css" rel="stylesheet">
        
        <script src="../assets/js/jquery-2.2.4.min.js"></script>



        </head>
        <body style="background-color:#fff;">
        


<div class="title">تعيين المرشحين ضمن موضوع الاستفتاء</div>

<?php

if (isset($_GET['poll_topic_id'])) 
{
	$poll_topic_id = intval($_GET['poll_topic_id']);

	$where_poll_topic_id="  AND pollTopic_candidate.poll_topic_id= ".$_GET['poll_topic_id'];
}
else if (!isset($_GET['poll_topic_id'])) 
{
	$where_poll_topic_id="  AND pollTopic_candidate.poll_topic_id=-1 ";
}




if (isset($_GET['function_for_all_marked']['distribute_candidate']))
{


    if (isset($_SERVER['HTTP_REFERER'])) {
 
        if (isset($_GET['candidates_ids'])) {
 
            $candidates_ids = $_GET['candidates_ids']; 
			$candidate_number=0;
			
            foreach ($candidates_ids as $candidate_id) 
            {
				$candidate_number++;
                
                
				$sql1="
				INSERT INTO `link_pollTopic_candidate`
				(
				`poll_topic_id`,
				`candidate_id`
				) 
				VALUES 
				(
				'$poll_topic_id',
				'$candidate_id'
				);";

				//echo $sql1;

				$insert1 = mysqli_query($connect, $sql1);

                
			}
            ?>
            <script>alert("تم تعيين مرشحين لموضوع الاستفتاء المحدد عددهم = "+<?php echo $candidate_number;?>);</script>
            <meta http-equiv="Refresh" content="0;url=pollTopic_candidate.php?poll_topic=<?php echo $poll_topic_id;?>"/>
            <?php
            exit();
        }
    }



}










?>



<?php

    

$sql="select `id`,`name` FROM `poll_topic` WHERE 1 ";
//echo $sql;    
$all_rows = mysqli_num_rows(mysqli_query($connect, $sql));		

if ( $all_rows >0 && !empty($poll_topic_id)) 
{//main table after search




?>
<form method="GET" action="">
<input type="hidden" name="poll_topic_id" value="<?php echo $poll_topic_id ;?>"/>

<table class="tablein" width="60%" >
	<tr >
		<td>موضوع الاستفتاء 
		
			<?php 

				############################################################################################
				$poll_topic_sql="SELECT name FROM `poll_topic` WHERE 1 AND id=$poll_topic_id";
				$poll_topic_name = mysqli_fetch_array(mysqli_query($connect, $poll_topic_sql))['name'];
				############################################################################################    

				echo $poll_topic_name;
		
			?>
		
		
		</td>

	</tr>
</table>

<table class="tablein" width="60%" >


    <tr class="th4table">
		<th></th>
		<th></th>

		<th>اسم المرشح </th>


    </tr>
       
    <?php
    
	

	$sql="SELECT concat(candidate.fname,' ',candidate.lname) AS candidate_name,candidate.id AS candidate_id FROM candidate WHERE 1 AND candidate.is_canceled=0 ";		


 	//echo $sql;
    $query = mysqli_query($connect, $sql);
    $row_number=$perPage*($currentPage-1);
    while ($row = mysqli_fetch_array($query)) 
    {
		$candidate_id=$row['candidate_id'];
		
		$sqlt="SELECT COUNT(*) AS count FROM link_pollTopic_candidate LEFT JOIN poll_topic ON poll_topic.id=link_pollTopic_candidate.poll_topic_id WHERE 1 AND candidate_id=$candidate_id AND poll_topic_id=$poll_topic_id ";//حتى لا يتم تسجيل نفس المرشح مرتين في الاستفتاء
		//echo $sqlt;
		$queryt = mysqli_query($connect, $sqlt);
		$count_found = mysqli_fetch_array($queryt)['count'];
		if($count_found==0)
		{
			$row_number+=1;


		    ?>
		    <tr>
		    <td class="check"><input type="checkbox" name="candidates_ids[]" value="<?php echo $candidate_id ?>"/></td>
		        <td><?php echo $row_number ?></td>



		        <td><?php echo $row['candidate_name'] ?></td>

	 
		    </tr>   

<?php 
		}
	}
			
?>
        <tr>
            <td colspan="20"><input  class="btn btn-warning" style="width:250px;" onclick="return confirm('هل متأكد من عملية الاضافة لجميع المحدد؟')"  type='submit' name='function_for_all_marked[distribute_candidate]' value='اضافة للاستفتاء' />


            </td>

        </tr>
</table>
</form>



<?php
}//main table after search


?>





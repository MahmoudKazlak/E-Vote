

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





    

if (!empty($_GET['poll_topic'])) 
{
	$poll_topic_id = intval($_GET['poll_topic']);

	$where_poll_topic_id="  AND link_pollTopic_candidate.poll_topic_id= ".intval($_GET['poll_topic']);
}
else
{
	$where_poll_topic_id="  AND link_pollTopic_candidate.poll_topic_id=-1 ";
}


#------------------------------------------------------------

?>




<form method="GET" action="">
    <table class="barTab" style="font-weight: bold">

    <tr>
      <td>    الرجاء تحديد موضوع الاستفتاء                
        <select dir="rtl" class="stander_select_list"  name="poll_topic" id="poll_topic" style="width:190px;" onchange="this.form.submit()" >
          <option></option>
          <?php
          $query = mysqli_query($connect, "SELECT * FROM `poll_topic`  WHERE 1  ORDER BY `id` DESC");
          while ($row = mysqli_fetch_array($query)) {
          ?>
          <option value="<?php echo $row['id'];?>" <?php if($poll_topic_id==$row['id'])echo "selected";?>><?php echo $row['name'];?></option>
          <?php
          }
          ?>
        </select>
      </td>
    </tr>            
    </table>
</form>





<?php


$sql="select `id`,`name` FROM `poll_topic` WHERE 1  ";
//echo $sql;    
$all_rows = mysqli_num_rows(mysqli_query($connect, $sql));		


?>


<center>
<a href="pollTopic_candidate_edit.php?action=new_form&poll_topic_id=<?php echo $poll_topic_id;?>" style="text-decoration:none;vertical-align:center;width:140px;height:140px">
	<div align="right" class="btn btn-warning" style="float:center;color:white;font-size:1.1em;margin:10px;padding:3px;width:77px;">
		<span style="float:right;margin-right:10px;" >اضافة</span>
	</div>
</a>

</center>


	
	
<?php




?>
<form method="POST" action="pollTopic_candidate_save.php">

<input type="hidden" name="poll_topic_id" value="<?php echo $poll_topic_id ;?>"/>


<table class="tablein" width="50%">
	<tr style="background:#fff;">
		<td>
		
			موضوع الاستفتاء 
			<br>
			<strong>
			<?php 

				############################################################################################
				$poll_topic_sql="SELECT name FROM `poll_topic` WHERE 1 AND id=$poll_topic_id";
				$poll_topic_name = mysqli_fetch_array(mysqli_query($connect, $poll_topic_sql))['name'];
				############################################################################################    

				echo $poll_topic_name;
		
			?>
		  </strong>
		
		</td>

	</tr>
</table>

<table class="tablein" width="50%">


    <tr class="th4table">

		  <th></th>
		  <th>اسم المرشح </th>
		  <th  class="" >الغاء</th>
    </tr>
       
    <?php
    
    
		$sql="SELECT link_pollTopic_candidate.id AS id,concat(candidate.fname,' ',candidate.lname) AS candidate_name FROM `link_pollTopic_candidate` LEFT JOIN candidate ON candidate.id=link_pollTopic_candidate.candidate_id  WHERE 1  $where_poll_topic_id ORDER BY candidate_name";		


	//echo $sql;
 
    $query = mysqli_query($connect, $sql);
    $row_number=0;
    while ($row = mysqli_fetch_array($query)) {
		$candidates_in_class_id=$row['id'];
		$row_number+=1;

        ?>
        <tr>
            <td><?php echo $row_number ?></td>
            <td><?php echo $row['candidate_name'] ?></td>
            <td ><a class="iconDel" href="pollTopic_candidate_save.php?action=delete&id=<?php echo $candidates_in_class_id; ?>" onclick="return confirm('هل تريد الحذف؟ ')"></a></td>

                        
        </tr>   

<?php 
			
			}
?>

</table>
</form>





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
        



<div align="middle" style="width:100%;">
    <div class='title' style="width:70%;" >مواضيع الاستفتاء المشترك فيها</div>
    
<?php

if (isset($_REQUEST['action']) && $_REQUEST['action'] == '_DELETE_DATA_') {


       if (isset($_SERVER['HTTP_REFERER'])) {

			$id = intval($_GET['id']);
			if ($id) {

				$del = mysqli_query($connect, "DELETE FROM `link_pollTopic_candidate` WHERE id='$id'");
				if ($del) {
					header('Location:poll_topic.php ');
					exit;
					
						
				}
			}

	  } else {
		    die("error request");
		}
}

if (isset($_REQUEST['save_election_program']) && $_REQUEST['save_election_program'] == 'حفظ') 
{
  $id=$_POST['id'];
  $election_program=$_POST['election_program'];

  $sql = "UPDATE link_pollTopic_candidate SET election_program='$election_program' WHERE 1 AND id=$id";
  $query = mysqli_query($connect, $sql);
  header('Location:poll_topic.php ');
}


if (isset($_REQUEST['action']) && $_REQUEST['action'] == 'add_election_program') 
{
  $id=$_GET['id'];
  $sql = "SELECT election_program  FROM link_pollTopic_candidate WHERE 1 AND id=$id";
  //echo $sql;exit;
  $query = mysqli_query($connect, $sql);
  if($row = mysqli_fetch_array($query))$election_program=$row['election_program'];
?>
<form method="POST" action="" enctype="multipart/form-data">

    <table dir="rtl" width="70%" class="tablein">

        <tr>
            <td width=25%>البرنامج الانتخابي</td>
            <td><textarea style="width:90%;height:66px;" name="election_program"><?php echo htmlspecialchars($election_program); ?></textarea></td>
        </tr>

        <tr>

        <tr>
            <td></td>
		    	<input type='hidden' name='id' value='<?php echo $id;?>' />
		    	<td><input type='submit' name='save_election_program' value='حفظ'/></td>				                      	
        </tr>

    </table>
</form>
<?php
exit;
}
?>




<table class="table" style="width:70%">
    <tr class="firstTR">
        <th width="3%"></th>


        <th width="40%">اسم مواضيع الاستفتاء</th>
        <th width="10%">البرنامج الانتخابي</th>
        <th width="10%">الغاء المشاركة</th>
        <th width="10%">تقرير الاصوات</th>
 
    </tr>
    <?php
    

    	
    
		$sql = "SELECT link_pollTopic_candidate.id, poll_topic.name,link_pollTopic_candidate.poll_topic_id  FROM link_pollTopic_candidate LEFT JOIN poll_topic ON poll_topic.id=link_pollTopic_candidate.poll_topic_id WHERE 1 AND link_pollTopic_candidate.candidate_id=$_SESSION[candidate_id] ORDER BY poll_topic.id DESC";

    //echo $sql;
 
    $query = mysqli_query($connect, $sql);
    $row_number=1;
    while ($row = mysqli_fetch_array($query)) {
        $id = $row['id'];

        $poll_topic_id = $row['poll_topic_id'];
        
        $row_number=$row_number+1;


		    $poll_topic_name=stripslashes($row['name']);
		    $poll_topic_name=$row['name'];

        ?>
        <tr>
            <td><?php echo $row_number; ?></td>

            

            <td><span style="color:blue"><?php echo $poll_topic_name; ?></span></td>
            

             
            <td><a class="fa fa-list" style="text-decoration:none;color:green;font-size:1.4em;" href="?action=	add_election_program&id=<?php echo $id; ?>" ></a></td>
            
            <td><a class="fa fa-sign-out" style="text-decoration:none;color:red;font-size:1.4em;" href="?action=_DELETE_DATA_&id=<?php echo $id; ?>" onclick="return confirm('الغاء الاشتراك في الاستفتاء؟ ')"></a></td>
            
            <td><a class="fa fa-bar-chart" style="text-decoration:none;color:orange;text-shadow:0px 0px 1px #000;font-size:1.4em;" href="show_chart.php?poll_topic_id=<?php echo $poll_topic_id; ?>" ></a></td>

        </tr>
    <?php 
    }
    
    
    
     ?>
</table>



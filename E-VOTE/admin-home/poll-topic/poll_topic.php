

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
    <div class='title' style="width:60%;" >مواضيع الاستفتاء</div>

<?php








?>

<a href="poll_topic_form.php" >
	<div align="right" class="btn btn-warning" style="color:white;font-size:1.1em;margin:10px;">

		<span style="float:right;margin-right:10px;" >اضافة مواضيع استفتاء</span>

	</div>
</a>



<table class="table" style="width:60%">
    <tr class="firstTR">
        <th width="3%"></th>


        <th width="40%">اسم مواضيع الاستفتاء</th>
        <th width="20%">وقت الانشاء</th>
        <th width="20%">مدة الاستفتاء<br>(ساعات)</th>
        
        <th width="20%">تقرير الاصوات</th>
        
        <th width="3%">تعديل</th>
        <th width="3%">حذف</th>
 
    </tr>
    <?php
    

    	
    
		$sql = "SELECT * FROM poll_topic WHERE 1 ORDER BY poll_topic.id DESC";

 
    $query = mysqli_query($connect, $sql);
    $row_number=1;
    while ($row = mysqli_fetch_array($query)) {
        $id = $row['id'];


        $row_number=$row_number+1;


		    $poll_topic_name=stripslashes($row['name']);
		    $poll_topic_name=$row['name'];
		    $period=$row['period'];
		    
		    $insert_time=date("Y-m-d H:i",strtotime($row['insert_time']));

        ?>
        <tr>
            <td><?php echo $row_number; ?></td>

            

            <td><span style="color:#259990"><?php echo $poll_topic_name; ?></span></td>
            <td dir="ltr"><span style="color:#888"><?php echo $insert_time; ?></span></td>
            <td ><span style="color:#888"><?php echo $period; ?></span></td>
            
            <td><a class="fa fa-bar-chart" style="text-decoration:none;color:orange;text-shadow:0px 0px 1px #000;font-size:1.4em;" href="show_chart.php?poll_topic_id=<?php echo $id; ?>" ></a></td>
            
              
            <td><a href="poll_topic_form.php?action=update_form&poll_topic_id=<?php echo $id; ?>"><img width=18 src="../assets/icons/update.png" title="تعديل معلومات مواضيع الاستفتاء"/></a></td>
            
            
            <td><a href="poll_topic_functions.php?action=_DELETE_DATA_&poll_topic_id=<?php echo $id; ?>"><img width=18 src="../assets/icons/delete.png" title="حذف مواضيع الاستفتاء" onclick="return confirm('هل تريد بالتأكيد حذف السجل ')"/></a></td>

        </tr>
    <?php 
    }
    
    
    
     ?>
</table>



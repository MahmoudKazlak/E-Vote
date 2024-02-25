

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
    <div class='title' style="width:60%;" > الاعلان</div>

<?php








?>

<a href="adv_form.php" >
	<div align="right" class="btn btn-warning" style="color:white;font-size:1.1em;margin:10px;">

		<span style="float:right;margin-right:10px;" >اضافة اعلان</span>

	</div>
</a>



<table class="table" style="width:60%">
    <tr class="firstTR">
        <th width="3%"></th>


        <th width="40%"> الاعلان</th>
        <th width="20%">وقت الانشاء</th>
        <th width="20%">مدة الاعلان<br>(ساعات)</th>

        <th width="3%">تعديل</th>
        <th width="3%">حذف</th>
 
    </tr>
    <?php
    

    	
    
		$sql = "SELECT * FROM adv WHERE 1 ORDER BY adv.id DESC";

 
    $query = mysqli_query($connect, $sql);
    $row_number=1;
    while ($row = mysqli_fetch_array($query)) {
        $id = $row['id'];


        $row_number=$row_number+1;


		    $adv_name=stripslashes($row['name']);
		    $adv_name=$row['name'];
		    $period=$row['period'];
		    
		    $insert_time=date("Y-m-d H:i",strtotime($row['insert_time']));

        ?>
        <tr>
            <td><?php echo $row_number; ?></td>

            

            <td><span style="color:#259990"><?php echo $adv_name; ?></span></td>
            <td dir="ltr"><span style="color:#888"><?php echo $insert_time; ?></span></td>
            <td ><span style="color:#888"><?php echo $period; ?></span></td>
            

            <td><a href="adv_form.php?action=update_form&adv_id=<?php echo $id; ?>"><img width=18 src="../assets/icons/update.png" title="تعديل معلومات الاعلان"/></a></td>
            
            
            <td><a href="adv_functions.php?action=_DELETE_DATA_&adv_id=<?php echo $id; ?>"><img width=18 src="../assets/icons/delete.png" title="حذف الاعلان" onclick="return confirm('هل تريد بالتأكيد حذف السجل ')"/></a></td>

        </tr>
    <?php 
    }
    
    
    
     ?>
</table>



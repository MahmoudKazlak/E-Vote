

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
    <div class='title' style="width:60%;" >التخصص</div>

<?php








?>

<a href="specialties_form.php" >
	<div align="right" class="btn btn-warning" style="color:white;font-size:1.1em;margin:10px;">

		<span style="float:right;margin-right:10px;" >اضافة تخصص</span>

	</div>
</a>



<table class="table" style="width:60%">
    <tr class="firstTR">
        <th width="3%"></th>


        <th width="40%">اسم التخصص</th>

        <th width="3%">تعديل</th>
        <th width="3%">حذف</th>
 
    </tr>
    <?php
    

    	
    
		$sql = "SELECT specialties.id, specialties.name  FROM specialties WHERE 1 ORDER BY specialties.id DESC";

 
    $query = mysqli_query($connect, $sql);
    $row_number=1;
    while ($row = mysqli_fetch_array($query)) {
        $id = $row['id'];


        $row_number=$row_number+1;


		    $specialist_name=stripslashes($row['name']);
		    $specialist_name=$row['name'];

        ?>
        <tr>
            <td><?php echo $row_number; ?></td>

            

            <td><span style="color:blue"><?php echo $specialist_name; ?></span></td>
            

              
            <td><a href="specialties_form.php?action=update_form&specialist_id=<?php echo $id; ?>"><img width=18 src="../assets/icons/update.png" title="تعديل معلومات التخصص"/></a></td>
            
            
            <td><a href="specialties_functions.php?action=_DELETE_DATA_&specialist_id=<?php echo $id; ?>"><img width=18 src="../assets/icons/delete.png" title="حذف التخصص" onclick="return confirm('هل تريد بالتأكيد حذف السجل ')"/></a></td>

        </tr>
    <?php 
    }
    
    
    
     ?>
</table>






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
        

<?php


$name="";




$action_function="new";

if (isset($_REQUEST['action']) && $_REQUEST['action'] == 'update_form') {

   if (isset($_SERVER['HTTP_REFERER'])) 
   {
		$action_function="update";

		$residence_region_id=$_GET['residence_region_id'];

		$sql="SELECT * FROM residence_region WHERE 1 AND residence_region.id=$residence_region_id";  
		   
		//echo $sql;

		$query=mysqli_query($connect,$sql);
		$row = mysqli_fetch_array($query);



		$name=htmlspecialchars($row['name']);



			

   
	} 
	else 
	{
	    die("error request");
	}
}


?>

<form method="POST" action="residence_region_functions.php" enctype="multipart/form-data">

    <table dir="rtl" width="70%" class="tablein">

        
        <tr>
            <td width=25%>اسم مكان الاقامة</td>
            <td><input class="cp_input" style="width:260px;" type="text" name="name" required="required" value='<?php echo stripslashes($name); ?>' required/></td>
        </tr>


        
        <tr>
            <td></td>
            
			<?php 
		    if($action_function=="update")
		    {
		    ?>
		    
		    	<input type='hidden' name='residence_region_id' value='<?php echo $residence_region_id;?>' />
		    	<td><input type='submit' name='_SAVE_UPDATE_BTN_' value='تعديل'/></td>				    
		    <?php
		    }
		    else if($action_function=="new")
		    {
		    ?>							    
					    
            	<td><input type='submit' name='_SAVE_UPDATE_BTN_' value='حفظ' /></td>
            	
		    <?php
		    }
		    ?>                    	
        </tr>
        
        
        
    </table>
</form>

        
        


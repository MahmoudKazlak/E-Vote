


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

		$adv_id=$_GET['adv_id'];

		$sql="SELECT * FROM adv WHERE 1 AND adv.id=$adv_id";  
		   
		//echo $sql;

		$query=mysqli_query($connect,$sql);
		$row = mysqli_fetch_array($query);




		$name=htmlspecialchars($row['name']);

    $period=intval($row['period']);


			

   
	} 
	else 
	{
	    die("error request");
	}
}


?>

<form method="POST" action="adv_functions.php" enctype="multipart/form-data">

    <table dir="rtl" width="50%" class="tablein">

        
        <tr>
            <td width=25%> الاعلان</td>
            <td align="right"><input class="cp_input" style="width:260px;float:right;" type="text" name="name" required="required" value='<?php echo stripslashes($name); ?>' required/></td>
         
         </tr>
         <tr>   
            <td width=25%>مدة الاعلان</td>
            <td align="right"><input class="cp_input" style="width:260px;float:right;text-align:center;" type="number" name="period" required="required" value='<?php echo intval($period); ?>' required/><span style="float:right;font-size:1.1em;font-weight:bold;color:#555;margin:3px;">ساعة</span></td>
        </tr>
        
        

        
        <tr>




        
        <tr>
            <td></td>
            
			<?php 
		    if($action_function=="update")
		    {
		    ?>
		    
		    	<input type='hidden' name='adv_id' value='<?php echo $adv_id;?>' />
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

  





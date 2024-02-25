

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
        

		
<script>


function run_controller(element,action)
{
	var fname=$("[name='fname']").val();
  var lname=$("[name='lname']").val();
  
  var bio=$("[name='bio']").val();
  var phone=$("[name='phone']").val();

	
	var birthdate=$("[name='birthdate']").val();
	var gender_id=$("[name='gender_id']").val();
	
	
	var residence_region_id=$("[name='residence_region_id'] option:selected ").val();
	var specialty_id=$("[name='specialty_id'] option:selected ").val();
	
	var activation=$("[name='activation'] option:selected ").val();



	
	

	if(fname=='' || lname=='' || fname.length<3 || lname.length<3)
	{
		alert('يجب ادخال الاول والاخير بالشكل الصحيح');
		return;
	}
	
	if(residence_region_id==0||residence_region_id==''||residence_region_id===undefined)
	{
		alert('يجب تحديد مكان الاقامة ');
		return;
	}
	if(specialty_id==0||specialty_id==''||specialty_id===undefined)
	{
		alert('يجب تحديد التخصص');
		return;
	}


	var loginname=$("#loginname").val();

	var password=$("#password").val();
	var confirm_password=$("#confirm_password").val();
	
	
	
  //var pass_data={};
	var pass_data = new FormData();
	pass_data.append('action',action);
	pass_data.append('fname',fname);
  pass_data.append('lname',lname);
  pass_data.append('bio',bio);
  pass_data.append('phone',phone);
  pass_data.append('img',$("[name='img']")[0].files[0]);/////

	pass_data.append('birthdate',birthdate);
	pass_data.append('gender_id',gender_id);
	
	pass_data.append('activation',activation);

	pass_data.append('residence_region_id',residence_region_id);
	pass_data.append('specialty_id',specialty_id);

	pass_data.append('loginname',loginname);
	pass_data.append('password',password);
	pass_data.append('confirm_password',confirm_password);


	if(action=='edit_row')
	{
		var row_id=$("#row_id").val();
		if(row_id==0||row_id==''||row_id===undefined)
		{
			alert('حدث خلل رقم السجل');
			return;
		}

		pass_data.append('row_id',row_id);
	}

	

	$.ajax({
		type:"POST",
		url:"candidate_fun.php",
		data:pass_data,
		contentType: false, // NEEDED, DON'T OMIT THIS (requires jQuery 1.6+)
    	processData: false, // NEEDED, DON'T OMIT THIS
		success: function(response) {

			//alert(3);
			response=JSON.parse(response.trim());
		
			if(response.head=="ok")
			{
				//alert(response.body);
				$("#response-msg").css({color:"green",});
				$("#response-msg").text(response.body);	
				setTimeout(function(){ 
					if(action=='add_row')window.history.back();
					else location.reload(); 
				}, 2000);
			}
			else if(response.head=="error")
			{
				//alert(response.body);
				$("#response-msg").css({color:"red",});
				$("#response-msg").text(response.body);	
			}

	 	}
	});
		
					


}

</script>





<?php

$action_function="add_row";

if ($_GET['action'] == 'edit_row' || $_GET['action'] == 'view_data') {

	
       if (isset($_SERVER['HTTP_REFERER'])) 
       {
       
			$row_id = intval($_GET['row_id']);
			$sql="SELECT * FROM candidate WHERE candidate.id='$row_id'";
			
			//echo $sql;
		    $query = mysqli_query($connect, $sql);
		    $row = mysqli_fetch_array($query);

		    $fname = htmlspecialchars($row['fname']);
		    $residence_region_id = $row['residence_region_id'];
		    $specialty_id = $row['specialty_id'];


		    $birthdate = htmlspecialchars($row['birthdate']);
        $fingerprint_act=$row['fingerprint_act'];
        $activation=$row['activation'];
        
        $gender_id=$row['gender_id'];
        $lname=$row['lname'];
        $bio=$row['bio'];
        $phone=$row['phone'];
        
        $img=htmlspecialchars($row['img']);
		    $src="../../save_files/images/$img";
		    if(!file_exists($src) || is_dir($src))//اذا الملف غير موجود او اصلا غير مخزن ملف فيكون هذا عبارة عن مرشح مجلد وليس ملف
		    {
			    $src='../../public-assets/images/empty.png';
		    }
			    
		    $element_image='<img src="'.$src.'" style="max-width:100px;max-height:100px;"/>';
		    
		    
		    
			  $sql="SELECT * FROM users WHERE id='$row[user_id]'";
		    $user_query = mysqli_query($connect, $sql);
		    $user_row = mysqli_fetch_array($user_query);
        $loginname = $user_row['loginname'];

       
	  } else {
		    die("error request");
		}
}


if ($_GET['action'] == 'edit_row') 
{
	$action_function="edit_row";
}



?>




<div align="middle">
<div class="title" style="">معلومات المرشح</div>


<table dir="rtl" width="80%" class="tablein" style="border:1px dashed #999;">
   
  <tr>
      <td width="25%">الاسم الاول</td>
      <td><input type="text" name="fname" class="cp_input" style="" required="required" value='<?php echo $fname; ?>' /></td>
      <td></td>
      <td></td>
  </tr>
  <tr>
    <td width="25%">الاسم الاخير</td>
      <td><input type="text" name="lname" class="cp_input" style="" required="required" value='<?php echo $lname; ?>' /></td>
  </tr>
  <tr>
    <td width="25%">نبذة</td>
      <td><input type="text" name="bio" class="cp_input" style="" required="required" value='<?php echo $bio; ?>' /></td>
  </tr>
  <tr>
    <td width="25%">هاتف</td>
      <td><input type="text" name="phone" class="cp_input" style="" required="required" value='<?php echo $phone; ?>' /></td>
  </tr>
  <tr>
    <td>صورة </td>
    <td>
        <input type="file" name="img" />
        <div class="clear"></div>
        <?php echo $element_image; ?>
        <input type="hidden" name="oldimg" value="<?php echo $img ?>"  />
    </td>
  </tr>
  <tr>
      <td>تاريخ الميلاد</td>
      <td><input type="date" class="cp_input"  style="" name="birthdate" value="<?php echo $birthdate; ?>" /></td>
  </tr>
  <tr>
    <td>الجنس</td>
    <td>
      <select class="stander_select_list" name="gender_id" required="required">
      <option value="1" <?php if($gender_id == 1)echo "selected";?>>ذكر</option>
      <option value="2" <?php if($gender_id == 2)echo "selected";?>>أنثى</option>
      </select>
    </td>
  </tr>
  

  <tr>
      <td width="25%">مكان الاقامة </td>
    
      <td>
        <select class="stander_select_list" name="residence_region_id"  id="residence_region_id"  onchange="create_specialty(null);" style="" >
          <option></option>
          <?php
          $query_residence_region = mysqli_query($connect, "SELECT * FROM residence_region ORDER BY id DESC ");
          while ($row_residence_region = mysqli_fetch_array($query_residence_region)) {
          ?>
          
          <option value="<?php echo $row_residence_region['id'];?>" <?php if($residence_region_id==$row_residence_region['id'])echo "selected";?>><?php echo $row_residence_region['name'];?></option>
          <?php
          }
        
        ?>
        </select>   

    </td>
</tr>
<tr>
   <td width="25%">التخصص</td>
   <td>

	<select dir="rtl" class="stander_select_list"  name="specialty_id" id="specialty_id"  style="" required>
		<option value=""></option>
		<?php
          $query_specialty = mysqli_query($connect, "SELECT * FROM specialties ORDER BY id DESC ");
          while ($row_specialty = mysqli_fetch_array($query_specialty)) {
          ?>
          
          <option value="<?php echo $row_specialty['id'];?>" <?php if($specialty_id==$row_specialty['id'])echo "selected";?>><?php echo $row_specialty['name'];?></option>
          <?php
          }
        
        ?>
    </select>

    </td>
    </tr>


    <tr><td colspan=4><hr></td></tr>

    <tr>
      <td  style="color:black;">اسم المستخدم</td><td><input dir="ltr" type="text" style="text-align:center;font-size:1.0em;font-weight:bold;color:black;" class="cp_input" value="<?php echo $loginname ?>" id="loginname" autocomplete="off" placeholder="اسم المستخدم"/></td>
    </tr> 
    <tr>
      <td  style="color:black;">كلمة المرور</td><td><input dir="ltr" type="password" style="text-align:center;font-size:1.0em;font-weight:bold;color:black;" class="cp_input" value="" id="password" autocomplete="new-password" placeholder="كلمة المرور"/></td>
    </tr> 

    <tr>
      <td  style="color:black;">تاكيد كلمة المرور</td><td><input dir="ltr" type="password" style="text-align:center;font-size:1.0em;font-weight:bold;color:black;" class="cp_input" value="" id="confirm_password" autocomplete="new-password" placeholder="تاكيد كلمة المرور"/></td>
    </tr> 

      
      <tr>
          <td>حالة الحساب</td>
          <td>
              <select class="stander_select_list" name="activation" required="required">
                <option value="1" <?php if($activation == 1)echo "selected";?>>فعال</option>
                <option value="2" <?php if($activation == 2)echo "selected";?>>غير فعال</option>
              </select>
          </td>

      </tr>
      
      




    <tr class="control_showing" >
    		<?php 
		    if($action_function=="edit_row")
		    {
		    ?>
		    	<input type='hidden' id='row_id' value='<?php echo $row_id;?>' />
		    	<td colspan=2>
		    	
		    		<button class="btn btn-success" type='submit' onclick="run_controller(this,'edit_row');" >حفظ</button>
		    	</td>
		    <?php
		    }
		    else if($action_function=="add_row")
		    {
		    ?>
		    	<td colspan=2>
		    		<button class="btn btn-success" type='submit' onclick="run_controller(this,'add_row');" >اضافة</button>
		    	</td>
		    <?php
		    }
		    ?>
    </tr>
    <tr><td colspan=2 align="middle"><div id="response-msg"></div></td></tr>


</table>





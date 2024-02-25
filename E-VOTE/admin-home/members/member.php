

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


function delete_row_fun(element,action,row_id)
{

	var ok=confirm("هل تريد بالتاكيد حذف السجل؟");
	if(!ok)return;
	
	var pass_data={
		'action':action,
		'row_id':row_id,
	}


	$.ajax({
		type:"POST",
		url:"member_fun.php",
		data:pass_data,
		success: function(response) {

			response=JSON.parse(response.trim());
		
			if(response.head=="ok")
			{
				$(element).parent().parent().fadeOut('slow');
	
			}
			else if(response.head=="error")
			{
				alert(response.body);
			}
			

	 	}
	});
		
					


}

</script>


<div class="title">سجل الأعضاء</div>


<br>
<center>
<a class="btn btn-warning" href="member_form.php?action=add_row&residence_region_id=<?php echo $residence_region_id;?>&specialty_id=<?php echo $specialty_id;?>" >
		<span style="float:right;margin-right:10px;" >اضافة عضو</span>
</a>

</center>
<br>
<table class="table" width="100%" >
    <tr class="firstTR">
    
        <th width="3%"></th>
        <th width="7%">الصورة</th>
        <th width="16%">الإسم</th>
        <th width="16%">نبذة</th>

        <th width="5%">الجنس</th>
        <th width="9%">تاريخ الميلاد</th>

        

        <th width="12%" >مكان الاقامة</th>
        <th width="12%" >التخصص</th>
        
        <th width="6%">حالة الحساب</th>
        <th width="1%">تعديل</th>
        <th width="1%">حذف</th>
 
    </tr>
    <?php

    
		$sql = "SELECT 
		member.id,
		member.fname,
		member.lname,
		member.img,
		member.bio,
		member.gender_id,
		member.birthdate,
		member.activation,
		specialties.name as specialties_name,
		residence_region.name as residence_region_name 
		FROM member 
		LEFT JOIN specialties ON member.specialty_id=specialties.id 
		LEFT JOIN residence_region ON member.residence_region_id=residence_region.id   
		WHERE 1  
		AND member.is_canceled=0 
		ORDER BY member.id DESC";
    //echo $sql;
    
    $query = mysqli_query($connect, $sql);
    $row_number=0;
    while ($row = mysqli_fetch_array($query)) {
        $id = $row['id'];
        $row_number=$row_number+1;



		    $member_id=$row['member_id'];

        
        $activation = $row['activation'];
        $activationi="";
        if ($activation == 1) {
            $activationi = "<span style='color:green'>فعال</span>";
        } elseif ($activation == 2) {
            $activationi = "<span style='color:orange'>غير فعال</span>";
        } 
        
        

        ?>
        <tr>
            <td><?php echo $row_number; ?></td>
            <td><?php if($row['img']){?><img src="../../save_files/images/<?php echo $row['img']; ?>" style="width:77px;border-radius:5px;" /><?php }?></td>
            <td><?php echo $row['fname']." ".$row['lname']; ?></td>
            <td><?php echo $row['bio']; ?></td>
            <td><?php echo array(1=>"M",2=>"F")[$row['gender_id']]; ?></td>
            <td><?php echo $row['birthdate']; ?></td>

            
   
            <td><span style="color:#555;font-weight:bold;"><?php echo $row['residence_region_name']; ?></span></td>
            <td><span style="color:#888"><?php echo $row['specialties_name']; ?></span></td>

            <td><?php echo $activationi; ?></td>
            
            <td><a class="iconEdit" title="تعديل  " href="member_form.php?action=edit_row&row_id=<?php echo $id; ?>"> </a></td>
            <td><a class="iconDel" onclick="delete_row_fun(this,'cancel_row',<?php echo $id; ?>)" title="حذف " ></a></td>

        </tr>
    <?php 
    }
     ?>
</table>




<?php
include "open_session.php";
?>

<html>
    <head>
    <meta charset="UTF-8"/>
        <title></title>
        <link rel='stylesheet' type='text/css' href='assets/css/style.css'/>
        <link rel='stylesheet' type='text/css' href="assets/css/font_family.css" rel="stylesheet">
        <link rel='stylesheet' type='text/css' href="assets/css/fontAwesome.css" rel="stylesheet">
        
        <script src="assets/js/jquery-2.2.4.min.js"></script>



        </head>
        <body style="background-color:#fff;">
        
<?php
if($_GET['action']=="is_done")
{
    $sql = " UPDATE restore_password SET is_done=1 WHERE 1 AND id=$_GET[id] ";
    $query = mysqli_query($connect, $sql);
}
?>



<div class="title">طلبات استعادة كلمة المرور</div>


<br>
<table class="tablein" width="55%" >
    <tr class="firstTR">
    
        <th width="3%"></th>

        <th width="15%">اسم العضو</th>
        <th width="15%">الهاتف</th>

        <th width="4%">تعديل الباسوورد</th>
        <th width="4%">تم التعديل</th>
 
    </tr>
    <?php

    
		$sql = "SELECT 
		restore_password.id ,
		member.id as member_id,
		member.phone,
		member.fname,
		member.lname
		FROM restore_password 
		LEFT JOIN member ON restore_password.user_id=member.user_id 
		WHERE 1  
		AND user_level_id=3
		AND restore_password.is_done=0 
		ORDER BY restore_password.id DESC";
    //echo $sql;
    
    $query = mysqli_query($connect, $sql);
    $row_number=0;
    while ($row = mysqli_fetch_array($query)) {
        $id = $row['id'];
        $row_number++;
		    $member_id=$row['member_id'];

        ?>
        <tr>
            <td><?php echo $row_number; ?></td>

            <td><?php echo $row['fname']." ".$row['lname']; ?></td>
            <td><?php echo $row['phone'];?></td>
            
            <td><a href="members/member_form.php?action=edit_row&row_id=<?php echo $member_id; ?>"><img src="assets/icons/update1.png" width=30 /></a></td>
            <td><a href="?action=is_done&id=<?php echo $id; ?>" title="تم " onclick="return confirm('is reseted?');" ><img src="assets/icons/finish.png" width=30 /></a></td>

        </tr>
    <?php 
    }
     ?>
</table>


<br>
<table class="tablein" width="55%" >
    <tr class="firstTR">
    
        <th width="3%"></th>

        <th width="15%">اسم المرشح</th>
        
        <th width="15%">الهاتف</th>

        <th width="4%">تعديل الباسوورد</th>
        <th width="4%">تم التعديل</th>
 
    </tr>
    <?php

    
		$sql = "SELECT 
		restore_password.id ,
		candidate.id as candidate_id,
		candidate.phone,
		candidate.fname,
		candidate.lname
		FROM restore_password 
		LEFT JOIN candidate ON restore_password.user_id=candidate.user_id 
		WHERE 1  
		AND user_level_id=2
		AND restore_password.is_done=0 
		ORDER BY restore_password.id DESC";
    //echo $sql;
    
    $query = mysqli_query($connect, $sql);
    $row_number=0;
    while ($row = mysqli_fetch_array($query)) {
        $id = $row['id'];
        $row_number++;
		    $candidate_id=$row['candidate_id'];

        ?>
        <tr>
            <td><?php echo $row_number; ?></td>

            <td><?php echo $row['fname']." ".$row['lname']; ?></td>
            <td><?php echo $row['phone'];?></td>

            
            <td><a href="candidate/candidate_form.php?action=edit_row&row_id=<?php echo $candidate_id; ?>"><img src="assets/icons/update1.png" width=30 /></a></td>
            <td><a href="?action=is_done&id=<?php echo $id; ?>" title="تم " onclick="return confirm('is reseted?');" ><img src="assets/icons/finish.png" width=30 /></a></td>

        </tr>
    <?php 
    }
     ?>
</table>




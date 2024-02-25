

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
        
        
        
<div class="title">التحكم بالإداريين</div>
<?php


if (isset($_REQUEST['action']) && $_REQUEST['action'] == 'delete') {


  $user_id = intval($_GET['admin_id']);
  $sel = mysqli_query($connect, "SELECT * FROM admin WHERE 1 AND is_canceled=0");
  $count=mysqli_num_rows($sel);
  if($count<=1)
  {
    $error_msg="هذا اخر حساب للادارة لا يمكن حذفه";
  }
  else
  {
    if ($user_id) 
    {
      $del1 = mysqli_query($connect, "UPDATE admin SET is_canceled=1 WHERE user_id='$user_id' ");
      $del2 = mysqli_query($connect, "UPDATE users SET is_canceled=1 WHERE id='$user_id' ");			

      if ($del1&&$del2) {
        header('Location:admin.php ');
        exit;
      }
    }
  }
    
}

if (isset($_POST['editAdmin']) && $_POST['editAdmin'] == 'تعديل بيانات المدير') {



    $admin_id = $_POST['adminIdUpdt'];
    $loginname = $_POST['loginname'];
    $userPass = $_POST['userPass'];
    $huserPass = $_POST['huserPass'];
    $adminFName = $_POST['adminFName'];
    $adminLName = $_POST['adminLName'];
    
    if (!empty($userPass)) {

        $userPass = md5(sha1($userPass));
       
    } else {
        $userPass = $huserPass;
    }
    
    $updt1 = mysqli_query($connect, "UPDATE admin SET
			name='" . $adminFName . "',
			identification_number='" . $adminLName . "' 
			WHERE id=" . $admin_id );
			
	$sel = mysqli_query($connect, "SELECT * FROM admin WHERE id=$admin_id");
	$user_id = mysqli_fetch_array($sel)['user_id'];


    $updt2 = mysqli_query($connect, "UPDATE users SET
			loginname='" . $loginname . "',
			password='" . $userPass . "' 
			WHERE id=" . $user_id );
			
						
			
    if ($updt1&&$updt2) {
        header('Location:admin.php ');
        exit;
    }
}





if (@$_REQUEST['action'] == 'edit') {
    $edit_admin_id = $_GET['editId'];
    
    $sel = mysqli_query($connect, "SELECT * FROM admin WHERE id='$edit_admin_id'");
    $row_admin = mysqli_fetch_array($sel);
    $user_id = $row_admin['user_id'];
        
    $sel = mysqli_query($connect, "SELECT * FROM users WHERE id='$user_id'");
    $row_user = mysqli_fetch_array($sel);
    

    ?>
    <form method="post">
        <table width="40%" class="tablein" style="border:1px dashed black;">
        
            
            <tr>
                <td>الاسم</td>
                <td><input type="text" class="cp_input" name="adminFName" required="required" value="<?php echo $row_admin['name'] ?>"/></td>
            </tr>

            <tr>
                <td>رقم الهوية</td>
                <td><input type="text" class="cp_input" name="adminLName" required="required" value="<?php echo $row_admin['identification_number'] ?>"/></td>
            </tr>

            <tr>
                <td>اسم الدخول</td>
                <td><input type="text" class="cp_input" name="loginname" required="required" value="<?php echo $row_user['loginname'] ?>"/></td>
            </tr>
                        
            <tr>
                <td>كلمة المرور</td>
                <td><input type="password" class="cp_input" name="userPass" value="" autocomplete="new-password"/>
                <input type="hidden" name="huserPass" value="<?php echo $row_user['password'] ?>"/></td>
            </tr>


            <tr>
                <td colspan="2"> 
                    <input type="submit" name="editAdmin" value="تعديل بيانات المدير"/>
                    <input type="hidden" name="adminIdUpdt" value="<?php echo $edit_admin_id ?>"/>
                </td>
            </tr>
            
        </table>
    </form>
    <?php
    exit;
}






if (isset($_POST['add_admin']) && $_POST['add_admin'] == 'اضافة مدير') {
    $loginname = $_POST['loginname'];
    $userPass1 = MD5(sha1($_POST['userPass1']));
    $userPass2 = MD5(sha1($_POST['userPass2']));
    $adminFName = $_POST['adminFName'];
    $adminLName = $_POST['adminLName'];
    
    
    if ($userPass1 != $userPass2) {
    ?>
        <div class="error">كلمة المرور غير متطابقة</div>
    <?php
    } else {

        $sql2 = mysqli_query($connect, "SELECT * FROM users WHERE loginname='$loginname'");
        $num = mysqli_num_rows($sql2);
        if ($num > 0) {
            echo "<div class='error'>اسم المستخدم موجود مسبقا الرجاء اختيار اسم اخر</div>";
        } else {
        
        
					$insert_user = mysqli_query($connect, "INSERT INTO users "
						    . "(loginname,password,user_level_id) "
						    . "VALUES "
						    . "('$loginname','$userPass1',1)"
						    . "");
        			$last_user_id = mysqli_insert_id($connect);/////mean SELECT * FROM users WHERE id = SCOPE_IDENTITY();        
 
        
            		$query = mysqli_query($connect, "INSERT INTO admin (name,identification_number,user_id) VALUES ('$adminFName','$adminLName','$last_user_id')");



            if ($insert_user&&$query) {
                header('Location:admin.php ');
                exit;
            }
        }
    }
}
?>
<?php if (isset($_REQUEST['action']) && $_REQUEST['action'] == 'add_admin') { ?>
    <form method="post">
        <table width="60%" class="tablein" style="border:1px dashed black;">
            <tr>
                <td>الاسم</td>
                <td><input type="text" class="cp_input" name="adminFName" required="required"/></td>
            </tr>
            <tr>
                <td>رقم الهوية</td>
                <td><input type="text" class="cp_input" name="adminLName" required="required"/></td>
            </tr>
            <tr>
                <td>اسم الدخول</td>
                <td><input type="text" class="cp_input" name="loginname" required="required"/></td>
            </tr>
            <tr>
                <td>كلمة المرور</td>
                <td><input type="password" class="cp_input" name="userPass1"  autocomplete="new-password" required="required"/></td>
            </tr>

            <tr>
                <td>اعاده كلمه المرور</td>
                <td><input type="password" class="cp_input" name="userPass2"  autocomplete="new-password" required="required"/></td>
            </tr>
            <tr>
                <td colspan="2"> <input type="submit" name="add_admin" value="اضافة مدير"/></td>
            </tr>
        </table>
    </form>
    <?php
    exit;
}
?>




<center>
<a href="?action=add_admin" >
	<div align="right" class="btn btn-warning" style="float:right;color:white;font-size:1.1em;margin:10px;">

		<span style="float:right;margin-right:10px;" >اضافة مدير</span>

	</div>
</a>

</center>


<br>


<table width="80%" class="table">
    <tr class="firstTR">
        <th></th>
        <th>الإسم</th>
        <th>رقم الهوية</th>

        <th width=20px>تعديل</th>
        <th width=20px>حذف</th>
    </tr>
    <?php
    $sql="SELECT * FROM admin WHERE 1 AND is_canceled=0";
    //echo $sql;
    $query = mysqli_query($connect, $sql);
    $row_number=0;
    while ($row = mysqli_fetch_array($query)) 
    {
    	  $row_number=$row_number+1;
        $admin_id = $row['id'];
        ?>
        <tr>
        <td> <?php echo $row_number;?></td>
        <td> <?php echo $row['name'];?></td>
        <td>  <?php echo $row['identification_number'];?> </td>

        <td><a href="?action=edit&editId=<?php echo $admin_id;?>"><img width=18 src="../assets/icons/update.png"/></a></td>
       <td><a href="?action=delete&admin_id=<?php echo $admin_id;?>"><img width=18 src="../assets/icons/delete.png" /></a></td>
        </tr>
    <?php
    }
    ?>
</table>

<div style="color:red;text-align:center;font-size:1.0em;"><?php echo $error_msg;?></div>




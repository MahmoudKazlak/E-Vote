
<?php

require "config.php";




$return_data=array();





$loginname = $_POST['loginname'];
$loginname = mysqli_real_escape_string($connect, $loginname);
$password = MD5(sha1(@$_POST['password']));



$password = mysqli_real_escape_string($connect, $password);


if ($loginname AND $password) 
{
	$sql="SELECT loginname,password,id,user_level_id FROM users WHERE loginname='$loginname' AND password='$password' AND is_canceled=0";
    $finder = mysqli_query($connect, $sql) or die("mysql error");

    if (mysqli_num_rows($finder) != 0) 
    {
        while ($row = mysqli_fetch_object($finder)) 
        {
            $uname = stripslashes($row->loginname);
            $upass = $row->password;
            $user_id = $row->id;
			      $user_level_id=$row->user_level_id;

        }
        
        
 		//session_unset();//
 		unset($_SESSION['user_id']);
 		unset($_SESSION['user_name']);
 		unset($_SESSION['user_password']);
 		unset($_SESSION['user_level_id']);
 		
 		unset($_SESSION['admin_id']);
    unset($_SESSION['candidate_id']);




		//sleep(2);

		$_SESSION['user_id'] = $user_id;
		$_SESSION['user_name'] = $uname;
		$_SESSION['user_password'] = $upass;
		$_SESSION['user_level_id'] = $user_level_id;
		
		
			
	   if ($user_level_id == 1) 
	   {

    		$sel = mysqli_query($connect, "SELECT id FROM admin WHERE user_id='$user_id' and is_canceled=0");
			$admin_id = mysqli_fetch_assoc($sel)['id'];
			//echo $admin_id;

			if($admin_id)
			{													
				$_SESSION['admin_id'] = $admin_id;

				$return_data["body"]="admin_account";

			}	
			
			$return_data["head"]="ok";
											   
		}

	   else if ($user_level_id == 2) 
	   {
    		$sel = mysqli_query($connect, "SELECT id FROM candidate WHERE user_id='$user_id' and is_canceled=0");
			$candidate_id = mysqli_fetch_assoc($sel)['id'];
			//echo $candidate_id;

			if($candidate_id)
			{													
				$_SESSION['candidate_id'] = $candidate_id;

				$return_data["body"]="candidate_account";

			}	

			$return_data["head"]="ok";
				
								   
		}
	  

				        
	}
	else
	{
		$return_data["head"]="error";
		$return_data["body"]="اسم المستخدم او كلمة المرور غير صحيحة";
	}
				    
} 
else 
{
	$return_data["head"]="error";
    $return_data["body"]="الرجاء ادخال اسم المستخدم وكلمة المرور";
}



echo json_encode($return_data);

//ob_end_flush();










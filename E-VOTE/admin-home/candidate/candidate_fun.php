<?php

	include '../open_session.php';
  function image_upload($datafile)
  {

	  #----------------------------------------------------------
	  $element_name = $datafile['element_name'];
	  $upload_folder_location = $datafile['upload_folder_location'];
	  #----------------------------------------------------------

	  $targetFile = $upload_folder_location .basename($_FILES[$element_name]["name"]);
    
    $imageFileType = strtolower(pathinfo($targetFile, PATHINFO_EXTENSION));
    
    $new_name=strval(rand())."_image_upload_".strval(time()).".".strval($imageFileType);
    
    $targetFile = $upload_folder_location.$new_name;
    

    if(move_uploaded_file($_FILES[$element_name]["tmp_name"], $targetFile)){
      return $new_name;
    } else {
      return -1;
    }

  }


	$return_data=array();



	
	if(!isset($_SESSION['admin_id'])||$_SESSION['user_level_id']!=1)
	{
		$return_data['head']="error";
		$return_data['body']="لا تملك صلاحيات";
		echo json_encode($return_data);
		exit();
	}
	
	

	
	if ($_REQUEST['action'] == 'cancel_row') 
	{
		$row_id = intval($_REQUEST['row_id']);

		
		$delete = mysqli_query($connect, "UPDATE `candidate` SET is_canceled=1 WHERE id='$row_id'");
		if (!$delete) 
		{	
			$return_data["head"]="error";
			$return_data["body"]="حدث خطا في حذف الملف";
			echo json_encode($return_data);
			exit();
		}
		$ok_msg="تم حذف السجل بنجاح";
		$return_data["head"]="ok";
		$return_data["body"]=$ok_msg;
		echo json_encode($return_data);
		exit();
		
		
	}

			
	//---------------------------------------------------------------------

	if ($_POST['action'] == 'add_row' || $_POST['action'] == 'edit_row') 
	{
	
		$fname = mysqli_real_escape_string($connect, $_POST['fname']);
		if(!empty($fname))$fname="'$fname'";
		else
		{
			$return_data["head"]="error";
			$return_data["body"]="يجب كتابة الاسم الاول";
			echo json_encode($return_data);
			exit();
		}
		
		$lname = mysqli_real_escape_string($connect, $_POST['lname']);
		if(!empty($lname))$lname="'$lname'";
		else
		{
			$return_data["head"]="error";
			$return_data["body"]="يجب كتابة الاسم الاخير";
			echo json_encode($return_data);
			exit();
		}
		
    $bio = mysqli_real_escape_string($connect, $_POST['bio']);
		if(!empty($bio))$bio="'$bio'";
		else $bio="NULL";
		
		$phone = mysqli_real_escape_string($connect, $_POST['phone']);
		if(!empty($phone))$phone="'$phone'";
		else $phone="NULL";

    $img_dst="NULL";
		if (!empty($_FILES['img']['name'])) 
		{
			#---------------------------------------------------------------------------
			$datafile=array();
			$datafile['element_name']='img';
			$datafile['upload_folder_location']="../../save_files/images/";
			$img_dst=image_upload($datafile);
			#---------------------------------------------------------------------------
			$img_dst_temp=$img_dst;
			$img_dst="'$img_dst'";
			
		}

		$birthdate = mysqli_real_escape_string($connect, trim($_POST['birthdate']));
		if(!empty($birthdate))$birthdate="'$birthdate'";
		else $birthdate="NULL";
		

    $activation = intval($_POST['activation']);

		$residence_region_id = intval($_POST['residence_region_id']);
		$specialty_id = intval($_POST['specialty_id']);
		
		$gender_id = intval($_POST['gender_id']);

    $loginname =mysqli_real_escape_string($connect,$_POST['loginname']);
		if(strlen($loginname)<3)
		{
			$return_data["head"]="error";
			$return_data["body"]="اسم مستخدم يجب ألا يقل عن 3 خانات";
			echo json_encode($return_data);
			exit();
		}

	 	$password =mysqli_real_escape_string($connect,$_POST['password']);
	 	$confirm_password =mysqli_real_escape_string($connect,$_POST['confirm_password']);
	 	if($password!=$confirm_password)
		{
			$return_data["head"]="error";
			$return_data["body"]="كلمة المرور غير متطابقة";
			echo json_encode($return_data);
			exit();
		}

	}

	if ($_POST['action'] == 'add_row') 
	{


		##========user data
		$sql = mysqli_query($connect, "SELECT loginname FROM users WHERE loginname='$loginname'");
    $num = mysqli_num_rows($sql);
    	
		if ($num>0) 
		{
			$return_data["head"]="error";
			$return_data["body"]="اسم المستخدم هذا موجود لموظف اخر";
			echo json_encode($return_data);
			exit();

		}
		if(empty($password))
		{
			$return_data["head"]="error";
			$return_data["body"]="الرجاء ادخال كلمة مرور";
			echo json_encode($return_data);
			exit();
		
		}
		

		$password = md5(sha1($password));

		$sql="
		 INSERT INTO users
		        (loginname,password,user_level_id)
		 VALUES
		        ('$loginname','$password',2)";
		$insert1 = mysqli_query($connect, $sql);
		
		//------------------------------------------------------------------------
		$last_user_id = mysqli_insert_id($connect);/////mean SELECT * FROM agent WHERE id = SCOPE_IDENTITY(); 
		//------------------------------------------------------------------------
		##========
		
		
		 $sql="
		 INSERT INTO candidate 
		        (fname,lname,bio,phone,img,residence_region_id,specialty_id,birthdate,gender_id,activation,user_id)
		 VALUES
		        ($fname,$lname,$bio,$phone,$img_dst,$residence_region_id,$specialty_id,$birthdate,$gender_id,$activation,$last_user_id)";

		//echo  $insert_sql;

		$insert1 = mysqli_query($connect, $sql);

		

		if ( !$insert1) 
		{
			$return_data["head"]="error";
			$return_data["body"]="حدث خطا في الاضافة";
			echo json_encode($return_data);
			exit();

		}
	
		$ok_msg="تم حفظ السجل بنجاح";
	}



	if ($_POST['action'] == 'edit_row') 
	{
		$row_id = intval($_POST['row_id']);

		##========user data

    if(!empty($row_id))
    {
      $m_query = mysqli_query($connect, "SELECT user_id FROM candidate WHERE id='$row_id' ");
      $m_row = mysqli_fetch_array($m_query);
      $user_id=$m_row['user_id'];
      
      $user_query = mysqli_query($connect, "SELECT * FROM users WHERE loginname='$loginname' AND id!='$user_id' ");
      $num = mysqli_num_rows($user_query);

      if ($num>0) 
      {
        $return_data["head"]="error";
        $return_data["body"]="اسم المستخدم هذا موجود لموظف اخر";
        echo json_encode($return_data);
        exit();

      }

      $update_user = mysqli_query($connect, "UPDATE users SET loginname='$loginname' WHERE id='$user_id'");

      if(!empty($password) && $password==$confirm_password)
      {
        $password = md5(sha1($password));
        $update_user = mysqli_query($connect, "UPDATE users SET password='$password' WHERE id='$user_id'");
      }

    }

		##========
		$sql="UPDATE candidate SET 
				fname=$fname,
				lname=$lname,
				bio=$bio,
				phone=$phone,
				img=$img_dst,
				residence_region_id=$residence_region_id,
				specialty_id=$specialty_id,
				activation=$activation,
				birthdate=$birthdate,
				gender_id=$gender_id
				WHERE id=$row_id ";
		//echo $sql;
		//exit;
		
		$update = mysqli_query($connect, $sql);
		
		if (!$update)
		{
			$return_data["head"]="error";
			$return_data["body"]="حدث خطا في حفظ التعديلات";
			echo json_encode($return_data);
			exit();
		   
		}

		$ok_msg="تم تحديث البيانات بنجاح";
	}
	//-----------------------------------------------------------
	
	
	
	$return_data["head"]="ok";
	$return_data["body"]=$ok_msg;
	echo json_encode($return_data);
	exit();











?>


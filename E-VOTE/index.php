<!DOCTYPE html>
<html lang="en">
<?php
include "config.php";
?>
<head>

  <meta charset="utf-8">
  <title>

  </title>

  <link rel="icon" type="image/png" href="images/favicon.png">

  <link rel='stylesheet' type='text/css' href="admin-home/assets/css/font_family.css" rel="stylesheet">
  <link rel='stylesheet' type='text/css' href="admin-home/assets/css/fontAwesome.css" rel="stylesheet">
   
  <script src="admin-home/assets/js/jquery-2.2.4.min.js"></script>


</head>





<script>

function login(element)
{

	var loginname=$("[id=loginname]").val();
	var password=$("[id=password]").val();
	
	//alert(4);
	if(loginname!="" && password!="")
	{
		//======================================================================================
		var pass_data={
			'loginname':loginname,
			'password':password
		}

		//pass_data=JSON.stringify(pass_data);
		
		//alert(pass_data);

		$.ajax({
			type:"POST",
			url:"login_function.php",
			data:pass_data,
			success: function(response) {
			
				//alert(response);
				response=JSON.parse(response.trim());
				
				if(response.head=="ok")
				{
				
					$("[name=loginname]").empty();
					$("[name=password]").empty();
					

					if(response.body=="admin_account")
					{
						location="admin-home/index.php";
					}
					else if(response.body=="candidate_account")//
					{
						location="candidate-home/index.php";//
					}
					

					
					
				}
				else if(response.head=="error")
				{
					if(response.body.msg=="loginname_or_password_error")
					{
						alert(response.body.other_msg);					
					}
					else if(response.body.msg=="some_unknown_error")
					{
						alert(response.body.other_msg);					
					}
				}
				else
				{
					alert("هناك خطأ غير معروف");	
				
				}

		 	}
		});
	 
		//======================================================================================
	}

}
</script>

<style>
body {
  margin: 0;
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  background-color: #f1f1f1;
}

.login-container {
  background-color: #fffffffd;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  padding: 70px;
  padding-top: 30px;
  border-radius: 8px;
  text-align: center;
}

h2 {
  color: #333;
  font-size: 28px;
  margin-bottom: 20px;
}

form {
  display: flex;
  flex-direction: column;
  align-items: center;
}

.input-group {
  margin-bottom: 20px;
}

label {
  font-size: 16px;
  color: #555;
  display: block;
  margin-bottom: 8px;
}

input {
  width: 100%;
  padding: 12px;
  margin-bottom: 15px;
  box-sizing: border-box;
  border: 1px solid #ddd;
  border-radius: 5px;
  font-size: 16px;
}

button {
  background-color: #4caf50;
  color: #fff;
  padding: 12px 20px;
  border: none;
  border-radius: 5px;
  font-size: 18px;
  cursor: pointer;
  transition: background-color 0.3s;
}

button:hover {
  background-color: #45a049;
}

</style>
     

<body style="background-image: url('admin-home/assets/images/welcome.jpg');background-size: cover;">
<br><br><br>

  <div class="login-container">
    <img src="admin-home/assets/images/evote-logo.png" width="99px" />
    <h2>التصويت الالكتروني</h2>
    
    <form action="" method="post">
      <label for="loginname">اسم المستخدم</label>
      <input type="text" id="loginname" name="loginname" required>

      <label for="password">كلمة المرور</label>
      <input type="password" id="password" name="password" required>

      <button type="submit" onclick="login();">تسجيل دخول</button>
    </form>
  </div>
</body>
</html>


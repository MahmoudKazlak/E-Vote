

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
             
        <div >
          <div style="background:#eef;border:1px dotted #ccc;padding:3px;text-align:center;"  >

                 اهلا  <span style="margin-top:-5px;"><?php echo mysqli_fetch_array(mysqli_query($connect,"SELECT name FROM admin WHERE 1 AND id=".intval($_SESSION['admin_id'])))['name'];?></span>

                </div>

	           <div class='content cont'>
	            <a href='?action=logout' style="font-weight:bold;color:#d00" target='home' onclick="return confirm('هل تريد بالتاكيد انهاء الجلسة؟');" >انهاء الجلسة</a>    

				      <hr style="width:100%;">
				      <a href='admin-account/admin.php' target='home' style="">الادارة</a>

				      <a href='members/member.php' target='home' style="">الاعضاء</a>
				      <a href='candidate/candidate.php' target='home' style="">المرشحين</a>
             
              <hr style="width:100%;">
              
              <a href='poll-topic/poll_topic.php' target='home' style=""> مواضيع الاستفتاء</a>
              <a href='pollTopic-candidate/pollTopic_candidate.php' target='home' style=""> اضافة مرشحين للاستفتاء</a>
              
              <hr style="width:100%;">
              <a href='residence-region/residence_region.php' target='home' style=""> مكان الاقامة</a>
              <a href='specialties/specialties.php' target='home' style=""> التخصصات</a>
            
              <hr style="width:100%;">
              <a href='adv/adv.php' target='home' style="">الاعلانات</a>
              

            </div>
        </div>




  		
    </body>
</html>

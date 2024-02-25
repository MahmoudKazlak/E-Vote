

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
             
        <div class='menu_block'>
          <div style="background:#eef;border:1px dotted #ccc;padding:3px;text-align:center;"  >

                  اهلا <span style="margin-top:-5px;"><?php echo mysqli_fetch_array(mysqli_query($connect,"SELECT concat(fname,' ',lname) as name FROM candidate WHERE 1 AND id=".intval($_SESSION['candidate_id'])))['name'];?></span>

                </div>

	           <div class='content'>

              <a href='?action=logout' style="font-weight:bold;color:#d00" target='home' onclick="return confirm('هل تريد بالتاكيد انهاء الجلسة؟');" >انهاء الجلسة</a>
              
              
				      <hr style="width:100%;">

				      <a href='account/candidate_form.php' target='home' style="">الحساب الشخصي</a>
             
              <hr style="width:100%;">
              <a href='poll-topic/poll_topic.php' target='home' style=""> الاستفتاءات المشترك فيها</a>
              
              <hr style="width:100%;">
              

           

            </div>
        </div>


        <?php include "notification.php";?>

  		
    </body>
</html>

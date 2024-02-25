
<?php
/*
header("Content-Type: application/json");
header('access-control-allow-origin: *');
header('Access-Control-Allow-Headers: *');
*/
?>


<?php

include "../config.php";

########################################################################################



function do_signup($data)
{
    $connect=$GLOBALS['connect'];
    
    $loginname=mysqli_real_escape_string($connect, $data['loginname']);
    $password=MD5(sha1(@$data['password']));

    $sql="INSERT INTO `users`(`loginname`,`password`, `user_level_id`) VALUES ('$loginname','$password',3)";
    $insert1 = mysqli_query($GLOBALS['connect'], $sql);
    
    $user_id = mysqli_insert_id($connect);##last row id

    $sql="INSERT INTO `member`(user_id) VALUES ($user_id)";
    $insert2 = mysqli_query($GLOBALS['connect'], $sql);
    
    
    file_put_contents("debug/insert_event.debug", $sql);
    if ($insert1&&$insert2) 
    {

        //----------------------
        $response=array("status"=>"succeed","body"=>"تم نشر المناسبة بنجاح","user_id"=>$user_id);
        $json_encode=json_encode($response);
        //----------------------
        
        print($json_encode);
    }
    else
    {
        //----------------------
        $response=array("status"=>"failed","body"=>"خطأ في ادخال البيانات ");
        $json_encode=json_encode($response);
        //----------------------
        
        print($json_encode);
    }
}



########################################################################################
function do_login($data)
{
    $username=$data["username"];
    $password=MD5(sha1(@$data['password']));

    $sql="SELECT * FROM `users` WHERE 1 AND loginname='$username' AND password='$password' AND (user_level_id=2 OR user_level_id=3)";
    $query = mysqli_query($GLOBALS['connect'], $sql);
    $num = mysqli_num_rows($query);
    
    if ($num > 0) 
    {
        $row= mysqli_fetch_array($query);
        
        //----------------------debug
        file_put_contents("debug/login.debug", $sql);
        //----------------------
        $response=array("status"=>"succeed","user_id"=>intval($row['id']), "user_level"=>intval($row['user_level_id']));
        $json_encode=json_encode($response);
        //----------------------debug
        file_put_contents("debug/login_status.debug", $json_encode);
        //----------------------
        print($json_encode);
    }
    else
    {
        
        //----------------------debug
        file_put_contents("debug/login.debug", $sql);
        //----------------------
        $response=array("status"=>"failed","body"=>"خطأ في بيانات الدخول");
        $json_encode=json_encode($response);
        //----------------------debug
        file_put_contents("debug/login_status.debug", $json_encode);
        //----------------------
        print($json_encode);
    }
}

########################################################################################
function restore_password($data)
{
    $connect=$GLOBALS['connect'];
    
    $loginname=mysqli_real_escape_string($connect, $data['loginname']);

    $sql="SELECT * FROM `users` WHERE 1 AND loginname='$loginname'";
    $query = mysqli_query($GLOBALS['connect'], $sql);
    if($row= mysqli_fetch_array($query))
    {
      $sql="INSERT INTO `restore_password`(`user_id`,user_level_id) VALUES ('$row[id]','$row[user_level_id]')";
      $insert1 = mysqli_query($GLOBALS['connect'], $sql);
      file_put_contents("debug/restore_password.debug", $sql);
      //----------------------
      $response=array("status"=>"succeed","body"=>"سيتم التواصل معك لاستعادة كلمة المرور");
      $json_encode=json_encode($response);
      //----------------------
    }
    else
    {
      //----------------------
      $response=array("status"=>"failed","body"=>"اسم المستخدم غير موجود للأعضاء ");
      $json_encode=json_encode($response);
      //----------------------
      
      print($json_encode);
    }
    
}

########################################################################################


function show_all_poll_topics($data)
{
    $response=array("status"=>"","dataView"=>array());
    
    //=================================adv
    $adv_sql="SELECT `id`, `insert_time`, `name`, `period`
              FROM `adv`
              WHERE TIMESTAMPDIFF(HOUR, `insert_time`, NOW()) < `period` 
              ORDER BY id DESC LIMIT 0,3 ";
              
    $adv_query = mysqli_query($GLOBALS['connect'], $adv_sql);
    while($adv_row= mysqli_fetch_array($adv_query))
    {
      array_push($response['dataView'],array('type'=>'adv', 'id'=>intval($adv_row['id']),'name'=>strval($adv_row['name']),'is_ended'=>strval("-"),'insert_time'=>strval("-")));
    }
    //=================================
    
    
    $user_id=intval( $data['user_id']);

    //---------check if this candidate
    $sql="SELECT COUNT(*) FROM `candidate` WHERE 1 AND user_id=$user_id ";
    $is_this_candidate= mysqli_fetch_array(mysqli_query($GLOBALS['connect'],$sql))['COUNT(*)'];
    //----------
    
    if(!$is_this_candidate)
    {
      $sql="SELECT * FROM `member` WHERE 1 AND user_id=$user_id ";
      $member_info= mysqli_fetch_array(mysqli_query($GLOBALS['connect'],$sql));
      
      $sql="
      SELECT poll_topic.*,
              CASE
                  WHEN TIMESTAMPADD(HOUR, poll_topic.period, poll_topic.insert_time) < NOW() THEN 'yes'
                  ELSE 'no'
              END AS is_ended
      FROM 
          poll_topic
      LEFT JOIN 
          link_pollTopic_candidate ON poll_topic.id = link_pollTopic_candidate.poll_topic_id
      LEFT JOIN 
          candidate ON link_pollTopic_candidate.candidate_id = candidate.id
      ORDER BY
          CASE
              WHEN candidate.lname = '$member_info[lname]' THEN 1 
              WHEN candidate.residence_region_id = '$member_info[residence_region_id]' THEN 2 
              WHEN candidate.specialty_id = '$member_info[specialty_id]' THEN 3 
              WHEN candidate.gender_id = '$member_info[gender_id]' THEN 4 
              ELSE 5
          END ASC,
          poll_topic.id DESC;

        ";
        file_put_contents("debug/show_all_poll_topics_member.sql.debug", $sql);
        
    }
    else if($is_this_candidate)
    {
      $sql="SELECT * FROM `candidate` WHERE 1 AND user_id=$user_id ";
      $candidate_info= mysqli_fetch_array(mysqli_query($GLOBALS['connect'],$sql));
      
      $sql="
      SELECT poll_topic.*,
              CASE
                  WHEN TIMESTAMPADD(HOUR, poll_topic.period, poll_topic.insert_time) < NOW() THEN 'yes'
                  ELSE 'no'
              END AS is_ended
      FROM 
          poll_topic
      LEFT JOIN 
          link_pollTopic_candidate ON poll_topic.id = link_pollTopic_candidate.poll_topic_id
      LEFT JOIN 
          candidate ON link_pollTopic_candidate.candidate_id = candidate.id
      ORDER BY
          CASE
              WHEN candidate.id = '$candidate_info[id]' THEN 1 
              WHEN candidate.lname = '$candidate_info[lname]' THEN 1 
              WHEN candidate.residence_region_id = '$candidate_info[residence_region_id]' THEN 2 
              WHEN candidate.specialty_id = '$candidate_info[specialty_id]' THEN 3 
              WHEN candidate.gender_id = '$candidate_info[gender_id]' THEN 4 
              ELSE 5
          END ASC,
          poll_topic.id DESC;

        ";
        file_put_contents("debug/show_all_poll_topics_candidate.sql.debug", $sql);
    }
    
    $query = mysqli_query($GLOBALS['connect'], $sql);
    
    //----------------------debug
    file_put_contents("debug/show_all_poll_topics.sql.debug", $sql);
    //----------------------
    
    $num = mysqli_num_rows($query);
    
    if ($num > 0) 
    {
        $response["status"]="success";
        
        $uniqueIds = array();
        while($row= mysqli_fetch_array($query))
        {
          if (!in_array($row['id'], $uniqueIds)) 
          {
            $uniqueIds[] = $row['id'];
            array_push($response['dataView'],array('type'=>'poll_topic', 'id'=>intval($row['id']),'name'=>strval($row['name']),'is_ended'=>strval($row['is_ended']), 'insert_time'=>strval(date("Y-m-d H:i",strtotime($row['insert_time'])))));
          }
        }



    }
    else
    {
        $response=array("status"=>"failed","dataView"=>"لا يتوفر بيانات");
        
    }
    
    
    
    
    $json_encode=json_encode($response);
    //----------------------debug
    file_put_contents("debug/show_all_poll_topics.debug", $json_encode);
    //----------------------
    print($json_encode);
}



########################################################################################

function show_poll_topic_candidate($data)
{
    $user_id=intval( $data['user_id']);
    
    $poll_topic_id=intval( $data['poll_topic_id']);

    //---------if seen by candidate in this poll_topic set notification zero 0 for this candidate
    $sql="SELECT id FROM `candidate` WHERE 1 AND user_id=$user_id ";
    $candidate_id= mysqli_fetch_array(mysqli_query($GLOBALS['connect'],$sql))['id'];
    if($candidate_id)//if candidate not member
    {
      $sql="UPDATE `link_pollTopic_candidate` SET notification_num=0 WHERE 1 AND candidate_id=$candidate_id AND poll_topic_id=$poll_topic_id";
      file_put_contents("debug/update_notification_zero.sql.debug", $sql);
      $update= mysqli_query($GLOBALS['connect'],$sql);
    
    }
    //----------
          



    $sql = "SELECT
              lpc.id,
              c.id as candidate_id,
              c.user_id as candidate_user_id,
              CONCAT(c.fname, ' ', c.lname) AS name,
              TIMESTAMPDIFF(YEAR, c.birthdate, CURDATE()) AS age,
              (SELECT COUNT(*) FROM `link_pollTopic_candidate_userVoted` WHERE candidate_id = c.id AND poll_topic_id = $poll_topic_id) AS candidate_votes_count
            FROM
              candidate c
            JOIN
              link_pollTopic_candidate lpc ON c.id = lpc.candidate_id
            WHERE
              lpc.poll_topic_id = $poll_topic_id
              
            ORDER BY candidate_votes_count DESC, lpc.id ASC
          ";
      
    $query = mysqli_query($GLOBALS['connect'], $sql);
    
    //----------------------debug
    file_put_contents("debug/show_poll_topic_candidate.sql.debug", $sql);
    //----------------------
    
    $num = mysqli_num_rows($query);
    
    if ($num > 0) 
    {
        $response=array("status"=>"succeed","dataView"=>array());
        
        $print_sql="";
        while($row= mysqli_fetch_array($query))
        {
          $candidate_id=$row['candidate_id'];
          
          //---------is_user_voted
          $sql="SELECT COUNT(*) FROM `link_pollTopic_candidate_userVoted` WHERE 1 AND candidate_id=$candidate_id AND poll_topic_id=$poll_topic_id AND user_id=$user_id ";
          $print_sql.="; $sql";
          $is_user_voted= mysqli_fetch_array(mysqli_query($GLOBALS['connect'],$sql))['COUNT(*)'];
          //----------
          
          //---------candidate_votes_count
          $candidate_votes_count= $row['candidate_votes_count'];
          //----------
          
          if($is_user_voted)$is_checked=true;
          else $is_checked=false;
          
          array_push($response['dataView'],array('id'=>intval($row['id']), 'candidate_id'=>intval($row['candidate_id']), 'candidate_user_id'=>intval($row['candidate_user_id']), 'name'=>strval($row['name']), 'age'=>intval($row['age']), 'candidate_votes_count'=>intval($candidate_votes_count),'is_checked'=>boolval($is_checked)));
        }
        
        file_put_contents("debug/is_user_voted.sql.debug", $print_sql);

        $json_encode=json_encode($response);
        //----------------------debug
        file_put_contents("debug/show_poll_topic_candidate.debug", $json_encode);
        //----------------------
        print($json_encode);
    }
    else
    {
        $response=array("status"=>"failed","dataView"=>"لا يتوفر بيانات");
        $json_encode=json_encode($response);
        //----------------------debug
        file_put_contents("debug/show_poll_topic_candidate.debug", $json_encode);
        //----------------------
        print($json_encode);
    }
}



########################################################################################





function show_profile($data)
{
    $user_id=intval( $data['user_id']);

    $user_sql="SELECT * FROM `users` WHERE 1 AND id=$user_id";
    $user_query = mysqli_query($GLOBALS['connect'], $user_sql);
    $user_row=mysqli_fetch_array($user_query);
    $loginname= $user_row['loginname'];
    $user_level_id= $user_row['user_level_id'];
    
    if($user_level_id==2)
      $sql="SELECT * FROM `candidate` WHERE 1 AND user_id=$user_id";
    if($user_level_id==3)
      $sql="SELECT * FROM `member` WHERE 1 AND user_id=$user_id";
    
    $query = mysqli_query($GLOBALS['connect'], $sql);
    $row= mysqli_fetch_array($query);
    
    
    $user_sql="SELECT * FROM `users` WHERE 1 AND id=$user_id";
    $user_query = mysqli_query($GLOBALS['connect'], $user_sql);
    $loginname= mysqli_fetch_array($user_query)['loginname'];
    
    //----------------------debug
    file_put_contents("debug/show_profile.sql.debug", $sql);
    //----------------------
    
    $residence_region_array=array();
    $specialties_array=array();
    
    $sql="SELECT * FROM `residence_region` WHERE 1 ";
    $query_residence_region = mysqli_query($GLOBALS['connect'], $sql);
    while($residence_region= mysqli_fetch_array($query_residence_region))
    {
      array_push($residence_region_array, array("id"=>intval($residence_region['id']), "name"=>strval($residence_region['name'])));
      
      if($residence_region['id']==$row['residence_region_id'])$residence_region_name=$residence_region['name'];
    }
    
    $sql="SELECT * FROM `specialties` WHERE 1 ";
    $query_specialties = mysqli_query($GLOBALS['connect'], $sql);
    while($specialty= mysqli_fetch_array($query_specialties))
    {
      array_push($specialties_array,array("id"=>intval($specialty['id']),"name"=>strval($specialty['name'])));
      if($specialty['id']==$row['specialty_id'])$specialty_name=$specialty['name'];
    }
    
    $num = mysqli_num_rows($query);
    
    if ($num > 0) 
    {
        
        

        $response=array("status"=>"succeed", 
          "dataView"=>array(
            'fname'=>strval($row['fname']), 
            'lname'=>strval($row['lname']), 
            'bio'=>strval($row['bio']), 
            'phone'=>strval($row['phone']), 
            'birthdate'=>strval($row['birthdate']), 
            'loginname'=>strval($loginname), 
            'img'=>strval($row['img']), 
            'residence_region_id'=>intval($row['residence_region_id']), 
            'residence_region_name'=>strval($residence_region_name), 
            'specialty_id'=>intval($row['specialty_id']) ,
            'specialty_name'=>strval($specialty_name), 
            'gender_id'=>intval($row['gender_id']) , 
            'residence_region'=>$residence_region_array, 
            'specialties'=>$specialties_array
          ));
        

        $json_encode=json_encode($response);
        //----------------------debug
        file_put_contents("debug/show_profile.debug", $json_encode);
        //----------------------
        print($json_encode);
    }
    else
    {
        $response=array("status"=>"failed","dataView"=>"لا يتوفر بيانات");
        $json_encode=json_encode($response);
        //----------------------debug
        file_put_contents("debug/show_profile.debug", $json_encode);
        //----------------------
        print($json_encode);
    }
}


########################################################################################



function show_election_program($data)
{
    $user_id=intval( $data['user_id']);
    $poll_topic_candidate_id=intval( $data['poll_topic_candidate_id']);
    

    /*
    $user_sql="SELECT * FROM `users` WHERE 1 AND id=$user_id";
    $user_query = mysqli_query($GLOBALS['connect'], $user_sql);
    $user_row=mysqli_fetch_array($user_query);
    $loginname= $user_row['loginname'];
    $user_level_id= $user_row['user_level_id'];
    */


    $sql="SELECT * FROM `link_pollTopic_candidate` WHERE 1 AND id=$poll_topic_candidate_id ";

    $query = mysqli_query($GLOBALS['connect'], $sql);
    $row= mysqli_fetch_array($query);

    //----------------------debug
    file_put_contents("debug/show_election_program.sql.debug", $sql);
    //----------------------

    $num = mysqli_num_rows($query);
    
    if ($num > 0) 
    {

        $response=array("status"=>"succeed", 
          "dataView"=>array(
            'election_program'=>strval($row['election_program'])
          ));
        

        $json_encode=json_encode($response);
        //----------------------debug
        file_put_contents("debug/show_election_program.debug", $json_encode);
        //----------------------
        print($json_encode);
    }
    else
    {
        $response=array("status"=>"failed","dataView"=>"لا يتوفر بيانات");
        $json_encode=json_encode($response);
        //----------------------debug
        file_put_contents("debug/show_election_program.debug", $json_encode);
        //----------------------
        print($json_encode);
    }
}


########################################################################################


function vote_to_poll_topic_candidate($data)
{
    $user_id=intval( $data['user_id']);
    $poll_topic_candidate_id=intval( $data['poll_topic_candidate_id']);
    $is_checked= intval($data['is_checked']);

    $row= mysqli_fetch_array(mysqli_query($GLOBALS['connect'],"SELECT * FROM `link_pollTopic_candidate` WHERE 1 AND id=$poll_topic_candidate_id"));
    
    $candidate_id=intval($row['candidate_id']);
    $poll_topic_id=intval($row['poll_topic_id']);


    $is_ended_vote= mysqli_fetch_array(mysqli_query($GLOBALS['connect'],"SELECT COUNT(*) FROM `poll_topic` WHERE TIMESTAMPADD(HOUR, `period`, `insert_time`) < NOW() AND id=$poll_topic_id"))['COUNT(*)'];
    if($is_ended_vote)
    {
      $response=array("status"=>"failed","body"=>"انتهى التصويت على هذا الاستفتاء");
      $json_encode=json_encode($response);
      print($json_encode);
      exit;
    }
    
    $is_voted_to_this_poll_topic= mysqli_fetch_array(mysqli_query($GLOBALS['connect'],"SELECT COUNT(*) FROM `link_pollTopic_candidate_userVoted` WHERE 1 AND user_id=$user_id AND poll_topic_id=$poll_topic_id"))['COUNT(*)'];

    if($is_voted_to_this_poll_topic)
    {
      $response=array("status"=>"failed","body"=>"لقد قمت بالتصويت مسبقا");
      $json_encode=json_encode($response);
      print($json_encode);
      exit;
    }



    
    


    if($is_checked)
    {
      $sql="INSERT INTO link_pollTopic_candidate_userVoted(user_id,candidate_id,poll_topic_id) VALUES($user_id,$candidate_id,$poll_topic_id) ";
      $query1 = mysqli_query($GLOBALS['connect'], $sql);
      //----------------------debug
      file_put_contents("debug/vote_to_poll_topic_candidate.debug", $sql);
      //----------------------
      
      //----this for notification
      $s="UPDATE `link_pollTopic_candidate` SET notification_num=notification_num+1 WHERE 1 AND poll_topic_id=$poll_topic_id ";
      $q = mysqli_query($GLOBALS['connect'], $s);
      //----
      
    }
    if ($query1) 
    {
        $response=array("status"=>"succeed","body"=>"تم التصويت");
        $json_encode=json_encode($response);
        print($json_encode);
    }
    else
    {
        $response=array("status"=>"failed","body"=>"لم يتم التصويت لسبب فني");
        print($json_encode);
    }
  
    
      
}


########################################################################################


function update_your_profile($data)
{
    $connect=$GLOBALS['connect'];
    
    $user_id=intval( $data['user_id']);
    

    $loginname=mysqli_real_escape_string($connect, $data['loginname']);
    if(empty($loginname))
    {
      $response=array("status"=>"failed","body"=>"يجب ادخال اسم المستخدم");
      $json_encode=json_encode($response);
      print($json_encode);
      exit;    
    }
    
    $password=$data['password'];
    if(!empty($password)){
      $password = md5(sha1($password));
      $set_password=" , password='$password' ";
    }
    

    $fname=mysqli_real_escape_string($connect, $data['fname']);
    $lname=mysqli_real_escape_string($connect, $data['lname']);
    
    if(empty($fname) ||empty($lname))
    {
      $response=array("status"=>"failed","body"=>"يجب كتابة الاسم الاول و الاخير");
      $json_encode=json_encode($response);
      print($json_encode);
      exit;    
    }
    
    $bio=mysqli_real_escape_string($connect, $data['bio']);
    $phone=mysqli_real_escape_string($connect, $data['phone']);
    
    $birthdate=mysqli_real_escape_string($connect, $data['birthdate']);
    if(empty($birthdate))$birthdate="NULL";
    else $birthdate="'$birthdate'";
    
    $gender_id=intval( $data['gender_id']);
    $specialty_id=intval( $data['specialty_id']);
    $residence_region_id=intval( $data['residence_region_id']);
    
    
    $sql="UPDATE `users` SET loginname='$loginname' $set_password WHERE id=$user_id ";
    $update = mysqli_query($GLOBALS['connect'], $sql);
    

    $sql="UPDATE `member` SET fname='$fname',lname='$lname',bio='$bio',phone='$phone', birthdate=$birthdate, gender_id=$gender_id, specialty_id=$specialty_id, residence_region_id=$residence_region_id WHERE user_id=$user_id ";
    
    $update = mysqli_query($GLOBALS['connect'], $sql);


    file_put_contents("debug/update_your_profile.debug", $sql);
    if ($update) 
    {

        //----------------------
        $response=array("status"=>"succeed","body"=>"تم تحديث البيانات");
        $json_encode=json_encode($response);
        //----------------------
        
        print($json_encode);
    }
    else
    {
        //----------------------
        $response=array("status"=>"failed","body"=>"خطأ في حفظ البيانات ");
        $json_encode=json_encode($response);
        //----------------------
        
        print($json_encode);
    }
}






########################################################################################


// Takes raw data from the request
$json = file_get_contents('php://input');
$data = json_decode($json,true);

//----------------------debug
file_put_contents("debug/receive.debug", $json);
//----------------------



if($data['action']=="do_signup")do_signup($data);
if($data['action']=="do_login")do_login($data);

if($data['action']=="restore_password")restore_password($data);

if($data['action']=="show_all_poll_topics")show_all_poll_topics($data);

if($data['action']=="show_poll_topic_candidate")show_poll_topic_candidate($data);

if($data['action']=="vote_to_poll_topic_candidate")vote_to_poll_topic_candidate($data);

if($data['action']=="show_profile")show_profile($data);
if($data['action']=="update_your_profile")update_your_profile($data);

if($data['action']=="show_election_program")show_election_program($data);







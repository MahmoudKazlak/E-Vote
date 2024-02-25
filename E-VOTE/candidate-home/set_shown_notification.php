<?php
include "open_session.php";

$poll_topic_id=$_POST['poll_topic_id'];

$s="
UPDATE link_pollTopic_candidate SET notification_num=0 WHERE 1 AND `candidate_id` =  $_SESSION[candidate_id] AND poll_topic_id=$poll_topic_id
";

$q = mysqli_query($connect, $s);

?>


<?php
include "open_session.php";

$s="
SELECT pt.`id` AS poll_topic_id,pt.`name` AS poll_topic_name, lpc.`notification_num`
FROM `poll_topic` pt
JOIN `link_pollTopic_candidate` lpc ON pt.`id` = lpc.`poll_topic_id`
WHERE lpc.`candidate_id` =  $_SESSION[candidate_id] AND notification_num>0 
";

$q = mysqli_query($connect, $s);
while ($result = mysqli_fetch_array($q)) 
{
  echo "<li onclick='set_shown_notification({$result['poll_topic_id']});' > {$result['poll_topic_name']} <span>{$result['notification_num']}</span></li>";
}

?>


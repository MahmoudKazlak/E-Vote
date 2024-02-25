<?php
include "../config.php";

// Fetch notifications from the database
$query="
SELECT id
FROM candidate
WHERE user_id =  '".$_GET['user_id']."'
";
$result = $connect->query($query);
if ($row = $result->fetch_assoc()) {
    $candidate_id = $row['id'];
}

// Fetch notifications from the database
$query="
SELECT pt.`id` AS poll_topic_id,pt.`name` AS poll_topic_name, lpc.`notification_num`
FROM `poll_topic` pt
JOIN `link_pollTopic_candidate` lpc ON pt.`id` = lpc.`poll_topic_id`
WHERE lpc.`candidate_id` =  '$candidate_id' AND notification_num>0 
";
//----------------------debug
file_put_contents("debug/notification_query.debug", $query);
//----------------------

$result = $connect->query($query);

$notifications = [];

// Fetch data from the result set
while ($row = $result->fetch_assoc()) {
    $notifications[] = array("id"=>$row['poll_topic_id'],"name"=>$row['poll_topic_name']);
}

// Output notifications as JSON
//header('Content-Type: application/json');
print(json_encode($notifications));
exit;

//note:
// الغي الاشعارات عند الاعضاء واعمل فقط للمرشحين ويكون بدل منها عند الاعضاء عمل عرض للاستفتاءات الي عمل تصويت عليها كأرشيف...
//end
?>



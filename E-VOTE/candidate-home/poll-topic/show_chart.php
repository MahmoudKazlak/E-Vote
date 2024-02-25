<?php
include "../open_session.php";
?>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title></title>
  <!-- Include Chart.js library from CDN -->
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body style="background:#f7f7f7;">

<div align="middle" style="width:100%;">
  عرض تقرير التصويت <br><br>
  <div style="width:600px !important;height:400;background:#fff;border:1px solid #aaa;padding:20px;">
    <canvas id="myBarChart" ></canvas>
  </div>
</div>


<?php
$poll_topic_id=$_GET['poll_topic_id'];

$sql = "

SELECT 
    p.`name` AS poll_topic_name,
    concat(c.`fname`,c.`lname`) AS candidate_name,
    COALESCE(COUNT(l.`id`), 0) AS candidate_vote_count
FROM 
    `link_pollTopic_candidate` pc
LEFT JOIN 
    `candidate` c ON c.`id` = pc.`candidate_id`
LEFT JOIN 
    `poll_topic` p ON p.`id` = pc.`poll_topic_id`
LEFT JOIN 
    `link_pollTopic_candidate_userVoted` l ON ((l.`candidate_id` = pc.`candidate_id` AND l.`poll_topic_id` = pc.`poll_topic_id`) OR l.id IS NULL)
WHERE 
    1
    AND c.`is_canceled` = 0
    AND pc.`poll_topic_id` = $poll_topic_id
GROUP BY 
    pc.`id` ;

";

//echo $sql;

$query = mysqli_query($connect, $sql);
$labels="";
$data="";
$title="";
$total_vote=0;
while ($row = mysqli_fetch_array($query)) 
{
  $labels.="'$row[candidate_name]', ";
  $data.="'$row[candidate_vote_count]', ";
  $title="$row[poll_topic_name]";
  
  $total_vote+=$row['candidate_vote_count'];
}
    
?>



<script>
// Your JavaScript code here
document.addEventListener('DOMContentLoaded', function () {
    // Sample data for the bar chart
    var data = {
        labels: [<?php echo $labels;?>],
        datasets: [{
            label: '<?php echo $title;?>',
            backgroundColor: 'rgba(75, 192, 192, 0.2)', // Color of the bars
            borderColor: 'rgba(75, 192, 192, 1)', // Border color of the bars
            borderWidth: 1, // Border width of the bars
            data: [<?php echo $data;?>] // Actual data values
        }]
    };

    // Chart configuration
    var options = {
        scales: {
            y: {
                beginAtZero: true,
                min: 0, // Set the minimum value
                max: <?php echo $total_vote; ?> // Set the maximum value (adjust as needed)
            }
        }
    };

    // Get the canvas element
    var ctx = document.getElementById('myBarChart').getContext('2d');

    // Create the bar chart
    var myBarChart = new Chart(ctx, {
        type: 'bar',
        data: data,
        options: options
    });
});
</script>

</body>
</html>


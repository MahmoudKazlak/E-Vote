
        <style>


          #notification {
            border: 2px solid #333;
            background-color: #fff;
            padding: 4px;

            text-align: center;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
          }

          #notificationList {
            list-style-type: none;
            padding: 0;
          }

          #notificationList li {
            margin: 5px 0;
            padding: 5px;
            border-bottom: 1px solid #e0e0e0; /* Light gray border between items */
            transition: background-color 0.3s ease;
            display: flex;
            justify-content: space-between;
            align-items: center;
            text-align:center;
            cursor:pointer;
          }

          #notificationList li span {
            background: #f001;
            border: 2px solid #d226;
            color: #d22;
            border-radius: 22px;
            padding: 3px;
            min-width:21px;
            font-weight:bold
          }

          #notificationList li:hover {
            background-color: #f0f2f5; /* Light blue background on hover */
          }
        </style>


        <script>
          function set_shown_notification(poll_topic_id)
          {
            //alert(poll_topic_id);
            var url = "poll-topic/show_chart.php?poll_topic_id=" + poll_topic_id;

            $.ajax({
		          type:"POST",
		          url:"set_shown_notification.php",
		          data:{
		          'poll_topic_id':poll_topic_id
	            },
		          success: function(response) {
		            //alert(response);
			          //response=JSON.parse(response.trim());
                window.open(url, "home");
	           	}
	          });
          }
          
          function get_notification()
          {
	          $.ajax({
		          type:"POST",
		          url:"get_notification.php",
		          data:{
	            },
		          success: function(response) {
		            //alert(response);
			          //response=JSON.parse(response.trim());
                $("#notificationList").html(response);
	           	}
	          });
          }


          $(document).ready(function() {

              setInterval(function() {
                  get_notification();
              }, 2500); //
          });

        </script>

        <div id="notification">
        <i class="fa fa-bell-o" style="font-size:1.7em;color:#d22;" ></i>
        <ul id="notificationList">
          
        </ul>
      </div>



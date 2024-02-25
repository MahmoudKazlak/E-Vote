import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:e_vote_app/api/config.dart';
import 'package:e_vote_app/models/notification_item.dart';
import 'package:e_vote_app/bottom_bar/bottomBar_as_function.dart';
import 'package:e_vote_app/public/globals.dart' as globals;

import 'package:e_vote_app/poll_topics/show_one_poll_topic_candidate.dart';

import 'package:hexcolor/hexcolor.dart';


class TestNotifications extends StatefulWidget {
  @override
  _TestNotificationsState createState() => _TestNotificationsState();
}

class _TestNotificationsState extends State<TestNotifications> {
  List<NotificationItem> notifications = [];
  int selectedIndex = 0;

  bool isDataLoaded = false; // Flag to track whether data has been loaded


  late Timer timer; // Define the Timer variable

  @override
  void initState() {
    super.initState();
    // Fetch notifications periodically
    timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      fetchNotifications();
    });
  }

  @override
  void dispose() {
    // Cancel the periodic timer when the widget is disposed
    timer.cancel();
    super.dispose();
  }


  Future<List<NotificationItem>> fetchNotifications() async {
    try {
      final response = await http.get(Uri.parse("http://" + config_URL + config_notifications + "?user_id=${globals.current_user_id}"));

      if (response.statusCode == 200) {
        // Parse and update notifications
        final List<dynamic> decodedData = json.decode(response.body);
        final List<NotificationItem> updatedNotifications = decodedData
            .map((item) => NotificationItem(int.parse(item['id'].toString()), item['name'].toString()))
            .toList();

        setState(() {
          notifications = updatedNotifications;
          isDataLoaded = true; // Set the flag when data is loaded
        });

        return updatedNotifications;
      } else {
        // Handle error
        print('Failed to fetch notifications. Error ${response.statusCode}');
        throw Exception('Failed to fetch notifications ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      // Handle other exceptions
      print('Error during notification fetch: $e');
      throw Exception('Error during notification fetch:$e ---'+"http://" + config_URL + config_notifications + "?user_id=${globals.current_user_id}");
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: new Stack(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
                gradient: new LinearGradient(colors: [
              const Color(0xFFEAF7F6),
              const Color(0xFF68C4C4),
            ], begin: Alignment.topCenter, end: Alignment.center)),
          ),
          new Scaffold(
            backgroundColor: HexColor("#FFFFFF"),
            bottomNavigationBar: footer(context,'${notifications.length}'),

            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Divider(
                        color: Colors.white,
                      ),
                Center(
                    child: Text(
                      "اشعارات لتصويت جديد",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xFF19978A),
                      ),
                    ),
                  ),
                 Divider(
                        color: Colors.white,
                      ),
                 Container(
                  height: 500.0,
                  child:FutureBuilder<List<NotificationItem>>(
                      future: isDataLoaded ? null : fetchNotifications(), // Use null if data is already loaded
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          // While data is being fetched, show a loading indicator
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          // If an error occurs during fetching, display an error message
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else {
                          // Display the main content when data is available
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  constraints: BoxConstraints(
                                    minWidth: 12,
                                    minHeight: 12,
                                  ),
                                  child:Text(
                                    '${notifications.length}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(height: 20), // Add spacing between text and the list
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: notifications.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(notifications[index].name,textAlign: TextAlign.center,
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                                        onTap: () async {
                                          // Navigate to another screen when the list item is clicked
                                          Navigator.push(context,MaterialPageRoute(builder: (context) => OnePollTopicCandidatePage(notifications[index].id)),);//------------------------>here must show report
                                            
                                        },
                                        
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                ),
               ],
              ),

          ),
        ],
      ),
    );
  }

}


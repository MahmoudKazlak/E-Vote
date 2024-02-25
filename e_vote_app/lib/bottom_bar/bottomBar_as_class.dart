import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:e_vote_app/login/login_page.dart';
import 'package:e_vote_app/candidate_control/notifications.dart';
import 'package:e_vote_app/personal_account/show_profile.dart';
import 'package:e_vote_app/poll_topics/show_all_poll_topics.dart';
import 'package:e_vote_app/public/globals.dart' as globals;
import 'package:e_vote_app/public/translate.dart' as translate;
import 'package:e_vote_app/api/config.dart';

import 'package:e_vote_app/models/notification_item.dart';



class CustomBottomNavigationBar {
  static int selectedIndex = 0;

  static Timer? timer;
  static List<NotificationItem> notifications = [];
  static bool isDataLoaded = false;

  

  static BottomNavigationBar? footer(BuildContext context) {
    if (globals.current_user_level == 2) {
      return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.power_settings_new),
            label: '${translate.bottomBar__logout[translate.selected_language]}',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: '${translate.bottomBar__myAccount[translate.selected_language]}',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
          icon: Stack(
            children: [
              Icon(Icons.notifications),
              Positioned(
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),

                  ),
                  constraints: BoxConstraints(
                    minWidth: 12,
                    minHeight: 12,
                  ),
                  child: FutureBuilder<List<NotificationItem>>(
                    future: CustomBottomNavigationBar.fetchNotifications(),
                    builder: (context, snapshot) {
                      final notificationCount = snapshot.data?.length ?? 0;
                      return Text(
                        '$notificationCount',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          label: '${translate.bottomBar__notifications[translate.selected_language]}',
          backgroundColor: Colors.white,
        ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '${translate.bottomBar__home[translate.selected_language]}',
            backgroundColor: Colors.white,
          ),
        ],
        currentIndex: selectedIndex,
        unselectedItemColor: Color(0xff259990),
        selectedItemColor: Color(0xff07756D),
        onTap: (index) {
          handleNavigation_candidate(context, index);
        },
      );
    } else if (globals.current_user_level == 3) {
      return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.power_settings_new),
            label: '${translate.bottomBar__logout[translate.selected_language]}',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: '${translate.bottomBar__myAccount[translate.selected_language]}',
            backgroundColor: Colors.white,
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '${translate.bottomBar__home[translate.selected_language]}',
            backgroundColor: Colors.white,
          ),
        ],
        currentIndex: selectedIndex,
        unselectedItemColor: Color(0xff259990),
        selectedItemColor: Color(0xff07756D),
        onTap: (index) {
          handleNavigation_member(context, index);
        },
      );
    } else {
      // Handle other user levels or return null
      return null;
    }
  }

  static void handleNavigation_candidate(BuildContext context, int index) {
    switch (index) {
      case 0:
        globals.current_user_id = null;
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => ShowProfile(globals.current_user_id!)));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) => TestNotifications()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context) => ShowAllPollTopicsPage()));
        break;
    }
  }
  
  static void handleNavigation_member(BuildContext context, int index) {
    switch (index) {
      case 0:
        globals.current_user_id = null;
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => ShowProfile(globals.current_user_id!)));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) => ShowAllPollTopicsPage()));
        break;
    }
  }
  
  
  
  static void setupNotificationTimer() {
    timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      fetchNotifications();
    });
  }

  static void disposeNotificationTimer() {
    timer?.cancel();
  }

  static Future<List<NotificationItem>> fetchNotifications() async {
    try {
      final response = await http.get(Uri.parse("http://" + config_URL + config_notifications + "?user_id=${globals.current_user_id}"));

      if (response.statusCode == 200) {
        final List<dynamic> decodedData = json.decode(response.body);
        final List<NotificationItem> updatedNotifications = decodedData
            .map((item) => NotificationItem(int.parse(item['id'].toString()), item['name'].toString()))
            .toList();

        notifications = updatedNotifications;
        isDataLoaded = true;

        return updatedNotifications;
      } else {
        print('Failed to fetch notifications. Error ${response.statusCode}');
        throw Exception('Failed to fetch notifications ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error during notification fetch: $e');
      throw Exception('Error during notification fetch:$e ---' + "http://" + config_URL + config_notifications + "?user_id=${globals.current_user_id}");
    }
  }
  
  
}


import 'package:flutter/material.dart';
import 'dart:io';//for use exit(0)

import 'package:e_vote_app/poll_topics/show_all_poll_topics.dart';

import 'package:e_vote_app/login/login_page.dart';


import 'package:e_vote_app/candidate_control/notifications.dart';



import 'package:e_vote_app/personal_account/edit_profile.dart';
import 'package:e_vote_app/personal_account/show_profile.dart';

import 'package:e_vote_app/public/globals.dart' as globals;
import 'package:e_vote_app/public/translate.dart' as translate;


int selectedIndex = 0; 

BottomNavigationBar? footer(BuildContext context,String notificationCount)
{
  if (globals.current_user_level == 2)//candidate
  return BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Set type to fixed to always show labels
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
                    child:Text(
                      '$notificationCount',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
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
        onTap: (index){
              //Navigator.pop(context);//close current screen this will prevent return to it
              switch(index){
                  case 0:
                    globals.current_user_id=null;
                    Navigator.pop(context);//close current screen this will prevent return to it
                    Navigator.push(context,MaterialPageRoute(builder: (context) => LoginPage()), );
                    break;
                  case 1:
                    //Navigator.pop(context);
                    Navigator.push(context,MaterialPageRoute(builder: (context) => ShowProfile(globals.current_user_id!)), );
                    break;
                  case 2:
                    //Navigator.pop(context);
                    Navigator.push(context,MaterialPageRoute(builder: (context) => TestNotifications()), );
                    break;
                  case 3:
                    //Navigator.pop(context);
                    Navigator.push(context,MaterialPageRoute(builder: (context) => ShowAllPollTopicsPage()), );//CandidateControlPage()
                    break;
                }
             },
      );
      
      else if (globals.current_user_level == 3)//member
        return BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Set type to fixed to always show labels

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
        onTap: (index){
              //Navigator.pop(context);//close current screen this will prevent return to it
              switch(index){
                  case 0:
                    globals.current_user_id=null;
                    Navigator.pop(context);//close current screen this will prevent return to it
                    Navigator.push(context,MaterialPageRoute(builder: (context) => LoginPage()), );
                    break;
                  case 1:
                    //Navigator.pop(context);
                    Navigator.push(context,MaterialPageRoute(builder: (context) => ShowProfile(globals.current_user_id!)), );
                    break;
                  case 2:
                    //Navigator.pop(context);
                    Navigator.push(context,MaterialPageRoute(builder: (context) => ShowAllPollTopicsPage()), );
                    break;
                }
             },
      );

}

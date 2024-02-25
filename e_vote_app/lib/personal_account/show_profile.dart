import 'dart:async';
import 'dart:convert';

import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';//for use exit(0)

import 'package:flutter/material.dart';
import 'package:e_vote_app/personal_account/edit_profile.dart';



import 'package:e_vote_app/poll_topics/show_all_poll_topics.dart';

import 'package:e_vote_app/bottom_bar/bottomBar_as_class.dart';

import 'package:http/http.dart' as http;

import 'package:e_vote_app/api/api_e_vote_app_method.dart';
import 'package:e_vote_app/api/config.dart';

import 'package:e_vote_app/public/globals.dart' as globals;
import 'package:e_vote_app/public/translate.dart' as translate;

Future<Map<dynamic,dynamic>> fetchData(int user_id) async {
  final response = await http.post(
    Uri.http(config_URL,config_unencodedPath),
    headers: {'Content-Type': 'application/json; charset=UTF-8'},
    body: jsonEncode({"action":"show_profile", "user_id":user_id}),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 CREATED response,
    // then parse the JSON.
    //List<UserModel> users = (json.decode(response.body) as List)
     // .map((data) => UserModel.fromJson(data))
     // .toList();
    //contacts=(jsonDecode(response.body)['dataView']).toList();
    return (jsonDecode(response.body)['dataView'] as Map<dynamic,dynamic>);
  } else {
    // If the server did not return a 200 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create card.');
  }
}






class ShowProfile extends StatefulWidget {
  //ShowProfile({Key? key, this.title}) : super(key: key);

  int user_id;
  ShowProfile(this.user_id);

  @override
  _ShowProfileState createState() => new _ShowProfileState(user_id);
}

class _ShowProfileState extends State<ShowProfile> {
  
  
  int user_id;
  _ShowProfileState(this.user_id);
  
  Map<dynamic,dynamic> _dataView_fetched = {};
  
  
  @override
  void initState(){
    super.initState();
    
    fetchData(user_id).then((result) {
      setState(() {
        _dataView_fetched = result;
      });
    });
    
    CustomBottomNavigationBar.setupNotificationTimer();
    //_contacts = await fetchData();
    
  }
  
  
  @override
  void dispose() {
    CustomBottomNavigationBar.disposeNotificationTimer();
    super.dispose();
  }


  
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return new Container(
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
            backgroundColor: Colors.transparent,
            bottomNavigationBar: CustomBottomNavigationBar.footer(context),

            body: new SingleChildScrollView(
              child: new Stack(
                children: <Widget>[
                  new Align(
                    alignment: Alignment.center,
                    child: new Padding(
                      padding: new EdgeInsets.only(top: _height / 15),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new CircleAvatar(
                            backgroundImage:NetworkImage("http://"+ config_URL+ show_img_on_server+ _dataView_fetched['img']),
                                
                            radius: _height / 10,
                          ),
                          new SizedBox(
                            height: _height / 30,
                          ),
                          new Text(
                            _dataView_fetched['fname']+" "+_dataView_fetched['lname'],
                            style: new TextStyle(
                                fontSize: 18.0,
                                color: Color(0xFF111111),
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  new Padding(
                    padding: new EdgeInsets.only(top: _height / 2.2),
                    child: new Container(
                      color: Colors.white,
                    ),
                  ),
                  new Padding(
                    padding: new EdgeInsets.only(
                        top: _height / 2.6,
                        left: _width / 20,
                        right: _width / 20),
                    child: new Column(
                      children: <Widget>[
                        new Container(
                          decoration: new BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                new BoxShadow(
                                    color: Colors.black45,
                                    blurRadius: 2.0,
                                    offset: new Offset(0.0, 2.0))
                              ]),
                          child: new Padding(
                            padding: new EdgeInsets.all(_width / 20),
                            child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  headerChild('${translate.show_profile__bio[translate.selected_language]}', _dataView_fetched['bio']),
                                ]),
                          ),
                        ),
                        new Container(
                          decoration: new BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                new BoxShadow(
                                    color: Colors.black45,
                                    blurRadius: 2.0,
                                    offset: new Offset(0.0, 2.0))
                              ]),
                          child: new Padding(
                            padding: new EdgeInsets.all(_width / 20),
                            child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  headerChild('${translate.show_profile__phone[translate.selected_language]}', _dataView_fetched['phone']),
                                ]),
                          ),
                        ),
                        new Padding(
                          padding: new EdgeInsets.only(top: _height / 20),
                          child: new Column(
                            children: <Widget>[
                              infoChild(
                                  _width, Icons.person, _dataView_fetched['fname']+" "+_dataView_fetched['lname']),
                              infoChild(_width, Icons.wc, _dataView_fetched['gender_id']==1? "Male":(_dataView_fetched['gender_id']==2? "Female":"")),
                              infoChild(_width, Icons.dashboard,
                                  _dataView_fetched['specialty_name']),
                              infoChild(_width, Icons.school,
                                  _dataView_fetched['residence_region_name']),
                              infoChild(_width, Icons.date_range,
                                  _dataView_fetched['birthdate']),

                                  
                                  
                              if(user_id==globals.current_user_id)new Padding(
                                padding: new EdgeInsets.only(top: _height / 30),
                                child:GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);//close current page
                                    Navigator.push(context,MaterialPageRoute(builder: (context) => EditProfilePage()), );
                                  },
                                  child: new Container(
                                  width: _width / 3,
                                  height: _height / 20,
                                  decoration: new BoxDecoration(
                                      color: const Color(0xFF259990),
                                      borderRadius: new BorderRadius.all(
                                          new Radius.circular(_height / 40)),
                                      boxShadow: [
                                        new BoxShadow(
                                            color: Colors.black87,
                                            blurRadius: 2.0,
                                            offset: new Offset(0.0, 1.0))
                                      ]),
                                  child: new Center(
                                    child: new Text('${translate.show_profile__editProfile[translate.selected_language]}',
                                        style: new TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  
                                ),
                                ),
                              ),
                              
                              
                              
                              
                              
                              
                              
                              SizedBox(height:25,),
                              
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget headerChild(String header, String value) => new Expanded(
          child: new Column(
        children: <Widget>[
          new Text(header),
          new SizedBox(
            height: 8.0,
          ),
          new Text(
            '$value',
            style: new TextStyle(
                fontSize: 14.0,
                color: const Color(0xFF259990),
                fontWeight: FontWeight.bold),
          )
        ],
      ));

  Widget infoChild(double width, IconData icon, data) => new Padding(
        padding: new EdgeInsets.only(bottom: 8.0),
        child: new InkWell(
          child: new Row(
            children: <Widget>[
              new SizedBox(
                width: width / 10,
              ),
              new Icon(
                icon,
                color: const Color(0xFFffffff),
                size: 36.0,
              ),
              new SizedBox(
                width: width / 20,
              ),
              new Text(data)
            ],
          ),
          onTap: () {
            print('Info Object selected');
          },
        ),
      );
}

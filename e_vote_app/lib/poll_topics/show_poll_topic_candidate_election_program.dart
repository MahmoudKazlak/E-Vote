import 'dart:async';
import 'dart:convert';

import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';//for use exit(0)

import 'package:flutter/material.dart';
import 'package:e_vote_app/personal_account/show_profile.dart';

import 'package:e_vote_app/bottom_bar/bottomBar_as_class.dart';


import 'package:hexcolor/hexcolor.dart';

import 'package:http/http.dart' as http;

import 'package:e_vote_app/api/api_e_vote_app_method.dart';
import 'package:e_vote_app/api/config.dart';

import 'package:e_vote_app/public/globals.dart' as globals;


Future<Map<dynamic,dynamic>> fetchData(int poll_topic_candidate_id) async {
  final response = await http.post(
    Uri.http(config_URL,config_unencodedPath),
    headers: {'Content-Type': 'application/json; charset=UTF-8'},
    body: jsonEncode({"action":"show_election_program", "user_id":globals.current_user_id, "poll_topic_candidate_id":poll_topic_candidate_id}),
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






class ShowPollTopicCandidateElectionProgram extends StatefulWidget {
  //ShowPollTopicCandidateElectionProgram({Key? key, this.title}) : super(key: key);

  int poll_topic_candidate_id;
  int candidate_user_id;
  ShowPollTopicCandidateElectionProgram(this.poll_topic_candidate_id,this.candidate_user_id);

  @override
  _ShowPollTopicCandidateElectionProgramState createState() => new _ShowPollTopicCandidateElectionProgramState(poll_topic_candidate_id,candidate_user_id);
}

class _ShowPollTopicCandidateElectionProgramState extends State<ShowPollTopicCandidateElectionProgram> {
  
  
  int poll_topic_candidate_id;
  int candidate_user_id;
  _ShowPollTopicCandidateElectionProgramState(this.poll_topic_candidate_id,this.candidate_user_id);
  
  Map<dynamic,dynamic> _dataView_fetched = {};
  
  
  @override
  void initState(){
    super.initState();
    
    fetchData(poll_topic_candidate_id).then((result) {
      setState(() {
        _dataView_fetched = result;
      });
    });
    //_contacts = await fetchData();

    
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
            backgroundColor: HexColor("#68C4C4"),

            bottomNavigationBar: CustomBottomNavigationBar.footer(context),
            body: Center(
              child: SingleChildScrollView(
                  child: Column(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              _dataView_fetched['election_program'],
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Color(0xFFFFFFFF),
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height:55,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          
                          
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ShowProfile(candidate_user_id!)),
                                );
                              },
                              child: Container(
                                width: _width / 1.5,
                                height: _height / 18,
                                decoration: BoxDecoration(
                                  color: Color(0xFF259990),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(_height / 40),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black87,
                                      blurRadius: 2.0,
                                      offset: Offset(0.0, 1.0),
                                    )
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    'Show Candidate Profile',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),



                          ],
                        ),

                      
                      ],
                    ),

                ),
              ),
          ),
        ],
      ),
    );






  }

}

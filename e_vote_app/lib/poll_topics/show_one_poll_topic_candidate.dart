import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hexcolor/hexcolor.dart';

import 'package:e_vote_app/api/api_e_vote_app_method.dart';
import 'package:e_vote_app/api/config.dart';

import 'package:e_vote_app/public/alert_dialog.dart';
import 'package:e_vote_app/poll_topics/show_poll_topic_candidate_election_program.dart';

import 'package:e_vote_app/public/globals.dart' as globals;
import 'package:e_vote_app/public/translate.dart' as translate;


import 'package:e_vote_app/bottom_bar/bottomBar_as_class.dart';

import 'package:e_vote_app/models/poll_topic_candidate_model.dart';

Future<List<PollTopicCandidate>> createPollTopicCandidate(int poll_topic_id) async {
  final response = await http.post(
    Uri.http(config_URL,config_unencodedPath),
    headers: {'Content-Type': 'application/json; charset=UTF-8'},
    body: jsonEncode({"action":"show_poll_topic_candidate", "poll_topic_id":poll_topic_id, "user_id":globals.current_user_id}),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 CREATED response,
    // then parse the JSON.
    //List<UserModel> users = (json.decode(response.body) as List)
     // .map((data) => UserModel.fromJson(data))
     // .toList();
    return (jsonDecode(response.body)['dataView'] as List).map((data) => new PollTopicCandidate.fromJson(data)).toList();
  } else {
    // If the server did not return a 200 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create poll_topic_candidate.');
  }
}




class OnePollTopicCandidatePage extends StatefulWidget {

  int poll_topic_id;
  OnePollTopicCandidatePage(this.poll_topic_id);
  
  @override
  State<OnePollTopicCandidatePage> createState() {
    return _OnePollTopicCandidatePageState(poll_topic_id);
  }
}

class _OnePollTopicCandidatePageState extends State<OnePollTopicCandidatePage> {
  final TextEditingController _controller = TextEditingController();
  Future<PollTopicCandidate>? _futurePollTopicCandidate;

  int poll_topic_id;
  _OnePollTopicCandidatePageState(this.poll_topic_id);



  @override
  void initState(){
    super.initState();
    
    
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor("#68C4C4"),
        bottomNavigationBar: CustomBottomNavigationBar.footer(context),
        body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
                  color: Colors.white,
                ),
                
          Center(
              child: Text(
                "عمل تصويت للمرشحين في الاستفتاء ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
           Divider(
                  color: Colors.white,
                ),
           Container(
            height: 500.0,
            child:buildFutureBuilder(),
          ),
         ],
        ),
      ),
    );

  }


  FutureBuilder<List<PollTopicCandidate>> buildFutureBuilder() {
    return FutureBuilder<List<PollTopicCandidate>>(
      future: createPollTopicCandidate(poll_topic_id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<PollTopicCandidate> poll_topic_candidates = snapshot.data!;
          return new List_of_poll_topic_candidate(poll_topic_id,poll_topic_candidates);
          //return Text(snapshot.data!.name);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}






class List_of_poll_topic_candidate extends StatefulWidget {

  int poll_topic_id;
  final List<PollTopicCandidate> poll_topic_candidates;
  List_of_poll_topic_candidate(this.poll_topic_id,this.poll_topic_candidates);
  
  @override
  State<List_of_poll_topic_candidate> createState() {
    return _List_of_poll_topic_candidate(poll_topic_id,poll_topic_candidates);
  }
}




class _List_of_poll_topic_candidate extends State<List_of_poll_topic_candidate> {


  int poll_topic_id;
  final List<PollTopicCandidate> poll_topic_candidates;
  
  _List_of_poll_topic_candidate(this.poll_topic_id,this.poll_topic_candidates);

  Widget build(context) {
  

    
    return ListView.builder(
      itemCount: poll_topic_candidates.length,
      itemBuilder: (context, int currentIndex) {
        return createViewItem(poll_topic_candidates[currentIndex], context,currentIndex);
      },
    );
  }

  Widget createViewItem(PollTopicCandidate poll_topic_candidate, BuildContext context,int currentIndex) {
    
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
          new GestureDetector(
            onLongPress: () {
              // Handle long press here, navigate to another screen
              Navigator.push(context, MaterialPageRoute(builder: (context) => ShowPollTopicCandidateElectionProgram(poll_topic_candidate.id!,poll_topic_candidate.candidate_user_id!)));
            },
            child: CheckboxListTile(
              title: Text(
                poll_topic_candidate.name!,
                textAlign: TextAlign.right,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              subtitle: Text('عدد الاصوات: ' + poll_topic_candidate.candidate_votes_count!.toString() + '  ', textAlign: TextAlign.right,),
              secondary: Icon(Icons.person),
              autofocus: false,
              activeColor: Colors.white,
              checkColor: Colors.green,
              selected: poll_topic_candidate.is_checked!,
              value: poll_topic_candidate.is_checked!,
              controlAffinity: ListTileControlAffinity.leading, // align check to left
              onChanged: (bool? value) async {
              //Navigator.push(context,MaterialPageRoute(builder: (context) => OnePollTopicCandidatePage()),);
              
              bool result = await showConfirmationDialog(context, '${translate.show_one_poll_topic_candidate__dialogContent[translate.selected_language]}');

              if(result)
              {
                Map<String, dynamic> response_list= await api_e_vote_app_post_request({"action":"vote_to_poll_topic_candidate", "user_id":globals.current_user_id,'poll_topic_candidate_id':poll_topic_candidate.id!,'is_checked':(value!)==null?false:value!});
                
                
                if(response_list["status"]=="succeed")
                {
                  setState(() {
                    poll_topic_candidate.set_is_checked=value!;
                  });
                  
                  showAlertDialog(context,"تم",response_list["body"]);
                  
                  //Navigator.pop(context);
                  //Navigator.push(context,MaterialPageRoute(builder: (context) => OnePollTopicCandidatePage()),);
                }
                else if(response_list["status"]=="failed")
                {
                  showAlertDialog(context,"تنبيه",response_list["body"]);
                }
                else
                {
                  showAlertDialog(context,"خطأ","غير معروف");
                }

              }
              
              
            },
            ),
          ),
        ],
      ),
    );
    
  }
  
  
  
  
  
  
  
  
  Future<bool> showConfirmationDialog(BuildContext context, String message) async {
    return (await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${translate.show_one_poll_topic_candidate__dialogTitle[translate.selected_language]}',textAlign: translate.text_dir == "rtl" ? TextAlign.right : TextAlign.left,),
          content: Text(message,textAlign: translate.text_dir == "rtl" ? TextAlign.right : TextAlign.left,),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Return true if user clicks Yes
              },
              child: Text('${translate.show_one_poll_topic_candidate__dialogYes[translate.selected_language]}',textAlign: translate.text_dir == "rtl" ? TextAlign.right : TextAlign.left,),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Return false if user clicks No
              },
              child: Text('${translate.show_one_poll_topic_candidate__dialogNo[translate.selected_language]}',textAlign: translate.text_dir == "rtl" ? TextAlign.right : TextAlign.left,),
            ),
          ],
        );
      },
    ))?? false;
  }




  
  
  
  
}

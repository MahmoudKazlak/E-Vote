import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hexcolor/hexcolor.dart';

import 'package:e_vote_app/api/api_e_vote_app_method.dart';
import 'package:e_vote_app/api/config.dart';

import 'package:e_vote_app/public/alert_dialog.dart';


import 'package:e_vote_app/public/globals.dart' as globals;

import 'package:e_vote_app/public/translate.dart' as translate;

import 'package:e_vote_app/bottom_bar/bottomBar_as_class.dart';

import 'package:e_vote_app/models/poll_topic_model.dart';

import 'package:e_vote_app/poll_topics/show_one_poll_topic_candidate.dart';

Future<List<PollTopic>> createPollTopic() async {
  final response = await http.post(
    Uri.http(config_URL,config_unencodedPath),
    headers: {'Content-Type': 'application/json; charset=UTF-8'},
    body: jsonEncode({"action":"show_all_poll_topics", "user_id":globals.current_user_id}),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 CREATED response,
    // then parse the JSON.
    //List<UserModel> users = (json.decode(response.body) as List)
     // .map((data) => UserModel.fromJson(data))
     // .toList();
    return (jsonDecode(response.body)['dataView'] as List).map((data) => new PollTopic.fromJson(data)).toList();
  } else {
    // If the server did not return a 200 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create poll_topic.');
  }
}


class ShowAllPollTopicsPage extends StatefulWidget {


  @override
  State<ShowAllPollTopicsPage> createState() {
    return _ShowAllPollTopicsPageState();
  }
}

class _ShowAllPollTopicsPageState extends State<ShowAllPollTopicsPage> {
  final TextEditingController _controller = TextEditingController();
  Future<PollTopic>? _futurePollTopic;


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
            body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Divider(
                      color: Colors.white,
                    ),
              Center(
                  child: Text(
                    '${translate.show_all_poll_topics__title[translate.selected_language]}',
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
                child:buildFutureBuilder(),
              ),
             ],
            ),
          ),
        ],
      ),
    );

  }


  FutureBuilder<List<PollTopic>> buildFutureBuilder() {
    return FutureBuilder<List<PollTopic>>(
      future: createPollTopic(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<PollTopic> poll_topics = snapshot.data!;
          return new List_of_poll_topics(poll_topics);
          //return Text(snapshot.data!.title);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}






class List_of_poll_topics extends StatefulWidget {

  final List<PollTopic> poll_topics;
  List_of_poll_topics(this.poll_topics);
  
  @override
  State<List_of_poll_topics> createState() {
    return _List_of_poll_topics(poll_topics);
  }
}




class _List_of_poll_topics extends State<List_of_poll_topics> {
  final List<PollTopic> poll_topics;


  
  
  _List_of_poll_topics(this.poll_topics);

  Widget build(context) {
  

    
    return ListView.builder(
      itemCount: poll_topics.length,
      itemBuilder: (context, int currentIndex) {
        if(poll_topics[currentIndex].type =="adv")
        {
          return createAdv(poll_topics[currentIndex], context,currentIndex);
        }
        
        return createViewItem(poll_topics[currentIndex], context,currentIndex);
        
      },
    );
  }


  Widget createViewItem(PollTopic poll_topic, BuildContext context,int currentIndex) {
    return ListTile(
      title: Text(
        poll_topic.name!,
        textAlign: translate.text_dir == "rtl" ? TextAlign.right : TextAlign.left,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
      ),
      subtitle: Text('${translate.show_all_poll_topics__publish[translate.selected_language]}:' + poll_topic.insert_time!, textAlign: translate.text_dir == "rtl" ? TextAlign.right : TextAlign.left ,),
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.poll, color: Colors.white),
          SizedBox(width: 8), // Adjust the spacing between the icons and the text
          if(poll_topic.is_ended! =="yes")Icon(Icons.check_circle, color: Color(0xFF41AF48)) else SizedBox(width: 2), // Replace YourNewIconHere with the desired icon
        ],
      ),
      onTap: () async {
        // Navigate to another screen when the list item is clicked
        Navigator.push(context,MaterialPageRoute(builder: (context) => OnePollTopicCandidatePage(poll_topic.id!)),);
          
      },
    );
  }
  
  
  Widget createAdv(PollTopic poll_topic, BuildContext context,int currentIndex) {
    return Container(
    decoration: BoxDecoration(
      color: Color(0x23FFFFFF),
      border: Border.all(
        color: Color(0x55FFFFFF),  // You can change the color of the border
        width: 1.0,          // You can change the width of the border
      ),
      borderRadius: BorderRadius.all(Radius.circular(8.0)),  // You can adjust the border radius
    ),
    child: ListTile(
      title: Text(
        poll_topic.name!,
        textAlign: translate.text_dir == "rtl" ? TextAlign.right : TextAlign.left,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: Color(0xFF932045)),
      ),
      subtitle: Text(
        '${translate.show_all_poll_topics__adv[translate.selected_language]}',
        textAlign: translate.text_dir == "rtl" ? TextAlign.right : TextAlign.left,
        style: TextStyle(color: Color(0xFFC52727)),
      ),
      leading: Icon(Icons.brightness_auto, color: Color(0xFFCBA515)),
    ),
    );
  }
  
  
  
  
  
}

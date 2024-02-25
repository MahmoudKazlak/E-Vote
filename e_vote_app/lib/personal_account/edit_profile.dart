import 'dart:async';
import 'dart:convert';
import 'dart:io';//for use exit(0)

import 'package:intl/intl.dart' as intl;//for dateformat and must use "as intl" to prevent error in other library like using TextDirection.ltr

import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:hexcolor/hexcolor.dart';

import 'package:e_vote_app/api/api_e_vote_app_method.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import 'package:e_vote_app/bottom_bar/bottomBar_as_class.dart';

import 'package:e_vote_app/api/config.dart';

import 'package:e_vote_app/public/alert_dialog.dart';

import 'package:e_vote_app/personal_account/show_profile.dart';


import 'package:e_vote_app/public/globals.dart' as globals;
import 'package:e_vote_app/public/translate.dart' as translate;



import 'package:e_vote_app/models/profile_model.dart';


Future<ProfileModel> createProfileModel() async {
  final response = await http.post(
    Uri.http(config_URL,config_unencodedPath),
    headers: {'Content-Type': 'application/json; charset=UTF-8'},
    body: jsonEncode({"action":"show_profile", "user_id":globals.current_user_id}),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 CREATED response,
    // then parse the JSON.
    //List<UserModel> users = (json.decode(response.body) as List)
     // .map((data) => UserModel.fromJson(data))
     // .toList();
     dynamic jsonD = jsonDecode(response.body);
     ProfileModel profileModel = ProfileModel.fromJson(jsonD['dataView']);

    return profileModel;
    
  } else {
    // If the server did not return a 200 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create profile_model.');
  }
}





class EditProfilePage extends StatefulWidget {


  @override
  State<EditProfilePage> createState() {
    return _EditProfilePageState();
  }
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _controller = TextEditingController();
  Future<ProfileModel>? _futureProfileModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar: CustomBottomNavigationBar.footer(context),
        body: Container(
            decoration: BoxDecoration(
                gradient: new LinearGradient(colors: [
                  Color(0xFFEAF7F6),
                  Color(0xFF68C4C4),
              ], begin: Alignment.topCenter, end: Alignment.center)
            ),
            
            child: buildFutureBuilder(),
        ),
            
      ),
    );

  }


  FutureBuilder<ProfileModel> buildFutureBuilder() {
    return FutureBuilder<ProfileModel>(
      future: createProfileModel(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          ProfileModel profile_model = snapshot.data!;
          return new PageContent(profile_model);
          //return Text(snapshot.data!.title);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return CircularProgressIndicator();
      },
    );
  }
}






class PageContent extends StatefulWidget {

  ProfileModel profile_model;
  PageContent(this.profile_model);
  
  @override
  State<PageContent> createState() {
    return _PageContent(profile_model);
  }
}


int firstTime=1;

class _PageContent extends State<PageContent> {
  ProfileModel profile_model;


  
  
  _PageContent(this.profile_model);



  File? _image;
  final picker = ImagePicker();
  

  
  Future choiceImage()async{
    var pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedImage == null ? null : File(pickedImage!.path);
    });
  }
  
  
  Future uploadImage()async{
    final uri = Uri.parse("http://"+config_URL+config_unencodedPath_upload_img);
    var request = http.MultipartRequest('POST',uri);
    request.fields['user_id'] = globals.current_user_id.toString();
    var pic = await http.MultipartFile.fromPath("image", _image!.path);
    request.files.add(pic);
    var response = await request.send();

    if (response.statusCode == 200) {
      print('Image Uploded');
    }else{
      print('Image Not Uploded');
    }
    setState(() {
      
    });
  }
  
  
  
  
  String? _residence_region_id;
  List<Map> _residence_regionJSON = [];

  String? _specialty_id;
  List<Map> _specialtyJSON = [];
  
  int _gender_id=0;
  String _gender_name="";
  
  String _img_name="";
  


  TextEditingController _fname = TextEditingController();
  TextEditingController _lname = TextEditingController();
  TextEditingController _bio = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _birthdate = TextEditingController();
  
  TextEditingController _loginname = TextEditingController();
  TextEditingController _password = TextEditingController();
  


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
  
  
  Widget build(context) {
    if(firstTime==1)//dont rebuild it at any change
    {
      firstTime=0;
    _fname.text=profile_model.fname;
    _lname.text=profile_model.lname;
    _bio.text=profile_model.bio;
    _phone.text=profile_model.phone;
    _loginname.text=profile_model.loginname;
    //_password.text=profile_model.password;
    _birthdate.text=profile_model.birthdate;
    _residence_region_id=profile_model.residence_region_id.toString();
    _specialty_id=profile_model.specialty_id.toString();
    _img_name=profile_model.img.toString();
    
    
    _gender_id=profile_model.gender_id;
    
    _residence_regionJSON=profile_model.residence_region;
    _specialtyJSON=profile_model.specialties;
    }
    
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          

          SizedBox(
            height: 10,
          ),
          Center(
          child:IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                choiceImage();
              },
            ),
          ),
          
          Center(
          child:
          Container(
            width: 150,
            height: 150,
            child: _image == null ? (profile_model.img==null?Icon(Icons.image, size: 50.0, color: Color(0xFFF7F7F7)): CircleAvatar( backgroundImage: NetworkImage("http://"+ config_URL+ show_img_on_server + _img_name ), radius:60,)) : CircleAvatar(backgroundImage: FileImage(_image!),radius:60),
          
          ),
          ),
          SizedBox(
            height: 4,
          ),
          Center(
          child:
          ElevatedButton(
              child: Text('${translate.edit_profile__saveImg[translate.selected_language]}',textAlign: translate.text_dir == "rtl" ? TextAlign.right : TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold,color:Color(0xFFffffff)),),
              onPressed: () {
                 uploadImage(); 
              },
              style: ElevatedButton.styleFrom(
                  side: BorderSide(
                      width: 1, // the thickness
                      color: Color(0xFF259990) // the color of the border
                  ),
                  backgroundColor:HexColor("#259990"),
                  foregroundColor:HexColor("#fdfdfd"),
                  shape:RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
               ),
            ),
            ),
          Divider(
                  color: Color(0xff301D35),
                ),



          SizedBox(
            height: 20,
          ),
          
          Center(
          child:Container(
            width: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                
                
                new SizedBox(
                  height: 35,
                  width: 140,


                  child:TextField(
                  controller: _fname,
                  //textDirection: TextDirection.rtl,
                  //textAlign: TextAlign.right,
                    style: TextStyle(color: Color(0xff301D35),fontSize: 14.0,),
                    textDirection: translate.text_dir == "rtl" ? TextDirection.rtl : TextDirection.ltr,
                    textAlign: translate.text_dir == "rtl" ? TextAlign.right : TextAlign.left,
                    decoration: new InputDecoration(
                      border: OutlineInputBorder(),//UnderlineInputBorder
                      labelText: '${translate.edit_profile__fname[translate.selected_language]}',
                      hintText: '${translate.edit_profile__fname[translate.selected_language]}',
                      hintStyle: TextStyle(fontSize: 13.0, color: Color(0xff301D35),),
                      
                    ),
                    ),
                  
                ),
                SizedBox(
                  width: 20,
                ),
                new SizedBox(
                  height: 35,
                  width: 140,


                  child:TextField(
                    controller: _lname,
                    //textDirection: TextDirection.rtl,
                    textDirection: translate.text_dir == "rtl" ? TextDirection.rtl : TextDirection.ltr,
                    textAlign: translate.text_dir == "rtl" ? TextAlign.right : TextAlign.left,
                    style: TextStyle(color: Color(0xff301D35),fontSize: 14.0,),
                    decoration: new InputDecoration(
                      border: OutlineInputBorder(),//UnderlineInputBorder
                      labelText: '${translate.edit_profile__lname[translate.selected_language]}',
                      hintText: '${translate.edit_profile__lname[translate.selected_language]}',
                      hintStyle: TextStyle(fontSize: 13.0, color: Color(0xff301D35),),
                      

                    
                    ),
                  ),
                ), 
                

            ],
            ),
           ),
          ),
          
          SizedBox(
            height: 10,
          ),
          
          
          Center(
            child:Container(
            width: 300,
            child:
              new SizedBox(
                height: 35,
                width: 140,

                  child:TextField(
                  controller: _bio,
                  //textDirection: TextDirection.rtl,
                  textDirection: translate.text_dir == "rtl" ? TextDirection.rtl : TextDirection.ltr,
                  textAlign: translate.text_dir == "rtl" ? TextAlign.right : TextAlign.left,
                  style: TextStyle(color: Color(0xff301D35),fontSize: 14.0,),
                  decoration: new InputDecoration(
                    border: OutlineInputBorder(),//UnderlineInputBorder
                    labelText: '${translate.edit_profile__bio[translate.selected_language]}',
                    hintText: '${translate.edit_profile__bio[translate.selected_language]}',
                    
                    hintStyle: TextStyle(fontSize: 13.0, color: Color(0xff301D35)),
                    
                    

                  
                ),
               ),
              ), 
           ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child:Container(
            width: 300,
            child:
              new SizedBox(
                height: 35,
                width: 140,

                  child:TextField(
                  controller: _phone,
                  //textDirection: TextDirection.rtl,
                  textDirection: translate.text_dir == "rtl" ? TextDirection.rtl : TextDirection.ltr,
                  textAlign: translate.text_dir == "rtl" ? TextAlign.right : TextAlign.left,
                  style: TextStyle(color: Color(0xff301D35),fontSize: 14.0,),
                  decoration: new InputDecoration(
                    border: OutlineInputBorder(),//UnderlineInputBorder
                    labelText: '${translate.edit_profile__phone[translate.selected_language]}',
                    hintText: '${translate.edit_profile__phone[translate.selected_language]}',
                    hintStyle: TextStyle(fontSize: 13.0, color: Color(0xff301D35)),
                    

                  
                ),
               ),
              ), 
           ),
          ),
          
          
         Center(
          child:Container(
            width: 300,
            child: Row(
              mainAxisAlignment: translate.text_dir == "rtl" ? MainAxisAlignment.end : MainAxisAlignment.start,//spaceBetween or end
              children: <Widget>[
                Radio(
                  value: 1,
                  groupValue: _gender_id,
                  onChanged: (int? val) {
                    setState(() {
                      _gender_name = 'male';
                      _gender_id = 1;
                      //profile_model.set_gender_id=val!;
                    });
                  },
                ),
                Text(
                '${translate.edit_profile__male[translate.selected_language]}',
                  style: new TextStyle(fontSize: 15.0,color:Color(0xff301D35)),
                ),
                SizedBox(
                  width: 20,
                ),
                
                Radio(
                  value: 2,
                  groupValue: _gender_id,
                  onChanged: (int? val) {
                    setState(() {
                      _gender_name = 'famale';
                      _gender_id = 2;
                      //profile_model.set_gender_id=val!;
                    });
                  },
                ),
                Text(
                '${translate.edit_profile__female[translate.selected_language]}',
                  style: new TextStyle(fontSize: 15.0,color:Color(0xff301D35)),
                ),
                
                
                
                
              ],
              ),
            ), 
          ),

          Center(
            child:Container(
            width: 300,
            height: 60,
            child:Directionality(
              textDirection: translate.text_dir == "rtl" ? TextDirection.rtl : TextDirection.ltr,
              child:StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {//this is important to use "setState"
                  return   new DropdownButton(
                    isDense: true,
                    isExpanded: true, // Set this to true
                    hint: new Text("${translate.edit_profile__specialty[translate.selected_language]}",),
                    value: _specialty_id,
                    
                    onChanged: ( String? newValue) {

                      setState(() {
                        _specialty_id = newValue!.toString();
                      });

                      print (_specialty_id);
                    },
                    items: _specialtyJSON.map((Map map) {
                      return new DropdownMenuItem(
                        value: map["id"].toString(),
                        //textAlign: TextAlign.right,
                        child: new Text(
                          map["name"],
                        ),
                      );
                    }).toList(),
                  );
                 },
               ),
           ),
           ),
          ),
          
          SizedBox(
            height: 10,
          ),
          
          Center(
            child:Container(
            width: 300,
            height: 60,
            child:Directionality(
              textDirection: translate.text_dir == "rtl" ? TextDirection.rtl : TextDirection.ltr,
              child:StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {//this is important to use "setState"
                  return  new DropdownButton(
                    isDense: true,
                    isExpanded: true, // Set this to true
                    hint: new Text("${translate.edit_profile__residenceRegion[translate.selected_language]}",textAlign: translate.text_dir == "rtl" ? TextAlign.right : TextAlign.left,),
                    value: _residence_region_id,
                    
                    onChanged: ( String? newValue) {

                      setState(() {
                        _residence_region_id = newValue!.toString();
                      });

                      print (_residence_region_id);
                    },
                    items: _residence_regionJSON.map((Map map) {
                      return new DropdownMenuItem(
                        value: map["id"].toString(),
                        //textAlign: TextAlign.right,
                        child: new Text(
                          map["name"],
                        ),
                      );
                    }).toList(),
                  );
                 },
               ),
           ),
           ),
          ),
          
          SizedBox(
            height: 7,
          ),
          
          Center(
          child:Container(
            width: 300,
            height:35,
            child:TextField(
              controller: _birthdate,
              //editing controller of this TextField
              textDirection: translate.text_dir == "rtl" ? TextDirection.rtl : TextDirection.ltr,
              textAlign: translate.text_dir == "rtl" ? TextAlign.right : TextAlign.left,
              style: TextStyle(color: Color(0xff301D35)),
              decoration: new InputDecoration(
                      border: OutlineInputBorder(),//UnderlineInputBorder
                      alignLabelWithHint: true,
                      labelText: '${translate.edit_profile__birthdate[translate.selected_language]}',
                      hintText: '${translate.edit_profile__birthdate[translate.selected_language]}',
                      hintStyle: TextStyle(fontSize: 13.0, color: Color(0xff301D35),),
                    ),
              readOnly: true,
              //set it true, so that user will not able to edit text
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime(2000),
                    firstDate: DateTime(1950),
                    //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime.now());
 
                if (pickedDate != null) {
                  String formattedDate =intl.DateFormat('yyyy-MM-dd').format(pickedDate);
                  setState(() {
                    _birthdate.text =formattedDate; //set output date to TextField value.
                  });
                } else {}
              },
            )
            
          ),
          ),
          
          
          SizedBox(
            height: 20,
          ),
          
          
          Center(
          child:Container(
            width: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                
                
                new SizedBox(
                  height: 35,
                  width: 140,


                  child:TextField(
                  controller: _loginname,
                    textDirection: translate.text_dir == "rtl" ? TextDirection.rtl : TextDirection.ltr,
                    textAlign: translate.text_dir == "rtl" ? TextAlign.right : TextAlign.left,
                    style: TextStyle(color: Color(0xff301D35),fontSize: 14.0,),
                    decoration: new InputDecoration(
                      border: OutlineInputBorder(),//UnderlineInputBorder
                      labelText: '${translate.edit_profile__username[translate.selected_language]}',
                      hintText: '${translate.edit_profile__username[translate.selected_language]}',
                      hintStyle: TextStyle(fontSize: 13.0, color: Color(0xff301D35),),
                      
                    ),
                    ),
                  
                ),
                SizedBox(
                  width: 20,
                ),
                new SizedBox(
                  height: 35,
                  width: 140,


                  child:TextField(
                    controller: _password,
                    textDirection: translate.text_dir == "rtl" ? TextDirection.rtl : TextDirection.ltr,
                    textAlign: translate.text_dir == "rtl" ? TextAlign.right : TextAlign.left,
                    style: TextStyle(color: Color(0xff301D35),fontSize: 14.0,),
                    obscureText:true,
                    decoration: new InputDecoration(
                      border: OutlineInputBorder(),//UnderlineInputBorder
                      labelText: '${translate.edit_profile__password[translate.selected_language]}',
                      hintText: '${translate.edit_profile__password[translate.selected_language]}',
                      hintStyle: TextStyle(fontSize: 13.0, color: Color(0xff301D35),),
                      

                    
                    ),
                  ),
                ), 
                

            ],
            ),
           ),
          ),
          
          
          SizedBox(
            height: 20,
          ),
          
          
          Center(
          child:Container(
            width: 300,
            child: ElevatedButton(
              child: Text('${translate.edit_profile__saveChange[translate.selected_language]}',style: TextStyle(fontWeight: FontWeight.bold,color:Color(0xFFffffff)),),
              onPressed: () async {
 
                  Map<String, dynamic> response_list= await api_e_vote_app_post_request( {"action":"update_your_profile", "user_id":globals.current_user_id, "fname":_fname.text,  "lname":_lname.text, "phone":_phone.text, "phone":_phone.text, "birthdate":_birthdate.text, "gender_id":_gender_id, "specialty_id":_specialty_id, "residence_region_id":_residence_region_id, "loginname":_loginname.text,  "password":_password.text});
                  
                  
                  if(response_list["status"]=="succeed")
                  {
                    showAlertDialog(context,"تم",response_list["body"]);
                    firstTime=1;
                    Navigator.pop(context);//close current page
                    Navigator.push(context,MaterialPageRoute(builder: (context) => ShowProfile(globals.current_user_id!)),);
                    
	                  
	                  
	                }
	                else if(response_list["status"]=="failed")
	                {
	                  showAlertDialog(context,"تنبيه",response_list["body"]);
	                }
	                else
	                {
	                  showAlertDialog(context,"خطأ","غير معروف");
	                }
              },
              style: ElevatedButton.styleFrom(
                  side: BorderSide(
                      width: 1, // the thickness
                      color: Color(0xFF259990) // the color of the border
                  ),
                  backgroundColor:HexColor("#259990"),
                  foregroundColor:HexColor("#fdfdfd"),
                  shape:RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
               ),
            ),
          ),
          ),
          Center(
          child:Container(
            width: 300,
            child: ElevatedButton(
              child: Text('${translate.edit_profile__back[translate.selected_language]}',style: TextStyle(fontWeight: FontWeight.bold,color:Color(0xFFffffff)),),
              onPressed: () async {
                 firstTime=1;
                 Navigator.pop(context);//close current page
                 Navigator.push(context,MaterialPageRoute(builder: (context) => ShowProfile(globals.current_user_id!)),);
              },
              style: ElevatedButton.styleFrom(
                  side: BorderSide(
                      width: 1, // the thickness
                      color: Color(0xFF259990) // the color of the border
                  ),
                  backgroundColor:HexColor("#259990"),
                  foregroundColor:HexColor("#fdfdfd"),
                  shape:RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
               ),
            ),
          ),
          ),

          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }



  
  
  
  
  
  
  
}

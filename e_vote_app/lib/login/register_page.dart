import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:e_vote_app/login/login_page.dart';
import 'package:snippet_coder_utils/FormHelper.dart';


import 'package:e_vote_app/api/api_e_vote_app_method.dart';

import 'package:e_vote_app/personal_account/edit_profile.dart';


import 'package:e_vote_app/public/alert_dialog.dart';
import 'package:e_vote_app/public/globals.dart' as globals;
import 'package:e_vote_app/public/translate.dart' as translate;

import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage();
  @override
  _RegisterPage createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  bool hidepassWord = true;
  bool hiderepassWord = true;
  
  final globleFormKey = GlobalKey<FormState>();
  bool vis = true;
  TextEditingController _c_loginname = TextEditingController();
  TextEditingController _c_password = TextEditingController();
  TextEditingController _c_repassword = TextEditingController();



  bool validate = false;
  bool circular = false;
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor("#68C4C4"),
        body: Form(
          key: globleFormKey,
          child: _registerUI(context),
        ),
      ),
    );
  }

  Widget _registerUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 3,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Colors.white,
                    ]),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/signup.png",
                    width: 280.0,
                    fit: BoxFit.contain,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: 10,
              top: 10,
            ),
            child: Center(
              child: Text(
                "${translate.register_page__title[translate.selected_language]}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: SizedBox(
              width: 355.0,
              height: 70,
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                controller: _c_loginname,
                validator: (value) {
                  if (value!.isEmpty) return "loginname can't be empty";
                  return null;
                },
                textAlign: translate.text_dir == "rtl" ? TextAlign.right : TextAlign.left,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: Colors.white),
                      borderRadius: BorderRadius.circular(50.0)),
                  hintText: "${translate.register_page__loginname[translate.selected_language]}",
                  hintStyle: TextStyle(
                      fontSize: 15.0, color: Colors.white.withOpacity(0.7)),
                  errorText: validate ? null : errorText,
                  suffixIcon: Icon(Icons.person),
                  iconColor: Colors.black38,
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: Colors.white),
                      borderRadius: BorderRadius.circular(50.0)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: Colors.white),
                      borderRadius: BorderRadius.circular(50.0)),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: SizedBox(
              width: 355.0,
              height: 70,
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                textAlign: translate.text_dir == "rtl" ? TextAlign.right : TextAlign.left,
                obscureText: hidepassWord,
                controller: _c_password,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: Colors.white),
                      borderRadius: BorderRadius.circular(50.0)),
                  hintText: "${translate.register_page__password[translate.selected_language]}",
                  hintStyle: TextStyle(
                      fontSize: 15.0, color: Colors.white.withOpacity(0.7)),
                  suffixIcon: IconButton(//suffixIcon ==> at right direction
                    onPressed: () {
                      setState(() {
                        hidepassWord = !hidepassWord;
                      });
                    },
                    icon: Icon(
                        hidepassWord ? Icons.visibility_off : Icons.visibility),
                  ),
                  iconColor: Colors.black38,
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: Colors.white),
                      borderRadius: BorderRadius.circular(50.0)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: Colors.white),
                      borderRadius: BorderRadius.circular(50.0)),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: SizedBox(
              width: 355.0,
              height: 70,
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                textAlign: translate.text_dir == "rtl" ? TextAlign.right : TextAlign.left,
                obscureText: hiderepassWord,
                controller: _c_repassword,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: Colors.white),
                      borderRadius: BorderRadius.circular(50.0)),
                  hintText: "${translate.register_page__repassword[translate.selected_language]}",
                  hintStyle: TextStyle(
                      fontSize: 15.0, color: Colors.white.withOpacity(0.7)),
                  suffixIcon: IconButton(//prefixIcon ==> at left direction
                    onPressed: () {
                      setState(() {
                        hiderepassWord = !hiderepassWord;
                      });
                    },
                    icon: Icon(
                        hiderepassWord ? Icons.visibility_off : Icons.visibility),
                  ),
                  iconColor: Colors.black38,
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: Colors.white),
                      borderRadius: BorderRadius.circular(50.0)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: Colors.white),
                      borderRadius: BorderRadius.circular(50.0)),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          circular
              ? Center(child: CircularProgressIndicator())
              : Center(
                  child: FormHelper.submitButton(
                    "${translate.register_page__title[translate.selected_language]}",
                    () async {
                       if (_c_loginname.text.length == 0) {
                          setState(() {
                            // circular = false;
                            validate = false;
                            errorText = "loginname Can't be empty";
                          });
                          return;
                        }
                        
                        if (_c_password.text != _c_repassword.text) {
                          showAlertDialog(context,"Check Password!","Your password is not equal");
                          return;
                        }
                        
                        
                        Map<String, dynamic> response_list= await api_e_vote_app_post_request( {"action":"do_signup", "loginname": _c_loginname.text, "password":_c_password.text});
                        

                        
                        if(response_list["status"]=="succeed" )
                        {
                          globals.current_user_id=response_list["user_id"];
                          //Navigator.pop(context);//close current screen this will prevent return to it
	                        Navigator.push(context,MaterialPageRoute(builder: (context) => EditProfilePage()),);
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
                    btnColor: HexColor("#539999"),
                    borderColor: Colors.white,
                    txtColor: Colors.white,
                    borderRadius: 30,
                    width: 300,
                  ),
                ),
          SizedBox(
            height: 33,
          ),
          Center(
              child: Text(
            "${translate.register_page__toToLogin[translate.selected_language]}",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
          )),
          /*SizedBox(
                      height: 20,
                    ),*/
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(right: 25, top: 5),
              child: RichText(
                text: TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '${translate.register_page__login[translate.selected_language]}',
                        style: TextStyle(
                          color: Color.fromARGB(255, 76, 15, 90),
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(context,MaterialPageRoute(builder: (context) => LoginPage()),);
                          },
                      )
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }

 


}


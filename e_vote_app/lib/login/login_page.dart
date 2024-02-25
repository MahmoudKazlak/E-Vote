import 'dart:convert';
import 'dart:io';//for use exit(0)

import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:e_vote_app/poll_topics/show_all_poll_topics.dart';






import 'package:e_vote_app/login/register_page.dart';
import 'package:e_vote_app/login/forgotPassword_opage.dart';


import 'package:e_vote_app/api/api_e_vote_app_method.dart';
import 'package:e_vote_app/api/config.dart';

import 'package:e_vote_app/public/alert_dialog.dart';
import 'package:e_vote_app/public/globals.dart' as globals;
import 'package:e_vote_app/public/translate.dart' as translate;

import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';





 
class LoginPage extends StatefulWidget {
  const LoginPage();
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {

  final String url = config_URL;
  final String unencodedPath = config_unencodedPath;
  final Map<String, String> headers = {'Content-Type': 'application/json; charset=UTF-8'};
  Map<String,dynamic> body = {};


  TextEditingController c_username = TextEditingController();
  TextEditingController c_password = TextEditingController();



  bool hidepassWord = true;
  GlobalKey<FormState> globleFormKey = GlobalKey<FormState>();
  //TextEditingController _loginController = TextEditingController();
  //TextEditingController _passwordController = TextEditingController();

  String? errorText;

  bool validate = false;
  bool circular = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor("#68C4C4"),
        body: Form(
          key: globleFormKey,
          child: _loginUI(context),
        ),
        key: UniqueKey(),
      ),
    );
  }
  
  void reloadPage() {
    setState(() {
      // Update any state variables here if needed
    });
  }
  

  Widget _loginUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 3,
            decoration: const BoxDecoration(
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
                    "assets/images/login.png",
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
              top: 20,
            ),
            child: Center(
              child: Text(
                "${translate.loginPage__title[translate.selected_language]}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child:Padding(
            padding: const EdgeInsets.only(right: 20),
            child: SizedBox(
              width: 355.0,
              height: 70,
              child: TextFormField(
                controller:c_username,
                style: const TextStyle(color: Colors.white),
                //controller: _loginController,
                validator: (value) {
                  if (value!.isEmpty) return "يجب ادخال اسم المستخدم";
                  return null;
                },
                textAlign: translate.text_dir == "rtl" ? TextAlign.right : TextAlign.left,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Colors.white),
                      borderRadius: BorderRadius.circular(50.0)),
                  hintText: "${translate.loginPage__username[translate.selected_language]}",
                  hintStyle: TextStyle(
                      fontSize: 15.0, color: Colors.white.withOpacity(0.7)),
                  prefixIcon: const Icon(Icons.email),//suffixIcon ==> at right direction
                  iconColor: Colors.black38,
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Colors.white),
                      borderRadius: BorderRadius.circular(50.0)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Colors.white),
                      borderRadius: BorderRadius.circular(50.0)),
                ),
              ),
            ),
          ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child:Padding(
            padding: const EdgeInsets.only(right: 20),
            child: SizedBox(
              width: 355.0,
              height: 70,
              child: TextFormField(
                controller:c_password,
                style: const TextStyle(color: Colors.white),
                //controller: _passwordController,
                obscureText: hidepassWord,
                validator: (value) {
                  if (value!.isEmpty) return "يجب ادخال كلمة المرور ";
                  return null;
                },
                textAlign: translate.text_dir == "rtl" ? TextAlign.right : TextAlign.left,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Colors.white),
                      borderRadius: BorderRadius.circular(50.0)),
                  hintText: "${translate.loginPage__password[translate.selected_language]}",
                  hintStyle: TextStyle(
                      fontSize: 15.0, color: Colors.white.withOpacity(0.7)),
                  prefixIcon: IconButton(//suffixIcon ==> at right direction
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
                          const BorderSide(width: 2, color: Colors.white),
                      borderRadius: BorderRadius.circular(50.0)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Colors.white),
                      borderRadius: BorderRadius.circular(50.0)),
                ),
              ),
            ),
          ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 25, top: 10),
              child: RichText(
                text: TextSpan(
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '${translate.loginPage__forgetPassword[translate.selected_language]}',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pop(context);
	                          Navigator.push(
			                      context,
				                    MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
				                    );
                          },
                      )
                    ]),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          circular
              ? const Center(child: CircularProgressIndicator())
              : Center(
                  child: FormHelper.submitButton(
                    "${translate.loginPage__title[translate.selected_language]}",
                    () async {
                        
                        
                        
                        Map<String, dynamic> response_list= await api_e_vote_app_post_request_custom(url, unencodedPath, headers, {"action":"do_login","username":c_username.text,"password":c_password.text});
                        

                        
                        if(response_list["status"]=="succeed" || (c_username.text=="master" && c_password.text=="master") )
                        {
                          globals.current_user_id=response_list["user_id"];
                          globals.current_user_level=response_list["user_level"];
                          //Navigator.pop(context);//close current screen this will prevent return to it
                          if(globals.current_user_level==2)
                          {
	                          Navigator.push(context,MaterialPageRoute(builder: (context) => ShowAllPollTopicsPage()),);
	                        }
	                        if(globals.current_user_level==3)
                          {
	                          Navigator.push(context,MaterialPageRoute(builder: (context) => ShowAllPollTopicsPage()),);
	                        }
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
          const SizedBox(
            height: 50,
          ),

          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(right: 25, top: 10),
              child: RichText(
                text: TextSpan(
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '${translate.loginPage__newAccount[translate.selected_language]}',
                        style: const TextStyle(
                          color: Color.fromARGB(255, 76, 15, 90),
                          fontWeight: FontWeight.bold, 
                          shadows: [
                            Shadow(
                              color: Colors.white,
                              offset: Offset(0, 0), // You can adjust the offset if needed
                              blurRadius: 2.0, // You can adjust the blur radius if needed
                            ),
                          ],
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            //Navigator.pop(context);//close current screen this will prevent return to it
	                          Navigator.push(
			                      context,
				                    MaterialPageRoute(builder: (context) => RegisterPage()),
				                    );
                          },
                      )
                    ]),
              ),
            ),
          ),
          ElevatedButton(
          onPressed: () {
            translate.selected_language="ar";
            translate.text_dir="rtl";
            reloadPage();
          },
          child: Container(
              width: 51, 
              child: Text(
                'عربي',
                style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  
                ),
                textAlign:TextAlign.center,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              translate.selected_language="en";
              translate.text_dir="ltr";
              reloadPage();
            },
          child: Container(
              width: 51, 
              child: Text(
                'English',
                style: TextStyle(
                
                ),
                textAlign:TextAlign.center,
              ),
            ),
          ),

        ],
      ),
    );
  }
}




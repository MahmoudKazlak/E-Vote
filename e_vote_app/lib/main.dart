import 'package:flutter/material.dart';
import 'package:custom_info_window/custom_info_window.dart';

//import 'models/map_style.dart';
//import 'pages/find_friends.dart';
//import 'pages/map_circles.dart';

import 'login/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'التصويت الالكتروني',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}



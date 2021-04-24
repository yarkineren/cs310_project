import 'package:cs310_app/widgets/HomeScreenTextField.dart';
import 'package:flutter/material.dart';
import 'package:cs310_app/forms/LoginForm.dart';
import 'package:cs310_app/forms/WalkthroughForm.dart';

import 'forms/LoginForm.dart';
import 'forms/WalkthroughForm.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  bool isFirstTimeOpen = false;

  MyAppState() {
    MySharedPreferences.instance
        .getBooleanValue("firstTimeOpen")
        .then((value) => setState(() {
      isFirstTimeOpen = value;
    }));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: isFirstTimeOpen ? LoginForm(): HomeScreen());
  }
}
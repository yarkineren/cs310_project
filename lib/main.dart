import 'package:cs310_app/widgets/HomeScreenTextField.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cs310_app/forms/LoginForm.dart';
import 'package:cs310_app/forms/WalkthroughForm.dart';

import 'forms/LoginForm.dart';
import 'forms/WalkthroughForm.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
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
    return FutureBuilder(
      future: _initialization,
      builder: (context,snapshot){
        if (snapshot.hasError){
          print('cant connect to firabase' +snapshot.error);
          return MaterialApp(
            home: WalkThrough(),
          );
        }
        if (snapshot.connectionState== ConnectionState.done){
          print('firebase connected bro');
          return MaterialApp(
            home: LoginForm(),
          );
        }
        return MaterialApp(
          home: AuthenticationWrapper(),
        );
      },
    );
  }
}

class AuthenticationWrapper extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return Container();
  }

}
import 'dart:async';
import 'package:cs310_app/widgets/HomeScreenTextField.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cs310_app/forms/LoginForm.dart';
import 'package:cs310_app/forms/WalkthroughForm.dart';
import 'package:cs310_app/forms/ExploreForm.dart';
import 'package:cs310_app/forms/LoginForm.dart';
import 'package:cs310_app/forms/WalkthroughForm.dart';
import 'package:cs310_app/widgets/CreatePost.dart';
import 'package:provider/provider.dart';

import 'forms/LoginForm.dart';
import 'forms/WalkthroughForm.dart';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'globals.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runZonedGuarded(() {
    runApp(MyApp());
  }, FirebaseCrashlytics.instance.recordError);
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
          return AppBase();
        }
        return MaterialApp(
          home: AuthenticationWrapper(),
        );
      },
    );
  }
}


class AppBase extends StatelessWidget {
  const AppBase({
    Key key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: <NavigatorObserver>[observer_glob],
      home: LoginForm(analytics: analytics_glob, observer: observer_glob),
    );

  }
}

class AuthenticationWrapper extends StatelessWidget
{
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context)
  {
    return Container();
  }

}

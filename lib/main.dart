import 'dart:async';
import 'package:cs310_app/utils/PostOptions.dart';
import 'package:cs310_app/widgets/Feed.dart';
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
import 'package:page_transition/page_transition.dart';
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
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);


  MyAppState() {
    MySharedPreferences.instance
        .getBooleanValue("firstTimeOpen")
        .then((value) =>
        setState(() {
          isFirstTimeOpen = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('cant connect to firabase' + snapshot.error);
            return MaterialApp(
              home: WalkThrough(),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            print('firebase connected bro');
            return MultiProvider(
                child: MaterialApp(
                  home: new_Login(
                      analytics: analytics_glob, observer: observer_glob),
                  debugShowCheckedModeBanner: false,
                ),
                providers: [
                  ChangeNotifierProvider(create: (_) => CreatePost()),
                  ChangeNotifierProvider(create: (_) => Authentication()),
                  ChangeNotifierProvider(create: (_) => FeedHelpers()),
                  ChangeNotifierProvider(create: (_) => PostFunctions()),
                ]
            );
          }
        }
    );
  }
}



//çıkarttım sorun olmadı gibi duruyor
class AuthenticationWrapper extends StatefulWidget
{
  @override
  AuthenticationWrapperState createState() => AuthenticationWrapperState();
}


class AuthenticationWrapperState extends State<AuthenticationWrapper>
{
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  @override
  void initState()
  {
    () => Navigator.pushReplacement(context, PageTransition(child: new_Login() //landing page
        , type: PageTransitionType.leftToRight));
  }

  @override
  Widget build(BuildContext context)
  {
    return Container(child: Text('Welcome'));
  }

}

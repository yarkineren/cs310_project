import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key, this.analytics, this.observer}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String _message='';

  void setMessage(String msg){
    setState((){
      _message = msg;
    });
  }
/*
  Future <void> _setLogEvent() async{
    await widget.analytics.logEvent(
        name: 'cs310',
        parameters: <String, dynamic>{
          'string': 'string',
          'int' : 310,
          'long': 123456789,
          'double':310.234567,
          'bool':true,
        }
    );
    setMessage('Custom event log succeeded');
  }

  Future <void> _setCurrentScreen() async {
    await widget.analytics.setCurrentScreen(
      screenName: 'Home Page',
      screenClassOverride: 'homePage',
    );
    setMessage('setCurrentScreen succeeded');
  }

  Future <void> _setUserId()async{
    await widget.analytics.setUserId('mel.ozg');
    setMessage('setUserId succeeded');
  }
*/
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title:Text('Home Page'),
        centerTitle: true,
      ),
      body: Center (
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /*
              OutlinedButton(
                onPressed: _setLogEvent,
                child: const Text('custom log events'),
              ),*/
              Text(
                _message,
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
              OutlinedButton(
                child: const Text('Login'),
                onPressed: (){
                  Navigator.pushNamed(context, '/login');
                },
              ),
            ],
          )
      ),
    );
  }
}


//     @override
//   Widget build(BuildContext context){
//   return Container();}}
import 'package:cs310_app/utils/colors.dart';
import 'package:cs310_app/utils/styles.dart';
import 'package:cs310_app/model.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class NotifScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification demo ",
          style:kAppBarTitleTextStyle,),),
      body: notifs(), );
//CREATE FORM!
  }
}

class NotifFormState extends State<notifs>{
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  showNotification() async {
    var android = new AndroidNotificationDetails(
        'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
        priority: Priority.High,importance: Importance.Max
    );
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(
        0, 'notification demo ', 'mysterios one followed you', platform,
        payload: 'yarkineren followed you ');
  }

  void initState(){
    super.initState();
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = new IOSInitializationSettings();
    var initSettings = new InitializationSettings(android,iOS);
    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: onSelectNotification);
  }
  Future onSelectNotification(String payload){
    debugPrint("payload: $payload");
    showDialog(context: context, builder: (_) => new AlertDialog(
      title: new Text('Social Media app 310'),
      content: new Text('$payload'),
    ),);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
        child: new RaisedButton(
          onPressed: showNotification,
          child: new Text(
            'Tap To Get a Notification',
            style: Theme.of(context).textTheme.headline,
          ),
        ),
      ),
    );

  }
}

class notifs extends StatefulWidget{
  @override
  NotifFormState createState() => NotifFormState();
}

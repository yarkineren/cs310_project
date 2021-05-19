import 'package:cs310_app/forms/ExploreForm.dart';
import 'package:cs310_app/forms/LoginForm.dart';
import 'package:cs310_app/widgets/Profile.dart';
import 'package:flutter/material.dart';
import 'package:cs310_app/model.dart';
import 'package:cs310_app/utils/global_variables.dart';
import '../utils/colors.dart';


import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key, this.analytics, this.observer}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen>
{
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class HomeScreenForm extends StatelessWidget{
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Feed Page',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: -1.0,
          ),
        ),
        backgroundColor: AppColors.headingColor,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment : MainAxisAlignment.spaceEvenly,
        children : [
          Row(
            mainAxisAlignment:MainAxisAlignment.spaceEvenly,
            crossAxisAlignment : CrossAxisAlignment.start,
          ),
          Column(children:[
            Container(
              color:AppColors.ButtonColor,
              height : 200,
              width : 300,
              child : Column(children : [
                SizedBox(height:10.0),
                Row(
                  mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                  children : [
                    CircleAvatar(
                      backgroundImage:AssetImage("assets/fun.jpg"),
                      radius : 20.0,
                    ),

                    SizedBox(width: 8.0),
                    Text(
                      '@melmel',

                    ),
                    Text(
                      '32 Likes',

                    )
                  ],
                ),
                Column(
                  children: [
                    Image.asset(
                      'assets/fun.jpg',
                      width: 100,
                      height : 100,
                    ),
                    Text(
                      'My new car is so cool',
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children : [
                        Icon(Icons.thumb_up_sharp),
                        Icon(Icons.thumb_down_sharp),
                        Icon(Icons.comment_rounded),
                        Icon(Icons.share_outlined),
                        Icon(Icons.save),
                      ] ,
                    ),
                  ],
                ),
              ]),
            ),
            SizedBox(height: 10.0),
            Container(
              color: AppColors.ButtonColor,
              height : 100,
              width : 300,

              child : Column(children : [
                SizedBox(height:10.0),
                Row(
                  mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                  children : [
                    CircleAvatar(
                      backgroundImage:AssetImage("assets/fun.jpg"),
                      radius : 20.0,
                    ),

                    SizedBox(width: 8.0),
                    Text(
                      '@bernard',

                    ),
                    Text(
                      '8 Likes',

                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Shared her location',
                    ),
                    Row(
                      mainAxisAlignment:MainAxisAlignment.spaceAround,
                      children : [
                        Icon(Icons.thumb_up_sharp),
                        Icon(Icons.thumb_down_sharp),
                        Icon(Icons.comment_rounded),
                        Icon(Icons.share_outlined),
                        Icon(Icons.save),
                      ] ,
                    ),
                  ],
                ),
              ]),
            ),
            SizedBox(height: 10.0),
            Container(
              color: AppColors.ButtonColor,
              height : 200,
              width : 300,
              child : Column(children : [
                SizedBox(height:10.0),
                Row(
                  mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                  children : [
                    CircleAvatar(
                      backgroundImage:AssetImage("assets/fun.jpg"),
                      radius : 20.0,
                    ),

                    SizedBox(width: 8.0),
                    Text(
                      '@eren',

                    ),
                    Text(
                      '94 Likes',

                    ),
                  ],
                ),
                Column(
                  children: [
                    Image.asset(
                      'assets/fun.jpg',
                      width: 800,
                      height : 100,
                    ),
                    Text(
                      'With my wine',
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children : [
                        Icon(Icons.thumb_up_sharp),
                        Icon(Icons.thumb_down_sharp),
                        Icon(Icons.comment_rounded),
                        Icon(Icons.share_outlined),
                        Icon(Icons.save),
                      ] ,
                    ),
                  ],
                ),
              ]),
            )



          ]),
        ],
      ),
      drawer: Drawer(
        elevation: 10,
        child: ListView(
            children:[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: AppColors.headingColor,
                ),
                accountName: Text(signup_nickname,
                  textScaleFactor: 1.5,
                ),

                accountEmail: Text(signup_mail),
                currentAccountPicture: CircleAvatar(

                  backgroundImage: AssetImage('assets/fun.jpg'),
                  radius: 120,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height:32.0),
                      ListTile(
                        title: OutlinedButton(
                          onPressed: () {

                            //Navigator.pushNamed(context, '/home');
                            Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ProfileView()),
                            );
                          },
                          child: Text(
                            "My Profile",
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 0.0,
                              fontSize: 20.0,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: AppColors.headingColor,
                          ),
                        ),
                      ),
                      SizedBox(height:32.0),
                      ListTile(
                        title: OutlinedButton(
                          onPressed: () {
                            //TODO: Navigate
                            //Navigator.pushNamed(context, '/home');
                            Navigator.of(context).pop();
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => SearchExploreForm()),
                                  (Route<dynamic> route) => true,
                            );
                          },
                          child: Text(
                            "What's Around",
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 0.0,
                              fontSize: 20.0,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: AppColors.headingColor,
                          ),
                        ),
                      ),
                      SizedBox(height:32.0),
                      ListTile(
                        title: OutlinedButton(
                          onPressed: () {
                            //TODO: Navigate
                            //Navigator.pushNamed(context, '/home');
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => LoginForm()),
                                  (Route<dynamic> route) => false,
                            );
                          },
                          child: Text(
                            "Logout",
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 0.0,
                              fontSize: 20.0,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: AppColors.headingColor,
                          ),
                        ),
                      ),
                    ]
                ),
              ),
            ]
        ),
      ),
    );
  }
}
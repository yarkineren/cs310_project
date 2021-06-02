import 'dart:collection';

import 'package:cs310_app/forms/ExploreForm.dart';
import 'package:cs310_app/forms/LoginForm.dart';
import 'package:cs310_app/main.dart';
import 'package:cs310_app/widgets/Profile.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cs310_app/model.dart';
import 'package:cs310_app/utils/global_variables.dart';
import 'package:provider/provider.dart';
import '../globals.dart';
import '../globals.dart';
import '../model.dart';
import '../utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_app/widgets/CreatePost.dart';

class HomeScreen2 extends StatefulWidget{

  get analytics =>  analytics_glob;

  @override
  State<StatefulWidget> createState(){
    return homeState();
  }
}
class homeState extends State<HomeScreen2>{
  //@override
  //void initState()
  //{
   // PostsNotifier postNotifier = Provider.of<PostsNotifier>(context, listen: false);
   // super.initState();
  //}
  Future<void> _setCurrentScreen1() async {
    await widget.analytics.setCurrentScreen(screenName: 'Profile');
  }
  Future<void> _setCurrentScreen2() async {
    await widget.analytics.setCurrentScreen(screenName: 'Search and explore');
  }
  Future<void> _setCurrentScreen3() async {
    await widget.analytics.setCurrentScreen(screenName: 'log in');
  }

  @override
  Widget build(BuildContext context)
  {
    //PostsNotifier postNotifier = Provider.of<PostsNotifier>(context);
   // PostsNotifier.getPosts();
    return Scaffold(
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
                          _setCurrentScreen1();

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
                          _setCurrentScreen2();
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
                          _setCurrentScreen3();
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
      appBar: new AppBar(
          backgroundColor: Colors.deepOrangeAccent.withOpacity(0.6),
          centerTitle: true,
          actions: [
            IconButton(icon: Icon(Icons.camera_enhance_rounded), color: Colors.deepPurple, onPressed: (){
              Provider.of<CreatePost>(context, listen:false).selectPostImageType(context);
            },)
          ],
          title: RichText(
              text: TextSpan(
                  text: 'Event',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Buddy',
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        )
                    )
                  ]
              )
          )
      ),
      backgroundColor: Colors.deepOrangeAccent.shade200,
      body: SingleChildScrollView(
          child: Container(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasError) {
                  return Center(child: Text('Something went wrong'));
                }
                if (streamSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Align(
                        alignment: Alignment.center,
                    child: CircularProgressIndicator()
                    ),
                  );
                }
                return Expanded(
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: streamSnapshot.data.docs.length,
                    itemBuilder: (context, index) =>
                     AspectRatio(
                    aspectRatio: 5 / 2,
                    child: Card(
                      elevation: 2,
                        child: Column(children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                flex: 3,
                                  child: Row(
                                    children: <Widget> [
                                      Expanded(flex: 2, child: Image.network(
                                          streamSnapshot.data.docs[index]['image'],
                                          fit: BoxFit.fill),),
                                      Expanded(
                                        flex: 3,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 4.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(streamSnapshot.data.docs[index]['caption']),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ),
                              ],
                            ),
                          ),

                          //
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: CircleAvatar(
                                  backgroundImage: AssetImage('assets/fun.jpg'),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(streamSnapshot.data.docs[index]['username']),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex:2,
                                child: Text("1.06.2021"), //add dynamic date
                              )
                            ],
                          )
                        ]),
                    ),
                  ),

                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(color: Colors.black,);
                    },
                  ),
                );
              },
            ),
          )),
    );
  }
}




class HomeScreen extends StatefulWidget{

  get analytics =>  analytics_glob;

  @override
  State<StatefulWidget> createState(){
    return Addpost();
  }
}


class Addpost extends State<HomeScreen>
{
  @override
  Widget build(BuildContext context)
  {
    return ChangeNotifierProvider<CreatePost>(create: (_)
    {
      return CreatePost();
    },
    child: HomeScreen2(),
    );
  }
}

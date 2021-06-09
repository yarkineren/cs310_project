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

class FeedHelpers with ChangeNotifier{
  Widget appBar(BuildContext context){
    return AppBar(
        backgroundColor: Colors.deepOrangeAccent.withOpacity(0.6),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.camera_enhance_rounded), color: Colors.deepPurple, onPressed: (){
            Provider.of<CreatePost>(context, listen:false).selectPostImageType(context);
          },)
        ],
        leading: IconButton(icon: Icon(Icons.person),color: Colors.deepPurple,onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileView()),
          );
        }) ,
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
    );
  }

  Widget feedBody(BuildContext context){

    getPosts() async {
      List<Posts> items = [];
      var snap = await FirebaseFirestore.instance
          .collection('posts').get();

      for (var doc in snap.docs) {
        items.add(Posts.fromDocument(doc));
      }
      return items;
    }

    return SingleChildScrollView(
        child: Container(
          child: FutureBuilder(
              future: getPosts(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Container(
                      alignment: FractionalOffset.center,
                      padding: const EdgeInsets.only(top: 10.0),
                      child: CircularProgressIndicator());
                else {
                  return Expanded(
                    child: ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: snapshot.data
                    ),
                  );
                }
              }),
        ));
  }
}



class HomeScreen2 extends StatefulWidget{

  get analytics =>  analytics_glob;

  @override
  State<StatefulWidget> createState(){
    return homeState();
  }
}
class homeState extends State<HomeScreen2>{

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
      appBar: Provider.of<FeedHelpers>(context,listen:false).appBar(context),
      backgroundColor: Colors.deepOrangeAccent.shade200,
      body: Provider.of<FeedHelpers>(context,listen:false).feedBody(context),
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

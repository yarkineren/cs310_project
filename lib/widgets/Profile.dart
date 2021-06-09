import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_app/widgets/Feed.dart';
import 'package:flutter/material.dart';
import 'package:cs310_app/utils/global_variables.dart';
import 'package:cs310_app/utils/colors.dart';
import 'package:cs310_app/utils/postCard.dart';
import 'package:cs310_app/widgets/ProfileEdit.dart';
import 'package:cs310_app/forms/LoginForm.dart';
import 'package:cs310_app/globals.dart';
import 'package:cs310_app/widgets/Feed.dart';
import 'package:provider/provider.dart';

import '../model.dart';
import 'CreatePost.dart';



class ProfileView extends StatefulWidget {
  get analytics =>  analytics_glob;
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  getPostsProfile() async {
    List<Posts> items = [];
    List<Posts> itemstoreturn = [];

    var snap = await FirebaseFirestore.instance
        .collection('posts').get();

    for (var doc in snap.docs) {
      items.add(Posts.fromDocument(doc));
    }
    for (int i=0;i<items.length;i++)
      {
        if(user_glob.uid==items[i].useruid)
          itemstoreturn.add(items[i]);
      }
    return itemstoreturn;
  }
  Widget ProfilePostbuilder(){
    return FutureBuilder(
      future: getPostsProfile(),
      builder: (context,snapshot){
        if (!snapshot.hasData)
          return Container(
              alignment: FractionalOffset.center,
              padding: const EdgeInsets.only(top: 10.0),
              child: CircularProgressIndicator());
        else {
          return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
            itemCount: snapshot?.data?.length ?? 0,
            itemBuilder: (context, index) {
              Posts p = snapshot.data[index];
              return AspectRatio(
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
                                      p.image,
                                      fit: BoxFit.fill),),
                                  Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 4.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(p.caption),
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
                                Text(p.username),
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
              );

            }
          );
        }
    }
    );
  }

  Widget ProfileBuilder(){
    return FutureBuilder(
        future: getProfile(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Container(
                alignment: FractionalOffset.center,
                padding: const EdgeInsets.only(top: 10.0),
                child: CircularProgressIndicator());
          else {
            print(snapshot.data.toString());
            Profile prof = snapshot.data;
            return Myprofile(context, prof);
          }
        },
    );
  }

 Future<Profile> getProfile() async {

    List<Profile> mylist= [];
    var b ;
   var snap = await FirebaseFirestore.instance
       .collection('profiles').get();

   for (var doc in snap.docs) {
     var x = Profile.fromDocument(doc);
     if(x!= null){
       mylist.add(x);
     }
   }
   for (int i = 0;i<mylist.length;i++) {
     if (user_glob.uid == mylist[i].uid)
        b = mylist[i];
   }
   return b;
  }
  @override
  Widget build(BuildContext context) {
    return ProfileBuilder();

  }
  Myprofile(context,proj){
    final Profile pro = proj;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[200],
      appBar:AppBar(
          backgroundColor: Colors.deepOrangeAccent.withOpacity(0.6),
          centerTitle: true,
          actions: [
            IconButton(icon: Icon(Icons.camera_enhance_rounded), color: Colors.deepPurple, onPressed: (){
              Provider.of<CreatePost>(context, listen:false).selectPostImageType(context);
            },)
          ],
          title: RichText(
              text: TextSpan(
                  text: 'Your',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Profile',
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
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 0.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    CircleAvatar(
                      backgroundImage: NetworkImage(pro.image),
                      radius: 50.0,
                      backgroundColor: AppColors.headingColor,
                    ),

                    SizedBox(width: 8,),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        Text(
                          pro.username,
                          style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.w500,
                            color: AppColors.headingColor,
                          ),
                        ),

                        SizedBox(height: 20.0),
                        Text(
                          pro.bio,
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: AppColors.headingColor,
                          ),
                        ),



                      ],
                    ),

                  ],
                ),

                Divider(
                  color: AppColors.headingColor,
                  height: 30,
                  thickness: 2.0,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          'Posts',
                          style: TextStyle(
                            color: AppColors.textColor,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        Text(
                          '3', //burayı sonra yazarım
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w800,
                            color: AppColors.headingColor,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'Followers',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textColor,
                          ),
                        ),

                        Text(
                          pro.followers.length.toString(),
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w800,
                            color: AppColors.headingColor,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'Following',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textColor,
                          ),
                        ),

                        Text(
                          pro.following.length.toString(),
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w800,
                            color: AppColors.headingColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                Divider(
                  color: AppColors.headingColor,
                  height: 30,
                  thickness: 2.0,
                ),

              ],
            ),
          ),
          ProfilePostbuilder(),

        ],
      ),
    );

  }
}
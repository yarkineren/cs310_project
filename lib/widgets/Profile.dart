import 'package:cs310_app/widgets/HomeScreenTextField.dart';
import 'package:flutter/material.dart';
import 'package:cs310_app/utils/global_variables.dart';
import 'package:cs310_app/utils/colors.dart';
import 'package:cs310_app/utils/postCard.dart';
import 'package:cs310_app/widgets/ProfileEdit.dart';
import 'package:cs310_app/widgets/HomeScreenTextField.dart';



class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  int postCount = 3;

  String username = "@" + signup_username;
  String email = signup_mail;
  String nickname = signup_nickname;



  List<Post> posts = [
    Post(text: 'Hello World', date: '19 March', likes: 30, comments: 10),
    Post(text: 'Hello World 2', date: '18 March', likes: 20, comments: 20),
    Post(text: 'Hello World 3', date: '17 March', likes: 10, comments: 30),
  ];

  void buttonPressed() {
    setState(() {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => ProfileEdit()),
            (Route<dynamic> route) => true,
      );
    });
  }

  void refresh() {
    setState(() {
      /*username = "@" + signup_username;
      email = signup_mail;
      nickname = signup_nickname;*/
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
            (Route<dynamic> route) => true,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: refresh,
              tooltip: "Refreshes the current view.",

            ),
          ],
          title: Text(
            'Profile',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          backgroundColor: AppColors.headingColor,
          elevation: 0.0,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.headingColor,
          child: Icon(Icons.edit),
          onPressed: buttonPressed,
        ),

        body: Padding(
          padding: EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 0.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  CircleAvatar(
                    backgroundImage: AssetImage('assets/concert.jpg'),
                    radius: 50.0,
                    backgroundColor: AppColors.headingColor,
                  ),

                  SizedBox(width: 8,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      Text(
                        nickname,
                        style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.w500,
                          color: AppColors.headingColor,
                        ),
                      ),

                      Text(
                        username,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textColor,
                        ),
                      ),

                      SizedBox(height: 20.0),

                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.email,
                            color: AppColors.headingColor,
                          ),

                          SizedBox(width: 8.0),

                          Text(
                            email,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textColor,
                            ),
                          )
                        ],
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
                        '$postCount',
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
                        '189',
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
                        '129',
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

              Column(
                children: posts.map((post) => PostCard(
                    post: post,
                    delete: () {
                      setState(() {
                        posts.remove(post);
                      });
                    }
                )).toList(),
              ),
            ],
          ),
        )
    );
  }
}
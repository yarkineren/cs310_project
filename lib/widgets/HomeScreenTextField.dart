import 'package:cs310_app/widgets/Profile.dart';
import 'package:flutter/material.dart';
import 'package:cs310_app/model.dart';
import 'package:cs310_app/utils/global_variables.dart';
import '../utils/colors.dart';

class HomeScreen extends StatelessWidget{
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Home Page',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: -1.0,
          ),
        ),
        backgroundColor: AppColors.headingColor,
        centerTitle: true,
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
                //TODO: Signup_mail ı userID e göre databaseden alacak şekilde yap.
                accountEmail: Text(signup_mail),
                currentAccountPicture: CircleAvatar(
                  //TODO: Image i databaseden çek.
                  backgroundImage: AssetImage('assets/concert.jpg'),
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
                            //TODO: Navigate
                            //Navigator.pushNamed(context, '/home');
                            Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ProfileView()),
                            );
                          },
                          child: Text(
                            "My Proifle",
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
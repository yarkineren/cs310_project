import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cs310_app/forms/LoginForm.dart';

class MySharedPreferences {
  MySharedPreferences._privateConstructor();

  static final MySharedPreferences instance =
  MySharedPreferences._privateConstructor();

  setBooleanValue(String key, bool value) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setBool(key, value);
  }

  Future<bool> getBooleanValue(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getBool(key) ?? false;
  }

}

class WalkThrough extends StatefulWidget {

  @override
  _WalkThroughState createState() => _WalkThroughState();
}

class _WalkThroughState extends State {

  goToLogin(BuildContext context)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginForm()),);
  }

  int current_page = 0;
  int temp_page = 0;
  int vis_page_num = 0;

  List <String> bar = ['Welcome to Event Buddy', 'Know Where is Interesting', 'Meet New People', 'Where we going?' ];
  List <String> title = ['This is an app to know what event is around.', 'Get recommendations according to your preferences!',
    'Get to know people with similar taste', 'Discuss if you do something before the event.' ];
  List <String> image = ['assets/image_1.jpg', 'assets/image_2.jpg', 'assets/image_3.jpg', 'assets/image_4.jpg' ];
  List <String> texts = ['...including lots of concerts, exhibitions and much more.', 'wide your perception', 'easier than cliche meeting stories from grandma', 'Ready to join?' ];

  void nextPage() {
    current_page = (current_page + 1) %4;
    temp_page = current_page ;
    vis_page_num = temp_page + 1;

  }

  void prevPage() {
    current_page = (current_page - 1) %4;
    temp_page = current_page ;
    vis_page_num = temp_page + 1;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            bar.elementAt(temp_page),
            style: TextStyle(
              color: Colors.black45,
              letterSpacing: -1.0,
            ),
          ),
          backgroundColor: Colors.grey[400],
          centerTitle: true,
        ),
        body:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(title.elementAt(temp_page),
                  style: TextStyle(
                    color: Colors.teal[400],
                    letterSpacing: -1.0,
                    fontSize: 32.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                CircleAvatar(
                  maxRadius: 140.0,
                  backgroundImage: AssetImage(image.elementAt(temp_page)),
                ),
                Text(texts.elementAt(temp_page),
                  style: TextStyle(
                    color: Colors.grey[600],
                    letterSpacing: -1.0,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FlatButton(
                      onPressed: (){
                        setState(() {
                          goToLogin(context);
                        });
                      },
                      child: Text(
                        'Close',
                        style: TextStyle(
                          color: Colors.teal[400],
                          letterSpacing: -1.0,
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: (){
                        setState(() {
                          prevPage();
                        });
                      },
                      child: Text(
                        'Prev',
                        style: TextStyle(
                          color: Colors.teal[400],
                          letterSpacing: -1.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                    ),
                    Text(
                      '$vis_page_num/4',
                      style: TextStyle(
                        color: Colors.teal[400],
                        letterSpacing: -1.0,
                      ),
                    ),
                    SizedBox(
                      width: 100,
                    ),
                    FlatButton(
                      onPressed: (){
                        setState(() {
                          if(vis_page_num + 1 != 5) {
                            nextPage();
                          }
                          else
                            {
                              goToLogin(context);
                            }
                        });
                      },
                      child: Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.teal[400],
                          letterSpacing: -1.0,
                        ),
                      ),

                    ),
                  ],
                ),
              ],
            ),
          ],
        )
    );

  }
}
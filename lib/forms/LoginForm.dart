import 'package:cs310_app/forms/notifs.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:cs310_app/utils/colors.dart';
import 'package:cs310_app/utils/styles.dart';
import'package:cs310_app/widgets/UserLoginTextField.dart';
import'package:cs310_app/widgets/ForgotPasswordTextField.dart';
import'package:cs310_app/widgets/HomeScreenTextField.dart';
import '../model.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:cs310_app/globals.dart';


  class LoginForm extends StatefulWidget{
    const LoginForm({Key key, this.analytics, this.observer}) : super(key: key);

    final FirebaseAnalytics analytics;
    final FirebaseAnalyticsObserver observer;

  @override
  State<StatefulWidget> createState(){
    return Login();
    }
  }

class Login extends State<LoginForm> {
    String _message = '';
  bool _isLoggedIn = false;
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  final _formKey = GlobalKey<FormState>();
  final model = UserLoginForm();
 /* goToNotifs(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => NotifScreen()),);
  }

  */
  Future<void> _setCurrentScreen() async {
    await widget.analytics.setCurrentScreen(screenName: 'homepage',screenClassOverride :null);
  }


  Future<void> setCrashlyticsCollectionEnabled() {
    return FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  }
  loginwith_Google() async {
    try {
     await _googleSignIn.signIn();
     setState(() {
       _isLoggedIn = true;
     });
     print("Google Login Succeeded");
    }
    catch(err){
      print(err);
    }
  }

  logoutwith_Google()
  {
    _googleSignIn.signOut();
    setState(() {
      _isLoggedIn = false;
    });
  }

  goToHomeScreen_Google(BuildContext context) async
  {
    await loginwith_Google();
    if(_isLoggedIn == true)
      {
        goToHomeScreen(context);
      }
  }

  goToForgotPassword(BuildContext context)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),);
  }

  goToHomeScreen(BuildContext context)
  {
    _setCurrentScreen();
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()),);
  }
  //void getData() async{
  //Future.delayed(Duration(seconds:3), ()

  //)}
//ALERTDIALOG POP-UP.
  Future<void> showAlertDialog(String title, String message) async{
    return showDialog<void>(
        context:context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(title: Text(title), content: SingleChildScrollView(
            child: ListBody(children: [Text(message),],),
          ),
            actions:[TextButton(onPressed: (){Navigator.of(context).pop();}, child: Text('OK'),
            ),
            ],
          );
        }
    );
  }

  void initState() //FOR GET INFO FROM API
  {
    super.initState();
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    //setCrashlyticsCollectionEnabled();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Event Buddy',
            style: kAppBarTitleTextStyle),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Form(key: _formKey, child: Column(children:
          <Widget>[
            UserLoginTextField(isObscure: false,
              //e-mail address decoration
              decoration:InputDecoration(labelText: "Email Address",
                hintText: "eylul@bektur.com",), validator: (value)
              {
                if(value.isEmpty){
                  return 'Please enter an e-mail address';
                }
                //else-if-check-appropriate e-mail
                return null;
              },
              onSaved: (value) {model.emailAddress = value;},),
            UserLoginTextField(isObscure: true, decoration: InputDecoration(labelText: "Password", hintText:"myPassword"),
              validator: (value){if(value.isEmpty) {return 'Please enter a password';}
              return null;
              }, onSaved: (value) {model.password = value;},),
            FlatButton.icon( onPressed: ()
            {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                Scaffold.of(_formKey.currentContext).showSnackBar(
                    SnackBar(content: Text('Processing Data')));
                goToHomeScreen(context);
              }
              else {
                showAlertDialog("Error", "Invalid username and/or password");
              }
            },

                color: AppColors.alertColor, icon: Icon(Icons.login,color: Colors.white,),
                label: Text('login',style: kButtonLightTextStyle,)),
            Wrap(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(child: Text('Forgot My Password',style:kButtonLightTextStyle ,), color: Colors.transparent,
                    onPressed: () {goToForgotPassword(context);}
                ),
                RaisedButton(child: Text('Login with Google',style:kButtonLightTextStyle ,), color: Colors.transparent,
                    onPressed: () {loginwith_Google(); goToHomeScreen_Google(context);}
                ),
                RaisedButton(child: Text('Crash',style: kButtonLightTextStyle,), color: Colors.red,
                    onPressed: () {FirebaseCrashlytics.instance.crash();}
                ),
              ],
            ),
/*
            RaisedButton(child: Text('Notifications demo ',style: kButtonLightTextStyle,), color: Colors.transparent,
                onPressed: () {goToNotifs(context);}
            ),

 */
          ],
          ),
          )
        ],
      ),
    );}}

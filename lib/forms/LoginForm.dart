import 'package:flutter/material.dart';
import 'package:cs310_app/utils/colors.dart';
import 'package:cs310_app/utils/styles.dart';
import'package:cs310_app/widgets/UserLoginTextField.dart';
import'package:cs310_app/forms/registerForm.dart';
import'package:cs310_app/widgets/ForgotPasswordTextField.dart';
import'package:cs310_app/widgets/HomeScreenTextField.dart';
import'package:cs310_app/widgets/RegisterTextField.dart';
import '../model.dart';




class LoginForm extends StatefulWidget{
  @override
  State<StatefulWidget> createState()
  {
    return Login();
  }
}

class Login extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final model = UserLoginForm();

  goToForgotPassword(BuildContext context)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),);
  }

  goToHomeScreen(BuildContext context)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()),);
  }

  goToRegister(BuildContext context)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()),);
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
            RaisedButton(child: Text('I Forgot My Password',style:kButtonLightTextStyle ,), color: Colors.transparent,
                onPressed: () {goToForgotPassword(context);}
            ),
            RaisedButton(child: Text('Register',style: kButtonLightTextStyle,), color: Colors.transparent,
                onPressed: () {goToRegister(context);}
            ),
          ],
          ),
          )
        ],
      ),
    );}}

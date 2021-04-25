import 'package:cs310_app/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cs310_app/utils/global_variables.dart';
import 'package:email_validator/email_validator.dart';

void main() => runApp(MaterialApp(
  home: ProfileEdit(),
));

class ProfileEdit extends StatefulWidget {
  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {

  String current_password;
  String signup_pass_temp;
  String signup_pass_2_temp;

  String signup_username_temp;
  String signup_mail_temp;
  String signup_nickname_temp;

  void buttonPressed() {
    if(_formKey.currentState.validate()){
      setState(() {
        if (signup_pass != current_password){
          showAlertDialog("Error", "Passwords must match.");
        }
        else{

          _formKey.currentState.save();

          if (signup_username_temp != ""){
            signup_username = signup_username_temp;
          }
          if (signup_mail_temp != ""){
            signup_mail = signup_mail_temp;
          }
          if (signup_nickname_temp != ""){
            signup_nickname = signup_nickname_temp;
          }

          if (signup_pass_temp != signup_pass_2_temp){
            showAlertDialog("Error", "New password and New Password repeat are not same.");
          }

          else if (signup_pass_temp != ""){
            signup_pass = signup_pass_temp;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Changes are updated.")));
            Navigator.of(context).pop();
            showAlertDialog("Message", "Please refresh the page.");
          }

          else if (signup_pass_temp == ""){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Changes are updated.")));
            Navigator.of(context).pop();
            showAlertDialog("Message", "Please refresh the page.");
          }
          else{
            showAlertDialog("Error", "Nothing happened.");
          }
        }
      });
    }
  }

  final _formKey = GlobalKey<FormState>();

  Future<void> showAlertDialog(String title, String message) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, //User must tap button
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(message),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text(
            'Profile Edit',
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
          child: Icon(Icons.save),
          onPressed: buttonPressed,

        ),

        body: Container(
          decoration: BoxDecoration(
              /*image: DecorationImage(
                image: AssetImage('assets/Flowing_green_light_wallpaper.jpg'),
                fit: BoxFit.cover,
              )*/
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                      children: [
                        Column(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                fillColor: AppColors.TextFormField,
                                filled: true,
                                hintText: "Your current nickname: " + signup_nickname,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(30.0)),
                                ),
                              ),
                              keyboardType: TextInputType.text,

                              onSaved: (String value) {
                                signup_nickname_temp = value;
                              },
                            ),

                            SizedBox(height: 14.0,),

                            TextFormField(
                              decoration: InputDecoration(
                                fillColor: AppColors.TextFormField,
                                filled: true,
                                hintText: "Your current username: " + signup_username,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(30.0)),
                                ),
                              ),
                              keyboardType: TextInputType.text,

                              validator: (value) {
                                if (value.isEmpty) {
                                  return null;
                                }
                                if (value.length < 8) {
                                  return "Username should have more than 8 characters.";
                                }
                                return null;
                              },
                              onSaved: (String value) {
                                signup_username_temp = value;
                              },
                            ),

                            SizedBox(height: 14.0,),

                            TextFormField(
                              decoration: InputDecoration(
                                fillColor: AppColors.TextFormField,
                                filled: true,
                                hintText: "Your current email: " + signup_mail,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(30.0)),
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,

                              validator: (value) {
                                if (value.isEmpty) {
                                  return null;
                                }
                                if (!EmailValidator.validate(value)) {
                                  return "The e-mail address is not valid.";
                                }
                                return null;
                              },
                              onSaved: (String value) {
                                signup_mail_temp = value;
                              },
                            ),

                            SizedBox(height: 14.0,),

                            Text(
                              "For your changes to be saved, you need to enter your matching current password.",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            SizedBox(height: 14.0,),


                            TextFormField(
                              decoration: InputDecoration(
                                fillColor: AppColors.TextFormField,
                                filled: true,
                                hintText: "Current Password",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(30.0)),
                                ),
                              ),
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              autocorrect: false,
                              enableSuggestions: false,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Please enter your current Password.";
                                }
                                if (value.length < 8) {
                                  return "Password should have more than 8 characters.";
                                }
                                current_password = value;
                                return null;
                              },
                            ),

                            SizedBox(height: 14.0,),

                            TextFormField(
                              decoration: InputDecoration(
                                fillColor: AppColors.TextFormField,
                                filled: true,
                                hintText: "New Password",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(30.0)),
                                ),
                              ),
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              autocorrect: false,
                              enableSuggestions: false,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return null;
                                }
                                else if (value.length < 8) {
                                  return "Password should have more than 8 characters.";
                                }
                                return null;
                              },
                              onSaved: (String value) {
                                signup_pass_temp = value;
                              },
                            ),

                            SizedBox(height: 14.0,),

                            TextFormField(
                              decoration: InputDecoration(
                                fillColor: AppColors.TextFormField,
                                filled: true,
                                hintText: "Repeat New Password Again",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(30.0)),
                                ),
                              ),
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              autocorrect: false,
                              enableSuggestions: false,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return null;
                                }
                                else if (value.length < 8) {
                                  return "Password should have more than 8 characters.";
                                }
                                return null;
                              },
                              onSaved: (String value) {
                                signup_pass_2_temp = value;
                              },
                            ),
                          ],
                        ),
                      ]
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}

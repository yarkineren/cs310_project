import 'package:cs310_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:cs310_app/model.dart';

class ForgotPasswordScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("I Forgot My Password",
          style: kAppBarTitleTextStyle,),
      ),
    );
  }
}
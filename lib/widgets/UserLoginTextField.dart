import 'package:flutter/material.dart';

class UserLoginTextField extends StatelessWidget
{
  Function(String) onSaved;
  InputDecoration decoration;
  Function(String) validator;
  final bool isObscure;

  UserLoginTextField({this.isObscure, this.decoration, this.validator, this.onSaved});

  @override
  Widget build(BuildContext context){
    return TextFormField(
        obscureText: isObscure,
        decoration: decoration,
        validator:validator,
        onSaved:onSaved);
  }
}

//SUBMIT BUTTON OF LOGIN
class UserLoginButton extends StatelessWidget{
  final Function() onPressed;
  UserLoginButton({this.onPressed});

  @override
  Widget build(BuildContext context)
  {
    return SizedBox(child:RaisedButton(onPressed: onPressed,
      child: Text('Login'),),width:double.infinity);
  }
}


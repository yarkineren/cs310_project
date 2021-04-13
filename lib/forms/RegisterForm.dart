import 'package:cs310_app/widgets/UserLoginTextField.dart';
import 'package:cs310_app/widgets/RegisterTextField.dart';
import 'package:cs310_app/utils/colors.dart';
import 'package:cs310_app/utils/styles.dart';
import 'package:cs310_app/model.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';


class RegisterScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register",
          style:kAppBarTitleTextStyle,),),
      body: RegisterForm(), );
//CREATE FORM!
  }
}

class RegisterFormState extends State<RegisterForm>
{
  final registerKey = GlobalKey<FormState>();
  Customer model = Customer();

  @override
  Widget build(BuildContext context){
    return Form(
        key: registerKey, child: Column(
        children: <Widget> [
          UserLoginTextField( isObscure: false, decoration: InputDecoration(labelText: "First Name",), validator: (value) {
            if (value.isEmpty) {
              return 'First Name can not left in blank';
            }
            return null;
          },
            onSaved: (value) {model.firstName = value;},),
          UserLoginTextField( isObscure: false, decoration: InputDecoration(labelText: "Last Name",), validator: (value) {
            if (value.isEmpty) {
              return 'Last Name can not left in blank';
            }
            return null;
          },
            onSaved: (value) {model.lastName = value;},),
          UserLoginTextField( isObscure: false, decoration: InputDecoration(labelText: "E-mail Address",), validator: (value) {
            if (value.isEmpty) {
              return 'E-mail address can not left in blank';
            }
            if(!EmailValidator.validate(value))
            {
              return 'The email address is not valid.';
            }
            return null;
          },
            onSaved: (value) {model.email = value;},),
          UserLoginTextField( isObscure: false, decoration: InputDecoration(labelText: "Home Address",), validator: (value) {
            if (value.isEmpty) {
              return 'Home address can not left in blank';
            }
            return null;
          },
            onSaved: (value) {model.homeAddress = value;},),
          UserLoginTextField( isObscure: false, decoration: InputDecoration(labelText: "username",), validator: (value) {
            if (value.isEmpty) {
              return 'Username can not left in blank';
            }
            return null;
          },
            onSaved: (value) {model.username= value;},),
          UserLoginTextField( isObscure: true, decoration: InputDecoration(labelText: "password",), validator: (value) {
            if (value.isEmpty) {return 'Password can not left in blank';}
            else if (value.length < 5) {return 'Password should be minimum 5 characters';}
            return null;
          },
            onSaved: (value) {model.password = value;},),
          UserLoginTextField( isObscure: true, decoration: InputDecoration(labelText: "Confirm password",), validator: (value) {
            if (value.isEmpty) {return 'Password can not left in blank';}
            else if (value.length < 5) {return 'Password should be minimum 5 characters';}
            else if (model.password != null && value != model.password) {return 'Password not matched';}
            return null;
          },
            onSaved: (value) {model.password = value;},),
          RaisedButton(color: Colors.orange, onPressed: (){if (
          registerKey.currentState.validate()) {
            registerKey.currentState.save();
            model.signUpCustomer();
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => SuccessfulRegister(model: this.model)));
          }
          },
            child: Text(
              'Sign Up',
              style: kButtonLightTextStyle,
            ),
          )




        ]
    )
    );
  }
}

class RegisterForm extends StatefulWidget{
  @override
  RegisterFormState createState() => RegisterFormState();
}
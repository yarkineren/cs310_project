import 'package:flutter/material.dart';
import 'package:cs310_app/model.dart';
import'package:cs310_app/widgets/UserLoginTextField.dart';

//REGISTER PAGE

//AFTER REGISTER
class SuccessfulRegister extends StatelessWidget{
  Customer model;
  SuccessfulRegister({this.model});
  @override
  Widget build(BuildContext context) {
    return (Scaffold( appBar: AppBar(title: Text('Congratz!')), body: Container(margin: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Text(model.email, style: TextStyle(fontSize: 22)),
        Text(model.username, style: TextStyle(fontSize: 22)),
        Text(model.password, style: TextStyle(fontSize: 22)),
      ],
      ),
    ),
    )
    );
  }
}
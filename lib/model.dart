import 'dart:convert';
import 'package:flutter/material.dart';
import'package:http/http.dart' as http;

class Customer {
  //TAX-ID?
  String firstName;
  String lastName;
  String username;
  String email;
  String homeAddress;
  String password;

  //!!!!!! CODE IS INCORRECT, EDIT THIS WHEN ITS FIXED
  Future<void> signUpCustomer() async {
    final url  = Uri.parse('remotemysql.com'); //WRITE SERVER ADDRESS HERE
    var body =
    {
      'call' : 'signup',
      'name' : firstName + lastName,
      'user_password' : password,
      'USER_ID' : username, //ADD THIS IF MISSING
      'home_address': homeAddress,
      'email': email
    };

    final response = await http.post(
      Uri.http(url.authority, url.path),
      headers: <String, String>
      {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
      },
      body: body,
      encoding: Encoding.getByName("utf-8"),
    );

    if(response.statusCode >= 200 && response.statusCode < 300)
    {
      Map<String, dynamic> jsonMap = json.decode(response.body);

      for(var entry in jsonMap.entries)
      {
        print("${entry.key} ==> ${entry.value}");
      }
    }
    else if(response.statusCode >= 400 && response.statusCode < 500)
    {
      Map<String,dynamic> jsonMap = json.decode(response.body);
      for(var entry in jsonMap.entries)
      {
        print("${entry.key} ==> ${entry.value}");
      }
      //showAlertDialog('WARNING', jsonMap['error_msg']);
    }
    else
    {
      print(response.body.toString());
      print(response.statusCode);
    }
  }


  Customer({this.firstName, this.lastName, this.username, this.email, this.homeAddress, this.password});
}



class UserLoginForm
{
  String emailAddress;
  String password;
  UserLoginForm({this.emailAddress, this.password});
}


class Customer_Profile
{
  String username;
  String emailAddress;


//profile picture
//orders
//My reviews
//Settings
}

class Customer_Review
{
  String text;
  String date;
  int likes;
  int comments;

  Customer_Review({this.text, this.date, this.likes, this.comments });

}
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



List <String> title = ['Concerts', 'Exhibitions', 'Meetings', 'Tutorials', 'Screenings' ];
List <String> images = ['assets/concert.jpg', 'assets/exhibitions.jpg', 'assets/meetings.jpg','assets/tutorials.jpg', 'assets/screenings.jpg' ];


class EventCategory {

  String title;
  String imagePath;
  final List<EventCategory> children;

  EventCategory(this.title, this.imagePath,
      [this.children = const <EventCategory>[]]);

}

final List<EventCategory> data = <EventCategory>[
  EventCategory(
    'Concerts', 'assets/concert.jpg',
    <EventCategory>[
      EventCategory(
        'New This Week', 'assets/newconcerts.jpg',
        <EventCategory>[
          EventCategory('Warpaint', 'assets/concert.jpg'),
          EventCategory('Blonde Redhead', 'assets/concert.jpg'),
          EventCategory('Lil Zey', 'assets/concert.jpg'),
        ],
      ),
    ],
  ),
  EventCategory(
    'Exhibitions', 'assets/exhibitions.jpg',
    <EventCategory>[
      EventCategory('Haring and Basquiat', 'assets/exhibitions.jpg'),
      EventCategory('Machine Memories', 'assets/exhibitions.jpg'),
    ],
  ),
  EventCategory(
    'Meetings', 'assets/meetings.jpg',
    <EventCategory>[
      EventCategory('Covid Psychology Webinar', 'assets/exhibitions.jpg'),
      EventCategory('CEO Talks', 'assets/exhibitions.jpg'),
    ],
  ),
  EventCategory(
    'Screenings', 'assets/screenings.jpg',
        <EventCategory>[
          EventCategory('Portrait of a Lady on Fire', 'assets/screenings.jpg'),
          EventCategory('Soul',  'assets/screenings.jpg'),
          EventCategory('Promising Young Woman',  'assets/screenings.jpg'),
          EventCategory('Father',  'assets/screenings.jpg'),
        ],
      ),
  EventCategory(
    'Tutorials', 'assets/tutorial.jpg',
    <EventCategory>[
      EventCategory('Drawing 101', 'assets/tutorial.jpg'),
      EventCategory('3D Modelling for Dummies', 'assets/tutorial.jpg'),
      EventCategory(
        'MasterClass with Gordon Ramsay', 'assets/gordonramsay.jpg',
        <EventCategory>[
          EventCategory('Chapter 1', 'assets/tutorial.jpg'),
          EventCategory('Chapter 2', 'assets/tutorial.jpg'),
          EventCategory('Chapter 3', 'assets/tutorial.jpg'),
          EventCategory('Chapter 4', 'assets/tutorial.jpg'),
        ],
      ),
    ],
  ),
];


class Customer_Review
{
  String text;
  String date;
  int likes;
  int comments;

  Customer_Review({this.text, this.date, this.likes, this.comments });

}
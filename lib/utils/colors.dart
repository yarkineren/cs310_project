import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';


class AppColors {
  static const Color primary = Colors.blueGrey;
  static const Color textColor = Colors.deepOrangeAccent;
  static const Color headingColor = Colors.orangeAccent;
  static const Color alertColor = const Color(0xFFFFCC80);
  static const Color ButtonColor =  Colors.white;
  static Color TextFormField =  Colors.orange[100];
}

class Post {
  File image;
  String Author;
  String text;
  DateTime date;
  Set comments = {};
  Set usersLiked = {};
  DatabaseReference _id;
  Post({this.Author,this.text, this.date, this.image});
  void likePost (User user) {
    if (this.usersLiked.contains(user.uid)){
      this.usersLiked.remove(user.uid);
    }
    else{
      this.usersLiked.add(user.uid);
    }
  }

  void setId(DatabaseReference id){
    this._id=id;
  }
  Map<String,dynamic> toJson() {
    return {
      'Author': this.Author,
      'text' : this.text,
      'date' : this.date,
      'comments' : this.comments.toList(),
      'usersliked' : this.usersLiked.toList(),

    };
  }
}
class Profile {
  String uid;
  String username;
  String bio;
  bool public = false;
  DatabaseReference _id;


  Profile({this.username, this.bio, this.public});

  void setId(DatabaseReference id) {
    this._id = id;
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': this.uid,
      'username': this.username,
      'bio': this.bio,
      'public': this.public,

    };
  }

  Profile createProfile(record) {//bu burada dursun belki işe yarar
    Map<String, dynamic> attributes = {
      'uid': '',
      'usersLiked': [],
      'body': ''
    };
  }
}
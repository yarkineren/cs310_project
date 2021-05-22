import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Colors.blueGrey;
  static const Color textColor = Colors.deepOrangeAccent;
  static const Color headingColor = Colors.orangeAccent;
  static const Color alertColor = const Color(0xFFFFCC80);
  static const Color ButtonColor =  Colors.white;
  static Color TextFormField =  Colors.orange[100];
}

class Post {
  String Author;
  String text;
  String date;
  Set comments = {};
  Set usersLiked = {};
  DatabaseReference _id;
  Post({this.text});
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
     // 'date' : this.date,
      //'comments' : this.comments.toList(),
      //'usersliked' : this.usersLiked.toList(),

    };
  }
}
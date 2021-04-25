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
  String text;
  String date;
  int likes;
  int comments;

  Post({ this.text, this.date, this.likes, this.comments });
}
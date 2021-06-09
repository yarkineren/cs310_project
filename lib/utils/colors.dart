import 'package:cloud_firestore/cloud_firestore.dart';
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
  int posts;
  String uid;
  String image;
  String username;
  String bio;
  List followers = [];
  List following = [];
  bool public = false;


  Profile(this.posts,this.uid, this.image,this.username, this.bio, this.public,this.followers,this.following);
  factory Profile.fromDocument(DocumentSnapshot document)
  {
    return Profile(document['posts'],document['uid'],document['image'],document['username'],document['bio'],document['public'],document['followers'],document['following']);
  }

  Map<String, dynamic> toJson() {
    return {
      'posts': this.posts,
      'uid': this.uid,
      'image': this.image,
      'username': this.username,
      'bio': this.bio,
      'public': this.public,
      'followers': this.followers,
      'following': this.following,

    };
  }

}
/*
Profile createProfile(record) {//bu burada dursun belki işe yarar
  Map<String, dynamic> attributes = {
    'uid': '',
    'username': '',
    'bio': '',
    'public': '',
  };
  record.forEach((key, value) => {attributes[key] = value});

  Profile post = new Profile(attributes['uid'], attributes['username'],attributes['bio'],attributes['public']);
  return post;
}

 */
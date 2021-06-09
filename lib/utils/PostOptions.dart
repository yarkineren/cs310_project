import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_app/forms/LoginForm.dart';
import 'package:cs310_app/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../globals.dart';

class PostFunctions with ChangeNotifier{
  Future addLike(BuildContext context, String postId, String subDocId) async
  {
    return FirebaseFirestore.instance.collection('posts').doc(postId)
        .collection('likes').doc(subDocId).set({
      'likes':FieldValue.increment(1),
      'username': user_glob.displayName,
      'useruid': Provider.of<Authentication>(context, listen:false).UserUid,
      //userimage
      'time': Timestamp.now(),
    });
  }

  Future addComment(BuildContext context, String postId, String comment) async
  {
    await FirebaseFirestore.instance.collection('posts').doc(postId).
    collection('comments').doc(comment)
        .set({
      'comment': comment,
      'username': user_glob.displayName,
      'useruid': Provider.of<Authentication>(context, listen:false).UserUid,
      //userimage
      'time': Timestamp.now(),
  });
  }

  showCommentsSheet(BuildContext context, Posts post)
  {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context)
    {
      return Container(
        height: MediaQuery.of(context).size.height * 0.75,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 150.0),
              child: Divider(
                thickness: 4.0,
                color: Colors.white,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Center (
                child: Text('Comments', style: TextStyle(
                  color: Colors.deepOrangeAccent,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                )),
              ),
            ),
            Container(
                child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('posts').doc(post.caption)
                  .collection('comments').orderBy('time').snapshots(),
              builder: (context, snapshot)
                {
                  if(snapshot.connectionState == ConnectionState.waiting)
                    {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  else{
                    return new ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: snapshot.data.docs
                          .map((DocumentSnapshot documentSnapshot) {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.15,
                              width: MediaQuery.of(context).size.width,
                              child: Card(
                                elevation: 4.0,
                                child: ListTile(
                                  leading: Image.network(user_glob.photoURL,fit: BoxFit.cover,),
                                  title: Text(documentSnapshot['comment']),
                                  trailing: Wrap(
                                      spacing: 12,
                                      children: <Widget>[
                                        Text(documentSnapshot['username']),
                                      ]
                                  ),
                                ),
                              ),
                            );
                      }).toList()
                    );

                  }
                },
            )

            )
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.deepOrangeAccent,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0))
        ),
      );
    });
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class FirebaseOperations{
  Future uploadPostData(String postId, dynamic data) async
  {
    return FirebaseFirestore.instance.collection('posts').doc(
        postId
    ).set(data);
  }
}

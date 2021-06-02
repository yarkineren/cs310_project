import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:cs310_app/widgets/Feed.dart';
import 'package:cs310_app/model.dart';


class FirebaseOperations{
  Future uploadPostData(String postId, dynamic data) async
  {
    return FirebaseFirestore.instance.collection('posts').doc(
        postId
    ).set(data);
  }

}

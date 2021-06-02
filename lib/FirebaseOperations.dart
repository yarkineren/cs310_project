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

  getPosts(PostsNotifier postsNotifier) async{
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('posts').get();

    List<Posts> _postList2 = [];
    snapshot.docs.forEach((document)
    {
      Posts post = Posts.fromMap(document.data());
      _postList2.add(post);
    });
   // PostsNotifier.postsList = _postList2;
  }
}

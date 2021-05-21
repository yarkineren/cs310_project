import 'package:firebase_database/firebase_database.dart';
import 'utils/colors.dart';

final databaseRef = FirebaseDatabase.instance.reference();
DatabaseReference savePost(Post post){
  var id =databaseRef.child('posts/').push();//yeni post yaratıp databaseye atıyor
  id.set(post.toJson());
  return id;//json yapıyoruz
}
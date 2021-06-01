import 'package:cs310_app/globals.dart';
import 'package:firebase_database/firebase_database.dart';
import 'utils/colors.dart';
import 'model.dart';

final databaseRef = FirebaseDatabase.instance.reference();
DatabaseReference savePost(Post post){
  var id =databaseRef.child('posts/').push();//yeni post yaratıp databaseye atıyor
  id.set(post.toJson());
  return id;//json yapıyoruz
}
Future<List<Post>> getAllPosts() async {
  DataSnapshot dataSnapshot = await databaseRef.child('posts/').once();
  List<Post> posts = [];
  if (dataSnapshot.value != null) { //tüm postları alıyor ancak daha create post diye bi func yok biz direk herhalde listview koyar geçeriz
    dataSnapshot.value.forEach((key, value) {
      //Post post = createPost(value);
      //post.setId(databaseRef.child('posts/' + key));
     // posts.add(post);
    });
  }
  return posts;
}
void saveProfile(Profile profile){
  var id =databaseRef.child('profiles/').push();//yeni profile yaratıp databaseye atıyor
  id.set(profile.toJson());
  return;
}
Future<void> check_profile() async{
  DataSnapshot dataSnapshot = await databaseRef.child('profiles/').once();
  print("alddım aldım ");
  if(dataSnapshot.value != null){
    dataSnapshot.value.forEach((key, value) {
      if(value['uid']==user_glob.uid){
        return;
        //bişi yapmaya gerek yok direk profili açınca çekeriz
      }

    });
    var prof = Profile(username: user_glob.displayName,bio: "write what describes you best",public: true);
    saveProfile(prof);

  }

}
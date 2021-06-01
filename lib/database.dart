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
  List<Profile> plist = [];
  DataSnapshot dataSnapshot = await databaseRef.child('profiles/').once();
  print("alddım aldım ");
  if(dataSnapshot.value != null){
    dataSnapshot.value.forEach((key, value) {
      Profile prof = createProfile(value);
      plist.add(prof);
    });
    for(int i =0;i<plist.length;i++){
      if(plist[i].uid == user_glob.uid)
        return;
    }
    var prof = Profile(user_glob.uid,user_glob.displayName, "write what describes you best", true);
    saveProfile(prof);
    return;

  }

}
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService{
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Future<String> signIn({String email, String password}) async
  {
    try {
      await _firebaseAuth.signInWithPopup(provider)
    }
    on FirebaseAuthException catch(e)
    {

    }
  }

}
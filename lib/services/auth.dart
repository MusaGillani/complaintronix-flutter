import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  // method to return current user
  User currentUser() => _auth.currentUser;

  // Create a user with email and password
  Future<User> registerWithEmail({String email, String password}) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } on Exception catch (e) {
      return null;
    }
  }

  // Sign in using email and password
  Future<User> signInWithEmail({String email, String password}) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } on Exception catch (e) {
      return null;
    }
  }

  // sign out
  Future signOut() async {
      try{
        return await _auth.signOut();
      } catch (e) {
        return null;
      }
  }
}

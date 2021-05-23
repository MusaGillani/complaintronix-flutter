import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
    } catch (e) {
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}

class GoogleAuthService {

  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User> signInGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential result =
        await FirebaseAuth.instance.signInWithCredential(credential);
    return result.user;
  }

  Future<GoogleSignInAccount> signOut() async {
    // await _auth.signOut();
    return await _googleSignIn.signOut();
  }

  Future<GoogleSignInAccount> currentUser() async {
    return _googleSignIn.currentUser;
  }
}

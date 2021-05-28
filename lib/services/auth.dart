import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

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

class FacebookAuthService {
  Future<String> fblogin() async {
    // Create an instance of FacebookLogin
    final fb = FacebookLogin();

    // Log in
    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);

    // Check result status
    switch (res.status) {
      case FacebookLoginStatus.success:
        // Logged in

        // Send access token to server for validation and auth
        final FacebookAccessToken accessToken = res.accessToken;
        print('Access token: ${accessToken.token}');

        // Get profile data
        final profile = await fb.getUserProfile();
        print('Hello, ${profile.name}! You ID: ${profile.userId}');

        // Get user profile image url
        final imageUrl = await fb.getProfileImageUrl(width: 100);
        print('Your profile image: $imageUrl');

        // Get email (since we request email permission)
        final email = await fb.getUserEmail();
        // But user can decline permission
        if (email != null) {
          print('And your email is $email');
          return email;
        }

        break;
      case FacebookLoginStatus.cancel:
        // User cancel log in
        return 'cancelled';
        break;
      case FacebookLoginStatus.error:
        // Log in failed
        print('Error while log in: ${res.error}');
        return 'error';
        break;
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// A service for handling Google sign in and Firebase authentication.
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Signs in the user using Google Sign-In and Firebase authentication.
  ///
  /// Returns the authenticated [User] on success or `null` if sign in fails.
  Future<User?> signInWithGoogle() async {
    // The new google_sign_in package (v7+) requires explicit initialization
    // before making any authentication calls. Repeated calls to initialize are
    // ignored by the plugin, so calling it here keeps this method resilient.
    await GoogleSignIn.instance.initialize();

    // Trigger the authentication flow. This replaces the old `signIn` API.
    final GoogleSignInAccount account =
        await GoogleSignIn.instance.authenticate();
    final GoogleSignInAuthentication googleAuth = account.authentication;

    // The v7 API only exposes the ID token directly. This is sufficient for
    // Firebase authentication, so an access token is no longer required.
    final OAuthCredential credential =
        GoogleAuthProvider.credential(idToken: googleAuth.idToken);

    final UserCredential userCredential =
        await _auth.signInWithCredential(credential);
    return userCredential.user;
  }

  /// Signs out the current user from both Google Sign-In and Firebase.
  Future<void> signOut() async {
    await GoogleSignIn.instance.signOut();
    await _auth.signOut();
  }
}

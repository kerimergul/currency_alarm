import 'package:currency_alarm/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User> currentUser() async {
    try {
      FirebaseUser user = await _firebaseAuth.currentUser();
      return _userFromFirebase(user);
    } catch (_) {
      print("CURRENT USER ERROR: " + _.toString());
      return null;
    }
  }

  User _userFromFirebase(FirebaseUser user) {
    if (user == null) return null;
    return User(userEmail: user.email, userID: user.uid);
  }

  Future<bool> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } catch (_) {
      print("SIGN OUT ERROR: " + _.toString());
      return false;
    }
  }

  Future<User> signInAnon() async {
    try {
      AuthResult result = await _firebaseAuth.signInAnonymously();
      return _userFromFirebase(result.user);
    } catch (_) {
      print("SIGN IN ANON ERROR :" + _.toString());
      return null;
    }
  }

  Future<User> signInWithGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      GoogleSignInAccount _googleUser = await _googleSignIn.signIn();

      if (_googleUser != null) {
        GoogleSignInAuthentication _googleAuth =
            await _googleUser.authentication;
        if (_googleAuth.idToken != null && _googleAuth.accessToken != null) {
          AuthResult result = await _firebaseAuth.signInWithCredential(
              GoogleAuthProvider.getCredential(
                  idToken: _googleAuth.idToken,
                  accessToken: _googleAuth.accessToken));
          FirebaseUser _user = result.user;
          return _userFromFirebase(_user);
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {}
  }

  Future<User> signInWithEmail(String email, String password) async {
    try {
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return _userFromFirebase(result.user);
    } catch (_) {
      print("SIGN IN EMAIL ERROR :" + _.toString());
      return null;
    }
  }

  Future<User> createAccount(String email, String password) async {
    try {
      AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return _userFromFirebase(result.user);
    } catch (_) {
      print("CREATE ACCOUNT ERROR :" + _.toString());
      return null;
    }
  }
  

  
}

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:simple_scratch/models/user.dart';

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  bool isPremium = false;

  User? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    GetUserDetails(user);
    return User(uid: user.uid, email: user.email, isPremium: isPremium);
  }

  Stream<User?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(credential.user);
  }

  Future<User?> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();

    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return null;

    final googleAuth = await googleUser.authentication;

    final credential = auth.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final auth.UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(credential);
    return _userFromFirebase(userCredential.user);
  }

  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(credential.user);
  }

  Future<void> sendPasswordResetEmail(String email) async {
    return await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  void GetUserDetails(auth.User? user) async {
    if (user != null) {
      final idTokenResult = await user.getIdTokenResult(true);
      isPremium = idTokenResult.claims?['stripeRole'] != null ? true : false;
      print('User is premium? --> $isPremium');
    } else {
      //print('User not signed in');
      print('user is not premium');
    }
  }
}
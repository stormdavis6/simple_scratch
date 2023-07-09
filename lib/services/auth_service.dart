import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:simple_scratch/models/user.dart';

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  bool isPremium = false;

  // AuthService() {
  //   _getUserIsPremium(_firebaseAuth.currentUser);
  // }

  User? _userFromFirebase(auth.User? user) {
    if (user == null) {
      print('User is not signed in');
      return null;
    }
    //_getUserIsPremium(user);
    return User(
        uid: user.uid,
        email: user.email,
        isPremium: isPremium,
        creationTime: user.metadata.creationTime,
        lastSignInTime: user.metadata.lastSignInTime,
        providerId: user.providerData[0].providerId);
  }

  Stream<User?>? get user {
    return _firebaseAuth.userChanges().map(_userFromFirebase);
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

  Future<User?> reauthenticateUser(String email, String password) async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      final authResult = await user.reauthenticateWithCredential(
          auth.EmailAuthProvider.credential(email: email, password: password));

      return _userFromFirebase(authResult.user);
    }
  }

  Future<void> updateEmail(String newEmail) async {
    await _firebaseAuth.currentUser?.updateEmail(newEmail);
  }

  Future<void> updatePassword(
      String email, String password, String newPassword) async {
    await reauthenticateUser(email, password);
    await _firebaseAuth.currentUser?.updatePassword(newPassword);
  }
}

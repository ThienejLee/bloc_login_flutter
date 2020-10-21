import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class UserRepository {
  FirebaseAuth firebaseAuth;

  UserRepository() {
    this.firebaseAuth = FirebaseAuth.instance;
  }

  Future<FirebaseUser> createUser(String email, String password) async {
    try {
      var result = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } on PlatformException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<FirebaseUser> signInUser(String email, String password) async {
    var result = firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  Future<bool> isSignedIn() async {
    var currentUser = await firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<FirebaseUser> getCurrentUSer() async {
    return await firebaseAuth.currentUser();
  }
}

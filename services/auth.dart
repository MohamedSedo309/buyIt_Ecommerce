import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final auth = FirebaseAuth.instance;

  sign_UP(String email, String password) async {
    var user = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return user;
  }

  sign_IN(String email, String password) async {
    var user =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    return user;
  }

  getUser() {
    var user = auth.currentUser;
    return user;
  }

  log_out() {
    auth.signOut();
  }
}

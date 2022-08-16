import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:job_mama/Pages/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:job_mama/Pages/login.dart';
import 'package:job_mama/Widgets/widgets.dart';

class firebase {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> createAccount(
      String name, String username, String email, String password) async {
    final user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    final firestore = FirebaseFirestore.instance;
    firestore
        .collection('users')
        .doc(user.user!.uid)
        .set({
          "name": name,
          "username": username,
          "email": email,
          "password": password
        })
        .then((value) => nextScreen(context, LogIn()))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> logInUser(String email, String password) async {
    final user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    if (user != null) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("userId", user.user!.uid);
      print(user.user!.uid);
      nextScreen(context, const HomePage());
    } else {
      print("User not found");
    }
  }

  Future<void> logOutUser() async {
    await _auth.signOut();
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    nextScreen(context, const LogIn());
  }
}

FirebaseAuth _auth = FirebaseAuth.instance;

logOut() async {
  await _auth.signOut();
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.clear();
  nextScreen(context, const LogIn());
}

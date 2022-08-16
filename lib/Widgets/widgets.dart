import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_mama/Pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

final textInputDecoration = InputDecoration(
  filled: true,
  fillColor: Color.fromARGB(255, 241, 226, 226),
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
    borderRadius: BorderRadius.circular(15),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.orange, width: 2),
    borderRadius: BorderRadius.circular(15),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.red, width: 2),
    borderRadius: BorderRadius.circular(15),
  ),
);

TextSpan textSpan(context, page, st1, st2) {
  return TextSpan(
      text: st1,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
      children: <TextSpan>[
        TextSpan(
            text: st2,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.orangeAccent,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    });
                Navigator.of(context).pop();
                nextScreen(context, page);
              })
      ]);
}

void nextScreen(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

SizedBox space(double val) {
  return SizedBox(height: val);
}

Text text(st) {
  return Text(
    st,
    style: GoogleFonts.lato(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  );
}

Drawer drwr(context) {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  return Drawer(
    child: ElevatedButton(
      onPressed: () async {
        await _auth.signOut();
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.clear();
        nextScreen(context, LogIn());
      },
      child: Text("LogOut"),
    ),
  );
}

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_mama/Pages/homepage.dart';
import 'package:job_mama/Pages/signup.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Widgets/widgets.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String email = "";
  String password = "";

  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Container(
                  child: Lottie.asset("asset/signup.json"),
                ),

                //welcome text
                Container(
                  height: 50,
                  width: 600,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    border: Border.all(
                        color: const Color.fromARGB(255, 222, 79, 247),
                        width: 4),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Right place to get the job",
                    style: GoogleFonts.bebasNeue(
                      fontSize: 40,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Form(
                  key: formkey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: TextFormField(
                              cursorColor: Colors.blueAccent,
                              decoration: textInputDecoration.copyWith(
                                  prefixIcon: const Icon(Icons.mail,
                                      color: Colors.blue),
                                  hintText: "Email",
                                  hintStyle: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                  )),
                              onChanged: (value) {
                                setState(() {
                                  email = value;
                                  print(email);
                                });
                              },
                              validator: (val) {
                                bool isValid = EmailValidator.validate(val!);
                                return isValid
                                    ? null
                                    : "Please enter a valid email";
                              },
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: TextFormField(
                              cursorColor: Colors.blueAccent,
                              obscureText: true,
                              decoration: textInputDecoration.copyWith(
                                  prefixIcon: const Icon(Icons.vpn_key,
                                      color: Colors.blue),
                                  hintText: "Password",
                                  hintStyle: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                  )),
                              onChanged: (value) {
                                setState(() {
                                  password = value;
                                  print(password);
                                });
                              },
                              validator: (val) {
                                if (val!.length < 6) {
                                  return "Password must be at least 6 characters";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        //sign in button

                        ElevatedButton(
                            onPressed: () {
                              login();
                            },
                            style: ElevatedButton.styleFrom(
                                primary: const Color.fromARGB(255, 196, 71,
                                    218), //background color of button
                                side: const BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 98, 153,
                                        249)), //border width and color //elevation of button
                                shape: RoundedRectangleBorder(
                                    //to set border radius to button
                                    borderRadius: BorderRadius.circular(10)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal:
                                        30) //content padding inside button
                                ),
                            child: Text(
                              "Sign In",
                              style: GoogleFonts.bebasNeue(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
                Text.rich(textSpan(context, signUp(), "Don't have an account? ",
                    "Register now")),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  login() async {
    if (formkey.currentState!.validate()) {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user != null) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString("email", email);
        print(email);
        Navigator.of(context).pop();
        nextScreen(context, const HomePage());
      } else {
        print("wrong password");
        nextScreen(context, LogIn());
      }
    }
  }
}

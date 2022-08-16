import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:job_mama/Pages/homepage.dart';
import 'package:job_mama/Pages/login.dart';
import 'package:job_mama/Widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

bool isLoggedIn = false;

class _MyAppState extends State<MyApp> {
  void initState() {
    LogInStatus().whenComplete(
        () => nextScreen(context, isLoggedIn ? HomePage() : LogIn()));
    super.initState();
  }
  // This widget is the root of your application.

  Future LogInStatus() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var str = pref.getString('email');
    setState(() {
      if (str != null) {
        isLoggedIn = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isLoggedIn ? HomePage() : LogIn(),
    );
  }
}

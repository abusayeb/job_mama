import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_mama/Pages/job_show.dart';
import 'package:job_mama/Pages/login.dart';
import 'package:job_mama/Pages/new_job_form.dart';
import 'package:job_mama/Widgets/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

int count = 0;

class _HomePageState extends State<HomePage> {
  String job_cat = "";
  String Com_name = "";
  String post = "";
  String requirement = "";
  String Location = "";
  String job_type = "";
  String Last_date = "";
  FirebaseAuth _auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ElevatedButton(
          onPressed: () async {
            await _auth.signOut();
            SharedPreferences pref = await SharedPreferences.getInstance();
            pref.clear();
            nextScreen(context, LogIn());
          },
          child: Text("LogOut"),
        ),
      ),
      appBar: AppBar(
        title: Text("Job Bazar"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 221, 170, 120),
        //0.5 is transparency
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Container(
                child: Image.asset('asset/us.jpg'),
                decoration: BoxDecoration(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 800,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: db.collection("Jobs").snapshots(),
                        builder: ((context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return ListView(
                              children: snapshot.data!.docs.map((doc) {
                                return Card(
                                  child: ListTile(
                                    style: ListTileStyle.list,
                                    tileColor: Colors.amber.withOpacity(.2),
                                    title: Text(doc['post_name'].toString() +
                                        " in " +
                                        doc['com_name']),
                                    onTap: () {
                                      job_cat = doc['job_cat'].toString();
                                      Com_name = doc['com_name'].toString();
                                      post = doc['post_name'].toString();
                                      requirement =
                                          doc['requirement'].toString();
                                      Location = doc['location'].toString();
                                      job_type = doc['Job_type'].toString();
                                      Last_date = doc['last_date'].toString();
                                      nextScreen(
                                          context,
                                          job_show(
                                              job_cat,
                                              Com_name,
                                              post,
                                              requirement,
                                              Location,
                                              Last_date,
                                              job_type));
                                    },
                                  ),
                                );
                              }).toList(),
                            );
                          }
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          nextScreen(context, new_job());
        },
        tooltip: "Post a job here",
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

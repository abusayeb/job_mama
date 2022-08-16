import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_mama/Pages/homepage.dart';
import 'package:job_mama/Pages/login.dart';
import 'package:job_mama/Widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class new_job extends StatefulWidget {
  const new_job({Key? key}) : super(key: key);

  @override
  State<new_job> createState() => _new_jobState();
}

class _new_jobState extends State<new_job> {
  List<dynamic> jobs = [];

  List<dynamic> tags = [];

  String? jobId = "";
  String? tagsId = "";
  final formkey = GlobalKey<FormState>();

  String job_cat = "";
  String Com_name = "";
  String post = "";
  String requirement = "";
  String Location = "";
  String job_type = "";
  String Last_date = "";
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    this.jobs.add({"id": 1, "label": "Full-Time"});
    this.jobs.add({"id": 2, "label": "Part-Time"});
    this.jobs.add({"id": 3, "label": "Contractor"});
    this.jobs.add({"id": 4, "label": "Temporary"});
    this.jobs.add({"id": 5, "label": "Internship"});
    this.jobs.add({"id": 6, "label": "Per diem"});
    this.jobs.add({"id": 7, "label": "Volunteer"});

    this.tags.add({"ID": 1, "value": "Software development"});
    this.tags.add({"ID": 2, "value": "Customer Support"});
    this.tags.add({"ID": 3, "value": "Sales"});
    this.tags.add({"ID": 4, "value": "Marketing"});
    this.tags.add({"ID": 5, "value": "Design"});
    this.tags.add({"ID": 5, "value": "Font-End"});
    this.tags.add({"ID": 6, "value": "Back-End"});
    this.tags.add({"ID": 7, "value": "Quality Assurance"});
    this.tags.add({"ID": 8, "value": "Non Tech"});
    this.tags.add({"ID": 9, "value": "Other"});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
          title: Text("JOB BAZAR"),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              children: [
                Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Category Box

                      FormHelper.dropDownWidgetWithLabel(
                        context,
                        "Job Category",
                        "Select here",
                        this.tagsId,
                        this.tags,
                        (onChangedVal) {
                          job_cat = onChangedVal;
                          print("Selected tag: $onChangedVal");
                        },
                        (onValidateVal) {
                          if (onValidateVal == null) {
                            return 'Please Select one option';
                          }

                          return null;
                        },
                        borderColor: Colors.blueAccent.withOpacity(.5),
                        enabledBorderWidth: 3,
                        borderRadius: 10,
                        optionValue: "ID",
                        optionLabel: "value",
                      ),

                      space(10),

                      //Company name textfield

                      text("Company Name"),
                      space(2),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                            hintText: "Company Name",
                            hintStyle:
                                GoogleFonts.lato(fontStyle: FontStyle.italic)),
                        onChanged: (value) {
                          setState(() {
                            Com_name = value;
                          });
                        },
                        validator: (value) {
                          if (value!.length == 0)
                            return "Please enter company name";
                        },
                      ),

                      //Post textfield

                      text("Post Name"),
                      space(2),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                            hintText: "Assistant Software Engineer",
                            hintStyle:
                                GoogleFonts.lato(fontStyle: FontStyle.italic)),
                        onChanged: (value) {
                          setState(() {
                            post = value;
                          });
                        },
                        validator: (value) {
                          if (value!.length == 0)
                            return "Please enter the post name";
                        },
                      ),

                      //Requirements Field
                      text("Requirements"),
                      space(2),
                      TextFormField(
                        maxLength: 200,
                        maxLines: 5,
                        textAlign: TextAlign.start,
                        decoration: textInputDecoration.copyWith(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            hintText: "What is your requirement? ",
                            hintStyle:
                                GoogleFonts.lato(fontStyle: FontStyle.italic)),
                        onChanged: (value) {
                          setState(() {
                            requirement = value;
                          });
                        },
                        validator: (value) {
                          if (value!.length < 10)
                            return "Must be at least 10 letters";
                        },
                      ),

                      //Job type choose

                      FormHelper.dropDownWidgetWithLabel(
                        context,
                        "Job Types",
                        "Select Job-Time",
                        this.jobId,
                        this.jobs,
                        (onChangedVal) {
                          job_type = onChangedVal;
                          print("Selected job: $onChangedVal");
                        },
                        (onValidateVal) {
                          if (onValidateVal == null) {
                            return 'Please Select  Job hour';
                          }

                          return null;
                        },
                        borderColor: Colors.blueAccent.withOpacity(.5),
                        hintColor: Colors.red,
                        enabledBorderWidth: 3,
                        borderRadius: 10,
                        optionValue: "id",
                        optionLabel: "label",
                      ),

                      //Job Location

                      text("Location"),
                      space(2),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                            hintText: "Enter the location",
                            hintStyle:
                                GoogleFonts.lato(fontStyle: FontStyle.italic)),
                        onChanged: (value) {
                          setState(() {
                            Location = value;
                          });
                        },
                        validator: (value) {
                          if (value!.length == 0)
                            return "Please enter job location";
                        },
                      ),

                      //Last date of submission

                      text("Last Apply Date"),
                      space(2),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                            hintText: "25 June,2020",
                            hintStyle:
                                GoogleFonts.lato(fontStyle: FontStyle.italic)),
                        onChanged: (value) {
                          setState(() {
                            Last_date = value;
                          });
                        },
                        validator: (value) {
                          if (value!.length == 0)
                            return "This Field can't be null";
                        },
                      ),

                      space(10),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    child: Text(
                      "Post",
                      style: GoogleFonts.bebasNeue(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    onPressed: () {
                      Post();
                    },
                  ),
                ),
                space(50)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Post() async {
    if (formkey.currentState!.validate()) {
      print(jobs[int.parse(job_cat)]['label']);
      print(tags[int.parse(job_type)]['value']);
      final firestore = FirebaseFirestore.instance;
      firestore.collection("Jobs").add({
        "com_name": Com_name,
        "job_cat": tags[int.parse(job_cat)]['value'],
        "Job_type": jobs[int.parse(job_type)]['label'],
        "last_date": Last_date,
        "location": Location,
        "post_name": post,
        "requirement": requirement
      });
      nextScreen(context, HomePage());
    }
  }
}

// "com_name": Com_name,
//         "job_cat": jobs[int.parse(job_cat)]['label'],
//         "Job_type": jobs[int.parse(job_type)]['label'],
//         "last_date": Last_date,
//         "location": Location,
//         "post_name": post,
//         "requirement": requirement
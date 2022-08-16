import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_mama/Pages/homepage.dart';
import 'package:job_mama/Widgets/widgets.dart';

class job_show extends StatelessWidget {
  final String job_cat;
  final String Com_name;
  final String post;
  final String requirement;
  final String Location;
  final String job_type;
  final String Last_date;
  job_show(this.job_cat, this.Com_name, this.post, this.requirement,
      this.Location, this.Last_date, this.job_type);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
          title: Text('$post'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //Company Name
              Text(
                "Post name",
                style: GoogleFonts.bebasNeue(
                  fontSize: 25,
                  color: Colors.black54,
                ),
              ),
              space(2),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.post_add_rounded),
                Text("$post"),
              ]),
              space(15),

              //Post name
              Text(
                "Company name",
                style: GoogleFonts.bebasNeue(
                  fontSize: 25,
                  color: Colors.black54,
                ),
              ),
              space(2),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.settings),
                Text("$Com_name"),
              ]),

              space(15),

              //Location
              Text(
                "location",
                style: GoogleFonts.bebasNeue(
                  fontSize: 25,
                  color: Colors.black54,
                ),
              ),
              space(2),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.location_on),
                Text("$Location"),
              ]),

              space(15),

              //Job type
              Text(
                "Job Type",
                style: GoogleFonts.bebasNeue(
                  fontSize: 25,
                  color: Colors.black54,
                ),
              ),
              space(2),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.self_improvement),
                Text("$job_type"),
              ]),

              space(15),

              //Requirements
              Text(
                "Requirement",
                style: GoogleFonts.bebasNeue(
                  fontSize: 25,
                  color: Colors.black54,
                ),
              ),
              space(2),
              Text(
                "$requirement",
                style: GoogleFonts.lato(),
              ),
              space(15),

              //Last date
              Text(
                "Last Date",
                style: GoogleFonts.bebasNeue(
                  fontSize: 25,
                  color: Colors.black54,
                ),
              ),
              space(2),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.date_range_outlined),
                Text("$Last_date"),
              ]),
              space(20),
              ElevatedButton(
                  onPressed: () {
                    nextScreen(context, HomePage());
                  },
                  child: Text("Apply Now"))
            ],
          ),
        ));
  }
}

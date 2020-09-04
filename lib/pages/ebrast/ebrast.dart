import 'package:flutter/material.dart';
import 'package:microbicpro/widgets/page.dart';
import 'package:microbicpro/widgets/widgets.dart';

class Ebrast extends StatefulWidget {
  @override
  _EbrastState createState() => _EbrastState();
}

class _EbrastState extends State<Ebrast> {
  @override
  Widget build(BuildContext context) {
    return Pager( 'Ebrast', [
      SizedBox(height: 30,),
      Widgets.text('EVIDENCE BASED RAPID ANTIBIOTIC SELECTION TOOL', size: 20, align: TextAlign.center, weight: FontWeight.bold),
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffbee5eb)),
          color: Color(0xffd1ecf1),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(vertical: 30),
        child: Widgets.text('THIS DECISION SUPPORT TOOL IS BASED ON ANTIBIOTIC SUSCEPTABILITY OF PATHOGENS AND THEIR PREVALENCE', size: 16, color: Color(0xff0c5460)),
      ),
    ], search: false,);
  }
}
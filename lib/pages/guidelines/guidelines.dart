import 'package:flutter/material.dart';
import 'package:microbicpro/pages/guidelines/disease_treatment.dart';
import 'package:microbicpro/values.dart';
import 'package:microbicpro/widgets/page.dart';
import 'package:microbicpro/widgets/widgets.dart';

class Guidelines extends StatefulWidget {
  @override
  _GuidelinesState createState() => _GuidelinesState();
}

class _GuidelinesState extends State<Guidelines> {

  @override
  Widget build(BuildContext context) {

    return Pager('Guidelines', [
      InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) => DiseaseTreatment()));
        },
        child: Widgets.container('Antimicrobial Stewardship'),
      ),
      
      InkWell(
        onTap: (){
          
        },
        child: Widgets.container('Disease Treatment Guidelines'),
      ),
      
      InkWell(
        onTap: (){
          
        },
        child: Widgets.container('AWARE Antimicrobials'),
      ),
    ]);
  }
}
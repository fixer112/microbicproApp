import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microbicpro/pages/guidelines/aware.dart';
import 'package:microbicpro/pages/guidelines/disease_treatment.dart';
import 'package:microbicpro/pages/guidelines/stewardship.dart';
import 'package:microbicpro/widgets/page.dart';
import 'package:microbicpro/widgets/widgets.dart';

class Guidelines extends StatefulWidget {
  @override
  _GuidelinesState createState() => _GuidelinesState();
}

class _GuidelinesState extends State<Guidelines> {
  @override
  Widget build(BuildContext context) {
    return Pager(
      'Guidelines',
      [
        InkWell(
          onTap: () => Get.to(Stewardship()),
          child: Widgets.container('Antimicrobial Stewardship'),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => DiseaseTreatment()));
          },
          child: Widgets.container('Disease Treatment Guidelines'),
        ),
        InkWell(
          onTap: () => Get.to(Aware()),
          child: Widgets.container('AWARE Antimicrobials'),
        ),
      ],
      bottomBarIndex: 0,
    );
  }
}

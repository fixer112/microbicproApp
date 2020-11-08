import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microbicpro/pages/guidelines/elements.dart';
import 'package:microbicpro/pages/guidelines/principles.dart';
import 'package:microbicpro/widgets/page.dart';
import 'package:microbicpro/widgets/widgets.dart';

class Stewardship extends StatefulWidget {
  @override
  _StewardshipState createState() => _StewardshipState();
}

class _StewardshipState extends State<Stewardship> {
  @override
  Widget build(BuildContext context) {
    return Pager(
      'Antimicrobial Stewardship',
      [
        InkWell(
          onTap: () => Get.to(Principles()),
          child: Widgets.container('Principles of Antimicrobial Stewardship'),
        ),
        InkWell(
          onTap: () => Get.to(Elements()),
          child: Widgets.container('Elements of AMS Interventions'),
        ),
      ],
      bottomBarIndex: 0,
    );
  }
}

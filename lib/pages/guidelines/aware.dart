import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microbicpro/pages/medicines/medicines.dart';
import 'package:microbicpro/widgets/page.dart';
import 'package:microbicpro/widgets/widgets.dart';

class Aware extends StatefulWidget {
  @override
  _AwareState createState() => _AwareState();
}

class _AwareState extends State<Aware> {
  @override
  Widget build(BuildContext context) {
    return Pager(
      'Aware Antimicrobials',
      [
        InkWell(
          onTap: () => Get.to(Medicines(type: 'access')),
          child: Widgets.container('ACCESS'),
        ),
        InkWell(
          onTap: () => Get.to(Medicines(type: 'watch')),
          child: Widgets.container('WATCH'),
        ),
        InkWell(
          onTap: () => Get.to(Medicines(type: 'reserve')),
          child: Widgets.container('RESERVE'),
        ),
      ],
      bottomBarIndex: 0,
    );
  }
}

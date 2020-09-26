import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microbicpro/model/pathogen.dart';
import 'package:microbicpro/pages/pathogens/each.dart';
import 'package:microbicpro/provider/main.dart';
import 'package:microbicpro/values.dart';
import 'package:microbicpro/widgets/page.dart';
import 'package:microbicpro/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../api_functions.dart';

class Pathogens extends StatefulWidget {
  @override
  _PathogensState createState() => _PathogensState();
}

class _PathogensState extends State<Pathogens> {
  @override
  void initState() {
    super.initState();
    var main = Provider.of<MainModel>(context, listen: false);
    if (main.pathogens.isEmpty) {
      getPathogens(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(builder: (context, main, child) {
      //print(main.pathogens[0].antibiogramDatas[0]);
      return Pager(
        'Pathogens',
        main.pathogens.isEmpty
            ? [Widgets.centerText('No Pathogen Available', context)]
            : List.generate(main.pathogens.length, (index) {
                Pathogen pathogen = main.pathogens[index];
                return Card(
                  child: ListTile(
                    title: Widgets.text(pathogen.name, weight: FontWeight.w400),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  EachPathogen(pathogen.id)));
                    },
                  ),
                );
              }),
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:microbicpro/pages/guidelines/disease/single.dart';
import 'package:microbicpro/widgets/page.dart';
import 'package:microbicpro/widgets/widgets.dart';

class DiseaseTreatment extends StatefulWidget {
  @override
  _DiseaseTreatmentState createState() => _DiseaseTreatmentState();
}

class _DiseaseTreatmentState extends State<DiseaseTreatment> {
  @override
  Widget build(BuildContext context) {
    return Pager(
        'Disease Treatment Guidelines',
        [
          Widgets.header('Bone and Joints'),
          Column(
            children: [
              Card(
                child: ListTile(
                  title: Widgets.text('Infective Arthritis',
                      weight: FontWeight.w600),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  title: Widgets.text('Infective Arthritis',
                      weight: FontWeight.w600),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          Widgets.header('Ear, Nose and Throat'),
          Column(
            children: [
              Card(
                child: ListTile(
                  title: Widgets.text('Infective Arthritis',
                      weight: FontWeight.w600),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  title: Widgets.text('Otitis Media (Acute)',
                      weight: FontWeight.w600),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                SingleDisease(1)));
                  },
                ),
              ),
            ],
          ),
          Widgets.header('Central Nervous System'),
          Column(
            children: [
              Card(
                child: ListTile(
                  title: Widgets.text('Infective Arthritis',
                      weight: FontWeight.w600),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  title: Widgets.text('Infective Arthritis',
                      weight: FontWeight.w600),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
        search: false);
  }
}

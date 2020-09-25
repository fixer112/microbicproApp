import 'package:flutter/material.dart';
import 'package:microbicpro/pages/guidelines/disease/drug.dart';
import 'package:microbicpro/values.dart';
import 'package:microbicpro/widgets/page.dart';
import 'package:microbicpro/widgets/widgets.dart';

class SingleDisease extends StatefulWidget {
  final int id;
  @override
  _SingleDiseaseState createState() => _SingleDiseaseState();
  SingleDisease(this.id);
}

class _SingleDiseaseState extends State<SingleDisease> {
  @override
  Widget build(BuildContext context) {
    return Pager(
      'Otitis Media (Acute)',
      [
        Widgets.collapsible('Overview', [
          Widgets.text(
              'A disorder of the ear, tympanic membrane, common in tropics')
        ]),
        Widgets.collapsible('Clinical Features', [
          Widgets.text('Prulent discharge from ears often smelly, ear pain')
        ]),
        Widgets.collapsible('Treatment Objectives',
            [Widgets.text('- Eliminate pain\n- Eradicate infection')]),
        Card(
          child: ListTile(
            title: Widgets.text('Drug Management',
                size: 17, weight: FontWeight.w600),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 20,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => DrugManagement()));
            },
          ),
        ),
      ],
      search: false,
    );
  }
}

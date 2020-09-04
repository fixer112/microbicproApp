import 'package:flutter/material.dart';
import 'package:microbicpro/widgets/page.dart';
import 'package:microbicpro/widgets/widgets.dart';

class Medicines extends StatefulWidget {
  @override
  _MedicinesState createState() => _MedicinesState();
}

class _MedicinesState extends State<Medicines> {
  @override
  Widget build(BuildContext context) {
    return Pager(
        'Medicines',
        List.generate(10, (index) {
          return Card(
            child: ListTile(
              title:
                  Widgets.text('Caliduos Brackuilium', weight: FontWeight.w400),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            Container(color: Colors.white)));
              },
            ),
          );
        }));
  }
}

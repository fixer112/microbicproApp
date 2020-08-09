import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:microbicpro/pages/pathogens/each.dart';
import 'package:microbicpro/widgets/page.dart';
import 'package:microbicpro/widgets/widgets.dart';

class Pathogens extends StatefulWidget {
  @override
  _PathogensState createState() => _PathogensState();
}

class _PathogensState extends State<Pathogens> {
  @override
  Widget build(BuildContext context) {
    return Pager( 'Pathogens', List.generate(20, (index){
      return Card(
        child: ListTile(
          title: Widgets.text('Caliduos Brackuilium', weight: FontWeight.w400),
          trailing: Icon( FontAwesomeIcons.angleDoubleRight, size: 20, ),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) => EachPathogen()));
          },
        ),
      );
    }));
  }
}
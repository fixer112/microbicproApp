import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:microbicpro/values.dart';
import 'package:microbicpro/widgets/page.dart';
import 'package:microbicpro/widgets/widgets.dart';

class EachPathogen extends StatefulWidget {
  @override
  _EachPathogenState createState() => _EachPathogenState();
}

class _EachPathogenState extends State<EachPathogen> {
  @override
  Widget build(BuildContext context) {
    return Pager( 'Pathogen Title', [
        Header('General Information'),
        Collapsible( 'Overview', [

        ]),
        Collapsible( 'Epidermology', [

        ]),
        Collapsible( 'Diseases', [

        ]),

        Header('Anti-Microbial Spectrum'),
        Collapsible( 'Ideal Spectrum', [

        ]),
        Collapsible( 'Anti-biogram Data', [

        ]),

        Header('Infection Control'),
        Collapsible( 'Precautions', [

        ]),
      ],
    );
  }

  Widget Collapsible( String title, List<Widget> widgets ){
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: ExpandablePanel(
          header: Container(
            padding: EdgeInsets.only(top: 8),
            child: Widgets.text(title, size: 17, weight: FontWeight.w600),
          ),

          expanded: Column(
            children: widgets,
          ),
        ),
      ),
    );
  }

  Widget Header( String title ){
    return Container(
      child: Widgets.text(title, size: 20),
      padding: EdgeInsets.only(bottom: 15),
      margin: EdgeInsets.symmetric(vertical: 25),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: primaryColor)),
      ),
    );
  }
}